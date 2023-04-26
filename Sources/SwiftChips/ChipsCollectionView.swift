//
//  ChipsCollectionView.swift
//
//  Created by Andrea Ciani on 23/04/23.
//

import SwiftUI

public struct ChipsCollectionView<D: ChipData>: View {
    
    @Binding public var chips: [D]
    
    public var workingMode: WorkingMode
    
    public init(chips: Binding<[D]>, mode: WorkingMode = .multipleSelection) {
        self._chips = chips
        self.workingMode = mode
    }
    
    public var body: some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        return GeometryReader { geo in
            ZStack(alignment: .topLeading, content: {
                ForEach(0 ..< $chips.count, id: \.self) { i in
                    ChipView(data: self.$chips[i]) { selected in
                        if workingMode == .singleSelection && selected {
                            for (index,_) in self.chips.enumerated() where index != i {
                                self.chips[index].isSelected = false
                            }
                        }
                    }
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    @State private static var chips = [
        ExampleChipData(text: "something longer", isSelected: false),
        ExampleChipData(text: "Lorem impsum", isSelected: false),
        ExampleChipData(text: "veeeeery ver", isSelected: false),
        ExampleChipData(text: "Andrea Ciani", isSelected: false),
    ]
    
    static var previews: some View {
        ChipsCollectionView(chips: $chips)
    }
}
