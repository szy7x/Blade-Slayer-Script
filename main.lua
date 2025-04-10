repeat task.wait() until game:IsLoaded()

-- Carrega Fluent com verificação do parâmetro "true" para compatibilidade
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua", true))()

local Window = Fluent:CreateWindow({
    Title = "Blade Slayer Hub | by Szy",
    SubTitle = "🇧🇷",
    TabWidth = 160,
    Size = UDim2.fromOffset(520, 360),
    Acrylic = true,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.RightControl
})

local MainTab = Window:AddTab({ Title = "Main", Icon = "rbxassetid://6026568198" })

-- Variáveis de controle
local autoFarm = false
local autoRebirth = false
local autoUpgrade = false
local autoEquip = false

-- Função de Auto Farm: simula clique automático (ajuste o Remote conforme necessário)
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

-- Função de Auto Rebirth: simula o rebirth automático
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

-- Função de Auto Upgrade: percorre os upgrades e ativa cada um
function startAutoUpgrade()
    task.spawn(function()
        while autoUpgrade do
            pcall(function()
                for _, upgrade in pairs(game:GetService("ReplicatedStorage").Events.Upgrade:GetChildren()) do
                    upgrade:FireServer()
                end
            end)
            task.wait(2)
        end
    end)
end

-- Função de Auto Equip: equipar automaticamente o melhor item/espada
function startAutoEquip()
    task.spawn(function()
        while autoEquip do
            pcall(function()
                game:GetService("ReplicatedStorage").Events["Equip Best"]:FireServer()
            end)
            task.wait(3)
        end
    end)
end

-- Adiciona os toggles à interface
MainTab:AddToggle({
    Title = "Auto Farm",
    Default = false,
    Callback = function(state)
        autoFarm = state
        if state then startAutoFarm() end
    end
})

MainTab:AddToggle({
    Title = "Auto Rebirth",
    Default = false,
    Callback = function(state)
        autoRebirth = state
        if state then startAutoRebirth() end
    end
})

MainTab:AddToggle({
    Title = "Auto Upgrade",
    Default = false,
    Callback = function(state)
        autoUpgrade = state
        if state then startAutoUpgrade() end
    end
})

MainTab:AddToggle({
    Title = "Auto Equip Best",
    Default = false,
    Callback = function(state)
        autoEquip = state
        if state then startAutoEquip() end
    end
})
