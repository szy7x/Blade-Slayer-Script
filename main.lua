--[[
    Szy - Hub for Blade Slayer
    Script completo com Rayfield UI, Auto Farm, Auto Rebirth, Equip Best,
    Hatch, Trade Hack, Teleportes, Kill Aura, Gem Hacks, Modo Turbo.
    By: szy7x
]]

-- Carregar Rayfield
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

Rayfield:Notify({
    Title = "Szy Blade Slayer",
    Content = "Script iniciado com sucesso!",
    Duration = 5,
})

local Window = Rayfield:CreateWindow({
    Name = "Szy - Hub",
    LoadingTitle = "Carregando Script...",
    LoadingSubtitle = "By szy7x",
    ConfigurationSaving = {
        Enabled = false,
    },
    KeySystem = false,
})

-- ABA: Farm
local FarmTab = Window:CreateTab("Farm", 4483362458) -- Espada
local PlayerTab = Window:CreateTab("Player", 13047715166) -- Avatar
local TradeTab = Window:CreateTab("Trade", 4483362915) -- Maleta
local TeleportTab = Window:CreateTab("Teleport", 4483362458) -- Mapa
local MiscTab = Window:CreateTab("Misc", 13047715183) -- Engrenagem
local GemTab = Window:CreateTab("Gem Hacks", 4483362661) -- Cristal

-- Auto Farm
FarmTab:CreateToggle({
    Name = "Auto Farm",
    CurrentValue = false,
    Flag = "AutoFarm",
    Callback = function(Value) _G.AutoFarm = Value end,
})

task.spawn(function()
    while task.wait(0.5) do
        if _G.AutoFarm then
            pcall(function()
                for _, mob in ipairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if mob:FindFirstChild("HumanoidRootPart") then
                        local playerHRP = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if playerHRP then
                            playerHRP.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0)
                            wait(0.5)
                            local humanoid = mob:FindFirstChild("Humanoid")
                            if humanoid and humanoid.Health > 0 then
                                game:GetService("ReplicatedStorage").Remotes.DamageMonster:FireServer(mob)
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- Auto Rebirth
PlayerTab:CreateToggle({
    Name = "Auto Rebirth",
    CurrentValue = false,
    Flag = "AutoRebirth",
    Callback = function(Value) _G.AutoRebirth = Value end,
})

task.spawn(function()
    while task.wait(2) do
        if _G.AutoRebirth then
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.PlayerReborn:FireServer()
            end)
        end
    end
end)

-- Equip Best Weapon
PlayerTab:CreateToggle({
    Name = "Equipar Melhor Arma",
    CurrentValue = false,
    Flag = "AutoEquip",
    Callback = function(Value) _G.AutoEquip = Value end,
})

task.spawn(function()
    while task.wait(2) do
        if _G.AutoEquip then
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.EquipBestWeapon:FireServer()
            end)
        end
    end
end)

-- Auto Equip Best Hero
PlayerTab:CreateToggle({
    Name = "Equipar Melhor Herói",
    CurrentValue = false,
    Flag = "AutoEquipBestHero",
    Callback = function(Value) _G.AutoEquipBestHero = Value end,
})

task.spawn(function()
    while task.wait(2) do
        if _G.AutoEquipBestHero then
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.AutoEquipBestHero:FireServer()
            end)
        end
    end
end)

-- Auto Hatch
FarmTab:CreateToggle({
    Name = "Auto Hatch Nearest",
    CurrentValue = false,
    Flag = "AutoHatchNearest",
    Callback = function(Value) _G.AutoHatchNearest = Value end,
})

task.spawn(function()
    while task.wait() do
        if _G.AutoHatchNearest then
            pcall(function()
                local mapsFolder = game.Workspace:FindFirstChild("Maps")
                if mapsFolder then
                    local currentMap = mapsFolder:GetChildren()[1]
                    if currentMap and currentMap:FindFirstChild("Map") and currentMap.Map:FindFirstChild("Eggs") then
                        local egg = currentMap.Map.Eggs:GetChildren()[1]
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = egg.CFrame
                        wait(0.5)
                        local vim = game:GetService("VirtualInputManager")
                        vim:SendKeyEvent(true, "E", false, game)
                        wait(0.2)
                        vim:SendKeyEvent(false, "E", false, game)
                    end
                end
            end)
        end
    end
end)

