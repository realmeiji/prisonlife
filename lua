if not game:IsLoaded() then game.Loaded:Wait() end
if not syn or not protectgui then getgenv().protectgui = function() end end

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local Debris = game:GetService("Debris")
local SoundService = game:GetService("SoundService")

local IS_MOBILE = UserInputService and UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

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
Instance.new("UICorner", startupFrame).CornerRadius = UDim.new(0, 10)

local startupStroke = Instance.new("UIStroke", startupFrame)
startupStroke.Color = Color3.fromRGB(255, 192, 203)
startupStroke.Thickness = 1.25
startupStroke.Transparency = 0.15

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
    KorbloxEnabled = false, HeadlessEnabled = false,
    FastSwitchEnabled = false, FastSwitchDelay = 0.05,
    FastSwitchList = {"M9", "Revolver", "Remington 870", "MP5", "M4A1", "M700", "AK-47"},
    RemoveFog = false, CustomSkybox = false, SkyboxName = "None", WorldGradient = false,
    ReloadShuffleKey = "None",
    Hotkeys = {},
}
getgenv().SilentAimSettings = SilentAimSettings

local Camera = workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()
local GetPlayers = Players.GetPlayers
local WorldToScreen = Camera.WorldToScreenPoint
local WorldToViewportPoint = Camera.WorldToViewportPoint
local GetPartsObscuringTarget = Camera.GetPartsObscuringTarget
local FindFirstChild = game.FindFirstChild
local RenderStepped = RunService.RenderStepped
local GetMouseLocation = UserInputService.GetMouseLocation

local ValidTargetParts = { "Head", "HumanoidRootPart", "LeftArm", "RightArm", "LeftLeg", "RightLeg" }
local TARGET_PART_ALIASES = {
    Head = { "Head" },
    HumanoidRootPart = { "HumanoidRootPart" },
    LeftArm = { "Left Arm", "LeftUpperArm", "LeftLowerArm", "LeftHand" },
    RightArm = { "Right Arm", "RightUpperArm", "RightLowerArm", "RightHand" },
    LeftLeg = { "Left Leg", "LeftUpperLeg", "LeftLowerLeg", "LeftFoot" },
    RightLeg = { "Right Leg", "RightUpperLeg", "RightLowerLeg", "RightFoot" },
}

local function resolveTargetPart(character, partName)
    if not character or not partName then return nil end
    if partName == "Random" then
        local order = { unpack(ValidTargetParts) }
        for i = #order, 2, -1 do
            local j = math.random(1, i)
            order[i], order[j] = order[j], order[i]
        end
        for _, logical in ipairs(order) do
            local p = resolveTargetPart(character, logical)
            if p then return p end
        end
        return character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Head")
    end
    local aliases = TARGET_PART_ALIASES[partName]
    if aliases then
        for _, name in ipairs(aliases) do
            local p = character:FindFirstChild(name)
            if p then return p end
        end
        return nil
    end
    return character:FindFirstChild(partName)
end

local originalMouseIconEnabled = UserInputService.MouseIconEnabled
if not IS_MOBILE then UserInputService.MouseIconEnabled = false end

local HAS_DRAWING = false
pcall(function()
    if typeof(Drawing) == "table" and typeof(Drawing.new) == "function" then
        local ok, test = pcall(Drawing.new, "Circle")
        if ok and test then
            HAS_DRAWING = true
            pcall(function() test:Remove() end)
        end
    end
end)

local function _mkDraw(className)
    if HAS_DRAWING then
        local ok, o = pcall(Drawing.new, className)
        if ok and o then return o end
    end
    local d = { Visible = false, Color = Color3.new(1,1,1), Thickness = 1, Radius = 3, Position = Vector2.new(), NumSides = 24, Filled = false, Transparency = 1, ZIndex = 100, Size = Vector2.new(), Text = "", From = Vector2.new(), To = Vector2.new(), Font = 2, Center = true, Outline = true }
    function d:Remove() end
    function d:Destroy() end
    return d
