//
//  SwipeAction.swift
//  HotProspect
//
//  Created by @andreev2k on 09.08.2022.
//
/// Добавление действий по свайпам строк



import SwiftUI

struct SwipeAction: View {
    var body: some View {
        List {
            Text("Hello, World!")
                .swipeActions {
                    Button {
                        print("Hi")
                    } label: {
                        Label("Send Message", systemImage: "message")
                    }
                }
                .swipeActions(edge: .leading) {
                    Button {
                        print("Pinning")
                    } label: {
                        Label("Pin", systemImage: "pin")
                    }
                    .tint(.orange)

                }
        }
    }
}

struct SwipeAction_Previews: PreviewProvider {
    static var previews: some View {
        SwipeAction()
    }
}
