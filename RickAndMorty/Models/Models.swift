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

public struct LocationsResponse: Codable, Hashable {
    public let info: Info
    public let results: [RMLocation]
}

public struct RMLocation: Codable, Identifiable, Hashable {
    public let id: Int
    public let name: String
    public let type: String
    public let dimension: String
    public let residents: [String]
}

public struct EpisodesResponse: Codable, Hashable {
    public let info: Info
    public let results: [RMEpisode]
}

public struct RMEpisode: Codable, Identifiable, Hashable {
    public let id: Int
    public let name: String
    public let air_date: String
    public let episode: String
    public let characters: [String]
}
