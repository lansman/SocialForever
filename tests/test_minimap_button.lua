function wipe(t) for k in pairs(t) do t[k] = nil end end

SocialForever = nil
SocialForeverDB = nil
dofile("Core.lua")
dofile("UI.lua")

local SF = SocialForever
local UI = SF.UI
local S = SF.State

local function noop() end
local function widget()
    local scripts = {}
    local frame = {
        SetSize = noop, SetFrameStrata = noop, SetFrameLevel = noop,
        RegisterForClicks = noop, RegisterForDrag = noop,
        SetHighlightTexture = noop, ClearAllPoints = noop,
        SetPoint = function(self, ...) self.point = {...} end,
        SetScript = function(self, name, fn) scripts[name] = fn end,
        GetScript = function(self, name) return scripts[name] end,
        CreateTexture = function() return widget() end,
        SetTexture = noop, SetTexCoord = noop,
    }
    return frame
end

Minimap = widget()
Minimap.GetFrameLevel = function() return 2 end
Minimap.GetCenter = function() return 100, 100 end
Minimap.GetEffectiveScale = function() return 1 end
CreateFrame = function() return widget() end
GetCursorPosition = function() return 180, 100 end
GameTooltip = { SetOwner=noop, SetText=noop, AddLine=noop, Show=noop, Hide=noop }

SF.db = { minimapButtonX = -52, minimapButtonY = -52 }
S.main = { IsShown = function() return false end }
local shown, hidden = 0, 0
UI.ShowMain = function() shown = shown + 1 end
UI.HideMain = function() hidden = hidden + 1 end

UI.BuildMinimapButton()
assert(S.minimapButton, "minimap button was not built")
assert(math.abs((SF.db.minimapButtonX ^ 2 + SF.db.minimapButtonY ^ 2) ^ 0.5 - 80) < 0.001,
    "initial minimap position was not clamped to the ring")

S.minimapButton:GetScript("OnClick")(S.minimapButton, "LeftButton")
assert(shown == 1 and hidden == 0, "left click did not open the panel")

S.minimapButton:GetScript("OnDragStart")(S.minimapButton)
S.minimapButton:GetScript("OnUpdate")(S.minimapButton)
S.minimapButton:GetScript("OnDragStop")(S.minimapButton)
assert(math.abs(SF.db.minimapButtonX - 80) < 0.001 and math.abs(SF.db.minimapButtonY) < 0.001,
    "dragged minimap position was not saved")
assert(S.minimapButton:GetScript("OnUpdate") == nil, "drag update did not stop")

print("PASS: native minimap button build, click, drag, and persistence tests")
