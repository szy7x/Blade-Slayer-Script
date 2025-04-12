--[[ Szy Blade Slayer | Script Completo com KeySystem e Suporte ]]
-- FIXED KEY: SzyBladeSlayer2025
-- KEY LINK: https://direct-link.net/1335872/szy-hub-key
-- DISCORD: https://discord.gg/jDhZzpyq2a

-- Carrega Rayfield com sistema de Key
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

-- Cria a janela com sistema de chave
local Window = Rayfield:CreateWindow({
    Name = "Szy - Blade Slayer",
    LoadingTitle = "Szy Hub",
    LoadingSubtitle = "Carregando sua interface...",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil,
        FileName = "SzyBladeSlayer"
    },
    KeySystem = true,
    KeySettings = {
        Title = "Sistema de Chave - Szy Hub",
        Subtitle = "Insira sua chave abaixo para continuar",
        Note = "Clique em 'Get Key' para obter a chave gratuitamente.",
        FileName = "SzyKeySave",
        SaveKey = true,
        GrabKeyFromSite = true,
        Key = {"SzyBladeSlayer2025"},
        KeyInput = true,
        KeyWebsite = "https://direct-link.net/1335872/szy-hub-key"
    }
})


local Window = Rayfield:CreateWindow({
    Name = "Szy - Hub | Blade Slayer",
    LoadingTitle = "Carregando Script...",
    LoadingSubtitle = "By szy7x",
    ConfigurationSaving = {Enabled = false},
    Discord = {
        Enabled = true,
        Invite = "jDhZzpyq2a",
        RememberJoins = false
    },
    KeySystem = false
})

Rayfield:Notify({
    Title = "Szy Blade Slayer",
    Content = "Script carregado com sucesso!",
    Duration = 5,
})

Rayfield:LoadConfiguration()

-- Variáveis
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local rs = game:GetService("RunService")
local farmAtivado, rebirthAtivado, autoClickAtivado, killAuraAtivado = false, false, false, false
local killAuraDist = 30

-- Função Auto Click
rs.RenderStepped:Connect(function()
    if autoClickAtivado then
        local event = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Click")
        event:FireServer()
    end
end)

-- Kill Aura
rs.Heartbeat:Connect(function()
    if killAuraAtivado then
        for _, mob in pairs(workspace.Mobs:GetChildren()) do
            if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                local dist = (mob.HumanoidRootPart.Position - hrp.Position).Magnitude
                if dist <= killAuraDist then
                    game:GetService("ReplicatedStorage").Remotes.DamageEnemy:FireServer(mob)
                end
            end
        end
    end
end)

-- Auto Farm
task.spawn(function()
    while true do task.wait(0.2)
        if farmAtivado then
            for _, mob in pairs(workspace.Mobs:GetChildren()) do
                if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                    hrp.CFrame = mob.HumanoidRootPart.CFrame + Vector3.new(0, 0, -4)
                    repeat
                        game:GetService("ReplicatedStorage").Remotes.DamageEnemy:FireServer(mob)
                        task.wait()
                    until mob.Humanoid.Health <= 0 or not farmAtivado
                end
            end
        end
    end
end)

-- Auto Rebirth
task.spawn(function()
    while true do task.wait(2)
        if rebirthAtivado then
            local rebirth = game:GetService("ReplicatedStorage").Remotes.Rebirth
            rebirth:FireServer()
        end
    end
end)

-- Criando Abas
local abaFarm = Window:CreateTab("Farm", 4483362458)
local abaPlayer = Window:CreateTab("Player", 7072717517)

-- Botões Farm
abaFarm:CreateToggle({
    Name = "Auto Farm",
    CurrentValue = false,
    Callback = function(value)
        farmAtivado = value
    end
})

abaFarm:CreateToggle({
    Name = "Auto Click",
    CurrentValue = false,
    Callback = function(value)
        autoClickAtivado = value
    end
})

abaFarm:CreateToggle({
    Name = "Auto Rebirth",
    CurrentValue = false,
    Callback = function(value)
        rebirthAtivado = value
    end
})

abaFarm:CreateToggle({
    Name = "Kill Aura",
    CurrentValue = false,
    Callback = function(value)
        killAuraAtivado = value
    end
})

abaFarm:CreateSlider({
    Name = "Distância Kill Aura",
    Range = {10, 50},
    Increment = 1,
    CurrentValue = killAuraDist,
    Callback = function(value)
        killAuraDist = value
    end
})

-- Variáveis de controle
local autoEquip, autoFuse, autoSkill, autoHatch = false, false, false, false
local selectedEgg = "Egg1"

