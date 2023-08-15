//
//  TabBarView.swift
//  Fito-SwiftUI
//
//  Created by user234937 on 8/15/23.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedIndex = 0
    var body: some View {
        TabView(selection: $selectedIndex) {
                    FirstView()
                        .tag(0)
                        .tabItem {
                            Label("", systemImage: "plus.circle.fill")
                        }
                    
                    ViewRecordsView()
                        .tag(1)
                        .tabItem {
                            Label("", systemImage: "list.bullet.rectangle")
                        }
                    
                    ThirdView()
                        .tag(2)
                        .tabItem {
                            Label("", systemImage: "chart.bar.fill")
                        }
                    
                    ProfileView()
                        .tag(3)
                        .tabItem {
                            Label("", systemImage: "person.crop.circle")
                        }
                }
        .accentColor(.orange) // Set tab bar item color

    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}

struct FirstView: View {
    var body: some View {
        Text("First View")
            .background(Color.red)
            .navigationBarTitle("First", displayMode: .inline)
    }
}

struct SecondView: View {
    var body: some View {
        Text("Second View")
            .background(Color.green)
            .navigationBarTitle("Second", displayMode: .inline)
    }
}

struct ThirdView: View {
    var body: some View {
        Text("Third View")
            .background(Color.blue)
            .navigationBarTitle("Third", displayMode: .inline)
    }
}

struct FourthView: View {
    var body: some View {
        Text("Fourth View")
            .background(Color.purple)
            .navigationBarTitle("Fourth", displayMode: .inline)
    }
}
