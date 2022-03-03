//
//  IngredientsProgressionViewModel.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 25/02/2022.
//

import Foundation
import Combine

enum IngredientProgressionError: Error, Equatable, CustomStringConvertible {
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

class IngredientProgressionViewModel: ObservableObject, Subscriber, Equatable {
    static func == (lhs: IngredientProgressionViewModel, rhs: IngredientProgressionViewModel) -> Bool {
        return true
    }
    
    
    typealias Input = IngredientProgressionIntentState
    typealias Failure = Never
    
    private(set) var ingredient: IngredientProgression
    public var codes: String
    public var ingredients: String
    public var unites: String
    public var quantites: String
    public var prix: String
    public var prix_total: String
    public var nomListeIngredients: String    //@Published var collectionName: String
    @Published var error: IngredientProgressionError = .NONE
    var delegate: IngredientProgressionViewModelDelegate?
    
    init(ingredient: IngredientProgression){
        self.ingredient = ingredient
        self.codes = ingredient.codes
        self.ingredients = ingredient.ingredients
        self.unites = ingredient.unites
        self.quantites = ingredient.quantites
        self.prix = ingredient.prix
        self.prix_total = ingredient.prix_total
        self.nomListeIngredients = ingredient.nomListeIngredients         /*self.trackName = track.trackName
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
    
    func receive(_ input: IngredientProgressionIntentState) -> Subscribers.Demand {
        switch input {
            case .READY:
                break
            /*case .CHANGING_ARTISTNAME(let artistName):
                self.track.artistName = artistName
                if(self.track.artistName != artistName){
                    self.error = .ARTISTNAME("Invalid input")
                }*/
            case .LIST_UPDATED:
                self.delegate?.ingredientProgressionViewModelChanged()
                break
        }
        
        return .none
    }
}
