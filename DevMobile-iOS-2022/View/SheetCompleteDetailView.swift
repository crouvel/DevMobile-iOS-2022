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
    @State var confirmationShown: Bool = false
    @State private var modify: Bool = false
    @State private var showingIncorrect = false
    private var oldcouvert : Int
    @ObservedObject var dataSheetComplete: SheetCompleteListViewModel = SheetCompleteListViewModel()
    @ObservedObject var dataSheetIncomplete: SheetIncompleteListViewModel = SheetIncompleteListViewModel()
    
    private var _listvm: StepProgressionListViewModel!
    var listvm: StepProgressionListViewModel {
        return _listvm
    }
    private var _listvm2: IngredientsProgressionListViewModel!
    var listvm2: IngredientsProgressionListViewModel {
        return _listvm2
    }
    private var _listSheetComplete: [String]!
    var listSheetComplete: [String] {
        return dataSheetComplete.vms.map{$0.nomRecette}
    }
    private var _listSheetIncomplete: [String]!
    var listSheetIncomplete: [String] {
        return dataSheetIncomplete.vms.map{$0.nomRecette}
    }
    
    init(vm: SheetCompleteViewModel){
        self.viewModel = vm
        self.intent = SheetCompleteIntent(vm: vm)
        self.oldcouvert = vm.Nbre_couverts
        self._listvm = StepProgressionListViewModel(referenceProgression: self.viewModel.nomProgression)
        self._listvm2 = IngredientsProgressionListViewModel(idFiche: self.viewModel.idFiche)
    }
    private var _times: [Int]!
    var times: [Int] {
        return listvm.vms.map{$0.id2 != nil ? $0.temps2 as! Int : $0.temps1}
    }
    
    private var _totaltime: Int!
    var totaltime: Int {
        return times.reduce( 0, { x, y in
            x + y
        } )
    }
    
    private var deletionSheetState : DeleteSheetIntentState {
        return self.viewModel.deletionState
    }
    
    var body: some View {
        ScrollView {
            switch deletionSheetState {
            case .ready:
                VStack {
                    //MARK: ENTETE
                    if !modify {
                        VStack{
                            //Text("\(oldcouvert)")
                            HStack {
                                /*Button(action: {
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
                                 }*/
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
                                Button(action: {
                                    modify = true
                                }){
                                    Text("Modifier entête")
                                        .fontWeight(.bold)
                                        .foregroundColor(.blue)
                                        .frame(alignment: .center)
                                        .padding()
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Color.blue, lineWidth: 5)
                                        )
                                }
                            }
                            
                            NavigationLink(destination: EtiquetteVenteView(viewModel: self.viewModel)){
                                Text("Etiquette Vente")
                                    .fontWeight(.bold)
                                    .foregroundColor(.green)
                                    .padding()
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.green, lineWidth: 5)
                                    )
                                EmptyView()
                            }
                            Button(action: {
                                //SheetDAO.deleteSheet(idFiche: self.viewModel.sheet.idFiche, vm: self.viewModel)
                                confirmationShown = true
                            }){
                                Text("Supprimer la fiche")
                                    .fontWeight(.bold)
                                    .foregroundColor(.red)
                                    .frame(alignment: .center)
                            }.padding()
                        }
                    }
                    //MARK: MODIFICATION BLOCK
                    else {
                        Section {
                            VStack {
                                HStack{
                                    Text("Nom de la recette :")
                                        .fontWeight(.bold)
                                        .padding()
                                    TextField("", text: $viewModel.nomRecette)
                                        .onSubmit {
                                        }
                                    Button(action :{
                                        if listSheetIncomplete.contains(where: { $0.lowercased() == viewModel.nomRecette.lowercased()}) || listSheetComplete.contains(where: { $0.lowercased() == viewModel.nomRecette.lowercased()})
                                        {
                                            print("alert : libelle name cannot be used")
                                            showingIncorrect = true
                                        }else {
                                            SheetDAO.updateRecette(nom: viewModel.nomRecette, idFiche: viewModel.idFiche)
                                            intent.intentToChange(nomRecette: viewModel.nomRecette)
                                            modify = false
                                        }
                                    }){
                                        Text("Modifier")
                                            .foregroundColor(.blue)
                                            .fontWeight(.bold)
                                    }.padding()
                                }
                                Divider()
                                /*HStack{
                                    Text("Catégorie de recette : ")
                                        .fontWeight(.bold)
                                        .padding()
                                    Picker("Catégorie de recette", selection: $viewModel.categorieRecette) {
                                        Text("Entrée").tag("Entrée")
                                        Text("Plat").tag("Plat")
                                        Text("Dessert").tag("Dessert")
                                        Text("Autre").tag("Autre")
                                    }.padding()
                                        .onSubmit {
                                            //intent.intentToChange(categorie: viewModel.nomCategorie)
                                        }
                                    Button(action :{
                                        intent.intentToChange(categorie: viewModel.categorieRecette)
                                        modify = false
                                    }){
                                        Text("Modifier")
                                            .foregroundColor(.blue)
                                            .fontWeight(.bold)
                                        
                                    }.padding()
                                }*/
                                Divider()
                                /*HStack{
                                    Text("Nombre de couverts :")
                                        .fontWeight(.bold)
                                        .padding()
                                    TextField("", value: $viewModel.Nbre_couverts, formatter: NumberFormatter())
                                        .padding()
                                    if viewModel.Nbre_couverts != nil {
                                        Button(action :{
                                            SheetDAO.updateCouvert(couvert: viewModel.Nbre_couverts, idFiche: viewModel.idFiche, oldcouvert: oldcouvert, nomProgression: viewModel.nomProgression)
                                            //_listvm2.fetchData(idFiche: viewModel.idFiche)
                                            intent.intentToChange(couvert: viewModel.Nbre_couverts)
                                            
                                            modify = false
                                        }){
                                            Text("Modifier")
                                                .foregroundColor(.blue)
                                                .fontWeight(.bold)
                                        }.padding()
                                    }
                                }*/
                                Divider()
                                HStack{
                                    Text("Nom de l'auteur :")
                                        .fontWeight(.bold)
                                        .padding()
                                    TextField("", text: $viewModel.nomAuteur)
                                        .padding()
                                        .onSubmit {
                                        }
                                    Button(action :{
                                        intent.intentToChange(auteur: viewModel.nomAuteur)
                                        modify = false
                                    }){
                                        Text("Modifier")
                                            .foregroundColor(.blue)
                                            .fontWeight(.bold)
                                    }.padding()
                                }
                                Divider()
                            }.alert("Nom de recette est déjà employé ou identique, veuillez changer de nom.", isPresented: $showingIncorrect) {
                                Button("OK", role: .cancel) { }
                            }
                        }
                        Button(action: {
                            modify = false
                        }){
                            Text("Terminer")
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.blue, lineWidth: 5)
                                )
                        }
                    }
                    //MARK: END MODIF BLOCK
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
                        Divider()
                        HStack{
                            Text("Nombre de couverts : ")
                                .fontWeight(.bold)
                                .font(.system(size: 17))
                            
                            Text("\(viewModel.Nbre_couverts)")
                        }
                    }
                    Divider()
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
                    //MARK: ETAPES FICHE
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
                            HStack{
                                Text("Temps total : \(totaltime) minutes")
                                    .fontWeight(.bold)
                            }
                        }
                    }
                    Divider()
                    //MARK: SYNTHESE RECAP
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
                    case .COUVERT(let reason):
                        self.errorMessage = reason
                        self.showErrorMessage = true
                    case .NOM(let reason):
                        self.errorMessage = reason
                        self.showErrorMessage = true
                    case .AUTEUR(let reason):
                        self.errorMessage = reason
                        self.showErrorMessage = true
                    case .CATEGORY(let reason):
                        self.errorMessage = reason
                        self.showErrorMessage = true
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
