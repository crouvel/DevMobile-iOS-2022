//
//  CalculCoutsIView.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 28/02/2022.
//

import SwiftUI

struct CalculCoutsView: View {
    @ObservedObject var viewModel: SheetCompleteViewModel
    @State var fluidePersonnel : Bool = true
    @State var coutMoyen : Float = 15
    @State var coutForfaitaire : Float = 5
    @State var coefficient : Float = 2.8
    @State var coefficientfp : Float = 1.4
    @State var applyCoef1 : Bool = false
    @State var applyCoef2 : Bool = false
    init(vm: SheetCompleteViewModel){
        self.viewModel = vm
        self._listvm2 = IngredientsProgressionListViewModel(idFiche: self.viewModel.idFiche)
        self._listcost = TotalCostsViewModel(idFiche: self.viewModel.idFiche)
    }
    
    private var _listvm2: IngredientsProgressionListViewModel!
    var listvm2: IngredientsProgressionListViewModel {
        return _listvm2
    }
    
    private var _listcost: TotalCostsViewModel!
    var listcost: TotalCostsViewModel {
        return _listcost
    }
    
    var body: some View {
        ScrollView{
            VStack{
                HStack{
                    Spacer()
                    HStack{
                        Text("Dénomination")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                    }
                    Spacer()
                }.background(Color.blue)
                    .frame( alignment: .center)
                Divider()
                VStack{
                    HStack {
                        VStack {
                            Text("Codes")
                                .fontWeight(.bold)
                            ForEach( _listvm2.vms,id: \.ingredient.nomListeIngredients) {
                                vm in
                                VStack{
                                    ForEach(vm.codes.split(separator: ","), id: \.self){ code in
                                        Text(code)
                                    }
                                }
                            }
                        }
                        
                        VStack {
                            Text("Nature")
                                .fontWeight(.bold)
                            ForEach( _listvm2.vms,id: \.ingredient.nomListeIngredients) {
                                vm in
                                VStack{
                                    ForEach(vm.ingredients.split(separator: ","), id: \.self){ ingredient in
                                        Text(ingredient)
                                    }
                                }
                            }
                        }
                        
                        VStack {
                            Text("Unite")
                                .fontWeight(.bold)
                            ForEach( _listvm2.vms,id: \.ingredient.nomListeIngredients) {
                                vm in
                                VStack{
                                    ForEach(vm.unites.split(separator: ","), id: \.self){ unite in
                                        Text(unite)
                                    }
                                }
                            }
                        }
                        VStack {
                            Text("Qté tot")
                                .fontWeight(.bold)
                            ForEach( _listvm2.vms,id: \.ingredient.nomListeIngredients) {
                                vm in
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
                HStack{
                    Spacer()
                    HStack{
                        Text("Valorisation")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                    }
                    Spacer()
                }.background(Color.blue)
                    .frame( alignment: .center)
                Divider()
                VStack {
                    HStack {
                        VStack {
                            Text("Ingrédient")
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                            ForEach( _listvm2.vms,id: \.ingredient.nomListeIngredients) {
                                vm in
                                VStack{
                                    ForEach(vm.ingredients.split(separator: ","), id: \.self){ ingredient in
                                        Text(ingredient)
                                            .italic()
                                    }
                                }
                            }
                        }
                        VStack {
                            Text("Prix Unitaire")
                                .fontWeight(.bold)
                            ForEach( _listvm2.vms,id: \.ingredient.nomListeIngredients) {
                                vm in
                                VStack{
                                    ForEach(vm.prix.split(separator: ","), id: \.self){ prix in
                                        HStack {
                                            Text(prix)
                                            Text("€")
                                        }
                                    }
                                }
                            }
                        }
                        VStack {
                            Text("PTHT")
                                .fontWeight(.bold)
                            ForEach( _listvm2.vms,id: \.ingredient.nomListeIngredients) {
                                vm in
                                VStack{
                                    ForEach(vm.prix_total.split(separator: ","), id: \.self){ prixtot in
                                        HStack{
                                            Text(String(format: "%.1f", (prixtot as NSString).floatValue))
                                            Text("€")
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
                Divider()
                Divider()
                VStack {
                    HStack {
                        VStack{
                            Text("Total Denrées : ")
                                .fontWeight(.bold)
                            Text("ASS 5% : ")
                                .fontWeight(.bold)
                            Text("Coût matière : ")
                                .fontWeight(.bold)
                            if fluidePersonnel {
                                Text("Coût personnel : ")
                                    .fontWeight(.bold)
                                Text("Coût fluide : ")
                                    .fontWeight(.bold)
                            }
                            Divider()
                            Text("Coût de production tot : ")
                                .fontWeight(.bold)
                            //Text("Coût de production pour portion de 200g")
                        }
                        VStack{
                            HStack {
                                Text(String(format: "%.2f", _listcost.vms[0].cost.prix_total))
                                Text("€")
                            }
                            HStack {
                                Text(String(format: "%.2f", _listcost.vms[0].cost.prix_total*0.05))
                                Text("€")
                            }
                            HStack {
                                Text(String(format: "%.2f", (_listcost.vms[0].cost.prix_total*0.05) + _listcost.vms[0].cost.prix_total ))
                                Text("€")
                            }
                            if fluidePersonnel {
                                HStack {
                                    Text(String(format: "%.1f", coutMoyen))
                                    Text("€")
                                }
                                HStack {
                                    Text(String(format: "%.1f", coutForfaitaire))
                                    Text("€")
                                }
                            }
                        Divider()
                            HStack {
                                Text(String(format: "%.2f", (_listcost.vms[0].cost.prix_total*0.05) + _listcost.vms[0].cost.prix_total ))
                            }
                        }
                    }
                }
            }.navigationTitle("Calcul des coûts")
        }
    }
}


struct CalculCoutsView_Previews: PreviewProvider {
    static var previews: some View {
        CalculCoutsView(vm: SheetCompleteViewModel(sheet:SheetComplete(nomRecette:"oui", idFiche: 555555, nomAuteur: "test", Nbre_couverts: 8, categorieRecette: "categorie", nomProgression: "ok")))
    }
}
