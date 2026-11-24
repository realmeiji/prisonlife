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
Instance.new("UICorner", startupFrame).CornerRadius = UDim.new(0.2, 0)

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
    AutoshootEnabled = false, NoclipEnabled = false,
    SpeedValue = 16, JumpPowerValue = 50,
    InvisibleEnabled = false, KorbloxEnabled = false, HeadlessEnabled = false,
    FastSwitchEnabled = false, FastSwitchDelay = 0.05,
    FastSwitchList = {"M9", "Revolver", "Remington 870", "MP5", "M4A1", "M700", "AK-47"},
    FastSwitchHotkey = Enum.KeyCode.H, NoclipPunchEnabled = false,
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
UserInputService.MouseIconEnabled = false

local cursorGui = Instance.new("ScreenGui")
cursorGui.Name = "SpentHubCursor"
cursorGui.ResetOnSpawn = false
cursorGui.IgnoreGuiInset = true
cursorGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
cursorGui.DisplayOrder = 2147483647
cursorGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local customCursor = Instance.new("ImageLabel")
customCursor.Name = "Cursor"
customCursor.Size = UDim2.fromOffset(32, 32)
customCursor.BackgroundTransparency = 1
customCursor.Image = "rbxassetid://2025732283"
customCursor.ImageColor3 = Theme.ACCENT 
customCursor.AnchorPoint = Vector2.new(0, 0)
customCursor.ZIndex = 2147483647
customCursor.Visible = not IS_MOBILE
customCursor.Parent = cursorGui

local cursorConnection = RenderStepped:Connect(function()
    if IS_MOBILE then return end
    local mouseLoc = GetMouseLocation(UserInputService)
    customCursor.Position = UDim2.fromOffset(mouseLoc.X, mouseLoc.Y)
end)

local mouse_box = Drawing.new("Square")
mouse_box.Visible = false
mouse_box.ZIndex = 999
mouse_box.Color = Color3.fromRGB(255, 182, 193)
mouse_box.Thickness = 2
mouse_box.Size = Vector2.new(20, 20)
mouse_box.Filled = false

local fov_circle = Drawing.new("Circle")
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

local lastRollTime, lastRollResult = 0, false
local function CalculateChance(Percentage)
    local now = tick()
    if now - lastRollTime < 0.15 then return lastRollResult end
    lastRollTime = now
    Percentage = math.floor(Percentage)
    local chance = math.floor(Random.new().NextNumber(Random.new(), 0, 1) * 100) / 100
    lastRollResult = chance <= Percentage / 100
    return lastRollResult
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

