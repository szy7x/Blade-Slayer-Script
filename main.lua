local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Szy - Hub | Blade Slayer",
    LoadingTitle = "Szy Hub",
    LoadingSubtitle = "Script Exclusivo",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "SzyHub",
        FileName = "BladeSlayer"
    },
    Discord = {
        Enabled = false
    },
    KeySystem = false,
})

-- Variáveis Globais
local autoFarm = false
local autoClick = false
local autoRebirth = false
local autoEquipWeapon = false
local autoEquipHero = false
local selectedZone = "Zone1"
local killAura = false
local killAuraRange = 25

-- Teleportar personagem para uma posição
local function teleportTo(position)
    if game.Players.LocalPlayer.Character then
        game.Players.LocalPlayer.Character:PivotTo(CFrame.new(position))
    end
end

-- Função de clicar (AutoClick)
local function doClick()
    local args = {[1] = true}
    game:GetService("ReplicatedStorage").Remotes.Click:FireServer(unpack(args))
end

-- Iniciar Auto Click
local function startAutoClick()
    while autoClick do
        doClick()
        task.wait(0.05)
    end
end

-- Localizar inimigo mais próximo
local function getNearestEnemy()
    local nearest, dist = nil, math.huge
    for _, v in pairs(workspace.Enemies:GetChildren()) do
        if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            local d = (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            if d < dist then
                nearest = v
                dist = d
            end
        end
    end
    return nearest
end

-- Kill Aura com distância
local function killAuraLoop()
    while killAura do
        for _, enemy in pairs(workspace.Enemies:GetChildren()) do
            if enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                local dist = (enemy.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                if dist <= killAuraRange then
                    doClick()
                end
            end
        end
        task.wait(0.1)
    end
end

-- Função Auto Farm
local function autoFarmLoop()
    while autoFarm do
        local enemy = getNearestEnemy()
        if enemy then
            teleportTo(enemy.HumanoidRootPart.Position + Vector3.new(0, 2, 0))
            repeat
                doClick()
                task.wait(0.1)
            until not enemy or not enemy:FindFirstChild("Humanoid") or enemy.Humanoid.Health <= 0 or not autoFarm
        else
            task.wait(0.5)
        end
    end
end

local FarmTab = Window:CreateTab("Farm", 4483362458)

FarmTab:CreateToggle({
    Name = "Auto Farm",
    CurrentValue = false,
    Callback = function(Value)
        autoFarm = Value
        if autoFarm then
            autoFarmLoop()
        end
    end,
})

FarmTab:CreateToggle({
    Name = "Auto Click",
    CurrentValue = false,
    Callback = function(Value)
        autoClick = Value
        if autoClick then
            startAutoClick()
        end
    end,
})

FarmTab:CreateToggle({
    Name = "Kill Aura",
    CurrentValue = false,
    Callback = function(Value)
        killAura = Value
        if killAura then
            killAuraLoop()
        end
    end,
})

FarmTab:CreateSlider({
    Name = "Distância Kill Aura",
    Range = {5, 100},
    Increment = 1,
    CurrentValue = killAuraRange,
    Callback = function(Value)
        killAuraRange = Value
    end,
})

-- Continuação nas próximas partes...
