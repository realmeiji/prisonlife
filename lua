-- init if not game:IsLoaded() then game.Loaded:Wait() end if not syn or not protectgui then getgenv().protectgui = function() end end

-- ============ STARTUP NOTIFICATION ============
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

local startupGui = Instance.new("ScreenGui")
startupGui.Name = "SpentHubStartup"
startupGui.ResetOnSpawn = false
startupGui.IgnoreGuiInset = true
startupGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
startupGui.DisplayOrder = 200
startupGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local startupFrame = Instance.new("Frame", startupGui)
startupFrame.Size = UDim2.new(0, 300, 0, 60)
startupFrame.Position = UDim2.new(0.5, -150, 0, -80)
startupFrame.BackgroundColor3 = Color3.fromRGB(32, 32, 38)
startupFrame.BackgroundTransparency = 0.05
startupFrame.BorderSizePixel = 0
Instance.new("UICorner", startupFrame).CornerRadius = UDim.new(0.2, 0)
local startupStroke = Instance.new("UIStroke", startupFrame)
startupStroke.Color = Color3.fromRGB(255, 182, 193)
startupStroke.Thickness = 1
local startupGlow = Instance.new("UIStroke", startupFrame)
startupGlow.Color = Color3.fromRGB(255, 182, 193)
startupGlow.Thickness = 4
startupGlow.Transparency = 0.7
Instance.new("UICorner", startupGlow).CornerRadius = UDim.new(0.2, 0)

local startupTitle = Instance.new("TextLabel", startupFrame)
startupTitle.Size = UDim2.new(1, -20, 0, 26)
startupTitle.Position = UDim2.new(0, 14, 0, 6)
startupTitle.BackgroundTransparency = 1
startupTitle.Text = "Starting Spent Hub..."
startupTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
startupTitle.Font = Enum.Font.GothamBold
startupTitle.TextSize = 14
startupTitle.TextXAlignment = Enum.TextXAlignment.Left

local startupSub = Instance.new("TextLabel", startupFrame)
startupSub.Size = UDim2.new(1, -20, 0, 16)
startupSub.Position = UDim2.new(0, 14, 0, 32)
startupSub.BackgroundTransparency = 1
startupSub.Text = "loading modules · please wait"
startupSub.TextColor3 = Color3.fromRGB(180, 180, 190)
startupSub.Font = Enum.Font.Gotham
startupSub.TextSize = 11
startupSub.TextXAlignment = Enum.TextXAlignment.Left

local startupBar = Instance.new("Frame", startupFrame)
startupBar.Size = UDim2.new(1, -28, 0, 3)
startupBar.Position = UDim2.new(0, 14, 1, -8)
startupBar.BackgroundColor3 = Color3.fromRGB(48, 48, 56)
startupBar.BorderSizePixel = 0
Instance.new("UICorner", startupBar).CornerRadius = UDim.new(1, 0)

local startupFill = Instance.new("Frame", startupBar)
startupFill.Size = UDim2.new(0, 0, 1, 0)
startupFill.BackgroundColor3 = Color3.fromRGB(255, 182, 193)
startupFill.BorderSizePixel = 0
Instance.new("UICorner", startupFill).CornerRadius = UDim.new(1, 0)

TweenService:Create(startupFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
    Position = UDim2.new(0.5, -150, 0, 30)
}):Play()
TweenService:Create(startupFill, TweenInfo.new(3, Enum.EasingStyle.Linear), {
    Size = UDim2.new(1, 0, 1, 0)
}):Play()

task.spawn(function()
    for _ = 1, 6 do
        pcall(function()
            TweenService:Create(startupGlow, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0.4}):Play()
        end)
        task.wait(0.25)
        pcall(function()
            TweenService:Create(startupGlow, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0.7}):Play()
        end)
        task.wait(0.25)
    end
end)

task.wait(3)

