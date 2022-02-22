//
//  SheetCompleteDetailView.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 22/02/2022.
//

import SwiftUI

struct SheetCompleteDetailView: View {
    var intent: SheetCompleteIntent
    @ObservedObject var viewModel: SheetCompleteViewModel
    @State var errorMessage: String = ""
    @State var showErrorMessage: Bool = false
    //@ObservedObject var listvm : StepProgressionListViewModel
    
    private var _listvm: StepProgressionListViewModel!
        var listvm: StepProgressionListViewModel {
            return _listvm
        }
    init(vm: SheetCompleteViewModel){
        self.intent = SheetCompleteIntent()
        self.viewModel = vm
        //self.intent.addObserver(vm: self.viewModel)
        self._listvm = StepProgressionListViewModel(referenceProgression: self.viewModel.nomProgression)
    }
    //private var dataSteps: StepProgressionListViewModel { return StepProgressionListViewModel(referenceProgression: self.viewModel.nomProgression)}
    
    var body: some View {
        VStack{
            HStack{
                Text("Intitulé")
                    .fontWeight(.bold)
                    .frame(maxHeight: .infinity)
                Text("\(viewModel.nomRecette)")
                    .frame(maxHeight: .infinity)
                Text("\(listvm.vms.count)")
            }.fixedSize(horizontal: false, vertical: true)
            HStack{
                Text("Nombre de couverts : ")
                    .fontWeight(.bold)
                    .frame(maxHeight: .infinity)
                Text("\(viewModel.Nbre_couverts)")
                    .frame(maxHeight: .infinity)              }.fixedSize(horizontal: false, vertical: true)
        }
        VStack{
            HStack{
            Text("Responsable :")
                .fontWeight(.bold)
            Text("\(viewModel.nomAuteur)")
                    .padding()
            }
        }
        VStack{
                ForEach( _listvm.vms,id: \.step.id1) {
                    vm in
                    //NavigationLink(destination: SheetCompleteDetailView(vm: vm)){
                    if vm.step.titre2 == nil {
                            Text("\(vm.step.titre1)")
                                .fontWeight(.bold)
                                .underline()
                        Text(vm.step.description1 ?? "")
                            .italic()
                        
                    }// }
                    //}
            }
        }
        .navigationTitle("\(viewModel.nomRecette)")
        .onChange(of: viewModel.error){ error in
            switch error {
                case .NONE:
                    return
                /*case .ARTISTNAME(let reason):
                    self.errorMessage = reason
                    self.showErrorMessage = true
                case .TRACKNAME(let reason):
                    self.errorMessage = reason
                    self.showErrorMessage = true
                case .COLLECTIONNAME(let reason):
                    self.errorMessage = reason
                    self.showErrorMessage = true*/
            }
        }.alert("\(errorMessage)", isPresented: $showErrorMessage){
            Button("Ok", role: .cancel){
                showErrorMessage = false
            }
        }
    }
}

struct SheetCompleteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SheetCompleteDetailView(
            vm: SheetCompleteViewModel(sheet:SheetComplete(nomRecette:"oui", idFiche: 555555, nomAuteur: "test", Nbre_couverts: 8, categorieRecette: "categorie", nomProgression: "ok")))
    }
}
