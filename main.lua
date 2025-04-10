repeat task.wait() until game:IsLoaded()

-- Carrega Fluent
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Blade Slayer Hub | by Szy",
    SubTitle = "Tora Style",
    TabWidth = 160,
    Size = UDim2.fromOffset(500, 350),
    Acrylic = true,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.RightControl
})

local Tab = Window:AddTab({ Title = "Main", Icon = "rbxassetid://6026568198" })

-- Variáveis de controle
local autoFarm = false
local autoRebirth = false
local autoEquip = false
local autoUpgrade = false

-- Funções
local function startAutoFarm()
    task.spawn(function()
        while autoFarm do
            local mobs = workspace:FindFirstChild("Mobs")
            if mobs then
                for _, mob in ipairs(mobs:GetChildren()) do
                    if mob:FindFirstChild("HumanoidRootPart") then
                        local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            hrp.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                            game:GetService("ReplicatedStorage").Remotes.Damage:FireServer(mob)
                        end
                    end
                end
            end
            task.wait(0.3)
        end
    end)
end

local function startAutoRebirth()
    task.spawn(function()
        while autoRebirth do
            game:GetService("ReplicatedStorage").Remotes.Rebirth:FireServer()
            task.wait(5)
        end
    end)
end

local function startAutoEquip()
    task.spawn(function()
        while autoEquip do
            game:GetService("ReplicatedStorage").Remotes.EquipBest:FireServer()
            task.wait(2)
        end
    end)
end

local function startAutoUpgrade()
    task.spawn(function()
        while autoUpgrade do
            game:GetService("ReplicatedStorage").Remotes.Upgrade:FireServer("Strength")
            task.wait(2)
        end
    end)
end

-- Adiciona os botões na aba Fluent
Tab:AddToggle("Auto Farm", {Default = false}, function(state)
    autoFarm = state
    if state then startAutoFarm() end
end)

Tab:AddToggle("Auto Rebirth", {Default = false}, function(state)
    autoRebirth = state
    if state then startAutoRebirth() end
end)

Tab:AddToggle("Auto Equip", {Default = false}, function(state)
    autoEquip = state
    if state then startAutoEquip() end
end)

Tab:AddToggle("Auto Upgrade", {Default = false}, function(state)
    autoUpgrade = state
    if state then startAutoUpgrade() end
end)
