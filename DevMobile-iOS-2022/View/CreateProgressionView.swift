
//
//  CreateProgressionView.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 25/02/2022.
//

import SwiftUI

struct CreateProgressionView: View {
    @ObservedObject var viewModel: SheetCompleteViewModel
    //private var _viewModel2 : ProgressionViewModel
    @State var referenceProgression: String = ""
    @State var titleStep: String = ""
    @State var description : String = ""
    @State var ordre : Int = 1
    @State var temps : Int = 0
    @State var progressionAj : String = ""
    //@ObservedObject var intent : ProgressionIntent
    @ObservedObject var dataProgression: ProgressionListViewModel = ProgressionListViewModel()
    @State var created: Bool = false
    
    /*private var _viewModel2: ProgressionViewModel!
     var viewModel2: ProgressionViewModel {
     return viewModel2
     }*/
    
    init(vm: SheetCompleteViewModel){
        self.viewModel = vm
        //self.intent = intent
    }
    private var _listProgression: [String]!
    var listProgression: [String] {
        return dataProgression.vms.map{$0.referenceProgression}
    }
    
    private var creationProgressionState : ProgressionCreationIntentState {
        return self.viewModel.creationState
    }
    
    private var creationStepState : StepCreationIntentState {
        return self.viewModel.creationStateStep
    }
    
    var body: some View {
        NavigationView{
            VStack{
                switch creationProgressionState {
                case .creating:
                    Text("Création de la progression")
                        .foregroundColor(.black)
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .black))
                        .scaleEffect(2)
                case .creatingError(let error):
                    Text(error)
                    Text("Erreur à la création de la progression, elle n'a pas été ajoutée à la fiche technique, veuillez réésayer ultérieurement.")
                        .fontWeight(.bold)
                        .italic()
                        .padding()
                    Divider()
                case .created:
                    switch creationStepState {
                    case .created :
                        Text("L'étape a bien été créée, voulez-vous ajouter une autre étape ?")
                            .fontWeight(.bold)
                            .padding()
                        Divider()
                        HStack{
                            Button(action: {
                                titleStep = ""
                                description = ""
                                ordre = 1
                                temps = 0
                                progressionAj = ""
                                self.viewModel.creationStateStep = .ready
                                /*ProgressionDAO.addProgressionSheet(nomProgression: referenceProgression, nomRecette: self.viewModel.nomRecette)*/
                            }){
                                Text("Oui")
                                    .fontWeight(.bold)
                                    .foregroundColor(.blue)
                                    .frame(alignment: .center)
                            }
                            
                            NavigationLink(destination: CreateIngredientsListView(nomProgression: referenceProgression, vm: self.viewModel)){
                                Text("Non, terminer")
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                EmptyView()
                            }.padding()
                            
                        }
                    case .creating:
                        Text("Création de l'étape")
                            .foregroundColor(.black)
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .black))
                            .scaleEffect(2)
                    case .creatingError(let error):
                        Text(error)
                            .foregroundColor(.black)
                    case .ready:
                        Text("Progression \(referenceProgression) Créée !")
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                        Text("Ajoutes des étapes à la progression.")
                            .fontWeight(.bold)
                            .italic()
                        Form {
                            Section(header: Text("Informations principales de l'étape")
                                        .font(.system(size: 20))
                                        .foregroundColor(.black)
                                        .fontWeight(.bold)){
                                
                                HStack{
                                    Text("Titre de l'étape : ");
                                    TextField("Titre de l'étape", text: $titleStep)
                                    /*.onSubmit {
                                     vm.intentstate.intentToChange(name: name)
                                     }*/
                                }
                                
                                HStack{
                                    Text("Description de l'étape : ");
                                    TextEditor(text: $description)
                                    /*.onSubmit {
                                     vm.intentstate.intentToChange(name: name)
                                     }*/
                                }
                                HStack{
                                    Text("Temps (en minutes) : ");
                                    TextField("Durée de l'étape", value: $temps, formatter: NumberFormatter())
                                    /*.onSubmit {
                                     vm.intentstate.intentToChange(name: name)
                                     }*/
                                }
                                HStack{
                                    Text("Ordre : ");
                                    TextField("Ordre de l'étape", value: $ordre, formatter: NumberFormatter())
                                }
                            }
                            
                            if description == "" {
                                Section(header: Text("Associez une progression déjà écrite")
                                            .font(.system(size: 20))
                                            .foregroundColor(.black)
                                            .fontWeight(.bold)){
                                    HStack{
                                        Picker("Progression", selection: $progressionAj){
                                            ForEach(dataProgression.vms, id : \.progression.idProgression) { vm in
                                                Text("\(vm.progression.referenceProgression)").tag("\(vm.progression.referenceProgression)")
                                            }
                                            
                                        }
                                    }
                                }
                            }
                            if (titleStep != "") && (ordre > 0) && (temps > 1) {
                                Button(action: {StepDAO.CreateStep(titre: titleStep, ordre: ordre, temps: temps, description: description, refprogression: referenceProgression, desprogression: progressionAj, vm: self.viewModel)
                                }){
                                    Text("Ajouter l'étape")
                                        .fontWeight(.bold)
                                        .foregroundColor(.cyan)
                                        .frame(alignment: .center)
                                }
                            }
                        }
                    }
                case .ready:
                    Form{
                        Section(header: Text("Ajoutez une progression")
                                    .font(.system(size: 20))
                                    .foregroundColor(.black)
                                    .fontWeight(.bold)){
                            HStack{
                                Text("Référence de la progression : ");
                                TextField("Nom progression", text: $referenceProgression)
                            }
                            if listProgression.contains(where: { $0.lowercased() == referenceProgression.lowercased() }){
                                Text("Le nom de progression est déjà utilisé, changez-le.")
                                    .fontWeight(.bold)
                                    .foregroundColor(.red)
                            }
                            if (referenceProgression != "") && !(listProgression.contains(where: { $0.lowercased() == referenceProgression.lowercased() })) {
                                Divider()
                                Button(action: {ProgressionDAO.CreateProgression(nomProgression: referenceProgression, nomRecette: self.viewModel.nomRecette, vm: self.viewModel)
                                }){
                                    Text("Créer la progression")
                                        .fontWeight(.bold)
                                        .foregroundColor(.cyan)
                                        .frame(alignment: .center)
                                }
                            }
                        }
                    }
                }
                
            }.navigationTitle("Créer une progression")
                .navigationBarHidden(true)
        }
        .navigationBarBackButtonHidden(true)
    }
}//.backgroundView(.gray)

struct CreateProgressionView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProgressionView(vm: SheetCompleteViewModel(sheet:SheetComplete(nomRecette:"oui", idFiche: 555555, nomAuteur: "test", Nbre_couverts: 8, categorieRecette: "categorie", nomProgression: "")))
    }
}

