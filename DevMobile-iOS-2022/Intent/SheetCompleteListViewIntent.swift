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
    

    var description: String{
        switch self {
        case .ready                               : return "ready"
        case .loading(let s)                      : return "loading"
        case .loaded(let complete)                  : return "loaded: \(complete.count) comp sheets"
        case .loadingError(let error)             : return "loadingError: Error loading -> \(error)"
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
            debugPrint("SearchIntent: httpJsonLoaded -> success ")
            #endif
            sheetCompleteList.sheetListState = .loaded(result)
    }
    
    func httpJsonLoadedError(error: Error){
            #if DEBUG
            debugPrint("SearchIntent: httpJsonLoaded -> success ")
            #endif
            sheetCompleteList.sheetListState = .loadingError("\(error)")
    }
    func sheetsLoaded(){
        #if DEBUG
        debugPrint("SearchIntent: sheets loaded")
        #endif
        sheetCompleteList.sheetListState = .ready
    }

   
    func load(url : String){
        #if DEBUG
        debugPrint("SearchIntent: .loading(\(url))")
        #endif
        sheetCompleteList.sheetListState = .loading(url)
    }
    

}
