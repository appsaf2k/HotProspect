//
//  ProspectsView.swift
//  HotProspect
//
//  Created by @andreev2k on 09.08.2022.
//

import CodeScanner
import SwiftUI
import UserNotifications


enum filterType {
    case none, contacted, uncontacted
}

// Challenge 3
enum SortType {
    case name, recent, isContacted
}


struct ProspectsView: View {
    @EnvironmentObject var prospects: Prospects
    @State private var isShowScanner = false
    
    let filter: filterType
    
    // Challenge 3
    @State private var isShowingSortOptions = false
    @State var sort: SortType = .recent
    
    let random = ["Brittany Brown\nbrittany.brown@random.com", "Adina Woodward\nadina.woodward@random.com", "Euan Rankin\neuan.rankin@random.com", "Arman Lawrence\narman.lawrence@random.com", "Rumaysa Lang\nrumaysa.lang@random.com", "Pawel Kerr\npawel.kerr@random.com", "Ashlee Reilly\nashlee.reilly@random.com", "Tabitha Monroe\ntabitha.monroe@random.com", "Deen Key\ndeen.key@random.com", "Aasiyah Byrd\naasiyah.byrd@random.com", "Esmee Robinson\n@random.com", "Bill Archer\nbill.archer@random.com", "Umar Whitworth\numar.whitworth@random.com", "Azra Hernandez\nazra.hernandez@random.com", "Nadine Matthams\nnadine.matthams@random.com", "Mateo Pearce\nmateo.pearce@random.com", "Shelbie Santiago\nshelbie.santiago@random.com", "Md Stokes\n@md.stokesrandom.com", "Mathilde Macfarlane\nmathilde.macfarlane@random.com", "Jamila Fernandez\njamila.fernandez@random.com"]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredSortedProspects) { prospect in
                    HStack {
                    VStack(alignment: .leading) {
                        Text(prospect.name)
                            .font(.headline)
                        Text(prospect.emailAddress)
                            .foregroundColor(.secondary)
                    }
                        Spacer()
                        
                        Image(systemName: prospect.isContacted ? "phone.fill" : "phone.down.fill")
                            .foregroundColor(prospect.isContacted ? .green : .red)
                    }
                    .swipeActions {
                        if prospect.isContacted {
                            Button {
                                prospects.toggle(prospect)
                            } label: {
                                Label("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark")
                            }
                            .tint(.red)
                        } else {
                            Button {
                                prospects.toggle(prospect)
                            } label: {
                                Label("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark")
                            }
                            .tint(.green)
                            
                            Button {
                                addNotification(for: prospect)
                            } label: {
                                Label("Remind Me", systemImage: "bell")
                            }
                            .tint(.orange)
                        }
                    }
                }
            }
            .navigationTitle(title)
            .toolbar {
                HStack {
                    // Challenge 3
                    Button("Sorted") {
                        isShowingSortOptions = true
                    }
                    .padding(.horizontal)
                Button {
                    isShowScanner = true
                } label: {
                    Label("Scan", systemImage: "qrcode.viewfinder")
                }
            }
            }
            .sheet(isPresented: $isShowScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: self.random.randomElement()!, completion: handleScan)
            }
            // Challenge 3
            .actionSheet(isPresented: $isShowingSortOptions) {
                ActionSheet(title: Text("Sort by"), buttons: [
                    .default(Text((self.sort == .name ? "✓ " : "") + "Name"), action: { self.sort = .name }),
                    .default(Text((self.sort == .recent ? "✓ " : "") + "Most recent"), action: { self.sort = .recent }),
                    .default(Text((self.sort == .isContacted ? "✓ " : "") + "Contacted"), action: { self.sort = .isContacted }),
                ])
            }
        }
    }
    
    // Challenge 3
    var filteredSortedProspects: [Prospect] {
        switch sort {
        case .name:
            return filteredProspects.sorted { $0.name < $1.name }
        case .recent:
            return filteredProspects.sorted { $0.date > $1.date }
        case .isContacted:
            return filteredProspects.sorted { $0.isContacted || $1.isContacted}
        }
    }
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncntacted people"
        }
    }
    
    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter { $0.isContacted }
        case .uncontacted:
            return prospects.people.filter { !$0.isContacted }
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowScanner = false
        
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            prospects.addPerson(person)
            
        case .failure(let error):
            print("Scanning filed: \(error.localizedDescription)")
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 9
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            //            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("D'oh")
                    }
                }
                
            }
        }
    }
}




















struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
            .environmentObject(Prospects())
    }
}
