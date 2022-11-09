//
//  GenerationDataLoader.swift
//  SerebiiPokemonViewer
//
//  Created by Jason Dees on 11/3/22.
//

import Foundation

func loadGenerationList() -> [Generation] {
    if let url = Bundle.main.url(forResource: "GenerationData", withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            print(String(decoding: data, as: UTF8.self))
            let jsonData = try JSONDecoder().decode(GenerationsFile.self, from: data)
            return jsonData.generations
            
        } catch let error {
            print(error)
        }}
    return []
}

func generateRandomPokemon() {
    
}

public func zeroOutNumber(_ number: String) -> String {
    String(("000" + number).suffix(3))
}
