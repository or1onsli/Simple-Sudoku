//
//  MenuVC.swift
//  Sudoku
//
//  Created by Fabio Cipriani on 24/10/16.
//  Copyright © 2016 Fabio Cipriani. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {
    
    // MARK: @IBOutlets
    @IBOutlet var dimensions: [Button]!
    @IBOutlet var levels: [Button]!
    @IBOutlet weak var beginBtn: Button!
    
    // MARK: Custom properties
    var timer = Timer()
    private var _dimSelected: String?
    var dimSelected: String? {
        get {
            return _dimSelected
        } set {
            _dimSelected = newValue
        }
    }
    private var _lvlSelected: Int?
    var lvlSelected: Int? {
        get {
            return _lvlSelected
        } set {
            _lvlSelected = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for dimension in dimensions {
            dimension.roundCornersAndDropShadow(cornerRadius: 15, shadowColor: UIColor.black.cgColor, shadowOpacity: 0.7, shadowOffset: .zero, shadowRadius: 5)
        }
        for level in levels {
            level.roundCornersAndDropShadow(cornerRadius: 15, shadowColor: UIColor.black.cgColor, shadowOpacity: 0.7, shadowOffset: .zero, shadowRadius: 5)
        }
        beginBtn.roundCornersAndDropShadow(cornerRadius: 15, shadowColor: UIColor.black.cgColor, shadowOpacity: 0.7, shadowOffset: .zero, shadowRadius: 5)
    }
    
    @IBAction func dimBtnPressed(_ sender: Button) {
        if sender.alpha != 1 {
            sender.alpha = 1
            dimSelected = nil
            timer.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
                self.bkg.isHidden = !self.bkg.isHidden
            })
        } else {
            for dimension in dimensions {
                dimension.alpha = 1
            }
            sender.alpha = 0.8
            
            if let dim = sender.titleLabel!.text {
                dimSelected = dim
            }
        }
    }
    
    @IBOutlet weak var bkg: UIImageView!
    @IBAction func lvlBtnPressed(_ sender: Button) {
        if sender.alpha != 1 {
            sender.alpha = 1
            lvlSelected = nil
        } else {
            for level in levels {
                level.alpha = 1
            }
            sender.alpha = 0.8
            if let lvl = sender.titleLabel!.text {
                switch lvl {
                case "Easy" :
                    lvlSelected = 0
                case "Medium" :
                    lvlSelected = 1
                case "Hard" :
                    lvlSelected = 2
                default:
                    lvlSelected = 1
                }
            }
        }
    }
    
    @IBAction func beginBtnPressed(_ sender: Button) {
        if let dim = dimSelected{
            if let lvl = lvlSelected {
                self.performSegue(withIdentifier: dim, sender: lvl)
            } else {
                self.performSegue(withIdentifier: dim, sender: 0)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dim = dimSelected {
            switch dim {
            case "4x4":
                if let destination = segue.destination as? twoTimesTwoVC {
                    if let lvl = sender as? Int {
                        destination.diffLvl = lvl
                    }
                }
            case "6x6":
                if let destination = segue.destination as? SixTimesSixVC {
                    if let lvl = sender as? Int {
                        destination.diffLvl = lvl
                    }
                }
            case "9x9":
                if let destination = segue.destination as? ThreeTimesThreeVC {
                    if let lvl = sender as? Int {
                        destination.diffLvl = lvl
                    }
                }
            default:
                break
            }
        }
    }
    
}
