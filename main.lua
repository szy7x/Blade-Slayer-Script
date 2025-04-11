-- Carregar Rayfield
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

Rayfield:Notify({
   Title = "Szy Blade Slayer",
   Content = "Script iniciado com sucesso!",
   Duration = 5,
   Actions = { Ignore = { Name = "Fechar", Callback = function() end } }
})

local Window = Rayfield:CreateWindow({
   Name = "Szy - Hub",
   LoadingTitle = "Carregando Script...",
   LoadingSubtitle = "By szy7x",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false,
})

-- ABA: Farm
local FarmTab = Window:CreateTab("Farm", 13644397228) -- Espada

local AutoFarm = false

FarmTab:CreateToggle({
   Name = "Auto Farm",
   CurrentValue = false,
   Flag = "AutoFarm",
   Callback = function(Value)
      AutoFarm = Value
   end,
})

task.spawn(function()
   while true do
      task.wait()
      if AutoFarm then
         pcall(function()
            for _, mob in ipairs(game:GetService("Workspace").Enemies:GetChildren()) do
               if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                  local playerHRP = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                  if playerHRP then
                     playerHRP.CFrame = mob.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                     wait(0.3)
                     game:GetService("ReplicatedStorage").Remotes.DamageMonster:FireServer(mob)
                  end
               end
            end
         end)
      end
   end
end)

-- Kill Aura
FarmTab:CreateToggle({
   Name = "Kill Aura (Inimigos Próximos)",
   CurrentValue = false,
   Flag = "KillAura",
   Callback = function(Value)
      _G.KillAura = Value
   end,
})

task.spawn(function()
   while true do
      wait(0.3)
      if _G.KillAura then
         for _, mob in ipairs(game:GetService("Workspace").Enemies:GetChildren()) do
            if mob:FindFirstChild("HumanoidRootPart") and (mob.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 15 then
               game:GetService("ReplicatedStorage").Remotes.DamageMonster:FireServer(mob)
            end
         end
      end
   end
end)

-- ABA: Player
local PlayerTab = Window:CreateTab("Player", 13644397268) -- Avatar

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
      wait(2)
      if _G.AutoRebirth then
         game:GetService("ReplicatedStorage").Remotes.PlayerReborn:FireServer()
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
      wait(2)
      if _G.AutoEquip then
         game:GetService("ReplicatedStorage").Remotes.EquipBestWeapon:FireServer()
      end
   end
end)

-- ABA: Dungeon/Raid
local DungeonTab = Window:CreateTab("Dungeon/Raid", 13644405217) -- Cristal

DungeonTab:CreateToggle({
   Name = "Auto Hatch",
   CurrentValue = false,
   Flag = "AutoHatch",
   Callback = function(Value)
      _G.AutoHatch = Value
   end,
})

task.spawn(function()
   while true do
      wait(1.5)
      if _G.AutoHatch then
         game:GetService("ReplicatedStorage").Remotes.HatchEgg:InvokeServer("Common")
      end
   end
end)

-- ABA: Trade
local TradeTab = Window:CreateTab("Trade", 13644397243) -- Troca

TradeTab:CreateButton({
   Name = "Tentar Duplicar Herói",
   Callback = function()
      game:GetService("ReplicatedStorage").Remotes.TradeHero:InvokeServer("DupeMethod")
   end,
})

-- ABA: Teleport
local TeleportTab = Window:CreateTab("Teleport", 13644397281) -- Portal

local teleportCoords = {
   ["Map 1"] = Vector3.new(0, 0, 0),
   ["Map 2"] = Vector3.new(50, 0, 0),
   ["Map 3"] = Vector3.new(100, 0, 0),
   ["Map 4"] = Vector3.new(150, 0, 0),
   ["Map 5"] = Vector3.new(200, 0, 0),
   ["Map 6"] = Vector3.new(250, 0, 0),
   ["Map 7"] = Vector3.new(300, 0, 0),
   ["Map 8"] = Vector3.new(350, 0, 0),
   ["Map 9"] = Vector3.new(400, 0, 0),
   ["Map 10"] = Vector3.new(450, 0, 0),
   ["Map 11"] = Vector3.new(500, 0, 0),
   ["Map 12"] = Vector3.new(550, 0, 0),
   ["Map 13"] = Vector3.new(600, 0, 0),
   ["Map 14"] = Vector3.new(650, 0, 0),
   ["Map 15"] = Vector3.new(700, 0, 0),
}

for mapName, position in pairs(teleportCoords) do
   TeleportTab:CreateButton({
      Name = mapName,
      Callback = function()
         local char = game.Players.LocalPlayer.Character
         if char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = CFrame.new(position)
         end
      end,
   })
end

-- ABA: Gem Hacks
local GemTab = Window:CreateTab("Gem Hacks", 13644405812) -- Diamante

local function getSelectedGem()
   local ui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("MainUI")
   if not ui then return nil end
   local selected = ui:FindFirstChild("SelectedGem")
   return selected and selected.Value or nil
end

-- Método 1
GemTab:CreateButton({
   Name = "Gem Hack - Método 1",
   Callback = function()
      local gem = getSelectedGem()
      if gem then
         game:GetService("ReplicatedStorage").Remotes.DupeGem:FireServer(gem, "method1")
      end
   end,
})

-- Método 2
GemTab:CreateButton({
   Name = "Gem Hack - Método 2",
   Callback = function()
      local gem = getSelectedGem()
      if gem then
         game:GetService("ReplicatedStorage").Remotes.DupeGem:FireServer(gem, "method2")
      end
   end,
})

-- Race Condition
GemTab:CreateButton({
   Name = "Race Condition (Antes de Decompor)",
   Callback = function()
      local gem = getSelectedGem()
      if gem then
         for i = 1, 5 do
            game:GetService("ReplicatedStorage").Remotes.DupeGem:FireServer(gem, "race")
            wait(0.1)
         end

-- ABA: Player
local PlayerTab = Window:CreateTab("Player", 13644402082) -- Ícone de boneco

PlayerTab:CreateSlider({
   Name = "Velocidade",
   Range = {16, 200},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

PlayerTab:CreateSlider({
   Name = "Pulo",
   Range = {50, 200},
   Increment = 1,
   CurrentValue = 50,
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
   end,
})

-- ABA: Misc
local MiscTab = Window:CreateTab("Misc", 13644405036) -- Engrenagem

MiscTab:CreateToggle({
   Name = "Kill Aura (Inimigos Próximos)",
   CurrentValue = false,
   Callback = function(Value)
      _G.KillAura = Value
   end,
})

task.spawn(function()
   while true do
      wait(0.3)
      if _G.KillAura then
         for _, mob in pairs(game:GetService("Workspace").Mobs:GetChildren()) do
            if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
               local dist = (mob.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
               if dist <= 20 then
                  game:GetService("ReplicatedStorage").Remotes.DamageMonster:FireServer(mob)
               end
            end
         end
      end
   end
end)

MiscTab:CreateButton({
   Name = "Rejoin Server",
   Callback = function()
      game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
   end,
})

-- Finalização
Rayfield:Notify({
   Title = "Szy - Blade Slayer",
   Content = "Tudo pronto! Aproveite o script.",
   Duration = 6,
   Image = nil,
   Actions = {
      OK = {
         Name = "Fechar",
         Callback = function() end,
      },
   },
})
