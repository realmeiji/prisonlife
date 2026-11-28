if not game:IsLoaded() then game.Loaded:Wait() end
if not syn or not protectgui then getgenv().protectgui = function() end end

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local Lighting = game:GetService("Lighting")
local Debris = game:GetService("Debris")
local SoundService = game:GetService("SoundService")

local startupGui = Instance.new("ScreenGui")
startupGui.Name = "SpentHubStartup"
startupGui.ResetOnSpawn = false
startupGui.IgnoreGuiInset = true
startupGui.DisplayOrder = 200
startupGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local startupFrame = Instance.new("Frame", startupGui)
startupFrame.Size = UDim2.new(0, 300, 0, 60)
startupFrame.Position = UDim2.new(0.5, -150, 0, -80)
startupFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
startupFrame.BackgroundTransparency = 0.08
startupFrame.BorderSizePixel = 0
Instance.new("UICorner", startupFrame).CornerRadius = UDim.new(0.12, 0)

local startupStroke = Instance.new("UIStroke", startupFrame)
startupStroke.Color = Color3.fromRGB(255, 182, 193)
startupStroke.Thickness = 1.5
startupStroke.Transparency = 0.4

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

TweenService:Create(startupFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
    Position = UDim2.new(0.5, -150, 0, 30)
}):Play()
TweenService:Create(startupFill, TweenInfo.new(3, Enum.EasingStyle.Linear), {
    Size = UDim2.new(1, 0, 1, 0)
}):Play()

task.wait(3)

TweenService:Create(startupFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
    Position = UDim2.new(0.5, -150, 0, -80),
    BackgroundTransparency = 1,
}):Play()
TweenService:Create(startupTitle, TweenInfo.new(0.35), {TextTransparency = 1}):Play()
TweenService:Create(startupSub, TweenInfo.new(0.35), {TextTransparency = 1}):Play()
TweenService:Create(startupStroke, TweenInfo.new(0.35), {Transparency = 1}):Play()
task.wait(0.4)
pcall(function() startupGui:Destroy() end)

local IS_MOBILE = UserInputService and UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

local function getMenuDimensions()
    local vp = workspace.CurrentCamera.ViewportSize
    local sw, sh = vp.X, vp.Y
    if IS_MOBILE or sw < 700 then
        local scale = math.clamp(sw / 900, 0.45, 0.75)
        return {
            mainW = math.floor(sw * 0.96), mainH = math.floor(sh * 0.80),
            mainX = math.floor(sw * 0.02), mainY = math.floor(sh * 0.08),
            sidebarW = math.floor(100 * scale), contentX = math.floor(110 * scale),
            contentW_offset = math.floor(-220 * scale - 10), rightDockW = math.floor(160 * scale),
            titleH = 36, statusH = 20, fontSize_body = 10, fontSize_header = 11, isMobile = true,
        }
    end
    return {
        mainW = 890, mainH = 440, mainX = -445, mainY = -220,
        sidebarW = 150, contentX = 176, contentW_offset = -388, rightDockW = 200,
        titleH = 40, statusH = 24, fontSize_body = 11, fontSize_header = 12, isMobile = false,
    }
end

local DIM = getMenuDimensions()

local SilentAimSettings = {
    Enabled = false, TeamCheck = false, VisibleCheck = false,
    TargetPart = "HumanoidRootPart", SilentAimMethod = "Raycast",
    FOVRadius = 130, FOVVisible = false, FOVCenter = false,
    ShowSilentAimTarget = false, MouseHitPrediction = false, MouseHitPredictionAmount = 0.165,
    HitChance = 100, TargetCop = true, TargetInmate = true, TargetCriminal = true,
    ForcefieldCheck = true, TargetingMode = "Manual",
    ESP_Enabled = false, ESP_Team = false, ESP_Highlight = true, ESP_Name = true,
    ESP_Health = true, ESP_Trace = false, ESP_MaxDistance = 1500,
    ESP_HighlightColor = Color3.fromRGB(255, 182, 193),
    ESP_NameColor = Color3.fromRGB(255, 255, 255),
    ESP_HPColor = Color3.fromRGB(80, 255, 100),
    ESP_TraceColor = Color3.fromRGB(255, 255, 255),
    AutoshootEnabled = false,
    HeadlessEnabled = false, KorbloxEnabled = false,
    FastSwitchEnabled = false, FastSwitchDelay = 0.05,
    FastSwitchList = {"M9", "Revolver", "Remington 870", "MP5", "M4A1", "M700", "AK-47"},
    NoclipPunchEnabled = false,
    RemoveFog = false, CustomSkybox = false, SkyboxName = "None", WorldGradient = false,
    ReloadShuffleKey = "None",
    Hotkeys = {},
}
getgenv().SilentAimSettings = SilentAimSettings

local Whitelist = {}
getgenv().SilentAimWhitelist = Whitelist
local function isWhitelisted(plr) if not plr then return false end return Whitelist[string.lower(plr.Name)] == true end

local TARGET_LOCK_COLOR = Color3.fromRGB(255, 200, 220)
local RING_IDLE_COLOR = Color3.fromRGB(255, 255, 255)

local Theme = {
    ACCENT = Color3.fromRGB(255, 182, 193), ACCENT_LIGHT = Color3.fromRGB(255, 200, 220),
    ACCENT_DARK = Color3.fromRGB(240, 150, 180),
    BG_MAIN = Color3.fromRGB(12, 12, 16), BG_PANEL = Color3.fromRGB(18, 18, 24),
    BG_OPT = Color3.fromRGB(28, 28, 36), BG_HOVER = Color3.fromRGB(38, 38, 48),
    BG_ACTIVE = Color3.fromRGB(48, 48, 60),
    BORDER = Color3.fromRGB(50, 50, 65), BORDER_STRONG = Color3.fromRGB(70, 70, 90),
    TEXT = Color3.fromRGB(235, 235, 245), TEXT_DIM = Color3.fromRGB(150, 150, 160),
    TEXT_STRONG = Color3.fromRGB(255, 255, 255), TEXT_MUTED = Color3.fromRGB(120, 120, 130),
    GRADIENT_1 = Color3.fromRGB(255, 182, 193), GRADIENT_2 = Color3.fromRGB(220, 160, 200),
    ICON = "S",
}

local Camera = workspace.CurrentCamera
local GuiService = game:GetService("GuiService")
local Mouse = LocalPlayer:GetMouse()
local GetPlayers = Players.GetPlayers
local WorldToScreen = Camera.WorldToScreenPoint
local WorldToViewportPoint = Camera.WorldToViewportPoint
local GetPartsObscuringTarget = Camera.GetPartsObscuringTarget
local FindFirstChild = game.FindFirstChild
local RenderStepped = RunService.RenderStepped
local GetMouseLocation = UserInputService.GetMouseLocation
local ValidTargetParts = {"Head", "HumanoidRootPart", "LeftArm", "RightArm", "LeftLeg", "RightLeg"}

local originalMouseIconEnabled = UserInputService.MouseIconEnabled
if not IS_MOBILE then
    UserInputService.MouseIconEnabled = false
end

