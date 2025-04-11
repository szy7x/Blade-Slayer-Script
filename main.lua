-- Carregando Rayfield
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

-- Notificação de carregamento
Rayfield:Notify({
   Title = "Szy Blade Slayer",
   Content = "Script iniciado com sucesso!",
   Duration = 5,
   Image = nil,
   Actions = {
      Ignore = {
         Name = "Fechar",
         Callback = function() end
      }
   }
})

-- Criar Janela
local Window = Rayfield:CreateWindow({
   Name = "Szy - Hub | Blade Slayer",
   LoadingTitle = "Carregando Script...",
   LoadingSubtitle = "By szy7x",
   ConfigurationSaving = {
      Enabled = false,
   },
   KeySystem = false,
})

Rayfield:LoadConfiguration()

-- Variáveis globais
getgenv().autoFarm = false
getgenv().autoClick = false
getgenv().killAura = false
getgenv().autoRebirth = false
getgenv().equipBestWeapon = false
getgenv().equipBestHero = false
getgenv().autoHatch = false

-- Serviços
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Função de Auto Click
function startAutoClick()
    while getgenv().autoClick do
        local click = ReplicatedStorage.Remotes.Click
        if click then
            click:FireServer()
        end
        task.wait(0.1)
    end
end

-- Função de Equipar Best Weapon
function equipBest()
    ReplicatedStorage.Remotes.EquipBestWeapon:FireServer()
end

-- Função de Equipar Best Hero
function equipBestHero()
    ReplicatedStorage.Remotes.EquipBestHero:FireServer()
end

-- Função de Rebirth
function autoRebirth()
    while getgenv().autoRebirth do
        ReplicatedStorage.Remotes.Rebirth:FireServer()
        task.wait(5)
    end
end

local FarmTab = Window:CreateTab("🌾 Farm", 4483362458)

-- Auto Farm
FarmTab:CreateToggle({
    Name = "Auto Farm",
    CurrentValue = false,
    Flag = "AutoFarm",
    Callback = function(Value)
        getgenv().autoFarm = Value
        if Value then
            task.spawn(function()
                while getgenv().autoFarm do
                    local mobs = workspace:FindFirstChild("Enemies")
                    if mobs then
                        for _, mob in pairs(mobs:GetChildren()) do
                            if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                                LocalPlayer.Character:PivotTo(mob.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3))
                                ReplicatedStorage.Remotes.Click:FireServer()
                                repeat
                                    ReplicatedStorage.Remotes.Click:FireServer()
                                    task.wait(0.1)
                                until mob.Humanoid.Health <= 0 or not getgenv().autoFarm
                            end
                        end
                    end
                    task.wait(0.5)
                end
            end)
        end
    end,
})

-- Kill Aura
local killAuraRange = 10
FarmTab:CreateSlider({
    Name = "Kill Aura Distância",
    Range = {5, 50},
    Increment = 1,
    Suffix = "metros",
    CurrentValue = 10,
    Flag = "AuraDistance",
    Callback = function(Value)
        killAuraRange = Value
    end,
})

