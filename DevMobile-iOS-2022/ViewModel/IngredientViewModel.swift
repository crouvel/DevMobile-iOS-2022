
//
//  TrackViewModel.swift
//  Test_Cours_listUI
//
//  Created by m1 on 16/02/2022.
//

import Foundation
import Combine

//MARK: Intent states pour Ingrédient
enum IngredientError: Error, Equatable, CustomStringConvertible {
    case NONE
    case LIBELLE(String)
    case QUANTITE(String)
    case PRIX(String)
    var description: String {
        switch self {
        case .NONE:
            return "No error"
        case .LIBELLE:
            return "Libelle of ingredient is not  valid"
        case .QUANTITE:
            return "quantity not valid"
        case .PRIX:
            return "prix not valid"
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
    
    var description: String{
        switch self {
        case .ready                               : return "ready"
        case .creating                            : return "creating sheet"
        case .created                              : return "created"
        case .creatingError(let error)             : return "creatingError: Error loading -> \(error)"
        }
    }
}

class IngredientViewModel: ObservableObject, Subscriber, IngredientObserver {
    func changed(libelle: String, idIngredient: Int) {
        IngredientDAO.updateLibelle(libelle: libelle, idIngredient: idIngredient)
        self.libelle = libelle
    }
    
    func changed(categorie: Int, idIngredient: Int) {
        
        self.idCategorieIngredient = categorie
    }
    
    func changed(prix: Float, idIngredient: Int) {
        IngredientDAO.updatePrix(prix: prix, idIngredient: idIngredient)
        self.prixUnitaire = prix
    }
    func changed(quantite: Float, idIngredient: Int) {
        IngredientDAO.updateQuantite(quantite: quantite, idIngredient: idIngredient)
        self.quantiteStockee = quantite
    }
    
    typealias Input = IngredientIntentState
    typealias Failure = Never
    
    @Published var creationIngredientState : CreateIngredientIntentState = .ready{
        didSet{
            print("state: \(self.creationIngredientState)")
            switch self.creationIngredientState { // state has changed
            case .created:
                
                print("created")
            case .creatingError(let error):
                print("\(error)")
            default:
                return
            }
        }
    }
    
    @Published var deletionState : DeleteIngredientIntentState = .ready{
        didSet{
            print("state: \(self.deletionState)")
            switch self.deletionState { // state has changed
            case .deleted:
                print("deleted")
            case .deletingError(let error):
                print("\(error)")
            default:
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
        self.ingredient.addObserver(obs: self)
    }
    
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
        case .CHANGING_LIBELLE(let libelle):
            self.ingredient.libelle = libelle
            if (self.ingredient.libelle != libelle){
                self.error = .LIBELLE("Invalid input")
            }
        case .CHANGING_CATEGORIE(let categorie):
            self.ingredient.idCategorieIngredient = categorie
            /*if(self.ingredient.nomCategorie != categorie){
             self.error = .CATEGORIE("Invalid input")
             }*/
        case .CHANGING_PRIX(let prix):
            self.ingredient.prixUnitaire = prix
            if (self.ingredient.prixUnitaire != prix){
                self.error = .PRIX("Invalid input")
            }
        case .CHANGING_QTE(let quantite):
            self.ingredient.quantiteStockee = quantite
            if (self.ingredient.quantiteStockee != quantite){
                self.error = .QUANTITE("Invalid input")
            }
        case .LIST_UPDATED:
            self.delegate?.ingredientViewModelChanged()
            break
        }
        return .none
    }
}
