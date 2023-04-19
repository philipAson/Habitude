//
//  ContentView.swift
//  Habitude
//
//  Created by Philip Andersson on 2023-04-18.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("V.9")
                .padding()
            Spacer()

            List() {
                ForEach(1...5, id: \.self) { index in
            
                    Text("Task")
                    
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
