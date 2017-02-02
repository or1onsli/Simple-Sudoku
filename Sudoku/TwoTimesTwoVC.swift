//
//  ViewController.swift
//  Sudoku
//
//  Created by Fabio Cipriani on 19/10/16.
//  Copyright © 2016 Fabio Cipriani. All rights reserved.
//

import UIKit

class twoTimesTwoVC: UIViewController {
    
    // MARK: @IBOutlets
    @IBOutlet var cells: [Button]!
    @IBOutlet weak var checkBtn: Button!
    
    var diffLvl = 0
    var game = sudoku.init(size: 4)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for cell in cells {
            cell.roundCornersAndDropShadow(cornerRadius: 15, shadowColor: UIColor.black.cgColor, shadowOpacity: 0.7, shadowOffset: .zero, shadowRadius: 5)
        }
        checkBtn.roundCornersAndDropShadow(cornerRadius: 15, shadowColor: UIColor.black.cgColor, shadowOpacity: 0.7, shadowOffset: .zero, shadowRadius: 5)
        
        game.fillIn()
        let level = 0 // max level
        game.eraseMost(level)
        let board = game.description(false)
        var data = [String]()
        
        for i in 0...3 {
            for j in 0...3 {
                data.append(board[i][j])
            }
        }
        
        print(data)
        for x in data.indices {
            if data[x] != " " {
                cells[x].isUserInteractionEnabled = false
            }
            cells[x].setTitle(data[x], for: .normal)
        }
        
//        labelRisultato.text = s.description(false)
//        show = false
//        showSolutionButton.isEnabled = true
//        showSolutionButton.setTitle(show ? "Hide Solution" : "Show Solution", for: UIControlState.normal)
        
    }
    
    // MARK: @IBActions
    @IBAction func cellPressed(_ sender: Button) {
        if let val = sender.titleLabel!.text?.integerValue {
            if val < 4 {
                sender.setTitle("\(val+1)", for: .normal)
                
            } else {
                sender.setTitle("1", for: .normal)
            }
        }
        else{
            sender.setTitle("1", for: .normal)
        }
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func checkBtnPressed(_ sender: Button) {
        //Check if the inserted values complete correctly the sudoku
    }
}

// MARK: String Extension
private extension String {
    struct Formatter {
        static let instance = NumberFormatter()
    }
    var doubleValue:Double? {
        return Formatter.instance.number(from: self)?.doubleValue
    }
    var integerValue:Int? {
        return Formatter.instance.number(from: self)?.intValue
    }
}
