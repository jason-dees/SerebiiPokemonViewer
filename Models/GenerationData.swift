//
//  Generation.swift
//  SerebiiPokemonViewer
//
//  Created by Jason Dees on 10/30/22.
//

import Foundation

struct GenerationsFile: Codable {
    public var lastPokemon: Int
    public var generations: [Generation]
}

struct Generation: Codable {
    
    public let name: String
    public let gen: String
    public let normalRoute: String
    public let iconRoute: String
    public let iconIsGif: Bool?
    public let shinyRoute: String
    public let lastPokemon: Int
}
