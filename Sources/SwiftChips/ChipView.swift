//
//  ChipView.swift
//
//  Created by Andrea Ciani on 23/04/23.
//

import SwiftUI

struct ChipData: Identifiable {
    let id: String = UUID().uuidString
    var text: String
    var isSelected: Bool
}

struct ChipView: View {
    @Binding var data: ChipData
    
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
            }
    }
}


struct ChipView_Previews: PreviewProvider {
    
    @State private static var selectedChipState = ChipData(
        text: "Selected Chip",
        isSelected: true)
    
    @State private static var unselectedChipState = ChipData(
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