local gui = Instance.new("ScreenGui")
gui.Name = "SpentHub"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 100
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local function buildMenuFrames()
    for _, c in ipairs(gui:GetChildren()) do
        if c.Name ~= "SpentHubNotif" and c.Name ~= "SpentHubToggle" then
            if c:IsA("Frame") or c:IsA("ScreenGui") then pcall(function() c:Destroy() end) end
        end
    end

    local vp = Camera.ViewportSize
    local sw, sh = vp.X, vp.Y
    local isMobile = IS_MOBILE or sw < 700
    local mainW, mainH, mainPosX, mainPosY, sideW, contX, contWOff, rightW, titleH, statusH, fBody, fHead

    if isMobile then
        mainW = math.floor(math.min(sw * 0.98, 540))
        mainH = math.floor(math.min(sh * 0.82, 400))
        mainPosX = -(mainW / 2); mainPosY = -(mainH / 2)
        sideW = 90; contX = 100; contWOff = -270; rightW = 150
        titleH = 32; statusH = 18; fBody = 9; fHead = 10
    else
        mainW = 890; mainH = 440; mainPosX = -445; mainPosY = -220
        sideW = 150; contX = 176; contWOff = -388; rightW = 200
        titleH = 40; statusH = 24; fBody = 11; fHead = 12
    end

    local bgBlur = Instance.new("Frame", gui)
    bgBlur.Name = "bgBlur"
    bgBlur.Size = UDim2.new(0, mainW + 10, 0, mainH + 10)
    bgBlur.Position = UDim2.new(0.5, mainPosX - 5, 0.5, mainPosY - 5)
    bgBlur.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    bgBlur.BackgroundTransparency = 0.55
    bgBlur.BorderSizePixel = 0
    bgBlur.ZIndex = 98
    Instance.new("UICorner", bgBlur).CornerRadius = UDim.new(0.02, 0)

    local shadow = Instance.new("Frame", gui)
    shadow.Name = "shadow"
    shadow.Size = UDim2.new(0, mainW + 10, 0, mainH + 10)
    shadow.Position = UDim2.new(0.5, mainPosX - 5, 0.5, mainPosY - 5)
    shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    shadow.BackgroundTransparency = 0.6
    shadow.BorderSizePixel = 0
    shadow.ZIndex = 99
    Instance.new("UICorner", shadow).CornerRadius = UDim.new(0.02, 0)

    local main = Instance.new("Frame", gui)
    main.Name = "main"
    main.Size = UDim2.new(0, mainW, 0, mainH)
    main.Position = UDim2.new(0.5, mainPosX, 0.5, mainPosY)
    main.BackgroundColor3 = Theme.BG_MAIN
    main.BackgroundTransparency = 0.05
    main.BorderSizePixel = 0
    main.Active = true
    main.ZIndex = 100
    Instance.new("UICorner", main).CornerRadius = UDim.new(0.025, 0)

    local mainStroke = Instance.new("UIStroke", main)
    mainStroke.Name = "mainStroke"
    mainStroke.Color = Theme.BORDER
    mainStroke.Thickness = 1
    mainStroke.Transparency = 0.5

    local mainGlow = Instance.new("UIStroke", main)
    mainGlow.Name = "mainGlow"
    mainGlow.Color = Theme.ACCENT
    mainGlow.Thickness = 4
    mainGlow.Transparency = 0.88
    Instance.new("UICorner", mainGlow).CornerRadius = UDim.new(0.025, 0)

    task.spawn(function()
        while main.Parent do
            pcall(function() TweenService:Create(mainGlow, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0.65}):Play() end)
            task.wait(3)
            pcall(function() TweenService:Create(mainGlow, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0.92}):Play() end)
            task.wait(3)
        end
    end)

    main:GetPropertyChangedSignal("Position"):Connect(function()
        shadow.Position = main.Position + UDim2.new(0, -5, 0, -5)
        bgBlur.Position = main.Position + UDim2.new(0, -5, 0, -5)
    end)
    main:GetPropertyChangedSignal("Visible"):Connect(function()
        shadow.Visible = main.Visible
        bgBlur.Visible = main.Visible
    end)

    local titleBar = Instance.new("Frame", main)
    titleBar.Name = "titleBar"
    titleBar.Size = UDim2.new(1, 0, 0, titleH)
    titleBar.BackgroundColor3 = Theme.BG_PANEL
    titleBar.BackgroundTransparency = 0.3
    titleBar.BorderSizePixel = 0
    titleBar.Active = true
    titleBar.ZIndex = 101
    Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0.035, 0)

    local titleStroke = Instance.new("UIStroke", titleBar)
    titleStroke.Color = Theme.BORDER
    titleStroke.Thickness = 0.5
    titleStroke.Transparency = 0.6

    local icon = Instance.new("TextLabel", titleBar)
    icon.Name = "icon"
    icon.Size = UDim2.new(0, 36, 1, 0)
    icon.Position = UDim2.new(0, 10, 0, 0)
    icon.BackgroundTransparency = 1
    icon.Text = Theme.ICON
    icon.TextColor3 = Theme.ACCENT
    icon.Font = Enum.Font.GothamBold
    icon.TextSize = isMobile and 18 or 24
    icon.ZIndex = 102

    task.spawn(function()
        while icon.Parent do
            pcall(function() TweenService:Create(icon, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {TextTransparency = 0.3}):Play() end)
            task.wait(2)
            pcall(function() TweenService:Create(icon, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {TextTransparency = 0}):Play() end)
            task.wait(2)
        end
    end)

    local title = Instance.new("TextLabel", titleBar)
    title.Name = "title"
    title.Size = UDim2.new(1, -180, 1, 0)
    title.Position = UDim2.new(0, 46, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "SPENT HUB"
    title.TextColor3 = Theme.TEXT_STRONG
    title.Font = Enum.Font.GothamBold
    title.TextSize = isMobile and 11 or 14
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.ZIndex = 102

    local drag = Instance.new("TextButton", titleBar)
    drag.Size = UDim2.new(1, -180, 1, 0)
    drag.Position = UDim2.new(0, 46, 0, 0)
    drag.BackgroundTransparency = 1
    drag.Text = ""
    drag.AutoButtonColor = false
    drag.Draggable = true
    drag.Active = true
    drag.ZIndex = 103

    local function createRipple(parent, position)
        local ripple = Instance.new("Frame", parent)
        ripple.Size = UDim2.new(0, 0, 0, 0)
        ripple.Position = position
        ripple.BackgroundColor3 = Theme.ACCENT
        ripple.BackgroundTransparency = 0.8
        ripple.BorderSizePixel = 0
        ripple.ZIndex = 99
        Instance.new("UICorner", ripple).CornerRadius = UDim.new(1, 0)
        TweenService:Create(ripple, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 100, 0, 100),
            Position = position + UDim2.new(-50, 0, -50, 0),
            BackgroundTransparency = 1,
        }):Play()
        task.delay(0.6, function() pcall(function() ripple:Destroy() end) end)
    end

    local function makeTitleBtn(symbol, orderX)
        local sz = isMobile and 22 or 26
        local btn = Instance.new("TextButton", titleBar)
        btn.Size = UDim2.new(0, sz, 0, sz)
        btn.Position = UDim2.new(1, orderX, 0.5, -(sz/2))
        btn.BackgroundColor3 = Theme.BG_OPT
        btn.Text = symbol
        btn.TextColor3 = Theme.TEXT
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = isMobile and 11 or 14
        btn.BorderSizePixel = 0
        btn.AutoButtonColor = false
        btn.ZIndex = 103
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0.35, 0)
        local btnGlow = Instance.new("UIStroke", btn)
        btnGlow.Color = Theme.ACCENT
        btnGlow.Thickness = 2
        btnGlow.Transparency = 1
        Instance.new("UICorner", btnGlow).CornerRadius = UDim.new(0.35, 0)
        btn.MouseButton1Click:Connect(function() createRipple(btn, UDim2.new(0.5, 0, 0.5, 0)) end)
        btn.MouseEnter:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.18), {BackgroundColor3 = Theme.BG_HOVER, TextColor3 = Theme.ACCENT}):Play()
            TweenService:Create(btnGlow, TweenInfo.new(0.15), {Transparency = 0.4}):Play()
        end)
        btn.MouseLeave:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.18), {BackgroundColor3 = Theme.BG_OPT, TextColor3 = Theme.TEXT}):Play()
            TweenService:Create(btnGlow, TweenInfo.new(0.15), {Transparency = 1}):Play()
        end)
        return btn, btnGlow
    end

    local compactBtn = makeTitleBtn("-", isMobile and -56 or -90)
    local closeBtn = makeTitleBtn("x", isMobile and -28 or -58)

    local statusStrip = Instance.new("Frame", main)
    statusStrip.Name = "statusStrip"
    statusStrip.Size = UDim2.new(1, 0, 0, statusH)
    statusStrip.Position = UDim2.new(0, 0, 0, titleH)
    statusStrip.BackgroundColor3 = Theme.BG_PANEL
    statusStrip.BackgroundTransparency = 0.5
    statusStrip.BorderSizePixel = 0
    statusStrip.ZIndex = 101

    local statusLabel = Instance.new("TextLabel", statusStrip)
    statusLabel.Name = "statusLabel"
    statusLabel.Size = UDim2.new(1, -20, 1, 0)
    statusLabel.Position = UDim2.new(0, 10, 0, 0)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "* idle · method: Raycast · fov: 130"
    statusLabel.TextColor3 = Theme.TEXT_DIM
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.TextSize = isMobile and 8 or 10
    statusLabel.TextXAlignment = Enum.TextXAlignment.Left
    statusLabel.ZIndex = 102

    local topOffset = titleH + statusH + 8

    local sidebar = Instance.new("Frame", main)
    sidebar.Name = "sidebar"
    sidebar.Size = UDim2.new(0, sideW, 1, -topOffset - 8)
    sidebar.Position = UDim2.new(0, 6, 0, topOffset)
    sidebar.BackgroundColor3 = Theme.BG_PANEL
    sidebar.BackgroundTransparency = 0.15
    sidebar.BorderSizePixel = 0
    sidebar.ZIndex = 101
    Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0.05, 0)
    local sidebarStroke = Instance.new("UIStroke", sidebar)
    sidebarStroke.Color = Theme.BORDER
    sidebarStroke.Thickness = 0.5
    sidebarStroke.Transparency = 0.5

    local sideHeader = Instance.new("TextLabel", sidebar)
    sideHeader.Size = UDim2.new(1, -10, 0, 20)
    sideHeader.Position = UDim2.new(0, 6, 0, 4)
    sideHeader.BackgroundTransparency = 1
    sideHeader.Text = "SPENT"
    sideHeader.TextColor3 = Theme.ACCENT
    sideHeader.Font = Enum.Font.GothamBold
    sideHeader.TextSize = isMobile and 8 or 10
    sideHeader.TextXAlignment = Enum.TextXAlignment.Left
    sideHeader.ZIndex = 102

    local sidebarLayout = Instance.new("UIListLayout", sidebar)
    sidebarLayout.Padding = UDim.new(0, isMobile and 2 or 4)
    sidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder

    local sidebarPad = Instance.new("UIPadding", sidebar)
    sidebarPad.PaddingTop = UDim.new(0, 28)
    sidebarPad.PaddingLeft = UDim.new(0, 6)
    sidebarPad.PaddingRight = UDim.new(0, 6)

    local divider = Instance.new("Frame", main)
    divider.Size = UDim2.new(0, 1, 1, -(topOffset + 6))
    divider.Position = UDim2.new(0, sideW + 10, 0, topOffset + 2)
    divider.BackgroundColor3 = Theme.BORDER
    divider.BackgroundTransparency = 0.4
    divider.BorderSizePixel = 0
    divider.ZIndex = 102

    local content = Instance.new("Frame", main)
    content.Name = "content"
    content.Size = UDim2.new(0, mainW - contX - rightW - 16, 1, -(topOffset + 8))
    content.Position = UDim2.new(0, contX, 0, topOffset)
    content.BackgroundColor3 = Theme.BG_PANEL
    content.BackgroundTransparency = 0.08
    content.BorderSizePixel = 0
    content.ZIndex = 101
    Instance.new("UICorner", content).CornerRadius = UDim.new(0.035, 0)
    local contentStroke = Instance.new("UIStroke", content)
    contentStroke.Color = Theme.BORDER
    contentStroke.Thickness = 0.5
    contentStroke.Transparency = 0.5

    local accentLine = Instance.new("Frame", content)
    accentLine.Name = "accentLine"
    accentLine.Size = UDim2.new(0, 70, 0, 2.5)
    accentLine.Position = UDim2.new(0, 10, 0, 28)
    accentLine.BackgroundColor3 = Theme.ACCENT
    accentLine.BorderSizePixel = 0
    accentLine.ZIndex = 102
    Instance.new("UICorner", accentLine).CornerRadius = UDim.new(1, 0)
    local accentGlow = Instance.new("UIStroke", accentLine)
    accentGlow.Color = Theme.ACCENT
    accentGlow.Thickness = 3
    accentGlow.Transparency = 0.6

    local contentHeader = Instance.new("TextLabel", content)
    contentHeader.Name = "contentHeader"
    contentHeader.Size = UDim2.new(1, -20, 0, 22)
    contentHeader.Position = UDim2.new(0, 10, 0, 2)
    contentHeader.BackgroundTransparency = 1
    contentHeader.Text = "MAIN"
    contentHeader.TextColor3 = Theme.ACCENT
    contentHeader.Font = Enum.Font.GothamBold
    contentHeader.TextSize = fHead
    contentHeader.TextXAlignment = Enum.TextXAlignment.Left
    contentHeader.ZIndex = 102

    local scroll = Instance.new("ScrollingFrame", content)
    scroll.Name = "scroll"
    scroll.Size = UDim2.new(1, -14, 1, -38)
    scroll.Position = UDim2.new(0, 8, 0, 34)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = isMobile and 3 or 4
    scroll.ScrollBarImageColor3 = Theme.ACCENT
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scroll.ScrollingDirection = Enum.ScrollingDirection.Y
    scroll.ClipsDescendants = true
    scroll.ZIndex = 102

    local scrollLayout = Instance.new("UIListLayout", scroll)
    scrollLayout.Name = "scrollLayout"
    scrollLayout.Padding = UDim.new(0, isMobile and 4 or 7)
    scrollLayout.SortOrder = Enum.SortOrder.LayoutOrder

    local rightDock = Instance.new("Frame", main)
    rightDock.Name = "rightDock"
    rightDock.Size = UDim2.new(0, rightW, 1, -(topOffset + 8))
    rightDock.Position = UDim2.new(1, -(rightW + 6), 0, topOffset)
    rightDock.BackgroundColor3 = Theme.BG_PANEL
    rightDock.BackgroundTransparency = 0.08
    rightDock.BorderSizePixel = 0
    rightDock.ZIndex = 101
    Instance.new("UICorner", rightDock).CornerRadius = UDim.new(0.035, 0)
    local rightStroke = Instance.new("UIStroke", rightDock)
    rightStroke.Color = Theme.BORDER
    rightStroke.Thickness = 0.5
    rightStroke.Transparency = 0.5

    local rightHeader = Instance.new("TextLabel", rightDock)
    rightHeader.Name = "rightHeader"
    rightHeader.Size = UDim2.new(1, -16, 0, 22)
    rightHeader.Position = UDim2.new(0, 10, 0, 4)
    rightHeader.BackgroundTransparency = 1
    rightHeader.Text = "FOV CIRCLE"
    rightHeader.TextColor3 = Theme.ACCENT
    rightHeader.Font = Enum.Font.GothamBold
    rightHeader.TextSize = isMobile and 9 or 11
    rightHeader.TextXAlignment = Enum.TextXAlignment.Left
    rightHeader.ZIndex = 102

    local rightScroll = Instance.new("ScrollingFrame", rightDock)
    rightScroll.Name = "rightScroll"
    rightScroll.Size = UDim2.new(1, -12, 1, -32)
    rightScroll.Position = UDim2.new(0, 6, 0, 28)
    rightScroll.BackgroundTransparency = 1
    rightScroll.BorderSizePixel = 0
    rightScroll.ScrollBarThickness = isMobile and 2 or 3
    rightScroll.ScrollBarImageColor3 = Theme.ACCENT
    rightScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    rightScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    rightScroll.ScrollingDirection = Enum.ScrollingDirection.Y
    rightScroll.ClipsDescendants = true
    rightScroll.ZIndex = 102

    local rightLayout = Instance.new("UIListLayout", rightScroll)
    rightLayout.Name = "rightLayout"
    rightLayout.Padding = UDim.new(0, isMobile and 3 or 6)
    rightLayout.SortOrder = Enum.SortOrder.LayoutOrder

    return {
        main = main, shadow = shadow, bgBlur = bgBlur,
        titleBar = titleBar, icon = icon, title = title, drag = drag,
        compactBtn = compactBtn, closeBtn = closeBtn, statusLabel = statusLabel,
        sidebar = sidebar, sidebarLayout = sidebarLayout,
        content = content, contentHeader = contentHeader, accentLine = accentLine,
        scroll = scroll, scrollLayout = scrollLayout,
        rightDock = rightDock, rightHeader = rightHeader,
        rightScroll = rightScroll, rightLayout = rightLayout,
        mainGlow = mainGlow, mainStroke = mainStroke,
        mainW = mainW, mainH = mainH, mainPosX = mainPosX, mainPosY = mainPosY,
        isMobile = isMobile, fBody = fBody, fHead = fHead, createRipple = createRipple,
    }
end

