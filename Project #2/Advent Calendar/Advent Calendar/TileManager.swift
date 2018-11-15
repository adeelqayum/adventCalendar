//
//  TileManager.swift
//  Advent Calendar
//
//  Created by Adeel Qayum on 10/30/18.
//  Copyright © 2018 Adeel Qayum. All rights reserved.
//

import Foundation
import UIKit

struct Tile {
    var index = 0
    var faceUp = false
}

class TileManager {
    
    var tilesArray = [Tile]()
    
    //give each tile an index number and add it to the array
    func initCalendar (with numberofTiles: Int) {
        
            for i in 0..<numberofTiles {
                let tile = Tile(index: i, faceUp: false)
                tilesArray.append(tile)
            }
        
    }
    
    //check if a tile is faceup
    func isFaceUp (_ index: Int) -> Bool {
        return tilesArray[index].faceUp
    }
    
    //reset all tiles to be face down
    func allTilesFaceDown() {
        for i in 0..<tilesArray.count {
            tilesArray[i].faceUp = false
        }
    }
    
}
