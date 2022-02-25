//
//  TracksIntent.swift
//  Test_Cours_listUI
//
//  Created by m1 on 19/02/2022.
//

import Foundation

enum SheetListState : CustomStringConvertible{
    case ready
    case loading(String)
    case loaded([SheetIncompleteDTO])
    case loadingError(String)
    //case newEditeurs([EditeurViewModel])

    var description: String{
        switch self {
        case .ready                               : return "ready"
        case .loading(let s)                      : return "loading"
        case .loaded(let editeurs)                  : return "loaded: \(editeurs.count) incomplete sheets"
        case .loadingError(let error)             : return "loadingError: Error loading -> \(error)"
        //case .newEditeurs(let editeurs)               : return "newJeu: reset game list with \(editeurs.count) editors"
        }
    }
    
}

class SheetListViewIntent{
    
    var sheetincompleteList: SheetIncompleteListViewModel
    
    init(list: SheetIncompleteListViewModel){
        self.sheetincompleteList = list
    }
        
    func loaded(sheets: [SheetIncomplete]){
        #if DEBUG
        debugPrint("SearchIntent: \(self.sheetincompleteList.sheetListState) => \(sheets.count) editors loaded")
        #endif
        self.sheetincompleteList.sheetListState = .ready
    }
    
    func httpJsonLoaded(results: [SheetIncompleteDTO]){
            #if DEBUG
            debugPrint("SearchIntent: httpJsonLoaded -> success -> .loaded(editors)")
            #endif
            sheetincompleteList.sheetListState = .loaded(results)
            /*}else{
                sheetincompleteList.sheetListState = .loadingError("\(error)")
            }*/
    }

func httpJsonLoadedError(error: Error){       
            sheetincompleteList.sheetListState = .loadingError("\(error)")
}

    func editeurLoaded(){
        #if DEBUG
        debugPrint("SearchIntent: editor deleted => save data")
        #endif
        sheetincompleteList.sheetListState = .ready
    }

    //var editeurFilter : String? = nil

    func loadEditeurs(url : String/*, editeurFilter: String?*/){
        //self.editeurFilter = editeurFilter
        #if DEBUG
        debugPrint("SearchIntent: .loading(\(url))")
        debugPrint("SearchIntent: asyncLoadEditors")
        #endif
        sheetincompleteList.sheetListState = .loading(url)
    }
    

}
