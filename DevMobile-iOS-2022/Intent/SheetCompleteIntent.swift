//
//  TrackIntent.swift
//  Test_Cours_listUI
//
//  Created by m1 on 16/02/2022.
//

import Foundation
import Combine

enum SheetCompleteIntentState: Equatable, CustomStringConvertible {
    //case ready
    case READY
    /*case CHANGING_ARTISTNAME(String)*/
    case LIST_UPDATED
    
    var description: String {
        switch self {
            case .READY:
                return "Ready"
            /*case .CHANGING_ARTISTNAME(let artistName):
                return "Changing artist name to \(artistName)"*/
        case .LIST_UPDATED:
                return "List updated"
        }
    }
}

class SheetCompleteIntent: ObservableObject {
    private var state = PassthroughSubject<SheetCompleteIntentState, Never>()
    
    func intentToChange(artistName: String){
        /*self.state.send(.CHANGING_ARTISTNAME(artistName))*/
        self.state.send(.LIST_UPDATED)
    }
    
    func addObserver(vm: SheetCompleteViewModel){
        self.state.subscribe(vm)
    }
}