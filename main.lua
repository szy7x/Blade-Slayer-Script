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

-- Aba Player
local PlayerTab = Window:CreateTab("Player", 4483362458)

PlayerTab:CreateToggle({
    Name = "Auto Rebirth",
    CurrentValue = false,
    Callback = function(Value)
        autoRebirth = Value
        while autoRebirth do
            game:GetService("ReplicatedStorage").Remotes.Rebirth:FireServer()
            task.wait(2)
        end
    end,
})

PlayerTab:CreateButton({
    Name = "Equipar Melhor Arma",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.EquipBestWeapon:FireServer()
    end,
})

-- Aba Heroes
local HeroesTab = Window:CreateTab("Heroes", 4483362458)

HeroesTab:CreateToggle({
    Name = "Auto Equipar Melhor Hero",
    CurrentValue = false,
    Callback = function(Value)
        autoEquipHero = Value
        while autoEquipHero do
            game:GetService("ReplicatedStorage").Remotes.EquipBestHero:FireServer()
            task.wait(2)
        end
    end,
})

local TeleportTab = Window:CreateTab("Teleport", 4483362458)

local teleportLocations = {
    ["Map1"] = Vector3.new(0, 5, 0),
    ["Map2"] = Vector3.new(200, 5, 0),
    ["Map3"] = Vector3.new(400, 5, 0),
    ["Map4"] = Vector3.new(600, 5, 0),
    ["Map5"] = Vector3.new(800, 5, 0),
    ["Map6"] = Vector3.new(1000, 5, 0),
    ["Map7"] = Vector3.new(1200, 5, 0),
    ["Map8"] = Vector3.new(1400, 5, 0),
    ["Map9"] = Vector3.new(1600, 5, 0),
    ["Map10"] = Vector3.new(1800, 5, 0),
    ["Map11"] = Vector3.new(2000, 5, 0),
    ["Map12"] = Vector3.new(2200, 5, 0),
    ["Map13"] = Vector3.new(2400, 5, 0),
    ["Map14"] = Vector3.new(2600, 5, 0),
    ["Map15"] = Vector3.new(2800, 5, 0),
}

for name, position in pairs(teleportLocations) do
    TeleportTab:CreateButton({
        Name = name,
        Callback = function()
            teleportTo(position)
        end,
    })
end

local GemHackTab = Window:CreateTab("Gem Hacks", 4483362458)

-- Funções de Gem Hack simuladas
local function gemHack1()
    local btn = game.Players.LocalPlayer.PlayerGui:FindFirstChild("GemsBtn")
    if btn then fireclickdetector(btn.ClickDetector) end
end

local function gemHack2()
    local backpack = game.Players.LocalPlayer:FindFirstChild("Backpack")
    if backpack then
        game:GetService("ReplicatedStorage").Remotes:FindFirstChild("DecomposeGem"):FireServer(backpack)
    end
end

local function gemHack3()
    local gemsFrame = game.Players.LocalPlayer.PlayerGui:FindFirstChild("GemsFrame")
    if gemsFrame then
        -- tentativa de race condition antes da decomposição
        for i = 1, 5 do
            game:GetService("ReplicatedStorage").Remotes:FindFirstChild("DecomposeGem"):FireServer(gemsFrame)
        end
    end
end

-- Botões para cada método
GemHackTab:CreateButton({
    Name = "Método 1: Clicar em GemsBtn",
    Callback = gemHack1,
})

GemHackTab:CreateButton({
    Name = "Método 2: Decompor via Backpack",
    Callback = gemHack2,
})

GemHackTab:CreateButton({
    Name = "Método 3: Race Condition Decompose",
    Callback = gemHack3,
})

-- Modo Turbo: Executa todos os métodos juntos
GemHackTab:CreateButton({
    Name = "Modo Turbo (Todos Métodos)",
    Callback = function()
        gemHack1()
        task.wait(0.1)
        gemHack2()
        task.wait(0.1)
        gemHack3()
    end,
})

-- Aba Trade
local TradeTab = Window:CreateTab("Trade", 4483362458)

local selectedPlayer = nil
local players = {}

for _, player in pairs(game.Players:GetPlayers()) do
    if player ~= game.Players.LocalPlayer then
        table.insert(players, player.Name)
    end
end

TradeTab:CreateDropdown({
    Name = "Selecionar Jogador",
    Options = players,
    CurrentOption = players[1],
    Callback = function(Option)
        selectedPlayer = Option
    end,
})

TradeTab:CreateButton({
    Name = "Enviar Trade",
    Callback = function()
        if selectedPlayer then
            game:GetService("ReplicatedStorage").Remotes.RequestTrade:FireServer(game.Players:FindFirstChild(selectedPlayer))
        end
    end,
})

-- Aba Misc
local MiscTab = Window:CreateTab("Misc", 4483362458)

MiscTab:CreateButton({
    Name = "Kill Aura Inimigos Próximos",
    Callback = function()
        for _, enemy in pairs(workspace.Enemies:GetChildren()) do
            if enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                local dist = (enemy.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                if dist <= 20 then
                    doClick()
                end
            end
        end
    end,
})

MiscTab:CreateButton({
    Name = "Usar Habilidade",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.UseSkill:FireServer()
    end,
})

-- Salvamento de configurações (opcional)
Rayfield:LoadConfiguration()

-- Mensagem de sucesso
Rayfield:Notify({
    Title = "Szy Hub - Blade Slayer",
    Content = "Script totalmente carregado com sucesso!",
    Duration = 6.5,
    Image = 4483362458,
})

-- Fim do script
print("Szy Hub totalmente inicializado!")