local UI = buildMenuFrames()
local main = UI.main
local shadow = UI.shadow
local bgBlur = UI.bgBlur
local titleBar = UI.titleBar
local icon = UI.icon
local title = UI.title
local compactBtn = UI.compactBtn
local closeBtn = UI.closeBtn
local statusLabel = UI.statusLabel
local sidebar = UI.sidebar
local content = UI.content
local contentHeader = UI.contentHeader
local accentLine = UI.accentLine
local scroll = UI.scroll
local rightDock = UI.rightDock
local rightHeader = UI.rightHeader
local rightScroll = UI.rightScroll
local mainGlow = UI.mainGlow
local mainStroke = UI.mainStroke
local isMobile = UI.isMobile
local fBody = UI.fBody
local fHead = UI.fHead
local createRipple = UI.createRipple

local function animateAccentLine()
    accentLine.Size = UDim2.new(0, 0, 0, 2.5)
    accentLine.BackgroundTransparency = 0
    TweenService:Create(accentLine, TweenInfo.new(0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 70, 0, 2.5),
    }):Play()
end

local hubToggleBtn = Instance.new("TextButton", gui)
hubToggleBtn.Name = "SpentHubToggle"
hubToggleBtn.Size = UDim2.new(0, isMobile and 42 or 50, 0, isMobile and 42 or 50)
hubToggleBtn.Position = UDim2.new(0, 20, 0.5, isMobile and -21 or -25)
hubToggleBtn.BackgroundColor3 = Theme.BG_PANEL
hubToggleBtn.BackgroundTransparency = 0.15
hubToggleBtn.Text = Theme.ICON
hubToggleBtn.TextColor3 = Theme.ACCENT
hubToggleBtn.Font = Enum.Font.GothamBold
hubToggleBtn.TextSize = isMobile and 20 or 26
hubToggleBtn.BorderSizePixel = 0
hubToggleBtn.Visible = false
hubToggleBtn.Active = true
hubToggleBtn.Draggable = true
hubToggleBtn.ZIndex = 50
Instance.new("UICorner", hubToggleBtn).CornerRadius = UDim.new(1, 0)

local hubStroke = Instance.new("UIStroke", hubToggleBtn)
hubStroke.Color = Theme.BORDER
hubStroke.Thickness = 1
hubStroke.Transparency = 0.4

local hubGlow = Instance.new("UIStroke", hubToggleBtn)
hubGlow.Color = Theme.ACCENT
hubGlow.Thickness = 5
hubGlow.Transparency = 0.85
Instance.new("UICorner", hubGlow).CornerRadius = UDim.new(1, 0)

task.spawn(function()
    while hubToggleBtn.Parent do
        pcall(function() TweenService:Create(hubGlow, TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0.6}):Play() end)
        task.wait(2.5)
        pcall(function() TweenService:Create(hubGlow, TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0.88}):Play() end)
        task.wait(2.5)
    end
end)

hubToggleBtn.MouseEnter:Connect(function()
    TweenService:Create(hubToggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.ACCENT, TextColor3 = Theme.BG_MAIN}):Play()
end)
hubToggleBtn.MouseLeave:Connect(function()
    TweenService:Create(hubToggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.BG_PANEL, TextColor3 = Theme.ACCENT}):Play()
end)

local notifFrame = Instance.new("Frame", gui)
notifFrame.Name = "SpentHubNotif"
notifFrame.Size = UDim2.new(0, isMobile and 260 or 340, 0, 400)
notifFrame.Position = UDim2.new(1, isMobile and -270 or -360, 0, 100)
notifFrame.BackgroundTransparency = 1
notifFrame.ZIndex = 500

local notifLayout = Instance.new("UIListLayout", notifFrame)
notifLayout.Padding = UDim.new(0, 8)
notifLayout.SortOrder = Enum.SortOrder.LayoutOrder

local notifQueue = 0
local notifStaggerDelay = 0.05

local function notify(text, color)
    color = color or Theme.ACCENT
    notifQueue = notifQueue + 1
    local myOrder = notifQueue
    task.delay((myOrder - 1) * notifStaggerDelay, function()
        local LIFETIME = 3.5
        local wrap = Instance.new("Frame", notifFrame)
        wrap.Size = UDim2.new(1, 0, 0, 44)
        wrap.BackgroundTransparency = 1
        wrap.ZIndex = 501
        local card = Instance.new("Frame", wrap)
        card.Size = UDim2.new(1, 0, 1, 0)
        card.BackgroundColor3 = Theme.BG_OPT
        card.BackgroundTransparency = 0.08
        card.BorderSizePixel = 0
        card.ZIndex = 502
        Instance.new("UICorner", card).CornerRadius = UDim.new(0.16, 0)
        local stroke = Instance.new("UIStroke", card)
        stroke.Color = color
        stroke.Thickness = 1
        stroke.Transparency = 0.4
        local bar = Instance.new("Frame", card)
        bar.Size = UDim2.new(0, 3.5, 1, -10)
        bar.Position = UDim2.new(0, 5, 0, 5)
        bar.BackgroundColor3 = color
        bar.BorderSizePixel = 0
        bar.ZIndex = 503
        Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)
        local lbl = Instance.new("TextLabel", card)
        lbl.Size = UDim2.new(1, -18, 1, -8)
        lbl.Position = UDim2.new(0, 14, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = text
        lbl.TextColor3 = Theme.TEXT_STRONG
        lbl.Font = Enum.Font.GothamMedium
        lbl.TextSize = isMobile and 9 or 11
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.TextYAlignment = Enum.TextYAlignment.Center
        lbl.ZIndex = 503
        wrap.Position = UDim2.new(1.2, 0, 0, 0)
        card.BackgroundTransparency = 1
        lbl.TextTransparency = 1
        bar.BackgroundTransparency = 1
        TweenService:Create(wrap, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0)}):Play()
        TweenService:Create(card, TweenInfo.new(0.22), {BackgroundTransparency = 0.08}):Play()
        TweenService:Create(lbl, TweenInfo.new(0.22), {TextTransparency = 0}):Play()
        TweenService:Create(bar, TweenInfo.new(0.22), {BackgroundTransparency = 0}):Play()
        task.delay(LIFETIME, function()
            TweenService:Create(wrap, TweenInfo.new(0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Position = UDim2.new(1.2, 0, 0, 0)}):Play()
            TweenService:Create(card, TweenInfo.new(0.22), {BackgroundTransparency = 1}):Play()
            TweenService:Create(lbl, TweenInfo.new(0.22), {TextTransparency = 1}):Play()
            TweenService:Create(bar, TweenInfo.new(0.22), {BackgroundTransparency = 1}):Play()
            task.wait(0.28)
            pcall(function() wrap:Destroy() end)
        end)
    end)
end

local ROW_H = isMobile and 26 or 32
local SLIDER_H = isMobile and 38 or 44

local function makeSection(parent, text)
    local s = Instance.new("TextLabel", parent)
    s.Size = UDim2.new(1, 0, 0, isMobile and 14 or 18)
    s.BackgroundTransparency = 1
    s.Text = " " .. string.upper(text)
    s.TextColor3 = Theme.ACCENT
    s.Font = Enum.Font.GothamBold
    s.TextSize = isMobile and 8 or 9
    s.TextXAlignment = Enum.TextXAlignment.Left
    s.TextTransparency = 0.3
end

local function makeToggle(parent, name, default, callback, tooltip)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1, 0, 0, ROW_H)
    btn.BackgroundColor3 = Theme.BG_OPT
    btn.BackgroundTransparency = 0.08
    btn.Text = ""
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    btn.Name = name
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0.22, 0)
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Theme.BORDER
    stroke.Thickness = 0.5
    stroke.Transparency = 0.6
    local lbl = Instance.new("TextLabel", btn)
    lbl.Size = UDim2.new(0.65, 0, 1, 0)
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = name
    lbl.TextColor3 = Theme.TEXT
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextSize = fBody
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    local indW = isMobile and 32 or 38
    local indH = isMobile and 15 or 18
    local dotSz = isMobile and 11 or 14
    local ind = Instance.new("Frame", btn)
    ind.Size = UDim2.new(0, indW, 0, indH)
    ind.Position = UDim2.new(1, -(indW + 8), 0.5, -(indH/2))
    ind.BackgroundColor3 = default and Theme.ACCENT or Color3.fromRGB(45, 45, 55)
    ind.BorderSizePixel = 0
    Instance.new("UICorner", ind).CornerRadius = UDim.new(1, 0)
    local dot = Instance.new("Frame", ind)
    dot.Size = UDim2.new(0, dotSz, 0, dotSz)
    dot.Position = default and UDim2.new(1, -(dotSz+2), 0.5, -(dotSz/2)) or UDim2.new(0, 2, 0.5, -(dotSz/2))
    dot.BackgroundColor3 = Color3.fromRGB(250, 250, 250)
    dot.BorderSizePixel = 0
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
    local state = default
    btn.MouseButton1Click:Connect(function()
        state = not state
        createRipple(btn, UDim2.new(0.5, 0, 0.5, 0))
        TweenService:Create(dot, TweenInfo.new(0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Position = state and UDim2.new(1, -(dotSz+2), 0.5, -(dotSz/2)) or UDim2.new(0, 2, 0.5, -(dotSz/2)),
        }):Play()
        TweenService:Create(ind, TweenInfo.new(0.18), {
            BackgroundColor3 = state and Theme.ACCENT or Color3.fromRGB(45, 45, 55),
        }):Play()
        callback(state)
    end)
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.16), {BackgroundTransparency = 0, BackgroundColor3 = Theme.BG_HOVER}):Play()
        TweenService:Create(stroke, TweenInfo.new(0.16), {Transparency = 0.2}):Play()
        if tooltip then statusLabel.Text = " " .. tooltip end
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.16), {BackgroundTransparency = 0.08, BackgroundColor3 = Theme.BG_OPT}):Play()
        TweenService:Create(stroke, TweenInfo.new(0.16), {Transparency = 0.6}):Play()
        statusLabel.Text = "* idle · method: " .. SilentAimSettings.SilentAimMethod
    end)
    return btn
end

