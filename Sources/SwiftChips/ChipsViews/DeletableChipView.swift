//
//  SwiftUIView.swift
//  
//
//  Created by Andrea Ciani on 26.04.23.
//

import SwiftUI

struct DeletableChipView<D: ChipData>: View {
    
    @Binding var data: D
    
    var onTap: (D) -> ()
    
    @Environment(\.accentColor) var userAccentColor
    
    var body: some View {
        HStack {
            Button {
                onTap(data)
            } label: {
                Image(systemName: "x.circle.fill")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
            }
            Text(data.text)
        }
        .font(.system(size: 14))
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .foregroundColor(data.isSelected ? .white : .black)
        .background(userAccentColor)
        .cornerRadius(20)
        .animation(.spring(), value: data.isSelected)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    
    @State private static var chipState = ExampleChipData(
        text: "Example Chip",
        isSelected: true)
    
    static var previews: some View {
        DeletableChipView(data: $chipState, onTap: {_ in })
    }
}
