if not game:IsLoaded() then game.Loaded:Wait() end
if not syn or not protectgui then getgenv().protectgui = function() end end

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
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
startupFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
startupFrame.BackgroundTransparency = 0.08
startupFrame.BorderSizePixel = 0
Instance.new("UICorner", startupFrame).CornerRadius = UDim.new(0.11, 0)

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
TweenService:Create(startupFill, TweenInfo.new(1.2, Enum.EasingStyle.Linear), {
    Size = UDim2.new(1, 0, 1, 0)
}):Play()

task.wait(1.2)

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
    AutoshootEnabled = false, NoclipEnabled = false,
    SpeedValue = 16, JumpPowerValue = 50,
    InvisibleEnabled = false, KorbloxEnabled = false, HeadlessEnabled = false,
    FastSwitchEnabled = false, FastSwitchDelay = 0.05,
    FastSwitchList = {"M9", "Revolver", "Remington 870", "MP5", "M4A1", "M700", "AK-47"},
    FastSwitchHotkey = Enum.KeyCode.H, NoclipPunchEnabled = false,
    AutoReloadEnabled = false,
    GunModEnabled = false,
    FastFirerateEnabled = false,
    FireRateValue = 0.01,
    AutoFire = false,
    HitboxExpanderEnabled = false,
    HitboxTeamCheck = true,
    HitboxSize = 5,
    HitboxTransparency = 0.5,
    HitboxShape = "Box",
    KillEffectEnabled = false,
    KillEffectColor = Color3.fromRGB(255, 182, 193),
    KillEffectFadeDuration = 0.25,
    KillLogsEnabled = false,
    HitLogsEnabled = false,
    CustomHitSoundEnabled = false,
    CustomKillSoundEnabled = false,
    HitSoundName = "Neverlose",
    KillSoundName = "Vine Boom",
    WeaponSoundPack = "None",
    TracerESPEnabled = false,
    TracerTargetOnly = false,
    TracerThickness = 0.15,
    TracerColor = Color3.fromRGB(255, 182, 193),
    RemoveFog = false,
    CustomSkybox = false,
    SkyboxName = "None",
    WorldGradient = false,
    GetWeaponsList = {"M9", "AK-47", "M4A1", "Remington 870", "M700", "MP5", "Revolver"},
    AutoGetWeapons = false,
    SpinbotSpeed = 0,
    AntiInvisibleEnabled = false,
    InfiniteStamina = false,
    InfiniteJumpEnabled = false,
    CameraFOVEnabled = false,
    CameraFOV = 70,
    Hotkeys = {},
}
getgenv().SilentAimSettings = SilentAimSettings

local Whitelist = {}
getgenv().SilentAimWhitelist = Whitelist
local function isWhitelisted(plr) if not plr then return false end return Whitelist[string.lower(plr.Name)] == true end
local function addWhitelist(name) if not name or name == "" then return false end Whitelist[string.lower(name)] = true return true end
local function removeWhitelist(name) if not name then return false end Whitelist[string.lower(name)] = nil return true end

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
local HttpService = game:GetService("HttpService")
local Mouse = LocalPlayer:GetMouse()
local GetPlayers = Players.GetPlayers
local WorldToScreen = Camera.WorldToScreenPoint
local WorldToViewportPoint = Camera.WorldToViewportPoint
local GetPartsObscuringTarget = Camera.GetPartsObscuringTarget
local FindFirstChild = game.FindFirstChild
local RenderStepped = RunService.RenderStepped
local GetMouseLocation = UserInputService.GetMouseLocation
local ValidTargetParts = {"Head", "HumanoidRootPart"}
local PredictionAmount = 0.165

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

local cursorGui = nil
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
local function CalculateChance(Percentage)
    if Percentage == nil then return true end
    Percentage = tonumber(Percentage) or 100
    if Percentage >= 100 then return true end
    if Percentage <= 0 then return false end
    local roll = _rng:NextNumber(0, 100)
    return roll < Percentage
end

