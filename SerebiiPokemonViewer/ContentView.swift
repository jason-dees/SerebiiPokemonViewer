//
//  ContentView.swift
//  SerebiiPokemonViewer
//
//  Created by Jason Dees on 10/30/22.
//

import SwiftUI

struct ContentView: View {
    @State private var generations: [Generation] = []
    @State private var generation: Generation?
    @State private var generationString: String = ""
    @State private var pokemonNumber: Int = -1
    @State private var hasIcon: Bool = false
    @State private var iconUrlString: String = "https://serebii.net/pokearth/sprites/green/001.png"
    @State private var normalUrlString: String = "https://serebii.net/pokearth/sprites/green/001.png"
    @State private var hasShiny: Bool = false
    @State private var shinyUrlString: String = "https://serebii.net/pokearth/sprites/green/001.png"
    var body: some View {
        VStack {
            HStack {
                if self.hasIcon {
                    AsyncImage(url: URL(string: iconUrlString))
                        .imageScale(.large)
                }
                AsyncImage(url: URL(string: normalUrlString))
                    .imageScale(.large)
                if self.hasShiny {
                    AsyncImage(url: URL(string: shinyUrlString))
                        .imageScale(.large)
                }
            }
            Text("\(pokemonNumber)")
            Picker("Select Generation", selection: $generationString ) {
                ForEach(self.generations.map { $0.name }, id: \.self) { gen in
                    Text(gen)
                }
            }.pickerStyle(.menu)
            Button("New Pokemon", action: randomPokemonButton)
        }
        .padding()
        .onAppear(perform: getGenerationData)
        .onChange(of: generationString, perform: generationStringChange)
    }
   
    func getGenerationData() {
        self.generations = loadGenerationList()
        self.generationString = self.generations.last?.name ?? "not found"
    }
    
    func randomPokemonButton() {
        let lastPokemon: Int = self.generation?.lastPokemon ?? 150
        self.pokemonNumber = Int.random(in: 1...lastPokemon)
        let zeroedNumber = zeroOutNumber("\(self.pokemonNumber)")
        self.normalUrlString = "\(self.generation?.normalRoute ?? "")\(zeroedNumber).png"
        self.hasIcon = self.generation?.iconRoute ?? "" != ""
        self.hasShiny = self.generation?.shinyRoute ?? "" != ""
        if self.hasIcon {
            self.iconUrlString = "\(self.generation?.iconRoute ?? "")\(zeroedNumber)\(self.generation?.iconIsGif ?? false ? ".gif" : ".png")"
        }
        if self.hasShiny {
            self.shinyUrlString = "\(self.generation?.shinyRoute ?? "")\(zeroedNumber).png"
        }
    }
    
    func generationStringChange(to value: String) {
        self.generation = self.generations.first { $0.name == self.generationString}
        randomPokemonButton()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
