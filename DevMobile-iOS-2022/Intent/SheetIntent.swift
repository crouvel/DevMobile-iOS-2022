//
//  TrackIntent.swift
//  Test_Cours_listUI
//
//  Created by m1 on 16/02/2022.
//

import Foundation
import Combine

enum SheetIncompleteIntentState: Equatable, CustomStringConvertible {
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

class SheetIntent: ObservableObject {
    //private var state = PassthroughSubject<SheetIncompleteIntentState, Never>()
    
    /*func intentToChange(nom: String){
        self.state.send(.CHANGING_NOM(nom))
        self.state.send(.LIST_UPDATED)
    }
    
    func intentToChange(categorie: String){
        self.state.send(.CHANGING_CATEGORY(categorie))
        self.state.send(.LIST_UPDATED)
    }
    
    func intentToChange(couvert: Int){
        self.state.send(.CHANGING_COUVERT(couvert))
        self.state.send(.LIST_UPDATED)
    }
    
    func intentToChange(auteur: String){
        self.state.send(.CHANGING_AUTEUR(auteur))
        self.state.send(.LIST_UPDATED)
    }
    
    func addObserver(vm: SheetCompleteViewModel){
        self.state.subscribe(vm)
    }*/
}
