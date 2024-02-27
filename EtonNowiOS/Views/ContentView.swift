//
//  ContentView.swift
//  EtonNowiOS
//
//  Created by Collins, Matthew - MC on 22/02/2024.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var apiManager = ApiManager.shared
    @State private var matches: [Match] = []
    
    var body: some View {
        NavigationStack {
            
            List {
                if matches.count == 0 {
                    Text("No matches. Add on admin dashboard.")
                }
                else {
                    ForEach(matches, id:\.id) { match in
                        VStack(alignment: .leading) {
                            Text("\(match.title)")
                                .fontWeight(.bold)
                            HStack {
                                Text("\(match.date.formatted(.dateTime.day().month()))")
                                Spacer()
                                Text("\(match.played ? "\(match.team1.name) \(match.score1)-\(match.score2) \(match.team2.name)" : "Unplayed")")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Eton Now")
        }
        .onAppear {
            apiManager.getMatches { matches in
                self.matches = matches
            }
        }
        .refreshable {
            apiManager.getMatches { matches in
                self.matches = matches
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
