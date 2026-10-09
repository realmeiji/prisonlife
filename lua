--[[
    SPENT HUB v16 (Linoria-based)
    Author: Spent
    Silent aim core: SPENT 
    GUI: Linoria library (fetched from GitHub)
    Requires: executor with loadstring, game:HttpGet, hookmetamethod, Drawing API
]]

-- ============ LOAD LIBRARIES ============
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/Library.lua"))()
local ThemeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/addons/SaveManager.lua"))()

-- ============ SERVICES ============
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local WorldToViewportPoint = Camera.WorldToViewportPoint
local GetPlayers = Players.GetPlayers
local GetMouseLocation = UserInputService.GetMouseLocation
local resume = coroutine.resume
local create = coroutine.create

-- ============ SETTINGS ============
local Settings = {
    SilentEnabled = false,
    TeamCheck = false,
    VisibleCheck = false,
    TargetPart = "HumanoidRootPart",
    SilentAimMethod = "Raycast",
    FOVRadius = 130,
    FOVVisible = true,
    ShowSilentAimTarget = false,
    MouseHitPrediction = false,
    MouseHitPredictionAmount = 0.165,
    HitChance = 100,

    TargetCop = true,
    TargetInmate = true,
    TargetCriminal = true,

    ESP_Enabled = false,
    ESP_Team = false,
    ESP_Highlight = true,
    ESP_Name = true,
    ESP_Health = true,
    ESP_Trace = false,
    ESP_MaxDistance = 1500,
    ESP_HighlightColor = Color3.fromRGB(255, 182, 193),
    ESP_NameColor = Color3.fromRGB(255, 255, 255),
    ESP_HPColor = Color3.fromRGB(80, 255, 100),
    ESP_TraceColor = Color3.fromRGB(255, 255, 255),
}
getgenv().Settings = Settings

local TARGET_LOCK_COLOR = Color3.fromRGB(255, 182, 193)
local RING_IDLE_COLOR = Color3.fromRGB(255, 255, 255)

-- ============ DRAWING OBJECTS ============
local mouse_box = Drawing.new("Square")
mouse_box.Visible = false
mouse_box.ZIndex = 999
mouse_box.Color = Color3.fromRGB(255, 182, 193)
mouse_box.Thickness = 2
mouse_box.Size = Vector2.new(20, 20)
mouse_box.Filled = false

local fov_circle = Drawing.new("Circle")
fov_circle.Thickness = 1
fov_circle.NumSides = 100
fov_circle.Radius = 130
fov_circle.Filled = false
fov_circle.Visible = false
fov_circle.ZIndex = 999
fov_circle.Transparency = 1
fov_circle.Color = Color3.fromRGB(255, 182, 193)

-- ============ SILENT AIM CORE ============
local ExpectedArguments = {
    FindPartOnRayWithIgnoreList = {
        ArgCountRequired = 3,
        Args = { "Instance", "Ray", "table", "boolean", "boolean" }
    },
    FindPartOnRayWithWhitelist = {
        ArgCountRequired = 3,
        Args = { "Instance", "Ray", "table", "boolean" }
    },
    FindPartOnRay = {
        ArgCountRequired = 2,
        Args = { "Instance", "Ray", "Instance", "boolean", "boolean" }
    },
    Raycast = {
        ArgCountRequired = 3,
        Args = { "Instance", "Vector3", "Vector3", "RaycastParams" }
    }
}

local lastRollTime = 0
local lastRollResult = false

local function CalculateChance(Percentage)
    local now = tick()
    if now - lastRollTime < 0.15 then
        return lastRollResult
    end
    lastRollTime = now
    Percentage = math.floor(Percentage)
    local chance = math.floor(Random.new().NextNumber(Random.new(), 0, 1) * 100) / 100
    lastRollResult = chance <= Percentage / 100
    return lastRollResult
end

local function ValidateArguments(Args, RayMethod)
    local Matches = 0
    if #Args < RayMethod.ArgCountRequired then return false end
    for Pos, Argument in next, Args do
        if typeof(Argument) == RayMethod.Args[Pos] then Matches = Matches + 1 end
    end
    return Matches >= RayMethod.ArgCountRequired
end

local function getDirection(Origin, Position)
    return (Position - Origin).Unit * 1000
