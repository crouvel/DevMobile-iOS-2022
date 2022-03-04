//
//  TrackIntent.swift
//  Test_Cours_listUI
//
//  Created by m1 on 16/02/2022.
//

import Foundation
import Combine

enum IngredientIntentState: Equatable, CustomStringConvertible {
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

class IngredientIntent: ObservableObject {
    private var state = PassthroughSubject<IngredientIntentState, Never>()
    
    var ingredientvm : IngredientViewModel
    
    init(vm: IngredientViewModel){
        self.ingredientvm = vm
    }
    
    func deleted(){
#if DEBUG
        debugPrint("DeleteIntent: \(self.ingredientvm.deletionState) => deleted")
#endif
        self.ingredientvm.deletionState = .ready
    }
    
    func deleting(s: String){
#if DEBUG
        debugPrint("DeleteIntent: \(self.ingredientvm.deletionState) => deleting")
#endif
        self.ingredientvm.deletionState = .deleting(s)
    }
    
    func deletingError(error: Error){
#if DEBUG
        debugPrint("state: deleting error")
#endif
        self.ingredientvm.deletionState = .deletingError("\(error)")
    }
    func ingredientDeleted(){
#if DEBUG
        debugPrint("SearchIntent: editor deleted => save data")
#endif
        DispatchQueue.main.async {
            self.ingredientvm.deletionState = .deleted
        }
    }
    
    func created(){
#if DEBUG
        debugPrint("SheetCompleteListIntent: \(self.ingredientvm.creationIngredientState) => created")
#endif
        self.ingredientvm.creationIngredientState = .ready
    }
    
    func creating(){
#if DEBUG
        debugPrint("SheetCompleteListIntent: \(self.ingredientvm.creationIngredientState) => creating")
#endif
        self.ingredientvm.creationIngredientState = .creating
    }
    
    func creatingError(error: Error){
#if DEBUG
        debugPrint("state: creating error")
#endif
        self.ingredientvm.creationIngredientState = .creatingError("\(error)")
    }
    
    func ingredientCreated(){
#if DEBUG
        debugPrint("SearchIntent: sheet created => save data")
#endif
        DispatchQueue.main.async {
            self.ingredientvm.creationIngredientState = .created
        }
    }
    
    func intentToChange(artistName: String){
        /*self.state.send(.CHANGING_ARTISTNAME(artistName))*/
        self.state.send(.LIST_UPDATED)
    }
    
    func addObserver(vm: IngredientViewModel){
        self.state.subscribe(vm)
    }
}
