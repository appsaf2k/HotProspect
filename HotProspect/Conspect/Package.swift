//
//  Package.swift
//  HotProspect
//
//  Created by @andreev2k on 09.08.2022.
//
/// Добавление зависимостей пакета Swift в Xcode



import SamplePackage // импортированный пакет
import SwiftUI

struct Package: View {
    let possible = Array(1...60)
    
    var body: some View {
        Text(result)
    }
    
    var result: String {
        let selected = possible.random(7)
        let strings = selected.map(String.init)
        return strings.joined(separator: ", ")
    }
}

struct Package_Previews: PreviewProvider {
    static var previews: some View {
        Package()
    }
}
