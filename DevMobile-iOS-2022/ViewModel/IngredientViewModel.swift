
//
//  TrackViewModel.swift
//  Test_Cours_listUI
//
//  Created by m1 on 16/02/2022.
//

import Foundation
import Combine

enum IngredientError: Error, Equatable, CustomStringConvertible {
    case NONE
    /*case TRACKNAME(String)
    case ARTISTNAME(String)
    case COLLECTIONNAME(String)*/
    
    var description: String {
        switch self {
            case .NONE:
                    return "No error"
            /*case .TRACKNAME:
                    return "Trackname isn't  valid"
            case .ARTISTNAME:
                    return "Artist name isn't valid"
            case .COLLECTIONNAME:
                return "Collection name isn't valid"*/
        }
    }
}

enum DeleteIngredientIntentState : CustomStringConvertible {
    case ready
    case deleting(String)
    case deleted
    case deletingError(String)

    var description: String{
        switch self {
        case .ready                               : return "ready"
        case .deleting(let s)                                : return "deleting \(s)"
        case .deleted                             : return "deleted"
        case .deletingError(let error)             : return "deletingError: Error adding -> \(error)"
        }
    }
}

enum CreateIngredientIntentState : CustomStringConvertible {
    case ready
    case creating
    case created
    case creatingError(String)
    //case newEditeurs([EditeurViewModel])

    var description: String{
        switch self {
        case .ready                               : return "ready"
        case .creating                            : return "creating sheet"
        case .created                              : return "created"
        case .creatingError(let error)             : return "creatingError: Error loading -> \(error)"
        //case .newEditeurs(let editeurs)               : return "newJeu: reset game list with \(editeurs.count) editors"
        }
    }
}

class IngredientViewModel: ObservableObject, Subscriber {
    typealias Input = IngredientIntentState
    typealias Failure = Never
    
    @Published var creationIngredientState : CreateIngredientIntentState = .ready{
        didSet{
            print("state: \(self.creationIngredientState)")
            switch self.creationIngredientState { // state has changed
            case .created:    // new data has been loaded, to change all games of list
                //let sortedData = data.sorted(by: { $0. < $1.name })
                print("created")
            case .creatingError(let error):
                print("\(error)")
            default:                   // nothing to do for ViewModel, perhaps for the view
                return
            }
        }
    }

    
    @Published var deletionState : DeleteIngredientIntentState = .ready{
        didSet{
            print("state: \(self.deletionState)")
            switch self.deletionState { // state has changed
            case .deleted:    // new data has been loaded, to change all games of list
                //let sortedData = data.sorted(by: { $0. < $1.name })
                print("deleted")
            case .deletingError(let error):
                print("\(error)")
            default:                   // nothing to do for ViewModel, perhaps for the view
                return
            }
        }
    }
    
    private(set) var ingredient: Ingredient
    @Published var libelle: String
    @Published var idIngredient: Int
    @Published var nomCategorie: String
    @Published var quantiteStockee : Float?
    @Published var allergene : String
    @Published var prixUnitaire : Float
    @Published var idCategorieAllergene : String?
    @Published var unite : String
    @Published var idCategorieIngredient : Int
    //@Published var collectionName: String
    @Published var error: IngredientError = .NONE
    var delegate: IngredientViewModelDelegate?
    
    init(ingredient: Ingredient){
        self.ingredient = ingredient
        self.idIngredient = ingredient.idIngredient
        self.libelle = ingredient.libelle
        self.nomCategorie = ingredient.nomCategorie
        self.quantiteStockee = ingredient.quantiteStockee
        self.allergene = ingredient.allergene
        self.prixUnitaire = ingredient.prixUnitaire
        self.idCategorieAllergene = ingredient.idCategorieAllergene
        self.unite = ingredient.unite
        self.idCategorieIngredient = ingredient.idCategorieIngredient
        /*self.trackName = track.trackName
        self.artistName = track.artistName
        self.collectionName = track.collectionName*/
        /*self.track.addObserver(obs: self)*/
    }
    
    /*func changed(trackName: String) {
        self.trackName = trackName
    }
    
    func changed(collectionName: String) {
        self.collectionName = collectionName
    }
    
    func changed(artistName: String) {
        self.artistName = artistName
    }*/
    
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        return
    }
    
    func receive(_ input: IngredientIntentState) -> Subscribers.Demand {
        switch input {
            case .READY:
                break
            /*case .CHANGING_ARTISTNAME(let artistName):
                self.track.artistName = artistName
                if(self.track.artistName != artistName){
                    self.error = .ARTISTNAME("Invalid input")
                }*/
            case .LIST_UPDATED:
                self.delegate?.ingredientViewModelChanged()
                break
        }
        
        return .none
    }
}
