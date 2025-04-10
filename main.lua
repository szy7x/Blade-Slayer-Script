-- Carrega Fluent
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- Cria a Janela
local Window = Fluent:CreateWindow({
    Title = "Blade Slayer Hub | Tora Style",
    SubTitle = "by Szy",
    TabWidth = 160,
    Size = UDim2.fromOffset(520, 360),
    Acrylic = true,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.RightControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "home" })
}

-- Variáveis
local autoFarm = false
local autoRebirth = false
local autoUpgrade = false
local autoEquip = false

-- Funções
function startAutoFarm()
    task.spawn(function()
        while autoFarm do
            pcall(function()
                game:GetService("ReplicatedStorage").Events.Click3:FireServer()
            end)
            task.wait()
        end
    end)
end

function startAutoRebirth()
    task.spawn(function()
        while autoRebirth do
            pcall(function()
                game:GetService("ReplicatedStorage").Events.Rebirth:FireServer()
            end)
            task.wait(2)
        end
    end)
end

function startAutoUpgrade()
    task.spawn(function()
        while autoUpgrade do
            pcall(function()
                for _, v in pairs(game:GetService("ReplicatedStorage").Events.Upgrade:GetChildren()) do
                    v:FireServer()
                end
            end)
            task.wait(2)
        end
    end)
end

function startAutoEquip()
    task.spawn(function()
        while autoEquip do
            pcall(function()
                game:GetService("ReplicatedStorage").Events.EquipBest:FireServer()
            end)
            task.wait(3)
        end
    end)
end

-- Botões e Toggles na GUI
Tabs.Main:AddToggle("Auto Farm", { Default = false }, function(state)
    autoFarm = state
    if state then startAutoFarm() end
end)

Tabs.Main:AddToggle("Auto Rebirth", { Default = false }, function(state)
    autoRebirth = state
    if state then startAutoRebirth() end
end)

Tabs.Main:AddToggle("Auto Upgrade", { Default = false }, function(state)
    autoUpgrade = state
    if state then startAutoUpgrade() end
end)

Tabs.Main:AddToggle("Auto Equip Best", { Default = false }, function(state)
    autoEquip = state
    if state then startAutoEquip() end
end)
