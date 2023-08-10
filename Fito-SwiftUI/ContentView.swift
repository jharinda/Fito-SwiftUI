//
//  ContentView.swift
//  Fito-SwiftUI
//
//  Created by user234937 on 8/11/23.
//

import SwiftUI

struct ContentView: View {
    @State var selectedPage: ProjectAction = .getStarted
    var body: some View {
        switch selectedPage{
        case .getStarted:
            GetStartedView(actionPerformed: actionPerformed)
        case .login:
            LoginView(actionPerformed: actionPerformed)
        case .register:
            RegisterView(actionPerformed: actionPerformed)
        case .dashboard:
            RegisterView()
        }
       
    }
    
    func actionPerformed(action:ProjectAction){
        print("action performed",action)
        selectedPage = action
        /*switch action{
        case .login:
            print("login page")
            self.selectedPage = .login
        
        default:
            print("action invalid")
        }*/
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
