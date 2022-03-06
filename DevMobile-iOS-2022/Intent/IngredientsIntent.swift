//
//  TracksIntent.swift
//  Test_Cours_listUI
//
//  Created by m1 on 19/02/2022.
//

import Foundation

enum IngredientsListState : CustomStringConvertible{
    case ready
    case loading(String)
    case loaded([Ingredient])
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

