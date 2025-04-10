-- Carregar Fluent UI
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Szy Blade Slayer Hub",
    SubTitle = "by Szy",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Darker"
})

local Tab = Window:AddTab({ Title = "Main", Icon = "sword" })

-- Variáveis de controle
local autoFarm = false
local autoRebirth = false
local autoEquip = false
local autoUpgrade = false

-- Função para encontrar e atacar NPCs
function startAutoFarm()
    task.spawn(function()
        while autoFarm do
            local mobs = workspace:FindFirstChild("Mobs")
            if mobs then
                for _, mob in pairs(mobs:GetChildren()) do
                    if mob:FindFirstChild("HumanoidRootPart") then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                        -- Simula ataque
                        local args = {[1] = mob}
                        game:GetService("ReplicatedStorage").Remotes.Damage:FireServer(unpack(args))
                    end
                end
            end
            task.wait(0.3)
        end
    end)
end

-- Auto Rebirth
function startAutoRebirth()
    task.spawn(function()
        while autoRebirth do
            game:GetService("ReplicatedStorage").Remotes.Rebirth:FireServer()
            task.wait(5)
        end
    end)
end

-- Auto Equip Best Sword
function startAutoEquip()
    task.spawn(function()
        while autoEquip do
            game:GetService("ReplicatedStorage").Remotes.EquipBest:FireServer()
            task.wait(2)
        end
    end)
end

-- Auto Upgrade
function startAutoUpgrade()
    task.spawn(function()
        while autoUpgrade do
            game:GetService("ReplicatedStorage").Remotes.Upgrade:FireServer("Strength")
            task.wait(2)
        end
    end)
end

-- Botões Fluent
Tab:AddToggle("Auto Farm", {Default = false}, function(state)
    autoFarm = state
    if state then startAutoFarm() end
end)

Tab:AddToggle("Auto Rebirth", {Default = false}, function(state)
    autoRebirth = state
    if state then startAutoRebirth() end
end)

Tab:AddToggle("Auto Equip Best", {Default = false}, function(state)
    autoEquip = state
    if state then startAutoEquip() end
end)

Tab:AddToggle("Auto Upgrade", {Default = false}, function(state)
    autoUpgrade = state
    if state then startAutoUpgrade() end
end)
