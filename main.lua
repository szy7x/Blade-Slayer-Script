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
   Name = "Szy - Hub",
   LoadingTitle = "Carregando Script...",
   LoadingSubtitle = "By szy7x",
   ConfigurationSaving = {
      Enabled = false,
   },
   KeySystem = false,
})

Rayfield:LoadConfiguration()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer

-- ABA: Farm
local FarmTab = Window:CreateTab("Farm", 4483362458)

local AutoFarmToggle = FarmTab:CreateToggle({
   Name = "Auto Farm",
   CurrentValue = false,
   Flag = "AutoFarm",
   Callback = function(Value)
      _G.AutoFarm = Value
   end,
})

task.spawn(function()
   while true do
      task.wait(0.5)
      if _G.AutoFarm then
         pcall(function()
            for _, mob in ipairs(Workspace.Enemies:GetChildren()) do
               if mob:FindFirstChild("HumanoidRootPart") then
                  local humanoidRootPart = mob.HumanoidRootPart
                  local playerHRP = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                  if playerHRP then
                     playerHRP.CFrame = humanoidRootPart.CFrame * CFrame.new(0, 3, 0)
                     wait(0.5)
                     local humanoid = mob:FindFirstChild("Humanoid")
                     if humanoid and humanoid.Health > 0 then
                        ReplicatedStorage.Remotes.DamageMonster:FireServer(mob)
                     end
                  end
               end
            end
         end)
      end
   end
end)

-- ABA: Player
local PlayerTab = Window:CreateTab("Player", 4483362458)

PlayerTab:CreateToggle({
   Name = "Auto Rebirth",
   CurrentValue = false,
   Flag = "AutoRebirth",
   Callback = function(Value)
      _G.AutoRebirth = Value
   end,
})

task.spawn(function()
   while true do
      task.wait(2)
      if _G.AutoRebirth then
         pcall(function()
            ReplicatedStorage.Remotes.PlayerReborn:FireServer()
         end)
      end
   end
end)

PlayerTab:CreateToggle({
   Name = "Auto Equip Best Weapon",
   CurrentValue = false,
   Flag = "AutoEquip",
   Callback = function(Value)
      _G.AutoEquip = Value
   end,
})

task.spawn(function()
   while true do
      task.wait(2)
      if _G.AutoEquip then
         pcall(function()
            ReplicatedStorage.Remotes.EquipBestWeapon:FireServer()
         end)
      end
   end
end)

-- ABA: Heroes
local HeroesTab = Window:CreateTab("Heroes", 4483362458)

HeroesTab:CreateToggle({
   Name = "Auto Equip Best Hero",
   CurrentValue = false,
   Flag = "AutoEquipBestHero",
   Callback = function(Value)
      _G.AutoEquipBestHero = Value
   end,
})

task.spawn(function()
   while true do
      task.wait(2)
      if _G.AutoEquipBestHero then
         pcall(function()
            ReplicatedStorage.Remotes.AutoEquipBestHero:FireServer()
         end)
      end
   end
end)

HeroesTab:CreateToggle({
   Name = "Auto Hatch Nearest",
   CurrentValue = false,
   Flag = "AutoHatchNearest",
   Callback = function(Value)
      _G.AutoHatchNearest = Value
   end,
})

task.spawn(function()
   while true do
      task.wait()
      if _G.AutoHatchNearest then
         pcall(function()
            local mapsFolder = Workspace:FindFirstChild("Maps")
            if mapsFolder then
               local currentMap = mapsFolder:GetChildren()[1]
               if currentMap and currentMap:FindFirstChild("Map") and currentMap.Map:FindFirstChild("Eggs") then
                  local egg = currentMap.Map.Eggs:GetChildren()[1]
                  player.Character.HumanoidRootPart.CFrame = egg.CFrame
                  wait(0.5)
                  game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game)
                  wait(0.2)
                  game:GetService("VirtualInputManager"):SendKeyEvent(false, "E", false, game)
               end
            end
         end)
      end
   end
end)

-- ABA: Dungeon
local DungeonTab = Window:CreateTab("Dungeon", 4483362458)

local raidVars = {
   s = "Room1",
   diff = 1,
   mapid = 50201,
   table = {"Room1", "Room2", "Room3"},
   dtable = {"1", "2", "3"},
   fraid = false,
   hero = {guid = "null", index = 1, skill = true, id = 101},
}

