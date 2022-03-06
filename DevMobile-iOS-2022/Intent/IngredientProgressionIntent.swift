//
//  IngredientProgressionIntent.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 25/02/2022.
//

import Foundation
import Combine

enum IngredientProgressionIntentState: Equatable, CustomStringConvertible {
    case READY
    case LIST_UPDATED
    
    var description: String {
        switch self {
            case .READY:
                return "Ready"
        case .LIST_UPDATED:
                return "List updated"
        }
    }
}

class IngredientProgressionIntent: ObservableObject {
    private var state = PassthroughSubject<SheetCompleteIntentState, Never>()
    
    func intentToChange(artistName: String){
        self.state.send(.LIST_UPDATED)
    }
    
    func addObserver(vm: SheetCompleteViewModel){
        self.state.subscribe(vm)
    }
}