end

local function getMousePosition()
    return GetMouseLocation(UserInputService)
end

local function IsPlayerVisible(Player)
    local PlayerCharacter = Player.Character
    local LocalPlayerCharacter = LocalPlayer.Character
    if not (PlayerCharacter or LocalPlayerCharacter) then return false end
    local PlayerRoot = PlayerCharacter:FindFirstChild(Settings.TargetPart) or PlayerCharacter:FindFirstChild("HumanoidRootPart")
    if not PlayerRoot then return false end
    local CastPoints = { PlayerRoot.Position, LocalPlayerCharacter, PlayerCharacter }
    local IgnoreList = { LocalPlayerCharacter, PlayerCharacter }
    local ObscuringObjects = #Camera:GetPartsObscuringTarget(CastPoints, IgnoreList)
    return ObscuringObjects == 0
end

local function matchesTeam(Player)
    if not Player.Team then return true end
    local teamName = Player.Team.Name
    if teamName == "Guards" then return Settings.TargetCop end
    if teamName == "Criminals" then return Settings.TargetCriminal end
    if teamName == "Inmates" then return Settings.TargetInmate end
    return true
end

local function getClosestPlayer()
    if not Settings.TargetPart then return end
    local Closest
    local DistanceToMouse
    for _, Player in next, GetPlayers(Players) do
        if Player == LocalPlayer then continue end
        if Settings.TeamCheck and Player.Team == LocalPlayer.Team then continue end
        if not matchesTeam(Player) then continue end
        local Character = Player.Character
        if not Character then continue end
        if Settings.VisibleCheck and not IsPlayerVisible(Player) then continue end
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
        local Humanoid = Character:FindFirstChild("Humanoid")
        if not HumanoidRootPart or not Humanoid or Humanoid.Health <= 0 then continue end
        local ScreenPosition, OnScreen = WorldToViewportPoint(Camera, HumanoidRootPart.Position)
        if not OnScreen then continue end
        local Distance = (getMousePosition() - Vector2.new(ScreenPosition.X, ScreenPosition.Y)).Magnitude
        if Distance <= (DistanceToMouse or Settings.FOVRadius or 2000) then
            Closest = ((Settings.TargetPart == "Random" and Character.Head) or Character[Settings.TargetPart])
            DistanceToMouse = Distance
        end
    end
    return Closest
end

-- ============ ESP SYSTEM (optimized) ============
local espCache = {}
local ESP_UPDATE_INTERVAL = 1 / 30
local HIGHLIGHT_CHECK_INTERVAL = 0.1
local LOCK_CACHE_INTERVAL = 0.1
local DISTANCE_CULL = 1.2

local lastESPUpdate = 0
local lastHighlightUpdate = 0
local lastLockCheck = 0
local cachedLockedChar = nil

local function isLockedChar(char)
    local now = tick()
    if now - lastLockCheck >= LOCK_CACHE_INTERVAL then
        lastLockCheck = now
        local cur = getClosestPlayer()
        cachedLockedChar = (cur and cur.Parent) or nil
    end
    return cachedLockedChar == char
end

local function getTeamColor(player)
    local ok, color = pcall(function()
        if player.Team and player.Team.TeamColor then
            return player.Team.TeamColor.Color
        end
        local char = player.Character
        if char then
            local bc = char:FindFirstChildOfClass("BodyColors")
            if bc then return bc.HeadColor3 end
        end
        return Settings.ESP_HighlightColor
    end)
    if ok and color then return color end
    return Settings.ESP_HighlightColor
end

local function newESP(player)
    local d = {
        name = Drawing.new("Text"),
        hpBack = Drawing.new("Line"),
        hpBar = Drawing.new("Line"),
        trace = Drawing.new("Line"),
    }
    d.name.Size = 13
    d.name.Center = true
    d.name.Outline = true
    d.name.Color = Settings.ESP_NameColor
    d.name.Visible = false

    d.hpBack.Thickness = 3
    d.hpBack.Color = Color3.fromRGB(30, 30, 30)
    d.hpBack.Visible = false

    d.hpBar.Thickness = 3
    d.hpBar.Color = Settings.ESP_HPColor
    d.hpBar.Visible = false

    d.trace.Thickness = 1
    d.trace.Color = Settings.ESP_TraceColor
    d.trace.Visible = false

    espCache[player] = d
    return d