end

local fov_circle = _mkDraw("Circle")
fov_circle.Thickness = 1.5
fov_circle.NumSides = 100
fov_circle.Radius = 130
fov_circle.Filled = false
fov_circle.Visible = false
fov_circle.ZIndex = 999
fov_circle.Transparency = 0.9
fov_circle.Color = Color3.fromRGB(255, 255, 255)

local ExpectedArguments = {
    FindPartOnRayWithIgnoreList = { ArgCountRequired = 3, Args = { "Instance", "Ray", "table", "boolean", "boolean" } },
    FindPartOnRayWithWhitelist = { ArgCountRequired = 3, Args = { "Instance", "Ray", "table", "boolean" } },
    FindPartOnRay = { ArgCountRequired = 2, Args = { "Instance", "Ray", "Instance", "boolean", "boolean" } },
    Raycast = { ArgCountRequired = 3, Args = { "Instance", "Vector3", "Vector3", "RaycastParams" } },
}

local function ValidateArguments(Args, RayMethod)
    local n = 0
    if #Args < RayMethod.ArgCountRequired then return false end
    for Pos, Argument in next, Args do
        if typeof(Argument) == RayMethod.Args[Pos] then n = n + 1 end
    end
    return n >= RayMethod.ArgCountRequired
end

local _rng = Random.new()
local _shotRollExpire, _shotRollResult = 0, false
local SHOT_ROLL_WINDOW = 0.07

local function getEffectiveHitChance()
    local base = tonumber(SilentAimSettings.HitChance) or 100
    if base >= 100 then return 100 end
    if base <= 0 then return 0 end
    return math.clamp(base, 0, 100)
end

local function CalculateChance()
    local now = tick()
    if now < _shotRollExpire then return _shotRollResult end
    local pct = getEffectiveHitChance()
    if pct >= 100 then _shotRollResult = true
    elseif pct <= 0 then _shotRollResult = false
    else _shotRollResult = _rng:NextNumber(0, 100) < pct end
    _shotRollExpire = now + SHOT_ROLL_WINDOW
    return _shotRollResult
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

