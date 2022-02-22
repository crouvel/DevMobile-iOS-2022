//
//  StepProgressionListIntent.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 22/02/2022.
//

import Foundation

enum StepProgressionListState : CustomStringConvertible{
    case ready
    case loading(String)
    case loaded([StepProgression])
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
