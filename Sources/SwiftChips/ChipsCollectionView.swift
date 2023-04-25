//
//  ChipsCollectionView.swift
//
//  Created by Andrea Ciani on 23/04/23.
//

import SwiftUI

public struct ChipsCollectionView: View {
    
    @Binding public var chips: [ChipData]
    
    public init(chips: Binding<[ChipData]>) {
        self._chips = chips
    }
    
    public var body: some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        return GeometryReader { geo in
            ZStack(alignment: .topLeading, content: {
                ForEach(0 ..< chips.count) { i in
                    ChipView(data: self.$chips[i])
                        .padding(.all, 5)
                        .alignmentGuide(.leading) { dimension in
                            if (abs(width - dimension.width) > geo.size.width) {
                                width = 0
                                height -= dimension.height
                            }
                            
                            let result = width
                            if self.$chips[i].id == self.$chips.last!.id {
                                width = 0
                            } else {
                                width -= dimension.width
                            }
                            return result
                        }
                        .alignmentGuide(.top) { dimension in
                            let result = height
                            if self.$chips[i].id == self.$chips.last!.id {
                                height = 0
                            }
                            return result
                        }
                }
            })
        }.padding(.all, 10)
    }
}

struct ContentView_Previews: PreviewProvider {
    
    @State private static var chips = [
        ChipData(text: "something longer", isSelected: false),
        ChipData(text: "Lorem impsum", isSelected: false),
        ChipData(text: "veeeeery ver", isSelected: false),
        ChipData(text: "Andrea Ciani", isSelected: false),
    ]
    
    static var previews: some View {
        ChipsCollectionView(chips: $chips)
    }
}