local function getClosestPlayer()
    if not SilentAimSettings.TargetPart then return end
    local Closest, DistanceToMouse
    local origin = getAimOrigin()
    for _, Player in next, GetPlayers(Players) do
        if Player == LocalPlayer then continue end
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
            if not partInstance then continue end
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
        return LocalPlayer.PlayerGui:WaitForChild("Home", 3):WaitForChild("hud", 3):WaitForChild("BottomRightFrame", 3):WaitForChild("GunFrame", 3)
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
    if not CalculateChance() then return end
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
    local step = math.max(0.02, 0.3 / n)
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
        notify("Reload Shuffle · " .. tostring(n) .. " guns · 0.3s")
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
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "SpentHubUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    
    local main = Instance.new("Frame", screenGui)
    main.Size = UDim2.new(0, 720, 0, 480)
    main.Position = UDim2.new(0.5, -360, 0.5, -240)
    main.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
    main.BorderSizePixel = 0
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)
    local mainStroke = Instance.new("UIStroke", main)
    mainStroke.Color = Color3.fromRGB(255, 182, 193)
    mainStroke.Thickness = 1.5
    
    local topbar = Instance.new("Frame", main)
    topbar.Size = UDim2.new(1, 0, 0, 36)
    topbar.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
    topbar.BorderSizePixel = 0
    Instance.new("UICorner", topbar).CornerRadius = UDim.new(0, 10)
    
    local icon = Instance.new("ImageLabel", topbar)
    icon.Size = UDim2.new(0, 24, 0, 24)
    icon.Position = UDim2.new(0, 10, 0.5, -12)
    icon.BackgroundTransparency = 1
    icon.Image = "rbxassetid://" .. HUB_ICON_ASSET_ID
    
    local title = Instance.new("TextLabel", topbar)
    title.Size = UDim2.new(0, 200, 1, 0)
    title.Position = UDim2.new(0, 40, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "SPENT HUB · PRECISION"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 14
    title.TextXAlignment = Enum.TextXAlignment.Left
    
    local sidebar = Instance.new("Frame", main)
    sidebar.Size = UDim2.new(0, 150, 1, -36)
    sidebar.Position = UDim2.new(0, 0, 0, 36)
    sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
    sidebar.BorderSizePixel = 0
    
    local content = Instance.new("Frame", main)
    content.Size = UDim2.new(1, -150, 1, -36)
    content.Position = UDim2.new(0, 150, 0, 36)
    content.BackgroundTransparency = 1
    
    -- Info Page (1000000x better)
    local infoPage = Instance.new("ScrollingFrame", content)
    infoPage.Size = UDim2.new(1, 0, 1, 0)
    infoPage.BackgroundTransparency = 1
    infoPage.ScrollBarThickness = 2
    infoPage.ScrollBarImageColor3 = Color3.fromRGB(255, 182, 193)
    infoPage.CanvasSize = UDim2.new(0, 0, 1.5, 0)
    
    local profileCard = Instance.new("Frame", infoPage)
    profileCard.Size = UDim2.new(0.95, 0, 0, 100)
    profileCard.Position = UDim2.new(0.025, 0, 0, 10)
    profileCard.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
    profileCard.BorderSizePixel = 0
    Instance.new("UICorner", profileCard).CornerRadius = UDim.new(0, 8)
    
    local head = Instance.new("ImageLabel", profileCard)
    head.Size = UDim2.new(0, 70, 0, 70)
    head.Position = UDim2.new(0, 15, 0.5, -35)
    head.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    Instance.new("UICorner", head).CornerRadius = UDim.new(1, 0)
    task.spawn(function()
        local ok, content = pcall(function() return Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420) end)
        if ok and content then head.Image = content end
    end)
    
    local dispName = Instance.new("TextLabel", profileCard)
    dispName.Size = UDim2.new(1, -110, 0, 24)
    dispName.Position = UDim2.new(0, 100, 0, 15)
    dispName.BackgroundTransparency = 1
    dispName.Text = LocalPlayer.DisplayName
    dispName.TextColor3 = Color3.fromRGB(255, 182, 193)
    dispName.Font = Enum.Font.GothamBold
    dispName.TextSize = 18
    dispName.TextXAlignment = Enum.TextXAlignment.Left
    
    local userName = Instance.new("TextLabel", profileCard)
    userName.Size = UDim2.new(1, -110, 0, 16)
    userName.Position = UDim2.new(0, 100, 0, 40)
    userName.BackgroundTransparency = 1
    userName.Text = "@" .. LocalPlayer.Name .. " · " .. LocalPlayer.UserId
    userName.TextColor3 = Color3.fromRGB(150, 150, 160)
    userName.Font = Enum.Font.Gotham
    userName.TextSize = 12
    userName.TextXAlignment = Enum.TextXAlignment.Left
    
    local brand = Instance.new("TextLabel", profileCard)
    brand.Size = UDim2.new(1, -110, 0, 16)
    brand.Position = UDim2.new(0, 100, 0, 58)
    brand.BackgroundTransparency = 1
    brand.Text = "SPENT HUB · made by spent"
    brand.TextColor3 = Color3.fromRGB(255, 255, 255)
    brand.Font = Enum.Font.GothamMedium
    brand.TextSize = 12
    brand.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Stats Grid
    local statsFrame = Instance.new("Frame", infoPage)
    statsFrame.Size = UDim2.new(0.95, 0, 0, 80)
    statsFrame.Position = UDim2.new(0.025, 0, 0, 120)
    statsFrame.BackgroundTransparency = 1
    
    local function makeStatCard(title, val, xPos)
        local card = Instance.new("Frame", statsFrame)
        card.Size = UDim2.new(0.31, 0, 1, 0)
        card.Position = UDim2.new(xPos, 0, 0, 0)
        card.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
        card.BorderSizePixel = 0
        Instance.new("UICorner", card).CornerRadius = UDim.new(0, 6)
        
        local t = Instance.new("TextLabel", card)
        t.Size = UDim2.new(1, 0, 0, 20)
        t.Position = UDim2.new(0, 0, 0, 10)
        t.BackgroundTransparency = 1
        t.Text = title
        t.TextColor3 = Color3.fromRGB(150, 150, 160)
        t.Font = Enum.Font.GothamBold
        t.TextSize = 10
        
        local v = Instance.new("TextLabel", card)
        v.Size = UDim2.new(1, 0, 0, 30)
        v.Position = UDim2.new(0, 0, 0, 35)
        v.BackgroundTransparency = 1
        v.Text = val
        v.TextColor3 = Color3.fromRGB(255, 255, 255)
        v.Font = Enum.Font.GothamBold
        v.TextSize = 18
        return v
    end
    
    local uptimeVal = makeStatCard("UPTIME", "00:00", 0)
    local pingVal = makeStatCard("PING", "0 ms", 0.345)
    local timeVal = makeStatCard("LOCAL TIME", os.date("%H:%M"), 0.69)
    
    -- Main Features Page
    local mainPage = Instance.new("ScrollingFrame", content)
    mainPage.Size = UDim2.new(1, 0, 1, 0)
    mainPage.BackgroundTransparency = 1
    mainPage.Visible = false
    mainPage.ScrollBarThickness = 2
    mainPage.ScrollBarImageColor3 = Color3.fromRGB(255, 182, 193)
    mainPage.CanvasSize = UDim2.new(0, 0, 2, 0)
    
    -- Simple toggle function
    local function addToggle(parent, text, default, callback)
        local btn = Instance.new("TextButton", parent)
        btn.Size = UDim2.new(1, -20, 0, 30)
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
        btn.BorderSizePixel = 0
        btn.Text = "   " .. text
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 12
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.AutoButtonColor = false
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
        
        local indicator = Instance.new("Frame", btn)
        indicator.Size = UDim2.new(0, 16, 0, 16)
        indicator.Position = UDim2.new(1, -24, 0.5, -8)
        indicator.BackgroundColor3 = default and Color3.fromRGB(255, 182, 193) or Color3.fromRGB(50, 50, 60)
        Instance.new("UICorner", indicator).CornerRadius = UDim.new(1, 0)
        
        local state = default
        btn.MouseButton1Click:Connect(function()
            state = not state
            indicator.BackgroundColor3 = state and Color3.fromRGB(255, 182, 193) or Color3.fromRGB(50, 50, 60)
            if callback then callback(state) end
        end)
        return btn
    end
    
    local y = 10
    local sa = addToggle(mainPage, "Silent Aim", SilentAimSettings.Enabled, function(v) SilentAimSettings.Enabled = v end)
    sa.Position = UDim2.new(0.025, 0, 0, y) y = y + 35
    local au = addToggle(mainPage, "Autoshoot", SilentAimSettings.AutoshootEnabled, function(v) SilentAimSettings.AutoshootEnabled = v end)
    au.Position = UDim2.new(0.025, 0, 0, y) y = y + 35
    local fs = addToggle(mainPage, "Fast Switch", SilentAimSettings.FastSwitchEnabled, function(v) SilentAimSettings.FastSwitchEnabled = v if v then startFastSwitch() else stopFastSwitch() end end)
    fs.Position = UDim2.new(0.025, 0, 0, y) y = y + 35
    local esp = addToggle(mainPage, "Enable ESP", SilentAimSettings.ESP_Enabled, function(v) SilentAimSettings.ESP_Enabled = v end)
    esp.Position = UDim2.new(0.025, 0, 0, y) y = y + 35
    
    -- Sidebar buttons
    local function addTab(text, page, yPos)
        local btn = Instance.new("TextButton", sidebar)
        btn.Size = UDim2.new(1, -20, 0, 32)
        btn.Position = UDim2.new(0, 10, 0, yPos)
        btn.BackgroundColor3 = page.Visible and Color3.fromRGB(35, 35, 45) or Color3.fromRGB(20, 20, 26)
        btn.BorderSizePixel = 0
        btn.Text = text
        btn.TextColor3 = page.Visible and Color3.fromRGB(255, 182, 193) or Color3.fromRGB(200, 200, 200)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 12
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
        
        btn.MouseButton1Click:Connect(function()
            for _, p in pairs({infoPage, mainPage}) do p.Visible = false end
            for _, b in pairs(sidebar:GetChildren()) do
                if b:IsA("TextButton") then
                    b.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
                    b.TextColor3 = Color3.fromRGB(200, 200, 200)
                end
            end
            page.Visible = true
            btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
            btn.TextColor3 = Color3.fromRGB(255, 182, 193)
        end)
    end
    
    addTab("Info", infoPage, 10)
    addTab("Main", mainPage, 50)
    
    -- Drag UI
    local dragging, dragInput, dragStart, startPos
    topbar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = main.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    topbar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    -- Live clock
    local startT = tick()
    task.spawn(function()
        while main.Parent do
            local up = math.floor(tick() - startT)
            local m, s = math.floor(up/60), up%60
            uptimeVal.Text = string.format("%02d:%02d", m, s)
            local p = LocalPlayer:GetNetworkPing()
            pingVal.Text = string.format("%.0f ms", (p or 0) * 1000)
            timeVal.Text = os.date("%H:%M:%S")
            task.wait(1)
        end
    end)
    
    return {
        Toggle = function()
            main.Visible = not main.Visible
        end,
        Unload = function()
            screenGui:Destroy()
        end
    }
