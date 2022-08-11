//
//  ContextMenus.swift
//  HotProspect
//
//  Created by @andreev2k on 09.08.2022.
//
/// Создание контекстных меню



import SwiftUI

struct ContextMenus: View {
    @State private var backgroundColor = Color.gray
    @State var text = "asasasdasdadasdasdasasdadasdasdadasdasdasdasdasdasdas"
    var body: some View {
        VStack {
            Text("Hello World!")
                .padding()
                .background(backgroundColor)
            
            Text("Change Color")
                .padding()
                .contextMenu {
                    Button() {
                        backgroundColor = .red
                    } label: {
                        Text(text)
                        Text(text)
                        Image("alienYellow_hurt")
                       // Label("Red", systemImage: "checkmark.circle.fill")
                    }
                    Button(role: .destructive) {
                        backgroundColor = .green
                    } label: {
                        Label("Green", systemImage: "checkmark.circle.fill")
                    }
                    Button("Blue") {
                        backgroundColor = .blue
                    }
                }
        }
    }
}

struct ContextMenus_Previews: PreviewProvider {
    static var previews: some View {
        ContextMenus()
    }
}
