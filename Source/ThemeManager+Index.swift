//
//  ThemeManager+Index.swift
//  SwiftTheme
//
//  Created by Gesen on 16/9/18.
//  Copyright © 2016年 Gesen. All rights reserved.
//

import UIKit

extension ThemeManager {
    
    public func colorForArray(_ array: [String]) -> UIColor? {
        guard let rgba = elementForArray(array) else { return nil }
        guard let color = try? UIColor(rgba_throws: rgba as String) else {
            print("SwiftTheme WARNING: Not convert rgba \(rgba) in array: \(array)[\(currentThemeIndex)]")
            return nil
        }
        return color
    }
    
    public func imageForArray(_ array: [String]) -> UIImage? {
        guard let imageName = elementForArray(array) else { return nil }
        guard let image = UIImage(named: imageName as String) else {
            print("SwiftTheme WARNING: Not found image name '\(imageName)' in array: \(array)[\(currentThemeIndex)]")
            return nil
        }
        return image
    }
    
    public func elementForArray<T>(_ array: [T]) -> T? {
        let index = currentThemeIndex
        guard  array.indices ~= index else {
            print("SwiftTheme WARNING: Not found element in array: \(array)[\(currentThemeIndex)]")
            return nil
        }
        return array[index]
    }
    
}