local function makeSlider(parent, name, min, max, default, callback)
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(1, 0, 0, SLIDER_H)
    frame.BackgroundColor3 = Theme.BG_OPT
    frame.BackgroundTransparency = 0.08
    frame.BorderSizePixel = 0
    frame.Name = name
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0.22, 0)
    local stroke = Instance.new("UIStroke", frame)
    stroke.Color = Theme.BORDER
    stroke.Thickness = 0.5
    stroke.Transparency = 0.6
    local lbl = Instance.new("TextLabel", frame)
    lbl.Size = UDim2.new(1, -16, 0, 14)
    lbl.Position = UDim2.new(0, 10, 0, 2)
    lbl.BackgroundTransparency = 1
    lbl.Text = name .. ": " .. tostring(default)
    lbl.TextColor3 = Theme.TEXT
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextSize = isMobile and 9 or 10
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    local bar = Instance.new("Frame", frame)
    bar.Size = UDim2.new(1, -20, 0, 5)
    bar.Position = UDim2.new(0, 10, 0, 22)
    bar.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    bar.BorderSizePixel = 0
    Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)
    local fill = Instance.new("Frame", bar)
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Theme.ACCENT
    fill.BorderSizePixel = 0
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)
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

local function makeButton(parent, name, callback, color)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1, 0, 0, ROW_H)
    btn.BackgroundColor3 = color or Theme.BG_OPT
    btn.BackgroundTransparency = 0.08
    btn.Text = name
    btn.TextColor3 = Theme.TEXT
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = fBody
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0.22, 0)
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Theme.BORDER
    stroke.Thickness = 0.5
    stroke.Transparency = 0.6
    btn.MouseButton1Click:Connect(function()
        createRipple(btn, UDim2.new(0.5, 0, 0.5, 0))
        callback()
    end)
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.16), {BackgroundColor3 = Theme.BG_HOVER, BackgroundTransparency = 0, TextColor3 = Theme.TEXT_STRONG}):Play()
        TweenService:Create(stroke, TweenInfo.new(0.16), {Transparency = 0.2}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.16), {BackgroundColor3 = color or Theme.BG_OPT, BackgroundTransparency = 0.08, TextColor3 = Theme.TEXT}):Play()
        TweenService:Create(stroke, TweenInfo.new(0.16), {Transparency = 0.6}):Play()
    end)
end

local function makeDropdown(parent, name, values, current, callback)
    local idx = 1
    for i, v in ipairs(values) do if v == current then idx = i break end end
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1, 0, 0, ROW_H)
    btn.BackgroundColor3 = Theme.BG_OPT
    btn.BackgroundTransparency = 0.08
    btn.Text = name .. ": " .. values[idx]
    btn.TextColor3 = Theme.TEXT
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = fBody
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0.22, 0)
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Theme.BORDER
    stroke.Thickness = 0.5
    stroke.Transparency = 0.6
    btn.MouseButton1Click:Connect(function()
        idx = idx + 1
        if idx > #values then idx = 1 end
        btn.Text = name .. ": " .. values[idx]
        createRipple(btn, UDim2.new(0.5, 0, 0.5, 0))
        callback(values[idx])
    end)
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.16), {BackgroundColor3 = Theme.BG_HOVER, BackgroundTransparency = 0, TextColor3 = Theme.TEXT_STRONG}):Play()
        TweenService:Create(stroke, TweenInfo.new(0.16), {Transparency = 0.2}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.16), {BackgroundColor3 = Theme.BG_OPT, BackgroundTransparency = 0.08, TextColor3 = Theme.TEXT}):Play()
        TweenService:Create(stroke, TweenInfo.new(0.16), {Transparency = 0.6}):Play()
    end)
end

local function makeKeybind(parent, name, currentKey, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1, 0, 0, ROW_H)
    btn.BackgroundColor3 = Theme.BG_OPT
    btn.BackgroundTransparency = 0.08
    btn.Text = ""
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0.22, 0)
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Theme.BORDER
    stroke.Thickness = 0.5
    stroke.Transparency = 0.6
    local lbl = Instance.new("TextLabel", btn)
    lbl.Size = UDim2.new(0.6, 0, 1, 0)
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = name
    lbl.TextColor3 = Theme.TEXT
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextSize = fBody
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    local keyLbl = Instance.new("TextLabel", btn)
    keyLbl.Size = UDim2.new(0, 56, 0, 18)
    keyLbl.Position = UDim2.new(1, -64, 0.5, -9)
    keyLbl.BackgroundColor3 = Theme.BG_MAIN
    keyLbl.BackgroundTransparency = 0.4
    keyLbl.Text = currentKey.Name
    keyLbl.TextColor3 = Theme.ACCENT
    keyLbl.Font = Enum.Font.GothamBold
    keyLbl.TextSize = isMobile and 8 or 10
    keyLbl.BorderSizePixel = 0
    Instance.new("UICorner", keyLbl).CornerRadius = UDim.new(0.4, 0)
    local listening = false
    local listenConn = nil
    btn.MouseButton1Click:Connect(function()
        if listening then return end
        listening = true
        keyLbl.Text = "..."
        keyLbl.TextColor3 = Theme.TEXT
        listenConn = UserInputService.InputBegan:Connect(function(input, processed)
            if processed then return end
            if input.UserInputType == Enum.UserInputType.Keyboard then
                local newKey = input.KeyCode
                listening = false
                keyLbl.Text = newKey.Name
                keyLbl.TextColor3 = Theme.ACCENT
                callback(newKey)
                if listenConn then listenConn:Disconnect() end
            end
        end)
    end)
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.16), {BackgroundColor3 = Theme.BG_HOVER, BackgroundTransparency = 0}):Play()
        TweenService:Create(stroke, TweenInfo.new(0.16), {Transparency = 0.2}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.16), {BackgroundColor3 = Theme.BG_OPT, BackgroundTransparency = 0.08}):Play()
        TweenService:Create(stroke, TweenInfo.new(0.16), {Transparency = 0.6}):Play()
    end)
end

local whitelistPlayerRows = {}
local function rebuildWhitelistPlayerList(container)
    for _, child in ipairs(container:GetChildren()) do
        if child:IsA("Frame") or child:IsA("TextLabel") then child:Destroy() end
    end
    table.clear(whitelistPlayerRows)
    local allPlayers = Players:GetPlayers()
    if #allPlayers == 0 then
        local empty = Instance.new("TextLabel", container)
        empty.Size = UDim2.new(1, 0, 0, 22)
        empty.BackgroundTransparency = 1
        empty.Text = " no players in server"
        empty.TextColor3 = Theme.TEXT_DIM
        empty.Font = Enum.Font.Gotham
        empty.TextSize = fBody
        empty.TextXAlignment = Enum.TextXAlignment.Left
        return
    end
    for _, plr in ipairs(allPlayers) do
        if plr == LocalPlayer then continue end
        local isWL = Whitelist[string.lower(plr.Name)] == true
        local row = Instance.new("Frame", container)
        row.Size = UDim2.new(1, 0, 0, isMobile and 30 or 36)
        row.BackgroundColor3 = Theme.BG_OPT
        row.BackgroundTransparency = 0.08
        row.BorderSizePixel = 0
        Instance.new("UICorner", row).CornerRadius = UDim.new(0.18, 0)
        local rowStroke = Instance.new("UIStroke", row)
        rowStroke.Color = isWL and Theme.ACCENT or Theme.BORDER
        rowStroke.Thickness = 0.5
        rowStroke.Transparency = isWL and 0.3 or 0.6
        local nameLbl = Instance.new("TextLabel", row)
        nameLbl.Size = UDim2.new(1, -50, 0.5, 0)
        nameLbl.Position = UDim2.new(0, 8, 0, 1)
        nameLbl.BackgroundTransparency = 1
        nameLbl.Text = plr.DisplayName
        nameLbl.TextColor3 = isWL and Theme.ACCENT or Theme.TEXT
        nameLbl.Font = Enum.Font.GothamMedium
        nameLbl.TextSize = fBody
        nameLbl.TextXAlignment = Enum.TextXAlignment.Left
        local indW = isMobile and 28 or 34
        local indH = isMobile and 13 or 16
        local dotSz = isMobile and 9 or 12
        local ind = Instance.new("Frame", row)
        ind.Size = UDim2.new(0, indW, 0, indH)
        ind.Position = UDim2.new(1, -(indW + 8), 0.5, -(indH/2))
        ind.BackgroundColor3 = isWL and Theme.ACCENT or Color3.fromRGB(45, 45, 55)
        ind.BorderSizePixel = 0
        Instance.new("UICorner", ind).CornerRadius = UDim.new(1, 0)
        local dot = Instance.new("Frame", ind)
        dot.Size = UDim2.new(0, dotSz, 0, dotSz)
        dot.Position = isWL and UDim2.new(1, -(dotSz+2), 0.5, -(dotSz/2)) or UDim2.new(0, 2, 0.5, -(dotSz/2))
        dot.BackgroundColor3 = Color3.fromRGB(250, 250, 250)
        dot.BorderSizePixel = 0
        Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
        local state = isWL
        local toggleBtn = Instance.new("TextButton", row)
        toggleBtn.Size = UDim2.new(1, 0, 1, 0)
        toggleBtn.BackgroundTransparency = 1
        toggleBtn.Text = ""
        toggleBtn.ZIndex = 2
        toggleBtn.MouseButton1Click:Connect(function()
            state = not state
            if state then
                addWhitelist(plr.Name)
                rowStroke.Color = Theme.ACCENT; rowStroke.Transparency = 0.3
                nameLbl.TextColor3 = Theme.ACCENT
            else
                removeWhitelist(plr.Name)
                rowStroke.Color = Theme.BORDER; rowStroke.Transparency = 0.6
                nameLbl.TextColor3 = Theme.TEXT
            end
            TweenService:Create(dot, TweenInfo.new(0.18), {Position = state and UDim2.new(1, -(dotSz+2), 0.5, -(dotSz/2)) or UDim2.new(0, 2, 0.5, -(dotSz/2))}):Play()
            TweenService:Create(ind, TweenInfo.new(0.18), {BackgroundColor3 = state and Theme.ACCENT or Color3.fromRGB(45, 45, 55)}):Play()
            notify((state and "whitelisted " or "un-whitelisted ") .. plr.Name, state and Theme.ACCENT or Theme.TEXT_DIM)
        end)
        whitelistPlayerRows[plr] = row
    end
end

local FIXED_GUN_LIST = {"M9", "Revolver", "Remington 870", "MP5", "M4A1", "M700", "AK-47"}

