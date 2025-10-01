//
//  ResourceVM.swift
//  RickAndMorty
//
//  Created by Weeraphot Bumbaugh on 9/20/25.
//
import Foundation

enum LoadState: Equatable { case idle, loading, loaded, failed(String) }

enum Resource: String, CaseIterable, Identifiable {
    case characters = "Characters"
    case episodes = "Episodes"
    case locations = "Locations"
    var id: Self { self }
}

@MainActor
final class ResourceVM: ObservableObject {
    @Published var characters: [RMCharacter] = []
    @Published var episodes: [RMEpisode] = []
    @Published var locations: [RMLocation] = []
    @Published var info: Info? = nil
    @Published var state: LoadState = .idle
    @Published var searchText: String = ""
    @Published var resource: Resource = .characters
    
    private let api = APIClient()
    private var currentPage: Int = 1
    private var loadTask: Task<Void, Never>? = nil
    
    func selectResource(_ newValue: Resource) {
        loadTask?.cancel()
        
        currentPage = 1
        characters = []
        episodes = []
        locations = []
        info = nil
        state = .loading
        
        let name = searchText.isEmpty ? nil : searchText
        loadTask = Task { [weak self] in
            guard let self else { return }
            await self.load(page: 1, name: name, resource: newValue)
        }
    }
    
    func firstLoad() async {
        guard case .idle = state else { return }
        await load(page: 1, name: nil, resource: resource)}
    
    func applySearch() async {
        currentPage = 1
        let name = searchText.isEmpty ? nil : searchText
        await load(page: currentPage, name: name, resource: resource)
    }
    
    func nextPage() async {
        guard let i = info, i.next != nil else { return }
        currentPage += 1
        let name = searchText.isEmpty ? nil : searchText
        await load(page: currentPage, name: name, resource: resource)
    }
    
    func prevPage() async {
        guard let i = info, i.prev != nil else { return }
        currentPage = max(1, currentPage - 1)
        let name = searchText.isEmpty ? nil : searchText
        await load(page: currentPage, name: name, resource: resource)
    }
    func load(page: Int?, name: String?, resource: Resource) async {
        if Task.isCancelled { return }
        
        state = .loading
        do {
            switch resource {
            case .characters:
                let resp = try await api.fetchCharacters(page: page, name: name)
                if Task.isCancelled { return }
                characters = resp.results
                info = resp.info

            case .episodes:
                let resp = try await api.fetchEpisodes(page: page, name: name)
                if Task.isCancelled { return }
                episodes = resp.results
                info = resp.info
                
            case .locations:
                let resp = try await api.fetchLocations(page: page, name: name)
                if Task.isCancelled { return }
                locations = resp.results
                info = resp.info
            }
            state = .loaded
            
        } catch {
            if Task.isCancelled { return }
            characters = []
            episodes = []
            locations = []
            info = nil
            state = .failed(error.localizedDescription)
        }
    }
}
