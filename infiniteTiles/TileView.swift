//
//  TileView.swift
//  infiniteTiles
//
//  Created by Kacper on 01/11/15.
//  Copyright © 2015 Kacper. All rights reserved.
//

import UIKit

class TileView: UIView {
    
    @IBOutlet weak var valueLabel: UILabel!
    
    var value = 1 {
        didSet {
            valueLabel.text = String(Int(pow(2, Double(value))))
            backgroundColor = AppColorPalette.instance.tile[(value-1)%12]
        }
    }
    
    class var nibName: String {
        return "TileView"
    }
    
    class func createView() -> TileView {
        return UINib(nibName: TileView.nibName, bundle: nil).instantiateWithOwner(nil, options: nil).first as! TileView
    }
    
    override func awakeFromNib() {
        valueLabel.text = String(Int(pow(2, Double(value))))
        backgroundColor = AppColorPalette.instance.tile[value-1]
        layer.borderColor = UIColor(white: 1, alpha: 0.5).CGColor
        layer.borderWidth = 1
    }
    
}
