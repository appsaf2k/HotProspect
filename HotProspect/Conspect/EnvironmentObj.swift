//
//  EnvironmentObj.swift
//  HotProspect
//
//  Created by @andreev2k on 09.08.2022.
//
/// Чтение пользовательских значений из среды с помощью @EnvironmentObject



import SwiftUI

@MainActor class User: ObservableObject {
    @Published var name = "Taylor Swift"
}

struct EditView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        TextField("Name", text: $user.name)
    }
}

struct DisplayView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        Text(user.name)
    }
}

struct EnvironmentObj: View {
    @StateObject var user = User()
    
    var body: some View {
        VStack {
            EditView()
            DisplayView()
        } .environmentObject(user)
    }
}

struct EnvironmentObj_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentObj()
    }
}