local function _mkDraw(className)
    if typeof(Drawing) == "table" and typeof(Drawing.new) == "function" then
        local ok, o = pcall(Drawing.new, className)
        if ok and o then return o end
    end
    local d = { Visible = false, Color = Color3.new(1,1,1), Thickness = 1, Radius = 3,
        Position = Vector2.new(), NumSides = 24, Filled = false, Transparency = 1, ZIndex = 100,
        Size = Vector2.new(), Text = "", From = Vector2.new(), To = Vector2.new() }
    function d:Remove() end
    return d
end

local cursorOuter = _mkDraw("Circle")
cursorOuter.Radius = 3.5
cursorOuter.Thickness = 1.5
cursorOuter.NumSides = 24
cursorOuter.Filled = false
cursorOuter.ZIndex = 100
cursorOuter.Visible = not IS_MOBILE
cursorOuter.Transparency = 1

local cursorInner = _mkDraw("Circle")
cursorInner.Radius = 3
cursorInner.Thickness = 1
cursorInner.NumSides = 24
cursorInner.Filled = false
cursorInner.ZIndex = 101
cursorInner.Visible = not IS_MOBILE
cursorInner.Transparency = 1

local CURSOR_TIP_OFFSET = Vector2.new(0, 0)
local function invertColor(c)
    return Color3.new(1 - c.R, 1 - c.G, 1 - c.B)
end
local function sampleUnderCursor(screenPos)
    local cam = workspace.CurrentCamera
    if not cam then return Color3.fromRGB(255, 255, 255) end
    local ray = cam:ViewportPointToRay(screenPos.X, screenPos.Y)
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    local char = LocalPlayer.Character
    if char then params.FilterDescendantsInstances = { char } end
    local result = workspace:Raycast(ray.Origin, ray.Direction * 500, params)
    if result and result.Instance and result.Instance:IsA("BasePart") then
        return result.Instance.Color
    end
    return Color3.fromRGB(40, 40, 48)
end

local cursorConnection = RenderStepped:Connect(function()
    if IS_MOBILE then
        cursorOuter.Visible = false
        cursorInner.Visible = false
        return
    end
    local mouseLoc = GetMouseLocation(UserInputService)
    local tip = Vector2.new(mouseLoc.X + CURSOR_TIP_OFFSET.X, mouseLoc.Y + CURSOR_TIP_OFFSET.Y)
    cursorOuter.Position = tip
    cursorInner.Position = tip
    cursorOuter.Visible = true
    cursorInner.Visible = true
    local sample = sampleUnderCursor(tip)
    local inv = invertColor(sample)
    cursorOuter.Color = inv
    cursorInner.Color = Color3.new(
        math.clamp(sample.R * 0.35 + inv.R * 0.65, 0, 1),
        math.clamp(sample.G * 0.35 + inv.G * 0.65, 0, 1),
        math.clamp(sample.B * 0.35 + inv.B * 0.65, 0, 1)
    )
end)

local mouse_box = _mkDraw("Square")
mouse_box.Visible = false
mouse_box.ZIndex = 999
mouse_box.Color = Color3.fromRGB(255, 182, 193)
mouse_box.Thickness = 2
mouse_box.Size = Vector2.new(20, 20)
mouse_box.Filled = false

local fov_circle = _mkDraw("Circle")
fov_circle.Thickness = 1.5
fov_circle.NumSides = 100
fov_circle.Radius = 130
fov_circle.Filled = false
fov_circle.Visible = false
fov_circle.ZIndex = 999
fov_circle.Transparency = 0.9
fov_circle.Color = RING_IDLE_COLOR

local ExpectedArguments = {
    FindPartOnRayWithIgnoreList = { ArgCountRequired = 3, Args = { "Instance", "Ray", "table", "boolean", "boolean" } },
    FindPartOnRayWithWhitelist = { ArgCountRequired = 3, Args = { "Instance", "Ray", "table", "boolean" } },
    FindPartOnRay = { ArgCountRequired = 2, Args = { "Instance", "Ray", "Instance", "boolean", "boolean" } },
    Raycast = { ArgCountRequired = 3, Args = { "Instance", "Vector3", "Vector3", "RaycastParams" } },
}

local _rng = Random.new()

local function getWeaponSpreadRadius()
    local char = LocalPlayer.Character
    if not char then return 0.05 end
    for _, t in ipairs(char:GetChildren()) do
        if t:IsA("Tool") then
            local sp = t:GetAttribute("SpreadRadius")
            if typeof(sp) == "number" then return sp end
        end
    end
    return 0.05
end

local function getEffectiveHitChance()
    local base = tonumber(SilentAimSettings.HitChance) or 100
    if base >= 100 then return 100 end
    if base <= 0 then return 0 end
    
    local tgt = currentTarget
    local char = LocalPlayer.Character
    local myHRP = char and char:FindFirstChild("HumanoidRootPart")
    local their = tgt and tgt.Parent and (tgt.Parent:FindFirstChild("HumanoidRootPart") or tgt)
    
    if myHRP and their and their:IsA("BasePart") then
        local dist = (their.Position - myHRP.Position).Magnitude
        if dist > 60 then
            local t = math.clamp((dist - 60) / 190, 0, 1)
            base = base * (1 - t * 0.70)
        end
    end
    return math.clamp(base, 0, 100)
end

local function computeHitOffset(hitChance, distance, weaponSpread)
    local baseSpread = math.clamp(weaponSpread or 0.05, 0.02, 0.20)
    local rangeFactor = math.clamp(distance / 500, 0.4, 3.0)
    local effectiveSpread = baseSpread * rangeFactor
    
    local roll = _rng:NextNumber(0, 1)
    if roll > (hitChance / 100) then
        local ang = _rng:NextNumber(0, math.pi * 2)
        local r = effectiveSpread * math.sqrt(_rng:NextNumber(0, 1))
        return Vector3.new(math.cos(ang) * r, math.sin(ang) * r, 0)
    end
    return Vector3.zero
end

local function getAimPointWithSpread(targetPart, origin)
    if not targetPart or not targetPart.Parent then return nil end
    local distance = (targetPart.Position - origin).Magnitude
    local hitChance = getEffectiveHitChance()
    
    local offset = computeHitOffset(hitChance, distance, getWeaponSpreadRadius())
    
    local aimDir = (targetPart.Position - origin)
    if aimDir.Magnitude < 0.001 then return targetPart.Position end
    
    local right = aimDir.Unit:Cross(Vector3.new(0,1,0))
    if right.Magnitude < 0.001 then right = Vector3.new(1,0,0) end
    right = right.Unit
    local up = right:Cross(aimDir.Unit).Unit
    
    return targetPart.Position + right * offset.X + up * offset.Y
end

local function ValidateArguments(Args, RayMethod)
    local n = 0
    if #Args < RayMethod.ArgCountRequired then return false end
    for Pos, Argument in next, Args do
        if typeof(Argument) == RayMethod.Args[Pos] then n = n + 1 end
    end
    return n >= RayMethod.ArgCountRequired
end

local function getDirection(Origin, Position) return (Position - Origin).Unit * 1000 end
local function getCenter()
    local vp = Camera.ViewportSize
    return Vector2.new(vp.X / 2, vp.Y / 2)
end
local function getCursorPos()
    if IS_MOBILE then local vp = Camera.ViewportSize return Vector2.new(vp.X / 2, vp.Y / 2) end
    return GetMouseLocation(UserInputService)
end
local function getAimOrigin()
    if SilentAimSettings.FOVCenter then return getCenter() end
    return getCursorPos()
end

