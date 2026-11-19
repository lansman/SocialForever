# Unreleased panel visibility and familiar thoughts — live Forever test plan

These checks require World of Warcraft: Forever (Interface 16001). Automated Lua tests do not count as completion of this plan.

Before each scenario, enable only SocialForever when practical, clear BugGrabber/BugSack output, and note the selected **Settings → Panel visibility** mode. Do not delete `SocialForeverDB`; persistence is part of the test.

## City and settlement mode

1. Select **Hide in cities and settlements**, leave the panel manually open, log out in Stormwind, and log back in. Confirm the panel starts hidden without a visible flash.
2. Walk from Stormwind to Elwynn Forest. Confirm the panel returns once and does not flicker.
3. Return to Stormwind. Confirm it hides again.
4. Run `/sf show` inside Stormwind. Confirm the panel opens, detection rows and Invite controls remain usable, and a second `/sf show` hides it.
5. Repeat the entry/exit check in smaller settlements and inns from both factions. Confirm the panel follows the resting indicator rather than an English or Russian place name.
6. Outside a resting area, run `/sf hide`, change subzones, enter and leave cities or settlements, and confirm the panel never reopens by itself.
7. Repeat login, `/reload`, teleport and dungeon-return checks in a city, a smaller settlement and an inn. Confirm one stable transition with no flash or repeated reopening.

## Other modes and persistence

1. Select **Always visible**, reload inside and outside a resting area, and confirm original SocialForever behavior: the last manual open/closed state is respected without automatic settlement hiding.
2. Select **Manual only**, reload, and confirm the panel stays hidden even if it was visible before reload.
3. Open Manual only with `/sf`, cross zone boundaries, and confirm it remains visible until manually closed.
4. Restart the client and confirm the chosen mode remains selected in Settings.
5. Switch among all three modes in Settings, including while standing in a settlement, and confirm the selected row and immediate panel behavior agree.

## Background behavior and combat

1. While the panel is automatically hidden, mouse over/target nearby players and perform normal social interactions that SocialForever detects.
2. Leave the city/settlement or open the panel manually. Confirm those players and their encounter history were retained; no history should be cleared by hiding.
3. Invite a player from the visible panel and confirm the existing Invite/Invited/Declined behavior is unchanged.
4. Enter or leave a resting area during combat. Confirm the panel waits until combat ends before changing visibility and no `ADDON_ACTION_BLOCKED` or Lua error appears.
5. After combat, confirm the ordinary secure rows repaint and remain targetable/invitable.

## Familiar thoughts

1. Select **Familiar thoughts → Off**, target and encounter eligible blue/purple familiar players, and confirm no “I've seen this … before” line appears immediately, after the normal delay, or after combat.
2. Confirm familiarity colors, Nearby membership, encounter counts and tooltip history continue updating while thoughts are Off.
3. Reload or restart the client and confirm Off remains selected.
4. Switch the setting back On and confirm an eligible familiar can produce the normal gray thought after its cooldown permits it.

Record client build, locale, faction, place, resting-indicator state, selected mode, result, and any error stack for each failure.