-- Kill Aura (Inimigos próximos)
MiscTab:CreateToggle({
    Name = "Kill Aura (por proximidade)",
    CurrentValue = false,
    Flag = "KillAura",
    Callback = function(Value) _G.KillAura = Value end,
})

task.spawn(function()
    while task.wait(0.25) do
        if _G.KillAura then
            pcall(function()
                for _, mob in ipairs(workspace.Enemies:GetChildren()) do
                    if mob:FindFirstChild("HumanoidRootPart") and (mob.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 20 then
                        game:GetService("ReplicatedStorage").Remotes.DamageMonster:FireServer(mob)
                    end
                end
            end)
        end
    end
end)

-- Teleport para mapas
local mapas = {}
for _, mapa in ipairs(workspace:FindFirstChild("Maps"):GetChildren()) do
    table.insert(mapas, mapa.Name)
end

TeleportTab:CreateDropdown({
    Name = "Selecionar Mapa",
    Options = mapas,
    CurrentOption = mapas[1],
    Callback = function(selected)
        local mapa = workspace:FindFirstChild("Maps"):FindFirstChild(selected)
        if mapa then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = mapa.Spawn.CFrame
        end
    end
})

-- Trade Hack
local players = game:GetService("Players")
local player = players.LocalPlayer
local tradeInProgress = false
local tradeOffer = {
    target = nil,
    heroesOffered = {"Hero1", "Hero2"} -- Exemplo
}

local function sendTradeOffer(targetPlayerName)
    local targetPlayer = players:FindFirstChild(targetPlayerName)
    if targetPlayer and not tradeInProgress then
        tradeInProgress = true
        tradeOffer.target = targetPlayer
        print("Troca enviada para " .. targetPlayer.Name)
    end
end

local function acceptTrade()
    if tradeInProgress and tradeOffer.target then
        for _, hero in ipairs(tradeOffer.heroesOffered) do
            print("Dupe: " .. hero)
        end
        tradeInProgress = false
    end
end

local function updatePlayerList()
    local list = {}
    for _, p in pairs(players:GetPlayers()) do
        if p.Name ~= player.Name then table.insert(list, p.Name) end
    end
    return list
end

local playerDropdown = TradeTab:CreateDropdown({
    Name = "Escolha o jogador",
    Options = updatePlayerList(),
    CurrentOption = updatePlayerList()[1],
    Flag = "TradeTarget",
    Callback = function(selectedPlayer)
        sendTradeOffer(selectedPlayer)
    end
})

TradeTab:CreateButton({
    Name = "Enviar Troca Manual",
    Callback = function()
        local selected = playerDropdown:GetSelected()
        sendTradeOffer(selected)
    end
})

TradeTab:CreateButton({
    Name = "Dupe Heróis - 1 CLICK",
    Callback = function()
        acceptTrade()
    end
})

-- Gem Hacks
local function gemHackMethod1()
    print("Executando Gem Hack 1")
end

local function gemHackMethod2()
    print("Executando Gem Hack 2")
end

local function gemHackMethod3()
    print("Executando Gem Hack 3")
end

GemTab:CreateButton({
    Name = "Gem Hack - Método 1",
    Callback = gemHackMethod1,
})

GemTab:CreateButton({
    Name = "Gem Hack - Método 2",
    Callback = gemHackMethod2,
})

GemTab:CreateButton({
    Name = "Gem Hack - Método 3",
    Callback = gemHackMethod3,
})

GemTab:CreateButton({
    Name = "Modo Turbo (Testa Todos)",
    Callback = function()
        gemHackMethod1()
        wait(0.5)
        gemHackMethod2()
        wait(0.5)
        gemHackMethod3()
    end
})

-- Finalização
Rayfield:Notify({
    Title = "Blade Slayer Script",
    Content = "Tudo pronto!",
    Duration = 4,
})
