# Unreleased selectable auto-hide — live test plan

Automated mocks do not prove client event timing. Keep SocialForever enabled and retain SavedVariables throughout this pass.

1. Open Settings from the minimap icon and select **Hide in selected situations**.
2. Toggle each checkbox independently and confirm its checkmark persists after `/reload`.
3. With only **Cities, settlements, inns** checked, enter and leave a resting area; verify the panel hides and restores without affecting Nearby/history.
4. With only **Taxi / flying** checked, take a flight path. Verify the panel hides after takeoff and restores after landing if it was otherwise open.
5. If free flight is available, take off and land without dismounting; verify the same transition and note whether the client emits the expected flag/mount event.
6. With only **Battlegrounds / arenas** checked, enter and leave each available PvP instance; verify the panel hides inside and restores outside.
7. Enter an ordinary party/raid instance with the PvP checkbox enabled; confirm that condition alone does not hide the panel.
8. Enable multiple checkboxes and move directly between active contexts. Confirm a temporary manual reveal does not incorrectly persist into a new context.
9. Manually close the panel outside all selected contexts, then travel through them; confirm no event reopens it.
10. Repeat a transition during combat and confirm visibility changes safely after combat with no `ADDON_ACTION_BLOCKED` error.