local function buildFovDock()
    for _, c in ipairs(rightScroll:GetChildren()) do
        if c:IsA("GuiObject") then c:Destroy() end
    end
    local oldLayout = rightScroll:FindFirstChildOfClass("UIListLayout")
    if oldLayout then oldLayout:Destroy() end
    local rl = Instance.new("UIListLayout", rightScroll)
    rl.Padding = UDim.new(0, isMobile and 3 or 6)
    rl.SortOrder = Enum.SortOrder.LayoutOrder

    makeSection(rightScroll, "FOV CIRCLE")
    makeToggle(rightScroll, "Fov Circle", SilentAimSettings.FOVVisible, function(s)
        SilentAimSettings.FOVVisible = s
        fov_circle.Visible = s
        notify("Fov Circle " .. (s and "enabled" or "disabled"), s and Theme.ACCENT or Theme.TEXT_DIM)
    end, "Toggle the FOV circle drawing")
    makeToggle(rightScroll, "Center FOV", SilentAimSettings.FOVCenter, function(s)
        SilentAimSettings.FOVCenter = s
        notify("Center FOV " .. (s and "on" or "off"), Theme.ACCENT)
    end, "Locks to screen center")
    makeSlider(rightScroll, "Fov Circle Size", 0, 400, SilentAimSettings.FOVRadius, function(v)
        SilentAimSettings.FOVRadius = v
        fov_circle.Radius = v
        statusLabel.Text = "* idle · method: " .. SilentAimSettings.SilentAimMethod .. " · fov: " .. v
    end)

    local gunSwitchContainer
    local function refreshGunList()
        if not gunSwitchContainer then return end
        for _, c in ipairs(gunSwitchContainer:GetChildren()) do
            if c:IsA("Frame") or c:IsA("TextLabel") then c:Destroy() end
        end
        local backpack = LocalPlayer:FindFirstChildOfClass("Backpack")
        local equippedChar = LocalPlayer.Character
        for _, gunName in ipairs(FIXED_GUN_LIST) do
            local inBackpack = backpack and backpack:FindFirstChild(gunName) ~= nil
            local equipped = equippedChar and equippedChar:FindFirstChild(gunName) ~= nil
            local available = inBackpack or equipped
            local selected = table.find(SilentAimSettings.FastSwitchList, gunName) ~= nil
            local row = Instance.new("Frame", gunSwitchContainer)
            row.Size = UDim2.new(1, 0, 0, isMobile and 22 or 26)
            row.BackgroundColor3 = Theme.BG_OPT
            row.BackgroundTransparency = available and 0.08 or 0.4
            row.BorderSizePixel = 0
            Instance.new("UICorner", row).CornerRadius = UDim.new(0.24, 0)
            local rowStroke = Instance.new("UIStroke", row)
            rowStroke.Color = selected and Theme.ACCENT or Theme.BORDER
            rowStroke.Thickness = 0.5
            rowStroke.Transparency = selected and 0.3 or 0.6
            local lbl = Instance.new("TextLabel", row)
            lbl.Size = UDim2.new(1, -32, 1, 0)
            lbl.Position = UDim2.new(0, 8, 0, 0)
            lbl.BackgroundTransparency = 1
            lbl.Text = gunName .. (available and "" or " (missing)")
            lbl.TextColor3 = selected and Theme.ACCENT or (available and Theme.TEXT or Theme.TEXT_MUTED)
            lbl.Font = Enum.Font.GothamMedium
            lbl.TextSize = isMobile and 8 or 10
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            local indW2 = isMobile and 24 or 28
            local indH2 = isMobile and 12 or 14
            local dotSz2 = isMobile and 8 or 10
            local ind = Instance.new("Frame", row)
            ind.Size = UDim2.new(0, indW2, 0, indH2)
            ind.Position = UDim2.new(1, -(indW2 + 4), 0.5, -(indH2/2))
            ind.BackgroundColor3 = selected and Theme.ACCENT or Color3.fromRGB(45, 45, 55)
            ind.BorderSizePixel = 0
            Instance.new("UICorner", ind).CornerRadius = UDim.new(1, 0)
            local dot = Instance.new("Frame", ind)
            dot.Size = UDim2.new(0, dotSz2, 0, dotSz2)
            dot.Position = selected and UDim2.new(1, -(dotSz2+2), 0.5, -(dotSz2/2)) or UDim2.new(0, 2, 0.5, -(dotSz2/2))
            dot.BackgroundColor3 = Color3.fromRGB(250, 250, 250)
            dot.BorderSizePixel = 0
            Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
            local click = Instance.new("TextButton", row)
            click.Size = UDim2.new(1, 0, 1, 0)
            click.BackgroundTransparency = 1
            click.Text = ""
            click.ZIndex = 2
            click.MouseButton1Click:Connect(function()
                local found = table.find(SilentAimSettings.FastSwitchList, gunName)
                if found then
                    table.remove(SilentAimSettings.FastSwitchList, found)
                    rowStroke.Color = Theme.BORDER; rowStroke.Transparency = 0.6
                    lbl.TextColor3 = available and Theme.TEXT or Theme.TEXT_MUTED
                    TweenService:Create(dot, TweenInfo.new(0.18), {Position = UDim2.new(0, 2, 0.5, -(dotSz2/2))}):Play()
                    TweenService:Create(ind, TweenInfo.new(0.18), {BackgroundColor3 = Color3.fromRGB(45, 45, 55)}):Play()
                else
                    table.insert(SilentAimSettings.FastSwitchList, gunName)
                    rowStroke.Color = Theme.ACCENT; rowStroke.Transparency = 0.3
                    lbl.TextColor3 = Theme.ACCENT
                    TweenService:Create(dot, TweenInfo.new(0.18), {Position = UDim2.new(1, -(dotSz2+2), 0.5, -(dotSz2/2))}):Play()
                    TweenService:Create(ind, TweenInfo.new(0.18), {BackgroundColor3 = Theme.ACCENT}):Play()
                end
            end)
        end
    end

    makeSection(rightScroll, "FAST SWITCH")
    makeToggle(rightScroll, "Enable Fast Switch", SilentAimSettings.FastSwitchEnabled, function(s)
        SilentAimSettings.FastSwitchEnabled = s
        if s then startFastSwitch() else stopFastSwitch() end
        notify("Fast Switch " .. (s and "enabled" or "disabled"), s and Theme.ACCENT or Theme.TEXT_DIM)
    end, "Cycle through selected guns")
    makeKeybind(rightScroll, "Set Hotkey", SilentAimSettings.FastSwitchHotkey, function(newKey)
        SilentAimSettings.FastSwitchHotkey = newKey
        notify("Fast Switch hotkey: " .. newKey.Name, Theme.ACCENT)
    end)
    makeSlider(rightScroll, "Switch Speed x100", 1, 50, math.floor(SilentAimSettings.FastSwitchDelay * 100), function(v)
        SilentAimSettings.FastSwitchDelay = v / 100
    end)

    gunSwitchContainer = Instance.new("Frame", rightScroll)
    gunSwitchContainer.Size = UDim2.new(1, 0, 0, 10)
    gunSwitchContainer.BackgroundTransparency = 1
    gunSwitchContainer.AutomaticSize = Enum.AutomaticSize.Y
    local gsLayout = Instance.new("UIListLayout", gunSwitchContainer)
    gsLayout.Padding = UDim.new(0, isMobile and 2 or 3)
    gsLayout.SortOrder = Enum.SortOrder.LayoutOrder

    local refreshBtn = Instance.new("TextButton", rightScroll)
    refreshBtn.Size = UDim2.new(1, 0, 0, isMobile and 20 or 24)
    refreshBtn.BackgroundColor3 = Theme.BG_OPT
    refreshBtn.BackgroundTransparency = 0.08
    refreshBtn.Text = "Refresh Gun List"
    refreshBtn.TextColor3 = Theme.TEXT_DIM
    refreshBtn.Font = Enum.Font.GothamMedium
    refreshBtn.TextSize = isMobile and 8 or 9
    refreshBtn.BorderSizePixel = 0
    refreshBtn.AutoButtonColor = false
    Instance.new("UICorner", refreshBtn).CornerRadius = UDim.new(0.24, 0)
    refreshBtn.MouseButton1Click:Connect(function()
        refreshGunList()
        notify("Gun list refreshed", Theme.ACCENT)
    end)

    refreshGunList()
    local bp = LocalPlayer:FindFirstChildOfClass("Backpack")
    if bp then
        bp.ChildAdded:Connect(function() task.wait(0.1); refreshGunList() end)
        bp.ChildRemoved:Connect(function() task.wait(0.1); refreshGunList() end)
    end
    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(1)
        local bp2 = LocalPlayer:FindFirstChildOfClass("Backpack")
        if bp2 then
            bp2.ChildAdded:Connect(function() task.wait(0.1); refreshGunList() end)
            bp2.ChildRemoved:Connect(function() task.wait(0.1); refreshGunList() end)
        end
        refreshGunList()
    end)

    task.defer(function()
        rightScroll.CanvasSize = UDim2.new(0, 0, 0, rl.AbsoluteContentSize.Y + 8)
    end)
end

local currentPage = "main"
local scrollLayout = scroll:FindFirstChildOfClass("UIListLayout")

local function clearScroll()
    for _, c in ipairs(scroll:GetChildren()) do
        if c:IsA("GuiObject") or c:IsA("UIListLayout") or c:IsA("UIPadding") then c:Destroy() end
    end
    scrollLayout = Instance.new("UIListLayout", scroll)
    scrollLayout.Name = "scrollLayout"
    scrollLayout.Padding = UDim.new(0, isMobile and 4 or 7)
    scrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
end

