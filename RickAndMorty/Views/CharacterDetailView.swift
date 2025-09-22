//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by Weeraphot Bumbaugh on 9/20/25.
//
import SwiftUI

struct CharacterDetailView: View {
    let character: RMCharacter
    @State private var note: String = ""

    private var noteKey: String { "rm_note_\(character.id)" }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                SquareAsyncImage(url: URL(string: character.image), size: 220, cornerRadius: 16)

                Text(character.name).font(.title2).bold()
                Text("\(character.species) • \(character.status)")
                    .foregroundStyle(.secondary)

                if !character.episode.isEmpty {
                    Text("Episodes: \(character.episode.count)")
                        .font(.footnote).foregroundStyle(.secondary)
                }

                Text("Note")
                    .font(.headline).padding(.top, 8)

                TextField("Add a note…", text: $note, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .padding(.top, 4)
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { note = UserDefaults.standard.string(forKey: noteKey) ?? "" }
        .onChange(of: note) { UserDefaults.standard.set(note, forKey: noteKey) }
    }
}

