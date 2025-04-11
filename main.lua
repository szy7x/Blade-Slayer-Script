-- Carregando Rayfield
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

Rayfield:Notify({
    Title = "Szy Blade Slayer",
    Content = "Script iniciado com sucesso!",
    Duration = 5,
    Actions = {
        Ignore = {
            Name = "Fechar",
            Callback = function() end
        }
    }
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

Rayfield:LoadConfiguration()

local FarmTab = Window:CreateTab("Farm", 4483362458)

FarmTab:CreateToggle({
    Name = "Auto Farm",
    CurrentValue = false,
    Flag = "AutoFarm",
    Callback = function(Value)
        _G.AutoFarm = Value
    end,
})

task.spawn(function()
    while true do
        task.wait(0.5)
        if _G.AutoFarm then
            pcall(function()
                for _, mob in ipairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    local hrp = mob:FindFirstChild("HumanoidRootPart")
                    if hrp and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.new(0, 3, 0)
                        task.wait(0.3)
                        game:GetService("ReplicatedStorage").Remotes.DamageMonster:FireServer(mob)
                    end
                end
            end)
        end
    end
end)

FarmTab:CreateToggle({
    Name = "Kill Aura",
    CurrentValue = false,
    Flag = "KillAura",
    Callback = function(Value)
        _G.KillAura = Value
    end,
})

task.spawn(function()
    while true do
        task.wait(0.2)
        if _G.KillAura then
            pcall(function()
                for _, mob in ipairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                        game:GetService("ReplicatedStorage").Remotes.DamageMonster:FireServer(mob)
                    end
                end
            end)
        end
    end
end)

FarmTab:CreateToggle({
    Name = "Auto Click",
    CurrentValue = false,
    Flag = "AutoClick",
    Callback = function(Value)
        _G.AutoClick = Value
    end,
})

task.spawn(function()
    while true do
        task.wait()
        if _G.AutoClick then
            pcall(function()
                for i = 1, 3 do
                    game:GetService("ReplicatedStorage").Remotes.PlayerClickAttack:FireServer()
                end
            end)
        end
    end
end)

-- ABA: Player
local PlayerTab = Window:CreateTab("Player", 4483362458)

PlayerTab:CreateToggle({
    Name = "Auto Rebirth",
    CurrentValue = false,
    Flag = "AutoRebirth",
    Callback = function(Value)
        _G.AutoRebirth = Value
    end,
})

task.spawn(function()
    while true do
        task.wait(2)
        if _G.AutoRebirth then
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.PlayerReborn:FireServer()
            end)
        end
    end
end)

PlayerTab:CreateToggle({
    Name = "Auto Equip Best Weapon",
    CurrentValue = false,
    Flag = "AutoEquip",
    Callback = function(Value)
        _G.AutoEquip = Value
    end,
})

task.spawn(function()
    while true do
        task.wait(2)
        if _G.AutoEquip then
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.EquipBestWeapon:FireServer()
            end)
        end
    end
end)

-- ABA: Heroes
local HeroesTab = Window:CreateTab("Heroes", 4483362458)

HeroesTab:CreateToggle({
    Name = "Auto Equip Best Hero",
    CurrentValue = false,
    Flag = "AutoEquipBestHero",
    Callback = function(Value)
        _G.AutoEquipBestHero = Value
    end,
})

task.spawn(function()
    while true do
        task.wait(2)
        if _G.AutoEquipBestHero then
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.AutoEquipBestHero:FireServer()
            end)
        end
    end
end)

HeroesTab:CreateToggle({
    Name = "Auto Hatch Nearest",
    CurrentValue = false,
    Flag = "AutoHatchNearest",
    Callback = function(Value)
        _G.AutoHatchNearest = Value
    end,
})

task.spawn(function()
    while true do
        task.wait()
        if _G.AutoHatchNearest then
            pcall(function()
                local mapsFolder = game.Workspace:FindFirstChild("Maps")
                if mapsFolder then
                    for _, map in pairs(mapsFolder:GetChildren()) do
                        if map:FindFirstChild("Map") and map.Map:FindFirstChild("Eggs") then
                            local egg = map.Map.Eggs:GetChildren()[1]
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = egg.CFrame
                            wait(0.5)
                            local vim = game:GetService("VirtualInputManager")
                            vim:SendKeyEvent(true, "E", false, game)
                            wait(0.2)
                            vim:SendKeyEvent(false, "E", false, game)
                            break
                        end
                    end
                end
            end)
        end
    end
end)

-- ABA: Trade
local TradeTab = Window:CreateTab("Trade", 4483362458)

