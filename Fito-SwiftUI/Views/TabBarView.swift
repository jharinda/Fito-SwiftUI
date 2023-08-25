//
//  TabBarView.swift
//  Fito-SwiftUI
//
//  Created by user234937 on 8/15/23.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedIndex = 3
    var body: some View {
        TabView(selection: $selectedIndex) {
                    AddRecordView()
                        .tag(0)
                        .tabItem {
                            Label("", systemImage: "plus.circle.fill")
                        }.accessibilityIdentifier("addRecordButton")
                    
                    ViewRecordsView()
                        .tag(1)
                        .tabItem {
                            Label("", systemImage: "list.bullet.rectangle")
                        }.accessibilityIdentifier("viewRecordsButton")
                    
                    AnalysisView()
                        .tag(2)
                        .tabItem {
                            Label("", systemImage: "chart.bar.fill")
                        }.accessibilityIdentifier("analyzeDataButton")
                    
                    ProfileView()
                        .tag(3)
                        .tabItem {
                            Label("", systemImage: "person.crop.circle")
                        }.accessibilityIdentifier("viewProfileButton")
                }
        .accentColor(.orange)
        

    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
