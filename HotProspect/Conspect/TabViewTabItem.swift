//
//  TabViewTabItem.swift
//  HotProspect
//
//  Created by @andreev2k on 09.08.2022.
//
/// Создание вкладок с помощью TabView и TabItem ()
/// Работа с .tag


import SwiftUI

struct TabViewTabItem: View {
    @State private var selectTabView = "One"
    
    var body: some View {
        TabView(selection: $selectTabView) {
            Text("Tab 1")
                .onTapGesture {
                    selectTabView = "two"
                }
                .tabItem {
                    Label("Tab 1", systemImage: "star")
                }
                .tag("one")
            
            Text("Tab 2")
                .onTapGesture {
                    selectTabView = "one"
                }
                .tabItem {
                    Label("Tab 2", systemImage: "person")
                }
                .tag("two")
        }
    }
}

struct TabViewTabItem_Previews: PreviewProvider {
    static var previews: some View {
        TabViewTabItem()
    }
}