TweenService:Create(startupFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
    Position = UDim2.new(0.5, -150, 0, -80),
    BackgroundTransparency = 1
}):Play()
TweenService:Create(startupTitle, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
TweenService:Create(startupSub, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
TweenService:Create(startupStroke, TweenInfo.new(0.3), {Transparency = 1}):Play()
TweenService:Create(startupGlow, TweenInfo.new(0.3), {Transparency = 1}):Play()
task.wait(0.35)
pcall(function() startupGui:Destroy() end)

-- ============ MAIN SCRIPT ============
local SilentAimSettings = {
    Enabled = false,
    ClassName = "Universal Silent Aim - Averiias, Stefanuk12, xaxa",
    ToggleKey = "RightAlt",
    TeamCheck = false,
    VisibleCheck = false,
    TargetPart = "HumanoidRootPart",
    SilentAimMethod = "Raycast",
    FOVRadius = 130,
    FOVVisible = false,
    ShowSilentAimTarget = false,
    MouseHitPrediction = false,
    MouseHitPredictionAmount = 0.165,
    HitChance = 100,
    TargetCop = true,
    TargetInmate = true,
    TargetCriminal = true,
    TargetHostile = true,
    TargetTrespassing = true,
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
getgenv().SilentAimSettings = SilentAimSettings

local TARGET_LOCK_COLOR = Color3.fromRGB(255, 182, 193)
local RING_IDLE_COLOR   = Color3.fromRGB(255, 255, 255)

local MainFileName = "UniversalSilentAim"
local SelectedFile, FileToSave = "", ""
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local Mouse = LocalPlayer:GetMouse()
local GetChildren = game.GetChildren
local GetPlayers = Players.GetPlayers
local WorldToScreen = Camera.WorldToScreenPoint
local WorldToViewportPoint = Camera.WorldToViewportPoint
local GetPartsObscuringTarget = Camera.GetPartsObscuringTarget
local FindFirstChild = game.FindFirstChild
local RenderStepped = RunService.RenderStepped
local GuiInset = GuiService.GetGuiInset
local GetMouseLocation = UserInputService.GetMouseLocation
local resume = coroutine.resume
local create = coroutine.create
local ValidTargetParts = {"Head", "HumanoidRootPart"}
local PredictionAmount = 0.165

local mouse_box = Drawing.new("Square")
mouse_box.Visible = true
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
function CalculateChance(Percentage)
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

do
    if not isfolder(MainFileName) then makefolder(MainFileName); end
    if not isfolder(string.format("%s/%s", MainFileName, tostring(game.PlaceId))) then
        makefolder(string.format("%s/%s", MainFileName, tostring(game.PlaceId)))
    end
end

local Files = listfiles(string.format("%s/%s", "UniversalSilentAim", tostring(game.PlaceId)))

local function GetFiles()
    local out = {}
    for i = 1, #Files do
        local file = Files[i]
        if file:sub(-4) == '.lua' then
            local pos = file:find('.lua', 1, true)
            local start = pos
            local char = file:sub(pos, pos)
            while char ~= '/' and char ~= '\\' and char ~= '' do
                pos = pos - 1
                char = file:sub(pos, pos)
            end
            if char == '/' or char == '\\' then
                table.insert(out, file:sub(pos + 1, start - 1))
            end
        end
    end
    return out
end

local function UpdateFile(FileName)
    assert(FileName or FileName == "string", "oopsies");
    writefile(string.format("%s/%s/%s.lua", MainFileName, tostring(game.PlaceId), FileName), HttpService:JSONEncode(SilentAimSettings))
end

local function LoadFile(FileName)
    assert(FileName or FileName == "string", "oopsies");
    local File = string.format("%s/%s/%s.lua", MainFileName, tostring(game.PlaceId), FileName)
    local ConfigData = HttpService:JSONDecode(readfile(File))
    for Index, Value in next, ConfigData do SilentAimSettings[Index] = Value end
end

local function getPositionOnScreen(Vector)
    local Vec3, OnScreen = WorldToScreen(Camera, Vector)
    return Vector2.new(Vec3.X, Vec3.Y), OnScreen
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
    if not (PlayerCharacter or LocalPlayerCharacter) then return end
    local PlayerRoot = FindFirstChild(PlayerCharacter, SilentAimSettings.TargetPart) or FindFirstChild(PlayerCharacter, "HumanoidRootPart")
    if not PlayerRoot then return end
    local CastPoints, IgnoreList = {PlayerRoot.Position, LocalPlayerCharacter, PlayerCharacter}, {LocalPlayerCharacter, PlayerCharacter}
    local ObscuringObjects = #GetPartsObscuringTarget(Camera, CastPoints, IgnoreList)
    return ((ObscuringObjects == 0 and true) or (ObscuringObjects > 0 and false))
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
        return Color3.fromRGB(255, 182, 193)
    end)
    if ok and color then return color end
    return Color3.fromRGB(255, 182, 193)
end

-- ============ FIXED TEAM DETECTION ============
local TEAM_NAMES = {
    Guard    = {"Guards", "Guard", "Police", "Cop", "Cops"},
    Inmate   = {"Inmates", "Inmate", "Prisoner", "Prisoners"},
    Criminal = {"Criminals", "Criminal", "Convict", "Convicts"},
}

local function teamMatchesKind(teamName, kind)
    for _, name in ipairs(TEAM_NAMES[kind]) do
        if teamName == name then return true end
    end
    return false
end

local function getTeamKind(plr)
    if not plr.Team then
        local char = plr.Character
        if char then
            local attr = char:GetAttribute("Team") or char:GetAttribute("Role")
            if type(attr) == "string" then
                if teamMatchesKind(attr, "Guard") then return "Guard" end
                if teamMatchesKind(attr, "Inmate") then return "Inmate" end
                if teamMatchesKind(attr, "Criminal") then return "Criminal" end
            end
        end
        return nil
    end
    local n = plr.Team.Name
    if teamMatchesKind(n, "Guard") then return "Guard" end
    if teamMatchesKind(n, "Inmate") then return "Inmate" end
    if teamMatchesKind(n, "Criminal") then return "Criminal" end
    return nil
end

local function getHostileState(plr)
    local char = plr.Character
    if not char then return false, false end
    local hostile = char:GetAttribute("Hostile")
    local trespass = char:GetAttribute("Trespassing")
    return (hostile == true), (trespass == true)
end

local function matchesTeam(Player)
    local kind = getTeamKind(Player)
    local hostile, trespass = getHostileState(Player)

    local allowGuard    = SilentAimSettings.TargetCop
    local allowInmate   = SilentAimSettings.TargetInmate
    local allowCriminal = SilentAimSettings.TargetCriminal
    local allowHostile  = SilentAimSettings.TargetHostile
    local allowTrespass = SilentAimSettings.TargetTrespassing

    if not (allowGuard or allowInmate or allowCriminal or allowHostile or allowTrespass) then
        return true
    end

    if allowHostile and hostile then return true end
    if allowTrespass and trespass then return true end

    if kind == "Guard"    and allowGuard    then return true end
    if kind == "Inmate"   and allowInmate   then return true end
    if kind == "Criminal" and allowCriminal then return true end

    return false
end
-- ============ END FIXED TEAM DETECTION ============

local function getClosestPlayer()
    if not SilentAimSettings.TargetPart then return end
    local Closest
    local DistanceToMouse
    for _, Player in next, GetPlayers(Players) do
        if Player == LocalPlayer then continue end
        if SilentAimSettings.TeamCheck and Player.Team == LocalPlayer.Team then continue end
        if not matchesTeam(Player) then continue end
        local Character = Player.Character
        if not Character then continue end
        if SilentAimSettings.VisibleCheck and not IsPlayerVisible(Player) then continue end
        local HumanoidRootPart = FindFirstChild(Character, "HumanoidRootPart")
        local Humanoid = FindFirstChild(Character, "Humanoid")
        if not HumanoidRootPart or not Humanoid or Humanoid and Humanoid.Health <= 0 then continue end
        local ScreenPosition, OnScreen = getPositionOnScreen(HumanoidRootPart.Position)
        if not OnScreen then continue end
        local Distance = (getMousePosition() - ScreenPosition).Magnitude
        if Distance <= (DistanceToMouse or SilentAimSettings.FOVRadius or 2000) then
            Closest = ((SilentAimSettings.TargetPart == "Random" and Character[ValidTargetParts[math.random(1, #ValidTargetParts)]]) or Character[SilentAimSettings.TargetPart])
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
    d.name.Color = Color3.fromRGB(255, 255, 255)
    d.name.Visible = false

    d.hpBack.Thickness = 3
    d.hpBack.Color = Color3.fromRGB(30, 30, 30)
    d.hpBack.Visible = false

    d.hpBar.Thickness = 3
    d.hpBar.Color = Color3.fromRGB(80, 255, 100)
    d.hpBar.Visible = false

    d.trace.Thickness = 1
    d.trace.Color = Color3.fromRGB(255, 255, 255)
    d.trace.Visible = false

    espCache[player] = d
    return d
end

local function clearESP(player)
    local d = espCache[player]
    if d then
        for key, obj in pairs(d) do
            if key ~= "lastUpdate" and typeof(obj) == "userdata" then
                pcall(function() obj:Remove() end)
            end
        end
        espCache[player] = nil
    end
end

Players.PlayerRemoving:Connect(function(player) clearESP(player) end)

local function hideESP(d)
    if d.name.Visible then d.name.Visible = false end
    if d.hpBack.Visible then d.hpBack.Visible = false end
    if d.hpBar.Visible then d.hpBar.Visible = false end
    if d.trace.Visible then d.trace.Visible = false end
end

local function updateESP()
    local now = tick()
    if now - lastESPUpdate < ESP_UPDATE_INTERVAL then
        return
    end
    lastESPUpdate = now

    local canUpdateHighlight = (now - lastHighlightUpdate) >= HIGHLIGHT_CHECK_INTERVAL
    if canUpdateHighlight then
        lastHighlightUpdate = now
    end

    local camPos = Camera.CFrame.Position
    local viewport = Camera.ViewportSize
    local centerX = viewport.X / 2
    local viewportY = viewport.Y
    local maxDist = SilentAimSettings.ESP_MaxDistance * DISTANCE_CULL
    local espEnabled = SilentAimSettings.ESP_Enabled

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

        if not d then
            d = newESP(player)
        end

        local head = char:FindFirstChild("Head") or hrp
        local screenHead, onScreen = WorldToViewportPoint(Camera, head.Position + Vector3.new(0, 1.5, 0))
        if not onScreen then
            hideESP(d)
            continue
        end

        if SilentAimSettings.ESP_Name then
            if not d.name.Visible then d.name.Visible = true end
            d.name.Text = player.DisplayName
            d.name.Position = Vector2.new(screenHead.X, screenHead.Y - 20)
            d.name.Color = SilentAimSettings.ESP_NameColor
        elseif d.name.Visible then
            d.name.Visible = false
        end

        if SilentAimSettings.ESP_Health then
            local topY = screenHead.Y - 32
            if not d.hpBack.Visible then d.hpBack.Visible = true end
            if not d.hpBar.Visible then d.hpBar.Visible = true end
            d.hpBack.From = Vector2.new(screenHead.X - 28, topY)
            d.hpBack.To = Vector2.new(screenHead.X + 28, topY)
            local pct = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
            d.hpBar.From = Vector2.new(screenHead.X - 28, topY)
            d.hpBar.To = Vector2.new(screenHead.X - 28 + 56 * pct, topY)
            d.hpBar.Color = SilentAimSettings.ESP_HPColor
        else
            if d.hpBack.Visible then d.hpBack.Visible = false end
            if d.hpBar.Visible then d.hpBar.Visible = false end
        end

        if SilentAimSettings.ESP_Trace then
            if not d.trace.Visible then d.trace.Visible = true end
            d.trace.From = Vector2.new(centerX, viewportY)
            d.trace.To = Vector2.new(screenHead.X, screenHead.Y)
            local tc = SilentAimSettings.ESP_Team and getTeamColor(player) or SilentAimSettings.ESP_TraceColor
            if d.trace.Color ~= tc then
                d.trace.Color = tc
            end
        elseif d.trace.Visible then
            d.trace.Visible = false
        end

        if canUpdateHighlight then
            if SilentAimSettings.ESP_Highlight then
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
                elseif SilentAimSettings.ESP_Team then
                    wantColor = getTeamColor(player)
                else
                    wantColor = SilentAimSettings.ESP_HighlightColor
                end

                if hl.OutlineColor ~= wantColor then
                    hl.OutlineColor = wantColor
                end
            else
                local hl = char:FindFirstChild("SpentHubHL")
                if hl then hl:Destroy() end
            end
        end
    end
end

-- ============ SPENT HUB GUI ============
local Theme = {
    ACCENT = Color3.fromRGB(255, 182, 193),
    ACCENT2 = Color3.fromRGB(200, 140, 200),
    BG_MAIN = Color3.fromRGB(15, 15, 18),
    BG_PANEL = Color3.fromRGB(22, 22, 26),
    BG_OPT = Color3.fromRGB(32, 32, 38),
    BG_HOVER = Color3.fromRGB(44, 44, 52),
    BORDER = Color3.fromRGB(58, 58, 66),
    TEXT = Color3.fromRGB(240, 240, 245),
    TEXT_DIM = Color3.fromRGB(155, 155, 165),
    TEXT_STRONG = Color3.fromRGB(255, 255, 255),
    ICON = "거",
}

local gui = Instance.new("ScreenGui")
gui.Name = "SpentHub"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 100
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local shadow = Instance.new("Frame", gui)
shadow.Size = UDim2.new(0, 750, 0, 450)
shadow.Position = UDim2.new(0.5, -375, 0.5, -225)
shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
shadow.BackgroundTransparency = 0.7
shadow.BorderSizePixel = 0
shadow.ZIndex = 99
Instance.new("UICorner", shadow).CornerRadius = UDim.new(0.02, 0)

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 740, 0, 440)
main.Position = UDim2.new(0.5, -370, 0.5, -220)
main.BackgroundColor3 = Theme.BG_MAIN
main.BackgroundTransparency = 0.03
main.BorderSizePixel = 0
main.Active = false
main.ZIndex = 100
Instance.new("UICorner", main).CornerRadius = UDim.new(0.02, 0)
shadow.Position = main.Position + UDim2.new(0, -5, 0, -5)

local mainStroke = Instance.new("UIStroke", main)
mainStroke.Color = Theme.BORDER
mainStroke.Thickness = 1
mainStroke.Transparency = 0.3

local mainGlow = Instance.new("UIStroke", main)
mainGlow.Color = Theme.ACCENT
mainGlow.Thickness = 3
mainGlow.Transparency = 0.88
Instance.new("UICorner", mainGlow).CornerRadius = UDim.new(0.02, 0)

main:GetPropertyChangedSignal("Position"):Connect(function()
    shadow.Position = main.Position + UDim2.new(0, -5, 0, -5)
end)
main:GetPropertyChangedSignal("Visible"):Connect(function()
    shadow.Visible = main.Visible
end)

task.spawn(function()
    while gui.Parent and main.Parent do
        pcall(function()
            TweenService:Create(mainGlow, TweenInfo.new(2.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0.7}):Play()
        end)
        task.wait(2.4)
        pcall(function()
            TweenService:Create(mainGlow, TweenInfo.new(2.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0.92}):Play()
        end)
        task.wait(2.4)
    end
end)

local titleBar = Instance.new("Frame", main)
titleBar.Size = UDim2.new(1, 0, 0, 38)
titleBar.BackgroundColor3 = Theme.BG_PANEL
titleBar.BackgroundTransparency = 0.15
titleBar.BorderSizePixel = 0
titleBar.ZIndex = 101
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0.035, 0)

local icon = Instance.new("TextLabel", titleBar)
icon.Size = UDim2.new(0, 34, 1, 0)
icon.Position = UDim2.new(0, 12, 0, 0)
icon.BackgroundTransparency = 1
icon.Text = Theme.ICON
icon.TextColor3 = Theme.ACCENT
icon.Font = Enum.Font.GothamBold
icon.TextSize = 22
icon.ZIndex = 102

task.spawn(function()
    while gui.Parent and icon.Parent do
        pcall(function() TweenService:Create(icon, TweenInfo.new(1.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {TextTransparency = 0.35}):Play() end)
        task.wait(1.6)
        pcall(function() TweenService:Create(icon, TweenInfo.new(1.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {TextTransparency = 0}):Play() end)
        task.wait(1.6)
    end
end)

local title = Instance.new("TextLabel", titleBar)
title.Size = UDim2.new(1, -240, 1, 0)
title.Position = UDim2.new(0, 50, 0, 0)
title.BackgroundTransparency = 1
title.Text = "SPENT HUB · v15.2"
title.TextColor3 = Theme.TEXT_STRONG
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 102

local drag = Instance.new("TextButton", titleBar)
drag.Size = UDim2.new(1, -240, 1, 0)
drag.Position = UDim2.new(0, 50, 0, 0)
drag.BackgroundTransparency = 1
drag.Text = ""
drag.AutoButtonColor = false
drag.Draggable = true
drag.Active = true
drag.ZIndex = 103

local function makeTitleBtn(symbol, orderX)
    local btn = Instance.new("TextButton", titleBar)
    btn.Size = UDim2.new(0, 24, 0, 24)
    btn.Position = UDim2.new(1, orderX, 0.5, -12)
    btn.BackgroundColor3 = Theme.BG_OPT
    btn.Text = symbol
    btn.TextColor3 = Theme.TEXT
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    btn.ZIndex = 103
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0.3, 0)
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Theme.BG_HOVER, TextColor3 = Theme.TEXT_STRONG}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Theme.BG_OPT, TextColor3 = Theme.TEXT}):Play()
    end)
    return btn
end

local compactBtn = makeTitleBtn("−", -90)
local closeBtn = makeTitleBtn("×", -58)

local statusStrip = Instance.new("Frame", main)
statusStrip.Size = UDim2.new(1, 0, 0, 24)
statusStrip.Position = UDim2.new(0, 0, 0, 38)
statusStrip.BackgroundColor3 = Theme.BG_PANEL
statusStrip.BackgroundTransparency = 0.4
statusStrip.BorderSizePixel = 0
statusStrip.ZIndex = 101

local statusLabel = Instance.new("TextLabel", statusStrip)
statusLabel.Size = UDim2.new(1, -260, 1, 0)
statusLabel.Position = UDim2.new(0, 16, 0, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "● idle · method: Raycast · fov: 130"
statusLabel.TextColor3 = Theme.TEXT_DIM
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 10
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.ZIndex = 102

local searchBox = Instance.new("TextBox", statusStrip)
searchBox.Size = UDim2.new(0, 220, 0, 16)
searchBox.Position = UDim2.new(1, -236, 0.5, -8)
searchBox.BackgroundColor3 = Theme.BG_OPT
searchBox.Text = ""
searchBox.PlaceholderText = "search options..."
searchBox.TextColor3 = Theme.TEXT
searchBox.PlaceholderColor3 = Theme.TEXT_DIM
searchBox.Font = Enum.Font.Gotham
searchBox.TextSize = 10
searchBox.BorderSizePixel = 0
searchBox.ClearTextOnFocus = false
searchBox.ZIndex = 102Instance.new("UICorner", searchBox).CornerRadius = UDim.new(0.4, 0)

local sidebar = Instance.new("Frame", main)
sidebar.Size = UDim2.new(0, 140, 1, -100)
sidebar.Position = UDim2.new(0, 10, 0, 72)
sidebar.BackgroundColor3 = Theme.BG_PANEL
sidebar.BackgroundTransparency = 0.15
sidebar.BorderSizePixel = 0
sidebar.ZIndex = 101
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0.05, 0)
local sidebarLayout = Instance.new("UIListLayout", sidebar)
sidebarLayout.Padding = UDim.new(0, 5)
sidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
local sidebarPad = Instance.new("UIPadding", sidebar)
sidebarPad.PaddingTop = UDim.new(0, 8)
sidebarPad.PaddingLeft = UDim.new(0, 8)
sidebarPad.PaddingRight = UDim.new(0, 8)

local content = Instance.new("Frame", main)
content.Size = UDim2.new(1, -168, 1, -100)
content.Position = UDim2.new(0, 158, 0, 72)
content.BackgroundColor3 = Theme.BG_PANEL
content.BackgroundTransparency = 0.05
content.BorderSizePixel = 0
content.ZIndex = 101
Instance.new("UICorner", content).CornerRadius = UDim.new(0.035, 0)
local contentStroke = Instance.new("UIStroke", content)
contentStroke.Color = Theme.BORDER
contentStroke.Thickness = 1
contentStroke.Transparency = 0.4

local accentLine = Instance.new("Frame", content)
accentLine.Size = UDim2.new(0, 60, 0, 2)
accentLine.Position = UDim2.new(0, 14, 0, 34)
accentLine.BackgroundColor3 = Theme.ACCENT
accentLine.BorderSizePixel = 0
accentLine.ZIndex = 102
Instance.new("UICorner", accentLine).CornerRadius = UDim.new(1, 0)
local accentGradient = Instance.new("UIGradient", accentLine)
accentGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Theme.ACCENT),
    ColorSequenceKeypoint.new(1, Theme.ACCENT2),
})

