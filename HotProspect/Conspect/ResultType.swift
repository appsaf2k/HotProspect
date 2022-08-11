//
//  ResultType.swift
//  HotProspect
//
//  Created by @andreev2k on 09.08.2022.
//
/// Понимание типа "result"



import SwiftUI

struct ResultType: View {
    @State private var output = ""
    
    var body: some View {
        Text(output)
            .task {
                await fetchReadings()
            }
    }
    func fetchReadings() async {
        let fetchTask = Task { () -> String in
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let readings = try JSONDecoder().decode([Double].self, from: data)
            return "Found \(readings.count) readings"
        }
        let result = await fetchTask.result
        
        switch result {
        case .success(let str):
            output = str
        case .failure(let error):
            output = "\(error.localizedDescription)"
        }
    }
}

struct ResultType_Previews: PreviewProvider {
    static var previews: some View {
        ResultType()
    }
}
