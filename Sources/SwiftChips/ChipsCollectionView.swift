//
//  ChipsCollectionView.swift
//
//  Created by Andrea Ciani on 23/04/23.
//

import SwiftUI

public struct ChipsCollectionView<D: ChipData>: View {
    
    @Binding public var chips: [D]
    
    public var workingMode: WorkingMode
    public var accentColor: Color = .accentColor
    
    public init(chips: Binding<[D]>, mode: WorkingMode = .multipleSelection, accentColor: Color = .accentColor) {
        self._chips = chips
        self.workingMode = mode
        self.accentColor = accentColor
    }
    
    public var body: some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        return GeometryReader { geo in
            ZStack(alignment: .topLeading, content: {
                ForEach(0 ..< $chips.count, id: \.self) { i in
                    buildChipView(at: i)
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
        }.environment(\.accentColor, accentColor)
    }
    
    // Used for single selection an multiple selection
    @ViewBuilder
    private func buildChipView(at i: Int) -> some View {
        switch workingMode {
        case .singleSelection, .multipleSelection:
            ChipView(data: self.$chips[i]) { data in
                if workingMode == .singleSelection && data.isSelected {
                    for (index, item) in self.chips.enumerated() where index != i && item.isSelected {
                        // where isSelected reduce the callbacks to the binding object state to
                        // only the object that need to be changed
                        self.chips[index].isSelected = false
                    }
                }
            }
        case .deletable:
            DeletableChipView(data: self.$chips[i]) { data in
                withAnimation {
                    self.$chips.wrappedValue = self.$chips.wrappedValue.filter { $0.id != data.id }
                }
            }
        }
        
    }
    
    // Used only for deletable mode
    @ViewBuilder
    private func builddDeletableChipView(at i: Int) -> some View {
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    
    @State private static var chips = [
        ExampleChipData(text: "Lorem", isSelected: false),
        ExampleChipData(text: "Lorem impsum", isSelected: false),
        ExampleChipData(text: "dolor sit amet", isSelected: false),
        ExampleChipData(text: "consectetur", isSelected: false),
        ExampleChipData(text: "adipiscing", isSelected: false),
        ExampleChipData(text: "elit", isSelected: false),
        ExampleChipData(text: "sed", isSelected: false),
    ]
    
    static var previews: some View {
        ChipsCollectionView(chips: $chips)
    }
}
