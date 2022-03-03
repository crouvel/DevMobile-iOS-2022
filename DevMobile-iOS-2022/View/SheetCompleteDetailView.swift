//
//  SheetCompleteDetailView.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 22/02/2022.
//

import SwiftUI

struct SheetCompleteDetailView: View {
    //var exportURL : URL
    //var intent: SheetCompleteIntent
    @ObservedObject var viewModel: SheetCompleteViewModel
    //@ObservedObject var viewModel2: IngredientProgressionViewModel
    @State var errorMessage: String = ""
    @State var showErrorMessage: Bool = false
    //@ObservedObject var listvm : StepProgressionListViewModel
    
    private var _listvm: StepProgressionListViewModel!
    var listvm: StepProgressionListViewModel {
        return _listvm
    }
    private var _listvm2: IngredientsProgressionListViewModel!
    var listvm2: IngredientsProgressionListViewModel {
        return _listvm2
    }
    init(vm: SheetCompleteViewModel/*, vm2: IngredientProgressionViewModel*/){
        //self.intent = SheetCompleteIntent()
        self.viewModel = vm
        //self.exportURL = URL(string: "")!
        //self.viewModel2 = vm2
        //self.intent.addObserver(vm: self.viewModel)
        self._listvm = StepProgressionListViewModel(referenceProgression: self.viewModel.nomProgression ?? "")
        self._listvm2 = IngredientsProgressionListViewModel(idFiche: self.viewModel.idFiche)
        /*vm.ingredients.split(separator: ",").map {_ in
         
         }*/
        
    }
    //private var dataSteps: StepProgressionListViewModel { return StepProgressionListViewModel(referenceProgression: self.viewModel.nomProgression)}
    
    var body: some View {
        if self.viewModel.nomProgression != "" {
            ScrollView {
                VStack {
                    HStack{
                        Button("Export PDF") {
                            
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
                            //func savePDF() {
                            /*@available(iOS 11.0, *)
                             guard let documentData = document.dataRepresentation() else { return }
                             let activityController = UIActivityViewController(activityItems: [documentData], applicationActivities: nil)
                             self.present(activityController, animated: true, completion: nil)
                             //}*/
                            
                        }.padding()
                        NavigationLink(destination: CalculCoutsView(vm: self.viewModel)){
                            Text("Calcul des coûts")
                                .fontWeight(.bold)
                            EmptyView()
                        }
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
                        Divider()
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
                    Divider()
                    VStack{
                        HStack{
                            Spacer()
                            HStack{
                                Text("Ingrédients")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .font(.system(size: 20))
                                /*Text("Unité")
                                 .fontWeight(.bold)
                                 .foregroundColor(.white)
                                 .font(.system(size: 20))
                                 Text("Qté")
                                 .fontWeight(.bold)
                                 .foregroundColor(.white)
                                 .font(.system(size: 20))*/                    }
                            /*.fontWeight(.bold)
                             .foregroundColor(.white)
                             .font(.system(size: 20))*/
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
                        /*HStack{
                         Text("\(viewModel.nomAuteur)")                //Text("\(listvm.vms.count)")
                         }*/
                    }
                    HStack {
                        VStack{
                            ForEach( _listvm.vms, id: \.step.id ) {
                                vm in
                                if vm.step.titre2 == nil {
                                    VStack{
                                        Text("\(vm.step.titre1)")
                                            .fontWeight(.bold)
                                            .underline()
                                        Text(vm.step.description1 ?? "")
                                            .italic()
                                            .fixedSize(horizontal: false, vertical: true)
                                    }
                                }else {
                                    VStack{
                                        /*Text("\(vm.step.titre1)")
                                         .fontWeight(.bold)
                                         .font(.system(size: 19))*/
                                        Text(vm.step.titre2 ?? "")
                                            .fontWeight(.bold)
                                            .underline()
                                        Text(vm.step.description2 ?? "")
                                            .italic()
                                            .fixedSize(horizontal: false, vertical: true)
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
                                            Text(ingredient)
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
                }.alert("\(errorMessage)", isPresented: $showErrorMessage){
                    Button("Ok", role: .cancel){
                        showErrorMessage = false
                    }
                }
            }
        } else {
            SheetDetailIncompleteView(vm: self.viewModel)
        }
    }
}

struct SheetCompleteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SheetCompleteDetailView(
            vm: SheetCompleteViewModel(sheet:SheetComplete(nomRecette:"oui", idFiche: 555555, nomAuteur: "test", Nbre_couverts: 8, categorieRecette: "categorie", nomProgression: "ok")))
    }
}