local function animateAccentLine()
    accentLine.Size = UDim2.new(0, 0, 0, 2)
    accentLine.BackgroundTransparency = 0
    TweenService:Create(accentLine, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 60, 0, 2)}):Play()
end

local contentHeader = Instance.new("TextLabel", content)
contentHeader.Size = UDim2.new(1, -20, 0, 26)
contentHeader.Position = UDim2.new(0, 14, 0, 6)
contentHeader.BackgroundTransparency = 1
contentHeader.Text = "MAIN"
contentHeader.TextColor3 = Theme.ACCENT
contentHeader.Font = Enum.Font.GothamBold
contentHeader.TextSize = 11
contentHeader.TextXAlignment = Enum.TextXAlignment.Left
contentHeader.ZIndex = 102

local scroll = Instance.new("ScrollingFrame", content)
scroll.Size = UDim2.new(1, -18, 1, -42)
scroll.Position = UDim2.new(0, 10, 0, 36)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 3
scroll.ScrollBarImageColor3 = Theme.BORDER
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.ScrollingDirection = Enum.ScrollingDirection.Y
scroll.ClipsDescendants = true
scroll.ZIndex = 102

local scrollLayout = Instance.new("UIListLayout", scroll)
scrollLayout.Padding = UDim.new(0, 6)
scrollLayout.SortOrder = Enum.SortOrder.LayoutOrder

local hubToggleBtn = Instance.new("TextButton", gui)
hubToggleBtn.Size = UDim2.new(0, 46, 0, 46)
hubToggleBtn.Position = UDim2.new(0, 26, 0.5, -23)
hubToggleBtn.BackgroundColor3 = Theme.BG_PANEL
hubToggleBtn.BackgroundTransparency = 0.1
hubToggleBtn.Text = Theme.ICON
hubToggleBtn.TextColor3 = Theme.ACCENT
hubToggleBtn.Font = Enum.Font.GothamBold
hubToggleBtn.TextSize = 24
hubToggleBtn.BorderSizePixel = 0
hubToggleBtn.Visible = false
hubToggleBtn.Active = true
hubToggleBtn.Draggable = true
hubToggleBtn.ZIndex = 50
Instance.new("UICorner", hubToggleBtn).CornerRadius = UDim.new(1, 0)
local hubStroke = Instance.new("UIStroke", hubToggleBtn)
hubStroke.Color = Theme.BORDER
hubStroke.Thickness = 1
local hubGlow = Instance.new("UIStroke", hubToggleBtn)
hubGlow.Color = Theme.ACCENT
hubGlow.Thickness = 4
hubGlow.Transparency = 0.9
Instance.new("UICorner", hubGlow).CornerRadius = UDim.new(1, 0)

