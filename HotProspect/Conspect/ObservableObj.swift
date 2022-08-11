//
//  ObservableObj.swift
//  HotProspect
//
//  Created by @andreev2k on 09.08.2022.
//
/// Ручная публикация изменений ObservableObject



import SwiftUI

@MainActor class DelayedUpdater: ObservableObject {
    var value = 0 {
        willSet {
            objectWillChange.send()
        }
    }
    
    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}

struct ObservableObj: View {
    @StateObject private var delayedUpdater = DelayedUpdater()
    var body: some View {
        Text("Time is \(delayedUpdater.value)")
    }
}

struct ObservableObj_Previews: PreviewProvider {
    static var previews: some View {
        ObservableObj()
    }
}