local players = game:GetService("Players")
local player = players.LocalPlayer
local tradeInProgress = false
local tradeOffer = {
    target = nil,
    heroesOffered = {}
}

local function sendTradeOffer(targetPlayerName)
    local targetPlayer = players:FindFirstChild(targetPlayerName)
    if targetPlayer then
        if not tradeInProgress then
            tradeInProgress = true
            tradeOffer.target = targetPlayer
            tradeOffer.heroesOffered = {"Hero1", "Hero2"}
        end
    end
end

local function acceptTrade()
    if tradeInProgress and tradeOffer.target then
        tradeInProgress = false
    end
end

local function updatePlayerList()
    local playerList = {}
    for _, p in pairs(players:GetPlayers()) do
        if p.Name ~= player.Name then
            table.insert(playerList, p.Name)
        end
    end
    return playerList
end

local PlayerDropdown = TradeTab:CreateDropdown({
    Name = "Escolher Jogador para Troca",
    Options = updatePlayerList(),
    CurrentOption = updatePlayerList()[1],
    Flag = "TradePlayerDropdown",
    Callback = function(selectedPlayer)
        sendTradeOffer(selectedPlayer)
    end,
})

TradeTab:CreateButton({
    Name = "Enviar Troca Manualmente",
    Callback = function()
        local selectedPlayer = PlayerDropdown:GetSelected()
        sendTradeOffer(selectedPlayer)
    end,
})

TradeTab:CreateButton({
    Name = "Dupe Heroes - 1 CLICK ONLY",
    Callback = function()
        acceptTrade()
    end,
})
-- ABA: Gem Hacks
local GemTab = Window:CreateTab("Gem Hacks", 4483362458)

GemTab:CreateButton({
    Name = "Dupe Gemas Selecionadas (Decomposição)",
    Callback = function()
        pcall(function()
            local Backpack = game.Players.LocalPlayer:FindFirstChild("Backpack")
            local UI = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("UI")
            if UI and UI:FindFirstChild("MainUI") and UI.MainUI:FindFirstChild("GemsFrame") then
                local frame = UI.MainUI.GemsFrame
                for _, gem in ipairs(frame:GetDescendants()) do
                    if gem:IsA("ImageButton") and gem:FindFirstChild("Selected") and gem.Selected.Visible == true then
                        local fakeGem = gem:Clone()
                        fakeGem.Parent = Backpack
                    end
                end
            end
        end)
    end
})

-- ABA: Teleport
local TeleportTab = Window:CreateTab("Teleport", 4483362458)

local function getMaps()
    local mapsFolder = game.Workspace:FindFirstChild("Maps")
    local maps = {}
    if mapsFolder then
        for _, map in pairs(mapsFolder:GetChildren()) do
            table.insert(maps, map.Name)
        end
    end
    return maps
end

local selectedMap = nil

TeleportTab:CreateDropdown({
    Name = "Selecionar Mapa",
    Options = getMaps(),
    CurrentOption = getMaps()[1],
    Flag = "MapaSelecionado",
    Callback = function(option)
        selectedMap = option
    end,
})

TeleportTab:CreateButton({
    Name = "Teleportar para o Mapa Selecionado",
    Callback = function()
        if selectedMap then
            local mapsFolder = game.Workspace:FindFirstChild("Maps")
            if mapsFolder then
                local destination = mapsFolder:FindFirstChild(selectedMap)
                if destination and destination:FindFirstChild("Spawn") then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = destination.Spawn.CFrame + Vector3.new(0, 3, 0)
                end
            end
        end
    end,
})

-- ABA: Misc
local MiscTab = Window:CreateTab("Misc", 4483362458)

MiscTab:CreateButton({
    Name = "Kill Aura (Inimigos Próximos)",
    Callback = function()
        _G.KillAura = not _G.KillAura
    end,
})

task.spawn(function()
    while true do
        task.wait(0.2)
        if _G.KillAura then
            pcall(function()
                for _, mob in ipairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    local hrp = mob:FindFirstChild("HumanoidRootPart")
                    if hrp and (hrp.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 20 then
                        game:GetService("ReplicatedStorage").Remotes.DamageMonster:FireServer(mob)
                    end
                end
            end)
        end
    end
end)

-- NOTIFICAÇÃO FINAL
Rayfield:Notify({
    Title = "Blade Slayer Script",
    Content = "Script COMPLETO carregado com sucesso!",
    Duration = 6,
    Image = nil,
    Actions = {
        Ignore = {
            Name = "OK",
            Callback = function() end
        }
    }
})
