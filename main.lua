-- Aguarda o jogo carregar completamente
repeat task.wait() until game:IsLoaded()
print("Script iniciado, jogo carregado!")

-- Carrega a Fluent UI (com o parâmetro true para compatibilidade)
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua", true))()
if not Fluent then
    warn("Falha ao carregar Fluent UI")
    return
end
print("Fluent carregado com sucesso!")

-- Cria a janela principal com Fluent
local Window = Fluent:CreateWindow({
    Title = "Blade Slayer Hub | by Szy",
    SubTitle = "Tora Style",
    TabWidth = 160,
    Size = UDim2.fromOffset(520, 360),
    Acrylic = true,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.RightControl
})
print("Janela criada com sucesso!")

-- Adiciona a aba "Main"
local MainTab = Window:AddTab({ Title = "Main", Icon = "rbxassetid://6026568198" })
print("Aba 'Main' criada com sucesso!")

-- Variáveis de controle
local autoFarm = false
local autoRebirth = false
local autoUpgrade = false
local autoEquip = false

-- Função de Auto Farm (simula cliques para dano)
function startAutoFarm()
    task.spawn(function()
        while autoFarm do
            pcall(function()
                game:GetService("ReplicatedStorage").Events.Click3:FireServer()
            end)
            task.wait(0.1)
        end
    end)
end

-- Função de Auto Rebirth
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

-- Função de Auto Upgrade (ativa todos os upgrades disponíveis)
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

-- Função de Auto Equip Best (equipe automaticamente o melhor item/espada)
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

-- Adiciona o toggle de Auto Farm à interface
MainTab:AddToggle({
    Title = "Auto Farm",
    Default = false,
    Callback = function(state)
        autoFarm = state
        if state then
            print("Auto Farm ativado!")
            startAutoFarm()
        else
            print("Auto Farm desativado!")
        end
    end
})

-- Adiciona o toggle de Auto Rebirth à interface
MainTab:AddToggle({
    Title = "Auto Rebirth",
    Default = false,
    Callback = function(state)
        autoRebirth = state
        if state then
            print("Auto Rebirth ativado!")
            startAutoRebirth()
        else
            print("Auto Rebirth desativado!")
        end
    end
})

-- Adiciona o toggle de Auto Upgrade à interface
MainTab:AddToggle({
    Title = "Auto Upgrade",
    Default = false,
    Callback = function(state)
        autoUpgrade = state
        if state then
            print("Auto Upgrade ativado!")
            startAutoUpgrade()
        else
            print("Auto Upgrade desativado!")
        end
    end
})

-- Adiciona o toggle de Auto Equip Best à interface
MainTab:AddToggle({
    Title = "Auto Equip Best",
    Default = false,
    Callback = function(state)
        autoEquip = state
        if state then
            print("Auto Equip Best ativado!")
            startAutoEquip()
        else
            print("Auto Equip Best desativado!")
        end
    end
})