DungeonTab:CreateDropdown({
   Name = "Select Room",
   Options = raidVars.table,
   CurrentOption = raidVars.s,
   Callback = function(v) raidVars.s = v end,
})

DungeonTab:CreateDropdown({
   Name = "Select difficulty",
   Options = raidVars.dtable,
   CurrentOption = tostring(raidVars.diff),
   Callback = function(v) raidVars.diff = tonumber(v) end,
})

DungeonTab:CreateInput({
   Name = "Insert map ID",
   PlaceholderText = "Ex: 50201",
   RemoveTextAfterFocusLost = false,
   Callback = function(v) raidVars.mapid = tonumber(v) end,
})

DungeonTab:CreateButton({
   Name = "Raid lobby",
   Callback = function()
      ReplicatedStorage.Remotes.LocalPlayerTeleport:FireServer({mapId = 50201})
   end
})

DungeonTab:CreateButton({
   Name = "Start raid",
   Callback = function()
      Rayfield:Notify({Title = "Raid", Content = "Don't move, auto kill is enabled.", Duration = 5})
      ReplicatedStorage.Remotes.EnterRaidRoom:FireServer(raidVars.s)
      wait(0.1)
      ReplicatedStorage.Remotes.SelectRaidsDifficulty:FireServer({difficulty = raidVars.diff, roomName = raidVars.s, selectMapId = raidVars.mapid})
      wait(0.1)
      ReplicatedStorage.Remotes.StartChallengeRaidMap:InvokeServer({userIds = {player.UserId}, roomName = raidVars.s})
   end
})

DungeonTab:CreateToggle({
   Name = "Start raid + Auto kill",
   CurrentValue = false,
   Callback = function(v)
      raidVars.fraid = v
      if v then
         Rayfield:Notify({Title = "Raid", Content = "Auto Kill ON - Não se mova!", Duration = 5})
         ReplicatedStorage.Remotes.EnterRaidRoom:FireServer(raidVars.s)
         wait(0.1)
         ReplicatedStorage.Remotes.SelectRaidsDifficulty:FireServer({difficulty = raidVars.diff, roomName = raidVars.s, selectMapId = raidVars.mapid})
         wait(0.1)
         ReplicatedStorage.Remotes.StartChallengeRaidMap:InvokeServer({userIds = {player.UserId}, roomName = raidVars.s})
         wait(0.5)
         task.spawn(function()
            while raidVars.fraid do
               task.wait()
               if #Workspace.Enemys:GetChildren() < 1 then
                  if Workspace:FindFirstChild("EnchantChest") then
                     firetouchinterest(Workspace.EnchantChest.Part, player.Character.HumanoidRootPart, 0)
                     wait(0.1)
                     firetouchinterest(Workspace.EnchantChest.Part, player.Character.HumanoidRootPart, 1)
                     ReplicatedStorage.Remotes.QuitRaidsMap:InvokeServer({currentSlotIndex = 1, toMapId = 50201})
                     raidVars.fraid = false
                  else
                     Rayfield:Notify({Title = "Raid", Content = "Pls join raid. #Failed", Duration = 5})
                     raidVars.fraid = false
                  end
               else
                  for _, get in ipairs(Workspace.Enemys:GetChildren()) do
                     local guid = get:GetAttribute("EnemyGuid")
                     ReplicatedStorage.Remotes.PlayerClickAttack:FireServer(guid)
                     ReplicatedStorage.Remotes.PlayerRespirationSkillAttack:InvokeServer(guid)
                     if raidVars.hero.guid ~= "null" then
                        ReplicatedStorage.Remotes.ClickEnemy:InvokeServer(guid)
                        ReplicatedStorage.Remotes.HeroSkillHarm:FireServer({harmIndex = raidVars.hero.index, isSkill = raidVars.hero.skill, heroGuid = raidVars.hero.guid, skillId = raidVars.hero.id})
                        ReplicatedStorage.Remotes.RespirationSkillHarm:FireServer({harmIndex = raidVars.hero.index, skillId = raidVars.hero.id})
                     end
                  end
               end
            end
         end)
      end
   end
})

-- Finalização
Rayfield:Notify({
   Title = "Blade Slayer Script",
   Content = "Tudo pronto!",
   Duration = 4,
   Image = nil,
   Actions = {
      Ignore = {
         Name = "OK",
         Callback = function() end
      }
   }
})
