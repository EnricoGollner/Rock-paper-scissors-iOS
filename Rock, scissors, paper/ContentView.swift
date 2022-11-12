//
//  ContentView.swift
//  Rock, scissors, paper
//
//  Created by Enrico Gollner on 12/11/22.
//

import SwiftUI

struct Figures: View{
    var figure: String
    
    var body: some View{
        Text(figure)
            .font(.system(size: 30))
            .padding()
            .background(.green)
            .clipShape(Capsule())
    }
}

struct ContentView: View {

    @State private var moves = ["✊", "🤚", "✌️"].shuffled()  // Embaralha
    
    @State private var status = ["WIN", "LOOSE"].shuffled()  // Embaralha
    
    @State private var score: Int = 0
    
    @State private var quest = 1  // Ends at 10
    
    @State private var alternate = Int.random(in: 0..<2)
    @State private var adversary = Int.random(in: 0..<3)
    
    @State private var scoreTitle = ""
    
    @State private var showScore = false
    @State private var isOver = false
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(stops: [
                .init(color: .green, location: 0.1),
                .init(color: .blue, location: 0.4)
            ]), startPoint: .top, endPoint: .bottom)
            
            VStack(spacing: 40){
                Spacer()
                
                Text("Level \(quest)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                Spacer()
                
                Text("\(moves[adversary])")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                    .background(.red)
                    .cornerRadius(30)
                
                Spacer()
                
                Text("How to \(status[alternate]) this game")
                    .foregroundColor(.white)
                    .font(.system(size: 22))
                
                Spacer()
                HStack(alignment: .center){
                    ForEach(0..<3){ number in
                        Button {
                            verify(number)
                        } label: {
                            Figures(figure: moves[number])
                        }
                    }
                }
                
                Spacer()
                Text("Score: \(score)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
        }
        .ignoresSafeArea()
        .alert(scoreTitle, isPresented: $showScore){
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is now: \(score)")
        }
        .alert("Thanks for playing!", isPresented: $isOver){
            Button("Restart", action: restart)
        } message: {
            Text("Final score: \(score)")
        }
    }
    
    func verify(_ numberOption: Int){
    
        if status[alternate] == "WIN"{
            switch moves[adversary]{
            case "✊":
                switch moves[numberOption]{
                case "🤚":
                    score += 1
                    scoreTitle = "Correct!"
                case "✌️":
                    if score > 0{
                        scoreMinusVerify(score)
                    }
                    scoreTitle = "Fail!"
                default:
                    scoreTitle = "Tie!"
                }
            case "🤚":
                switch moves[numberOption]{
                case "✊":
                    scoreMinusVerify(score)
                    scoreTitle = "Fail!"
                case "✌️":
                    score += 1
                    scoreTitle = "Correct!"
                default:
                    scoreTitle = "Tie!"
                }
            case "✌️":
                switch moves[numberOption]{
                case "✊":
                    score += 1
                    scoreTitle = "Correct!"
                case "🤚":
                    scoreMinusVerify(score)
                    scoreTitle = "Fail!"
                default:
                    scoreTitle = "Tie!"
                }
            default:
                break
            }

        } else{  // If it's "Loose"
            
            switch moves[adversary]{
            case "✊":
                switch moves[numberOption]{
                case "🤚":
                    score += 1
                    scoreTitle = "Correct!"
                case "✌️":
                    scoreMinusVerify(score)
                    scoreTitle = "Fail!"
                default:
                    scoreTitle = "Tie!"
                }
            case "🤚":
                switch moves[numberOption]{
                case "✊":
                    score += 1
                    scoreTitle = "Correct!"
                case "✌️":
                    scoreTitle = "Fail!"
                    scoreMinusVerify(score)
                default:
                    scoreTitle = "Tie!"
                }
            case "✌️":
                switch moves[numberOption]{
                case "✊":
                    scoreTitle = "Fail!"
                    scoreMinusVerify(score)
                case "🤚":
                    scoreTitle = "Correct!"
                    score += 1
                default:
                    scoreTitle = "Tie!"
                }
            default:
                break
            }
        }
        
        if quest == 10{
            isOver = true
        } else{
            showScore = true
        }
    }
    
    func scoreMinusVerify(_ score: Int){
        if score > 0{
            self.score -= 1
        }
    }
    
    func askQuestion(){
        quest += 1
        status.shuffle()
        moves.shuffle()
    }
    
    func restart(){
        score = 0
        quest = 1
        status.shuffle()
        moves.shuffle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