hubToggleBtn.MouseEnter:Connect(function()
    TweenService:Create(hubToggleBtn, TweenInfo.new(0.18, Enum.EasingStyle.Quart), {
        BackgroundColor3 = Theme.ACCENT,
        TextColor3 = Color3.fromRGB(15, 15, 18),
        Size = UDim2.new(0, 50, 0, 50),
        Position = UDim2.new(0, 24, 0.5, -25)
    }):Play()
end)
hubToggleBtn.MouseLeave:Connect(function()
    TweenService:Create(hubToggleBtn, TweenInfo.new(0.18, Enum.EasingStyle.Quart), {
        BackgroundColor3 = Theme.BG_PANEL,
        TextColor3 = Theme.ACCENT,
        Size = UDim2.new(0, 46, 0, 46),
        Position = UDim2.new(0, 26, 0.5, -23)
    }):Play()
end)

-- ============ NOTIFICATIONS (upgraded) ============
local notifFrame = Instance.new("Frame", gui)
notifFrame.Size = UDim2.new(0, 320, 0, 400)
notifFrame.Position = UDim2.new(1, -340, 0, 110)
notifFrame.BackgroundTransparency = 1
notifFrame.ZIndex = 500
local notifLayout = Instance.new("UIListLayout", notifFrame)
notifLayout.Padding = UDim.new(0, 8)
notifLayout.SortOrder = Enum.SortOrder.LayoutOrder

local NOTIF_ICON = {
    on = "+",
    off = "×",
    gear = "⚙",
    info = "i",
    warn = "!",
    success = "✓",
    error = "✕",
    save = "⇩",
    load = "⇧",
    accent = "◉",
    boot = "◈",
}

local notifQueue = 0
local notifStaggerDelay = 0.04

local function pickIcon(text)
    local lower = string.lower(text)
    if lower:find("enabled") then return NOTIF_ICON.on end
    if lower:find("disabled") then return NOTIF_ICON.off end
    if lower:find("loaded") then return NOTIF_ICON.load end
    if lower:find("saved") or lower:find("created") then return NOTIF_ICON.save end
    if lower:find("accent") then return NOTIF_ICON.accent end
    if lower:find("starting") or lower:find("spent hub") then return NOTIF_ICON.boot end
    if lower:find("fail") or lower:find("error") then return NOTIF_ICON.error end
    return NOTIF_ICON.info
end

local function notify(text, color)
    color = color or Theme.ACCENT
    notifQueue = notifQueue + 1
    local myOrder = notifQueue

    task.delay((myOrder - 1) * notifStaggerDelay, function()
        local LIFETIME = 3.2
        local paused = false
        local remaining = LIFETIME
        local lastTick = tick()

        local wrap = Instance.new("Frame", notifFrame)
        wrap.Size = UDim2.new(1, 0, 0, 44)
        wrap.BackgroundTransparency = 1
        wrap.ZIndex = 501

        local shadowCard = Instance.new("Frame", wrap)
        shadowCard.Size = UDim2.new(1, 0, 1, 0)
        shadowCard.Position = UDim2.new(0, 2, 0, 2)
        shadowCard.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        shadowCard.BackgroundTransparency = 0.6
        shadowCard.BorderSizePixel = 0
        shadowCard.ZIndex = 501
        Instance.new("UICorner", shadowCard).CornerRadius = UDim.new(0.15, 0)

        local card = Instance.new("Frame", wrap)
        card.Size = UDim2.new(1, 0, 1, 0)
        card.BackgroundColor3 = Theme.BG_OPT
        card.BackgroundTransparency = 0.05
        card.BorderSizePixel = 0
        card.ZIndex = 502
        Instance.new("UICorner", card).CornerRadius = UDim.new(0.15, 0)

        local stroke = Instance.new("UIStroke", card)
        stroke.Color = color
        stroke.Thickness = 1
        stroke.Transparency = 0.3

        local glow = Instance.new("UIStroke", card)
        glow.Color = color
        glow.Thickness = 3
        glow.Transparency = 0.85
        Instance.new("UICorner", glow).CornerRadius = UDim.new(0.15, 0)

        local bar = Instance.new("Frame", card)
        bar.Size = UDim2.new(0, 3, 1, -8)
        bar.Position = UDim2.new(0, 4, 0, 4)
        bar.BackgroundColor3 = color
        bar.BorderSizePixel = 0
        bar.ZIndex = 503
        Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)

        local iconCircle = Instance.new("Frame", card)
        iconCircle.Size = UDim2.new(0, 22, 0, 22)
        iconCircle.Position = UDim2.new(0, 12, 0.5, -11)
        iconCircle.BackgroundColor3 = color
        iconCircle.BackgroundTransparency = 0.15
        iconCircle.BorderSizePixel = 0
        iconCircle.ZIndex = 503
        Instance.new("UICorner", iconCircle).CornerRadius = UDim.new(1, 0)

        local iconLabel = Instance.new("TextLabel", iconCircle)
        iconLabel.Size = UDim2.new(1, 0, 1, 0)
        iconLabel.BackgroundTransparency = 1
        iconLabel.Text = pickIcon(text)
        iconLabel.TextColor3 = Color3.fromRGB(15, 15, 18)
        iconLabel.Font = Enum.Font.GothamBold
        iconLabel.TextSize = 13
        iconLabel.ZIndex = 504

        local lbl = Instance.new("TextLabel", card)
        lbl.Size = UDim2.new(1, -50, 1, -6)
        lbl.Position = UDim2.new(0, 42, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = text
        lbl.TextColor3 = Theme.TEXT_STRONG
        lbl.Font = Enum.Font.GothamMedium
        lbl.TextSize = 12
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.TextYAlignment = Enum.TextYAlignment.Center
        lbl.ZIndex = 503

        local progressTrack = Instance.new("Frame", card)
        progressTrack.Size = UDim2.new(1, -12, 0, 2)
        progressTrack.Position = UDim2.new(0, 6, 1, -5)
        progressTrack.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        progressTrack.BorderSizePixel = 0
        progressTrack.ZIndex = 503
        Instance.new("UICorner", progressTrack).CornerRadius = UDim.new(1, 0)

        local progressFill = Instance.new("Frame", progressTrack)
        progressFill.Size = UDim2.new(1, 0, 1, 0)
        progressFill.BackgroundColor3 = color
        progressFill.BorderSizePixel = 0
        progressFill.ZIndex = 504
        Instance.new("UICorner", progressFill).CornerRadius = UDim.new(1, 0)

        wrap.Position = UDim2.new(1.15, 0, 0, 0)
        wrap.BackgroundTransparency = 1
        card.BackgroundTransparency = 1
        shadowCard.BackgroundTransparency = 1
        lbl.TextTransparency = 1
        iconLabel.TextTransparency = 1
        bar.BackgroundTransparency = 1

        TweenService:Create(wrap, TweenInfo.new(0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0.02, 0, 0, 0)}):Play()
        task.delay(0.2, function()
            TweenService:Create(wrap, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0)}):Play()
        end)
        TweenService:Create(card, TweenInfo.new(0.2), {BackgroundTransparency = 0.05}):Play()
        TweenService:Create(shadowCard, TweenInfo.new(0.2), {BackgroundTransparency = 0.6}):Play()
        TweenService:Create(lbl, TweenInfo.new(0.2), {TextTransparency = 0}):Play()
        TweenService:Create(iconLabel, TweenInfo.new(0.2), {TextTransparency = 0}):Play()
        TweenService:Create(bar, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()

        local dying = false
        local function destroyNotif()
            if dying then return end
            dying = true
            TweenService:Create(wrap, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
                Position = UDim2.new(1.15, 0, 0, 0),
            }):Play()
            TweenService:Create(card, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
            TweenService:Create(shadowCard, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
            TweenService:Create(lbl, TweenInfo.new(0.2), {TextTransparency = 1}):Play()
            TweenService:Create(iconLabel, TweenInfo.new(0.2), {TextTransparency = 1}):Play()
            TweenService:Create(bar, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
            TweenService:Create(progressFill, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
            task.wait(0.25)
            pcall(function() wrap:Destroy() end)
        end

        card.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                destroyNotif()
            end
        end)

        card.MouseEnter:Connect(function()
            paused = true
            TweenService:Create(stroke, TweenInfo.new(0.15), {Transparency = 0}):Play()
            TweenService:Create(glow, TweenInfo.new(0.15), {Transparency = 0.6}):Play()
        end)
        card.MouseLeave:Connect(function()
            paused = false
            TweenService:Create(stroke, TweenInfo.new(0.15), {Transparency = 0.3}):Play()
            TweenService:Create(glow, TweenInfo.new(0.15), {Transparency = 0.85}):Play()
        end)

        task.spawn(function()
            while not dying do
                task.wait(0.05)
                local now = tick()
                local dt = now - lastTick
                lastTick = now
                if not paused then
                    remaining = remaining - dt
                    if remaining <= 0 then
                        destroyNotif()
                        break
                    end
                    local pct = math.clamp(remaining / LIFETIME, 0, 1)
                    progressFill.Size = UDim2.new(pct, 0, 1, 0)
                end
            end
        end)
    end)
end

local function makeSection(text)
    local s = Instance.new("TextLabel", scroll)
    s.Size = UDim2.new(1, 0, 0, 18)
    s.BackgroundTransparency = 1
    s.Text = "  " .. text
    s.TextColor3 = Theme.TEXT_DIM
    s.Font = Enum.Font.GothamBold
    s.TextSize = 10
    s.TextXAlignment = Enum.TextXAlignment.Left
end

local function makeToggle(name, default, callback, tooltip)
    local btn = Instance.new("TextButton", scroll)
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.BackgroundColor3 = Theme.BG_OPT
    btn.BackgroundTransparency = 0.05
    btn.Text = ""
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    btn.Name = name
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0.2, 0)
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Theme.BORDER
    stroke.Thickness = 1
    stroke.Transparency = 0.4

    local glow = Instance.new("UIStroke", btn)
    glow.Color = Theme.ACCENT
    glow.Thickness = 3
    glow.Transparency = 1
    Instance.new("UICorner", glow).CornerRadius = UDim.new(0.2, 0)

    local lbl = Instance.new("TextLabel", btn)
    lbl.Size = UDim2.new(0.7, 0, 1, 0)
    lbl.Position = UDim2.new(0, 12, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = name
    lbl.TextColor3 = Theme.TEXT
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local ind = Instance.new("Frame", btn)
    ind.Size = UDim2.new(0, 34, 0, 16)
    ind.Position = UDim2.new(1, -46, 0.5, -8)
    ind.BackgroundColor3 = default and Theme.ACCENT or Color3.fromRGB(48, 48, 56)
    ind.BorderSizePixel = 0
    Instance.new("UICorner", ind).CornerRadius = UDim.new(1, 0)

    local indGlow = Instance.new("UIStroke", ind)
    indGlow.Color = Theme.ACCENT
    indGlow.Thickness = 2
    indGlow.Transparency = default and 0.4 or 1
    Instance.new("UICorner", indGlow).CornerRadius = UDim.new(1, 0)

    local dot = Instance.new("Frame", ind)
    dot.Size = UDim2.new(0, 12, 0, 12)
    dot.Position = default and UDim2.new(1, -14, 0.5, -6) or UDim2.new(0, 2, 0.5, -6)
    dot.BackgroundColor3 = Color3.fromRGB(250, 250, 250)
    dot.BorderSizePixel = 0
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

    local state = default
    btn.MouseButton1Click:Connect(function()
        state = not state
        TweenService:Create(dot, TweenInfo.new(0.15, Enum.EasingStyle.Quart), {Position = state and UDim2.new(1, -14, 0.5, -6) or UDim2.new(0, 2, 0.5, -6)}):Play()
        TweenService:Create(ind, TweenInfo.new(0.15), {BackgroundColor3 = state and Theme.ACCENT or Color3.fromRGB(48, 48, 56)}):Play()
        TweenService:Create(indGlow, TweenInfo.new(0.15), {Transparency = state and 0.4 or 1}):Play()
        TweenService:Create(glow, TweenInfo.new(0.18), {Transparency = state and 0.7 or 1}):Play()
        callback(state)
    end)

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0, BackgroundColor3 = Theme.BG_HOVER}):Play()
        TweenService:Create(stroke, TweenInfo.new(0.15), {Transparency = 0.1}):Play()
        if tooltip then statusLabel.Text = "  " .. tooltip end
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.05, BackgroundColor3 = Theme.BG_OPT}):Play()
        TweenService:Create(stroke, TweenInfo.new(0.15), {Transparency = 0.4}):Play()
        statusLabel.Text = "● idle · method: " .. SilentAimSettings.SilentAimMethod
    end)
    return btn
