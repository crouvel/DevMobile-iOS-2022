//
//  ProgressionViewModel.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 28/02/2022.
//

import Foundation

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

class ProgressionToCreateViewModel : ObservableObject{
    
    private(set) var progression: ProgressionToCreate
    @Published var referenceProgression: String
    //@Published var collectionName: String
    //@Published var error: IngredientError = .NONE
    //var delegate: IngredientViewModelDelegate?
    
    init(progression: ProgressionToCreate){
        self.progression = progression
        self.referenceProgression = progression.referenceProgression
        /*self.trackName = track.trackName
        self.artistName = track.artistName
        self.collectionName = track.collectionName*/
        /*self.track.addObserver(obs: self)*/
    }
    
}

class ProgressionViewModel : ObservableObject{
    
    private(set) var progression: Progression
    @Published var referenceProgression: String
    public var idProgression: Int
    //@Published var collectionName: String
    //@Published var error: IngredientError = .NONE
    //var delegate: IngredientViewModelDelegate?
    
    init(progression: Progression){
        self.progression = progression
        self.referenceProgression = progression.referenceProgression
        self.idProgression = progression.idProgression
        /*self.trackName = track.trackName
        self.artistName = track.artistName
        self.collectionName = track.collectionName*/
        /*self.track.addObserver(obs: self)*/
    }
    
}
