repeat task.wait() until game:IsLoaded()

-- Carrega Rayfield UI
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

local Window = Rayfield:CreateWindow({
    Name = "Blade Slayer Hub",
    LoadingTitle = "Blade Slayer Script",
    LoadingSubtitle = "By Szy",
    ConfigurationSaving = {
        Enabled = false
    },
    Discord = {
        Enabled = false
    },
    KeySystem = false,
})

local MainTab = Window:CreateTab("Main", 4483362458)

-- Variáveis de controle
local autoFarm = false
local autoRebirth = false
local autoEquip = false
local autoUpgrade = false

-- Funções
function startAutoFarm()
    task.spawn(function()
        while autoFarm do
            local mobs = workspace:FindFirstChild("Mobs")
            if mobs then
                for _, mob in pairs(mobs:GetChildren()) do
                    if mob:FindFirstChild("HumanoidRootPart") then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                        game:GetService("ReplicatedStorage").Remotes.Damage:FireServer(mob)
                    end
                end
            end
            task.wait(0.3)
        end
    end)
end

function startAutoRebirth()
    task.spawn(function()
        while autoRebirth do
            game:GetService("ReplicatedStorage").Remotes.Rebirth:FireServer()
            task.wait(5)
        end
    end)
end

function startAutoEquip()
    task.spawn(function()
        while autoEquip do
            game:GetService("ReplicatedStorage").Remotes.EquipBest:FireServer()
            task.wait(2)
        end
    end)
end

function startAutoUpgrade()
    task.spawn(function()
        while autoUpgrade do
            game:GetService("ReplicatedStorage").Remotes.Upgrade:FireServer("Strength")
            task.wait(2)
        end
    end)
end

-- Toggles
MainTab:CreateToggle({
    Name = "Auto Farm",
    CurrentValue = false,
    Callback = function(Value)
        autoFarm = Value
        if Value then startAutoFarm() end
    end,
})

MainTab:CreateToggle({
    Name = "Auto Rebirth",
    CurrentValue = false,
    Callback = function(Value)
        autoRebirth = Value
        if Value then startAutoRebirth() end
    end,
})

MainTab:CreateToggle({
    Name = "Auto Equip",
    CurrentValue = false,
    Callback = function(Value)
        autoEquip = Value
        if Value then startAutoEquip() end
    end,
})

MainTab:CreateToggle({
    Name = "Auto Upgrade",
    CurrentValue = false,
    Callback = function(Value)
        autoUpgrade = Value
        if Value then startAutoUpgrade() end
    end,
})
