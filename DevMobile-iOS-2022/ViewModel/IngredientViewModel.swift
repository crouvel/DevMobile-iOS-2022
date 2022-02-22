
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

class IngredientViewModel: ObservableObject, Subscriber {
    typealias Input = IngredientIntentState
    typealias Failure = Never
    
    private(set) var ingredient: Ingredient
    @Published var libelle: String
    @Published var idIngredient: Int
    @Published var nomCategorie: String
    //@Published var collectionName: String
    @Published var error: IngredientError = .NONE
    var delegate: IngredientViewModelDelegate?
    
    init(ingredient: Ingredient){
        self.ingredient = ingredient
        self.idIngredient = ingredient.idIngredient
        self.libelle = ingredient.libelle
        self.nomCategorie = ingredient.nomCategorie
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
