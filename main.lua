-- Carregando Rayfield
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

Rayfield:Notify({
   Title = "Szy Blade Slayer",
   Content = "Script iniciado com sucesso!",
   Duration = 5,
   Actions = {
      Ignore = { Name = "Fechar", Callback = function() end }
   }
})

local Window = Rayfield:CreateWindow({
   Name = "Szy - Hub",
   LoadingTitle = "Carregando Script...",
   LoadingSubtitle = "By szy7x",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false,
})

Rayfield:LoadConfiguration()

local FarmTab = Window:CreateTab("Farm", 4483362458)
local PlayerTab = Window:CreateTab("Player", 4483362458)
local HeroesTab = Window:CreateTab("Heroes", 4483362458)
local TradeTab = Window:CreateTab("Trade", 4483362458)
local TeleportTab = Window:CreateTab("Teleport", 4483362458)
local MiscTab = Window:CreateTab("Misc", 4483362458)
local GemsHackTab = Window:CreateTab("Gem Hacks", 4483362458)

-- Funções globais
_G.AutoFarm = false
_G.AutoClick = false
_G.AutoRebirth = false
_G.AutoEquip = false
_G.AutoEquipBestHero = false
_G.AutoHatchNearest = false
_G.KillAura = false
_G.NearbyKillAura = false

-- Auto Farm
FarmTab:CreateToggle({
   Name = "Auto Farm",
   CurrentValue = false,
   Flag = "AutoFarm",
   Callback = function(Value)
      _G.AutoFarm = Value
   end,
})

task.spawn(function()
   while task.wait(0.5) do
      if _G.AutoFarm then
         pcall(function()
            for _, mob in ipairs(workspace.Enemies:GetChildren()) do
               if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                  local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                  if hrp then
                     hrp.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0)
                     wait(0.25)
                     game.ReplicatedStorage.Remotes.DamageMonster:FireServer(mob)
                  end
               end
            end
         end)
      end
   end
end)

-- Auto Click
FarmTab:CreateToggle({
   Name = "Auto Click",
   CurrentValue = false,
   Flag = "AutoClick",
   Callback = function(Value)
      _G.AutoClick = Value
   end,
})

task.spawn(function()
   while task.wait() do
      if _G.AutoClick then
         pcall(function()
            local remote = game.ReplicatedStorage.Remotes.PlayerClickAttack
            remote:FireServer()
            remote:FireServer()
         end)
      end
   end
end)

-- Kill Aura
FarmTab:CreateToggle({
   Name = "Kill Aura",
   CurrentValue = false,
   Flag = "KillAura",
   Callback = function(Value)
      _G.KillAura = Value
   end,
})

task.spawn(function()
   while task.wait(0.5) do
      if _G.KillAura then
         pcall(function()
            for _, mob in ipairs(workspace.Enemies:GetChildren()) do
               if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                  game.ReplicatedStorage.Remotes.DamageMonster:FireServer(mob)
               end
            end
         end)
      end
   end
end)

-- Nearby Kill Aura
MiscTab:CreateToggle({
   Name = "Kill Aura - Inimigos Perto",
   CurrentValue = false,
   Flag = "NearbyKillAura",
   Callback = function(Value)
      _G.NearbyKillAura = Value
   end,
})

