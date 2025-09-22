Base: https://rickandmortyapi.com/api

I built URLs using URLComponents and URLQueryItem.

The API returns a wrapper object with paging info and an array of characters, so I mirrored that shape. CharactersResponse contains Info and results [RMCharacter]. Info contains count, pages, next, prev. RMCharacter conforms to Identifiable and includes id, name, status, species, image, and episode.

No offline caching of API responses yet. If I were to extend this, I’d add a small on-disk cache or lightweight persistence.
Images use AsyncImage, a custom cache would avoid re-downloading on rapid scrolls.
