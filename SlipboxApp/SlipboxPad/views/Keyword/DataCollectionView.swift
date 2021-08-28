//
//  DataCollectionView.swift
//  assocy
//
//  Created by Karin Prater on 20.10.19.
//  Copyright © 2019 Karin Prater. All rights reserved.
//

import SwiftUI

struct DataCollectionView<Data, Content>: View
where Data: RandomAccessCollection, Data.Element: UUIDIdentifiable, Content : View {
    
    var data : [Data.Element]
    
    @State var dataPosition: [[String]]
    
    private let content: (Data.Element) -> Content
    var spacing: CGFloat = 0
    @State var frameHeight: CGFloat = 300  //size of data view frame needs to be computed
    
    public init(_ data: Data,
                spacing: CGFloat = 0,
                content: @escaping (Data.Element) -> Content) {
        
        self.data = data.map({ $0 })
        self.content = content
        self.spacing = spacing
        
        self._dataPosition = State(initialValue: [data.map({ $0.uuid.uuidString })])
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            ScrollView(.horizontal){
                //scrollview to get max width
                
                VStack(alignment: .leading, spacing: self.spacing) {
                    ForEach(self.dataPosition, id: \.self) { row  in
                        
                        HStack(spacing: self.spacing){
                            ForEach(row, id: \.self) { item in
                                
                                if getData(for: item) != nil {
                                    self.content(getData(for: item)!)
                                        
                                        .anchorPreference(key: MyAnchorPreferenceKey.self, value: .bounds) { bounds in
                                            [MyAnchorPreferenceData(viewIdx: item, bounds: bounds)]
                                        }
                                }
                                
                                
                            }
                        }
                        
                    }//end of foreach
                }//end of VStack
                    
                .frame(height: self.frameHeight, alignment: .topLeading)
      
             
                
            }//end of scrollview
                .backgroundPreferenceValue(MyAnchorPreferenceKey.self){ (preferences)  in
                    GeometryReader {geometry in
                        self.makeViewPosition(geometry, preferences)
                    }
            }
            .onReceive(self.data.publisher) { (value) in
                
                DispatchQueue.main.async {
                    let flatArray = self.dataPosition.flatMap { $0 }
                    //only add when data not already contains
                    if !flatArray.contains(value.uuid.uuidString){
                        self.dataPosition.append([value.uuid.uuidString])
                    }
                }
            }
            
        }
    }
    
    func getData(for uuid: String) -> Data.Element? {
        if let uuid = UUID(uuidString: uuid),
           let d = data.first(where: { $0.uuid == uuid }) {
            return d
        }else {
            return nil
        }
    }
    
    //MARK: - helper funcs
    
    func makeViewPosition(_ geometry: GeometryProxy, _ preferences: [MyAnchorPreferenceData]) -> some View {

        var flatArray = dataPosition.flatMap { $0 } // easier to reference as 1D

//        when value is added later, need to add to flatarray here
        if self.data.count == flatArray.count + 1 {
            if let id = self.data.last?.uuid.uuidString {
                if !flatArray.contains(id) {
                    flatArray.append(id)
                }
            }
        }

         //only update when data is available
        if flatArray.count != 0 {
            var height: CGFloat = 0 //size of scrollview content
            let widthOfWindow = geometry.size.width //the space we have avaliable
            var widthOfViews: CGFloat = 0  //helper store
            var newArray = [[String]]()

           // print("window \(widthOfWindow)")
            var new = [String]()

            for p in preferences {
                let bounds = geometry[p.bounds]  //gives size of each cell
                widthOfViews += bounds.size.width   //we add the cell widths together
                widthOfViews += spacing  //take into account spacing between cells
//                print(widthOfViews)

                if widthOfViews > widthOfWindow  {
                   // print("new line \(widthOfViews) bigger \(widthOfWindow)")
                    newArray.append(new)
                    new = [p.viewIdx]

                    widthOfViews = bounds.size.width
                    height += bounds.size.height
                }else {
                    new.append(p.viewIdx)
                    //  print("same line postion \(p.viewIdx)")
                }
            }
            newArray.append(new)

            DispatchQueue.main.async {
                // we are calling this func in backgroundPreferenceValue
                //during with the views will be rendered, so we need to force a waitng
                //not a preety solution
                if self.dataPosition != newArray {
//                    print(newArray)
                    //change when rotated included
                    //print("old layout with: \(self.dataPosition)")
                    self.dataPosition = newArray
                    //print("update layout with: \(self.dataPosition)")
                    if let last = preferences.last {
                        self.frameHeight = height + geometry[last.bounds].size.height
                        //print("heigth \(self.frameHeight)")
                    }
                }
            }
        }

        return Rectangle()
            .frame(width: 0, height: 0)
            .background(Color.clear)
    }
}

//struct DataCollectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        let data = ["hello","world", "topic"]
//         var idData = data.map { StringData(text: $0)}
//        return DataCollectionView(idData) { StringCollectionCell(text: $0, selectedItem: .constant("1"))
//        }
//    }
//}