local function getPositionOnScreen(Vector)
    local Vec3, OnScreen = WorldToScreen(Camera, Vector)
    if Vec3.Z < 0 then return Vector2.new(), false end
    return Vector2.new(Vec3.X, Vec3.Y), OnScreen
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
            local targetPartName = SilentAimSettings.TargetPart
            local partInstance
            if targetPartName == "Random" then
                partInstance = Character[ValidTargetParts[math.random(1, #ValidTargetParts)]]
            else
                partInstance = Character[targetPartName]
            end
            Closest = partInstance
            DistanceToMouse = Distance
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

local function getSmoothedTargetPosition()
    if currentTarget and currentTarget.Parent then return currentTarget.Position end
    return nil
end

local function getRedirectedDirectionForAutoShoot(Origin)
    local pos = getSmoothedTargetPosition()
    if not pos then return nil end
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
    local hitInstance = result and result.Instance or nil
    local hitPosition = result and result.Position or (origin + direction)
    return hitInstance, hitPosition
end

local function performAutoShot(weapon)
    if not weapon or not shootRemote then return end
    if not currentTarget or not currentTarget.Parent then return end
    local behavior = weapon:GetAttribute("Behavior")
    local reloadSession = weapon:GetAttribute("Local_ReloadSession") or 0
    local currentAmmo = weapon:GetAttribute("Local_CurrentAmmo") or 0
    if reloadSession ~= 0 then return end
    if currentAmmo <= 0 then return end
    local char = LocalPlayer.Character
    local head = char and char:FindFirstChild("Head")
    if not head then return end
    local origin = head.Position
    autoShootParams.FilterDescendantsInstances = { char }
    local aimPoint = currentTarget.Position
    local redirected = getRedirectedDirectionForAutoShoot(origin)
    if redirected then aimPoint = origin + redirected end
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
    if not CalculateChance(SilentAimSettings.HitChance) then return end
    local char = LocalPlayer.Character
    local myHumanoid = char and char:FindFirstChildOfClass("Humanoid")
    if not myHumanoid or myHumanoid.Health <= 0 then return end
    local weapon = getEquippedWeapon()
    if not weapon then return end
    if not table.find(gunModNames, weapon.Name) then return end
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
                local tool = backpack:FindFirstChild(weaponName) or char:FindFirstChild(weaponName)
                if tool and tool:IsA("Tool") then
                    local h = humanoid
                    local t = tool
                    task.spawn(function() pcall(function() h:EquipTool(t) end) end)
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

local function applySpeed(v)
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = v end
end
local function applyJumpPower(v)
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then hum.UseJumpPower = true hum.JumpPower = v end
end

local InvisibleRealCFrame = nil
local InvisibleAnimationTrack = nil
local InvisibleRenderKey = "SpentHubInvisibleRender"
local InvisibleOriginalTransparency = {}
local InvisibleOriginalCanCollide = {}

local function loadInvisibleAnimation(character)
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return nil end
    local animator = humanoid:FindFirstChildOfClass("Animator")
    if not animator then return nil end
    local isR15 = humanoid.RigType == Enum.HumanoidRigType.R15
    local animation = Instance.new("Animation")
    animation.AnimationId = isR15 and "rbxassetid://18665825805" or "rbxassetid://215384594"
    local track = animator:LoadAnimation(animation)
    track.Priority = Enum.AnimationPriority.Action4
    track:Play(0, 0.001, 0)
    animation:Destroy()
    task.delay(0, function() track.TimePosition = isR15 and 1.95 or 0.4 end)
    return track
end

local function stopInvisible()
    pcall(function() RunService:UnbindFromRenderStep(InvisibleRenderKey) end)
    if InvisibleAnimationTrack then InvisibleAnimationTrack:Stop() InvisibleAnimationTrack:Destroy() InvisibleAnimationTrack = nil end
    local character = LocalPlayer.Character
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    if rootPart and InvisibleRealCFrame then
        rootPart.CFrame = InvisibleRealCFrame
        local currentVelocity = rootPart.AssemblyLinearVelocity
        rootPart.AssemblyLinearVelocity = Vector3.new(currentVelocity.X, 0, currentVelocity.Z)
    end
    InvisibleRealCFrame = nil
    if character then
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") and part ~= rootPart then
                if InvisibleOriginalTransparency[part] ~= nil then part.Transparency = InvisibleOriginalTransparency[part] end
                if InvisibleOriginalCanCollide[part] ~= nil then part.CanCollide = InvisibleOriginalCanCollide[part] end
            end
        end
        if rootPart then rootPart.Transparency = 0 end
    end
    table.clear(InvisibleOriginalTransparency)
    table.clear(InvisibleOriginalCanCollide)
end

local function startInvisible()
    local character = LocalPlayer.Character
    if not character then return end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not rootPart then return end
    InvisibleAnimationTrack = loadInvisibleAnimation(character)
    InvisibleRealCFrame = nil
    table.clear(InvisibleOriginalTransparency)
    table.clear(InvisibleOriginalCanCollide)
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") and part ~= rootPart then
            InvisibleOriginalTransparency[part] = part.Transparency
            InvisibleOriginalCanCollide[part] = part.CanCollide
            part.Transparency = 0.5
            part.CanCollide = false
        end
    end
    rootPart.Transparency = 1
    pcall(function() RunService:UnbindFromRenderStep(InvisibleRenderKey) end)
    RunService:BindToRenderStep(InvisibleRenderKey, Enum.RenderPriority.Camera.Value - 1, function()
        if SilentAimSettings.InvisibleEnabled and InvisibleRealCFrame and rootPart.Parent then
            rootPart.CFrame = InvisibleRealCFrame
            if InvisibleAnimationTrack then InvisibleAnimationTrack:AdjustWeight(0.001) end
        end
    end)
end

RunService.Heartbeat:Connect(function()
    if not SilentAimSettings.InvisibleEnabled then return end
    local character = LocalPlayer.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not rootPart then return end
    local isR15 = humanoid.RigType == Enum.HumanoidRigType.R15
    local dropOffset = humanoid.HipHeight + (rootPart.Size.Y / 2) - 1
    InvisibleRealCFrame = rootPart.CFrame
    rootPart.CFrame = (rootPart.CFrame - Vector3.new(0, dropOffset, 0)) * CFrame.Angles(math.rad(isR15 and 180 or 90), 0, 0)
    local currentVelocity = rootPart.AssemblyLinearVelocity
    rootPart.AssemblyLinearVelocity = Vector3.new(currentVelocity.X, 0, currentVelocity.Z)
    if InvisibleAnimationTrack then InvisibleAnimationTrack:AdjustWeight(100) end
end)

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
    if SilentAimSettings.NoclipEnabled then startNoclip() end
    if SilentAimSettings.InvisibleEnabled then startInvisible() end
    if SilentAimSettings.HeadlessEnabled then applyHeadless(char) end
    if SilentAimSettings.KorbloxEnabled then applyKorblox(char) end
    task.wait(0.1)
    applySpeed(SilentAimSettings.SpeedValue)
    applyJumpPower(SilentAimSettings.JumpPowerValue)
    if SilentAimSettings.FastSwitchEnabled then startFastSwitch() end
end)

-- ===================== NOTIFY =====================
local Library = nil
local function notify(text, color)
    pcall(function()
        if Library and Library.Notify then
            Library:Notify({ Title = "SPENT HUB", Description = tostring(text), Time = 1.2 })
        end
    end)
    print("[SPENT HUB]", text)
end

-- ===================== SPENT HUB EXTRA FEATURES =====================
local Lighting = game:GetService("Lighting")
local Debris = game:GetService("Debris")
local StarterGui = game:GetService("StarterGui")

-- Infinite jump
UserInputService.JumpRequest:Connect(function()
    if not SilentAimSettings.InfiniteJumpEnabled then return end
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
end)

-- Camera FOV + spinbot
RunService.RenderStepped:Connect(function()
    if SilentAimSettings.CameraFOVEnabled and Camera then
        Camera.FieldOfView = SilentAimSettings.CameraFOV or 70
    end
    local spd = tonumber(SilentAimSettings.SpinbotSpeed) or 0
    if spd > 0 then
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(spd), 0) end
    end
end)

-- Infinite stamina
task.spawn(function()
    while task.wait(0.5) do
        if not SilentAimSettings.InfiniteStamina then continue end
        pcall(function()
            local char = LocalPlayer.Character
            if not char then return end
            for _, v in ipairs(char:GetDescendants()) do
                if v:IsA("LocalScript") and (v.Name:lower():find("jump") or v.Name:lower():find("stamina")) then
                    v.Disabled = true
                end
            end
        end)
    end
end)

-- Anti-invisible
local AntiInvisibleThreads, AntiInvisibleWhitelist = {}, {
    ["rbxassetid://507766388"] = true, ["rbxassetid://507766666"] = true,
    ["rbxassetid://507770239"] = true, ["rbxassetid://507770453"] = true,
    ["rbxassetid://507771019"] = true, ["rbxassetid://507771955"] = true,
    ["rbxassetid://507776043"] = true, ["rbxassetid://507776720"] = true,
    ["rbxassetid://507777268"] = true, ["rbxassetid://507777451"] = true,
}
pcall(function()
    for _, a in ipairs(ReplicatedStorage:GetDescendants()) do
        if a:IsA("Animation") then AntiInvisibleWhitelist[a.AnimationId] = true end
    end
end)
local function watchAnim(track)
    local id = track.Animation and track.Animation.AnimationId
    if not id or AntiInvisibleWhitelist[id] then return end
    if AntiInvisibleThreads[track] then task.cancel(AntiInvisibleThreads[track]) end
    AntiInvisibleThreads[track] = task.spawn(function()
        repeat track:AdjustWeight(0, 0) task.wait()
        until not (track.IsPlaying and SilentAimSettings.AntiInvisibleEnabled)
        AntiInvisibleThreads[track] = nil
    end)
end
local function hookCharAnims(character)
    local hum = character:WaitForChild("Humanoid", 5)
    if not hum then return end
    local anim = hum:FindFirstChildOfClass("Animator") or hum:WaitForChild("Animator", 5)
    if not anim then return end
    anim.AnimationPlayed:Connect(function(track)
        if SilentAimSettings.AntiInvisibleEnabled then watchAnim(track) end
    end)
end
local function hookPlrAnims(plr)
    if plr == LocalPlayer then return end
    if plr.Character then task.spawn(hookCharAnims, plr.Character) end
    plr.CharacterAdded:Connect(function(c) task.spawn(hookCharAnims, c) end)
end
for _, p in ipairs(Players:GetPlayers()) do hookPlrAnims(p) end
Players.PlayerAdded:Connect(hookPlrAnims)

-- Hitbox
local hitboxModified = {}
local function resetHitbox(hrp)
    if not hrp or not hrp.Parent then return end
    hrp.Size = Vector3.new(2, 2, 1)
    hrp.Transparency = 1
    hrp.CanCollide = false
    hrp.Material = Enum.Material.Plastic
    hrp.Shape = Enum.PartType.Block
end
local function applyHitbox(plr)
    if plr == LocalPlayer then return end
    local char = plr.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum and (hum.Sit or hum.SeatPart) then
        if hitboxModified[hrp] then resetHitbox(hrp); hitboxModified[hrp] = nil end
        return
    end
    if SilentAimSettings.HitboxTeamCheck and LocalPlayer.Team and plr.Team == LocalPlayer.Team then
        if hitboxModified[hrp] then resetHitbox(hrp); hitboxModified[hrp] = nil end
        return
    end
    local size = SilentAimSettings.HitboxSize or 5
    hrp.Size = Vector3.new(size, size, size)
    hrp.Transparency = SilentAimSettings.HitboxTransparency or 0.5
    hrp.CanCollide = false
    hrp.Material = Enum.Material.ForceField
    hrp.Shape = (SilentAimSettings.HitboxShape == "Ball") and Enum.PartType.Ball or Enum.PartType.Block
    hitboxModified[hrp] = true
end
RunService.Heartbeat:Connect(function()
    if not SilentAimSettings.HitboxExpanderEnabled then
        for hrp in pairs(hitboxModified) do resetHitbox(hrp) end
        table.clear(hitboxModified)
        return
    end
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then applyHitbox(plr) end
    end
end)

-- Tracer beams
local tracerBeams = {}
local function removeTracerBeam(plr)
    local d = tracerBeams[plr]
    if not d then return end
    pcall(function() if d.Beam then d.Beam:Destroy() end end)
    pcall(function() if d.Start then d.Start:Destroy() end end)
    pcall(function() if d.End then d.End:Destroy() end end)
    tracerBeams[plr] = nil
end
local function updateTracerBeam(plr)
    local char = plr.Character
    local localHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local targetHRP = char and char:FindFirstChild("HumanoidRootPart")
    if not char or not localHRP or not targetHRP then removeTracerBeam(plr) return end
    local data = tracerBeams[plr]
    if not data then
        local a0 = Instance.new("Attachment"); a0.Parent = localHRP
        local a1 = Instance.new("Attachment"); a1.Parent = targetHRP
        local beam = Instance.new("Beam")
        beam.Attachment0 = a0; beam.Attachment1 = a1
        beam.FaceCamera = true; beam.Parent = targetHRP
        data = { Beam = beam, Start = a0, End = a1 }
        tracerBeams[plr] = data
    end
    local color = SilentAimSettings.TracerColor or Color3.fromRGB(255, 182, 193)
    if currentTarget and currentTarget.Parent == char then color = TARGET_LOCK_COLOR
    elseif plr.Team and plr.Team.TeamColor then color = plr.Team.TeamColor.Color end
    data.Beam.Color = ColorSequence.new(color)
    data.Beam.Width0 = SilentAimSettings.TracerThickness or 0.15
    data.Beam.Width1 = SilentAimSettings.TracerThickness or 0.15
    data.Beam.Enabled = true
end
RunService.Heartbeat:Connect(function()
    if not (SilentAimSettings.ESP_Enabled and SilentAimSettings.TracerESPEnabled) then
        for plr in pairs(tracerBeams) do removeTracerBeam(plr) end
        return
    end
    if SilentAimSettings.TracerTargetOnly then
        local tp = currentTarget and currentTarget.Parent and Players:GetPlayerFromCharacter(currentTarget.Parent)
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer then
                if plr == tp then updateTracerBeam(plr) else removeTracerBeam(plr) end
            end
        end
        return
    end
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local hum = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then updateTracerBeam(plr) else removeTracerBeam(plr) end
        end
    end
end)

-- Gun mod / firerate / auto fire
local ToolPropertiesFolder = nil
pcall(function()
    ToolPropertiesFolder = ReplicatedStorage:WaitForChild("SharedModules", 5):WaitForChild("ToolProperties", 5)
end)
local gunModNames = {"AK-47", "Remington 870", "M9", "M700", "M4A1", "FAL", "MP5", "Revolver"}
local function applyGunMod(tool)
    if not tool or not tool:IsA("Tool") or not table.find(gunModNames, tool.Name) then return end
    if not SilentAimSettings.GunModEnabled then return end
    tool:SetAttribute("AutoFire", SilentAimSettings.AutoFire == true)
    if SilentAimSettings.FastFirerateEnabled then
        local rate = SilentAimSettings.FireRateValue or 0.01
        tool:SetAttribute("FireRate", rate)
        if ToolPropertiesFolder then
            pcall(function()
                local mod = ToolPropertiesFolder:FindFirstChild(tool.Name)
                if mod then
                    local props = require(mod)
                    props.FireRate = rate
                    props.AutoFire = SilentAimSettings.AutoFire == true
                end
            end)
        end
    end
end
local function applyGunModToAllTools()
    local char = LocalPlayer.Character
    if char then for _, t in ipairs(char:GetChildren()) do if t:IsA("Tool") then applyGunMod(t) end end end
    local bp = LocalPlayer:FindFirstChild("Backpack")
    if bp then for _, t in ipairs(bp:GetChildren()) do if t:IsA("Tool") then applyGunMod(t) end end end
end
local function hookGunContainer(container)
    if not container then return end
    container.ChildAdded:Connect(function(c) if c:IsA("Tool") then task.defer(applyGunMod, c) end end)
end
hookGunContainer(LocalPlayer:FindFirstChild("Backpack"))
if LocalPlayer.Character then hookGunContainer(LocalPlayer.Character) end
LocalPlayer.CharacterAdded:Connect(function(char)
    hookGunContainer(char)
    task.defer(applyGunModToAllTools)
end)

-- Auto reload
RunService.Heartbeat:Connect(function()
    if not SilentAimSettings.AutoReloadEnabled then return end
    local char = LocalPlayer.Character
    if not char then return end
    for _, tool in ipairs(char:GetChildren()) do
        if tool:IsA("Tool") and table.find(gunModNames, tool.Name) then
            local ammo = tool:GetAttribute("CurrentAmmo") or tool:GetAttribute("Local_CurrentAmmo")
            if typeof(ammo) == "number" and ammo <= 0 then pcall(function() tool:Activate() end) end
        end
    end
end)

-- Get weapons
local gettingWeapon = false
local function getWeapon(ToolName)
    if gettingWeapon then return end
    gettingWeapon = true
    local Char = LocalPlayer.Character
    local Root = Char and Char:FindFirstChild("HumanoidRootPart")
    if not (Char and Root) then gettingWeapon = false return end
    if LocalPlayer.Backpack:FindFirstChild(ToolName) or Char:FindFirstChild(ToolName) then
        gettingWeapon = false return
    end
    local Giver
    for _, v in ipairs(workspace:GetDescendants()) do
        if v.Name == "TouchGiver" and v:GetAttribute("ToolName") == ToolName then
            Giver = v:FindFirstChildWhichIsA("BasePart"); break
        end
    end
    if not Giver then gettingWeapon = false; notify("No giver: " .. tostring(ToolName)); return end
    local orig = Giver.CFrame
    local under = orig - Vector3.new(0, 15.5, 0)
    Giver.CanTouch = true
    Giver.CFrame = under
    Root.Anchored = true
    Char:PivotTo(under + Vector3.new(0, 5, 0))
    task.wait(0.25)
    pcall(function() firetouchinterest(Giver, Root, 0) end)
    task.wait(0.3)
    pcall(function() firetouchinterest(Giver, Root, 1) end)
    if Giver.Parent then Giver.CFrame = orig end
    local got, t = false, 0
    while t < 4 do
        if LocalPlayer.Backpack:FindFirstChild(ToolName) or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(ToolName)) then
            got = true; break
        end
        task.wait(0.1); t = t + 0.1
    end
    Root.Anchored = false
    gettingWeapon = false
    notify(got and ("Got " .. ToolName) or ("Failed " .. ToolName))
