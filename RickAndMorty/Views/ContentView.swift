//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Weeraphot Bumbaugh on 9/20/25.
//
import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ResourceVM()
    
    private var searchPlaceholder: String {
        switch viewModel.resource {
        case .characters: return "Search character name"
        case .episodes: return "Search episode name"
        case .locations: return "Search location name"
        }
    }
    
    var body: some View {
        NavigationStack{
            
            VStack{
    
                switch viewModel.state {
                case .idle:
                    Image(systemName: "text.document")
                        .imageScale(.large)
                    Button("Tap to load Rick & Morty"){
                        Task { await viewModel.firstLoad()}
                    }
                    .padding()
                    
                case .loading:
                    ProgressView()
                    Text("Loading...")
                        .padding()
                    
                case .loaded:
                    HStack {
                        Button("Prev") { Task { await viewModel.prevPage() } }
                            .disabled(viewModel.info?.prev == nil)
                        Spacer()
                        Button("Next") { Task { await viewModel.nextPage() } }
                            .disabled(viewModel.info?.next == nil)
                    }
                    .padding(.horizontal)
                    
                    Picker("Resource", selection: $viewModel.resource) {
                        ForEach(Resource.allCases) { resource in
                            Text(resource.rawValue.capitalized)
                                .tag(resource)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(8)
                    .onChange(of: viewModel.resource) { newValue in
                        viewModel.selectResource(newValue)
                    }

                    TextField("🔍\(searchPlaceholder)", text: $viewModel.searchText)
                    .onSubmit { Task { await viewModel.applySearch() } }
                    .padding(8)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(16)
                    .padding(.horizontal, 8)
                    
                    switch viewModel.resource {
                    case .characters:
                        List(viewModel.characters) { character in
                            NavigationLink {
                                CharacterDetailView(character: character)
                            } label: {
                                HStack(alignment: .top, spacing: 12) {
                                    SquareAsyncImage(url: URL(string: character.image), size: 72, cornerRadius: 10)
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(character.name).font(.headline)
                                        Text("\(character.species) • \(character.status)")
                                            .font(.subheadline)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                                .padding(.vertical, 6)
                            }
                        }
                        .listStyle(.plain)

                    case .episodes:
                        List(viewModel.episodes) { ep in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(ep.episode)
                                    .font(.caption).bold()
                                    .padding(.horizontal, 8).padding(.vertical, 2)
                                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(.secondary.opacity(0.4)))
                                Text(ep.name).font(.headline)
                                Text(ep.air_date).font(.subheadline).foregroundStyle(.secondary)
                            }
                            .padding(.vertical, 6)
                        }
                        .listStyle(.plain)

                    case .locations:
                        List(viewModel.locations) { loc in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(loc.name).font(.headline)
                                Text("\(loc.type) · \(loc.dimension)")
                                    .font(.subheadline).foregroundStyle(.secondary)
                                Text("Residents: \(loc.residents.count)")
                                    .font(.footnote).foregroundStyle(.secondary)
                            }
                            .padding(.vertical, 6)
                        }
                        .listStyle(.plain)
                    }

                    
                case .failed(let message):
                    VStack(spacing: 8) {
                        Text("Failed").font(.headline).foregroundStyle(.red)
                        Text(message).font(.caption).multilineTextAlignment(.center)
                        Button("Retry") { Task { await viewModel.applySearch() } }
                    }
                    .padding()

                }
                
            }
            .navigationTitle("Rick & Morty")
        }
    }
}

#Preview {
    ContentView()
}
