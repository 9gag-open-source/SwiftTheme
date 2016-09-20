//
//  ThemePicker.swift
//  SwiftTheme
//
//  Created by Gesen on 16/1/25.
//  Copyright © 2016年 Gesen. All rights reserved.
//

import UIKit

open class ThemePicker: NSObject, NSCopying {
    
    public typealias ValueType = () -> Any?
    
    var value: ValueType
    
    required public init(v: @escaping ValueType) {
        value = v
    }
    
    open func copy(with zone: NSZone?) -> Any {
        return type(of: self).init(v: value)
    }
    
}

open class ThemeColorPicker: ThemePicker {
    
    public convenience init(themeManager: ThemeManager, keyPath: String) {
        self.init(v: { return themeManager.colorForKeyPath(keyPath) })
    }

    public convenience init(themeManager: ThemeManager, colors: String...) {
        self.init(v: { return themeManager.colorForArray(colors) })
    }
    
    open class func pickerWithKeyPath(themeManager: ThemeManager, keyPath: String) -> ThemeColorPicker {
        return ThemeColorPicker(themeManager: themeManager, keyPath: keyPath)
    }
    
    open class func pickerWithColors(themeManager: ThemeManager, colors: [String]) -> ThemeColorPicker {
        return ThemeColorPicker(v: { return themeManager.colorForArray(colors) })
    }
    
}

open class ThemeImagePicker: ThemePicker {
    
    public convenience init(themeManager: ThemeManager, keyPath: String) {
        self.init(v: { return themeManager.imageForKeyPath(keyPath) })
    }
    
    public convenience init(themeManager: ThemeManager, names: String...) {
        self.init(v: { return themeManager.imageForArray(names) })
    }
    
    public convenience init(themeManager: ThemeManager, images: UIImage...) {
        self.init(v: { return themeManager.elementForArray(images) })
    }
    
    open class func pickerWithKeyPath(themeManager: ThemeManager, keyPath: String) -> ThemeImagePicker {
        return ThemeImagePicker(themeManager: themeManager, keyPath: keyPath)
    }
    
    open class func pickerWithNames(themeManager: ThemeManager, names: [String]) -> ThemeImagePicker {
        return ThemeImagePicker(v: { return themeManager.imageForArray(names) })
    }
    
    open class func pickerWithImages(themeManager: ThemeManager, images: [UIImage]) -> ThemeImagePicker {
        return ThemeImagePicker(v: { return themeManager.elementForArray(images) })
    }
    
}

open class ThemeCGFloatPicker: ThemePicker {
    
    public convenience init(themeManager: ThemeManager, keyPath: String) {
        self.init(v: { return CGFloat(themeManager.numberForKeyPath(keyPath) ?? 0) })
    }
    
    public convenience init(themeManager: ThemeManager, floats: CGFloat...) {
        self.init(v: { return themeManager.elementForArray(floats) })
    }
    
    open class func pickerWithKeyPath(themeManager: ThemeManager, keyPath: String) -> ThemeCGFloatPicker {
        return ThemeCGFloatPicker(themeManager: themeManager, keyPath: keyPath)
    }
    
    open class func pickerWithFloats(themeManager: ThemeManager, floats: [CGFloat]) -> ThemeCGFloatPicker {
        return ThemeCGFloatPicker(v: { return themeManager.elementForArray(floats) })
    }
    
}

open class ThemeCGColorPicker: ThemePicker {
    

    public convenience init(themeManager: ThemeManager, keyPath: String) {
        self.init(v: { return themeManager.colorForKeyPath(keyPath)?.cgColor })
    }
    
    public convenience init(themeManager: ThemeManager, colors: String...) {
        self.init(v: { return themeManager.colorForArray(colors)?.cgColor })
    }
    
    open func pickerWithKeyPath(themeManager: ThemeManager, keyPath: String) -> ThemeCGColorPicker {
        return ThemeCGColorPicker(themeManager: themeManager, keyPath: keyPath)
    }
    
    open func pickerWithColors(themeManager: ThemeManager, colors: [String]) -> ThemeCGColorPicker {
        return ThemeCGColorPicker(v: { return themeManager.colorForArray(colors)?.cgColor })

    }
    
}

open class ThemeDictionaryPicker: ThemePicker {
    
    public convenience init(themeManager: ThemeManager, dicts: [String: AnyObject]...) {
        self.init(v: { return themeManager.elementForArray(dicts) })
    }
    
    open class func pickerWithDicts(themeManager: ThemeManager,  dicts: [[String: AnyObject]]) -> ThemeDictionaryPicker {
        return ThemeDictionaryPicker(v: { return themeManager.elementForArray(dicts) })
    }
    
}

open class ThemeStatusBarStylePicker: ThemePicker {
    
    var styles: [UIStatusBarStyle]?
    var animated = true
    var themeManager: ThemeManager!
    
    public convenience init(themeManager: ThemeManager, keyPath: String) {
        self.init(v: { return themeManager.stringForKeyPath(keyPath) })
        self.themeManager = themeManager
    }
    
    public convenience init(themeManager: ThemeManager, styles: UIStatusBarStyle...) {
        self.init(v: { return 0 })
        self.styles = styles
        self.themeManager = themeManager
    }
    
    open class func pickerWithKeyPath(themeManager: ThemeManager, keyPath: String) -> ThemeStatusBarStylePicker {
        return ThemeStatusBarStylePicker(themeManager: themeManager, keyPath: keyPath)
    }
    
    open class func pickerWithStyles(_ styles: [UIStatusBarStyle]) -> ThemeStatusBarStylePicker {
        let picker = ThemeStatusBarStylePicker(v: { return 0 })
        picker.styles = styles
        return picker
    }
    
    open class func pickerWithStringStyles(themeManager: ThemeManager, styles: [String]) -> ThemeStatusBarStylePicker {
        return ThemeStatusBarStylePicker(v: { return themeManager.elementForArray(styles) })
    }
    
    func currentStyle(_ value: AnyObject?) -> UIStatusBarStyle {
        if let styles = styles {
            if styles.indices ~= themeManager.currentThemeIndex {
                return styles[themeManager.currentThemeIndex]
            }
        }
        if let styleString = value as? String {
            switch styleString {
            case "UIStatusBarStyleDefault"      : return .default
            case "UIStatusBarStyleLightContent" : return .lightContent
            default: break
            }
        }
        return .default
    }
    
}

class ThemeStatePicker: ThemePicker {
    
    typealias ValuesType = [UInt: ThemePicker]
    
    var values = ValuesType()
    
    convenience init?(picker: ThemePicker?, withState state: UIControlState) {
        guard let picker = picker else { return nil}
        
        self.init(v: { return 0 })
        values[state.rawValue] = picker
    }
    
    func setPicker(_ picker: ThemePicker?, forState state: UIControlState) -> Self {
        values[state.rawValue] = picker
        return self
    }
}