end
getgenv().GetWeapons = function()
    task.spawn(function()
        for _, name in ipairs(SilentAimSettings.GetWeaponsList or {}) do
            getWeapon(name); task.wait(0.35)
        end
    end)
end
task.spawn(function()
    while task.wait(8) do
        if SilentAimSettings.AutoGetWeapons then pcall(getgenv().GetWeapons) end
    end
end)

-- Simple teleports
local function tpTo(cf)
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then hrp.CFrame = cf end
end
getgenv().SpentTeleports = {
    CriminalBase = function() tpTo(CFrame.new(-920, 95, 2138)) end,
    Yard = function() tpTo(CFrame.new(791, 98, 2490)) end,
    Cafeteria = function() tpTo(CFrame.new(918, 99, 2434)) end,
    Gate = function() tpTo(CFrame.new(763, 99, 2472)) end,
    Armory = function() tpTo(CFrame.new(835, 99, 2313)) end,
}

-- Kill effect / logs / sounds
local KillEffectGui = Instance.new("ScreenGui")
KillEffectGui.Name = "SpentKillFX"
KillEffectGui.ResetOnSpawn = false
KillEffectGui.IgnoreGuiInset = true
KillEffectGui.DisplayOrder = 999
KillEffectGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
local KillEffectFrame = Instance.new("Frame")
KillEffectFrame.Size = UDim2.fromScale(1, 1)
KillEffectFrame.BackgroundTransparency = 1
KillEffectFrame.BorderSizePixel = 0
KillEffectFrame.Parent = KillEffectGui
local killFxPlaying = false
local function playKillEffect()
    if not SilentAimSettings.KillEffectEnabled or killFxPlaying then return end
    killFxPlaying = true
    KillEffectFrame.BackgroundColor3 = SilentAimSettings.KillEffectColor or Color3.fromRGB(255, 182, 193)
    local d = SilentAimSettings.KillEffectFadeDuration or 0.25
    local a = TweenService:Create(KillEffectFrame, TweenInfo.new(d/2), { BackgroundTransparency = 0.45 })
    local b = TweenService:Create(KillEffectFrame, TweenInfo.new(d/2), { BackgroundTransparency = 1 })
    a:Play(); a.Completed:Wait(); b:Play(); b.Completed:Wait()
    killFxPlaying = false
end
local HitSounds = {
    ["TF2 Hit"] = 137392628136734, ["Neverlose"] = 82938206376993, ["Minecraft Hit 1"] = 135478009117226,
    ["MLG Hit"] = 109817519733426, ["Rust"] = 1255040462, ["Skeet"] = 5633695679, ["Fatality"] = 6534947869,
}
local KillSounds = {
    ["Fahhh"] = 93458245768554, ["Vine Boom"] = 140367458608473, ["CoD Kaboom"] = 7358219350,
    ["Laugh"] = 87825295777427, ["iPhone Ding"] = 120612883125769, ["Creepy Bell"] = 98025615996882,
}
local function playSoundId(id)
    if not id then return end
    local s = Instance.new("Sound")
    s.SoundId = "rbxassetid://" .. tostring(id)
    s.Volume = 1
    s.Parent = workspace.CurrentCamera
    s:Play()
    Debris:AddItem(s, 5)
end
local function playHitSound()
    if SilentAimSettings.CustomHitSoundEnabled then
        playSoundId(HitSounds[SilentAimSettings.HitSoundName])
    end
end
local function playKillSound()
    if SilentAimSettings.CustomKillSoundEnabled then
        playSoundId(KillSounds[SilentAimSettings.KillSoundName])
    end
end
local KillFeedFolder = ReplicatedStorage:FindFirstChild("Killfeed") or ReplicatedStorage:WaitForChild("Killfeed", 5)
if KillFeedFolder then
    KillFeedFolder.ChildAdded:Connect(function(entry)
        if not entry:IsA("IntValue") then return end
        local kd, ku, vd, w = entry.Name:match("^(.-)%s*%(@(.-)%)%s*killed%s+(.-)%s+with%s+(.+)$")
        if not kd then return end
        if SilentAimSettings.KillLogsEnabled then
            notify(kd .. " killed " .. tostring(vd) .. " with " .. tostring(w))
        end
        if ku == LocalPlayer.Name then
            task.spawn(playKillEffect)
            playKillSound()
        end
    end)
end

-- Weapon sound packs
local SoundPacks = {
    ["Silenced Shot"] = 9341262362, ["Bubble Shot"] = 109244508089412,
    ["Laser Shot"] = 109075387966089, ["Dart Gun"] = 5924183835, ["Neverlose"] = 82938206376993,
}
local function applySoundPackToTool(tool)
    if not tool or not tool:IsA("Tool") or not table.find(gunModNames, tool.Name) then return end
    local pack = SilentAimSettings.WeaponSoundPack
    if not pack or pack == "None" then return end
    local id = SoundPacks[pack]
    if not id then return end
    local h = tool:FindFirstChild("Handle")
    local ss = h and h:FindFirstChild("ShootSound")
    if ss then ss.SoundId = "rbxassetid://" .. id end
end
local function applySoundPackToAll()
    local char = LocalPlayer.Character
    if char then for _, t in ipairs(char:GetChildren()) do applySoundPackToTool(t) end end
    local bp = LocalPlayer:FindFirstChild("Backpack")
    if bp then for _, t in ipairs(bp:GetChildren()) do applySoundPackToTool(t) end end
end
LocalPlayer.CharacterAdded:Connect(function(char)
    char.ChildAdded:Connect(function(c) if c:IsA("Tool") then task.defer(applySoundPackToTool, c) end end)
    task.defer(applySoundPackToAll)
end)

