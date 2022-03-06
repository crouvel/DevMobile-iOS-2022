//
//  TrackViewModel.swift
//  Test_Cours_listUI
//
//  Created by m1 on 16/02/2022.
//

import Foundation
import Combine

enum SheetCompleteError: Error, Equatable, CustomStringConvertible {
    case NONE
    case NOM(String)
    case COUVERT(String)
    case CATEGORY(String)
    case AUTEUR(String)
    
    var description: String {
        switch self {
        case .NONE:
            return "No error"
        case .NOM:
            return "Name isn't  valid"
        case .COUVERT:
            return "Number couverts isn't valid"
        case .AUTEUR:
            return "AUTEUR isn't valid"
        case .CATEGORY:
            return "Category isn't valid"
        }
    }
}

enum ProgressionCreationIntentState : CustomStringConvertible{
    case ready
    case creating
    case created
    case creatingError(String)
    
    var description: String{
        switch self {
        case .ready                               : return "ready"
        case .creating                            : return "creating progession"
        case .created                              : return "created"
        case .creatingError(let error)             : return "creatingError: Error loading -> \(error)"
        }
    }
    
}

enum StepCreationIntentState : CustomStringConvertible{
    case ready
    case creating
    case created
    case creatingError(String)
    
    var description: String{
        switch self {
        case .ready                               : return "ready"
        case .creating                            : return "creating step"
        case .created                              : return "created"
        case .creatingError(let error)             : return "creatingError: Error loading -> \(error)"
        }
    }
    
}

enum IngredientListCreationIntentState : CustomStringConvertible{
    case ready
    case creating
    case created
    case creatingError(String)
    
    var description: String{
        switch self {
        case .ready                               : return "ready"
        case .creating                            : return "creating ingredient list"
        case .created                              : return "created"
        case .creatingError(let error)             : return "creatingError: Error loading -> \(error)"
        }
    }
}

enum AddIngredientToListIntentState : CustomStringConvertible {
    case ready
    case adding
    case added
    case addingError(String)
    case addMoreList
    
    var description: String{
        switch self {
        case .ready                               : return "ready"
        case .adding                                : return "adding"
        case .added                              : return "added"
        case .addingError(let error)             : return "creatingError: Error adding -> \(error)"
        case .addMoreList                        : return "add more"
        }
    }
}

enum DeleteSheetIntentState : CustomStringConvertible {
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

enum CreateSheetIntentState : CustomStringConvertible {
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

class SheetCompleteViewModel: SheetCompleteObserver, ObservableObject, Subscriber {
    typealias Input = SheetCompleteIntentState
    typealias Failure = Never
    
    func changed(nomRecette: String, idFiche: Int){
        SheetDAO.updateRecette(nom: nomRecette, idFiche: idFiche)
        self.nomRecette = nomRecette
    }
    func changed(nomAuteur: String){
        self.nomAuteur = nomAuteur
    }
    func changed(category: String){
        self.categorieRecette = category
    }
    func changed(couverts: Int){
        self.Nbre_couverts = couverts
    }
    
    @Published var creationState : ProgressionCreationIntentState = .ready{
        didSet{
            print("state: \(self.creationState)")
            switch self.creationState {
            case .created:
                print("created")
            case .creatingError(let error):
                print("\(error)")
            default:
                return
            }
        }
    }
    
    @Published var enteteCreationState : CreateSheetIntentState = .ready{
        didSet{
            print("state: \(self.enteteCreationState)")
            switch self.enteteCreationState {
            case .created:
                print("created")
            case .creatingError(let error):
                print("\(error)")
            default:
                return
            }
        }
    }
    
    
    @Published var deletionState : DeleteSheetIntentState = .ready{
        didSet{
            print("state: \(self.deletionState)")
            switch self.deletionState {
            case .deleted:
                print("deleted")
            case .deletingError(let error):
                print("\(error)")
            default:
                return
            }
        }
    }
    
    @Published var creationStateStep : StepCreationIntentState = .ready{
        didSet{
            print("state: \(self.creationStateStep)")
            switch self.creationStateStep {
            case .created:
                print("created")
            case .creatingError(let error):
                print("\(error)")
            default:
                return
            }
        }
    }
    
    @Published var creationStateIngredientList : IngredientListCreationIntentState = .ready{
        didSet{
            print("state: \(self.creationStateIngredientList)")
            switch self.creationStateIngredientList {
            case .created:
                print("created")
            case .creatingError(let error):
                print("\(error)")
            default:
                return
            }
        }
    }
    
    @Published var addStateIngredientList : AddIngredientToListIntentState = .ready{
        didSet{
            print("state: \(self.addStateIngredientList)")
            switch self.addStateIngredientList {
            case .added:
                print("added : addStateIngredientList")
            case .addingError(let error):
                print("\(error)")
            default:
                return
            }
        }
    }
    
    private(set) var sheet: SheetComplete
    public var idFiche: Int
    @Published var nomRecette : String
    @Published var nomAuteur: String
    @Published var Nbre_couverts: Int
    @Published var categorieRecette: String
    @Published var nomProgression: String
    @Published var PDFUrl: URL?
    @Published var showShareSheet: Bool = false
    @Published var error: SheetCompleteError = .NONE
    var delegate: SheetCompleteViewModelDelegate?
    
    init(sheet: SheetComplete){
        self.sheet = sheet
        self.idFiche = sheet.idFiche
        self.nomRecette = sheet.nomRecette
        self.nomAuteur = sheet.nomAuteur
        self.Nbre_couverts = sheet.Nbre_couverts
        self.categorieRecette = sheet.categorieRecette
        self.nomProgression = sheet.nomProgression
        /*self.trackName = track.trackName
         self.artistName = track.artistName
         self.collectionName = track.collectionName*/
        self.sheet.addObserver(obs: self)
    }
        
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        return
    }
    
    func receive(_ input: SheetCompleteIntentState) -> Subscribers.Demand {
        switch input {
        case .READY:
            break
        case .CHANGING_NOM(let nom):
            self.sheet.nomRecette = nom
            if(self.sheet.nomRecette != nom){
                self.error = .NOM("Invalid input")
            }
        case .CHANGING_COUVERT(let couvert):
            self.sheet.Nbre_couverts = couvert
            if(self.sheet.Nbre_couverts != couvert){
                self.error = .COUVERT("Invalid input")
            }
        case .CHANGING_CATEGORY(let category):
            self.sheet.categorieRecette = category
            if(self.sheet.categorieRecette != category){
                self.error = .CATEGORY("Invalid input")
            }
        case .CHANGING_AUTEUR(let auteur):
            self.sheet.nomAuteur = auteur
            if(self.sheet.nomAuteur != auteur){
                self.error = .AUTEUR("Invalid input")
            }
        case .LIST_UPDATED:
            self.delegate?.sheetCompleteViewModelChanged()
            break
        }
        return .none
    }
}

