//
//  Sudoku.swift
//  Sudoku
//
//  Created by Andrea Vultaggio on 25/10/2016.
//  Copyright © 2016 Fabio Cipriani. All rights reserved.
//

import Foundation

struct sudoku {
    var board: [[Int]]
    var boardFilled: [[Int]]
    let size:Int
    var rowLockFlag = false
    
    init(size: Int){
        self.size = size
        let row = Array(repeating: 0, count: size)
        board = Array(repeating: row, count: size)
        boardFilled = board
    }
    
    func description(_ solved: Bool) -> [[String]] {
        let matrix = solved ? boardFilled : board
        //commento
        let row = Array(repeating: "", count: size)
        var retString = Array(repeating: row, count: size)
        
        for i in 0...size-1 {
            for j in 0...size-1 {
                let value = matrix[i][j]
                if value == 0 {
                    retString[i][j] = " "
                }
                else{
                   retString[i][j] = "\(value)"
                }
            }
        }
        
        return retString
    }
    
    func extract(index: Int, isARow: Bool) -> String {
        var ret = ""
        for i in 0...size-1 {
            if isARow {
                ret += "\(board[index][i])"
            } else {
                ret += "\(board[i][index])"
            }
        }
        return ret
    }
    
    func extractRect(row: Int, column: Int) -> String {
        var ret = ""
        let verticalDim = Int(sqrt(Double(size))) //size / 2 //##
        let horizontalDim = size / verticalDim
        let startColumn = (column/horizontalDim)*horizontalDim
        let startRow = (row/verticalDim)*verticalDim
        for i in 0...verticalDim-1 {
            for j in 0...horizontalDim-1 {
                ret += "\(board[i+startRow][j+startColumn])"
            }
        }
        return ret
    }
    
    func valueIsOK(_ value: Int, row: Int, column: Int) -> Bool {
        let rowString = extract(index: row, isARow: true)
        let columnString = extract(index: column, isARow: false)
        let rectString = extractRect(row: row, column: column)
        let rowOk = rowString.range(of: String(value)) == nil
        let columnOk = columnString.range(of: String(value)) == nil
        let rectOK = rectString.range(of: String(value)) == nil
        return rowOk && columnOk && rectOK
    }
    
    func possibleValues(row: Int, column: Int) -> String {
        var ret = ""
        for i in 1...size {
            if valueIsOK(i, row: row, column: column) {
                ret += String(i)
            }
        }
        return ret
    }
    
    mutating func fillAValue(row: Int, column: Int) -> Bool{
        let values = possibleValues(row: row, column: column)
        if values.isEmpty {
            return false
        } else {
            let charPosition = Int(arc4random_uniform(UInt32(values.characters.count)))
            let char = values[values.index(values.startIndex, offsetBy: charPosition)...values.index(values.startIndex, offsetBy: charPosition)]
            board[row][column] = Int(String(char))!
            return true
        }
    }
    
    mutating func fillIn(){
        var row = 0, column = 0
        while (row < size) {
            if fillAValue(row: row, column: column) { // go on the next box
                column += 1
                if (column == size) {
                    column = 0
                    row += 1
                }
            } else {                                  // return on the previous box
                board[row][column] = 0
                
                column = 0  //##
                //column -= 1
                for cl in 0..<size {
                    board[row][cl] = 0
                }
                
                if rowLockFlag {
                    row -= 1
                    if (row < 0) {
                        row = 0
                    }
                    
                    rowLockFlag = false //##
                }else{
                    rowLockFlag = true //##
                }
            }
        }
    }
    
    
    func solved() -> [[String]] {
        return description(true)
    }
    
    func toBeSolved() -> [[String]] {
        return description(false)
    }
    
    mutating func eraseMost(_ level:Int){
        boardFilled = board
        let loops = (level == 0) ? size*size : level
        for _ in 0...loops {
            let r = Int(arc4random_uniform(UInt32(size)))
            let c = Int(arc4random_uniform(UInt32(size)))
            let buffer = board[r][c]
            board[r][c] = 0
            let values = possibleValues(row: r, column: c)
            if values.characters.count != 1 {
                board[r][c] = buffer
            }
        }
    }
    
}