task.spawn(function()
   while task.wait(0.5) do
      if _G.NearbyKillAura then
         pcall(function()
            for _, mob in ipairs(workspace.Enemies:GetChildren()) do
               local mobHRP = mob:FindFirstChild("HumanoidRootPart")
               if mobHRP and (mobHRP.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 20 then
                  game.ReplicatedStorage.Remotes.DamageMonster:FireServer(mob)
               end
            end
         end)
      end
   end
end)

-- Auto Rebirth
PlayerTab:CreateToggle({
   Name = "Auto Rebirth",
   CurrentValue = false,
   Flag = "AutoRebirth",
   Callback = function(Value)
      _G.AutoRebirth = Value
   end,
})

task.spawn(function()
   while task.wait(2) do
      if _G.AutoRebirth then
         pcall(function()
            game.ReplicatedStorage.Remotes.PlayerReborn:FireServer()
         end)
      end
   end
end)

-- Auto Equip
PlayerTab:CreateToggle({
   Name = "Auto Equip Best Weapon",
   CurrentValue = false,
   Flag = "AutoEquip",
   Callback = function(Value)
      _G.AutoEquip = Value
   end,
})

task.spawn(function()
   while task.wait(2) do
      if _G.AutoEquip then
         pcall(function()
            game.ReplicatedStorage.Remotes.EquipBestWeapon:FireServer()
         end)
      end
   end
end)

-- Auto Equip Hero
HeroesTab:CreateToggle({
   Name = "Auto Equip Best Hero",
   CurrentValue = false,
   Flag = "AutoEquipBestHero",
   Callback = function(Value)
      _G.AutoEquipBestHero = Value
   end,
})

task.spawn(function()
   while task.wait(2) do
      if _G.AutoEquipBestHero then
         pcall(function()
            game.ReplicatedStorage.Remotes.AutoEquipBestHero:FireServer()
         end)
      end
   end
end)

-- Auto Hatch
HeroesTab:CreateToggle({
   Name = "Auto Hatch Nearest",
   CurrentValue = false,
   Flag = "AutoHatchNearest",
   Callback = function(Value)
      _G.AutoHatchNearest = Value
   end,
})

task.spawn(function()
   while task.wait(2) do
      if _G.AutoHatchNearest then
         pcall(function()
            local maps = workspace:FindFirstChild("Maps")
            if maps then
               local map = maps:GetChildren()[1]
               if map and map:FindFirstChild("Map") and map.Map:FindFirstChild("Eggs") then
                  local egg = map.Map.Eggs:GetChildren()[1]
                  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = egg.CFrame
                  task.wait(0.3)
                  local vim = game:GetService("VirtualInputManager")
                  vim:SendKeyEvent(true, "E", false, game)
                  task.wait(0.1)
                  vim:SendKeyEvent(false, "E", false, game)
               end
            end
         end)
      end
   end
end)

-- ABA: Teleport
local TeleportTab = Window:CreateTab("Teleport", 4483362458)
local MapsFolder = game:GetService("Workspace"):WaitForChild("Maps")

local function getMaps()
   local mapList = {}
   for _, map in pairs(MapsFolder:GetChildren()) do
      table.insert(mapList, map.Name)
   end
   return mapList
end

TeleportTab:CreateDropdown({
   Name = "Selecionar Mapa",
   Options = getMaps(),
   CurrentOption = getMaps()[1],
   Flag = "MapaSelecionado",
   Callback = function(MapName)
      local map = MapsFolder:FindFirstChild(MapName)
      if map and map:FindFirstChild("Spawn") then
         game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = map.Spawn.CFrame
      end
   end,
})

-- ABA: Misc
local MiscTab = Window:CreateTab("Misc", 4483362458)

MiscTab:CreateToggle({
   Name = "Kill Aura Inimigos Próximos",
   CurrentValue = false,
   Flag = "NearbyKillAura",
   Callback = function(Value)
      _G.NearbyKillAura = Value
   end,
})

task.spawn(function()
   while true do
      wait(0.25)
      if _G.NearbyKillAura then
         pcall(function()
            local playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
            for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
               if enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid") then
                  local distance = (enemy.HumanoidRootPart.Position - playerPos).Magnitude
                  if distance < 15 and enemy.Humanoid.Health > 0 then
                     game:GetService("ReplicatedStorage").Remotes.DamageMonster:FireServer(enemy)
                  end
               end
            end
         end)
      end
   end
end)

-- ABA: Gem Hacks
local GemHackTab = Window:CreateTab("Gem Hacks", 4483362458)

-- Função base
local function getDecomposeSelectedGems()
   local selected = {}
   for _, gem in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
      if gem:IsA("Tool") and gem.Name:match("Gem") and gem:FindFirstChild("Level") then
         if gem:FindFirstChild("Selected") and gem.Selected.Value == true then
            table.insert(selected, gem)
         end
      end
   end
   return selected
end

-- Método 1: Corrida de Condição
GemHackTab:CreateButton({
   Name = "Gem Hack - Método Race Condition",
   Callback = function()
      local gems = getDecomposeSelectedGems()
      for _, gem in pairs(gems) do
         for i = 1, 5 do
            task.spawn(function()
               game:GetService("ReplicatedStorage").Remotes.DecomposeGem:FireServer(gem)
            end)
         end
      end
   end,
})

-- Método 2: Clone Backpack (experimental)
GemHackTab:CreateButton({
   Name = "Gem Hack - Backpack Clone",
   Callback = function()
      local gems = getDecomposeSelectedGems()
      for _, gem in pairs(gems) do
         local clone = gem:Clone()
         clone.Parent = game:GetService("Players").LocalPlayer.Backpack
         game:GetService("ReplicatedStorage").Remotes.DecomposeGem:FireServer(clone)
         wait(0.25)
      end
   end,
})

-- Método 3: Delay Decompose
GemHackTab:CreateButton({
   Name = "Gem Hack - Delay Decompose",
   Callback = function()
      local gems = getDecomposeSelectedGems()
      for _, gem in pairs(gems) do
         wait(0.5)
         game:GetService("ReplicatedStorage").Remotes.DecomposeGem:FireServer(gem)
      end
   end,
})

-- Modo Turbo
GemHackTab:CreateButton({
   Name = "Gem Hack - MODO TURBO",
   Callback = function()
      local gems = getDecomposeSelectedGems()
      for _, gem in pairs(gems) do
         -- Método 1
         for i = 1, 3 do
            task.spawn(function()
               game:GetService("ReplicatedStorage").Remotes.DecomposeGem:FireServer(gem)
            end)
         end
         -- Método 2
         local clone = gem:Clone()
         clone.Parent = game:GetService("Players").LocalPlayer.Backpack
         game:GetService("ReplicatedStorage").Remotes.DecomposeGem:FireServer(clone)
         wait(0.1)
         -- Método 3
         wait(0.3)
         game:GetService("ReplicatedStorage").Remotes.DecomposeGem:FireServer(gem)
      end
   end,
})

Rayfield:Notify({
   Title = "Gem Hack Ativado",
   Content = "Teste os métodos! Resultados podem variar.",
   Duration = 6,
   Image = nil,
   Actions = {
      Ignore = {
         Name = "Fechar",
         Callback = function() end
      }
   }
})
