//
//  ChipView.swift
//
//  Created by Andrea Ciani on 23/04/23.
//

import SwiftUI

struct ChipView<D: ChipData>: View {
    @Binding var data: D
    
    var onTap: (Bool) -> ()
    
    var body: some View {
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
                onTap(data.isSelected)
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
        ChipView(data: $selectedChipState, onTap: { _ in })
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Selected")
        
        ChipView(data: $unselectedChipState, onTap: { _ in })
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Unselected")
    }
}