FarmTab:CreateToggle({
    Name = "Kill Aura",
    CurrentValue = false,
    Flag = "KillAura",
    Callback = function(Value)
        getgenv().killAura = Value
        if Value then
            task.spawn(function()
                while getgenv().killAura do
                    local mobs = workspace:FindFirstChild("Enemies")
                    if mobs then
                        for _, mob in pairs(mobs:GetChildren()) do
                            if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") then
                                local distance = (mob.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                                if distance <= killAuraRange and mob.Humanoid.Health > 0 then
                                    ReplicatedStorage.Remotes.Click:FireServer()
                                end
                            end
                        end
                    end
                    task.wait(0.1)
                end
            end)
        end
    end,
})

-- Auto Click
FarmTab:CreateToggle({
    Name = "Auto Click",
    CurrentValue = false,
    Flag = "AutoClick",
    Callback = function(Value)
        getgenv().autoClick = Value
        if Value then
            task.spawn(startAutoClick)
        end
    end,
})

-- Equipar Melhor Arma
FarmTab:CreateButton({
    Name = "Equipar Melhor Arma",
    Callback = equipBest,
})

-- Auto Rebirth
FarmTab:CreateToggle({
    Name = "Auto Rebirth",
    CurrentValue = false,
    Flag = "AutoRebirth",
    Callback = function(Value)
        getgenv().autoRebirth = Value
        if Value then
            task.spawn(autoRebirth)
        end
    end,
})

-- 🧍 PLAYER
local PlayerTab = Window:CreateTab("🏃 Player", 4483362361)

PlayerTab:CreateSlider({
	Name = "Velocidade",
	Range = {16, 200},
	Increment = 1,
	Suffix = "Velocidade",
	CurrentValue = 16,
	Flag = "Speed",
	Callback = function(Value)
		LocalPlayer.Character.Humanoid.WalkSpeed = Value
	end,
})

PlayerTab:CreateSlider({
	Name = "Pulo",
	Range = {50, 200},
	Increment = 1,
	Suffix = "Altura",
	CurrentValue = 50,
	Flag = "Jump",
	Callback = function(Value)
		LocalPlayer.Character.Humanoid.JumpPower = Value
	end,
})

PlayerTab:CreateSlider({
	Name = "Gravidade",
	Range = {0, 196.2},
	Increment = 1,
	Suffix = "Gravidade",
	CurrentValue = 196.2,
	Flag = "Gravity",
	Callback = function(Value)
		workspace.Gravity = Value
	end,
})

-- 🗺️ TELEPORT
local TeleportTab = Window:CreateTab("🌍 Teleport", 4483362458)

local teleportLocations = {
	"Map1", "Map2", "Map3", "Map4", "Map5",
	"Map6", "Map7", "Map8", "Map9", "Map10",
	"Map11", "Map12", "Map13", "Map14", "Map15"
}

for _, map in ipairs(teleportLocations) do
	TeleportTab:CreateButton({
		Name = "Teleportar para " .. map,
		Callback = function()
			local target = workspace:FindFirstChild(map)
			if target and target:FindFirstChild("Spawn") then
				LocalPlayer.Character:PivotTo(target.Spawn.CFrame + Vector3.new(0, 5, 0))
			end
		end,
	})
end

-- 🥚 AUTO HATCH
local HatchTab = Window:CreateTab("🥚 Hatch", 4483362253)

local eggList = {"Common Egg", "Rare Egg", "Epic Egg", "Legendary Egg"} -- editar se quiser

HatchTab:CreateDropdown({
	Name = "Selecionar Ovo",
	Options = eggList,
	CurrentOption = eggList[1],
	Flag = "SelectedEgg",
	Callback = function(Option)
		selectedEgg = Option
	end,
})

HatchTab:CreateToggle({
	Name = "Auto Hatch Ovo",
	CurrentValue = false,
	Flag = "AutoHatch",
	Callback = function(Value)
		getgenv().autoHatch = Value
		if Value then
			task.spawn(function()
				while getgenv().autoHatch do
					ReplicatedStorage.Remotes.Hatch:InvokeServer(selectedEgg, 1)
					task.wait(1)
				end
			end)
		end
	end,
})

-- 🔁 TRADE
local TradeTab = Window:CreateTab("🔄 Trade", 4483362438)

TradeTab:CreateDropdown({
	Name = "Selecionar Jogador",
	Options = getPlayers(),
	CurrentOption = getPlayers()[1] or "Ninguém",
	Flag = "TradeTarget",
	Callback = function(Option)
		selectedPlayer = Option
	end,
})

TradeTab:CreateButton({
	Name = "Enviar Pedido de Trade",
	Callback = function()
		if selectedPlayer then
			ReplicatedStorage.Remotes.RequestTrade:FireServer(selectedPlayer)
		end
	end,
})

-- 💎 GEM HACKS
local GemTab = Window:CreateTab("💎 Gem Hacks", 4483362398)

GemTab:CreateButton({
	Name = "Hack de Gemas 1 (Antes de Decompor)",
	Callback = function()
		local selectedGem = getSelectedGem()
		if selectedGem then
			ReplicatedStorage.Remotes.Decompose:InvokeServer({selectedGem})
		end
	end,
})

GemTab:CreateButton({
	Name = "Hack de Gemas 2 (Race Condition)",
	Callback = function()
		local selectedGem = getSelectedGem()
		if selectedGem then
			task.spawn(function()
				for i = 1, 5 do
					ReplicatedStorage.Remotes.UpgradeGem:FireServer(selectedGem)
					ReplicatedStorage.Remotes.Decompose:InvokeServer({selectedGem})
				end
			end)
		end
	end,
})

GemTab:CreateButton({
	Name = "Hack de Gemas 3 (Spam Upgrade)",
	Callback = function()
		local selectedGem = getSelectedGem()
		if selectedGem then
			for i = 1, 10 do
				ReplicatedStorage.Remotes.UpgradeGem:FireServer(selectedGem)
			end
		end
	end,
})

GemTab:CreateButton({
	Name = "Modo Turbo de Duplicação",
	Callback = function()
		local selectedGem = getSelectedGem()
		if selectedGem then
			for i = 1, 3 do
				ReplicatedStorage.Remotes.UpgradeGem:FireServer(selectedGem)
				ReplicatedStorage.Remotes.Decompose:InvokeServer({selectedGem})
				task.wait(0.2)
			end
		end
	end,
})
