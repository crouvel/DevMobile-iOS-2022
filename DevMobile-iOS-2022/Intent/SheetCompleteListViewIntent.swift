//
//  TracksIntent.swift
//  Test_Cours_listUI
//
//  Created by m1 on 19/02/2022.
//

import Foundation

enum SheetCompleteListState : CustomStringConvertible{
    case ready
    case loading(String)
    case loaded([SheetCompleteDTO])
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

class SheetCompleteListViewIntent{
    
    var sheetCompleteList : SheetCompleteListViewModel
    
    init(list: SheetCompleteListViewModel){
        self.sheetCompleteList = list
    }
        
    func loaded(sheets: [SheetComplete]){
        #if DEBUG
        debugPrint("SheetCompleteListIntent: \(self.sheetCompleteList.sheetListState) => \(sheets.count) editors loaded")
        #endif
        self.sheetCompleteList.sheetListState = .ready
    }
    
    func httpJsonLoaded(result: [SheetCompleteDTO]){
            #if DEBUG
            debugPrint("SearchIntent: httpJsonLoaded -> success -> .loaded(editors)")
            #endif
            sheetCompleteList.sheetListState = .loaded(result)
    }
    
    func httpJsonLoadedError(error: Error){
            #if DEBUG
            debugPrint("SearchIntent: httpJsonLoaded -> success -> .loaded(editors)")
            #endif
            sheetCompleteList.sheetListState = .loadingError("\(error)")
    }
    func editeurLoaded(){
        #if DEBUG
        debugPrint("SearchIntent: editor deleted => save data")
        #endif
        sheetCompleteList.sheetListState = .ready
    }

   
    func loadEditeurs(url : String){
        #if DEBUG
        debugPrint("SearchIntent: .loading(\(url))")
        debugPrint("SearchIntent: asyncLoadEditors")
        #endif
        sheetCompleteList.sheetListState = .loading(url)
    }
    

}
