//
//  ChangeThemeCell.swift
//  Demo
//
//  Created by Gesen on 16/3/2.
//  Copyright © 2016年 Gesen. All rights reserved.
//

import UIKit

class ChangeThemeCell: BaseCell {
    
    @IBOutlet weak var changeTheme: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let titlePicker1 = ThemeColorPicker(colors: "#FFF", "#000", "#FFF", "#000")
        let titlePicker2 = ThemeColorPicker(colors: "#555", "#AAA", "#555", "#AAA")
        let backgroundPicker = ThemeColorPicker(colors: "#EB4F38", "#F4C600", "#56ABE4", "#ECF0F1")
        
        changeTheme.theme_setTitleColor(titlePicker1, forState: .normal)
        changeTheme.theme_setTitleColor(titlePicker2, forState: .highlighted)
        changeTheme.theme_backgroundColor = backgroundPicker
        changeTheme.layer.cornerRadius = 60
    }
    
    @IBAction func tapChange(_ sender: UIButton) {
        MyThemes.switchToNext()
    }
    
    

}
