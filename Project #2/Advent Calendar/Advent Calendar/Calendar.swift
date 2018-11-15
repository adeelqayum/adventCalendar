//
//  Calendar.swift
//  Advent Calendar
//
//  Created by Adeel Qayum on 10/30/18.
//  Copyright © 2018 Adeel Qayum. All rights reserved.
//

import Foundation
import UIKit

struct Tile: Codable{
    var index: Int = 0
    var faceUp: Bool = true
    var label: String = ""
}


class Calendar: Codable {
    
    private let emojis = "🍏🍎🍐🍊🍋🍌🍉🍇🍓🍈🍒🍑🍍🥥🥝🍅🍆🥑🥦🥒🌶🌽🥕🥔🍠🥐🍞🥖🥨🧀🥚🍳🥞🥓🥩🍗🍖🌭🍔🍟🍕🥪🥙🌮🌯🥗🥘🥫🍝🍜🍲🍛🍣🍱🥟🍤🍙🍚🍘🍥🥠🍢🍡🍧🍨🍦🥧🍰🎂🍮🍭🍬🍫🍿🍩🍪🌰🥜🍯🥛🍼☕️🍵🥤🍶🍺🍻🥂🍷🥃🍸🍹🍾🥄🍴🍽🥣🥡🥢"
    
    var array = [Tile]()
    
    var testmode = false
    var selectedHoliday = NSLocalizedString("str_christmas", comment: "")
    
    func initGame(with numberOfTiles: Int) {
       
        var randomEmojisArray = [String]()
        
        for _ in stride(from: 0, to: numberOfTiles, by: 2) {
            let randomIndex = Int(arc4random_uniform(UInt32(emojis.count - 1)))
            let startSlice = emojis.index(emojis.startIndex, offsetBy: randomIndex)
            let endSlice = emojis.index(startSlice, offsetBy: 1)
            let slice = String(emojis[startSlice..<endSlice])
            
            randomEmojisArray.append(slice)
            randomEmojisArray.append(slice)
        }
        
        for i in 0..<numberOfTiles {
            let tile = Tile(index: i, faceUp: true, label: randomEmojisArray[i])
            array.append(tile)
        }
    }

    
    func isFaceUp(_ index: Int) -> Bool {
        return array[index].faceUp
    }
    
    func isFaceDown(_ index: Int) -> Bool {
        return !(array[index].faceUp)
    }
    
    func faceUpTiles() -> [Tile] {
        return array.filter { $0.faceUp == true }
    }
    
    func emoji(for index: Int) -> String? {
        guard index < array.count else { return nil }
        
        let tile = array[index]
        return !(tile.faceUp) ? tile.label : nil
    }
    
    func allTilesFaceDown() {
        for i in 0..<array.count {
            array[i].faceUp = true
        }
    }
    
    func toggleFaceUp(_ index: Int) {
        array[index].faceUp = !array[index].faceUp
    }
    
    
    
}
