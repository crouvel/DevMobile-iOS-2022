//
//  ProgressionViewModel.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 28/02/2022.
//

import Foundation


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
