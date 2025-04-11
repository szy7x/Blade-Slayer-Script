-- Carregando Rayfield
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

Rayfield:Notify({
    Title = "Szy Blade Slayer",
    Content = "Script iniciado com sucesso!",
    Duration = 5,
    Actions = { Ignore = { Name = "Fechar", Callback = function() end } }
})

-- Criar Janela
local Window = Rayfield:CreateWindow({
    Name = "Szy - Hub",
    LoadingTitle = "Carregando Script...",
    LoadingSubtitle = "By szy7x",
    ConfigurationSaving = { Enabled = false },
    KeySystem = false,
})

Rayfield:LoadConfiguration()

-- ABA: Farm
local FarmTab = Window:CreateTab("Farm", 7734053490)

-- Auto Farm
FarmTab:CreateToggle({
    Name = "Auto Farm",
    CurrentValue = false,
    Flag = "AutoFarm",
    Callback = function(v)
        _G.AutoFarm = v
    end,
})

task.spawn(function()
    while true do
        task.wait(0.3)
        if _G.AutoFarm then
            pcall(function()
                for _, mob in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    local hrp = mob:FindFirstChild("HumanoidRootPart")
                    if hrp and hrp:IsA("Part") then
                        local char = game.Players.LocalPlayer.Character
                        if char and char:FindFirstChild("HumanoidRootPart") then
                            char.HumanoidRootPart.CFrame = hrp.CFrame + Vector3.new(0, 3, 0)
                            task.wait(0.2)
                            game:GetService("ReplicatedStorage").Remotes.DamageMonster:FireServer(mob)
                            task.wait(0.2)
                        end
                    end
                end
            end)
        end
    end
end)

-- ABA: Player
local PlayerTab = Window:CreateTab("Player", 4483362458)

-- Auto Rebirth
PlayerTab:CreateToggle({
    Name = "Auto Rebirth",
    CurrentValue = false,
    Flag = "AutoRebirth",
    Callback = function(v)
        _G.AutoRebirth = v
    end,
})

task.spawn(function()
    while true do
        task.wait(2)

-- ABA: Trade
local TradeTab = Window:CreateTab("Trade", 4483362458)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local SelectedTradePlayer = nil

local function UpdatePlayerList()
    local list = {}
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            table.insert(list, plr.Name)
        end
    end
    return list
end

local PlayerDropdown = TradeTab:CreateDropdown({
    Name = "Selecionar Jogador",
    Options = UpdatePlayerList(),
    CurrentOption = "",
    Flag = "SelectedPlayerTrade",
    Callback = function(option)
        SelectedTradePlayer = option
    end,
})

Players.PlayerAdded:Connect(function()
    PlayerDropdown:Refresh(UpdatePlayerList(), true)
end)
Players.PlayerRemoving:Connect(function()
    PlayerDropdown:Refresh(UpdatePlayerList(), true)
end)

TradeTab:CreateButton({
    Name = "Enviar Troca",
    Callback = function()
        if SelectedTradePlayer then
            game:GetService("ReplicatedStorage").Remotes.TradePlayer:InvokeServer(SelectedTradePlayer)
        end
    end,
})

TradeTab:CreateButton({
    Name = "Dupe Heroes (1 Clique)",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.ConfirmTrade:FireServer()
    end,
})

-- ABA: Teleport
local TeleportTab = Window:CreateTab("Teleport", 4483362458)

local TeleportList = {
    "Map1", "Map2", "Map3", "Map4", "Map5",
    "Map6", "Map7", "Map8", "Map9", "Map10",
    "Map11", "Map12", "Map13", "Map14", "Map15"
}

for _, mapName in ipairs(TeleportList) do
    TeleportTab:CreateButton({
        Name = "Ir para " .. mapName,
        Callback = function()
            local mapFolder = game:GetService("Workspace"):FindFirstChild("Maps")
            if mapFolder then
                for _, map in pairs(mapFolder:GetChildren()) do
                    if map.Name == mapName and map:FindFirstChild("Map") then
                        local spawn = map.Map:FindFirstChild("Spawn")
                        if spawn and spawn:IsA("BasePart") then
                            LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = spawn.CFrame + Vector3.new(0, 3, 0)
                        end
                    end
                end
            end
        end,
    })
end

-- ABA: Gem Hacks
local GemTab = Window:CreateTab("Gem Hacks", 4483362458)

-- Função utilitária para pegar a gema selecionada
local function getSelectedGem()
    local UI = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("GameUI")
    if not UI then return nil end

    local selected = UI:FindFirstChild("Decompose") and UI.Decompose:FindFirstChild("Selected")
    if selected and selected:FindFirstChild("Gem") then
        return selected.Gem.Value
    end
    return nil
end

-- Método 1: Race Condition
local function dupRaceCondition()
    local gem = getSelectedGem()
    if gem then
        for i = 1, 2 do
            task.spawn(function()
                game:GetService("ReplicatedStorage").Remotes.Decompose:FireServer({ gem })
            end)
        end
        Rayfield:Notify({
            Title = "Gem Hack",
            Content = "Race Condition enviado!",
            Duration = 2,
        })
    else
        Rayfield:Notify({
            Title = "Erro",
            Content = "Nenhuma gema selecionada!",
            Duration = 2,
        })
    end
end

-- Método 2: Duplo FireServer com delay mínimo
local function dupDoubleFire()
    local gem = getSelectedGem()
    if gem then
        game:GetService("ReplicatedStorage").Remotes.Decompose:FireServer({ gem })
        wait(0.01)
        game:GetService("ReplicatedStorage").Remotes.Decompose:FireServer({ gem })
        Rayfield:Notify({
            Title = "Gem Hack",
            Content = "Double Fire enviado!",
            Duration = 2,
        })
    else
        Rayfield:Notify({
            Title = "Erro",
            Content = "Nenhuma gema selecionada!",
            Duration = 2,
        })
    end
end

-- Método 3: Invoke e FireServer combinados
local function dupInvokeCombo()
    local gem = getSelectedGem()
    if gem then
        pcall(function()
            game:GetService("ReplicatedStorage").Remotes.Decompose:InvokeServer({ gem })
            wait()
            game:GetService("ReplicatedStorage").Remotes.Decompose:FireServer({ gem })
        end)
        Rayfield:Notify({
            Title = "Gem Hack",
            Content = "Invoke Combo enviado!",
            Duration = 2,
        })
    else
        Rayfield:Notify({
            Title = "Erro",
            Content = "Nenhuma gema selecionada!",
            Duration = 2,
        })
    end
end

-- Botões Individuais
GemTab:CreateButton({
    Name = "Método 1: Race Condition",
    Callback = dupRaceCondition
})

GemTab:CreateButton({
    Name = "Método 2: Double FireServer",
    Callback = dupDoubleFire
})

GemTab:CreateButton({
    Name = "Método 3: Invoke + Fire",
    Callback = dupInvokeCombo
})

-- Modo Turbo: Tenta todos
GemTab:CreateButton({
    Name = "💥 Modo Turbo - Testar Todos",
    Callback = function()
        dupRaceCondition()
        wait(0.3)
        dupDoubleFire()
        wait(0.3)
        dupInvokeCombo()
        wait(0.2)
        Rayfield:Notify({
            Title = "Modo Turbo",
            Content = "Todos os métodos foram testados!",
            Duration = 3
        })
    end
})
