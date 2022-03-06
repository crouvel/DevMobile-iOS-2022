//
//  CreateIngredientView.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 22/02/2022.
//

import SwiftUI

//
//  CreateSheetView.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 22/02/2022.
//

import SwiftUI

struct CreateIngredientView: View {
    
    @State var code: Int = 00
    @State var libelle: String = ""
    @State var quantiteStockee: Float = 0.0
    @State var prixUnitaire: Float = 0.0
    @State var allergene: String = ""
    @State var idCategorieIngredient : Int = 1
    @State var categorieAllergene: String = ""
    @State var unite : String = ""
    @ObservedObject var viewModelIngredient: IngredientViewModel = IngredientViewModel(ingredient:Ingredient(libelle: "oui", idIngredient: 8888888, nomCategorie: "test", quantite: 5, prix: 2, allergene: "Oui", idCategorie: 55, idCatAllergene: "categorie" , unite: "Kg"  ))
    @ObservedObject var dataIngredient: IngredientListViewModel = IngredientListViewModel()
    private var creationState : CreateIngredientIntentState {
        return viewModelIngredient.creationIngredientState
    }
    
    private var _listIngredientLibelle: [String]!
    var listIngredientLibelle: [String] {
        return dataIngredient.datavm.map{$0.libelle}
    }
    private var _listIngredientCode: [Int]!
    var listIngredientCode: [Int] {
        return dataIngredient.datavm.map{$0.idIngredient}
    }
    
    private var valueFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    var body: some View {
        NavigationView{
            VStack{
                switch creationState {
                case .ready:
                    Form{
                        Section(header: Text("Création Ingrédient 🥩🍣🥛🥦🧀.")
                                    .font(.system(size: 20))
                                    .foregroundColor(.purple)
                                    .fontWeight(.bold)){
                            HStack{
                                Text("Code : ")
                                    .fontWeight(.bold)
                                TextField("code ingrédient", value: $code , formatter: NumberFormatter())
                            }
                            if listIngredientCode.contains(where: { $0 == code }){
                                Text("Le code est déjà utilisé, changez-le.")
                                    .fontWeight(.bold)
                                    .foregroundColor(.red)
                            }
                            HStack{
                                Text("Libellé : ")
                                    .fontWeight(.bold)
                                TextField("libellé ", text: $libelle)
                            }
                            if listIngredientLibelle.contains(where: { $0.lowercased() == libelle.lowercased() }){
                                Text("Le nom d'ingrédient est déjà utilisé, changez-le.")
                                    .fontWeight(.bold)
                                    .foregroundColor(.red)
                            }
                            HStack{
                                Text("Quantité :")
                                    .fontWeight(.bold)
                                TextField("Quantité stock", value: $quantiteStockee, formatter: valueFormatter)
                            }
                            HStack{
                                Text("Prix :")
                                    .fontWeight(.bold)
                                TextField("Prix", value: $prixUnitaire, formatter: valueFormatter)
                            }
                            HStack{
                                Picker("Catégorie d'ingrédient", selection: $idCategorieIngredient) {
                                    Text("Viandes / Volailles").tag(1)
                                    Text("Poisson et crustacés").tag(2)
                                    Text("Crèmerie").tag(5)
                                    Text("Epicerie").tag(9)
                                    Text("Fruits et Légumes").tag(11)
                                }
                            }
                            HStack{
                                Picker("Unité", selection: $unite) {
                                    Text("Kg").tag("Kg")
                                    Text("L").tag("L")
                                    Text("PM").tag("PM")
                                    Text("botte").tag("botte")
                                    Text("P").tag("P")
                                    Text("QS").tag("QS")
                                    Text("U").tag("U")
                                    Text("B").tag("B")
                                }
                                Text("\(unite)")
                                    .fontWeight(.bold)
                            }
                            HStack{
                                Picker("Allergène", selection: $allergene) {
                                    Text("Oui").tag("Oui")
                                    Text("Non").tag("Non")
                                }
                                Text("\(allergene)")
                                    .fontWeight(.bold)
                            }
                            if allergene == "Oui"{
                                HStack{
                                    Picker("Catégorie d'allergène", selection: $categorieAllergene) {
                                        Text("Arachides").tag("Arachides")
                                        Text("Crustacés").tag("Crustacés")
                                        Text("Fruits à coque").tag("Fruits à coque")
                                        Text("Gluten").tag("Gluten")
                                        Text("Lait").tag("Lait")
                                        Text("Poisson").tag("Poisson")
                                        Text("Sésame").tag("Sésame")
                                        Text("Soja").tag("Soja")
                                        Text("Œufs").tag("Œufs")
                                    }
                                }//.fontWeight(.bold)
                            }
                          
                        }
                        if ((code != 00) && (libelle != "") && (prixUnitaire != 0.0) && (allergene != "") && (categorieAllergene != "") && (unite != "") && (allergene == "Oui") && !(listIngredientCode.contains(where: { $0 == code })) && !(listIngredientLibelle.contains(where: { $0.lowercased() == libelle.lowercased() })) ) || ( (code != 00) && (libelle != "") && (quantiteStockee != 0.0) && (prixUnitaire != 0.0) && (allergene != "")  && (unite != "") && (allergene == "Non") && !(listIngredientCode.contains(where: { $0 == code })) && !(listIngredientLibelle.contains(where: { $0.lowercased() == libelle.lowercased() }))){
                            Section {
                                Button(action: {IngredientDAO.CreateIngredient(code: code, libelle: libelle, quantiteStockee: quantiteStockee, prixUnitaire: prixUnitaire, allergene: allergene, idCategorieIngredient: idCategorieIngredient, categorieAllergene: categorieAllergene, unite: unite, vm: self.viewModelIngredient) }){
                                    Text("Créer l'ingrédient !")
                                        .fontWeight(.bold)
                                        .frame(alignment: .center)
                                }
                            }
                        }
                    }
                case .creating:
                    Text("Création de l'ingrédient")
                        .foregroundColor(.black)
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .black))
                        .scaleEffect(2)
                case .created:
                    Text("L'ingrédient \(libelle) a bien été créé ! Vous pouvez le retrouver dans le mercurial en RAFRAICHISSANT le mercurial 😇." )
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                        .padding()
                    Divider()
                    VStack {
                        Button(action: {
                            code = 00
                            libelle = ""
                            quantiteStockee = 0.0
                            prixUnitaire = 0.0
                            allergene = ""
                            idCategorieIngredient = 1
                            categorieAllergene = ""
                            unite = ""
                            IngredientIntent(vm: viewModelIngredient).created()
                        }){
                            Text("Compris !")
                                .fontWeight(.bold)
                                .frame(alignment: .center)
                            Text("Vous allez être redirigé(e) sur la page de création en appuyant.")
                                .italic()
                        }
                    }
                case .creatingError(let string):
                    Text("Erreur à la création de la fiche, veuillez réessayer ulérieurement")
                        .fontWeight(.bold)
                        .italic()
                    Divider()
                    Button(action: {
                        code = 00
                        libelle = ""
                        quantiteStockee = 0.0
                        prixUnitaire = 0.0
                        allergene = ""
                        idCategorieIngredient = 1
                        categorieAllergene = ""
                        unite = ""
                        IngredientIntent(vm: viewModelIngredient).created()
                    }){
                        Text("Ok")
                            .fontWeight(.bold)
                            .frame(alignment: .center)
                    }
                }
            }
        }
        .navigationTitle("Créer un ingrédient")
        .foregroundColor(.purple)
    }
}

struct CreateIngredientView_Previews: PreviewProvider {
    static var previews: some View {
        CreateIngredientView()
    }
}

