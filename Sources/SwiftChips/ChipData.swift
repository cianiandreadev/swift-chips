//
//  ChipData.swift
//  
//
//  Created by Andrea Ciani on 23/04/23.
//

import Foundation

public protocol ChipData: Identifiable {
    var id: String { get }
    var text: String { get set }
    var isSelected: Bool { get set }
}
