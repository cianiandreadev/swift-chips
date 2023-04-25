//
//  File.swift
//  
//
//  Created by Ciani, Andrea-MIGROSONLINE on 25.04.23.
//

import Foundation

struct ExampleChipData: ChipData {
    var id: String = UUID().uuidString
    var text: String
    var isSelected: Bool
}

