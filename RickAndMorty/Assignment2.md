//
//  Assignment2.md
//  RickAndMorty
//
//  Created by Weeraphot Bumbaugh on 9/20/25.
//
---
## Requirements
**Core (required):**
//1. **Models:**
//   - `CharactersResponse { info: Info, results: [RMCharacter] }`
//   - `Info { count, pages, next, prev }`
//   - `RMCharacter: Identifiable { id, name, status, species, image, episode:[String] }`
//2. **Networking:**
//   - Use `URLSession` (async/await) to fetch `/api/character` with optional `page` and `name` query items.
//   - Check HTTP status (2xx) before decoding.
3. **UI — List & Search:**
   - SwiftUI list showing **image + name + species/status**.
   - **Search by name** (resets to page 1).
4. **UI — Pagination:**
   - **Next/Prev** buttons driven by `info.next/prev` (enable/disable accordingly).
5. **UI — Detail & Notes:**
   - Detail screen with larger image + basic fields.
   - **Editable note** per character using `UserDefaults` (e.g., key `rm_note_<id>`).
6. **UX States:**
   - Clear **loading**, **error with retry**, and **pull-to-refresh** behaviors.
//7. **Code Quality:**
//   - Separation of concerns: Views (render), ViewModel (state), API Client (network).
//   - No force-unwraps in UI paths.