end

local function makeSlider(name, min, max, default, callback)
    local frame = Instance.new("Frame", scroll)
    frame.Size = UDim2.new(1, 0, 0, 42)
    frame.BackgroundColor3 = Theme.BG_OPT
    frame.BackgroundTransparency = 0.05
    frame.BorderSizePixel = 0
    frame.Name = name
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0.2, 0)
    local stroke = Instance.new("UIStroke", frame)
    stroke.Color = Theme.BORDER
    stroke.Thickness = 1
    stroke.Transparency = 0.4

    local lbl = Instance.new("TextLabel", frame)
    lbl.Size = UDim2.new(1, -20, 0, 16)
    lbl.Position = UDim2.new(0, 12, 0, 2)
    lbl.BackgroundTransparency = 1
    lbl.Text = name .. ": " .. tostring(default)
    lbl.TextColor3 = Theme.TEXT
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextSize = 10
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local bar = Instance.new("Frame", frame)
    bar.Size = UDim2.new(1, -24, 0, 6)
    bar.Position = UDim2.new(0, 12, 0, 26)
    bar.BackgroundColor3 = Color3.fromRGB(48, 48, 56)
    bar.BorderSizePixel = 0
    Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)

    local fill = Instance.new("Frame", bar)
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Theme.ACCENT
    fill.BorderSizePixel = 0
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

    local fillGlow = Instance.new("UIStroke", fill)
    fillGlow.Color = Theme.ACCENT
    fillGlow.Thickness = 2
    fillGlow.Transparency = 0.5
    Instance.new("UICorner", fillGlow).CornerRadius = UDim.new(1, 0)

    local dragging = false
    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = true end
    end)
    bar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local rel = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
            local val = math.floor(min + (max - min) * rel)
            fill.Size = UDim2.new(rel, 0, 1, 0)
            lbl.Text = name .. ": " .. tostring(val)
            callback(val)
        end
    end)
end

local function makeButton(name, callback, color)
    local btn = Instance.new("TextButton", scroll)
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.BackgroundColor3 = color or Theme.BG_OPT
    btn.BackgroundTransparency = 0.05
    btn.Text = name
    btn.TextColor3 = Theme.TEXT
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 11
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0.2, 0)
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Theme.BORDER
    stroke.Thickness = 1
    stroke.Transparency = 0.4
    btn.MouseButton1Click:Connect(callback)
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Theme.BG_HOVER, BackgroundTransparency = 0, TextColor3 = Theme.TEXT_STRONG}):Play()
        TweenService:Create(stroke, TweenInfo.new(0.15), {Transparency = 0.1}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = color or Theme.BG_OPT, BackgroundTransparency = 0.05, TextColor3 = Theme.TEXT}):Play()
        TweenService:Create(stroke, TweenInfo.new(0.15), {Transparency = 0.4}):Play()
    end)
end

local function makeDropdown(name, values, current, callback)
    local idx = 1
    for i, v in ipairs(values) do if v == current then idx = i; break end end
    local btn = Instance.new("TextButton", scroll)
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.BackgroundColor3 = Theme.BG_OPT
    btn.BackgroundTransparency = 0.05
    btn.Text = name .. ": " .. values[idx]
    btn.TextColor3 = Theme.TEXT
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 11
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0.2, 0)
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Theme.BORDER
    stroke.Thickness = 1
    stroke.Transparency = 0.4
    btn.MouseButton1Click:Connect(function()
        idx = idx + 1
        if idx > #values then idx = 1 end
        btn.Text = name .. ": " .. values[idx]
        callback(values[idx])
    end)
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Theme.BG_HOVER, BackgroundTransparency = 0, TextColor3 = Theme.TEXT_STRONG}):Play()
        TweenService:Create(stroke, TweenInfo.new(0.15), {Transparency = 0.1}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Theme.BG_OPT, BackgroundTransparency = 0.05, TextColor3 = Theme.TEXT}):Play()
        TweenService:Create(stroke, TweenInfo.new(0.15), {Transparency = 0.4}):Play()
    end)
end

local function makeInput(placeholder, callback)
    local box = Instance.new("TextBox", scroll)
    box.Size = UDim2.new(1, 0, 0, 30)
    box.BackgroundColor3 = Theme.BG_OPT
    box.BackgroundTransparency = 0.05
    box.PlaceholderText = placeholder
    box.Text = ""
    box.TextColor3 = Theme.TEXT
    box.PlaceholderColor3 = Theme.TEXT_DIM
    box.Font = Enum.Font.GothamMedium
    box.TextSize = 11
    box.BorderSizePixel = 0
    Instance.new("UICorner", box).CornerRadius = UDim.new(0.2, 0)
    local stroke = Instance.new("UIStroke", box)
    stroke.Color = Theme.BORDER
    stroke.Thickness = 1
    stroke.Transparency = 0.4
    box.FocusLost:Connect(function() callback(box.Text) end)
end

local currentPage = "main"

