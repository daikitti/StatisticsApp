//
//  MenuAssembly.swift
//  Statistics-App
//
//  Created by Havydope Diii on 12.09.2024.
//

import Foundation
import UIKit

class MenuAssembly {
    func makeVC() -> MenuView{
        let view = MenuView()
        _ = MenuController(menuView: view)
        
        return view
    }
}