local function buildMain()
    makeSection(scroll, "SILENT AIM")
    makeToggle(scroll, "Enabled", SilentAimSettings.Enabled, function(s)
        SilentAimSettings.Enabled = s
        mouse_box.Visible = s and SilentAimSettings.ShowSilentAimTarget
        notify("Silent Aim " .. (s and "enabled" or "disabled"), s and Theme.ACCENT or Theme.TEXT_DIM)
    end, "Master silent aim toggle")
    makeDropdown(scroll, "Target Part", {"Head", "HumanoidRootPart", "Random"}, SilentAimSettings.TargetPart, function(v) SilentAimSettings.TargetPart = v end)
    makeDropdown(scroll, "Method", {"Raycast", "FindPartOnRay", "FindPartOnRayWithWhitelist", "FindPartOnRayWithIgnoreList", "Mouse.Hit/Target"}, SilentAimSettings.SilentAimMethod, function(v)
        SilentAimSettings.SilentAimMethod = v
        statusLabel.Text = "* method: " .. v
    end)
    makeSlider(scroll, "Hit Chance", 0, 100, SilentAimSettings.HitChance, function(v) SilentAimSettings.HitChance = v end)

    makeSection(scroll, "FORCEFIELD")
    makeToggle(scroll, "Forcefield Check", SilentAimSettings.ForcefieldCheck, function(s)
        SilentAimSettings.ForcefieldCheck = s
        notify("Forcefield Check " .. (s and "on - protected players ignored" or "off"), s and Theme.ACCENT or Theme.TEXT_DIM)
    end, "Skip players with active ForceField (silent aim + autoshoot)")

    makeSection(scroll, "TARGETING MODE")
    makeDropdown(scroll, "Target Mode", {"Manual", "Hostile", "Trespassing"}, SilentAimSettings.TargetingMode, function(v)
        SilentAimSettings.TargetingMode = v
        notify("Targeting Mode: " .. v, Theme.ACCENT)
        if v == "Manual" then statusLabel.Text = "* mode: Manual (all valid players)"
        elseif v == "Hostile" then statusLabel.Text = "* mode: Hostile (Hostile attr = true)"
        elseif v == "Trespassing" then statusLabel.Text = "* mode: Trespassing (Trespassing attr = true)" end
    end)
    local modeDesc = Instance.new("TextLabel", scroll)
    modeDesc.Size = UDim2.new(1, 0, 0, isMobile and 28 or 34)
    modeDesc.BackgroundColor3 = Theme.BG_OPT
    modeDesc.BackgroundTransparency = 0.3
    modeDesc.Text = " Manual = all  |  Hostile / Trespassing = inmates with attribute"
    modeDesc.TextColor3 = Theme.TEXT_DIM
    modeDesc.Font = Enum.Font.Gotham
    modeDesc.TextSize = isMobile and 7 or 9
    modeDesc.TextXAlignment = Enum.TextXAlignment.Left
    modeDesc.TextWrapped = true
    Instance.new("UICorner", modeDesc).CornerRadius = UDim.new(0.18, 0)

    makeSection(scroll, "AUTOSHOOT")
    makeToggle(scroll, "Autoshoot", SilentAimSettings.AutoshootEnabled, function(s)
        SilentAimSettings.AutoshootEnabled = s
        notify("Autoshoot " .. (s and "enabled" or "disabled"), s and Theme.ACCENT or Theme.TEXT_DIM)
    end, "Auto fires at current silent aim target")

    makeSection(scroll, "NOCLIP PUNCH")
    makeToggle(scroll, "Noclip Punch", SilentAimSettings.NoclipPunchEnabled, function(s)
        SilentAimSettings.NoclipPunchEnabled = s
        notify("Noclip Punch " .. (s and "enabled" or "disabled"), s and Theme.ACCENT or Theme.TEXT_DIM)
    end, "Press F near a wall to clip through. Auto-stops on exit.")

    makeSection(scroll, "FILTERS")
    makeToggle(scroll, "Team Check", SilentAimSettings.TeamCheck, function(s) SilentAimSettings.TeamCheck = s end)
    makeToggle(scroll, "Visible Check", SilentAimSettings.VisibleCheck, function(s) SilentAimSettings.VisibleCheck = s end)

    makeSection(scroll, "TARGET TEAM")
    makeToggle(scroll, "Target Cop", SilentAimSettings.TargetCop, function(s)
        SilentAimSettings.TargetCop = s
        notify("Target Cop: " .. tostring(s), Theme.ACCENT)
    end, "Aim at Guards team")
    makeToggle(scroll, "Target Inmate", SilentAimSettings.TargetInmate, function(s)
        SilentAimSettings.TargetInmate = s
        notify("Target Inmate: " .. tostring(s), Theme.ACCENT)
    end, "Aim at Inmates team")
    makeToggle(scroll, "Target Criminal", SilentAimSettings.TargetCriminal, function(s)
        SilentAimSettings.TargetCriminal = s
        notify("Target Criminal: " .. tostring(s), Theme.ACCENT)
    end, "Aim at Criminals team")

    makeSection(scroll, "PREDICTION")
    makeToggle(scroll, "Mouse.Hit Prediction", SilentAimSettings.MouseHitPrediction, function(s) SilentAimSettings.MouseHitPrediction = s end)
    makeSlider(scroll, "Prediction x1000", 165, 1000, math.floor(SilentAimSettings.MouseHitPredictionAmount * 1000), function(v)
        SilentAimSettings.MouseHitPredictionAmount = v / 1000
        PredictionAmount = v / 1000
    end)
    makeToggle(scroll, "Show SA Target", SilentAimSettings.ShowSilentAimTarget, function(s)
        SilentAimSettings.ShowSilentAimTarget = s
        mouse_box.Visible = s and SilentAimSettings.Enabled
    end)

    makeSection(scroll, "WHITELIST PLAYER")
    local wlDesc = Instance.new("TextLabel", scroll)
    wlDesc.Size = UDim2.new(1, 0, 0, isMobile and 16 or 20)
    wlDesc.BackgroundTransparency = 1
    wlDesc.Text = " Toggle players to exclude from aim"
    wlDesc.TextColor3 = Theme.TEXT_DIM
    wlDesc.Font = Enum.Font.Gotham
    wlDesc.TextSize = fBody
    wlDesc.TextXAlignment = Enum.TextXAlignment.Left

    local refreshBtn = Instance.new("TextButton", scroll)
    refreshBtn.Size = UDim2.new(1, 0, 0, isMobile and 24 or 28)
    refreshBtn.BackgroundColor3 = Theme.BG_OPT
    refreshBtn.BackgroundTransparency = 0.08
    refreshBtn.Text = "Refresh Player List"
    refreshBtn.TextColor3 = Theme.TEXT_DIM
    refreshBtn.Font = Enum.Font.GothamMedium
    refreshBtn.TextSize = fBody
    refreshBtn.BorderSizePixel = 0
    refreshBtn.AutoButtonColor = false
    Instance.new("UICorner", refreshBtn).CornerRadius = UDim.new(0.22, 0)

    local wlListContainer = Instance.new("Frame", scroll)
    wlListContainer.Size = UDim2.new(1, 0, 0, 10)
    wlListContainer.BackgroundTransparency = 1
    wlListContainer.AutomaticSize = Enum.AutomaticSize.Y
    local wlListLayout = Instance.new("UIListLayout", wlListContainer)
    wlListLayout.Padding = UDim.new(0, isMobile and 2 or 4)
    wlListLayout.SortOrder = Enum.SortOrder.LayoutOrder

    rebuildWhitelistPlayerList(wlListContainer)

    refreshBtn.MouseButton1Click:Connect(function()
        rebuildWhitelistPlayerList(wlListContainer)
        notify("Player list refreshed", Theme.ACCENT)
    end)
    refreshBtn.MouseEnter:Connect(function()
        TweenService:Create(refreshBtn, TweenInfo.new(0.14), {BackgroundColor3 = Theme.BG_HOVER, BackgroundTransparency = 0, TextColor3 = Theme.TEXT}):Play()
    end)
    refreshBtn.MouseLeave:Connect(function()
        TweenService:Create(refreshBtn, TweenInfo.new(0.14), {BackgroundColor3 = Theme.BG_OPT, BackgroundTransparency = 0.08, TextColor3 = Theme.TEXT_DIM}):Play()
    end)

    Players.PlayerAdded:Connect(function()
        task.wait(0.5)
        if currentPage == "main" then rebuildWhitelistPlayerList(wlListContainer) end
    end)
    Players.PlayerRemoving:Connect(function()
        task.wait(0.1)
        if currentPage == "main" then rebuildWhitelistPlayerList(wlListContainer) end
    end)
end

local function buildESP()
    makeSection(scroll, "ESP")
    makeToggle(scroll, "Enable ESP", SilentAimSettings.ESP_Enabled, function(s)
        SilentAimSettings.ESP_Enabled = s
        notify("ESP " .. (s and "enabled" or "disabled"), s and Theme.ACCENT or Theme.TEXT_DIM)
    end, "Master ESP toggle")
    makeToggle(scroll, "Team Colors", SilentAimSettings.ESP_Team, function(s)
        SilentAimSettings.ESP_Team = s
        notify("Team colors " .. (s and "on" or "off"), Theme.ACCENT)
    end, "Highlight and trace use team colors")

    makeSection(scroll, "ESP ELEMENTS")
    makeToggle(scroll, "Highlight", SilentAimSettings.ESP_Highlight, function(s) SilentAimSettings.ESP_Highlight = s end)
    makeToggle(scroll, "Name", SilentAimSettings.ESP_Name, function(s) SilentAimSettings.ESP_Name = s end)
    makeToggle(scroll, "Health Bar", SilentAimSettings.ESP_Health, function(s) SilentAimSettings.ESP_Health = s end)
    makeToggle(scroll, "Trace Line", SilentAimSettings.ESP_Trace, function(s) SilentAimSettings.ESP_Trace = s end)

    makeSection(scroll, "ESP RANGE")
    makeSlider(scroll, "Max Distance", 100, 3000, SilentAimSettings.ESP_MaxDistance, function(v) SilentAimSettings.ESP_MaxDistance = v end)
end

local function buildVisuals()
    makeSection(scroll, "PLAYER SETTINGS")
    makeToggle(scroll, "Noclip", SilentAimSettings.NoclipEnabled, function(s)
        SilentAimSettings.NoclipEnabled = s
        if s then startNoclip() else stopNoclip() end
        notify("Noclip " .. (s and "enabled" or "disabled"), s and Theme.ACCENT or Theme.TEXT_DIM)
    end, "Walk through parts")
    makeSlider(scroll, "Speed", 8, 200, SilentAimSettings.SpeedValue, function(v)
        SilentAimSettings.SpeedValue = v
        applySpeed(v)
    end)
    makeSlider(scroll, "Jump Power", 50, 500, SilentAimSettings.JumpPowerValue, function(v)
        SilentAimSettings.JumpPowerValue = v
        applyJumpPower(v)
    end)
    makeToggle(scroll, "Invisible", SilentAimSettings.InvisibleEnabled, function(s)
        SilentAimSettings.InvisibleEnabled = s
        if s then startInvisible() else stopInvisible() end
        notify("Invisible " .. (s and "enabled" or "disabled"), s and Theme.ACCENT or Theme.TEXT_DIM)
    end, "Hide your character")

    makeSection(scroll, "VISUAL")
    makeToggle(scroll, "Korblox", SilentAimSettings.KorbloxEnabled, function(s)
        SilentAimSettings.KorbloxEnabled = s
        local char = LocalPlayer.Character
        if s and char then applyKorblox(char) end
        notify("Korblox " .. (s and "enabled" or "disabled"), s and Theme.ACCENT or Theme.TEXT_DIM)
    end, "Apply korblox leg mesh")
    makeToggle(scroll, "Headless", SilentAimSettings.HeadlessEnabled, function(s)
        SilentAimSettings.HeadlessEnabled = s
        local char = LocalPlayer.Character
        if s and char then applyHeadless(char) end
        notify("Headless " .. (s and "enabled" or "disabled"), s and Theme.ACCENT or Theme.TEXT_DIM)
    end, "Apply headless mesh")
