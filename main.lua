-- Notificação de início
game.StarterGui:SetCore("SendNotification", {
    Title = "Szy Blade Slayer Hub",
    Text = "Script iniciado com sucesso!",
    Duration = 4
})

-- Carrega Fluent UI
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/centie/Fluent/main/source.lua"))()
local Window = Fluent:CreateWindow({
    Title = "Blade Slayer | Szy Hub",
    SubTitle = "Feito por Szy 🇧🇷",
    TabWidth = 120,
    Size = UDim2.fromOffset(520, 400),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Abas
local credits = Window:AddTab({ Title = "Credits", Icon = "heart" })
local info = Window:AddTab({ Title = "Informations", Icon = "info" })
local farm = Window:AddTab({ Title = "Farm", Icon = "axe" })
local dungeon = Window:AddTab({ Title = "Dungeon", Icon = "shield" })
local misc = Window:AddTab({ Title = "Misc", Icon = "settings" })
local machine = Window:AddTab({ Title = "Machine", Icon = "zap" })
local trade = Window:AddTab({ Title = "Trade", Icon = "gift" })
local player = Window:AddTab({ Title = "Player", Icon = "user" })
local teleport = Window:AddTab({ Title = "Teleport", Icon = "map" })

-- Variáveis
local autoFarm, autoRebirth, autoUpgrade = false, false, false

-- Auto loop
task.spawn(function()
    while task.wait(0.2) do
        if autoFarm then
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.Click:FireServer()
            end)
        end
        if autoRebirth then
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.Rebirth:FireServer()
            end)
        end
        if autoUpgrade then
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.Upgrade:InvokeServer("UpgradeName")
            end)
        end
    end
end)

-- Créditos
credits:AddParagraph({ Title = "Feito por", Content = "Szy" })
credits:AddButton({ Title = "Copiar Discord", Callback = function()
    setclipboard("discord.gg/seuszy")
    game.StarterGui:SetCore("SendNotification", {
        Title = "Discord copiado!",
        Text = "Cole no seu navegador",
        Duration = 4
    })
end })

-- Informações
info:AddParagraph({ Title = "Versão", Content = "1.0\nAtualizado em Abril 2025" })

-- Farm
farm:AddToggle("Auto Farm", false, function(v) autoFarm = v end)
farm:AddToggle("Auto Rebirth", false, function(v) autoRebirth = v end)
farm:AddToggle("Auto Upgrade", false, function(v) autoUpgrade = v end)
farm:AddButton({ Title = "Equipar Melhor", Callback = function()
    pcall(function()
        game:GetService("ReplicatedStorage").Remotes.EquipBest:FireServer()
    end)
end })

-- Dungeon/Raid
dungeon:AddButton({ Title = "Entrar na Dungeon", Callback = function()
    print("Entrando na Dungeon...")
end })

-- Misc
misc:AddButton({ Title = "Destravar FPS", Callback = function()
    setfpscap(999)
end })

-- Machine
machine:AddButton({ Title = "Upgrade Espada", Callback = function()
    print("Upgrade da espada enviado.")
end })

-- Trade
trade:AddButton({ Title = "Solicitar Troca", Callback = function()
    print("Troca solicitada.")
end })

-- Player
player:AddButton({ Title = "Speed x2", Callback = function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 32
end })

-- Teleport
teleport:AddButton({ Title = "Spawn", Callback = function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 10, 0)
end })
teleport:AddButton({ Title = "Área Final", Callback = function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(500, 10, 500)
end })
