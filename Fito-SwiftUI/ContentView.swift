//
//  ContentView.swift
//  Fito-SwiftUI
//
//  Created by user234937 on 8/11/23.
//

import SwiftUI

struct ContentView: View {
    @State var selectedPage: ProjectAction = .getStarted
    @State var isloggedin: Bool = false
    @AppStorage("currentUserEmail") var currentUserEmail = ""
    var body: some View {
        ZStack{
            NavigationStack{
                
                if(currentUserEmail != ""){
                    TabBarView()
                }else{
                    GetStartedView(actionPerformed: actionPerformed).navigationBarHidden(true)
                        .navigationBarBackButtonHidden(true)
                }
            }.navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
        }
    }
    
    func actionPerformed(action:ProjectAction){
        print("action performed",action)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