local function clearScroll()
    for _, c in ipairs(scroll:GetChildren()) do
        if c:IsA("GuiObject") or c:IsA("UIListLayout") or c:IsA("UIPadding") then c:Destroy() end
    end
    local newLayout = Instance.new("UIListLayout", scroll)
    newLayout.Padding = UDim.new(0, 6)
    newLayout.SortOrder = Enum.SortOrder.LayoutOrder
    scrollLayout = newLayout
end

local function buildMain()
    makeSection("SILENT AIM")
    makeToggle("Enabled", SilentAimSettings.Enabled, function(s)
        SilentAimSettings.Enabled = s
        mouse_box.Visible = s
        notify("Silent Aim " .. (s and "enabled" or "disabled"), s and Theme.ACCENT or Theme.TEXT_DIM)
    end, "Master silent aim toggle")
    makeDropdown("Target Part", {"Head", "HumanoidRootPart", "Random"}, SilentAimSettings.TargetPart, function(v) SilentAimSettings.TargetPart = v end)
    makeDropdown("Method", {"Raycast", "FindPartOnRay", "FindPartOnRayWithWhitelist", "FindPartOnRayWithIgnoreList", "Mouse.Hit/Target"}, SilentAimSettings.SilentAimMethod, function(v)
        SilentAimSettings.SilentAimMethod = v
        statusLabel.Text = "● method: " .. v
    end)
    makeSlider("Hit Chance", 0, 100, SilentAimSettings.HitChance, function(v) SilentAimSettings.HitChance = v end)

    makeSection("FILTERS")
    makeToggle("Team Check", SilentAimSettings.TeamCheck, function(s) SilentAimSettings.TeamCheck = s end)
    makeToggle("Visible Check", SilentAimSettings.VisibleCheck, function(s) SilentAimSettings.VisibleCheck = s end)

    makeSection("TARGET TEAM")
    makeToggle("Target Cop", SilentAimSettings.TargetCop, function(s)
        SilentAimSettings.TargetCop = s
        notify("Target Cop: " .. tostring(s), Theme.ACCENT)
    end, "Aim only at Guards team")
    makeToggle("Target Inmate", SilentAimSettings.TargetInmate, function(s)
        SilentAimSettings.TargetInmate = s
        notify("Target Inmate: " .. tostring(s), Theme.ACCENT)
    end, "Aim only at Inmates team")
    makeToggle("Target Criminal", SilentAimSettings.TargetCriminal, function(s)
        SilentAimSettings.TargetCriminal = s
        notify("Target Criminal: " .. tostring(s), Theme.ACCENT)
    end, "Aim only at Criminals team")
    makeToggle("Target Hostile", SilentAimSettings.TargetHostile, function(s)
        SilentAimSettings.TargetHostile = s
        notify("Target Hostile: " .. tostring(s), Theme.ACCENT)
    end, "Aim at players flagged Hostile")
    makeToggle("Target Trespassing", SilentAimSettings.TargetTrespassing, function(s)
        SilentAimSettings.TargetTrespassing = s
        notify("Target Trespassing: " .. tostring(s), Theme.ACCENT)
    end, "Aim at players flagged Trespassing")

    makeSection("PREDICTION")
    makeToggle("Mouse.Hit Prediction", SilentAimSettings.MouseHitPrediction, function(s) SilentAimSettings.MouseHitPrediction = s end)
    makeSlider("Prediction x1000", 165, 1000, math.floor(SilentAimSettings.MouseHitPredictionAmount * 1000), function(v)
        SilentAimSettings.MouseHitPredictionAmount = v / 1000
        PredictionAmount = v / 1000
    end)
end

local function buildESP()
    makeSection("ESP")
    makeToggle("Enable ESP", SilentAimSettings.ESP_Enabled, function(s)
        SilentAimSettings.ESP_Enabled = s
        notify("ESP " .. (s and "enabled" or "disabled"), s and Theme.ACCENT or Theme.TEXT_DIM)
    end, "Master ESP toggle")
    makeToggle("Team Colors", SilentAimSettings.ESP_Team, function(s)
        SilentAimSettings.ESP_Team = s
        notify("Team colors " .. (s and "on" or "off"), Theme.ACCENT)
    end, "Highlight and trace use team colors")

    makeSection("ESP ELEMENTS")
    makeToggle("Highlight", SilentAimSettings.ESP_Highlight, function(s) SilentAimSettings.ESP_Highlight = s end)
    makeToggle("Name", SilentAimSettings.ESP_Name, function(s) SilentAimSettings.ESP_Name = s end)
    makeToggle("Health Bar", SilentAimSettings.ESP_Health, function(s) SilentAimSettings.ESP_Health = s end)
    makeToggle("Trace Line", SilentAimSettings.ESP_Trace, function(s) SilentAimSettings.ESP_Trace = s end)

    makeSection("ESP RANGE")
    makeSlider("Max Distance", 100, 3000, SilentAimSettings.ESP_MaxDistance, function(v) SilentAimSettings.ESP_MaxDistance = v end)
end

local function buildVisuals()
    makeSection("FOV CIRCLE")
    makeToggle("Show FOV Circle", SilentAimSettings.FOVVisible, function(s)
        SilentAimSettings.FOVVisible = s
        fov_circle.Visible = s
    end, "Draw circle around cursor")
    makeSlider("FOV Radius", 0, 400, SilentAimSettings.FOVRadius, function(v)
        SilentAimSettings.FOVRadius = v
        fov_circle.Radius = v
    end)
    makeToggle("Show Silent Aim Target", SilentAimSettings.ShowSilentAimTarget, function(s) SilentAimSettings.ShowSilentAimTarget = s end)

    makeSection("COLORS")
    makeButton("Accent Pink", function()
        Theme.ACCENT = Color3.fromRGB(255, 182, 193)
        Theme.ACCENT2 = Color3.fromRGB(200, 140, 200)
        accentGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Theme.ACCENT), ColorSequenceKeypoint.new(1, Theme.ACCENT2)})
        mainGlow.Color = Theme.ACCENT; hubGlow.Color = Theme.ACCENT
        mouse_box.Color = Theme.ACCENT
        contentHeader.TextColor3 = Theme.ACCENT; icon.TextColor3 = Theme.ACCENT
        accentLine.BackgroundColor3 = Theme.ACCENT
        notify("Accent: Pink", Theme.ACCENT)
    end)
    makeButton("Accent Blue", function()
        Theme.ACCENT = Color3.fromRGB(140, 180, 255)
        Theme.ACCENT2 = Color3.fromRGB(200, 150, 255)
        accentGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Theme.ACCENT), ColorSequenceKeypoint.new(1, Theme.ACCENT2)})
        mainGlow.Color = Theme.ACCENT; hubGlow.Color = Theme.ACCENT
        mouse_box.Color = Theme.ACCENT
        contentHeader.TextColor3 = Theme.ACCENT; icon.TextColor3 = Theme.ACCENT
        accentLine.BackgroundColor3 = Theme.ACCENT
        notify("Accent: Blue", Theme.ACCENT)
    end)
    makeButton("Accent Green", function()
        Theme.ACCENT = Color3.fromRGB(140, 255, 180)
        Theme.ACCENT2 = Color3.fromRGB(180, 255, 200)
        accentGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Theme.ACCENT), ColorSequenceKeypoint.new(1, Theme.ACCENT2)})
        mainGlow.Color = Theme.ACCENT; hubGlow.Color = Theme.ACCENT
        mouse_box.Color = Theme.ACCENT
        contentHeader.TextColor3 = Theme.ACCENT; icon.TextColor3 = Theme.ACCENT
        accentLine.BackgroundColor3 = Theme.ACCENT
        notify("Accent: Green", Theme.ACCENT)
    end)
    makeButton("Accent Purple", function()
        Theme.ACCENT = Color3.fromRGB(200, 140, 255)
        Theme.ACCENT2 = Color3.fromRGB(255, 150, 220)
        accentGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Theme.ACCENT), ColorSequenceKeypoint.new(1, Theme.ACCENT2)})
        mainGlow.Color = Theme.ACCENT; hubGlow.Color = Theme.ACCENT
        mouse_box.Color = Theme.ACCENT
        contentHeader.TextColor3 = Theme.ACCENT; icon.TextColor3 = Theme.ACCENT
        accentLine.BackgroundColor3 = Theme.ACCENT
        notify("Accent: Purple", Theme.ACCENT)
    end)
    makeButton("Accent White", function()
        Theme.ACCENT = Color3.fromRGB(255, 255, 255)
        Theme.ACCENT2 = Color3.fromRGB(200, 200, 200)
        accentGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Theme.ACCENT), ColorSequenceKeypoint.new(1, Theme.ACCENT2)})
        mainGlow.Color = Theme.ACCENT; hubGlow.Color = Theme.ACCENT
        mouse_box.Color = Theme.ACCENT
        contentHeader.TextColor3 = Theme.ACCENT; icon.TextColor3 = Theme.ACCENT
        accentLine.BackgroundColor3 = Theme.ACCENT
        notify("Accent: White", Theme.ACCENT)
    end)
end

