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
        ScrollView {
        VStack{
            HStack{
            Spacer()
                Text("Intitulé")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .font(.system(size: 20))
                Spacer()
            }.background(Color.cyan)
                .frame( alignment: .center)
            HStack{
                Text("\(viewModel.nomRecette)")
                    .fontWeight(.semibold)
                    .font(.system(size: 19))
                //Text("\(listvm.vms.count)")
            }
            HStack{
                Text("Nombre de couverts : ")
                .fontWeight(.bold)
                .font(.system(size: 17))
                      
                Text("\(viewModel.Nbre_couverts)")                //Text("\(listvm.vms.count)")
            }
            /*HStack{
                Text("Nombre de couverts : ")
                    .fontWeight(.bold)
                    .frame(maxHeight: .infinity)
                Text("\(viewModel.Nbre_couverts)")
                    .frame(maxHeight: .infinity)              }.fixedSize(horizontal: false, vertical: true)*/
        }
        VStack{
            HStack{
            Spacer()
                Text("Réalisation")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .font(.system(size: 20))
                Spacer()
            }.background(Color.cyan)
                .frame( alignment: .center)
            HStack{
                Text("\(viewModel.nomProgression)")
                .fontWeight(.semibold)
                .font(.system(size: 18))
            }
            HStack{
            Spacer()
                Text("Responsable : \(viewModel.nomAuteur)")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .font(.system(size: 17))
                Spacer()
            }.background(Color.cyan)
                .frame( alignment: .center)
            /*HStack{
                Text("\(viewModel.nomAuteur)")                //Text("\(listvm.vms.count)")
            }*/
        }
            HStack {
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
                            .fixedSize(horizontal: false, vertical: true)
                    }// }
                    //}
            }
        }
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
