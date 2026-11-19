# SocialForever — concept

**Human creative:** Babuni

A World of Warcraft: Forever social-memory addon that remembers recurring nearby players and makes recognizing, inviting, marking and rating them easier.

## Design characteristics

It seeks familiarity rather than a constant automated nameplate layer; it works with nameplates switched off, preserves account-wide encounter history and offers subjective personal marks. Shared marks require caution in social presentation.

The main panel can stay out of the way in crowded capitals or remain entirely manual while detection and personal encounter memory continue in the background. Visibility is a presentation choice, not a switch for social-memory collection.

Based on existing README, development notes and Lua source, not invented historical conversations.

## Social intent and evolution (audit #32)

Babuni's intention was not to replace nameplates with another constant surveillance overlay. The addon should occasionally help the player recognize the people sharing the world, find and invite someone without disruptive targeting, and recall past encounters. The creative explicitly valued the small recognition message because it can make a passing stranger feel familiar.

The [0.4.1 history](DEVELOPMENT.md) separates Zone roster visibility from Nearby evidence; later fixes protect stable list interaction. The [0.4.5 history](CHANGELOG.md) adds muted familiar thoughts only after an eligible Nearby appearance or targeting. Personal flags were kept private in 0.4.4. These are recorded source decisions, not new concepts approved in this audit.