local function IsPlayerVisible(Player)
    local PlayerCharacter = Player.Character
    local LocalPlayerCharacter = LocalPlayer.Character
    if not (PlayerCharacter and LocalPlayerCharacter) then return false end
    local PlayerRoot = FindFirstChild(PlayerCharacter, SilentAimSettings.TargetPart) or FindFirstChild(PlayerCharacter, "HumanoidRootPart")
    if not PlayerRoot then return false end
    local CastPoints = {PlayerRoot.Position, LocalPlayerCharacter, PlayerCharacter}
    local IgnoreList = {LocalPlayerCharacter, PlayerCharacter}
    return #GetPartsObscuringTarget(Camera, CastPoints, IgnoreList) == 0
end

local function HasForcefield(Player)
    local char = Player.Character
    if not char then return false end
    return char:FindFirstChildOfClass("ForceField") ~= nil
end

local function matchesTargetingMode(Player)
    local mode = SilentAimSettings.TargetingMode
    if mode == "Manual" then return true end
    if Player.Team then
        local teamName = Player.Team.Name
        if teamName == "Guards" or teamName == "Criminals" then return true end
        if teamName == "Inmates" then
            local char = Player.Character
            if not char then return false end
            if mode == "Hostile" then return char:GetAttribute("Hostile") == true
            elseif mode == "Trespassing" then return char:GetAttribute("Trespassing") == true end
        end
    end
    return mode == "Manual"
end

