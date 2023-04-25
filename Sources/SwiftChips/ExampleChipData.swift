//
//  File.swift
//  
//
//  Created by Andrea Ciani on 23/04/23.
//

import Foundation

struct ExampleChipData: ChipData {
    var id: String = UUID().uuidString
    var text: String
    var isSelected: Bool
}