-- Skybox / fog / gradient
local Skyboxes = {
    None = nil,
    Nebula = {
        SkyboxBk = "rbxassetid://159454299", SkyboxDn = "rbxassetid://159454296",
        SkyboxFt = "rbxassetid://159454293", SkyboxLf = "rbxassetid://159454286",
        SkyboxRt = "rbxassetid://159454300", SkyboxUp = "rbxassetid://159454288",
    },
}
local currentSky = nil
local function applySkybox()
    if currentSky then pcall(function() currentSky:Destroy() end) currentSky = nil end
    if not SilentAimSettings.CustomSkybox then return end
    local data = Skyboxes[SilentAimSettings.SkyboxName]
    if not data then return end
    local sky = Instance.new("Sky")
    for k, v in pairs(data) do sky[k] = v end
    sky.Parent = Lighting
    currentSky = sky
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

-- Hotkey system
SilentAimSettings.Hotkeys = SilentAimSettings.Hotkeys or {}
local hotkeyActions = {}
local function registerHotkeyAction(id, fn)
    hotkeyActions[id] = fn
end
UserInputService.InputBegan:Connect(function(input, processed)
    if processed or input.UserInputType ~= Enum.UserInputType.Keyboard then return end
    local name = input.KeyCode.Name
    for id, keyName in pairs(SilentAimSettings.Hotkeys) do
        if keyName and keyName ~= "" and keyName ~= "None" and keyName == name then
            local fn = hotkeyActions[id]
            if fn then pcall(fn) end
        end
    end
end)

getgenv().SilentAimSettings = SilentAimSettings

-- ===================== SPENT HUB UI =====================
local HUB_ICON_ASSET_ID = 99267227598729

local function computeWindowSize()
    local cam = workspace.CurrentCamera
    local vp = (cam and cam.ViewportSize) or Vector2.new(1280, 720)
    local mobile = (UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled) or vp.X < 700
    local maxW = math.floor(vp.X * (mobile and 0.96 or 0.72))
    local maxH = math.floor(vp.Y * (mobile and 0.82 or 0.78))
    local prefW = mobile and 520 or 720
    local prefH = mobile and 420 or 620
    return math.clamp(prefW, 360, math.max(360, maxW)), math.clamp(prefH, 320, math.max(320, maxH)), mobile
end

