//
//  Models.swift
//  RickAndMorty
//
//  Created by Weeraphot Bumbaugh on 9/20/25.
//
import Foundation

public struct CharactersResponse: Codable, Hashable {
    public let info: Info
    public let results: [RMCharacter]
}

public struct Info: Codable, Hashable {
    public let count: Int
    public let pages: Int
    public let next: String?
    public let prev: String?
}

public struct RMCharacter: Codable, Identifiable, Hashable {
    public let id: Int
    public let name: String
    public let status: String
    public let species: String
    public let image: String
    public let episode: [String]
}
