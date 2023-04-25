//
//  ChipView.swift
//
//  Created by Andrea Ciani on 23/04/23.
//

import SwiftUI

public protocol ChipData: Identifiable {
    var id: String { get }
    var text: String { get set }
    var isSelected: Bool { get set }
}

public struct ChipView<D: ChipData>: View {
    @Binding public var data: D
    
    public init(data: Binding<D>) {
        self._data = data
    }
    
    public var body: some View {
        Text(data.text)
            .font(.system(size: 14))
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .foregroundColor(data.isSelected ? .white : .black)
            .background(data.isSelected ? Color.blue : Color.gray.opacity(0.3))
            .cornerRadius(20)
            .animation(.spring(), value: data.isSelected)
            .onTapGesture {
                data.isSelected.toggle()
            }
    }
}


struct ChipView_Previews: PreviewProvider {
    
    @State private static var selectedChipState = ExampleChipData(
        text: "Selected Chip",
        isSelected: true)
    
    @State private static var unselectedChipState = ExampleChipData(
        text: "Selected Chip",
        isSelected: false)
    
    static var previews: some View {
        ChipView(data: $selectedChipState)
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Selected")
        
        ChipView(data: $unselectedChipState)
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Unselected")
    }
}
