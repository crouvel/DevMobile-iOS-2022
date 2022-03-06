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

    var description: String{
        switch self {
        case .ready                               : return "ready"
        case .loading(let s)                      : return "loading"
        case .loaded(let steps)                  : return "loaded: \(steps.count) ingredients"
        case .loadingError(let error)             : return "loadingError: Error loading -> \(error)"
        }
    }
}
