//
//  ContentView.swift
//  ChatWithGemini
//
//  Created by Pradeep MACMINI on 15/07/24.
//

import SwiftUI
import GoogleGenerativeAI

// AIzaSyBTtoYo0euZgCdl4cMtHfhA9j0kxqfzIG0
struct ContentView: View {
    let model = GenerativeModel(name: "gemini-pro", apiKey: APIKey.default)
    @State var userPrompt = ""
    @State var response:LocalizedStringKey = "How can i help you today?"
    @State var isLoading = false
    
    var body: some View {
        VStack {
            Text("welcom to Gemini AI")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.indigo)
                .padding(.top,40)
            ZStack{
                ScrollView{
                    Text(response)
                        .font(.title)
                }
                if isLoading{
                    ProgressView()
                        .progressViewStyle(.circular)
                        .scaleEffect(CGSize(width: 5.0, height: 5.0))
                }
            }
            TextField("Ask me anything",text: $userPrompt,axis: .vertical)
                .lineLimit(5)
                .font(.title)
                .padding()
                .background(.indigo.opacity(0.2),in: .capsule)
                .disableAutocorrection(true)
                .onSubmit {
                    generateResponse()
                }
            
        }
        .padding()
    }
    func generateResponse(){
        isLoading = true
        response = ""
        Task{
            do{
                let result = try await model.generateContent(userPrompt)
                isLoading = false
                response = LocalizedStringKey(result.text ?? "No response found")
                userPrompt = ""
            }catch{
                response = "Something went wrong\n\(error.localizedDescription)"
            }
        }
    }
}

#Preview {
    ContentView()
}
