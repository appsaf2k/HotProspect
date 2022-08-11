//
//  Prospect.swift
//  HotProspect
//
//  Created by @andreev2k on 09.08.2022.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonimus"
    var emailAddress = ""
    fileprivate(set) var isContacted = false // не позволяет изменять извне
    
    // Challenge 3
    var date = Date()
}

@MainActor class Prospects: ObservableObject {
    @Environment(\.managedObjectContext) var moc
    @Published private(set) var people: [Prospect]
    
    static let saveKey = "SavedData"
    
    init() {
        self.people = []
        
        if let data = loadFile() {
            if let decoder = try? JSONDecoder().decode([Prospect].self, from: data) {
                self.people = decoder
                return
            }
        }
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(people) {
           // UserDefaults.standard.set(encoded, forKey: saveKey)
            
            saveFile(data: encoded)
        }
    }
    
    func addPerson(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
    // Challenge 2
    private func saveFile(data: Data) {
        let url = getDocumentDirectory().appendingPathComponent(Self.saveKey)

        do {
            try data.write(to: url, options: [.atomicWrite, .completeFileProtection])
        }
        catch let error {
            print("Could not write data: " + error.localizedDescription)
        }
    }
    
    // Challenge 2
    private func loadFile() -> Data? {
        let url = getDocumentDirectory().appendingPathComponent(Self.saveKey)
        if let data = try? Data(contentsOf: url) {
            return data
        }

        return nil
    }

    // Challenge 2
    private func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