-- Auto Equip Best Weapon
task.spawn(function()
    while true do task.wait(2)
        if autoEquip then
            local equipBest = game:GetService("ReplicatedStorage").Remotes.EquipBestWeapon
            equipBest:FireServer()
        end
    end
end)

-- Auto Fuse Weapons
task.spawn(function()
    while true do task.wait(4)
        if autoFuse then
            local fuse = game:GetService("ReplicatedStorage").Remotes.FuseAllWeapons
            fuse:FireServer()
        end
    end
end)

-- Auto Use Skill
task.spawn(function()
    while true do task.wait(1)
        if autoSkill then
            local skill = game:GetService("ReplicatedStorage").Remotes.UseSkill
            skill:FireServer()
        end
    end
end)

-- Auto Hatch
task.spawn(function()
    while true do task.wait(1.5)
        if autoHatch and selectedEgg then
            local hatch = game:GetService("ReplicatedStorage").Remotes.HatchEgg
            hatch:InvokeServer(selectedEgg, false)
        end
    end
end)

-- Botões de funções
abaFarm:CreateToggle({
    Name = "Auto Equip Best Weapon",
    CurrentValue = false,
    Callback = function(v)
        autoEquip = v
    end
})

abaFarm:CreateToggle({
    Name = "Auto Fuse Weapon",
    CurrentValue = false,
    Callback = function(v)
        autoFuse = v
    end
})

abaFarm:CreateToggle({
    Name = "Auto Use Skill",
    CurrentValue = false,
    Callback = function(v)
        autoSkill = v
    end
})

abaFarm:CreateDropdown({
    Name = "Selecionar Ovo",
    Options = {"Egg1", "Egg2", "Egg3", "Egg4", "Egg5"},
    CurrentOption = selectedEgg,
    Callback = function(v)
        selectedEgg = v
    end
})

abaFarm:CreateToggle({
    Name = "Auto Hatch",
    CurrentValue = false,
    Callback = function(v)
        autoHatch = v
    end
})

-- Início dos Gem Hacks
local function duplicarGemaSelecionada()
    local decomposerUI = plr.PlayerGui:FindFirstChild("DecomposeGems")
    if decomposerUI and decomposerUI:FindFirstChild("Main") then
        local selected = decomposerUI.Main:FindFirstChild("SelectedGem")
        if selected then
            game:GetService("ReplicatedStorage").Remotes.Decompose:FireServer(selected.Value)
        end
    end
end

local abaGemHack = Window:CreateTab("Gem Hacks", 4483362458)

abaGemHack:CreateButton({
    Name = "Duplicar Gema (Método 1)",
    Callback = function()
        duplicarGemaSelecionada()
    end
})

-- Método 2 de Gem Hack (Race Condition)
local function gemHackRace()
    local gui = plr.PlayerGui:FindFirstChild("DecomposeGems")
    if gui then
        local selected = gui.Main:FindFirstChild("SelectedGem")
        if selected then
            for i = 1, 5 do
                task.spawn(function()
                    game:GetService("ReplicatedStorage").Remotes.Decompose:FireServer(selected.Value)
                end)
            end
        end
    end
end

-- Modo Turbo: tenta todos os métodos
local function gemHackTurbo()
    duplicarGemaSelecionada()
    gemHackRace()
end

abaGemHack:CreateButton({
    Name = "Duplicar Gema (Método 2 - Race)",
    Callback = function()
        gemHackRace()
    end
})

abaGemHack:CreateButton({
    Name = "Modo Turbo de Duplicação",
    Callback = function()
        gemHackTurbo()
    end
})

-- Auto Collect Drops
local autoCollect = false
task.spawn(function()
    while true do task.wait(1)
        if autoCollect then
            for _, drop in pairs(workspace.Drops:GetChildren()) do
                if drop:IsA("Model") and drop:FindFirstChild("TouchInterest") then
                    firetouchinterest(plr.Character.HumanoidRootPart, drop, 0)
                    firetouchinterest(plr.Character.HumanoidRootPart, drop, 1)
                end
            end
        end
    end
end)

abaFarm:CreateToggle({
    Name = "Auto Coletar Drops",
    CurrentValue = false,
    Callback = function(v)
        autoCollect = v
    end
})

-- Auto Defense
local autoDefense = false
task.spawn(function()
    while true do task.wait(2)
        if autoDefense then
            game:GetService("ReplicatedStorage").Remotes.JoinDefense:FireServer()
        end
    end
end)