end

local function clearESP(player)
    local d = espCache[player]
    if d then
        for k, obj in pairs(d) do
            if k ~= "lastUpdate" and typeof(obj) == "userdata" then
                pcall(function() obj:Remove() end)
            end
        end
        espCache[player] = nil
    end
end

Players.PlayerRemoving:Connect(function(p) clearESP(p) end)

local function hideESP(d)
    if d.name.Visible then d.name.Visible = false end
    if d.hpBack.Visible then d.hpBack.Visible = false end
    if d.hpBar.Visible then d.hpBar.Visible = false end
    if d.trace.Visible then d.trace.Visible = false end
end

local function updateESP()
    local now = tick()
    if now - lastESPUpdate < ESP_UPDATE_INTERVAL then return end
    lastESPUpdate = now

    local canUpdateHighlight = (now - lastHighlightUpdate) >= HIGHLIGHT_CHECK_INTERVAL
    if canUpdateHighlight then lastHighlightUpdate = now end

    local camPos = Camera.CFrame.Position
    local viewport = Camera.ViewportSize
    local centerX = viewport.X / 2
    local viewportY = viewport.Y
    local maxDist = Settings.ESP_MaxDistance * DISTANCE_CULL
    local espEnabled = Settings.ESP_Enabled

    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        local d = espCache[player]
        local char = player.Character

        if not espEnabled then
            if d then hideESP(d) end
            if canUpdateHighlight and char then
                local hl = char:FindFirstChild("SpentHubHL")
                if hl then hl:Destroy() end
            end
            continue
        end

        if not char then
            if d then hideESP(d) end
            continue
        end

        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum then
            if d then hideESP(d) end
            continue
        end

        local hrpPos = hrp.Position
        local dist = (camPos - hrpPos).Magnitude
        if dist > maxDist then
            if d then hideESP(d) end
            if canUpdateHighlight then
                local hl = char:FindFirstChild("SpentHubHL")
                if hl then hl:Destroy() end
            end
            continue
        end

        if not d then d = newESP(player) end

        local head = char:FindFirstChild("Head") or hrp
        local screenHead, onScreen = WorldToViewportPoint(Camera, head.Position + Vector3.new(0, 1.5, 0))
        if not onScreen then
            hideESP(d)
            continue
        end

        if Settings.ESP_Name then
            if not d.name.Visible then d.name.Visible = true end
            d.name.Text = player.DisplayName
            d.name.Position = Vector2.new(screenHead.X, screenHead.Y - 20)
            d.name.Color = Settings.ESP_NameColor
        elseif d.name.Visible then
            d.name.Visible = false
        end

        if Settings.ESP_Health then
            local topY = screenHead.Y - 32
            if not d.hpBack.Visible then d.hpBack.Visible = true end
            if not d.hpBar.Visible then d.hpBar.Visible = true end
            d.hpBack.From = Vector2.new(screenHead.X - 28, topY)
            d.hpBack.To = Vector2.new(screenHead.X + 28, topY)
            local pct = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
            d.hpBar.From = Vector2.new(screenHead.X - 28, topY)
            d.hpBar.To = Vector2.new(screenHead.X - 28 + 56 * pct, topY)
            d.hpBar.Color = Settings.ESP_HPColor
        else
            if d.hpBack.Visible then d.hpBack.Visible = false end
            if d.hpBar.Visible then d.hpBar.Visible = false end
        end

        if Settings.ESP_Trace then
            if not d.trace.Visible then d.trace.Visible = true end
            d.trace.From = Vector2.new(centerX, viewportY)
            d.trace.To = Vector2.new(screenHead.X, screenHead.Y)
            local tc = Settings.ESP_Team and getTeamColor(player) or Settings.ESP_TraceColor
            if d.trace.Color ~= tc then d.trace.Color = tc end
        elseif d.trace.Visible then
            d.trace.Visible = false
        end

        if canUpdateHighlight then
            if Settings.ESP_Highlight then
                local hl = char:FindFirstChild("SpentHubHL")
                if not hl then
                    hl = Instance.new("Highlight")
                    hl.Name = "SpentHubHL"
                    hl.Adornee = char
                    hl.FillTransparency = 1
                    hl.OutlineTransparency = 0
                    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    hl.Parent = char
                end
                local wantColor
                if isLockedChar(char) then
                    wantColor = TARGET_LOCK_COLOR
                elseif Settings.ESP_Team then
                    wantColor = getTeamColor(player)
                else
                    wantColor = Settings.ESP_HighlightColor
                end
                if hl.OutlineColor ~= wantColor then hl.OutlineColor = wantColor end
            else
                local hl = char:FindFirstChild("SpentHubHL")
                if hl then hl:Destroy() end
            end
        end
    end
