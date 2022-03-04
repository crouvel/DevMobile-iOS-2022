//
//  IngredientSheetViewModel.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 04/03/2022.
//

import Foundation

class IngredientSheetViewModel: ObservableObject {
   
    private(set) var ingredient: IngredientSheet
    @Published var libelle: String
    @Published var idIngredient: Int
    
    init(ingredient: IngredientSheet){
        self.ingredient = ingredient
        self.idIngredient = ingredient.idIngredient
        self.libelle = ingredient.libelle
    }
    
}
