function wipe(t) for k in pairs(t) do t[k] = nil end end

local currentMap = 1429
local parentMaps = {}
local currentZone = "Elwynn Forest"
local inCombat = false
local resting = false
local onTaxi = false
local flying = false
local instanceType = "none"

C_Map = {
    GetBestMapForUnit = function(unit)
        assert(unit == "player", "capital lookup should use the player unit")
        return currentMap
    end,
    GetMapInfo = function(mapID)
        return { parentMapID = parentMaps[mapID] }
    end,
}
function GetZoneText() return currentZone end
function InCombatLockdown() return inCombat end
function IsResting() return resting end
function UnitOnTaxi(unit) assert(unit == "player"); return onTaxi end
function IsFlying() return flying end
function IsInInstance() return instanceType ~= "none", instanceType end

SocialForever = nil
SocialForeverDB = nil
dofile("Core.lua")
dofile("UI.lua")

local SF = SocialForever
local C = SF.Const
local S = SF.State
local Util = SF.Util
local UI = SF.UI

local function assertTrue(value, message)
    if not value then error(message, 2) end
end
local function assertFalse(value, message)
    if value then error(message, 2) end
end
local function assertEqual(actual, expected, message)
    if actual ~= expected then
        error((message or "values differ") .. "\nExpected: " .. tostring(expected) .. "\nActual:   " .. tostring(actual), 2)
    end
end

for mapID = 1453, 1458 do
    assertTrue(Util.IsRestArea(mapID), "fallback capital UiMapID not recognized: " .. mapID)
end
assertFalse(Util.IsRestArea(1429), "Elwynn Forest should not be a fallback rest area")
parentMaps[9001] = 1453
assertTrue(Util.IsRestArea(9001), "child map of a fallback capital should be recognized")
parentMaps[9001] = nil
currentMap = nil
currentZone = "Dalaran"
IsResting = nil
assertFalse(Util.IsRestArea(), "Dalaran is not in the fallback capital table")
currentZone = "Stormwind City"
assertTrue(Util.IsRestArea(), "capital name fallback should work when resting status is unavailable")
currentZone = "Elwynn Forest"
function IsResting() return resting end

SF.db = {
    hidden = false,
    panelVisibility = C.PANEL_VISIBILITY_AUTO,
    autoHideRestAreas = true,
    autoHideFlight = false,
    autoHidePvP = false,
}
local shown = false
local scans = 0
S.main = {
    Show = function() shown = true end,
    Hide = function() shown = false end,
    IsShown = function() return shown end,
    ClearAllPoints = function() end,
    SetPoint = function() end,
    SetSize = function() end,
}
SF.Detection.Scan = function() scans = scans + 1 end
UIParent = {}
ChatFrame1 = nil

resting = true
UI.ApplyPanelVisibility()
assertFalse(shown, "settlement mode should hide the panel in a rested area")
assertFalse(SF.db.hidden, "automatic hiding must not overwrite manual visibility")

UI.ShowMain(true)
assertTrue(shown, "/sf show should temporarily reveal the panel in a settlement")
assertTrue(S.autoHidePanelOverride, "automatic-hide override was not recorded")
UI.ShowMain(true)
assertFalse(shown, "repeated /sf show should hide the temporary rest-area override")
assertTrue(SF.db.hidden, "repeated command should count as a manual hide")

SF.db.hidden = false
UI.ShowMain(true)
resting = false
UI.ApplyPanelVisibility()
assertTrue(shown, "leaving a settlement should restore an otherwise open panel")
assertFalse(S.autoHidePanelOverride, "automatic-hide override should expire on exit")
resting = true
UI.ApplyPanelVisibility()
assertFalse(shown, "returning to a settlement should hide the panel again")

resting = false
SF.db.autoHideRestAreas = false
SF.db.autoHideFlight = true
SF.db.hidden = false
S.autoHideContext = nil
onTaxi = true
UI.ApplyPanelVisibility()
assertFalse(shown, "selected taxi-flight condition should hide the panel")
onTaxi = false
UI.ApplyPanelVisibility()
assertTrue(shown, "ending a taxi flight should restore an otherwise open panel")
flying = true
UI.ApplyPanelVisibility()
assertFalse(shown, "selected free-flight condition should hide the panel")
flying = false
SF.db.autoHideFlight = false
SF.db.autoHidePvP = true
instanceType = "pvp"
UI.ApplyPanelVisibility()
assertFalse(shown, "selected battleground condition should hide the panel")
instanceType = "arena"
UI.ApplyPanelVisibility()
assertFalse(shown, "selected arena condition should hide the panel")
instanceType = "party"
UI.ApplyPanelVisibility()
assertTrue(shown, "ordinary instances should not count as selected PvP contexts")
instanceType = "none"

SF.db.panelVisibility = C.PANEL_VISIBILITY_MANUAL
SF.db.hidden = false
S.manualPanelShown = false
resting = false
UI.ApplyPanelVisibility()
assertFalse(shown, "manual mode must not open automatically")
UI.ShowMain(true)
assertTrue(shown, "manual mode should open from a user command")
resting = true
UI.ApplyPanelVisibility()
assertTrue(shown, "manual mode should stay open across zone changes after a command")
UI.HideMain()
resting = false
UI.ApplyPanelVisibility()
assertFalse(shown, "a manually hidden panel must stay hidden after a zone change")

SF.db.panelVisibility = C.PANEL_VISIBILITY_AUTO
SF.db.autoHideRestAreas = true
SF.db.autoHidePvP = false
SF.db.hidden = false
S.autoHideContext = ""
resting = false
UI.ApplyPanelVisibility()
assertTrue(shown, "panel should be visible outside rest areas before combat test")
inCombat = true
resting = true
UI.ApplyPanelVisibility()
assertTrue(shown, "protected visibility change should wait during combat")
assertEqual(S.pendingMainShown, false, "rest-area hide was not queued during combat")
inCombat = false
UI.FlushPendingPanelVisibility()
assertFalse(shown, "queued rest-area hide should apply after combat")
assertTrue(scans > 0, "showing the panel should keep the normal detection scan hook")

print("PASS: selectable rest/flight/PvP visibility, manual intent, and combat deferral")