end

-- ============ HOOKS ============
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
    local Method = getnamecallmethod()
    local Arguments = { ... }
    local self = Arguments[1]
    local chance = CalculateChance(Settings.HitChance)
    if Settings.SilentEnabled and self == workspace and not checkcaller() and chance == true then
        if Method == "FindPartOnRayWithIgnoreList" and Settings.SilentAimMethod == Method then
            if ValidateArguments(Arguments, ExpectedArguments.FindPartOnRayWithIgnoreList) then
                local A_Ray = Arguments[2]
                local HitPart = getClosestPlayer()
                if HitPart then
                    Arguments[2] = Ray.new(A_Ray.Origin, getDirection(A_Ray.Origin, HitPart.Position))
                    return oldNamecall(unpack(Arguments))
                end
            end
        elseif Method == "FindPartOnRayWithWhitelist" and Settings.SilentAimMethod == Method then
            if ValidateArguments(Arguments, ExpectedArguments.FindPartOnRayWithWhitelist) then
                local A_Ray = Arguments[2]
                local HitPart = getClosestPlayer()
                if HitPart then
                    Arguments[2] = Ray.new(A_Ray.Origin, getDirection(A_Ray.Origin, HitPart.Position))
                    return oldNamecall(unpack(Arguments))
                end
            end
        elseif (Method == "FindPartOnRay" or Method == "findPartOnRay") and Settings.SilentAimMethod:lower() == Method:lower() then
            if ValidateArguments(Arguments, ExpectedArguments.FindPartOnRay) then
                local A_Ray = Arguments[2]
                local HitPart = getClosestPlayer()
                if HitPart then
                    Arguments[2] = Ray.new(A_Ray.Origin, getDirection(A_Ray.Origin, HitPart.Position))
                    return oldNamecall(unpack(Arguments))
                end
            end
        elseif Method == "Raycast" and Settings.SilentAimMethod == Method then
            if ValidateArguments(Arguments, ExpectedArguments.Raycast) then
                local A_Origin = Arguments[2]
                local HitPart = getClosestPlayer()
                if HitPart then
                    Arguments[3] = getDirection(A_Origin, HitPart.Position)
                    return oldNamecall(unpack(Arguments))
                end
            end
        end
    end
    return oldNamecall(...)
end))

local oldIndex = nil
oldIndex = hookmetamethod(game, "__index", newcclosure(function(self, Index)
    if self == Mouse and not checkcaller() and Settings.SilentEnabled and Settings.SilentAimMethod == "Mouse.Hit/Target" and getClosestPlayer() then
        local HitPart = getClosestPlayer()
        if Index == "Target" or Index == "target" then
            return HitPart
        elseif Index == "Hit" or Index == "hit" then
            return ((Settings.MouseHitPrediction and (HitPart.CFrame + (HitPart.Velocity * Settings.MouseHitPredictionAmount))) or (not Settings.MouseHitPrediction and HitPart.CFrame))
        elseif Index == "X" or Index == "x" then
            return self.X
        elseif Index == "Y" or Index == "y" then
            return self.Y
        elseif Index == "UnitRay" then
            return Ray.new(self.Origin, (self.Hit - self.Origin).Unit)
        end
    end
    return oldIndex(self, Index)
end))

