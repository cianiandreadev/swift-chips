//
//  ChipDataModel.swift
//  
//
//  Created by Andrea Ciani on 23/04/23.
//

import Foundation
import SwiftUI

struct ChipsDataModel: Identifiable {
    let id = UUID()
    @State var isSelected: Bool
    let systemImage: String
    let titleKey: LocalizedStringKey
}
