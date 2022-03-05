//
//  SheetCompleteDetailView.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 22/02/2022.
//

import SwiftUI

struct SheetCompleteDetailView: View {
    //var intent: SheetCompleteIntent
    @ObservedObject var viewModel: SheetCompleteViewModel
    @State var errorMessage: String = ""
    @State var showErrorMessage: Bool = false
    @State var confirmationShown: Bool = false
    
    private var _listvm: StepProgressionListViewModel!
    var listvm: StepProgressionListViewModel {
        return _listvm
    }
    private var _listvm2: IngredientsProgressionListViewModel!
    var listvm2: IngredientsProgressionListViewModel {
        return _listvm2
    }
    init(vm: SheetCompleteViewModel){
        self.viewModel = vm
        self._listvm = StepProgressionListViewModel(referenceProgression: self.viewModel.nomProgression ?? "")
        self._listvm2 = IngredientsProgressionListViewModel(idFiche: self.viewModel.idFiche)
    }
    
    private var deletionSheetState : DeleteSheetIntentState {
        return self.viewModel.deletionState
    }
    
    var body: some View {
        ScrollView {
            switch deletionSheetState {
            case .ready:
                VStack {
                    VStack{
                        HStack {
                            Button(action: {
                                let outputFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("SwiftUI.pdf")
                                let pageSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                                let rootVC = UIApplication.shared.windows.first?.rootViewController
                                
                                //Render the PDF
                                let pdfRenderer = UIGraphicsPDFRenderer(bounds: CGRect(origin: .zero, size: pageSize))
                                DispatchQueue.main.async {
                                    do {
                                        try pdfRenderer.writePDF(to: outputFileURL, withActions: { (context) in
                                            context.beginPage()
                                            rootVC?.view.layer.render(in: context.cgContext)
                                        })
                                        print("wrote file to: \(outputFileURL.path)")
                                    } catch {
                                        print("Could not create PDF file: \(error.localizedDescription)")
                                    }
                                }
                            }){
                                Text("Export   ")
                                //.fontWeight(.semibold)
                                    .foregroundColor(.blue)
                            }
                            NavigationLink(destination: CalculCoutsView(vm: self.viewModel)){
                                Text("Calcul des coûts")
                                    .fontWeight(.bold)
                                    .foregroundColor(.blue)
                                    .padding()
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.blue, lineWidth: 5)
                                    )
                                EmptyView()
                            }
                        }
                        Button(action: {
                            //SheetDAO.deleteSheet(idFiche: self.viewModel.sheet.idFiche, vm: self.viewModel)
                            confirmationShown = true
                        }){
                            Text("Supprimer la fiche")
                                .fontWeight(.bold)
                                .foregroundColor(.red)
                                .italic()
                                .frame(alignment: .center)
                        }.padding()
                    }
                    VStack{
                        HStack{
                            Spacer()
                            Text("Intitulé : \(viewModel.nomRecette)")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                            Spacer()
                        }.background(Color.cyan)
                            .frame( alignment: .center)
                        //Divider()
                        HStack{
                            Text("Nombre de couverts : ")
                                .fontWeight(.bold)
                                .font(.system(size: 17))
                            
                            Text("\(viewModel.Nbre_couverts)")
                        }
                    }
                    //Divider()
                    VStack{
                        HStack{
                            Spacer()
                            HStack{
                                Text("Ingrédients")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .font(.system(size: 20))
                            }
                            Spacer()
                        }.background(Color.cyan)
                            .frame( alignment: .center)
                        Divider()
                        VStack{
                            ForEach( _listvm2.vms,id: \.ingredient.nomListeIngredients) {
                                vm in
                                HStack{
                                    VStack{
                                        Text("\(vm.nomListeIngredients)")
                                            .fontWeight(.bold)
                                            .underline()
                                        ForEach(vm.ingredients.split(separator: ","), id: \.self){ ingredient in
                                            Text(ingredient)
                                        }
                                    }
                                    VStack{
                                        ForEach(vm.unites.split(separator: ","), id: \.self){ unite in
                                            Text(unite)
                                        }
                                    }
                                    VStack{
                                        ForEach(vm.quantites.split(separator: ","), id: \.self){ quantite in
                                            Text(quantite)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    Divider()
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
                        Divider()
                        HStack{
                            Text("\(viewModel.nomProgression ?? "")")
                                .fontWeight(.semibold)
                                .font(.system(size: 18))
                        }
                        Divider()
                        HStack{
                            Spacer()
                            Text("Responsable : \(viewModel.nomAuteur)")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .font(.system(size: 17))
                            Spacer()
                        }.background(Color.cyan)
                            .frame( alignment: .center)
                        Divider()
                    }
                    HStack {
                        VStack{
                            ForEach( _listvm.vms, id: \.step.id ) {
                                vm in
                                if vm.step.titre2 == nil {
                                    HStack{
                                        Text("\(vm.step.ordre1)")
                                            .fontWeight(.bold)
                                            .padding()
                                        VStack{
                                            Text("\(vm.step.titre1)")
                                                .fontWeight(.bold)
                                                .underline()
                                            Text(vm.step.description1 ?? "")
                                                .italic()
                                                .fixedSize(horizontal: false, vertical: true)
                                        }
                                        Text("\(vm.step.temps1) min")
                                            .fontWeight(.bold)
                                            .padding()
                                    }
                                }else {
                                    HStack {
                                        VStack {
                                            Text("\(vm.step.ordre1)")
                                                .fontWeight(.bold)
                                        }.padding()
                                        VStack{
                                            /*Text("\(vm.step.titre1)")
                                             .fontWeight(.bold)
                                             .font(.system(size: 19))*/
                                            Text("(\(vm.step.titre1))")
                                                .italic()
                                            Text(vm.step.titre2 ?? "")
                                                .fontWeight(.bold)
                                                .underline()
                                            Text(vm.step.description2 ?? "")
                                                .italic()
                                                .fixedSize(horizontal: false, vertical: true)
                                        }
                                        Text("\(vm.step.temps2 ?? 0) min")
                                            .fontWeight(.bold)
                                    }
                                }
                            }
                        }
                    }
                    Divider()
                    VStack {
                        HStack{
                            Spacer()
                            Text("Synthèse")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                            Spacer()
                        }.background(Color.cyan)
                            .frame( alignment: .center)
                        Divider()
                        VStack{
                            Text("Ingrédients necessaires")
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                            ForEach( _listvm2.vms,id: \.ingredient.nomListeIngredients) {
                                vm in
                                HStack{
                                    VStack{
                                        ForEach(vm.ingredients.split(separator: ","), id: \.self){ ingredient in
                                            HStack{
                                                Text("- ")
                                                Text(ingredient)
                                            }
                                        }
                                    }
                                }
                            }
                        }.frame(alignment: .topLeading)
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
                }
                .confirmationDialog("Voulez-vous supprimer la fiche", isPresented: $confirmationShown) {
                    Button("Supprimer", role: .destructive) {
                        withAnimation {
                            SheetDAO.deleteSheet(idFiche: viewModel.idFiche, vm: viewModel)
                        }
                    }.keyboardShortcut(.defaultAction)
                    
                    Button("Annuler", role: .cancel) {}
                }
                .alert("\(errorMessage)", isPresented: $showErrorMessage){
                    Button("Ok", role: .cancel){
                        showErrorMessage = false
                    }
                }
                
            case .deleting(let string):
                Text("Suppression de la fiche")
                    .foregroundColor(.black)
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .black))
                    .scaleEffect(2)
            case .deleted:
                Divider()
                Text("La fiche technique a bien été supprimée !")
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .italic()
                    .padding()
                Divider()
                Text("Vous pouvez désormais retourner à la liste principale des fiches complètes, et RAFRAICHIR⚠️ la liste.")
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .italic()
                    .padding()
            case .deletingError(let string):
                Text("Erreur à la suppression de la fiche, veuillez réessayer ulérieurement")
                    .fontWeight(.bold)
                    .italic()
                Divider()
                Button(action: {
                    SheetCompleteIntent(vm: self.viewModel).deleted()
                }){
                    Text("Ok")
                        .fontWeight(.bold)
                        .frame(alignment: .center)
                }
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
