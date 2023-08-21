//
//  HideKeyboard.swift
//  Fito-SwiftUI
//
//  Created by Roshel Rao on 2023-08-21.
//

import Foundation
import UIKit

func hideKeyboard(){
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}
