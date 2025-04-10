local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "Blade Slayer | Szy Hub 🇧🇷",
    LoadingTitle = "Iniciando...",
    LoadingSubtitle = "By Szy",
    ConfigurationSaving = {
        Enabled = false
    },
    KeySystem = false
})

Rayfield:Notify({
    Title = "Blade Slayer Script",
    Content = "Carregado com sucesso!",
    Duration = 5
})

-- FARM
local Farm = Window:CreateTab("Farm")

Farm:CreateToggle({
    Name = "Auto Kill",
    CurrentValue = false,
    Callback = function(v)
        getgenv().AutoKill = v
        while AutoKill do
            local args = {[1] = "Attack"}
            game:GetService("ReplicatedStorage").RemoteEvents.Damage:FireServer(unpack(args))
            task.wait(0.3)
        end
    end
})

Farm:CreateToggle({
    Name = "Auto Skill",
    CurrentValue = false,
    Callback = function(v)
        getgenv().AutoSkill = v
        while AutoSkill do
            game:GetService("ReplicatedStorage").RemoteEvents.Skill:FireServer()
            task.wait(1)
        end
    end
})

Farm:CreateToggle({
    Name = "Auto Quest",
    CurrentValue = false,
    Callback = function(v)
        getgenv().AutoQuest = v
        while AutoQuest do
            game:GetService("ReplicatedStorage").RemoteEvents.Quest:FireServer("Accept")
            task.wait(5)
        end
    end
})

Farm:CreateButton({
    Name = "Equip Best",
    Callback = function()
        game:GetService("ReplicatedStorage").RemoteEvents.EquipBest:FireServer()
    end
})

-- RAID
local Raid = Window:CreateTab("Dungeon / Raid")

Raid:CreateToggle({
    Name = "Auto Enter Dungeon",
    CurrentValue = false,
    Callback = function(v)
        getgenv().AutoDungeon = v
        while AutoDungeon do
            game:GetService("ReplicatedStorage").RemoteEvents.Dungeon:FireServer("Enter")
            task.wait(10)
        end
    end
})

Raid:CreateToggle({
    Name = "Auto Kill Boss",
    CurrentValue = false,
    Callback = function(v)
        getgenv().AutoBoss = v
        while AutoBoss do
            game:GetService("ReplicatedStorage").RemoteEvents.Damage:FireServer("Boss")
            task.wait(0.5)
        end
    end
})

-- TRADE
local Trade = Window:CreateTab("Trade")

Trade:CreateToggle({
    Name = "Auto Accept Trade",
    CurrentValue = false,
    Callback = function(v)
        getgenv().AutoAccept = v
        while AutoAccept do
            game:GetService("ReplicatedStorage").RemoteEvents.Trade:FireServer("Accept")
            task.wait(1)
        end
    end
})

Trade:CreateToggle({
    Name = "Auto Decline Trade",
    CurrentValue = false,
    Callback = function(v)
        getgenv().AutoDecline = v
        while AutoDecline do
            game:GetService("ReplicatedStorage").RemoteEvents.Trade:FireServer("Decline")
            task.wait(1)
        end
    end
})

-- TELEPORT
local Teleport = Window:CreateTab("Teleport")

Teleport:CreateButton({
    Name = "Zona 1",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 5, 0)
    end
})

Teleport:CreateButton({
    Name = "Dungeon",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(100, 5, 100)
    end
})

Teleport:CreateButton({
    Name = "Loja",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-50, 5, -50)
    end
})

-- PLAYER
local Player = Window:CreateTab("Player")

Player:CreateButton({
    Name = "Speed x2",
    Callback = function()
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 140
    end
})

Player:CreateButton({
    Name = "Jump x2",
    Callback = function()
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 100
    end
})

-- MISC
local Misc = Window:CreateTab("Misc")

Misc:CreateButton({
    Name = "Rejoin",
    Callback = function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
    end
})

Misc:CreateButton({
    Name = "Fechar UI",
    Callback = function()
        Rayfield:Destroy()
    end
})
