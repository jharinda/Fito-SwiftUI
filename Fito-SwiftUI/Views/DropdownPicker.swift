//
//  DropdownPicker.swift
//  Fito-SwiftUI
//
//  Created by user235431 on 8/14/23.
//

import SwiftUI

struct DropdownPicker<T>: View where T: Hashable, T: CustomStringConvertible {
    var title: String
    @Binding var selection: T?
    var options: [T]
    var displayKeyPath: KeyPath<T, String> // To display the options in the picker

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
            Picker("", selection: $selection) {
                ForEach(options, id: \.self) { option in
                    Text(option[keyPath: displayKeyPath]).tag(option)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .font(.custom("Poppins-SemiBold", size: 15))
        }
        .padding(.vertical, 0)
        .padding(.horizontal, 40)
    }
}
