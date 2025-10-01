# Mini‑Challenge: Multi‑Resource Browser

**Goal:** Add a pill selector **[Characters | Episodes | Locations]**. Use async/await, search by `name`, and pagination.

**Models:** Mirror API envelopes `{info, results}`.
Episode: `id, name, episode, air_date`
Location: `id, name, type, dimension, residents` (show **count** only)

**Tasks:**
1) Build segmented control. On change: **cancel** in‑flight, reset to page 1, fetch.
2) List:
   - Characters: image, name, species/status
   - Episodes: `SxxExx` + name + air date
   - Locations: name + type·dimension + “Residents: N”
3) Search uses `name=`; Next/Prev from `info.next/prev`. Show loading/error/empty.

**Accept:** No stale results on switch; search & paging per resource; no force‑unwraps.

**Stretch:** Debounce search; remember last page per pill; style episode code chips.

Docs: https://rickandmortyapi.com/documentation