end

local function updateThemeColors()
    mainGlow.Color = Theme.ACCENT
    hubGlow.Color = Theme.ACCENT
    mouse_box.Color = Theme.ACCENT
    fov_circle.Color = RING_IDLE_COLOR
    contentHeader.TextColor3 = Theme.ACCENT
    rightHeader.TextColor3 = Theme.ACCENT
    icon.TextColor3 = Theme.ACCENT
    accentLine.BackgroundColor3 = Theme.ACCENT
    customCursor.ImageColor3 = Theme.ACCENT
end

local MainFileName = "UniversalSilentAim"
local FileToSave = ""

do
    if not isfolder(MainFileName) then makefolder(MainFileName) end
    local sub = MainFileName .. "/" .. tostring(game.PlaceId)
    if not isfolder(sub) then makefolder(sub) end
end

local Files = listfiles(MainFileName .. "/" .. tostring(game.PlaceId))

local function GetFiles()
    local out = {}
    for i = 1, #Files do
        local file = Files[i]
        if file:sub(-4) == ".lua" then
            local pos = file:find(".lua", 1, true)
            local start = pos
            local ch = file:sub(pos, pos)
            while ch ~= "/" and ch ~= "\\" and ch ~= "" do
                pos = pos - 1
                ch = file:sub(pos, pos)
            end
            if ch == "/" or ch == "\\" then table.insert(out, file:sub(pos + 1, start - 1)) end
        end
    end
    return out
end

local function UpdateFile(FileName)
    writefile(MainFileName .. "/" .. tostring(game.PlaceId) .. "/" .. FileName .. ".lua", HttpService:JSONEncode(SilentAimSettings))
end

local function LoadFile(FileName)
    local data = HttpService:JSONDecode(readfile(MainFileName .. "/" .. tostring(game.PlaceId) .. "/" .. FileName .. ".lua"))
    for k, v in next, data do SilentAimSettings[k] = v end
end

local function makeInput(parent, placeholder, callback)
    local box = Instance.new("TextBox", parent)
    box.Size = UDim2.new(1, 0, 0, ROW_H)
    box.BackgroundColor3 = Theme.BG_OPT
    box.BackgroundTransparency = 0.08
    box.PlaceholderText = placeholder
    box.Text = ""
    box.TextColor3 = Theme.TEXT
    box.PlaceholderColor3 = Theme.TEXT_DIM
    box.Font = Enum.Font.GothamMedium
    box.TextSize = fBody
    box.BorderSizePixel = 0
    Instance.new("UICorner", box).CornerRadius = UDim.new(0.22, 0)
    local stroke = Instance.new("UIStroke", box)
    stroke.Color = Theme.BORDER
    stroke.Thickness = 0.5
    stroke.Transparency = 0.6
    box.Focused:Connect(function()
        TweenService:Create(stroke, TweenInfo.new(0.15), {Transparency = 0.1, Color = Theme.ACCENT}):Play()
    end)
    box.FocusLost:Connect(function()
        TweenService:Create(stroke, TweenInfo.new(0.15), {Transparency = 0.6, Color = Theme.BORDER}):Play()
        callback(box.Text)
    end)
end

local function buildConfig()
    makeSection(scroll, "SAVE / LOAD")
    makeInput(scroll, "File name...", function(name)
        if name and name ~= "" then
            FileToSave = name
            notify("Config name set: " .. name, Theme.ACCENT)
        end
    end)
    makeButton(scroll, "Create Config File", function()
        if FileToSave ~= "" then
            UpdateFile(FileToSave)
            notify("Created: " .. FileToSave, Theme.ACCENT)
        end
    end)

    makeSection(scroll, "EXISTING CONFIGS")
    local files = GetFiles()
    if #files == 0 then
        local empty = Instance.new("TextLabel", scroll)
        empty.Size = UDim2.new(1, 0, 0, isMobile and 20 or 24)
        empty.BackgroundTransparency = 1
        empty.Text = " no configs found"
        empty.TextColor3 = Theme.TEXT_DIM
        empty.Font = Enum.Font.Gotham
        empty.TextSize = fBody
        empty.TextXAlignment = Enum.TextXAlignment.Left
    else
        for _, name in ipairs(files) do
            makeButton(scroll, "Load: " .. name, function() LoadFile(name); notify("Loaded: " .. name, Theme.ACCENT) end)
            makeButton(scroll, "Save: " .. name, function() UpdateFile(name); notify("Saved: " .. name, Theme.ACCENT) end)
        end
    end

    makeSection(scroll, "ACCENT COLORS")
    makeButton(scroll, "Pink (Default)", function()
        Theme.ACCENT = Color3.fromRGB(255, 182, 193)
        Theme.ACCENT_LIGHT = Color3.fromRGB(255, 200, 220)
        Theme.GRADIENT_2 = Color3.fromRGB(220, 160, 200)
        updateThemeColors()
        notify("Accent: Pink", Theme.ACCENT)
    end)
    makeButton(scroll, "Blue", function()
        Theme.ACCENT = Color3.fromRGB(140, 180, 255)
        Theme.ACCENT_LIGHT = Color3.fromRGB(170, 200, 255)
        Theme.GRADIENT_2 = Color3.fromRGB(180, 150, 255)
        updateThemeColors()
        notify("Accent: Blue", Theme.ACCENT)
    end)
    makeButton(scroll, "Green", function()
        Theme.ACCENT = Color3.fromRGB(140, 255, 180)
        Theme.ACCENT_LIGHT = Color3.fromRGB(170, 255, 200)
        Theme.GRADIENT_2 = Color3.fromRGB(150, 240, 180)
        updateThemeColors()
        notify("Accent: Green", Theme.ACCENT)
    end)
    makeButton(scroll, "Purple", function()
        Theme.ACCENT = Color3.fromRGB(200, 140, 255)
        Theme.ACCENT_LIGHT = Color3.fromRGB(220, 170, 255)
        Theme.GRADIENT_2 = Color3.fromRGB(255, 150, 220)
        updateThemeColors()
        notify("Accent: Purple", Theme.ACCENT)
    end)
end

local function buildInfo()
    makeSection(scroll, "INFO")
    local info = Instance.new("TextLabel", scroll)
    info.Size = UDim2.new(1, 0, 0, 600)
    info.BackgroundColor3 = Theme.BG_OPT
    info.BackgroundTransparency = 0.08
    info.TextColor3 = Theme.TEXT
    info.Font = Enum.Font.Gotham
    info.TextSize = isMobile and 8 or 10
    info.TextWrapped = true
    info.TextXAlignment = Enum.TextXAlignment.Left
    info.TextYAlignment = Enum.TextYAlignment.Top
    info.Text = [[
 SPENT HUB

 HIGHLIGHT ESP FIXED
  Highlight now uses DepthMode.AlwaysOnTop
  so it shows through walls in every view.
  No more flicker — set once, stable.

 SILENT AIM
  RightAlt toggles.
  Hit chance rolls capped at 15hz.

 FOV CIRCLE (right dock)
  Fov Circle / Center FOV / Size

 FAST SWITCH (right dock)
  Hotkey default H.
  Gun list taps to include/exclude.

 NOCLIP PUNCH
  Toggle then press F near a wall.

 VISUALS tab
  Noclip / Speed / Jump Power / Invisible
  Korblox / Headless

 KEYBINDS
  RAlt   toggle silent aim
  RShift show/hide hub
  END    unload
  F      noclip punch
]]
    Instance.new("UICorner", info).CornerRadius = UDim.new(0.08, 0)
    local infoStroke = Instance.new("UIStroke", info)
    infoStroke.Color = Theme.BORDER
    infoStroke.Thickness = 0.5
    infoStroke.Transparency = 0.6
end

local tabs = {
    {name = "Main",    page = "main",    build = buildMain},
    {name = "ESP",     page = "esp",     build = buildESP},
    {name = "Visuals", page = "visuals", build = buildVisuals},
    {name = "Config",  page = "config",  build = buildConfig},
    {name = "Info",    page = "info",    build = buildInfo},
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
            TweenService:Create(b.btn, TweenInfo.new(0.22), {BackgroundColor3 = Theme.ACCENT, TextColor3 = Theme.BG_MAIN}):Play()
        else
            TweenService:Create(b.btn, TweenInfo.new(0.22), {BackgroundColor3 = Theme.BG_OPT, TextColor3 = Theme.TEXT}):Play()
        end
    end
    for _, u in ipairs(tabUnderlines) do u.frame.Visible = (u.page == page) end
    task.defer(function()
        if scrollLayout then scroll.CanvasSize = UDim2.new(0, 0, 0, scrollLayout.AbsoluteContentSize.Y + 20) end
    end)
end

for _, t in ipairs(tabs) do
    local holder = Instance.new("Frame", sidebar)
    holder.Size = UDim2.new(1, 0, 0, isMobile and 26 or 32)
    holder.BackgroundTransparency = 1
    holder.Name = t.name
    local btn = Instance.new("TextButton", holder)
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundColor3 = Theme.BG_OPT
    btn.BackgroundTransparency = 0.08
    btn.Text = t.name
    btn.TextColor3 = Theme.TEXT
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = isMobile and 9 or 11
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    btn.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0.24, 0)
    local pad = Instance.new("UIPadding", btn)
    pad.PaddingLeft = UDim.new(0, 10)
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Theme.BORDER
    stroke.Thickness = 0.5
    stroke.Transparency = 0.6
    local underline = Instance.new("Frame", holder)
    underline.Size = UDim2.new(0, 3, 1, -6)
    underline.Position = UDim2.new(0, 2, 0, 3)
    underline.BackgroundColor3 = Theme.ACCENT
    underline.BorderSizePixel = 0
    underline.Visible = false
    Instance.new("UICorner", underline).CornerRadius = UDim.new(1, 0)
    btn.MouseButton1Click:Connect(function() selectTab(t.page) end)
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.16), {BackgroundTransparency = 0, BackgroundColor3 = Theme.BG_HOVER, TextColor3 = Theme.TEXT_STRONG}):Play()
        TweenService:Create(stroke, TweenInfo.new(0.16), {Transparency = 0.2}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.16), {BackgroundTransparency = 0.08, BackgroundColor3 = Theme.BG_OPT, TextColor3 = Theme.TEXT}):Play()
        TweenService:Create(stroke, TweenInfo.new(0.16), {Transparency = 0.6}):Play()
    end)
    table.insert(tabButtons, {btn = btn, page = t.page})
    table.insert(tabUnderlines, {frame = underline, page = t.page})
