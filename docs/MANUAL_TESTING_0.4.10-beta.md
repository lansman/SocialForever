# SocialForever 0.4.10-beta — live minimap-button test plan

Automated checks do not replace testing in World of Warcraft: Forever. Keep existing SavedVariables so position persistence is exercised.

1. Log in or `/reload` and confirm the SocialForever note icon appears around the minimap without Lua errors.
2. Left-click the icon and confirm the main panel toggles exactly once per click.
3. Right-click the icon and confirm the main panel and its Settings menu open.
4. Drag the icon to several sides of the minimap, `/reload`, and confirm the last position persists.
5. Enable **Hide in cities and settlements**, enter a resting area, and confirm left-click temporarily reveals the panel without stopping detection/history.
6. Enable **Manual only**, reload, and confirm the icon can still open the panel while no automatic opening occurs.
7. Enter combat and click the icon. Confirm any protected panel visibility transition is deferred safely and no `ADDON_ACTION_BLOCKED` error appears.
8. Confirm the minimap button does not overlap or prevent use of tracking, zoom, calendar, mail, queue, or other addon buttons at the chosen position.
