-- Carregando Rayfield
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

-- Notificação de carregamento
Rayfield:Notify({
   Title = "Szy Blade Slayer",
   Content = "Script iniciado com sucesso!",
   Duration = 5,
   Actions = {
      Ignore = {
         Name = "Fechar",
         Callback = function() end
      }
   }
})

-- Criar Janela
local Window = Rayfield:CreateWindow({
   Name = "Szy - Hub",
   LoadingTitle = "Carregando Script...",
   LoadingSubtitle = "By szy7x",
   ConfigurationSaving = {
      Enabled = false,
   },
   KeySystem = false,
})

Rayfield:LoadConfiguration()

------------------------
-- ABA: FARM
------------------------
local FarmTab = Window:CreateTab("Farm", 4483362458)

local AutoFarmToggle = FarmTab:CreateToggle({
   Name = "Auto Farm",
   CurrentValue = false,
   Flag = "AutoFarm",
   Callback = function(Value)
      _G.AutoFarm = Value
   end,
})

local AutoClickToggle = FarmTab:CreateToggle({
   Name = "Auto Click",
   CurrentValue = false,
   Flag = "AutoClick",
   Callback = function(Value)
      _G.AutoClick = Value
   end,
})

task.spawn(function()
   while true do
      task.wait()
      if _G.AutoFarm then
         pcall(function()
            for _, mob in ipairs(game:GetService("Workspace").Enemies:GetChildren()) do
               if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                  local playerHRP = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                  if playerHRP then
                     playerHRP.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0)
                     game:GetService("ReplicatedStorage").Remotes.DamageMonster:FireServer(mob)
                     wait(0.2)
                  end
               end
            end
         end)
      end
   end
end)

task.spawn(function()
   while true do
      task.wait()
      if _G.AutoClick then
         pcall(function()
            local remote = game:GetService("ReplicatedStorage").Remotes.PlayerClickAttack
            remote:FireServer()
         end)
      end
   end
end)

------------------------
-- ABA: PLAYER
------------------------
local PlayerTab = Window:CreateTab("Player", 4483362458)

PlayerTab:CreateToggle({
   Name = "Auto Rebirth",
   CurrentValue = false,
   Callback = function(v)
      _G.AutoRebirth = v
   end
})

task.spawn(function()
   while true do
      task.wait(2)
      if _G.AutoRebirth then
         pcall(function()
            game:GetService("ReplicatedStorage").Remotes.PlayerReborn:FireServer()
         end)
      end
   end
end)

PlayerTab:CreateToggle({
   Name = "Auto Equip Best Weapon",
   CurrentValue = false,
   Callback = function(v)
      _G.AutoEquip = v
   end
})

task.spawn(function()
   while true do
      task.wait(2)
      if _G.AutoEquip then
         pcall(function()
            game:GetService("ReplicatedStorage").Remotes.EquipBestWeapon:FireServer()
         end)
      end
   end
end)

------------------------
-- ABA: HEROES
------------------------
local HeroesTab = Window:CreateTab("Heroes", 4483362458)

HeroesTab:CreateToggle({
   Name = "Auto Equip Best Hero",
   CurrentValue = false,
   Callback = function(v)
      _G.AutoEquipBestHero = v
   end
})

task.spawn(function()
   while true do
      task.wait(2)
      if _G.AutoEquipBestHero then
         pcall(function()
            game:GetService("ReplicatedStorage").Remotes.AutoEquipBestHero:FireServer()
         end)
      end
   end
end)

HeroesTab:CreateToggle({
   Name = "Auto Hatch Nearest",
   CurrentValue = false,
   Callback = function(v)
      _G.AutoHatchNearest = v
   end
})

task.spawn(function()
   while true do
      task.wait(2)
      if _G.AutoHatchNearest then
         pcall(function()
            local maps = game.Workspace:FindFirstChild("Maps")
            if maps then
               for _, map in pairs(maps:GetChildren()) do
                  local eggs = map:FindFirstChild("Map") and map.Map:FindFirstChild("Eggs")
                  if eggs then
                     local egg = eggs:GetChildren()[1]
                     if egg then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = egg.CFrame
                        wait(0.5)
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game)
                        wait(0.1)
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, "E", false, game)
                     end
                  end
               end
            end
         end)
      end
   end
end)

------------------------
-- ABA: TRADE
------------------------
local TradeTab = Window:CreateTab("Trade", 4483362458)
local players = game:GetService("Players")
local tradeTarget = nil

local function updatePlayerList()
   local list = {}
   for _, p in pairs(players:GetPlayers()) do
      if p.Name ~= players.LocalPlayer.Name then
         table.insert(list, p.Name)
      end
   end
   return list
end

local dropdown = TradeTab:CreateDropdown({
   Name = "Selecionar jogador",
   Options = updatePlayerList(),
   CurrentOption = "",
   Flag = "PlayerToTrade",
   Callback = function(option)
      tradeTarget = players:FindFirstChild(option)
   end,
})

TradeTab:CreateButton({
   Name = "Enviar Troca",
   Callback = function()
      if tradeTarget then
         print("Troca enviada para:", tradeTarget.Name)
         -- Adapte com o Remote correto caso tenha
      else
         warn("Selecione um jogador")
      end
   end,
})

TradeTab:CreateButton({
   Name = "Dupe Heroes (simulado)",
   Callback = function()
      print("Dupe ativado para teste!")
   end,
})

------------------------
-- ABA: MISC / TELEPORT
------------------------
local MiscTab = Window:CreateTab("Misc", 4483362458)

local mapNames = {}
local mapsFolder = game:GetService("Workspace"):FindFirstChild("Maps")

if mapsFolder then
   for _, map in ipairs(mapsFolder:GetChildren()) do
      if map.Name then
         table.insert(mapNames, map.Name)
      end
   end
end

MiscTab:CreateDropdown({
   Name = "Teleport para o Mapa",
   Options = mapNames,
   CurrentOption = mapNames[1],
   Flag = "TeleportToMap",
   Callback = function(selected)
      local destination = mapsFolder:FindFirstChild(selected)
      if destination and destination:FindFirstChild("Map") then
         game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = destination.Map.CFrame
      end
   end,
})

-- Notificação final
Rayfield:Notify({
   Title = "Blade Slayer Script",
   Content = "Tudo pronto!",
   Duration = 4,
   Actions = {
      Ignore = {
         Name = "OK",
         Callback = function() end
      }
   }
})
