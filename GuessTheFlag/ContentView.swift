//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Yusuf on 19/06/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
        .shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    
    func checkAnswer(userSelection: Int) -> Bool {
        countries[userSelection] == countries[correctAnswer] ? true : false
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                VStack(spacing: 10) {
                    Text("Tap the correct flag for: ")
                        .foregroundColor(.white)
                        .font(.subheadline.weight(.heavy))
                    Text((countries[correctAnswer]))
                        .foregroundColor(.white)
                        .font(.largeTitle.weight(.semibold))
                }
                
                VStack {
                    ForEach(0..<3) { number in
                        Button {
                            showingAlert = true
                            let isAnswerCorrect = checkAnswer(userSelection: number)
                            scoreTitle = isAnswerCorrect ? "Correct!" : "Incorrect"
                            if (isAnswerCorrect) {
                                score += 1
                            }
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                        }
                        .alert(scoreTitle, isPresented: $showingAlert) {
                            Button("Play Again", action: askQuestion)
                        } message: {
                            Text("Your score is \(score)")
                        }
                        .clipShape(Capsule())
                        .shadow(radius: 5)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
