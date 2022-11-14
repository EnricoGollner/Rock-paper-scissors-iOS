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
            .background(.ultraThinMaterial)
            .clipShape(Capsule())
    }
}

struct ContentView: View{
    @State private var status = ["WIN", "LOOSE"].shuffled()
    @State private var moves = ["✊", "🤚", "✌️"]
    @State private var statusOp = Int.random(in: 0..<2)
    @State private var adversary = Int.random(in: 0..<3)
    @State private var score = 0
    @State private var quest = 1
    @State private var scoreTitle = ""
    @State private var showScore = false
    @State private var isOver = false
    
    @State private var agreedToTerms = false
    @State private var agreedToPrivacyPolicy = false
    @State private var agreedToEmails = false

    
    var body: some View{
        ZStack{
            LinearGradient(gradient: Gradient(stops: [
                .init(color: .green, location: 0.2),
                .init(color: .black, location: 0.8)
            ]), startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
            
            VStack{
                Spacer()
                Text("Level \(quest)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                Spacer()
                Text(moves[adversary])
                    .font(.largeTitle)
                    .padding()
                    .background(.red)
                    .cornerRadius(20)
                Spacer()
                Text("How to \(status[statusOp]) this game")
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                Spacer()
                HStack{
                    ForEach(0..<3){ moveNumb in
                        Button{
                            verify(moveNumb)  // Send the option we choose
                        } label: {
                            Figures(figure: moves[moveNumb])
                        }
                    }
                }
                Spacer()
                Text("Score: \(score)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
        }
        .alert(scoreTitle, isPresented: $showScore){
            Button("Continue", action: askQuest)
        } message: {
            Text("Your score is \(score)")
        }
        .alert("Thanks to play!", isPresented: $isOver){
            Button("Restart", action: restart)
        }
    }
    func verify(_ moveNumb: Int){
        if status[statusOp] == "WIN"{
            switch moves[adversary]{
            case "✊":
                switch moves[moveNumb]{
                case "🤚":
                    score += 1
                    scoreTitle = "Correct!"
                case "✌️":
                    adjustScore(score)
                    scoreTitle = "Fail!"
                default:
                    scoreTitle = "Tie!"
                }
            case "🤚":
                switch moves[moveNumb]{
                case "✊":
                    adjustScore(score)
                    scoreTitle = "Fail!"
                case "✌️":
                    score += 1
                    scoreTitle = "Correct!"
                default:
                    scoreTitle = "Tie!"
                }
            case "✌️":
                switch moves[moveNumb]{
                case "✊":
                    score += 1
                    scoreTitle = "Correct!"
                case "🤚":
                    adjustScore(score)
                    scoreTitle = "Fail!"
                default:
                    scoreTitle = "Tie!"
                }
            default:
                break
            }
        } else{  // LOOSE
            switch moves[adversary]{
            case "✊":
                switch moves[moveNumb]{
                case "🤚":
                    adjustScore(score)
                    scoreTitle = "Fail!"
                case "✌️":
                    score += 1
                    scoreTitle = "Correct!"
                default:
                    scoreTitle = "Tie!"
                }
            case "🤚":
                switch moves[moveNumb]{
                case "✊":
                    score += 1
                    scoreTitle = "Correct!"
                case "✌️":
                    adjustScore(score)
                    scoreTitle = "Fail!"
                default:
                    scoreTitle = "Tie!"
                }
            case "✌️":
                switch moves[moveNumb]{
                case "✊":
                    adjustScore(score)
                    scoreTitle = "Fail!"
                case "🤚":
                    score += 1
                    scoreTitle = "Correct!"
                default:
                    scoreTitle = "Tie!"
                }
            default:
                break
            }
        }
        if quest == 10{
            isOver.toggle()
        } else{
            showScore.toggle()
        }
    }
    func adjustScore(_ score: Int){
        if score > 0{
            self.score -= 1
        }
    }
    func askQuest(){
        quest += 1
        status.shuffle()
    }
    func restart(){
        score = 0
        quest = 1
        status.shuffle()
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
