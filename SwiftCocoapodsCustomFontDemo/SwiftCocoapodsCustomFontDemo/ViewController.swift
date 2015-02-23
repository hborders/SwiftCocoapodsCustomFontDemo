//
//  ViewController.swift
//  SwiftCocoapodsCustomFontDemo
//
//  Created by Heath Borders on 2/23/15.
//  Copyright (c) 2015 Heath Borders. All rights reserved.
//

import UIKit
import SwiftCocoapodsCustomFont

class ViewController: UIViewController {

    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    @IBOutlet var customFontLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let customFont = CustomFont.helveticaNeueLtStdMdCn(size: 12)
        customFontLabel.font = customFont
    }
}

