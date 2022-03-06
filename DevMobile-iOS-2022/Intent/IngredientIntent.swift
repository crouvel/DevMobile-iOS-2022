//
//  TrackIntent.swift
//  Test_Cours_listUI
//
//  Created by m1 on 16/02/2022.
//

import Foundation
import Combine

enum IngredientIntentState: Equatable, CustomStringConvertible {
    
    case READY
    case CHANGING_LIBELLE(String)
    case CHANGING_CATEGORIE(Int)
    case CHANGING_PRIX(Float)
    case CHANGING_QTE(Float?)
    case LIST_UPDATED
    
    var description: String {
        switch self {
        case .READY:
            return "Ready"
        case .CHANGING_LIBELLE(let libelle):
            return "Changing libelle to \(libelle)"
        case .CHANGING_CATEGORIE(let categorie):
            return "Changing categorie to \(categorie)"
        case .CHANGING_PRIX(let prix):
            return "Changing prix to \(prix)"
        case .CHANGING_QTE(let qte):
            return "Changing quantité to \(qte)"
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
    
    func intentToChange(libelle: String){
        self.state.send(.CHANGING_LIBELLE(libelle))
        self.state.send(.LIST_UPDATED)
    }
    
    func intentToChange(categorie: Int){
        self.state.send(.CHANGING_CATEGORIE(categorie))
        self.state.send(.LIST_UPDATED)
    }
    
    func intentToChange(prix: Float){
        self.state.send(.CHANGING_PRIX(prix))
        self.state.send(.LIST_UPDATED)
    }
    
    func intentToChange(qte: Float?){
        self.state.send(.CHANGING_QTE(qte))
        self.state.send(.LIST_UPDATED)
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
    
    func addObserver(vm: IngredientViewModel){
        self.state.subscribe(vm)
    }
}