end

Library = loadUI()

local espData = {}
local ESP_LOGIC_INTERVAL = 0.05

local function hideESPData(d)
    if not d then return end
    d.name.Visible = false
    d.hpbarbg.Visible = false
    d.hpbar.Visible = false
    d.trace.Visible = false
    if d.hl then d.hl.Enabled = false end
end

local function removeESPData(plr)
    local d = espData[plr]
    if not d then return end
    pcall(function() d.name:Remove() end)
    pcall(function() d.hpbarbg:Remove() end)
    pcall(function() d.hpbar:Remove() end)
    pcall(function() d.trace:Remove() end)
    pcall(function() d.hl:Destroy() end)
    espData[plr] = nil
end

local espLastLogic = 0

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

    for _, p in ipairs(Players:GetPlayers()) do
        if p == LocalPlayer then continue end
        local c = p.Character
        local h = c and c:FindFirstChildOfClass("Humanoid")
        local r = c and c:FindFirstChild("HumanoidRootPart")
        
        if c and h and r and h.Health > 0 then
            local d = espData[p]
            if not d then
                d = {
                    name = _mkDraw("Text"),
                    hpbarbg = _mkDraw("Square"),
                    hpbar = _mkDraw("Square"),
                    trace = _mkDraw("Line"),
                    hl = Instance.new("Highlight")
                }
                d.name.Font = 2
                d.name.Center = true
                d.name.Outline = true
                d.name.ZIndex = 10
                d.hpbarbg.Filled = true
                d.hpbarbg.Thickness = 0
                d.hpbarbg.ZIndex = 10
                d.hpbar.Filled = true
                d.hpbar.Thickness = 0
                d.hpbar.ZIndex = 11
                d.trace.ZIndex = 9
                d.trace.Thickness = 1
                d.hl.FillColor = SilentAimSettings.ESP_HighlightColor
                d.hl.OutlineColor = SilentAimSettings.ESP_HighlightColor
                d.hl.FillTransparency = 0.55
                d.hl.OutlineTransparency = 0
                d.hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                d.hl.Enabled = false
                espData[p] = d
            end

            if teamColors and p.Team and p.Team == myTeam then
                hideESPData(d)
                continue
            end

            local dist = (r.Position - camPos).Magnitude
            if dist > maxDist then
                hideESPData(d)
                continue
            end

            local headPos = c:FindFirstChild("Head")
            local headP = headPos and headPos.Position or (r.Position + Vector3.new(0, 2.5, 0))
            local feetPos = r.Position - Vector3.new(0, 2.8, 0)
            local hVec3 = Camera:WorldToViewportPoint(headP)
            local fVec3 = Camera:WorldToViewportPoint(feetPos)

            if hVec3.Z <= 0 and fVec3.Z <= 0 then
                hideESPData(d)
                continue
            end

            local hs = Vector2.new(hVec3.X, hVec3.Y)
            local fs = Vector2.new(fVec3.X, fVec3.Y)
            local bh = math.clamp(math.abs(hs.Y - fs.Y), 12, 400)
            local topY = math.min(hs.Y, fs.Y)
            local botY = topY + bh
            local midX = hs.X

            if SilentAimSettings.ESP_Highlight then
                d.hl.Adornee = c
                d.hl.Parent = c
                d.hl.FillColor = teamColors and getTeamColor(p) or SilentAimSettings.ESP_HighlightColor
                d.hl.OutlineColor = d.hl.FillColor
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
                d.hpbar.Color = Color3.fromRGB(math.floor(255 * (1 - pct)), math.floor(255 * pct), 40)
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
        else
            if espData[p] then removeESPData(p) end
        end
    end

    for plr, _ in pairs(espData) do
        if not plr.Parent or not plr.Character then removeESPData(plr) end
    end