local function getTeamColor(player)
    local ok, color = pcall(function()
        if player.Team and player.Team.TeamColor then return player.Team.TeamColor.Color end
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

local function matchesTeam(Player)
    if not Player.Team then return true end
    local n = Player.Team.Name
    if n == "Guards" and not SilentAimSettings.TargetCop then return false end
    if n == "Inmates" and not SilentAimSettings.TargetInmate then return false end
    if n == "Criminals" and not SilentAimSettings.TargetCriminal then return false end
    return true
end

local currentTarget = nil

local function getPositionOnScreen(Vector)
    local Vec3, OnScreen = WorldToScreen(Camera, Vector)
    if Vec3.Z < 0 then return Vector2.new(), false end
    return Vector2.new(Vec3.X, Vec3.Y), OnScreen
end

local function resolveTargetPart(Character, partName)
    if not Character then return nil end
    if partName == "Random" then
        for _ = 1, 6 do
            local pick = ValidTargetParts[math.random(1, #ValidTargetParts)]
            local p = Character:FindFirstChild(pick)
            if p then return p end
        end
        return Character:FindFirstChild("HumanoidRootPart")
    end
    return Character:FindFirstChild(partName)
end

local function getClosestPlayer()
    if not SilentAimSettings.TargetPart then return end
    local Closest, DistanceToMouse
    local origin = getAimOrigin()
    for _, Player in next, GetPlayers(Players) do
        if Player == LocalPlayer then continue end
        if isWhitelisted(Player) then continue end
        if SilentAimSettings.TeamCheck and Player.Team == LocalPlayer.Team then continue end
        if not matchesTeam(Player) then continue end
        if SilentAimSettings.ForcefieldCheck and HasForcefield(Player) then continue end
        if not matchesTargetingMode(Player) then continue end
        local Character = Player.Character
        if not Character then continue end
        if SilentAimSettings.VisibleCheck and not IsPlayerVisible(Player) then continue end
        local HumanoidRootPart = FindFirstChild(Character, "HumanoidRootPart")
        local Humanoid = FindFirstChild(Character, "Humanoid")
        if not HumanoidRootPart or not Humanoid or Humanoid.Health <= 0 then continue end
        local ScreenPosition, OnScreen = getPositionOnScreen(HumanoidRootPart.Position)
        if not OnScreen then continue end
        local Distance = (origin - ScreenPosition).Magnitude
        if Distance <= (DistanceToMouse or SilentAimSettings.FOVRadius or 2000) then
            local partInstance = resolveTargetPart(Character, SilentAimSettings.TargetPart)
            if partInstance then
                Closest = partInstance
                DistanceToMouse = Distance
            end
        end
    end
    return Closest
end

task.spawn(function()
    while task.wait(0.1) do
        if SilentAimSettings.Enabled then currentTarget = getClosestPlayer() else currentTarget = nil end
    end
end)

local shootRemote = nil
local AutoShootGunTracers = nil
pcall(function()
    local gunRemotes = ReplicatedStorage:WaitForChild("GunRemotes", 5)
    if gunRemotes then shootRemote = gunRemotes:WaitForChild("ShootEvent", 5) end
end)
pcall(function()
    local sharedModules = ReplicatedStorage:WaitForChild("SharedModules", 5)
    local tracersModule = sharedModules and sharedModules:WaitForChild("GunTracers", 5)
    if tracersModule then AutoShootGunTracers = require(tracersModule) end
end)

local function getEquippedWeapon()
    local char = LocalPlayer.Character
    if not char then return nil end
    for _, child in ipairs(char:GetChildren()) do
        if child:IsA("Tool") then return child end
    end
    return nil
end

local autoShootParams = RaycastParams.new()
autoShootParams.FilterType = Enum.RaycastFilterType.Exclude
autoShootParams.CollisionGroup = "ClientBullet"

local lastAutoShotByWeapon = {}
local AutoShootRaycastInProgress = false
local gunModNames = {"AK-47", "Remington 870", "M9", "M700", "M4A1", "FAL", "MP5", "Revolver", "Taser"}

local function getRedirectedDirectionForAutoShoot(Origin)
    if not currentTarget or not currentTarget.Parent then return nil end
    local pos = currentTarget.Position
    local OriginalDistance = (pos - Origin).Magnitude
    if OriginalDistance == 0 then OriginalDistance = 1000 end
    local PartSize = currentTarget.Size
    local SpreadX = (math.random() - 0.5) * (PartSize.X + 2) * 0.2
    local SpreadY = (math.random() - 0.5) * (PartSize.Y + 2) * 0.2
    local SpreadZ = (math.random() - 0.5) * (PartSize.Z + 2) * 0.2
    local TargetPosition = pos + Vector3.new(SpreadX, SpreadY, SpreadZ)
    local NewDirection = (TargetPosition - Origin)
    local NewDistance = NewDirection.Magnitude
    if NewDistance == 0 then return nil end
    return NewDirection.Unit * math.max(OriginalDistance, NewDistance)
end

local function updateAmmoLabel(weapon, currentAmmo)
    local ok, gunFrame = pcall(function()
        return LocalPlayer.PlayerGui:WaitForChild("Home", 3)
            :WaitForChild("hud", 3)
            :WaitForChild("BottomRightFrame", 3)
            :WaitForChild("GunFrame", 3)
    end)
    if not ok or not gunFrame then return end
    local bulletsLabel = gunFrame:FindFirstChild("BulletsLabel")
    if not bulletsLabel then return end
    local behavior = weapon:GetAttribute("Behavior")
    if behavior == "Sniper" then
        local stored = weapon:GetAttribute("StoredAmmo") or 0
        bulletsLabel.Text = currentAmmo .. " | " .. stored
    else
        local maxAmmo = weapon:GetAttribute("MaxAmmo") or currentAmmo
        bulletsLabel.Text = currentAmmo .. "/" .. maxAmmo
    end
end

local function castPelletRayAutoShoot(weapon, origin, aimPoint, spreadRadius)
    local roll = math.random()
    local behavior = weapon:GetAttribute("Behavior")
    if behavior == "Sniper" or behavior == "Shotgun" then roll = math.sqrt(roll) end
    local range = weapon:GetAttribute("Range") or 1000
    local lookCFrame = CFrame.new(origin, aimPoint)
    local rollAngle = 360 - 720 * math.random()
    local direction = (lookCFrame * CFrame.Angles(0, 0, math.rad(rollAngle)) * CFrame.Angles(0, roll * spreadRadius, 0)).LookVector * range
    AutoShootRaycastInProgress = true
    local result = workspace:Raycast(origin, direction, autoShootParams)
    AutoShootRaycastInProgress = false
    return result and result.Instance or nil, result and result.Position or (origin + direction)
end

local function performAutoShot(weapon)
    if not weapon or not shootRemote then return end
    if not currentTarget or not currentTarget.Parent then return end
    local behavior = weapon:GetAttribute("Behavior")
    local reloadSession = weapon:GetAttribute("Local_ReloadSession") or 0
    local currentAmmo = weapon:GetAttribute("Local_CurrentAmmo") or 0
    if reloadSession ~= 0 or currentAmmo <= 0 then return end
    local char = LocalPlayer.Character
    local head = char and char:FindFirstChild("Head")
    if not head then return end
    local origin = head.Position
    autoShootParams.FilterDescendantsInstances = { char }
    local aimPoint = getAimPointWithSpread(currentTarget, origin) or currentTarget.Position
    local projectileCount = weapon:GetAttribute("ProjectileCount") or 1
    local spreadRadius = weapon:GetAttribute("SpreadRadius") or 0
    local muzzle = weapon:FindFirstChild("Muzzle")
    local muzzlePos = muzzle and muzzle.Position or origin
    local bulletData = {}
    for i = 1, projectileCount do
        local hitInstance, hitPosition = castPelletRayAutoShoot(weapon, origin, aimPoint, spreadRadius)
        table.insert(bulletData, { origin, hitPosition, hitInstance })
        if AutoShootGunTracers then
            pcall(function()
                if behavior == "Sniper" then AutoShootGunTracers.createSniper(muzzlePos, hitPosition)
                elseif behavior == "Taser" then AutoShootGunTracers.createTaser(muzzlePos, hitPosition)
                else AutoShootGunTracers.createBullet(muzzlePos, hitPosition) end
            end)
        end
    end
    shootRemote:FireServer(bulletData)
    local newAmmo = currentAmmo - 1
    weapon:SetAttribute("Local_CurrentAmmo", newAmmo)
    updateAmmoLabel(weapon, newAmmo)
    pcall(function()
        local handle = weapon:FindFirstChild("Handle")
        if handle then
            local shootSound = handle:FindFirstChild("ShootSound")
            if shootSound then
                local cloned = shootSound:Clone()
                cloned.Parent = Camera
                cloned.Playing = true
                task.delay(5, function() pcall(function() cloned:Destroy() end) end)
            end
            local flare = handle:FindFirstChild("Flare")
            if flare then
                flare.Enabled = true
                task.delay(0.05, function() if flare then flare.Enabled = false end end)
            end
        end
    end)
end

RunService.Heartbeat:Connect(function()
    if not shootRemote then return end
    if not SilentAimSettings.Enabled or not SilentAimSettings.AutoshootEnabled then return end
    if not currentTarget or not currentTarget.Parent then return end
    local char = LocalPlayer.Character
    local myHumanoid = char and char:FindFirstChildOfClass("Humanoid")
    if not myHumanoid or myHumanoid.Health <= 0 then return end
    local weapon = getEquippedWeapon()
    if not weapon or not table.find(gunModNames, weapon.Name) then return end
    local fireRate = weapon:GetAttribute("FireRate") or 0.1
    local weaponAutoFireAttr = weapon:GetAttribute("AutoFire")
    if not weaponAutoFireAttr then fireRate = fireRate * 1.5 end
    if weapon.Name == "Remington 870" then fireRate = 0.45 end
    local lastShotTime = lastAutoShotByWeapon[weapon.Name] or 0
    if (tick() - lastShotTime) < fireRate then return end
    lastAutoShotByWeapon[weapon.Name] = tick()
    performAutoShot(weapon)
end)

local fastSwitchConnection = nil
local function stopFastSwitch()
    if fastSwitchConnection then pcall(function() task.cancel(fastSwitchConnection) end) fastSwitchConnection = nil end
end

local function startFastSwitch()
    stopFastSwitch()
    fastSwitchConnection = task.spawn(function()
        while SilentAimSettings.FastSwitchEnabled do
            local char = LocalPlayer.Character
            local humanoid = char and char:FindFirstChildOfClass("Humanoid")
            if not char or not humanoid or humanoid.Health <= 0 then task.wait(0.1) continue end
            local backpack = LocalPlayer:FindFirstChildOfClass("Backpack")
            if not backpack then task.wait(0.1) continue end
            local list = SilentAimSettings.FastSwitchList
            if not list or #list == 0 then task.wait(0.1) continue end
            for _, weaponName in ipairs(list) do
                if not SilentAimSettings.FastSwitchEnabled then break end
                local tool = char:FindFirstChild(weaponName) or backpack:FindFirstChild(weaponName)
                if tool and tool:IsA("Tool") then
                    if not char:FindFirstChild(weaponName) then
                        pcall(function() humanoid:EquipTool(tool) end)
                        local deadline = tick() + 0.2
                        while tick() < deadline do
                            if char:FindFirstChild(weaponName) then break end
                            task.wait()
                        end
                    end
                end
                task.wait(SilentAimSettings.FastSwitchDelay)
            end
        end
    end)
end

pcall(function()
    local hook = newcclosure(function() end)
    for _, obj in next, getgc(false) do
        if typeof(obj) == "function" then
            local ok, source = pcall(debug.info, obj, "s")
            if ok and source and source:find("CharacterCollision") then
                pcall(hookfunction, obj, hook)
            end
        end
    end
end)

local noclipActive = false
local noclipConn = nil
local function noclipStep()
    if not noclipActive then return end
    local char = LocalPlayer.Character
    if not char then return end
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") and part.CanCollide then part.CanCollide = false end
    end
end
local function stopNoclip()
    noclipActive = false
    if noclipConn then noclipConn:Disconnect() noclipConn = nil end
    local char = LocalPlayer.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.CanCollide = false end
    end
end
local function startNoclip()
    if noclipActive then return end
    noclipActive = true
    noclipConn = RunService.Stepped:Connect(noclipStep)
end

local noclipPunchActive = false
local noclipPunchConn = nil
local function stopNoclipPunch()
    noclipPunchActive = false
    if noclipPunchConn then noclipPunchConn:Disconnect() noclipPunchConn = nil end
end
local function startNoclipPunch()
    if noclipPunchActive then return end
    noclipPunchActive = true
    noclipPunchConn = RunService.Stepped:Connect(function()
        if not noclipPunchActive then return end
        local char = LocalPlayer.Character
        if not char then stopNoclipPunch() return end
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then part.CanCollide = false end
        end
    end)
    task.delay(1.2, function() stopNoclipPunch() end)
end
local function doNoclipPunch() task.delay(0.35, startNoclipPunch) end

local KorbloxMeshId = "rbxassetid://101851696"
local KorbloxTextureId = "rbxassetid://101851254"
local function applyKorblox(character)
    local rightLeg = character:FindFirstChild("Right Leg") or character:FindFirstChild("RightUpperLeg")
    if not rightLeg then return end
    for _, v in ipairs(rightLeg:GetChildren()) do
        if v:IsA("SpecialMesh") or v:IsA("CharacterMesh") then v:Destroy() end
    end
    local mesh = Instance.new("SpecialMesh")
    mesh.MeshType = Enum.MeshType.FileMesh
    mesh.MeshId = KorbloxMeshId
    mesh.TextureId = KorbloxTextureId
    mesh.Scale = Vector3.new(1, 1, 1)
    mesh.Parent = rightLeg
end

local HeadlessMeshId = "rbxassetid://1095708"
local function applyHeadless(character)
    local head = character:FindFirstChild("Head")
    if not head then return end
    head.Transparency = 1
    head.CanCollide = false
    local face = head:FindFirstChildOfClass("Decal")
    if face then face:Destroy() end
    for _, v in ipairs(head:GetChildren()) do
        if v:IsA("SpecialMesh") or v:IsA("CharacterMesh") then v:Destroy() end
    end
    local mesh = Instance.new("SpecialMesh")
    mesh.MeshType = Enum.MeshType.FileMesh
    mesh.MeshId = HeadlessMeshId
    mesh.Scale = Vector3.new(0.001, 0.001, 0.001)
    mesh.Parent = head
end

LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(1)
    if SilentAimSettings.HeadlessEnabled then applyHeadless(char) end
    if SilentAimSettings.KorbloxEnabled then applyKorblox(char) end
    if SilentAimSettings.FastSwitchEnabled then startFastSwitch() end
end)

local Library = nil
local function notify(text, color)
    pcall(function()
        if Library and Library.Notify then
            Library:Notify({ Title = "SPENT HUB", Description = tostring(text), Time = 3 })
        end
    end)
    print("[SPENT HUB]", text)
end

local currentSky = nil
local function applySkybox()
    if currentSky then pcall(function() currentSky:Destroy() end) currentSky = nil end
    if not SilentAimSettings.CustomSkybox then return end
end
local function applyFog()
    if SilentAimSettings.RemoveFog then
        Lighting.FogEnd = 1e5
        Lighting.FogStart = 1e5
    end
end
local gradObj = nil
local function applyWorldGradient()
    if gradObj then pcall(function() gradObj:Destroy() end) gradObj = nil end
    if not SilentAimSettings.WorldGradient then return end
    local cc = Instance.new("ColorCorrectionEffect")
    cc.TintColor = Color3.fromRGB(255, 200, 220)
    cc.Saturation = 0.1
    cc.Parent = Lighting
    gradObj = cc
end
task.spawn(function()
    while task.wait(1) do
        if SilentAimSettings.RemoveFog then applyFog() end
    end
end)

local RELOAD_SHUFFLE_GUNS = { "M9", "Revolver", "Remington 870", "MP5", "M4A1", "M700", "AK-47", "FAL", "Taser" }
local reloadShuffleBusy = false
pcall(function() SoundService.RespectFilteringEnabled = false end)

local ToolPropertiesFolder = nil
pcall(function()
    local sm = ReplicatedStorage:FindFirstChild("SharedModules")
    if sm then ToolPropertiesFolder = sm:FindFirstChild("ToolProperties") end
end)

local function resolveMaxAmmo(tool)
    if not tool then return 30 end
    for _, key in ipairs({ "MaxAmmo", "Local_MaxAmmo", "MagazineSize", "ClipSize", "Capacity" }) do
        local v = tool:GetAttribute(key)
        if typeof(v) == "number" and v > 0 then return math.floor(v) end
    end
    local defaults = { ["M9"]=15, ["Revolver"]=6, ["Remington 870"]=6, ["MP5"]=30, ["M4A1"]=30, ["M700"]=5, ["AK-47"]=30, ["FAL"]=20, ["Taser"]=4 }
    return defaults[tool.Name] or 30
end

local function playPreservedReloadSounds(tool)
    if not tool then return end
    pcall(function()
        for _, d in ipairs(tool:GetDescendants()) do
            if d:IsA("Sound") then
                local n = d.Name:lower()
                if n:find("reload") or n:find("shell") or n:find("mag") or n:find("chamber") then
                    local c = d:Clone()
                    c.Parent = workspace.CurrentCamera or workspace
                    c:Play()
                    Debris:AddItem(c, 6)
                end
            end
        end
    end)
end

local function refillTool(tool)
    if not tool or not tool:IsA("Tool") then return end
    local maxAmmo = resolveMaxAmmo(tool)
    pcall(function()
        tool:SetAttribute("Local_CurrentAmmo", maxAmmo)
        tool:SetAttribute("CurrentAmmo", maxAmmo)
        tool:SetAttribute("Ammo", maxAmmo)
        tool:SetAttribute("Local_MaxAmmo", maxAmmo)
        tool:SetAttribute("MaxAmmo", maxAmmo)
        tool:SetAttribute("Local_ReloadSession", 0)
        tool:SetAttribute("ReloadSession", 0)
        tool:SetAttribute("Reloading", false)
        tool:SetAttribute("IsReloading", false)
        tool:SetAttribute("Local_Reloading", false)
        tool:SetAttribute("CanFire", true)
        tool:SetAttribute("Local_CanFire", true)
    end)
    pcall(function() if updateAmmoLabel then updateAmmoLabel(tool, maxAmmo) end end)
end

local function collectGuns()
    local list, seen = {}, {}
    local function add(container)
        if not container then return end
        for _, child in ipairs(container:GetChildren()) do
            if child:IsA("Tool") and table.find(RELOAD_SHUFFLE_GUNS, child.Name) and not seen[child] then
                seen[child] = true
                table.insert(list, child)
            end
        end
    end
    add(LocalPlayer.Character)
    add(LocalPlayer:FindFirstChild("Backpack"))
    return list
end

local function doReloadShuffle()
    if IS_MOBILE or reloadShuffleBusy then return end
    reloadShuffleBusy = true
    local guns = collectGuns()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local n = #guns
    if n == 0 then
        reloadShuffleBusy = false
        notify("No guns to reload")
        return
    end
    local step = math.max(0.01, 0.1 / n)
    task.spawn(function()
        for i, tool in ipairs(guns) do
            if not tool.Parent then continue end
            pcall(function() if hum then hum:EquipTool(tool) end end)
            refillTool(tool)
            playPreservedReloadSounds(tool)
            task.wait(step)
        end
        for _, tool in ipairs(collectGuns()) do refillTool(tool) end
        reloadShuffleBusy = false
        notify("Reload Shuffle · " .. tostring(n) .. " guns · 0.1s")
    end)
end
getgenv().SpentReloadShuffle = doReloadShuffle

SilentAimSettings.Hotkeys = SilentAimSettings.Hotkeys or {}
local hotkeyActions = {}
local function registerHotkeyAction(id, fn) hotkeyActions[id] = fn end

UserInputService.InputBegan:Connect(function(input, processed)
    if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
    if IS_MOBILE then return end
    local name = input.KeyCode.Name
    local rs = SilentAimSettings.ReloadShuffleKey
    if rs and rs ~= "" and rs ~= "None" and name == rs then
        doReloadShuffle()
        return
    end
    if processed then return end
    for id, keyName in pairs(SilentAimSettings.Hotkeys) do
        if keyName and keyName ~= "" and keyName ~= "None" and keyName == name then
            local fn = hotkeyActions[id]
            if fn then pcall(fn) end
        end
    end
end)

local HUB_ICON_ASSET_ID = 72635810815367

local function loadUI()
    local repo = "https://raw.githubusercontent.com/majeskooooo/Obsidian/main/"
    local ok, Lib = pcall(function() return loadstring(game:HttpGet(repo .. "Library.lua"))() end)
    if not ok or not Lib then return nil end
    
    Library = Lib
    getgenv().Library = Library
    
    Library.Scheme.AccentColor = Color3.fromRGB(255, 182, 193)
    Library.Scheme.BackgroundColor = Color3.fromRGB(10, 13, 18)
    Library.Scheme.MainColor = Color3.fromRGB(18, 22, 30)
    Library.Scheme.OutlineColor = Color3.fromRGB(28, 34, 44)

    local Window = Library:CreateWindow({
        Title = "SPENT HUB", Footer = "SPENT HUB", FooterLeft = "V1", FooterRight = "made by spent",
        Icon = HUB_ICON_ASSET_ID, NotifySide = "Right", ShowCustomCursor = false, 
        Size = UDim2.fromOffset(720, 520), Center = true, Resizable = true, ToggleKeybind = Enum.KeyCode.RightShift,
        CornerRadius = 12,
    })

    local Tabs = {
        Main = Window:AddTab("Main", "crosshair"),
        Player = Window:AddTab("Player", "user"),
        Visuals = Window:AddTab("Visuals", "eye"),
        Settings = Window:AddTab("Settings", "settings"),
    }

    local function addToggle(group, idx, text, default, onChange)
        return group:AddToggle(idx, { Text = text, Default = default == true, Callback = function(v) onChange(v) end })
    end

    local function addToggleHK(group, idx, text, default, onChange, hotkeyId)
        local tog = addToggle(group, idx, text, default, onChange)
        if tog and tog.AddKeyPicker and hotkeyId then
            SilentAimSettings.Hotkeys[hotkeyId] = SilentAimSettings.Hotkeys[hotkeyId] or "None"
            tog:AddKeyPicker(idx .. "_HK", {
                Text = "Key", Default = "None", Mode = "Toggle", SyncToggleState = false,
                ChangedCallback = function(key)
                    local name = typeof(key) == "EnumItem" and key.Name or tostring(key or "None")
                    if name == "" or name == "nil" then name = "None" end
                    SilentAimSettings.Hotkeys[hotkeyId] = name
                end,
            })
            registerHotkeyAction(hotkeyId, function()
                local t = Library and Library.Toggles and Library.Toggles[idx]
                if t and t.SetValue then t:SetValue(not t.Value) end
            end)
        end
        return tog
    end

    local aim = Tabs.Main:AddLeftGroupbox("Silent Aim")
    addToggleHK(aim, "SA_Enabled", "Silent Aim", SilentAimSettings.Enabled, function(v) SilentAimSettings.Enabled = v end, "SilentAim")
    aim:AddDropdown("SA_Part", { Text = "Target Part", Values = { "Head", "HumanoidRootPart", "LeftArm", "RightArm", "LeftLeg", "RightLeg", "Random" }, Default = SilentAimSettings.TargetPart, Callback = function(v) SilentAimSettings.TargetPart = v end })
    aim:AddSlider("SA_Hit", { Text = "Hit Chance", Default = SilentAimSettings.HitChance, Min = 0, Max = 100, Rounding = 0, Callback = function(v) SilentAimSettings.HitChance = v end })
    addToggle(aim, "SA_FF", "Forcefield Check", SilentAimSettings.ForcefieldCheck, function(v) SilentAimSettings.ForcefieldCheck = v end)
    addToggleHK(aim, "SA_Auto", "Autoshoot", SilentAimSettings.AutoshootEnabled, function(v) SilentAimSettings.AutoshootEnabled = v end, "Autoshoot")

    local filters = Tabs.Main:AddRightGroupbox("Filters / FOV")
    addToggle(filters, "SA_Team", "Team Check", SilentAimSettings.TeamCheck, function(v) SilentAimSettings.TeamCheck = v end)
    addToggle(filters, "SA_Vis", "Visible Check", SilentAimSettings.VisibleCheck, function(v) SilentAimSettings.VisibleCheck = v end)
    addToggle(filters, "FOV_On", "FOV Circle", SilentAimSettings.FOVVisible, function(v) SilentAimSettings.FOVVisible = v end)
    filters:AddSlider("FOV_Sz", { Text = "FOV Radius", Default = SilentAimSettings.FOVRadius, Min = 0, Max = 400, Rounding = 0, Callback = function(v) SilentAimSettings.FOVRadius = v end })

    local fs = Tabs.Main:AddLeftGroupbox("Fast Switch")
    addToggleHK(fs, "FS_On", "Fast Switch", SilentAimSettings.FastSwitchEnabled, function(v) SilentAimSettings.FastSwitchEnabled = v; if v then startFastSwitch() else stopFastSwitch() end end, "FastSwitch")
    fs:AddSlider("FS_Delay", { Text = "Switch Speed x100", Default = math.floor(SilentAimSettings.FastSwitchDelay * 100), Min = 1, Max = 50, Rounding = 0, Callback = function(v) SilentAimSettings.FastSwitchDelay = v / 100 end })

    local srBox = Tabs.Main:AddRightGroupbox("Reload Shuffle")
    srBox:AddLabel("PC only · equip + reload all · 0.1s")
    srBox:AddLabel("Reload Shuffle Key"):AddKeyPicker("SR_Key", {
        Text = "Key", Default = "None", Mode = "Always", SyncToggleState = false,
        ChangedCallback = function(key)
            local name = typeof(key) == "EnumItem" and key.Name or tostring(key or "None")
            if name == "" or name == "nil" then name = "None" end
            SilentAimSettings.ReloadShuffleKey = name
        end,
    })

    local pl = Tabs.Player:AddLeftGroupbox("Character")
    addToggle(pl, "PL_Kor", "Korblox", SilentAimSettings.KorbloxEnabled, function(v) SilentAimSettings.KorbloxEnabled = v; local c = LocalPlayer.Character; if v and c then applyKorblox(c) end end)
    addToggle(pl, "PL_Head", "Headless", SilentAimSettings.HeadlessEnabled, function(v) SilentAimSettings.HeadlessEnabled = v; local c = LocalPlayer.Character; if v and c then applyHeadless(c) end end)
    addToggle(pl, "PL_Punch", "Noclip Punch (F)", SilentAimSettings.NoclipPunchEnabled, function(v) SilentAimSettings.NoclipPunchEnabled = v end)

    local esp = Tabs.Visuals:AddLeftGroupbox("ESP")
    addToggleHK(esp, "ESP_On", "Enable ESP", SilentAimSettings.ESP_Enabled, function(v) SilentAimSettings.ESP_Enabled = v end, "ESP")
    addToggle(esp, "ESP_Name", "Names", SilentAimSettings.ESP_Name, function(v) SilentAimSettings.ESP_Name = v end)
    addToggle(esp, "ESP_HP", "Health Bar", SilentAimSettings.ESP_Health, function(v) SilentAimSettings.ESP_Health = v end)
    esp:AddSlider("ESP_Dist", { Text = "Max Distance", Default = SilentAimSettings.ESP_MaxDistance, Min = 100, Max = 3000, Rounding = 0, Callback = function(v) SilentAimSettings.ESP_MaxDistance = v end })

    local menu = Tabs.Settings:AddLeftGroupbox("Menu")
    menu:AddButton({ Text = "Unload", Func = function() if getgenv().SpentUnloadHub then getgenv().SpentUnloadHub() else pcall(function() Library:Unload() end) end end })

    Library:Notify({ Title = "SPENT HUB", Description = "made by spent · loaded", Time = 4 })
    return Library
end

Library = loadUI()

local espData = {}
local ESP_LOGIC_INTERVAL = 0.05

local function createESPData()
    local d = {}
    d.name = Drawing.new("Text")
    d.name.Visible = false
    d.name.Font = 2
    d.name.Center = true
    d.name.Outline = true
    d.name.ZIndex = 10
    d.hpbarbg = Drawing.new("Square")
    d.hpbarbg.Visible = false
    d.hpbarbg.Filled = true
    d.hpbarbg.Thickness = 0
    d.hpbarbg.ZIndex = 10
    d.hpbar = Drawing.new("Square")
    d.hpbar.Visible = false
    d.hpbar.Filled = true
    d.hpbar.Thickness = 0
    d.hpbar.ZIndex = 11
    d.trace = Drawing.new("Line")
    d.trace.Visible = false
    d.trace.ZIndex = 9
    d.trace.Thickness = 1
    d.hl = Instance.new("Highlight")
    d.hl.FillColor = SilentAimSettings.ESP_HighlightColor
    d.hl.OutlineColor = SilentAimSettings.ESP_HighlightColor
    d.hl.FillTransparency = 0.55
    d.hl.OutlineTransparency = 0
    d.hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    d.hl.Enabled = false
    return d
end

local function hideESPData(d)
    if not d then return end
    d.name.Visible = false
    d.hpbar.Visible = false
    d.hpbarbg.Visible = false
    d.trace.Visible = false
    if d.hl then d.hl.Enabled = false end
end

local function removeESPData(plr)
    local d = espData[plr]
    if not d then return end
    pcall(function() d.name:Remove() end)
    pcall(function() d.hpbar:Remove() end)
    pcall(function() d.hpbarbg:Remove() end)
    pcall(function() d.trace:Remove() end)
    pcall(function() d.hl:Destroy() end)
    espData[plr] = nil
end

local espLastLogic = 0
local espCache = {}

local function updateESPLogic()
    if not SilentAimSettings.ESP_Enabled then
        for _, d in pairs(espData) do hideESPData(d) end
        return
    end

    local myC = LocalPlayer.Character
    local myR = myC and myC:FindFirstChild("HumanoidRootPart")
    local camPos = myR and myR.Position or Camera.CFrame.Position
    local maxDist = SilentAimSettings.ESP_MaxDistance
    local teamColors = SilentAimSettings.ESP_Team
    local myTeam = LocalPlayer.Team
    local vp = Camera.ViewportSize

    table.clear(espCache)
    for _, p in ipairs(Players:GetPlayers()) do
        if p == LocalPlayer then continue end
        local c = p.Character
        local h = c and c:FindFirstChildOfClass("Humanoid")
        local r = c and c:FindFirstChild("HumanoidRootPart")
        if c and h and r and h.Health > 0 then
            espCache[p] = {c = c, h = h, r = r, head = c:FindFirstChild("Head")}
        end
    end

    for p, info in pairs(espCache) do
        local c, h, r, head = info.c, info.h, info.r, info.head
        local d = espData[p]
        if not d then d = createESPData() espData[p] = d end

        if teamColors and p.Team and p.Team == myTeam then
            hideESPData(d)
            continue
        end

        local dist = (r.Position - camPos).Magnitude
        if dist > maxDist then
            hideESPData(d)
            continue
        end

        local headPos = head and head.Position or (r.Position + Vector3.new(0, 2.5, 0))
        local feetPos = r.Position - Vector3.new(0, 2.8, 0)
        local hVec3 = Camera:WorldToViewportPoint(headPos)
        local fVec3 = Camera:WorldToViewportPoint(feetPos)

        if hVec3.Z <= 0 and fVec3.Z <= 0 then
            hideESPData(d)
            continue
        end

        local hs = Vector2.new(hVec3.X, hVec3.Y)
        local fs = Vector2.new(fVec3.X, fVec3.Y)
        local refX = hVec3.Z > 0 and hs.X or fs.X
        local refY = hVec3.Z > 0 and hs.Y or fs.Y

        if refX < -200 or refX > vp.X + 200 or refY < -200 or refY > vp.Y + 200 then
            hideESPData(d)
            continue
        end

        local bh = math.clamp(math.abs(hs.Y - fs.Y), 12, 400)
        local topY = math.min(hs.Y, fs.Y)
        local botY = topY + bh
        local midX = hs.X

        if SilentAimSettings.ESP_Highlight then
            local isTarget = (currentTarget and currentTarget.Parent == c)
            local color
            if isTarget then
                color = TARGET_LOCK_COLOR
            else
                color = teamColors and getTeamColor(p) or SilentAimSettings.ESP_HighlightColor
            end
            if d.hl.Adornee ~= c then d.hl.Adornee = c end
            if d.hl.Parent ~= c then d.hl.Parent = c end
            d.hl.FillColor = color
            d.hl.OutlineColor = color
            d.hl.Enabled = true
        else
            d.hl.Enabled = false
        end

        if SilentAimSettings.ESP_Name then
            d.name.Visible = true
            d.name.Text = string.format("%s [%d]", p.Name, math.floor(dist))
            d.name.Color = SilentAimSettings.ESP_NameColor
            d.name.Size = math.clamp(13 - dist / 120, 8, 14)
            d.name.Position = Vector2.new(midX, topY - 16)
        else
            d.name.Visible = false
        end

        if SilentAimSettings.ESP_Health then
            local pct = math.clamp(h.Health / math.max(h.MaxHealth, 1), 0, 1)
            local bwd = math.max(3, math.min(6, bh * 0.06))
            local bx = midX - (bh * 0.275) - bwd - 4
            d.hpbarbg.Visible = true
            d.hpbarbg.Position = Vector2.new(bx, topY)
            d.hpbarbg.Size = Vector2.new(bwd, bh)
            d.hpbarbg.Color = Color3.fromRGB(20, 20, 20)
            local fillH = bh * pct
            d.hpbar.Visible = true
            d.hpbar.Position = Vector2.new(bx, botY - fillH)
            d.hpbar.Size = Vector2.new(bwd, fillH)
            local r2 = math.floor(255 * (1 - pct))
            local g2 = math.floor(255 * pct)
            d.hpbar.Color = Color3.fromRGB(r2, g2, 40)
        else
            d.hpbar.Visible = false
            d.hpbarbg.Visible = false
        end

        if SilentAimSettings.ESP_Trace then
            d.trace.Visible = true
            d.trace.From = Vector2.new(vp.X / 2, vp.Y)
            d.trace.To = Vector2.new(midX, botY)
            d.trace.Color = teamColors and getTeamColor(p) or SilentAimSettings.ESP_TraceColor
        else
            d.trace.Visible = false
        end
    end

    for plr, _ in pairs(espData) do
        if not plr.Parent or not espCache[plr] then
            removeESPData(plr)
        end
    end
end

Players.PlayerRemoving:Connect(function(plr)
    task.wait(0.1)
    removeESPData(plr)
end)

local function spentToggleMenu()
    local lib = Library or getgenv().Library
    if not lib then return end
    local ok = false
    ok = pcall(function() if type(lib.Toggle) == "function" then lib:Toggle() return true end end) and true or ok
    if not ok then pcall(function() if lib.Toggled ~= nil then lib.Toggled = not lib.Toggled ok = true end end) end
    pcall(function() if lib.ScreenGui then lib.ScreenGui.Enabled = not lib.ScreenGui.Enabled ok = true end end)
    pcall(function()
        local root = lib.WindowContainer or lib.MainFrame or lib.Outer
        if root and root:IsA("GuiObject") then root.Visible = not root.Visible ok = true end
    end)
end

local function spentUnloadHub()
    UserInputService.MouseIconEnabled = originalMouseIconEnabled
    pcall(function() if cursorOuter then cursorOuter:Remove() end end)
    pcall(function() if cursorInner then cursorInner:Remove() end end)
    if cursorConnection then pcall(function() cursorConnection:Disconnect() end) end
    pcall(function() if fov_circle then fov_circle:Remove() end end)
    pcall(function() if mouse_box then mouse_box:Remove() end end)
    pcall(stopNoclip)
    pcall(stopNoclipPunch)
    pcall(stopFastSwitch)
    pcall(function() for _, p in ipairs(Players:GetPlayers()) do removeESPData(p) end end)
    local lib = Library or getgenv().Library
    pcall(function() if lib and type(lib.Unload) == "function" then lib:Unload() end end)
    pcall(function() if lib and lib.ScreenGui then lib.ScreenGui.Enabled = false lib.ScreenGui:Destroy() end end)
end
getgenv().SpentUnloadHub = spentUnloadHub
getgenv().SpentToggleMenu = spentToggleMenu

UserInputService.InputBegan:Connect(function(input, processed)
    if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
    if input.KeyCode == Enum.KeyCode.RightShift then spentToggleMenu() return end
    if input.KeyCode == Enum.KeyCode.End then spentUnloadHub() return end
    if processed then return end
    if input.KeyCode == Enum.KeyCode.F and not IS_MOBILE then
        if SilentAimSettings.NoclipPunchEnabled then doNoclipPunch() end
    end
end)

task.spawn(function()
    RenderStepped:Connect(function()
        if SilentAimSettings.ShowSilentAimTarget and SilentAimSettings.Enabled then
            if currentTarget and currentTarget.Parent then
                local vp2, on = WorldToViewportPoint(Camera, currentTarget.Position)
                mouse_box.Visible = on
                mouse_box.Position = Vector2.new(vp2.X, vp2.Y)
            else
                mouse_box.Visible = false
                mouse_box.Position = Vector2.new()
            end
        else
            mouse_box.Visible = false
        end

        if SilentAimSettings.FOVVisible then
            fov_circle.Visible = true
            fov_circle.Radius = SilentAimSettings.FOVRadius
            fov_circle.Position = SilentAimSettings.FOVCenter and getCenter() or getCursorPos()
            fov_circle.Color = (currentTarget and currentTarget.Parent) and TARGET_LOCK_COLOR or RING_IDLE_COLOR
        else
            fov_circle.Visible = false
        end

        local now = tick()
        if now - espLastLogic >= ESP_LOGIC_INTERVAL then
            espLastLogic = now
            pcall(updateESPLogic)
        end
    end)
end)

local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
    local Method = getnamecallmethod()
    local Args = {...}
    local self = Args[1]

    if Method == "Play" and not checkcaller() then
        local ok, isSoundClass = pcall(function() return self.ClassName == "Sound" end)
        if ok and isSoundClass then
            local tool = self.Parent and self.Parent.Parent
            local localChar = LocalPlayer.Character
            if localChar and tool and tool.Parent == localChar and tool.ClassName == "Tool" and tool:GetAttribute("ToolType") == "Gun" then
                pcall(function()
                    local soundClone = self:Clone()
                    soundClone.Parent = Camera
                    soundClone.Playing = true
                    task.delay(5, function() pcall(function() soundClone:Destroy() end) end)
                end)
                return
            end
        end
    end

    if SilentAimSettings.Enabled and self == workspace and not checkcaller() and not AutoShootRaycastInProgress then
        local hit = currentTarget
        if hit and hit.Parent then
            if Method == "FindPartOnRayWithIgnoreList" and SilentAimSettings.SilentAimMethod == Method then
                if ValidateArguments(Args, ExpectedArguments.FindPartOnRayWithIgnoreList) then
                    local r = Args[2]
                    local aimPoint = getAimPointWithSpread(hit, r.Origin) or hit.Position
                    Args[2] = Ray.new(r.Origin, getDirection(r.Origin, aimPoint))
                    return oldNamecall(unpack(Args))
                end
            elseif Method == "FindPartOnRayWithWhitelist" and SilentAimSettings.SilentAimMethod == Method then
                if ValidateArguments(Args, ExpectedArguments.FindPartOnRayWithWhitelist) then
                    local r = Args[2]
                    local aimPoint = getAimPointWithSpread(hit, r.Origin) or hit.Position
                    Args[2] = Ray.new(r.Origin, getDirection(r.Origin, aimPoint))
                    return oldNamecall(unpack(Args))
                end
            elseif (Method == "FindPartOnRay" or Method == "findPartOnRay") and SilentAimSettings.SilentAimMethod:lower() == Method:lower() then
                if ValidateArguments(Args, ExpectedArguments.FindPartOnRay) then
                    local r = Args[2]
                    local aimPoint = getAimPointWithSpread(hit, r.Origin) or hit.Position
                    Args[2] = Ray.new(r.Origin, getDirection(r.Origin, aimPoint))
                    return oldNamecall(unpack(Args))
                end
            elseif Method == "Raycast" and SilentAimSettings.SilentAimMethod == Method then
                if ValidateArguments(Args, ExpectedArguments.Raycast) then
                    local o = Args[2]
                    local aimPoint = getAimPointWithSpread(hit, o) or hit.Position
                    Args[3] = getDirection(o, aimPoint)
                    return oldNamecall(unpack(Args))
                end
            end
        end
    end
    return oldNamecall(...)
end))

local oldIndex = nil
oldIndex = hookmetamethod(game, "__index", newcclosure(function(self, i)
    if self == Mouse and not checkcaller() and SilentAimSettings.Enabled and SilentAimSettings.SilentAimMethod == "Mouse.Hit/Target" and currentTarget and currentTarget.Parent then
        local hit = currentTarget
        if i == "Target" or i == "target" then
            return hit
        elseif i == "Hit" or i == "hit" then
            local aimPoint = getAimPointWithSpread(hit, Camera.CFrame.Position) or hit.Position
            return CFrame.new(aimPoint)
        elseif i == "X" or i == "x" then
            return self.X
        elseif i == "Y" or i == "y" then
            return self.Y
        elseif i == "UnitRay" then
            return Ray.new(self.Origin, (self.Hit - self.Origin).Unit)
        end
    end
    return oldIndex(self, i)
end))

print("SPENT HUB loaded · made by spent")
