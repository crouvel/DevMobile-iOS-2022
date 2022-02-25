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
    //case newEditeurs([EditeurViewModel])

    var description: String{
        switch self {
        case .ready                               : return "ready"
        case .loading(let s)                      : return "loading"
        case .loaded(let editeurs)                  : return "loaded: \(editeurs.count) ingredients"
        case .loadingError(let error)             : return "loadingError: Error loading -> \(error)"
        //case .newEditeurs(let editeurs)               : return "newJeu: reset game list with \(editeurs.count) editors"
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
        debugPrint("SheetCompleteListIntent: \(self.ingredientList.ingredientListState) => \(ingredients.count) editors loaded")
        #endif
        self.ingredientList.ingredientListState = .ready
    }
    
    func httpJsonLoaded(result: [IngredientProgressionDTO]){
            #if DEBUG
            debugPrint("SearchIntent: httpJsonLoaded -> success -> .loaded(editors)")
            #endif
            ingredientList.ingredientListState = .loaded(result)
    }
    
    func httpJsonLoadedError(error: Error){
            #if DEBUG
            debugPrint("SearchIntent: httpJsonLoaded -> success -> .loaded(editors)")
            #endif
            ingredientList.ingredientListState = .loadingError("\(error)")
    }
    func editeurLoaded(){
        #if DEBUG
        debugPrint("SearchIntent: editor deleted => save data")
        #endif
        ingredientList.ingredientListState = .ready
    }

   
    func loadEditeurs(url : String){
        #if DEBUG
        debugPrint("SearchIntent: .loading(\(url))")
        debugPrint("SearchIntent: asyncLoadEditors")
        #endif
        ingredientList.ingredientListState = .loading(url)
    }
    
}
