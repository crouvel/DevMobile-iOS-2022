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

enum ProgressionCreationIntentState : CustomStringConvertible{
    case ready
    case creating
    case created
    case creatingError(String)
    //case newEditeurs([EditeurViewModel])

    var description: String{
        switch self {
        case .ready                               : return "ready"
        case .creating                            : return "creating progession"
        case .created                              : return "created"
        case .creatingError(let error)             : return "creatingError: Error loading -> \(error)"
        //case .newEditeurs(let editeurs)               : return "newJeu: reset game list with \(editeurs.count) editors"
        }
    }
    
}

enum StepCreationIntentState : CustomStringConvertible{
    case ready
    case creating
    case created
    case creatingError(String)
    //case newEditeurs([EditeurViewModel])

    var description: String{
        switch self {
        case .ready                               : return "ready"
        case .creating                            : return "creating step"
        case .created                              : return "created"
        case .creatingError(let error)             : return "creatingError: Error loading -> \(error)"
        //case .newEditeurs(let editeurs)               : return "newJeu: reset game list with \(editeurs.count) editors"
        }
    }
    
}

enum IngredientListCreationIntentState : CustomStringConvertible{
    case ready
    case creating
    case created
    case creatingError(String)
    //case newEditeurs([EditeurViewModel])

    var description: String{
        switch self {
        case .ready                               : return "ready"
        case .creating                            : return "creating ingredient list"
        case .created                              : return "created"
        case .creatingError(let error)             : return "creatingError: Error loading -> \(error)"
        //case .newEditeurs(let editeurs)               : return "newJeu: reset game list with \(editeurs.count) editors"
        }
    }
}

enum AddIngredientToListIntentState : CustomStringConvertible{
    case ready
    case adding
    case added
    case addingError(String)
    case addMoreList
    //case newEditeurs([EditeurViewModel])

    var description: String{
        switch self {
        case .ready                               : return "ready"
        case .adding                                : return "adding"
        case .added                              : return "added"
        case .addingError(let error)             : return "creatingError: Error adding -> \(error)"
        case .addMoreList                        : return "add more"
        //case .newEditeurs(let editeurs)               : return "newJeu: reset game list with \(editeurs.count) editors"
        }
    }
}


class SheetCompleteViewModel: ObservableObject, Subscriber {
    typealias Input = SheetCompleteIntentState
    typealias Failure = Never
    
    @Published var creationState : ProgressionCreationIntentState = .ready{
        didSet{
            print("state: \(self.creationState)")
            switch self.creationState { // state has changed
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
    
    @Published var creationStateStep : StepCreationIntentState = .ready{
        didSet{
            print("state: \(self.creationStateStep)")
            switch self.creationStateStep { // state has changed
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
    
    @Published var creationStateIngredientList : IngredientListCreationIntentState = .ready{
        didSet{
            print("state: \(self.creationStateIngredientList)")
            switch self.creationStateIngredientList { // state has changed
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
    
    @Published var addStateIngredientList : AddIngredientToListIntentState = .ready{
        didSet{
            print("state: \(self.addStateIngredientList)")
            switch self.addStateIngredientList { // state has changed
            case .added:    // new data has been loaded, to change all games of list
                //let sortedData = data.sorted(by: { $0. < $1.name })
                print("added : addStateIngredientList")
            case .addingError(let error):
                print("\(error)")
            default:                   // nothing to do for ViewModel, perhaps for the view
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
    //@Published var collectionName: String
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
    
    func receive(_ input: SheetCompleteIntentState) -> Subscribers.Demand {
        switch input {
            case .READY:
                break
            /*case .CHANGING_ARTISTNAME(let artistName):
                self.track.artistName = artistName
                if(self.track.artistName != artistName){
                    self.error = .ARTISTNAME("Invalid input")
                }*/
            case .LIST_UPDATED:
                self.delegate?.sheetCompleteViewModelChanged()
                break
        }
        
        return .none
    }
}

