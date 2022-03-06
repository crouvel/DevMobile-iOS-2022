//
//  IngredientListProgressionIntent.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 25/02/2022.
//

import Foundation

enum IngredientProgressionListState : CustomStringConvertible{
    case ready
    case loading(String)
    case loaded([IngredientProgressionDTO])
    case loadingError(String)

    var description: String{
        switch self {
        case .ready                               : return "ready"
        case .loading(let s)                      : return "loading"
        case .loaded(let ingredients)                  : return "loaded: \(ingredients.count) ingredients"
        case .loadingError(let error)             : return "loadingError: Error loading -> \(error)"
        }
    }
}

class IngredientProgressionListViewIntent{
    
    var ingredientList : IngredientsProgressionListViewModel
    
    init(list: IngredientsProgressionListViewModel){
        self.ingredientList = list
    }
        
    func loaded(ingredients: [IngredientProgression]){
        #if DEBUG
        debugPrint("SheetCompleteListIntent: \(self.ingredientList.ingredientListState) => \(ingredients.count)  loaded")
        #endif
        self.ingredientList.ingredientListState = .ready
    }
    
    func httpJsonLoaded(result: [IngredientProgressionDTO]){
            #if DEBUG
            debugPrint("SearchIntent: httpJsonLoaded -> success ")
            #endif
            ingredientList.ingredientListState = .loaded(result)
    }
    
    func httpJsonLoadedError(error: Error){
            #if DEBUG
            debugPrint("SearchIntent: httpJsonLoaded -> success ")
            #endif
            ingredientList.ingredientListState = .loadingError("\(error)")
    }
    func ingredientsLoaded(){
        #if DEBUG
        debugPrint("loaded -> ready")
        #endif
        ingredientList.ingredientListState = .ready
    }

   
    func load(url : String){
        #if DEBUG
        debugPrint("SearchIntent: .loading(\(url))")
        #endif
        ingredientList.ingredientListState = .loading(url)
    }
    
}
