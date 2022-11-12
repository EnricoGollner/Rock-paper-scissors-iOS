//
//  ContentView.swift
//  Rock, scissors, paper
//
//  Created by Enrico Gollner on 12/11/22.
//

import SwiftUI

struct ContentView: View {

    @State private var moves = ["Rock", "Paper", "Scissor"].shuffled()  // Embaralha
    
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
            Color.blue
            
            VStack(spacing: 40){
                
                Text("Level \(quest)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                Text("\(moves[adversary])")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                    .background(.red)
                
                Text("How to \(status[alternate]) this game")
                    .foregroundColor(.white)
                
                HStack(alignment: .center){
                    ForEach(0..<3){ number in
                        Button("\(moves[number])"){
                            verify(number)
                        }
                        .foregroundColor(.white)
                        .buttonStyle(.borderedProminent)
                        .tint(.green)
                    }
                }
                
                Text("\(score)")
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
            case "Rock":
                switch moves[numberOption]{
                case "Paper":
                    score += 1
                    scoreTitle = "Correct!"
                case "Scissor":
                    if score > 0{
                        scoreMinusVerify(score)
                    }
                    scoreTitle = "Fail!"
                default:
                    scoreTitle = "Tie!"
                }
            case "Paper":
                switch moves[numberOption]{
                case "Rock":
                    scoreMinusVerify(score)
                    scoreTitle = "Fail!"
                case "Scissor":
                    score += 1
                    scoreTitle = "Correct!"
                default:
                    scoreTitle = "Tie!"
                }
            case "Scissor":
                switch moves[numberOption]{
                case "Rock":
                    score += 1
                    scoreTitle = "Correct!"
                case "Paper":
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
            case "Rock":
                switch moves[numberOption]{
                case "Paper":
                    score += 1
                    scoreTitle = "Correct!"
                case "Scissor":
                    scoreMinusVerify(score)
                    scoreTitle = "Fail!"
                default:
                    scoreTitle = "Tie!"
                }
            case "Paper":
                switch moves[numberOption]{
                case "Rock":
                    score += 1
                    scoreTitle = "Correct!"
                case "Scissor":
                    scoreTitle = "Fail!"
                    scoreMinusVerify(score)
                default:
                    scoreTitle = "Tie!"
                }
            case "Scissor":
                switch moves[numberOption]{
                case "Rock":
                    scoreTitle = "Fail!"
                    scoreMinusVerify(score)
                case "Paper":
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
