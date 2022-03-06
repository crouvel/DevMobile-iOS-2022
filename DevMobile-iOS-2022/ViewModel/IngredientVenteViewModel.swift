//
//  IngredientVenteViewModel.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 06/03/2022.
//

import Foundation

class IngredientVenteViewModel: ObservableObject {
   
    private(set) var ingredient: IngredientVente
    @Published var ingredients: String
    @Published var libelleCategorie: String
    
    init(ingredient: IngredientVente){
        self.ingredient = ingredient
        self.ingredients = ingredient.ingredients
        self.libelleCategorie = ingredient.libelleCategorie
    }
    
}
