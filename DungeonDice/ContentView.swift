//  ContentView.swift
//  DungeonDice
//
//  Created by CRUZ, JANAI on 2/6/26.
//

import SwiftUI

struct ContentView: View {
    enum Dice: Int, CaseIterable, Identifiable{
       
        
        case four = 4
        case six = 6
        case eight = 8
        case ten = 10
        case twelve = 12
        case twenty = 20
        case hundred = 100
        
        var id: Int {
            return rawValue
        }
        
        var description: String { "\(rawValue)-sided"}
        
        func roll() -> Int{
            return Int.random(in: 1...self.rawValue)
        }
        
        
    }
    @State private var resultMessage = ""
    @State private var animationTrigger = false
    @State private var isDoneAnimation = true
   
    
    var body: some View {
        VStack {
            Text("Dungeon Dice")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundStyle(.red)
            
            Spacer()
            
            Text(resultMessage)
                .font(.largeTitle)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
//                .scaleEffect(isDoneAnimation ? 1.0 : 0.6)
//                .opacity(isDoneAnimation ? 1.0 : 0.2)
            rotation3DEffect(isDoneAnimation ? .degrees(360) : .degrees(0), axis: (x: 0, y: 0, z: 0))
                .frame(height: 150)
                .onChange(of: animationTrigger) {
                    isDoneAnimation = false
                    withAnimation(.interpolatingSpring(duration: 0.6, bounce: 0.4)) {
                        isDoneAnimation = true
                    }
                }
            
            Spacer()
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                ForEach(Dice.allCases) { dice in
                    Button("\(dice.description)-sided"){
                        resultMessage = "You rolled a \(dice.roll()) on a \(dice)-sided dice"
                        animationTrigger.toggle()
                    }
                }

            .buttonStyle(.borderedProminent)
            .tint(.red)
            }
            
                
    }
        
        .padding()
        }
       
}

struct ContentView_Previews: PreviewProvider{
    static var previews: some View {
        ContentView()
    }
}
