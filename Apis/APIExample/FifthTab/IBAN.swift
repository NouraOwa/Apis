//
//  IBAN.swift
//  APIExample
//
//  Created by Noura Alowayid on 12/11/1444 AH.
//

import SwiftUI
struct Iban: Codable {
    let iban, bank_name, account_number, bank_code: String
}
struct IBAN: View {
    @State private var bank = Iban(iban: "",bank_name: "", account_number: "", bank_code: "")
    var body: some View {
        ScrollView{
            VStack {
                Text("Account Information").font(.largeTitle).bold()
                //ForEach (bank) { item in
                    VStack {
                        Text(bank.iban).font(.title).bold()
                        Text(bank.bank_name)
                        Text(bank.account_number)
                        Text(bank.bank_code)
                            .frame (maxWidth: .infinity)
                            .foregroundColor (.black)
                            .font (.title2)
                            .padding(.all, 24)
                            .background (.gray.opacity(0.3))
                            .padding (.bottom, 30)
                    }.padding()
                }
            }
       // }
        .task {
            await loadData ()
        }
    }
    func loadData( ) async {
        do {
            let iban = "DE16200700000532013000".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let url = URL(string: "https://api.api-ninjas.com/v1/iban?iban=" + iban!)!
            var request = URLRequest(url: url)
            request.setValue("r5KH4fSoLgFaSwo69uUsxw==FDkbnI4CgVWATJp4", forHTTPHeaderField: "X-Api-Key")
            
            let (data, response) = try await URLSession.shared.data(for: request)
            let isSuccessful = isSuccessful(response: response as! HTTPURLResponse)
            print(String(data: data, encoding: .utf8))
            let serverNews = try JSONDecoder().decode(Iban.self, from: data)
            bank = serverNews
            
        } catch {
            print("error \(error)")
        }
    }
    
}


struct IBAN_Previews: PreviewProvider {
    static var previews: some View {
        IBAN()
    }
}