abaFarm:CreateToggle({
    Name = "Auto Defense",
    CurrentValue = false,
    Callback = function(v)
        autoDefense = v
    end
})

-- Auto Open Crates
local autoCrates = false
task.spawn(function()
    while true do task.wait(3)
        if autoCrates then
            game:GetService("ReplicatedStorage").Remotes.OpenCrate:FireServer()
        end
    end
end)

abaFarm:CreateToggle({
    Name = "Auto Open Crates",
    CurrentValue = false,
    Callback = function(v)
        autoCrates = v
    end
})

-- Teleportes
local maps = {
    ["Mapa 1"] = CFrame.new(10, 0, 10),
    ["Mapa 2"] = CFrame.new(100, 0, 100),
    ["Mapa 3"] = CFrame.new(200, 0, 200),
    ["Mapa 4"] = CFrame.new(300, 0, 300),
    ["Mapa 5"] = CFrame.new(400, 0, 400),
    ["Mapa 6"] = CFrame.new(500, 0, 500),
    ["Mapa 7"] = CFrame.new(600, 0, 600),
    ["Mapa 8"] = CFrame.new(700, 0, 700),
    ["Mapa 9"] = CFrame.new(800, 0, 800),
    ["Mapa 10"] = CFrame.new(900, 0, 900),
    ["Mapa 11"] = CFrame.new(1000, 0, 1000),
    ["Mapa 12"] = CFrame.new(1100, 0, 1100),
    ["Mapa 13"] = CFrame.new(1200, 0, 1200),
    ["Mapa 14"] = CFrame.new(1300, 0, 1300),
    ["Mapa 15"] = CFrame.new(1400, 0, 1400)
}

local abaTeleport = Window:CreateTab("Teleportes", 4483362458)
for nome, pos in pairs(maps) do
    abaTeleport:CreateButton({
        Name = nome,
        Callback = function()
            plr.Character:PivotTo(pos)
        end
    })
end

-- Misc: Velocidade e Pulo
local abaMisc = Window:CreateTab("Misc", 4483362458)
abaMisc:CreateSlider({
    Name = "Velocidade",
    Range = {16, 200},
    Increment = 1,
    CurrentValue = 16,
    Callback = function(val)
        plr.Character.Humanoid.WalkSpeed = val
    end
})

abaMisc:CreateSlider({
    Name = "Pulo",
    Range = {50, 200},
    Increment = 1,
    CurrentValue = 50,
    Callback = function(val)
        plr.Character.Humanoid.JumpPower = val
    end
})

-- KeySystem
local keyVal = "SzyBladeSlayer2025"
local function verificarKey()
    local inputKey = ""
    local input = game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Sistema de Key",
        Text = "Obtenha sua key em: https://direct-link.net/1335872/szy-hub-key",
        Duration = 8
    })
    repeat
        inputKey = tostring(game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("ScreenGui").KeyInput.Text)
        wait()
    until inputKey == keyVal
end

-- Discord de Suporte
local abaSuporte = Window:CreateTab("Suporte", 4483362458)
abaSuporte:CreateParagraph({Title = "Discord:", Content = "https://discord.gg/jDhZzpyq2a"})

-- (continua com salvamento de configurações, creditos e finalização...)

-- Sistema de Key (Tela de Input + Verificação)
local Library = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local function promptKey()
    local keyInput
    local keyValid = false

    local KeyWindow = Library:CreateWindow({
        Name = "Szy Hub - Key System",
        LoadingTitle = "Verificando Key...",
        LoadingSubtitle = "Aguarde",
        ConfigurationSaving = {
            Enabled = false
        },
        Discord = {
            Enabled = true,
            Invite = "jDhZzpyq2a",
            RememberJoins = false
        },
        KeySystem = true,
        KeySettings = {
            Title = "Szy Hub | Blade Slayer",
            Subtitle = "Sistema de Key",
            Note = "Obtenha sua key no botão abaixo!",
            FileName = "SzyBladeKey",
            SaveKey = true,
            GrabKeyFromSite = false,
            Key = "SzyBladeSlayer2025",
            KeyInput = true,
            ExternalLink = "https://direct-link.net/1335872/szy-hub-key"
        }
    })
end

-- Chamar função de prompt de Key
promptKey()

-- Créditos
local abaCreditos = Window:CreateTab("Créditos", 4483362458)
abaCreditos:CreateParagraph({
    Title = "Szy Hub",
    Content = "Script feito por Szy com amor para Blade Slayer\nKey Fixa: SzyBladeSlayer2025\nDiscord: discord.gg/jDhZzpyq2a"
})

-- Fim do Script
