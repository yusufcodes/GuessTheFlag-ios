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
    
    func checkAnswer(userSelection: Int) {
        showingAlert = true
        let isAnswerCorrect = countries[userSelection] == countries[correctAnswer] ? true : false
        scoreTitle = isAnswerCorrect ? "Correct!" : "Incorrect"
        if (isAnswerCorrect) {
            score += 1
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack(spacing: 10) {
                        Text("Tap the correct flag for: ")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text((countries[correctAnswer]))
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    VStack {
                        ForEach(0..<3) { number in
                            Button() {
                                checkAnswer(userSelection: number)
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
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