local function loadUI()
    local repo = "https://raw.githubusercontent.com/majeskooooo/Obsidian/main/"
    local ok, Lib = pcall(function()
        return loadstring(game:HttpGet(repo .. "Library.lua"))()
    end)
    if not ok or not Lib then
        warn("[SPENT HUB] UI library load failed")
        return nil
    end
    Library = Lib
    getgenv().Library = Library
    pcall(function() loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))() end)
    pcall(function() loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))() end)

    Library.Scheme.AccentColor = Color3.fromRGB(255, 182, 193)
    Library.Scheme.BackgroundColor = Color3.fromRGB(10, 13, 18)
    Library.Scheme.MainColor = Color3.fromRGB(18, 22, 30)
    Library.Scheme.OutlineColor = Color3.fromRGB(28, 34, 44)

    local winW, winH = computeWindowSize()
    local Window = Library:CreateWindow({
        Title = "SPENT HUB",
        Footer = "SPENT HUB",
        FooterLeft = "V1",
        FooterRight = "made by spent",
        Icon = HUB_ICON_ASSET_ID,
        NotifySide = "Right",
        ShowCustomCursor = false,
        Size = UDim2.fromOffset(winW, winH),
        Center = true,
        Resizable = true,
        SidebarCompacted = true,
        ShowMobileButtons = true,
        CornerRadius = 11,
        Font = Enum.Font.Gotham,
        ToggleKeybind = Enum.KeyCode.RightShift,
    })

    -- Force 11% corner radius across all UI corners after library builds window
    task.defer(function()
        pcall(function()
            Library.CornerRadius = 11
            local sg = Library.ScreenGui
            if not sg then return end
            for _, d in ipairs(sg:GetDescendants()) do
                if d:IsA("UICorner") then
                    -- Only apply to frames that are not pill/circular shapes
                    local parent = d.Parent
                    local isCircle = false
                    if parent and parent:IsA("GuiObject") then
                        local sX = parent.AbsoluteSize.X
                        local sY = parent.AbsoluteSize.Y
                        -- detect if it's being used as a perfect circle (toggle pill, dot etc)
                        if math.abs(sX - sY) < 4 and sX < 32 then isCircle = true end
                    end
                    if not isCircle then
                        d.CornerRadius = UDim.new(0.11, 0)
                    end
                end
            end
        end)
        pcall(function()
            if Library.Corners then
                for _, c in ipairs(Library.Corners) do
                    if c and c:IsA("UICorner") then
                        c.CornerRadius = UDim.new(0.11, 0)
                    end
                end
            end
        end)
    end)

    task.defer(function()
        pcall(function()
            local sg = Library.ScreenGui
            if not sg then return end
            for _, d in ipairs(sg:GetDescendants()) do
                if not d:IsA("TextLabel") then continue end
                local txt = d.Text
                if txt == "SPENT HUB" or txt == "SPENT HUB " then
                    d.Font = Enum.Font.GothamBold
                    d.Text = "SPENT HUB"
                elseif txt == "V1" then
                    d.Font = Enum.Font.GothamMedium
                elseif txt == "made by spent" then
                    d.Font = Enum.Font.Gotham
                end
            end
        end)
    end)

    if workspace.CurrentCamera then
        workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
            task.defer(function()
                local w, h = computeWindowSize()
                local c = Library.WindowContainer
                if c and c:IsA("GuiObject") then
                    local mw = math.floor(workspace.CurrentCamera.ViewportSize.X * 0.96)
                    local mh = math.floor(workspace.CurrentCamera.ViewportSize.Y * 0.82)
                    if c.AbsoluteSize.X > mw or c.AbsoluteSize.Y > mh then
                        pcall(function() c.Size = UDim2.fromOffset(math.min(c.AbsoluteSize.X, mw), math.min(c.AbsoluteSize.Y, mh)) end)
                    end
                end
            end)
        end)
    end

    local function setAccent(c)
        if typeof(c) ~= "Color3" then return end
        Library.Scheme.AccentColor = c
        Library.Scheme.OutlineColor = Color3.new(
            math.clamp(c.R * 0.25 + 0.08, 0, 1),
            math.clamp(c.G * 0.25 + 0.08, 0, 1),
            math.clamp(c.B * 0.25 + 0.08, 0, 1)
        )
        pcall(function() if Theme then Theme.ACCENT = c end end)
        pcall(function() if mouse_box then mouse_box.Color = c end end)
        SilentAimSettings.ESP_HighlightColor = c
        SilentAimSettings.TracerColor = c
        SilentAimSettings.KillEffectColor = c
        pcall(function()
            if Library.UpdateColorsUsingRegistry then Library:UpdateColorsUsingRegistry() end
        end)
        pcall(function()
            local sg = Library.ScreenGui
            if not sg then return end
            for _, d in ipairs(sg:GetDescendants()) do
                if d:IsA("UIStroke") then
                    local col = d.Color
                    local lum = col.R * 0.3 + col.G * 0.5 + col.B * 0.2
                    if lum > 0.15 then d.Color = c end
                end
            end
        end)
    end

    local function addToggle(group, idx, text, default, onChange)
        return group:AddToggle(idx, {
            Text = text,
            Default = default == true,
            Callback = function(v) onChange(v == true) end,
        })
    end

    local function addToggleHK(group, idx, text, default, onChange, hotkeyId)
        local tog = addToggle(group, idx, text, default, onChange)
        if tog and tog.AddKeyPicker and hotkeyId then
            SilentAimSettings.Hotkeys[hotkeyId] = SilentAimSettings.Hotkeys[hotkeyId] or "None"
            tog:AddKeyPicker(idx .. "_HK", {
                Text = "Key",
                Default = "None",
                Mode = "Toggle",
                SyncToggleState = false,
                ChangedCallback = function(key)
                    local name = typeof(key) == "EnumItem" and key.Name or tostring(key or "None")
                    if name == "" or name == "nil" then name = "None" end
                    SilentAimSettings.Hotkeys[hotkeyId] = name
                end,
            })
            registerHotkeyAction(hotkeyId, function()
                local t = Library and Library.Toggles and Library.Toggles[idx]
                if t and t.SetValue then
                    t:SetValue(not t.Value)
                end
            end)
        end
        return tog
    end

    local function listHas(list, name)
        if typeof(list) ~= "table" then return false end
        for _, v in ipairs(list) do if v == name then return true end end
        return false
    end
    local function listAdd(list, name)
        if not listHas(list, name) then table.insert(list, name) end
    end
    local function listRemove(list, name)
        for i = #list, 1, -1 do if list[i] == name then table.remove(list, i) end end
    end
    local function addMultiList(group, prefix, items, listRef)
        group:AddLabel("— scroll list —")
        for i, name in ipairs(items) do
            local idx = prefix .. "_" .. i
            addToggle(group, idx, name, listHas(listRef, name), function(v)
                if v then listAdd(listRef, name) else listRemove(listRef, name) end
            end)
        end
    end
    local function addExclusiveList(group, prefix, items, getValue, setValue)
        group:AddLabel("— scroll list (one at a time) —")
        local ids = {}
        local lock = false
        for i, name in ipairs(items) do
            local idx = prefix .. "_" .. i
            ids[name] = idx
            addToggle(group, idx, name, getValue() == name, function(v)
                if lock then return end
                if v then
                    lock = true
                    setValue(name)
                    for otherName, otherIdx in pairs(ids) do
                        if otherName ~= name then
                            local t = Library.Toggles and Library.Toggles[otherIdx]
                            if t and t.SetValue then
                                pcall(function() t:SetValue(false) end)
                            end
                        end
                    end
                    lock = false
                else
                    if getValue() == name then
                        lock = true
                        local t = Library.Toggles and Library.Toggles[idx]
                        if t and t.SetValue then
                            pcall(function() t:SetValue(true) end)
                        end
                        lock = false
                    end
                end
            end)
        end
    end

    local Tabs = {
        Info = Window:AddTab("Info", "info"),
        Main = Window:AddTab("Main", "crosshair"),
        Player = Window:AddTab("Player", "user"),
        Visuals = Window:AddTab("Visuals", "eye"),
        World = Window:AddTab("World", "globe"),
        Settings = Window:AddTab("Settings", "settings"),
    }
    local Toggles = Library.Toggles

    -- INFO PAGE
    local scriptStartTime = tick()
    local function getGreeting()
        local hour = tonumber(os.date("%H"))
        if hour < 5 then return "Still up?"
        elseif hour < 12 then return "Good Morning"
        elseif hour < 17 then return "Good Afternoon"
        elseif hour < 21 then return "Good Evening"
        else return "Good Night" end
    end
    local function formatUptime(seconds)
        seconds = math.max(0, math.floor(seconds))
        local h = math.floor(seconds / 3600)
        local m = math.floor((seconds % 3600) / 60)
        local s = seconds % 60
        if h > 0 then return string.format("%dh %02dm %02ds", h, m, s) end
        return string.format("%02dm %02ds", m, s)
    end
    local function deviceName()
        if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then return "Mobile" end
        if UserInputService.GamepadEnabled and not UserInputService.KeyboardEnabled then return "Console" end
        return "PC"
    end
    local function executorName()
        local n = "Unknown"
        pcall(function()
            if identifyexecutor then n = tostring(select(1, identifyexecutor())) end
        end)
        return n
    end

    task.defer(function()
        local parent = nil
        pcall(function()
            if Tabs.Info and Tabs.Info.Sides and Tabs.Info.Sides[1] then
                parent = Tabs.Info.Sides[1].Parent
            end
        end)
        if not parent then
            pcall(function()
                local sg = Library.ScreenGui
                if not sg then return end
                for _, d in ipairs(sg:GetDescendants()) do
                    if d:IsA("Frame") and (d.Name == "Info" or d.Name:lower():find("content")) then
                        parent = d
                        break
                    end
                end
            end)
        end
        if not parent then parent = Library.ScreenGui end
        if not parent then return end

        pcall(function()
            for _, name in ipairs({ "SpentInfoDash", "SpentProfileCard" }) do
                local old = parent:FindFirstChild(name, true)
                if old then old:Destroy() end
            end
            if Library.ScreenGui then
                for _, d in ipairs(Library.ScreenGui:GetDescendants()) do
                    if d.Name == "SpentProfileCard" or d.Name == "SpentInfoDash" then
                        d:Destroy()
                    end
                end
            end
        end)
        pcall(function()
            if Tabs.Info and Tabs.Info.Sides then
                for _, side in pairs(Tabs.Info.Sides) do
                    if typeof(side) == "Instance" then
                        side.Visible = false
                    elseif type(side) == "table" and side.Holder then
                        pcall(function() side.Holder.Visible = false end)
                    elseif type(side) == "table" and side.Frame then
                        pcall(function() side.Frame.Visible = false end)
                    end
                end
            end
        end)

        local ACC = Library.Scheme.AccentColor or Color3.fromRGB(255, 182, 193)
        local BG = Library.Scheme.BackgroundColor or Color3.fromRGB(10, 13, 18)
        local MAIN = Library.Scheme.MainColor or Color3.fromRGB(18, 22, 30)

        local dash = Instance.new("ScrollingFrame")
        dash.Name = "SpentInfoDash"
        dash.BackgroundTransparency = 1
        dash.BorderSizePixel = 0
        dash.Size = UDim2.new(1, -8, 1, -8)
        dash.Position = UDim2.fromOffset(4, 4)
        dash.ScrollBarThickness = 3
        dash.ScrollBarImageColor3 = ACC
        dash.CanvasSize = UDim2.fromOffset(0, 560)
        dash.ZIndex = 200
        dash.BackgroundTransparency = 1
        dash.Parent = parent

        local lay = Instance.new("UIListLayout")
        lay.Padding = UDim.new(0, 10)
        lay.SortOrder = Enum.SortOrder.LayoutOrder
        lay.Parent = dash
        local pad = Instance.new("UIPadding")
        pad.PaddingTop = UDim.new(0, 4)
        pad.PaddingLeft = UDim.new(0, 4)
        pad.PaddingRight = UDim.new(0, 4)
        pad.PaddingBottom = UDim.new(0, 12)
        pad.Parent = dash

        local function card(height, order)
            local f = Instance.new("Frame")
            f.BackgroundColor3 = MAIN
            f.BorderSizePixel = 0
            f.Size = UDim2.new(1, 0, 0, height)
            f.LayoutOrder = order
            f.ZIndex = 41
            f.Parent = dash
            local c = Instance.new("UICorner")
            c.CornerRadius = UDim.new(0.11, 0)
            c.Parent = f
            local s = Instance.new("UIStroke")
            s.Color = Color3.fromRGB(40, 44, 56)
            s.Thickness = 1
            s.Transparency = 0.25
            s.Parent = f
            return f
        end

        local function label(parent, props)
            local t = Instance.new("TextLabel")
            t.BackgroundTransparency = 1
            t.BorderSizePixel = 0
            t.Font = props.font or Enum.Font.Gotham
            t.TextSize = props.size or 13
            t.TextColor3 = props.color or Color3.fromRGB(220, 220, 230)
            t.TextXAlignment = props.align or Enum.TextXAlignment.Left
            t.TextYAlignment = props.valign or Enum.TextYAlignment.Center
            t.Text = props.text or ""
            t.Position = props.pos or UDim2.fromOffset(0, 0)
            t.Size = props.sizeU or UDim2.new(1, 0, 0, 18)
            t.ZIndex = (props.z or 42)
            t.TextTruncate = Enum.TextTruncate.AtEnd
            t.Parent = parent
            return t
        end

        local hero = card(128, 1)
        local bar = Instance.new("Frame")
        bar.BorderSizePixel = 0
        bar.Size = UDim2.new(1, 0, 0, 3)
        bar.Position = UDim2.fromOffset(0, 0)
        bar.BackgroundColor3 = ACC
        bar.ZIndex = 42
        bar.Parent = hero
        local barGrad = Instance.new("UIGradient")
        barGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, ACC),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)),
        })
        barGrad.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(1, 0.65),
        })
        barGrad.Parent = bar

        local head = Instance.new("ImageLabel")
        head.Name = "Headshot"
        head.BackgroundColor3 = Color3.fromRGB(22, 24, 32)
        head.Size = UDim2.fromOffset(88, 88)
        head.Position = UDim2.fromOffset(16, 20)
        head.BorderSizePixel = 0
        head.Image = ""
        head.ZIndex = 43
        head.Parent = hero
        local hc = Instance.new("UICorner")
        hc.CornerRadius = UDim.new(1, 0)
        hc.Parent = head
        local hs = Instance.new("UIStroke")
        hs.Color = ACC
        hs.Thickness = 2
        hs.Transparency = 0.2
        hs.Parent = head
        local dot = Instance.new("Frame")
        dot.Size = UDim2.fromOffset(14, 14)
        dot.Position = UDim2.new(1, -16, 1, -16)
        dot.BackgroundColor3 = Color3.fromRGB(80, 220, 120)
        dot.BorderSizePixel = 0
        dot.ZIndex = 44
        dot.Parent = head
        local dc = Instance.new("UICorner")
        dc.CornerRadius = UDim.new(1, 0)
        dc.Parent = dot

        local greet = label(hero, {
            text = getGreeting(),
            size = 12,
            color = ACC,
            font = Enum.Font.GothamMedium,
            pos = UDim2.fromOffset(120, 22),
            sizeU = UDim2.new(1, -140, 0, 16),
            z = 43,
        })
        local display = label(hero, {
            text = LocalPlayer.DisplayName or LocalPlayer.Name,
            size = 20,
            color = Color3.fromRGB(245, 245, 250),
            font = Enum.Font.GothamBold,
            pos = UDim2.fromOffset(120, 40),
            sizeU = UDim2.new(1, -140, 0, 24),
            z = 43,
        })
        local uname = label(hero, {
            text = "@" .. LocalPlayer.Name .. "  ·  " .. tostring(LocalPlayer.UserId),
            size = 13,
            color = Color3.fromRGB(150, 154, 170),
            pos = UDim2.fromOffset(120, 66),
            sizeU = UDim2.new(1, -140, 0, 18),
            z = 43,
        })
        local brand = label(hero, {
            text = "SPENT HUB  ·  made by spent",
            size = 12,
            color = ACC,
            font = Enum.Font.GothamMedium,
            pos = UDim2.fromOffset(120, 90),
            sizeU = UDim2.new(1, -140, 0, 18),
            z = 43,
        })

        task.spawn(function()
            local ok, content = pcall(function()
                return Players:GetUserThumbnailAsync(
                    LocalPlayer.UserId,
                    Enum.ThumbnailType.HeadShot,
                    Enum.ThumbnailSize.Size420x420
                )
            end)
            if ok and content and content ~= "" then
                head.Image = content
            else
                head.Image = string.format(
                    "https://www.roblox.com/headshot-thumbnail/image?userId=%d&width=420&height=420&format=png",
                    LocalPlayer.UserId
                )
                pcall(function()
                    head.Image = "rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&w=420&h=420"
                end)
            end
        end)

        local stats = card(92, 2)
        local function statCell(xScale, title, valueName)
            local cell = Instance.new("Frame")
            cell.BackgroundColor3 = Color3.fromRGB(14, 16, 22)
            cell.BorderSizePixel = 0
            cell.Size = UDim2.new(0.32, 0, 1, -20)
            cell.Position = UDim2.new(xScale, 6, 0, 10)
            cell.ZIndex = 42
            cell.Parent = stats
            local cc = Instance.new("UICorner")
            cc.CornerRadius = UDim.new(0.11, 0)
            cc.Parent = cell
            label(cell, {
                text = title,
                size = 11,
                color = Color3.fromRGB(130, 134, 150),
                font = Enum.Font.GothamMedium,
                pos = UDim2.fromOffset(10, 10),
                sizeU = UDim2.new(1, -16, 0, 14),
                z = 43,
            })
            local val = label(cell, {
                text = "—",
                size = 16,
                color = Color3.fromRGB(240, 240, 248),
                font = Enum.Font.GothamBold,
                pos = UDim2.fromOffset(10, 32),
                sizeU = UDim2.new(1, -16, 0, 28),
                z = 43,
            })
            val.Name = valueName
            return val
        end
        local uptimeVal = statCell(0, "UPTIME", "UptimeVal")
        local pingVal = statCell(0.33, "PING", "PingVal")
        local timeVal = statCell(0.66, "LOCAL TIME", "TimeVal")

        local session = card(170, 3)
        label(session, {
            text = "SESSION",
            size = 11,
            color = ACC,
            font = Enum.Font.GothamBold,
            pos = UDim2.fromOffset(16, 12),
            sizeU = UDim2.new(1, -32, 0, 14),
            z = 43,
        })
        local sessionLines = {
            { "Device", deviceName() },
            { "Executor", executorName() },
            { "PlaceId", tostring(game.PlaceId) },
            { "JobId", (tostring(game.JobId or ""):sub(1, 22)) },
            { "Region", "…" },
        }
        local sessionLabels = {}
        for i, row in ipairs(sessionLines) do
            local y = 32 + (i - 1) * 24
            label(session, {
                text = row[1],
                size = 12,
                color = Color3.fromRGB(120, 124, 140),
                pos = UDim2.fromOffset(16, y),
                sizeU = UDim2.new(0.35, 0, 0, 18),
                z = 43,
            })
            local v = label(session, {
                text = row[2],
                size = 12,
                color = Color3.fromRGB(230, 230, 240),
                font = Enum.Font.GothamMedium,
                pos = UDim2.fromOffset(120, y),
                sizeU = UDim2.new(1, -136, 0, 18),
                z = 43,
            })
            sessionLabels[row[1]] = v
        end
        task.spawn(function()
            local ok, region = pcall(function()
                return game:GetService("LocalizationService"):GetCountryRegionForPlayerAsync(LocalPlayer)
            end)
            if sessionLabels.Region then
                sessionLabels.Region.Text = tostring(ok and region or "—")
            end
        end)

        local controls = card(120, 4)
        label(controls, {
            text = "CONTROLS",
            size = 11,
            color = ACC,
            font = Enum.Font.GothamBold,
            pos = UDim2.fromOffset(16, 12),
            sizeU = UDim2.new(1, -32, 0, 14),
            z = 43,
        })
        local controlRows = {
            { "RightShift", "Toggle menu" },
            { "End", "Unload hub" },
            { "F (PC)", "Noclip punch" },
            { "Toggle keys", "Blank until you bind" },
        }
        for i, row in ipairs(controlRows) do
            local y = 32 + (i - 1) * 20
            label(controls, {
                text = row[1],
                size = 12,
                color = Color3.fromRGB(230, 230, 240),
                font = Enum.Font.GothamMedium,
                pos = UDim2.fromOffset(16, y),
                sizeU = UDim2.new(0.4, 0, 0, 16),
                z = 43,
            })
            label(controls, {
                text = row[2],
                size = 12,
                color = Color3.fromRGB(130, 134, 150),
                pos = UDim2.fromOffset(140, y),
                sizeU = UDim2.new(1, -156, 0, 16),
                z = 43,
            })
        end

        local about = card(88, 5)
        label(about, {
            text = "ABOUT",
            size = 11,
            color = ACC,
            font = Enum.Font.GothamBold,
            pos = UDim2.fromOffset(16, 12),
            sizeU = UDim2.new(1, -32, 0, 14),
            z = 43,
        })
        label(about, {
            text = "Silent aim, ESP, and visuals run on Spent logic.\nUI shell is Obsidian. Brand is SPENT HUB only.",
            size = 12,
            color = Color3.fromRGB(160, 164, 180),
            pos = UDim2.fromOffset(16, 34),
            sizeU = UDim2.new(1, -32, 0, 42),
            z = 43,
            valign = Enum.TextYAlignment.Top,
        }).TextWrapped = true

        task.spawn(function()
            while dash.Parent do
                local okStats, statsPing = pcall(function()
                    return game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
                end)
                pcall(function()
                    uptimeVal.Text = formatUptime(tick() - scriptStartTime)
                    timeVal.Text = os.date("%H:%M:%S")
                    if okStats and statsPing then
                        pingVal.Text = tostring(statsPing)
                    else
                        local p = LocalPlayer:GetNetworkPing()
                        pingVal.Text = string.format("%.0f ms", (p or 0) * 1000)
                    end
                end)
                task.wait(0.5)
            end
        end)

        pcall(function()
            if not Tabs.Info then return end
            for _, side in pairs(Tabs.Info.Sides or {}) do
                local inst = side
                if type(side) == "table" then
                    inst = side.Holder or side.Frame or side.Container or side.Root
                end
                if typeof(inst) == "Instance" then
                    inst.Visible = false
                    for _, ch in ipairs(inst:GetDescendants()) do
                        if ch:IsA("GuiObject") then
                            ch.Visible = false
                        end
                    end
                end
            end
        end)
    end)

    -- MAIN tab
    local aim = Tabs.Main:AddLeftGroupbox("Silent Aim")
    addToggleHK(aim, "SA_Enabled", "Silent Aim", SilentAimSettings.Enabled, function(v)
        SilentAimSettings.Enabled = v
        notify("Silent Aim " .. (v and "on" or "off"))
    end, "SilentAim")
    aim:AddDropdown("SA_Part", {
        Text = "Target Part",
        Values = { "Head", "HumanoidRootPart", "Random" },
        Default = SilentAimSettings.TargetPart,
        Callback = function(v) if typeof(v) == "string" then SilentAimSettings.TargetPart = v end end,
    })
    aim:AddDropdown("SA_Method", {
        Text = "Method",
        Values = { "Raycast", "FindPartOnRay", "FindPartOnRayWithWhitelist", "FindPartOnRayWithIgnoreList", "Mouse.Hit/Target" },
        Default = SilentAimSettings.SilentAimMethod,
        Callback = function(v) if typeof(v) == "string" then SilentAimSettings.SilentAimMethod = v end end,
    })
    aim:AddDropdown("SA_TargetMode", {
        Text = "Target Mode",
        Values = { "Manual", "Hostile", "Trespassing" },
        Default = SilentAimSettings.TargetingMode or "Manual",
        Callback = function(v) if typeof(v) == "string" then SilentAimSettings.TargetingMode = v end end,
    })
    aim:AddSlider("SA_Hit", {
        Text = "Hit Chance", Default = SilentAimSettings.HitChance, Min = 0, Max = 100, Rounding = 0,
        Callback = function(v) SilentAimSettings.HitChance = v end,
    })
    addToggle(aim, "SA_FF", "Forcefield Check", SilentAimSettings.ForcefieldCheck, function(v) SilentAimSettings.ForcefieldCheck = v end)
    addToggleHK(aim, "SA_Auto", "Autoshoot", SilentAimSettings.AutoshootEnabled, function(v) SilentAimSettings.AutoshootEnabled = v end, "Autoshoot")
    aim:AddLabel("Noclip Punch — F (PC only)")

    local filters = Tabs.Main:AddRightGroupbox("Filters / FOV")
    addToggle(filters, "SA_Team", "Team Check", SilentAimSettings.TeamCheck, function(v) SilentAimSettings.TeamCheck = v end)
    addToggle(filters, "SA_Vis", "Visible Check", SilentAimSettings.VisibleCheck, function(v) SilentAimSettings.VisibleCheck = v end)
    addToggle(filters, "SA_Cop", "Target Cop", SilentAimSettings.TargetCop, function(v) SilentAimSettings.TargetCop = v end)
    addToggle(filters, "SA_Inm", "Target Inmate", SilentAimSettings.TargetInmate, function(v) SilentAimSettings.TargetInmate = v end)
    addToggle(filters, "SA_Cri", "Target Criminal", SilentAimSettings.TargetCriminal, function(v) SilentAimSettings.TargetCriminal = v end)
    addToggle(filters, "FOV_On", "FOV Circle", SilentAimSettings.FOVVisible, function(v) SilentAimSettings.FOVVisible = v end)
    addToggle(filters, "FOV_Ctr", "Center FOV", SilentAimSettings.FOVCenter, function(v) SilentAimSettings.FOVCenter = v end)
    filters:AddSlider("FOV_Sz", {
        Text = "FOV Radius", Default = SilentAimSettings.FOVRadius, Min = 0, Max = 400, Rounding = 0,
        Callback = function(v) SilentAimSettings.FOVRadius = v end,
    })

    local fs = Tabs.Main:AddLeftGroupbox("Fast Switch")
    addToggleHK(fs, "FS_On", "Fast Switch", SilentAimSettings.FastSwitchEnabled, function(v)
        SilentAimSettings.FastSwitchEnabled = v
        if v then startFastSwitch() else stopFastSwitch() end
    end, "FastSwitch")
    fs:AddSlider("FS_Delay", {
        Text = "Switch Speed x100",
        Default = math.floor(SilentAimSettings.FastSwitchDelay * 100),
        Min = 1, Max = 50, Rounding = 0,
        Callback = function(v) SilentAimSettings.FastSwitchDelay = v / 100 end,
    })
    fs:AddLabel("Guns to Cycle")
    if typeof(SilentAimSettings.FastSwitchList) ~= "table" then
        SilentAimSettings.FastSwitchList = { "M9", "Revolver", "Remington 870", "MP5", "M4A1", "M700", "AK-47" }
    end
    addMultiList(fs, "FS_Gun", { "M9", "Revolver", "Remington 870", "MP5", "M4A1", "M700", "AK-47" }, SilentAimSettings.FastSwitchList)

    local gun = Tabs.Main:AddRightGroupbox("Gun Mods")
    addToggle(gun, "GM_On", "Gun Mod", SilentAimSettings.GunModEnabled, function(v)
        SilentAimSettings.GunModEnabled = v; applyGunModToAllTools()
    end)
    addToggle(gun, "GM_AF", "Auto Fire", SilentAimSettings.AutoFire, function(v)
        SilentAimSettings.AutoFire = v; applyGunModToAllTools()
    end)
    addToggle(gun, "GM_FF", "Fast Firerate", SilentAimSettings.FastFirerateEnabled, function(v)
        SilentAimSettings.FastFirerateEnabled = v; applyGunModToAllTools()
    end)
    gun:AddSlider("GM_Rate", {
        Text = "Firerate x1000",
        Default = math.floor((SilentAimSettings.FireRateValue or 0.01) * 1000),
        Min = 1, Max = 100, Rounding = 0,
        Callback = function(v) SilentAimSettings.FireRateValue = v / 1000; applyGunModToAllTools() end,
    })
    addToggle(gun, "GM_AR", "Auto Reload", SilentAimSettings.AutoReloadEnabled, function(v)
        SilentAimSettings.AutoReloadEnabled = v
    end)
    gun:AddLabel("Weapon Sound Pack")
    addExclusiveList(gun, "GM_Pack", { "None", "Silenced Shot", "Bubble Shot", "Laser Shot", "Dart Gun", "Neverlose" },
        function() return SilentAimSettings.WeaponSoundPack or "None" end,
        function(v) SilentAimSettings.WeaponSoundPack = v; applySoundPackToAll() end)

    -- PLAYER tab
    local pl = Tabs.Player:AddLeftGroupbox("Character")
    addToggleHK(pl, "PL_Noclip", "Noclip", SilentAimSettings.NoclipEnabled, function(v)
        SilentAimSettings.NoclipEnabled = v
        if v then startNoclip() else stopNoclip() end
    end, "Noclip")
    addToggleHK(pl, "PL_Invis", "Invisible", SilentAimSettings.InvisibleEnabled, function(v)
        SilentAimSettings.InvisibleEnabled = v
        if v then startInvisible() else stopInvisible() end
    end, "Invisible")
    addToggle(pl, "PL_Kor", "Korblox", SilentAimSettings.KorbloxEnabled, function(v)
        SilentAimSettings.KorbloxEnabled = v
        local c = LocalPlayer.Character
        if v and c then applyKorblox(c) end
    end)
    addToggle(pl, "PL_Head", "Headless", SilentAimSettings.HeadlessEnabled, function(v)
        SilentAimSettings.HeadlessEnabled = v
        local c = LocalPlayer.Character
        if v and c then applyHeadless(c) end
    end)
    addToggle(pl, "PL_Jump", "Infinite Jump", SilentAimSettings.InfiniteJumpEnabled, function(v)
        SilentAimSettings.InfiniteJumpEnabled = v
    end)
    addToggle(pl, "PL_Stam", "Infinite Stamina", SilentAimSettings.InfiniteStamina, function(v)
        SilentAimSettings.InfiniteStamina = v
    end)
    addToggle(pl, "PL_AntiInv", "Anti-Invisible", SilentAimSettings.AntiInvisibleEnabled, function(v)
        SilentAimSettings.AntiInvisibleEnabled = v
    end)
    addToggle(pl, "PL_Cam", "Custom Camera FOV", SilentAimSettings.CameraFOVEnabled, function(v)
        SilentAimSettings.CameraFOVEnabled = v
    end)
    pl:AddSlider("PL_CamV", {
        Text = "Camera FOV", Default = 70, Min = 50, Max = 120, Rounding = 0,
        Callback = function(v) SilentAimSettings.CameraFOV = v end,
    })
    pl:AddSlider("PL_Spin", {
        Text = "Spinbot Speed", Default = 0, Min = 0, Max = 50, Rounding = 0,
        Callback = function(v) SilentAimSettings.SpinbotSpeed = v end,
    })

    local hb = Tabs.Player:AddRightGroupbox("Hitbox")
    addToggle(hb, "HB_On", "Hitbox Expander", SilentAimSettings.HitboxExpanderEnabled, function(v)
        SilentAimSettings.HitboxExpanderEnabled = v
    end)
    addToggle(hb, "HB_Team", "Hitbox Team Check", SilentAimSettings.HitboxTeamCheck, function(v)
        SilentAimSettings.HitboxTeamCheck = v
    end)
    hb:AddSlider("HB_Size", {
        Text = "Hitbox Size", Default = 5, Min = 1, Max = 25, Rounding = 1,
        Callback = function(v) SilentAimSettings.HitboxSize = v end,
    })
    hb:AddSlider("HB_Tr", {
        Text = "Transparency x100", Default = 50, Min = 0, Max = 100, Rounding = 0,
        Callback = function(v) SilentAimSettings.HitboxTransparency = v / 100 end,
    })
    hb:AddDropdown("HB_Sh", {
        Text = "Shape",
        Values = { "Box", "Ball" },
        Default = SilentAimSettings.HitboxShape or "Box",
        Callback = function(v) if typeof(v) == "string" then SilentAimSettings.HitboxShape = v end end,
    })

    local we = Tabs.Player:AddLeftGroupbox("Weapons / TP")
    we:AddLabel("Weapons to Get")
    if typeof(SilentAimSettings.GetWeaponsList) ~= "table" then
        SilentAimSettings.GetWeaponsList = { "M9", "AK-47", "M4A1", "Remington 870", "M700", "MP5", "Revolver" }
    end
    addMultiList(we, "GetW", { "M9", "Revolver", "AK-47", "M4A1", "MP5", "Remington 870", "M700", "FAL", "Taser" }, SilentAimSettings.GetWeaponsList)
    we:AddButton({ Text = "Get Weapons", Func = function() if getgenv().GetWeapons then getgenv().GetWeapons() end end })
    addToggle(we, "AutoGet", "Auto Get Weapons", SilentAimSettings.AutoGetWeapons, function(v)
        SilentAimSettings.AutoGetWeapons = v
    end)
    we:AddButton({ Text = "TP Criminal Base", Func = function() getgenv().SpentTeleports.CriminalBase() end })
    we:AddButton({ Text = "TP Yard", Func = function() getgenv().SpentTeleports.Yard() end })
    we:AddButton({ Text = "TP Cafeteria", Func = function() getgenv().SpentTeleports.Cafeteria() end })
    we:AddButton({ Text = "TP Gate", Func = function() getgenv().SpentTeleports.Gate() end })
    we:AddButton({ Text = "TP Armory", Func = function() getgenv().SpentTeleports.Armory() end })

    -- VISUALS tab
    local esp = Tabs.Visuals:AddLeftGroupbox("ESP")
    addToggleHK(esp, "ESP_On", "Enable ESP", SilentAimSettings.ESP_Enabled, function(v) SilentAimSettings.ESP_Enabled = v end, "ESP")
    addToggle(esp, "ESP_Team", "Team Colors", SilentAimSettings.ESP_Team, function(v) SilentAimSettings.ESP_Team = v end)
    addToggle(esp, "ESP_HL", "Highlight", SilentAimSettings.ESP_Highlight, function(v) SilentAimSettings.ESP_Highlight = v end)
    addToggle(esp, "ESP_Name", "Names", SilentAimSettings.ESP_Name, function(v) SilentAimSettings.ESP_Name = v end)
    addToggle(esp, "ESP_HP", "Health Bar", SilentAimSettings.ESP_Health, function(v) SilentAimSettings.ESP_Health = v end)
    addToggle(esp, "ESP_Tr", "Trace Line", SilentAimSettings.ESP_Trace, function(v) SilentAimSettings.ESP_Trace = v end)
    esp:AddSlider("ESP_Dist", {
        Text = "Max Distance", Default = SilentAimSettings.ESP_MaxDistance, Min = 100, Max = 3000, Rounding = 0,
        Callback = function(v) SilentAimSettings.ESP_MaxDistance = v end,
    })

    local tr = Tabs.Visuals:AddRightGroupbox("Tracers / FX")
    addToggle(tr, "BeamOn", "Tracer Beams", SilentAimSettings.TracerESPEnabled, function(v) SilentAimSettings.TracerESPEnabled = v end)
    addToggle(tr, "BeamT", "Tracer Target Only", SilentAimSettings.TracerTargetOnly, function(v) SilentAimSettings.TracerTargetOnly = v end)
    tr:AddSlider("BeamW", {
        Text = "Thickness x100", Default = 15, Min = 5, Max = 50, Rounding = 0,
        Callback = function(v) SilentAimSettings.TracerThickness = v / 100 end,
    })
    addToggle(tr, "KillFX", "Kill Effect", SilentAimSettings.KillEffectEnabled, function(v) SilentAimSettings.KillEffectEnabled = v end)
    addToggle(tr, "KillLog", "Kill Logs", SilentAimSettings.KillLogsEnabled, function(v) SilentAimSettings.KillLogsEnabled = v end)
    addToggle(tr, "HitLog", "Hit Logs", SilentAimSettings.HitLogsEnabled, function(v) SilentAimSettings.HitLogsEnabled = v end)
    addToggle(tr, "HitSnd", "Custom Hit Sound", SilentAimSettings.CustomHitSoundEnabled, function(v) SilentAimSettings.CustomHitSoundEnabled = v end)
    tr:AddLabel("Hit Sound")
    addExclusiveList(tr, "HitSnd", { "TF2 Hit", "Neverlose", "Minecraft Hit 1", "MLG Hit", "Rust", "Skeet", "Fatality" },
        function() return SilentAimSettings.HitSoundName or "Neverlose" end,
        function(v) SilentAimSettings.HitSoundName = v end)
    addToggle(tr, "KillSnd", "Custom Kill Sound", SilentAimSettings.CustomKillSoundEnabled, function(v) SilentAimSettings.CustomKillSoundEnabled = v end)
    tr:AddLabel("Kill Sound")
    addExclusiveList(tr, "KillSnd", { "Fahhh", "Vine Boom", "CoD Kaboom", "Laugh", "iPhone Ding", "Creepy Bell" },
        function() return SilentAimSettings.KillSoundName or "Vine Boom" end,
        function(v) SilentAimSettings.KillSoundName = v end)

    -- WORLD tab
    local world = Tabs.World:AddLeftGroupbox("Environment")
    addToggle(world, "NoFog", "Remove Fog", SilentAimSettings.RemoveFog, function(v)
        SilentAimSettings.RemoveFog = v; applyFog()
    end)
    addToggle(world, "SkyOn", "Custom Skybox", SilentAimSettings.CustomSkybox, function(v)
        SilentAimSettings.CustomSkybox = v; applySkybox()
    end)
    world:AddDropdown("SkyN", {
        Text = "Skybox",
        Values = { "None", "Nebula" },
        Default = SilentAimSettings.SkyboxName or "None",
        Callback = function(v) if typeof(v) == "string" then SilentAimSettings.SkyboxName = v; applySkybox() end end,
    })
    addToggle(world, "Grad", "World Gradient", SilentAimSettings.WorldGradient, function(v)
        SilentAimSettings.WorldGradient = v; applyWorldGradient()
    end)

    -- SETTINGS tab
    local accentBox = Tabs.Settings:AddLeftGroupbox("Accent Color")
    if accentBox.AddColorPicker then
        accentBox:AddColorPicker("AccentPicker", {
            Text = "Accent / Outlines",
            Default = Library.Scheme.AccentColor,
            Callback = function(c) setAccent(c) end,
        })
    end
    for _, e in ipairs({
        { "Pink", Color3.fromRGB(255, 182, 193) },
        { "Blue", Color3.fromRGB(140, 180, 255) },
        { "Green", Color3.fromRGB(140, 255, 180) },
        { "Purple", Color3.fromRGB(200, 140, 255) },
        { "Red", Color3.fromRGB(255, 100, 120) },
        { "Orange", Color3.fromRGB(255, 170, 90) },
        { "Cyan", Color3.fromRGB(100, 230, 255) },
        { "White", Color3.fromRGB(235, 235, 245) },
    }) do
        accentBox:AddButton({ Text = e[1], Func = function() setAccent(e[2]) end })
    end

    local menu = Tabs.Settings:AddLeftGroupbox("Menu")
    menu:AddLabel("Menu toggle: RightShift")
    menu:AddLabel("Hotkeys start blank — set on each toggle")
    menu:AddButton({
        Text = "Unload",
        Func = function()
            if getgenv().SpentUnloadHub then
                getgenv().SpentUnloadHub()
            else
                pcall(function() Library:Unload() end)
            end
        end,
    })

    Library:Notify({ Title = "SPENT HUB", Description = "made by spent · loaded", Time = 1.2 })
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
    ok = pcall(function()
        if type(lib.Toggle) == "function" then
            lib:Toggle()
            return true
        end
    end) and true or ok
    if not ok then
        pcall(function()
            if lib.Toggled ~= nil then
                lib.Toggled = not lib.Toggled
                ok = true
            end
        end)
    end
    pcall(function()
        if lib.ScreenGui then
            lib.ScreenGui.Enabled = not lib.ScreenGui.Enabled
            ok = true
        end
    end)
    pcall(function()
        local root = lib.WindowContainer or lib.MainFrame or lib.Outer
        if root and root:IsA("GuiObject") then
            root.Visible = not root.Visible
            ok = true
        end
    end)
    pcall(function()
        local pg = LocalPlayer:FindFirstChild("PlayerGui")
        if not pg then return end
        for _, g in ipairs(pg:GetChildren()) do
            if g:IsA("ScreenGui") and (g.Name:lower():find("obsidian") or g.Name:lower():find("library") or g.Name:lower():find("spent")) then
                g.Enabled = not g.Enabled
            end
        end
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
    pcall(stopInvisible)
    pcall(stopFastSwitch)
    pcall(function()
        for _, p in ipairs(Players:GetPlayers()) do removeESPData(p) end
    end)
    local lib = Library or getgenv().Library
    pcall(function()
        if lib and type(lib.Unload) == "function" then
            lib:Unload()
        end
    end)
    pcall(function()
        if lib and lib.ScreenGui then
            lib.ScreenGui.Enabled = false
            lib.ScreenGui:Destroy()
        end
    end)
    print("SPENT HUB unloaded.")
end
getgenv().SpentUnloadHub = spentUnloadHub
getgenv().SpentToggleMenu = spentToggleMenu

UserInputService.InputBegan:Connect(function(input, processed)
    if input.UserInputType ~= Enum.UserInputType.Keyboard then return end

    if input.KeyCode == Enum.KeyCode.RightShift then
        spentToggleMenu()
        return
    end

    if input.KeyCode == Enum.KeyCode.End then
        spentUnloadHub()
        return
    end

    if processed then return end

    if input.KeyCode == Enum.KeyCode.F and not IS_MOBILE then
        doNoclipPunch()
    end
end)

task.spawn(function()
    RenderStepped:Connect(function()
        if SilentAimSettings.ShowSilentAimTarget and SilentAimSettings.Enabled then
            if currentTarget and currentTarget.Parent then
                local Root = currentTarget.Parent and currentTarget.Parent.PrimaryPart or currentTarget
                local vp2, on = WorldToViewportPoint(Camera, Root.Position)
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

    local chance = CalculateChance(SilentAimSettings.HitChance)
    if SilentAimSettings.Enabled and self == workspace and not checkcaller() and chance == true and not AutoShootRaycastInProgress then
        if Method == "FindPartOnRayWithIgnoreList" and SilentAimSettings.SilentAimMethod == Method then
            if ValidateArguments(Args, ExpectedArguments.FindPartOnRayWithIgnoreList) then
                local r = Args[2]
                local hit = currentTarget
                if hit and hit.Parent then
                    Args[2] = Ray.new(r.Origin, getDirection(r.Origin, hit.Position))
                    return oldNamecall(unpack(Args))
                end
            end
        elseif Method == "FindPartOnRayWithWhitelist" and SilentAimSettings.SilentAimMethod == Method then
            if ValidateArguments(Args, ExpectedArguments.FindPartOnRayWithWhitelist) then
                local r = Args[2]
                local hit = currentTarget
                if hit and hit.Parent then
                    Args[2] = Ray.new(r.Origin, getDirection(r.Origin, hit.Position))
                    return oldNamecall(unpack(Args))
                end
            end
        elseif (Method == "FindPartOnRay" or Method == "findPartOnRay") and SilentAimSettings.SilentAimMethod:lower() == Method:lower() then
            if ValidateArguments(Args, ExpectedArguments.FindPartOnRay) then
                local r = Args[2]
                local hit = currentTarget
                if hit and hit.Parent then
                    Args[2] = Ray.new(r.Origin, getDirection(r.Origin, hit.Position))
                    return oldNamecall(unpack(Args))
                end
            end
        elseif Method == "Raycast" and SilentAimSettings.SilentAimMethod == Method then
            if ValidateArguments(Args, ExpectedArguments.Raycast) then
                local o = Args[2]
                local hit = currentTarget
                if hit and hit.Parent then
                    Args[3] = getDirection(o, hit.Position)
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
            if SilentAimSettings.MouseHitPrediction then
                return hit.CFrame + (hit.Velocity * PredictionAmount)
            end
            return hit.CFrame
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