local function buildConfig()
    makeSection("SAVE / LOAD")
    makeInput("File name...", function(name)
        if name and name ~= "" then
            FileToSave = name
            notify("Config name set: " .. name, Theme.ACCENT)
        end
    end)
    makeButton("Create Config File", function()
        if FileToSave ~= "" then
            UpdateFile(FileToSave)
            notify("Created: " .. FileToSave, Theme.ACCENT)
        end
    end)
    makeSection("EXISTING CONFIGS")
    local files = GetFiles()
    if #files == 0 then
        local empty = Instance.new("TextLabel", scroll)
        empty.Size = UDim2.new(1, 0, 0, 24)
        empty.BackgroundTransparency = 1
        empty.Text = "  no configs found"
        empty.TextColor3 = Theme.TEXT_DIM
        empty.Font = Enum.Font.Gotham
        empty.TextSize = 10
        empty.TextXAlignment = Enum.TextXAlignment.Left
    else
        for _, name in ipairs(files) do
            makeButton("Load: " .. name, function() LoadFile(name); notify("Loaded: " .. name, Theme.ACCENT) end)
            makeButton("Save: " .. name, function() UpdateFile(name); notify("Saved: " .. name, Theme.ACCENT) end)
        end
    end
end

local function buildInfo()
    makeSection("INFO")
    local info = Instance.new("TextLabel", scroll)
    info.Size = UDim2.new(1, 0, 0, 420)
    info.BackgroundColor3 = Theme.BG_OPT
    info.BackgroundTransparency = 0.05
    info.TextColor3 = Theme.TEXT
    info.Font = Enum.Font.Gotham
    info.TextSize = 10
    info.TextWrapped = true
    info.TextXAlignment = Enum.TextXAlignment.Left
    info.TextYAlignment = Enum.TextYAlignment.Top
    info.Text = [[
 거 SPENT HUB v15.2

 Hold RMB to aim (toggle RAlt)
 GUI toggle: RightShift
 Unload: END
 Close: × → floating 거 reopens

 Silent Aim Core:
   Universal Silent Aim
   by Averiias / Stefanuk12 / xaxa

 Hit Chance:
   Rolls once per 0.15s window.

 Target Team:
   Guards    → Target Cop toggle
   Inmates   → Target Inmate toggle
   Criminals → Target Criminal toggle
   Hostile   → Target Hostile toggle
   Trespass  → Target Trespassing toggle

 Team Detection Fix:
   Handles both "Guard" and
   "Guards" name variants.
   Fallback to Character attributes
   Team / Role if Team object nil.

 Target Lock Feedback:
   FOV ring white when idle
   FOV ring light pink when locked
   Target's ESP highlight also
   locks to light pink

 ESP (optimized for low-end):
   Runs at 30 Hz (configurable)
   Highlight refresh at 10 Hz
   Lock cache 100ms
   Team Colors → highlight / trace
                 use team colors
   Highlight / Name / Health Bar /
   Trace Line toggles
   Max Distance slider

 Notifications:
   Icon per type
   Progress bar (drains over 3.2s)
   Hover to pause timer
   Click to dismiss

 Keybinds:
   RAlt  → toggle silent aim
   RMB   → engage aim
   RShift → show/hide hub
   END   → unload
]]
    Instance.new("UICorner", info).CornerRadius = UDim.new(0.06, 0)
end

local tabs = {
    {name = "Main", page = "main", build = buildMain},
    {name = "ESP", page = "esp", build = buildESP},
    {name = "Visuals", page = "visuals", build = buildVisuals},
    {name = "Config", page = "config", build = buildConfig},
    {name = "Info", page = "info", build = buildInfo},
}

local tabButtons = {}
local tabUnderlines = {}

local function selectTab(page)
    currentPage = page
    clearScroll()
    for _, t in ipairs(tabs) do
        if t.page == page then
            contentHeader.Text = string.upper(t.name)
            t.build()
            break
        end
    end
    animateAccentLine()
    for _, b in ipairs(tabButtons) do
        if b.page == page then
            TweenService:Create(b.btn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.ACCENT, TextColor3 = Color3.fromRGB(15, 15, 18)}):Play()
        else
            TweenService:Create(b.btn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.BG_OPT, TextColor3 = Theme.TEXT}):Play()
        end
    end
    for _, u in ipairs(tabUnderlines) do
        if u.page == page then
            u.frame.Visible = true
            u.frame.Size = UDim2.new(0, 0, 0, 2)
            TweenService:Create(u.frame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(1, -16, 0, 2)}):Play()
        else
            u.frame.Visible = false
        end
    end
    task.defer(function()
        scroll.CanvasSize = UDim2.new(0, 0, 0, scrollLayout.AbsoluteContentSize.Y + 20)
    end)
end

for _, t in ipairs(tabs) do
    local holder = Instance.new("Frame", sidebar)
    holder.Size = UDim2.new(1, 0, 0, 34)
    holder.BackgroundTransparency = 1
    holder.Name = t.name

    local btn = Instance.new("TextButton", holder)
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundColor3 = Theme.BG_OPT
    btn.BackgroundTransparency = 0.05
    btn.Text = t.name
    btn.TextColor3 = Theme.TEXT
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 11
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0.2, 0)
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Theme.BORDER
    stroke.Thickness = 1
    stroke.Transparency = 0.4

    local underline = Instance.new("Frame", holder)
    underline.Size = UDim2.new(1, -16, 0, 2)
    underline.Position = UDim2.new(0, 8, 1, -3)
    underline.BackgroundColor3 = Theme.ACCENT
    underline.BorderSizePixel = 0
    underline.Visible = false
    Instance.new("UICorner", underline).CornerRadius = UDim.new(1, 0)

    btn.MouseButton1Click:Connect(function() selectTab(t.page) end)
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0, BackgroundColor3 = Theme.BG_HOVER, TextColor3 = Theme.TEXT_STRONG}):Play()
        TweenService:Create(stroke, TweenInfo.new(0.15), {Transparency = 0.1}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.05, BackgroundColor3 = Theme.BG_OPT, TextColor3 = Theme.TEXT}):Play()
        TweenService:Create(stroke, TweenInfo.new(0.15), {Transparency = 0.4}):Play()
    end)

    table.insert(tabButtons, {btn = btn, page = t.page})
    table.insert(tabUnderlines, {frame = underline, page = t.page})
end

searchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local q = searchBox.Text:lower()
    for _, c in ipairs(scroll:GetChildren()) do
        if c:IsA("TextButton") or c:IsA("Frame") then
            if q == "" then c.Visible = true
            else
                local match = false
                if c:IsA("TextButton") and c.Text:lower():find(q, 1, true) then match = true end
                if c.Name:lower():find(q, 1, true) then match = true end
                c.Visible = match
            end
        end
    end
end)

local openState = "idle"
local activeOpenTweens = {}
local activeCloseTweens = {}

local function cancelTweens(list)
    for _, tw in ipairs(list) do
        pcall(function() tw:Cancel() end)
    end
    table.clear(list)
end

local baseMainSize = UDim2.new(0, 740, 0, 440)
local baseMainPos = UDim2.new(0.5, -370, 0.5, -220)
local baseShadowSize = UDim2.new(0, 750, 0, 450)
local baseShadowPos = UDim2.new(0.5, -375, 0.5, -225)

local hasGroupTransparency = pcall(function()
    local test = Instance.new("Frame")
    test.GroupTransparency = 0
    test:Destroy()
end)

local function playOpen()
    if openState == "opening" or openState == "open" then return end
    openState = "opening"

    cancelTweens(activeCloseTweens)
    cancelTweens(activeOpenTweens)

    main.Visible = true
    shadow.Visible = true
    main.Size = UDim2.new(0, 740 * 0.92, 0, 440 * 0.92)
    main.Position = baseMainPos + UDim2.new(0, 15, 0, 20)
    main.BackgroundTransparency = 1
    if hasGroupTransparency then main.GroupTransparency = 1 end
    mainGlow.Transparency = 1
    mainStroke.Transparency = 1

    shadow.Size = UDim2.new(0, 750 * 0.92, 0, 450 * 0.92)
    shadow.Position = main.Position + UDim2.new(0, -5, 0, -5)
    shadow.BackgroundTransparency = 1

    icon.TextTransparency = 1
    title.TextTransparency = 1
    for _, b in ipairs(tabButtons) do
        b.btn.Position = UDim2.new(-0.25, 0, 0, 0)
    end

    if hasGroupTransparency then
        table.insert(activeOpenTweens, TweenService:Create(main, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {GroupTransparency = 0, BackgroundTransparency = 0.03}))
    else
        table.insert(activeOpenTweens, TweenService:Create(main, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0.03}))
    end
    table.insert(activeOpenTweens, TweenService:Create(mainStroke, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Transparency = 0.3}))
    table.insert(activeOpenTweens, TweenService:Create(shadow, TweenInfo.new(0.28, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0.7}))

    local sizeMid = UDim2.new(0, 740 * 1.04, 0, 440 * 1.04)
    local posMid = baseMainPos + UDim2.new(0, -740 * 0.02, 0, -440 * 0.02)
    table.insert(activeOpenTweens, TweenService:Create(main, TweenInfo.new(0.24, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = sizeMid, Position = posMid}))
    task.delay(0.24, function()
        if openState ~= "opening" and openState ~= "open" then return end
        TweenService:Create(main, TweenInfo.new(0.16, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = baseMainSize, Position = baseMainPos}):Play()
        TweenService:Create(shadow, TweenInfo.new(0.16, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = baseShadowSize, Position = baseShadowPos}):Play()
    end)

    table.insert(activeOpenTweens, TweenService:Create(mainGlow, TweenInfo.new(0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Transparency = 0.35}))
    task.delay(0.18, function()
        if openState ~= "opening" and openState ~= "open" then return end
        TweenService:Create(mainGlow, TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0.88}):Play()
    end)

    table.insert(activeOpenTweens, TweenService:Create(icon, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}))
    table.insert(activeOpenTweens, TweenService:Create(title, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}))

    for i, b in ipairs(tabButtons) do
        task.delay(0.12 + (i - 1) * 0.05, function()
            if openState ~= "opening" and openState ~= "open" then return end
            TweenService:Create(b.btn, TweenInfo.new(0.28, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0)}):Play()
        end)
    end

    if hubToggleBtn.Visible then
        local ftw1 = TweenService:Create(hubToggleBtn, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 58, 0, 58), BackgroundTransparency = 0})
        local ftw2 = TweenService:Create(hubToggleBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0), TextTransparency = 1, BackgroundTransparency = 1})
        ftw1:Play()
        task.delay(0.12, function()
            ftw2:Play()
            task.wait(0.2)
            pcall(function() hubToggleBtn.Visible = false end)
        end)
    end

    for _, tw in ipairs(activeOpenTweens) do tw:Play() end

    task.delay(0.6, function()
        if openState == "opening" then openState = "open" end
    end)
