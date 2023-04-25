//
//  ChipsCollectionView.swift
//
//  Created by Andrea Ciani on 23/04/23.
//

import SwiftUI



class ChipsViewModel: ObservableObject {
    @Published var dataObject: [ChipsDataModel] = [ChipsDataModel.init(isSelected: false, systemImage: "pencil.circle", titleKey: "Pencil Circle")]
    
    func addChip() {
        dataObject.append(ChipsDataModel.init(isSelected: false, systemImage: "pencil.circle", titleKey: "Pencil"))
    }
    
    func removeLast() {
        guard dataObject.count != 0 else {
            return
        }
        dataObject.removeLast()
    }
}

struct ChipsCollectionView: View {
    
    @StateObject var viewModel = ChipsViewModel()
    
    var elements: [ChipsDataModel] = []
    
    var body: some View {
        VStack {
            ScrollView {
                ChipsContent(viewModel: viewModel)
            }
            Spacer()
            HStack {
                Spacer()
                Button("Remove Chips") {
                    withAnimation {
                        viewModel.removeLast()
                    }
                }.padding(.all, 40).accentColor(.red)
                Spacer()
                Button("Add Chips") {
                    withAnimation {
                        viewModel.addChip()
                    }
                }.padding(.all, 40)
                Spacer()
            }


        }
    }
}

struct ChipsContent: View {
    @ObservedObject var viewModel = ChipsViewModel()
    
    @State private var chipData = ChipData(text: "Bla", isSelected: false)
    
    var body: some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        return GeometryReader { geo in
                ZStack(alignment: .topLeading, content: {
                ForEach(viewModel.dataObject) { chipsData in
                    ChipView(data: $chipData)
                        .padding(.all, 5)
                        .alignmentGuide(.leading) { dimension in
                            if (abs(width - dimension.width) > geo.size.width) {
                                width = 0
                                height -= dimension.height
                            }
                            
                            let result = width
                            if chipsData.id == viewModel.dataObject.last!.id {
                                width = 0
                            } else {
                                width -= dimension.width
                            }
                            return result
                          }
                        .alignmentGuide(.top) { dimension in
                            let result = height
                            if chipsData.id == viewModel.dataObject.last!.id {
                                height = 0
                            }
                            return result
                        }
                }
            })
        }.padding(.all, 10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChipsCollectionView()
    }
}
