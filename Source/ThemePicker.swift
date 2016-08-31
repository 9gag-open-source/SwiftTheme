//
//  ThemePicker.swift
//  SwiftTheme
//
//  Created by Gesen on 16/1/25.
//  Copyright © 2016年 Gesen. All rights reserved.
//

import UIKit

public class ThemePicker: NSObject, NSCopying {
    
    public typealias ValueType = () -> AnyObject?
    
    var value: ValueType
    
    required public init(v: ValueType) {
        value = v
    }
    
    public func copyWithZone(zone: NSZone) -> AnyObject {
        return self.dynamicType.init(v: value)
    }
    
}

public class ThemeColorPicker: ThemePicker {
    
    public convenience init(themeManager: ThemeManager, keyPath: String) {
        self.init(v: { return themeManager.colorForKeyPath(keyPath) })
    }

    public convenience init(themeManager: ThemeManager, colors: String...) {
        self.init(v: { return themeManager.colorForArray(colors) })
    }
    
    public class func pickerWithKeyPath(themeManager: ThemeManager, keyPath: String) -> ThemeColorPicker {
        return ThemeColorPicker(themeManager: themeManager, keyPath: keyPath)
    }
    
    public class func pickerWithColors(themeManager: ThemeManager, colors: [String]) -> ThemeColorPicker {
        return ThemeColorPicker(v: { return themeManager.colorForArray(colors) })
    }
    
}

public class ThemeImagePicker: ThemePicker {
    
    public convenience init(themeManager: ThemeManager, keyPath: String) {
        self.init(v: { return themeManager.imageForKeyPath(keyPath) })
    }
    
    public convenience init(themeManager: ThemeManager, names: String...) {
        self.init(v: { return themeManager.imageForArray(names) })
    }
    
    public convenience init(themeManager: ThemeManager, images: UIImage...) {
        self.init(v: { return themeManager.elementForArray(images) })
    }
    
    public class func pickerWithKeyPath(themeManager: ThemeManager, keyPath: String) -> ThemeImagePicker {
        return ThemeImagePicker(themeManager: themeManager, keyPath: keyPath)
    }
    
    public class func pickerWithNames(themeManager: ThemeManager, names: [String]) -> ThemeImagePicker {
        return ThemeImagePicker(v: { return themeManager.imageForArray(names) })
    }
    
    public class func pickerWithImages(themeManager: ThemeManager, images: [UIImage]) -> ThemeImagePicker {
        return ThemeImagePicker(v: { return themeManager.elementForArray(images) })
    }
    
}

public class ThemeCGFloatPicker: ThemePicker {
    
    public convenience init(themeManager: ThemeManager, keyPath: String) {
        self.init(v: { return CGFloat(themeManager.numberForKeyPath(keyPath) ?? 0) })
    }
    
    public convenience init(themeManager: ThemeManager, floats: CGFloat...) {
        self.init(v: { return themeManager.elementForArray(floats) })
    }
    
    public class func pickerWithKeyPath(themeManager: ThemeManager, keyPath: String) -> ThemeCGFloatPicker {
        return ThemeCGFloatPicker(themeManager: themeManager, keyPath: keyPath)
    }
    
    public class func pickerWithFloats(themeManager: ThemeManager, floats: [CGFloat]) -> ThemeCGFloatPicker {
        return ThemeCGFloatPicker(v: { return themeManager.elementForArray(floats) })
    }
    
}

public class ThemeCGColorPicker: ThemePicker {
    
    public convenience init(themeManager: ThemeManager, keyPath: String) {
        self.init(v: { return themeManager.colorForKeyPath(keyPath)?.CGColor })
    }
    
    public convenience init(themeManager: ThemeManager, colors: String...) {
        self.init(v: { return themeManager.colorForArray(colors)?.CGColor })
    }
    
    public class func pickerWithKeyPath(themeManager: ThemeManager, keyPath: String) -> ThemeCGColorPicker {
        return ThemeCGColorPicker(themeManager: themeManager, keyPath: keyPath)
    }
    
    public class func pickerWithColors(themeManager: ThemeManager, colors: [String]) -> ThemeCGColorPicker {
        return ThemeCGColorPicker(v: { return themeManager.colorForArray(colors)?.CGColor })
    }
    
}

public class ThemeDictionaryPicker: ThemePicker {
    
    public convenience init(themeManager: ThemeManager, dicts: [String: AnyObject]...) {
        self.init(v: { return themeManager.elementForArray(dicts) })
    }
    
    public class func pickerWithDicts(themeManager: ThemeManager, dicts: [[String: AnyObject]]) -> ThemeDictionaryPicker {
        return ThemeDictionaryPicker(v: { return themeManager.elementForArray(dicts) })
    }
    
}

public class ThemeStatusBarStylePicker: ThemePicker {
    
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
    
    public class func pickerWithKeyPath(themeManager: ThemeManager, keyPath: String) -> ThemeStatusBarStylePicker {
        return ThemeStatusBarStylePicker(themeManager: themeManager, keyPath: keyPath)
    }
    
    public class func pickerWithStyles(styles: [UIStatusBarStyle]) -> ThemeStatusBarStylePicker {
        let picker = ThemeStatusBarStylePicker(v: { return 0 })
        picker.styles = styles
        return picker
    }
    
    public class func pickerWithStringStyles(themeManager: ThemeManager, styles: [String]) -> ThemeStatusBarStylePicker {
        return ThemeStatusBarStylePicker(v: { return themeManager.elementForArray(styles) })
    }
    
    func currentStyle(value: AnyObject?) -> UIStatusBarStyle {
        if let styles = styles {
            if styles.indices ~= themeManager.currentThemeIndex {
                return styles[themeManager.currentThemeIndex]
            }
        }
        if let styleString = value as? String {
            switch styleString {
            case "UIStatusBarStyleDefault"      : return .Default
            case "UIStatusBarStyleLightContent" : return .LightContent
            default: break
            }
        }
        return .Default
    }
    
}

class ThemeStatePicker: ThemePicker {
    
    typealias ValuesType = [UInt: ThemePicker]
    
    var values = ValuesType()
    
    convenience init?(picker: ThemePicker?, withState state: UIControlState) {
        guard let picker = picker else { return nil}
        
        self.init(v: { return 0 })
        self.setPicker(picker, forState: state)
    }
    
    func setPicker(picker: ThemePicker?, forState state: UIControlState) -> Self {
        values[state.rawValue] = picker
        return self
    }
}
