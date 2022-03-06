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
    case CHANGING_NOM(String)
    case CHANGING_COUVERT(Int)
    case CHANGING_CATEGORY(String)
    case CHANGING_AUTEUR(String)
    case LIST_UPDATED
    
    var description: String {
        switch self {
        case .READY:
            return "Ready"
            case .CHANGING_NOM(let nom):
             return "Changing name to \(nom)"
        case .CHANGING_COUVERT(let couvert):
         return "Changing couvert to \(couvert)"
        case .CHANGING_CATEGORY(let category):
         return "Changing category to \(category)"
        case .CHANGING_AUTEUR(let auteur):
         return "Changing auteur to \(auteur)"
        case .LIST_UPDATED:
            return "List updated"
        }
    }
}

class SheetCompleteIntent: ObservableObject {
    private var state = PassthroughSubject<SheetCompleteIntentState, Never>()
    
    var sheetCompletevm : SheetCompleteViewModel
    
    init(vm: SheetCompleteViewModel){
        self.sheetCompletevm = vm
    }
    
    func deleted(){
#if DEBUG
        debugPrint("SheetCompleteListIntent: \(self.sheetCompletevm.deletionState) => deleted")
#endif
        self.sheetCompletevm.deletionState = .ready
    }
    
    func deleting(s: String){
#if DEBUG
        debugPrint("SheetCompleteListIntent: \(self.sheetCompletevm.deletionState) => deleting")
#endif
        self.sheetCompletevm.deletionState = .deleting(s)
    }
    
    func deletingError(error: Error){
#if DEBUG
        debugPrint("state: deleting error")
#endif
        self.sheetCompletevm.deletionState = .deletingError("\(error)")
    }
    func sheetDeleted(){
#if DEBUG
        debugPrint("SearchIntent: editor deleted => save data")
#endif
        DispatchQueue.main.async {
            self.sheetCompletevm.deletionState = .deleted
        }
    }
    
    func created(){
#if DEBUG
        debugPrint("SheetCompleteListIntent: \(self.sheetCompletevm.enteteCreationState) => created")
#endif
        self.sheetCompletevm.enteteCreationState = .ready
    }
    
    func creating(){
#if DEBUG
        debugPrint("SheetCompleteListIntent: \(self.sheetCompletevm.enteteCreationState) => creating")
#endif
        self.sheetCompletevm.enteteCreationState = .creating
    }
    
    func creatingError(error: Error){
#if DEBUG
        debugPrint("state: creating error")
#endif
        self.sheetCompletevm.enteteCreationState = .creatingError("\(error)")
    }
    
    func sheetCreated(){
#if DEBUG
        debugPrint("SearchIntent: sheet created => save data")
#endif
        DispatchQueue.main.async {
            self.sheetCompletevm.enteteCreationState = .created
        }
    }
    
    func intentToChange(nomRecette: String){
        self.state.send(.CHANGING_NOM(nomRecette))
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
    }
}
