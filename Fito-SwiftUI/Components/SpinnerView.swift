//
//  SpinnerView.swift
//  Fito-SwiftUI
//
//  Created by user234937 on 8/15/23.
//

import SwiftUI

struct SpinnerView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
            .scaleEffect(2.0) // Adjust the scale as needed
            .padding(25)
            .background(Color.black.opacity(0.2))
            .cornerRadius(20)
    }
}

struct SpinnerView_Previews: PreviewProvider {
    static var previews: some View {
        SpinnerView()
    }
}