end

buildFovDock()

local openState = "idle"
local activeOpenTweens, activeCloseTweens = {}, {}

local function cancelTweens(list)
    for _, tw in ipairs(list) do pcall(function() tw:Cancel() end) end
    table.clear(list)
end

local baseMainSize = UDim2.new(0, UI.mainW, 0, UI.mainH)
local baseMainPos = UDim2.new(0.5, UI.mainPosX, 0.5, UI.mainPosY)
local baseShadowSize = UDim2.new(0, UI.mainW + 10, 0, UI.mainH + 10)
local baseShadowPos = UDim2.new(0.5, UI.mainPosX - 5, 0.5, UI.mainPosY - 5)

local function playOpen()
    if openState == "opening" or openState == "open" then return end
    openState = "opening"
    cancelTweens(activeCloseTweens); cancelTweens(activeOpenTweens)
    main.Visible = true; shadow.Visible = true; bgBlur.Visible = true
    main.Size = UDim2.new(0, UI.mainW * 0.90, 0, UI.mainH * 0.90)
    main.Position = baseMainPos + UDim2.new(0, 18, 0, 25)
    main.BackgroundTransparency = 1
    mainGlow.Transparency = 1; mainStroke.Transparency = 1
    shadow.BackgroundTransparency = 1
    bgBlur.BackgroundTransparency = 1
    icon.TextTransparency = 1; title.TextTransparency = 1

    table.insert(activeOpenTweens, TweenService:Create(main, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0.05}))
    table.insert(activeOpenTweens, TweenService:Create(mainStroke, TweenInfo.new(0.25), {Transparency = 0.5}))
    table.insert(activeOpenTweens, TweenService:Create(shadow, TweenInfo.new(0.3), {BackgroundTransparency = 0.6}))
    table.insert(activeOpenTweens, TweenService:Create(bgBlur, TweenInfo.new(0.3), {BackgroundTransparency = 0.55}))
    table.insert(activeOpenTweens, TweenService:Create(main, TweenInfo.new(0.28, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, UI.mainW * 1.05, 0, UI.mainH * 1.05),
        Position = baseMainPos + UDim2.new(0, -UI.mainW * 0.025, 0, -UI.mainH * 0.025),
    }))
    task.delay(0.28, function()
        if openState ~= "opening" and openState ~= "open" then return end
        TweenService:Create(main, TweenInfo.new(0.18, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = baseMainSize, Position = baseMainPos}):Play()
        TweenService:Create(shadow, TweenInfo.new(0.18), {Size = baseShadowSize, Position = baseShadowPos}):Play()
        TweenService:Create(bgBlur, TweenInfo.new(0.18), {Size = baseShadowSize, Position = baseShadowPos}):Play()
    end)
    table.insert(activeOpenTweens, TweenService:Create(mainGlow, TweenInfo.new(0.22), {Transparency = 0.35}))
    task.delay(0.22, function()
        if openState ~= "opening" and openState ~= "open" then return end
        TweenService:Create(mainGlow, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0.88}):Play()
    end)
    table.insert(activeOpenTweens, TweenService:Create(icon, TweenInfo.new(0.28), {TextTransparency = 0}))
    table.insert(activeOpenTweens, TweenService:Create(title, TweenInfo.new(0.28), {TextTransparency = 0}))

    if hubToggleBtn.Visible then
        TweenService:Create(hubToggleBtn, TweenInfo.new(0.14), {Size = UDim2.new(0, 62, 0, 62)}):Play()
        task.delay(0.14, function()
            TweenService:Create(hubToggleBtn, TweenInfo.new(0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0), TextTransparency = 1, BackgroundTransparency = 1}):Play()
            task.wait(0.22)
            pcall(function() hubToggleBtn.Visible = false end)
        end)
    end
    for _, tw in ipairs(activeOpenTweens) do tw:Play() end
    task.delay(0.7, function() if openState == "opening" then openState = "open" end end)
end

local function playClose()
    if openState == "closing" or openState == "closed" then return end
    local wasOpen = openState == "open" or openState == "opening" or openState == "idle"
    openState = "closing"
    cancelTweens(activeOpenTweens); cancelTweens(activeCloseTweens)

    task.delay(0.16, function()
        if openState ~= "closing" then return end
        TweenService:Create(main, TweenInfo.new(0.12), {Size = UDim2.new(0, UI.mainW * 1.04, 0, UI.mainH * 1.04), Position = main.Position + UDim2.new(0, -UI.mainW * 0.02, 0, -UI.mainH * 0.02)}):Play()
        task.delay(0.12, function()
            if openState ~= "closing" then return end
            TweenService:Create(main, TweenInfo.new(0.28, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
                Size = UDim2.new(0, UI.mainW * 0.87, 0, UI.mainH * 0.87),
                Position = baseMainPos + UDim2.new(0, UI.mainW * 0.065, 0, 25),
                BackgroundTransparency = 1,
            }):Play()
            TweenService:Create(shadow, TweenInfo.new(0.28), {BackgroundTransparency = 1}):Play()
            TweenService:Create(bgBlur, TweenInfo.new(0.28), {BackgroundTransparency = 1}):Play()
            TweenService:Create(mainGlow, TweenInfo.new(0.26), {Transparency = 1}):Play()
            TweenService:Create(mainStroke, TweenInfo.new(0.26), {Transparency = 1}):Play()
        end)
    end)
    task.delay(0.3, function()
        if not wasOpen then return end
        hubToggleBtn.Visible = true
        hubToggleBtn.Size = UDim2.new(0, 0, 0, 0)
        hubToggleBtn.TextTransparency = 1
        hubToggleBtn.BackgroundTransparency = 1
        TweenService:Create(hubToggleBtn, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, isMobile and 48 or 58, 0, isMobile and 48 or 58),
            TextTransparency = 0, BackgroundTransparency = 0.15,
        }):Play()
        task.delay(0.2, function()
            TweenService:Create(hubToggleBtn, TweenInfo.new(0.16), {Size = UDim2.new(0, isMobile and 42 or 50, 0, isMobile and 42 or 50)}):Play()
        end)
    end)
    task.delay(0.5, function()
        if openState ~= "closing" then return end
        main.Visible = false; shadow.Visible = false; bgBlur.Visible = false
        main.BackgroundTransparency = 0.05
        main.Size = baseMainSize; main.Position = baseMainPos
        shadow.Size = baseShadowSize; shadow.Position = baseShadowPos
        bgBlur.Size = baseShadowSize; bgBlur.Position = baseShadowPos
        mainGlow.Transparency = 0.88; mainStroke.Transparency = 0.5
        openState = "closed"
    end)
end

hubToggleBtn.MouseButton1Click:Connect(function() playOpen() end)
closeBtn.MouseButton1Click:Connect(function() playClose() end)

local isCompact = false
compactBtn.MouseButton1Click:Connect(function()
    isCompact = not isCompact
    local targetH = isCompact and (isMobile and 32 or 40) or UI.mainH
    TweenService:Create(main, TweenInfo.new(0.28, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, UI.mainW, 0, targetH)}):Play()
    compactBtn.Text = isCompact and "+" or "-"
end)

local _origPlayOpen = playOpen
playOpen = function()
    isCompact = false
    compactBtn.Text = "-"
    _origPlayOpen()
end

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

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.RightAlt then
        SilentAimSettings.Enabled = not SilentAimSettings.Enabled
        notify("Silent Aim " .. (SilentAimSettings.Enabled and "enabled" or "disabled"), Theme.ACCENT)
    end
    if input.KeyCode == Enum.KeyCode.RightShift then
        if main.Visible then playClose() else playOpen() end
    end
    if input.KeyCode == SilentAimSettings.FastSwitchHotkey then
        SilentAimSettings.FastSwitchEnabled = not SilentAimSettings.FastSwitchEnabled
        if SilentAimSettings.FastSwitchEnabled then startFastSwitch() else stopFastSwitch() end
        notify("Fast Switch " .. (SilentAimSettings.FastSwitchEnabled and "enabled" or "disabled"), Theme.ACCENT)
    end
    if input.KeyCode == Enum.KeyCode.F and SilentAimSettings.NoclipPunchEnabled then
        doNoclipPunch()
    end
    if input.KeyCode == Enum.KeyCode.End then
        UserInputService.MouseIconEnabled = originalMouseIconEnabled
        pcall(function() cursorGui:Destroy() end)
        if cursorConnection then cursorConnection:Disconnect() end
        
        pcall(function() gui:Destroy() end)
        pcall(function() fov_circle:Remove() end)
        pcall(function() mouse_box:Remove() end)
        stopNoclip()
        stopNoclipPunch()
        stopInvisible()
        stopFastSwitch()
        for _, p in ipairs(Players:GetPlayers()) do removeESPData(p) end
        print("SPENT HUB unloaded.")
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

selectTab("main")
main.Visible = true
shadow.Visible = true
bgBlur.Visible = true
openState = "open"
notify("SPENT HUB loaded", Theme.ACCENT)
task.delay(0.5, function()
    notify("Highlight ESP fixed — shows through walls", Theme.ACCENT)
end)
task.delay(1.0, function()
    notify("RAlt aim · RShift hub · F punch · END unload", Theme.TEXT_DIM)
end)
print("SPENT HUB loaded.")