-- ============ RENDER LOOP ============
resume(create(function()
    RunService.RenderStepped:Connect(function()
        local lockedTarget = getClosestPlayer()

        if Settings.ShowSilentAimTarget and Settings.SilentEnabled then
            if lockedTarget then
                local Root = lockedTarget.Parent and lockedTarget.Parent.PrimaryPart or lockedTarget
                local RootToViewportPoint, IsOnScreen = WorldToViewportPoint(Camera, Root.Position)
                mouse_box.Visible = IsOnScreen
                mouse_box.Position = Vector2.new(RootToViewportPoint.X, RootToViewportPoint.Y)
            else
                mouse_box.Visible = false
                mouse_box.Position = Vector2.new()
            end
        else
            mouse_box.Visible = false
        end

        if Settings.FOVVisible and Settings.SilentEnabled then
            fov_circle.Visible = true
            fov_circle.Position = getMousePosition()
            if lockedTarget then
                fov_circle.Color = TARGET_LOCK_COLOR
            else
                fov_circle.Color = RING_IDLE_COLOR
            end
        else
            fov_circle.Visible = false
        end

        updateESP()
    end)
end))

-- ============ LINORIA WINDOW ============
local Window = Library:CreateWindow({
    Title = "SPENT HUB  ·  v16",
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2,
})

local Tabs = {
    Combat = Window:AddTab("Combat"),
    ESP = Window:AddTab("ESP"),
    Visuals = Window:AddTab("Visuals"),
    ["UI Settings"] = Window:AddTab("UI Settings"),
    Home = Window:AddTab("Home"),
}

-- ============ COMBAT TAB ============
local SilentGroup = Tabs.Combat:AddLeftGroupbox("Silent Aim")
SilentGroup:AddToggle("SilentEnabled", {
    Text = "Enabled",
    Default = false,
    Tooltip = "Master silent aim toggle",
    Callback = function(v) Settings.SilentEnabled = v end,
})

SilentGroup:AddDropdown("TargetPart", {
    Text = "Target Part",
    Values = { "Head", "HumanoidRootPart", "Random" },
    Default = "HumanoidRootPart",
    Callback = function(v) Settings.TargetPart = v end,
})

SilentGroup:AddDropdown("SilentAimMethod", {
    Text = "Method",
    Values = { "Raycast", "FindPartOnRay", "FindPartOnRayWithWhitelist", "FindPartOnRayWithIgnoreList", "Mouse.Hit/Target" },
    Default = "Raycast",
    Callback = function(v) Settings.SilentAimMethod = v end,
})

SilentGroup:AddSlider("HitChance", {
    Text = "Hit Chance",
    Default = 100,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Suffix = "%",
    Callback = function(v) Settings.HitChance = v end,
})

SilentGroup:AddToggle("TeamCheck", {
    Text = "Team Check",
    Default = false,
    Callback = function(v) Settings.TeamCheck = v end,
})

SilentGroup:AddToggle("VisibleCheck", {
    Text = "Visible Check",
    Default = false,
    Callback = function(v) Settings.VisibleCheck = v end,
})

local TargetGroup = Tabs.Combat:AddRightGroupbox("Target Team")
TargetGroup:AddToggle("TargetCop", {
    Text = "Target Cop",
    Default = true,
    Tooltip = "Aim only at Guards team",
    Callback = function(v) Settings.TargetCop = v end,
})

TargetGroup:AddToggle("TargetInmate", {
    Text = "Target Inmate",
    Default = true,
    Tooltip = "Aim only at Inmates team",
    Callback = function(v) Settings.TargetInmate = v end,
})

TargetGroup:AddToggle("TargetCriminal", {
    Text = "Target Criminal",
    Default = true,
    Tooltip = "Aim only at Criminals team",
    Callback = function(v) Settings.TargetCriminal = v end,
})

local PredictGroup = Tabs.Combat:AddRightGroupbox("Prediction")
PredictGroup:AddToggle("MouseHitPrediction", {
    Text = "Mouse.Hit Prediction",
    Default = false,
    Callback = function(v) Settings.MouseHitPrediction = v end,
})

PredictGroup:AddSlider("PredictionAmount", {
    Text = "Prediction Amount",
    Default = 165,
    Min = 165,
    Max = 1000,
    Rounding = 0,
    Suffix = " x1000",
    Callback = function(v) Settings.MouseHitPredictionAmount = v / 1000 end,
})

-- ============ ESP TAB ============
local ESPMain = Tabs.ESP:AddLeftGroupbox("ESP")
ESPMain:AddToggle("ESP_Enabled", {
    Text = "Enable ESP",
    Default = false,
    Callback = function(v) Settings.ESP_Enabled = v end,
})

