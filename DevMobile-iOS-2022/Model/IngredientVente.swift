//
//  IngredientVente.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 06/03/2022.
//

import Foundation

struct IngredientVenteDTO: Decodable {
    var ingredients: String
    var libelleCategorie: String
}

class IngredientVente: ObservableObject {
    @Published var ingredients: String
    @Published var libelleCategorie : String
    
    init(ingredients: String, libelleCategorie: String){
        self.ingredients = ingredients
        self.libelleCategorie = libelleCategorie
    }
}
