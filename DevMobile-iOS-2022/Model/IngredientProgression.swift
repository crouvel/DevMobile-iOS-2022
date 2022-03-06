//
//  IngredientsProgression.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 25/02/2022.
//

import Foundation

struct IngredientProgressionDTO: Decodable{
    
    var codes: String
    var ingredients: String
    var unites: String
    var quantites: String
    var prix: String
    var prix_total: String
    var nomListeIngredients: String
}

struct LastIngredientListDTO: Decodable{
    var idLastCreatedList: Int
}

class IngredientProgression: ObservableObject {
    /*private var observers: [TrackObserver] = []*/
    var codes: String
    var ingredients: String
    var unites: String
    var quantites: String
    var prix: String
    var prix_total: String
    var nomListeIngredients: String
    
    
    init(codes: String, ingredients: String, unites: String, quantites: String, prix: String, prix_total: String, nomListeIngredients: String){
        self.codes = codes
        self.ingredients = ingredients
        self.unites = unites
        self.quantites = quantites
        self.prix = prix
        self.prix_total = prix_total
        self.nomListeIngredients = nomListeIngredients
    }
    
}
