//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Weeraphot Bumbaugh on 9/20/25.
//
import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = CharactersVM()
    
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

                    TextField("🔍 Search name (e.g. Rick)", text: $viewModel.searchText)
                    .onSubmit { Task { await viewModel.applySearch() } }
                    .padding(8)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(16)
                    .padding(.horizontal, 8)
                    
                    List(viewModel.characters) { character in
                        NavigationLink {
                            CharacterDetailView(character: character)
                            Text(character.name)
                        } label: {
                            HStack(alignment: .top, spacing: 12) {
                                SquareAsyncImage(
                                    url: URL(string: character.image),
                                    size: 72,
                                    cornerRadius: 10
                                )
                                
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
                    .refreshable { await viewModel.applySearch() }
                    
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