ESPMain:AddToggle("ESP_Team", {
    Text = "Team Colors",
    Default = false,
    Tooltip = "Highlight and trace use team colors",
    Callback = function(v) Settings.ESP_Team = v end,
})

local ESPElems = Tabs.ESP:AddRightGroupbox("Elements")
ESPElems:AddToggle("ESP_Highlight", {
    Text = "Highlight",
    Default = true,
    Callback = function(v) Settings.ESP_Highlight = v end,
})

ESPElems:AddToggle("ESP_Name", {
    Text = "Name",
    Default = true,
    Callback = function(v) Settings.ESP_Name = v end,
})

ESPElems:AddToggle("ESP_Health", {
    Text = "Health Bar",
    Default = true,
    Callback = function(v) Settings.ESP_Health = v end,
})

ESPElems:AddToggle("ESP_Trace", {
    Text = "Trace Line",
    Default = false,
    Callback = function(v) Settings.ESP_Trace = v end,
})

ESPElems:AddSlider("ESP_MaxDistance", {
    Text = "Max Distance",
    Default = 1500,
    Min = 100,
    Max = 3000,
    Rounding = 0,
    Callback = function(v) Settings.ESP_MaxDistance = v end,
})

-- ============ VISUALS TAB ============
local FOVGroup = Tabs.Visuals:AddLeftGroupbox("FOV Circle")
FOVGroup:AddToggle("FOVVisible", {
    Text = "Show FOV Circle",
    Default = true,
    Callback = function(v) Settings.FOVVisible = v end,
})

FOVGroup:AddSlider("FOVRadius", {
    Text = "FOV Radius",
    Default = 130,
    Min = 0,
    Max = 400,
    Rounding = 0,
    Callback = function(v)
        Settings.FOVRadius = v
        fov_circle.Radius = v
    end,
})

FOVGroup:AddToggle("ShowSilentAimTarget", {
    Text = "Show Silent Aim Target",
    Default = false,
    Callback = function(v) Settings.ShowSilentAimTarget = v end,
})

-- ============ UI SETTINGS TAB ============
local MenuGroup = Tabs["UI Settings"]:AddLeftGroupbox("Menu")
MenuGroup:AddButton("Unload", function()
    Library:Unload()
    if fov_circle then pcall(function() fov_circle:Remove() end) end
    if mouse_box then pcall(function() mouse_box:Remove() end) end
    for _, p in ipairs(Players:GetPlayers()) do clearESP(p) end
end)

MenuGroup:AddLabel("Menu Bind"):AddKeyPicker("MenuKeybind", {
    Default = "RightShift",
    NoUI = true,
    Text = "Menu Keybind",
})

Library.ToggleKeybind = Options.MenuKeybind

-- ============ HOME TAB (UPDATE LOG) ============
Tabs.Home:AddHomeTab({
    Welcome = {
        Title = "Welcome to SPENT HUB",
        Description = "Built for Prison Life. Silent aim, ESP, target team filters. Press RightShift to toggle this menu.",
    },
    Changelog = {
        {
            Title = "v16.0 — Linoria Rewrite",
            Date = "Today",
            Description = "Replaced the custom GUI with the Linoria library. Added keybind manager, theme manager, and save manager from Linoria. Removed Smart Symbol section. Silent aim core unchanged, credits now say SPENT.",
        },
        {
            Title = "v15.0 — Attributes",
            Date = "Previous",
            Description = "Added Hostile and Trespassing attribute filters for inmates. Added screen dim overlay. Optimized ESP to 30Hz updates with 10Hz highlight refresh.",
        },
        {
            Title = "v14.0 — Target Team",
            Date = "Older",
            Description = "Added Cop / Inmate / Criminal target filtering. Silent aim only locks onto enabled classes.",
        },
    },
})

-- ============ SAVE MANAGER + THEME MANAGER ============
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ "MenuKeybind" })
ThemeManager:SetFolder("SpentHub")
SaveManager:SetFolder("SpentHub/PrisonLife")
SaveManager:BuildConfigSection(Tabs["UI Settings"])
ThemeManager:ApplyToTab(Tabs["UI Settings"])
SaveManager:LoadAutoloadConfig()

print("SPENT HUB v16.0 loaded (Linoria).")