end

local function playClose()
    if openState == "closing" or openState == "closed" then return end
    local wasOpen = openState == "open" or openState == "opening" or openState == "idle"
    openState = "closing"

    cancelTweens(activeOpenTweens)
    cancelTweens(activeCloseTweens)

    if hasGroupTransparency then
        TweenService:Create(main, TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {GroupTransparency = 0.4}):Play()
    end

    task.delay(0.14, function()
        if openState ~= "closing" then return end
        local sizeSquish = UDim2.new(0, 740 * 1.03, 0, 440 * 1.03)
        local posSquish = main.Position + UDim2.new(0, -740 * 0.015, 0, -440 * 0.015)
        TweenService:Create(main, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = sizeSquish, Position = posSquish}):Play()
        task.delay(0.1, function()
            if openState ~= "closing" then return end
            TweenService:Create(main, TweenInfo.new(0.24, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
                Size = UDim2.new(0, 740 * 0.88, 0, 440 * 0.88),
                Position = baseMainPos + UDim2.new(0, 740 * 0.06, 0, 22),
                BackgroundTransparency = 1,
            }):Play()
            if hasGroupTransparency then
                TweenService:Create(main, TweenInfo.new(0.24, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {GroupTransparency = 1}):Play()
            end
            TweenService:Create(shadow, TweenInfo.new(0.24, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
                Size = UDim2.new(0, 750 * 0.88, 0, 450 * 0.88),
                BackgroundTransparency = 1,
            }):Play()
            TweenService:Create(mainGlow, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Transparency = 1}):Play()
            TweenService:Create(mainStroke, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Transparency = 1}):Play()
        end)
    end)

    task.delay(0.24, function()
        if not wasOpen then return end
        hubToggleBtn.Visible = true
        hubToggleBtn.Size = UDim2.new(0, 0, 0, 0)
        hubToggleBtn.TextTransparency = 1
        hubToggleBtn.BackgroundTransparency = 1
        TweenService:Create(hubToggleBtn, TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 54, 0, 54),
            TextTransparency = 0,
            BackgroundTransparency = 0.1,
        }):Play()
        task.delay(0.18, function()
            TweenService:Create(hubToggleBtn, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 46, 0, 46)}):Play()
        end)
    end)

    task.delay(0.44, function()
        if openState ~= "closing" then return end
        main.Visible = false
        shadow.Visible = false
        if hasGroupTransparency then main.GroupTransparency = 0 end
        main.BackgroundTransparency = 0.03
        main.Size = baseMainSize
        main.Position = baseMainPos
        shadow.Size = baseShadowSize
        shadow.Position = baseShadowPos
        mainGlow.Transparency = 0.88
        mainStroke.Transparency = 0.3
        openState = "closed"
    end)
end

hubToggleBtn.MouseButton1Click:Connect(function() playOpen() end)
closeBtn.MouseButton1Click:Connect(function() playClose() end)

compactBtn.MouseButton1Click:Connect(function()
    local targetSize = main.Size.Y.Offset > 40 and UDim2.new(0, 740, 0, 38) or UDim2.new(0, 740, 0, 440)
    TweenService:Create(main, TweenInfo.new(0.25, Enum.EasingStyle.Quart), {Size = targetSize}):Play()
end)

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.RightAlt then
        SilentAimSettings.Enabled = not SilentAimSettings.Enabled
        notify("Silent Aim " .. (SilentAimSettings.Enabled and "enabled" or "disabled"), Theme.ACCENT)
    end
    if input.KeyCode == Enum.KeyCode.RightShift then
        if main.Visible then playClose() else playOpen() end
    end
    if input.KeyCode == Enum.KeyCode.End then
        pcall(function() gui:Destroy() end)
        pcall(function() fov_circle:Remove() end)
        pcall(function() mouse_box:Remove() end)
        for _, p in ipairs(Players:GetPlayers()) do clearESP(p) end
        print("SPENT HUB unloaded.")
    end
end)

resume(create(function()
    RenderStepped:Connect(function()
        local lockedTarget = getClosestPlayer()

        if SilentAimSettings.ShowSilentAimTarget and SilentAimSettings.Enabled then
            if lockedTarget then
                local Root = lockedTarget.Parent and lockedTarget.Parent.PrimaryPart or lockedTarget
                local RootToViewportPoint, IsOnScreen = WorldToViewportPoint(Camera, Root.Position)
                mouse_box.Visible = IsOnScreen
                mouse_box.Position = Vector2.new(RootToViewportPoint.X, RootToViewportPoint.Y)
            else
                mouse_box.Visible = false
                mouse_box.Position = Vector2.new()
            end
        end

        if SilentAimSettings.FOVVisible then
            fov_circle.Visible = SilentAimSettings.FOVVisible
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

local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
    local Method = getnamecallmethod()
    local Arguments = {...}
    local self = Arguments[1]
    local chance = CalculateChance(SilentAimSettings.HitChance)
    if SilentAimSettings.Enabled and self == workspace and not checkcaller() and chance == true then
        if Method == "FindPartOnRayWithIgnoreList" and SilentAimSettings.SilentAimMethod == Method then
            if ValidateArguments(Arguments, ExpectedArguments.FindPartOnRayWithIgnoreList) then
                local A_Ray = Arguments[2]
                local HitPart = getClosestPlayer()
                if HitPart then
                    Arguments[2] = Ray.new(A_Ray.Origin, getDirection(A_Ray.Origin, HitPart.Position))
                    return oldNamecall(unpack(Arguments))
                end
            end
        elseif Method == "FindPartOnRayWithWhitelist" and SilentAimSettings.SilentAimMethod == Method then
            if ValidateArguments(Arguments, ExpectedArguments.FindPartOnRayWithWhitelist) then
                local A_Ray = Arguments[2]
                local HitPart = getClosestPlayer()
                if HitPart then
                    Arguments[2] = Ray.new(A_Ray.Origin, getDirection(A_Ray.Origin, HitPart.Position))
                    return oldNamecall(unpack(Arguments))
                end
            end
        elseif (Method == "FindPartOnRay" or Method == "findPartOnRay") and SilentAimSettings.SilentAimMethod:lower() == Method:lower() then
            if ValidateArguments(Arguments, ExpectedArguments.FindPartOnRay) then
                local A_Ray = Arguments[2]
                local HitPart = getClosestPlayer()
                if HitPart then
                    Arguments[2] = Ray.new(A_Ray.Origin, getDirection(A_Ray.Origin, HitPart.Position))
                    return oldNamecall(unpack(Arguments))
                end
            end
        elseif Method == "Raycast" and SilentAimSettings.SilentAimMethod == Method then
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
    if self == Mouse and not checkcaller() and SilentAimSettings.Enabled and SilentAimSettings.SilentAimMethod == "Mouse.Hit/Target" and getClosestPlayer() then
        local HitPart = getClosestPlayer()
        if Index == "Target" or Index == "target" then
            return HitPart
        elseif Index == "Hit" or Index == "hit" then
            return ((SilentAimSettings.MouseHitPrediction and (HitPart.CFrame + (HitPart.Velocity * PredictionAmount))) or (not SilentAimSettings.MouseHitPrediction and HitPart.CFrame))
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

selectTab("main")
main.Visible = true
shadow.Visible = true
openState = "open"
notify("SPENT HUB v15.2 loaded", Theme.ACCENT)
task.delay(0.4, function()
    notify("RMB aim · RAlt toggle · RShift GUI", Theme.TEXT_DIM)
end)
print("SPENT HUB v15.2 loaded.")