end

task.spawn(function()
    RenderStepped:Connect(function()
        if SilentAimSettings.FOVVisible then
            fov_circle.Visible = true
            fov_circle.Radius = SilentAimSettings.FOVRadius
            fov_circle.Position = SilentAimSettings.FOVCenter and getCenter() or getCursorPos()
            fov_circle.Color = (currentTarget and currentTarget.Parent) and Color3.fromRGB(255, 200, 220) or Color3.fromRGB(255, 255, 255)
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

    if SilentAimSettings.Enabled and self == workspace and not checkcaller() and not AutoShootRaycastInProgress then
        local hit = currentTarget
        if hit and hit.Parent then
            if Method == "FindPartOnRayWithIgnoreList" and SilentAimSettings.SilentAimMethod == Method then
                if ValidateArguments(Args, ExpectedArguments.FindPartOnRayWithIgnoreList) then
                    Args[2] = Ray.new(Args[2].Origin, getDirection(Args[2].Origin, hit.Position))
                    return oldNamecall(unpack(Args))
                end
            elseif Method == "FindPartOnRayWithWhitelist" and SilentAimSettings.SilentAimMethod == Method then
                if ValidateArguments(Args, ExpectedArguments.FindPartOnRayWithWhitelist) then
                    Args[2] = Ray.new(Args[2].Origin, getDirection(Args[2].Origin, hit.Position))
                    return oldNamecall(unpack(Args))
                end
            elseif (Method == "FindPartOnRay" or Method == "findPartOnRay") and SilentAimSettings.SilentAimMethod:lower() == Method:lower() then
                if ValidateArguments(Args, ExpectedArguments.FindPartOnRay) then
                    Args[2] = Ray.new(Args[2].Origin, getDirection(Args[2].Origin, hit.Position))
                    return oldNamecall(unpack(Args))
                end
            elseif Method == "Raycast" and SilentAimSettings.SilentAimMethod == Method then
                if ValidateArguments(Args, ExpectedArguments.Raycast) then
                    Args[3] = getDirection(Args[2], hit.Position)
                    return oldNamecall(unpack(Args))
                end
            end
        end
    end
    return oldNamecall(...)
end))

UserInputService.InputBegan:Connect(function(input, processed)
    if input.KeyCode == Enum.KeyCode.RightShift then
        if Library and Library.Toggle then Library.Toggle() end
    elseif input.KeyCode == Enum.KeyCode.End then
        if Library and Library.Unload then Library.Unload() end
    end
end)

print("SPENT HUB")
