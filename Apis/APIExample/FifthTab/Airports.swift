//
//  Airports.swift
//  APIExample
//
//  Created by Noura Alowayid on 12/11/1444 AH.
//

import SwiftUI
struct Airport: Codable, Identifiable {
    let id = UUID()
    let name, city: String
    let region, country: String
    let longitude, timezone: String
}
struct Airports: View {
    @State private var airport = [Airport]()
    var body: some View {
        ScrollView{
            VStack {
                Text("Airports").font(.largeTitle).bold()
                ForEach (airport) { item in
                    
                    VStack {
                        Text(item.name).font(.title).bold()
                        Text(item.city)
                        Text(item.region)
                        Text(item.country)
                        Text(item.longitude)
                        Text(item.timezone)

                            .frame (maxWidth: .infinity)
                            .foregroundColor (.black)
                            .font (.title2)
                            .padding(.all, 24)
                            .background (.gray.opacity(0.3))
                            .padding (.bottom, 30)
                    }.padding()
                }
            }
        }
        .task {
            await loadData ()
        }
    }
    func loadData( ) async {
        do {
            let name = "London Heathrow".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let url = URL(string: "https://api.api-ninjas.com/v1/airports?name="+name!)!
            var request = URLRequest(url: url)
            request.setValue("r5KH4fSoLgFaSwo69uUsxw==FDkbnI4CgVWATJp4", forHTTPHeaderField: "X-Api-Key")
            
            let (data, response) = try await URLSession.shared.data(for: request)
            let isSuccessful = isSuccessful(response: response as! HTTPURLResponse)
            print(String(data: data, encoding: .utf8))
            let serverNews = try JSONDecoder().decode([Airport].self, from: data)
            airport = serverNews
            
        } catch {
            print("error \(error)")
        }
    }
    
}
struct Airports_Previews: PreviewProvider {
    static var previews: some View {
        Airports()
    }
}
