Base: https://rickandmortyapi.com/api

I built URLs using URLComponents and URLQueryItem.

The API returns a wrapper object with paging info and an array of characters, so I mirrored that shape. CharactersResponse contains Info and results [RMCharacter]. Info contains count, pages, next, prev. RMCharacter conforms to Identifiable and includes id, name, status, species, image, and episode.

No offline caching of API responses yet. If I were to extend this, I’d add a small on-disk cache or lightweight persistence.
Images use AsyncImage, a custom cache would avoid re-downloading on rapid scrolls.

On pill change or when I submit a search, I cancel any in-flight network task via a stored handle, clear results, reset to page 1, and kick off a fresh fetch; inside the loader I also check Task.isCancelled so late responses are ignored and never update UI. This prevents stale flashes when switching resources or rapidly changing queries and ensures the list always reflects the latest intent. Known limitations: no offline caching or per-pill page memory yet, generic error surfacing from localizedDescription, and no typing debounce for live search.
