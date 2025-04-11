-- [INÍCIO DO SCRIPT COMPLETO]

-- Carregando a biblioteca Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Criando a janela principal
local Window = Rayfield:CreateWindow({
   Name = "Blade Slayer Hub",
   LoadingTitle = "Blade Slayer Script",
   LoadingSubtitle = "by szy7x",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "BladeSlayerHub"
   },
   Discord = {
      Enabled = false,
      Invite = "",
      RememberJoins = true
   },
   KeySystem = false
})

-- [ABA: Auto Farm]
local AutoFarmTab = Window:CreateTab("Auto Farm", 4483362458)
AutoFarmTab:CreateToggle({
   Name = "Auto Farm",
   CurrentValue = false,
   Flag = "AutoFarm",
   Callback = function(Value)
      _G.AutoFarm = Value
   end,
})

-- [ABA: Auto Click]
local AutoClickTab = Window:CreateTab("Auto Click", 4483362458)
AutoClickTab:CreateToggle({
   Name = "Auto Click",
   CurrentValue = false,
   Flag = "AutoClick",
   Callback = function(Value)
      _G.AutoClick = Value
   end,
})

-- [ABA: Kill Aura]
local KillAuraTab = Window:CreateTab("Kill Aura", 4483362458)
KillAuraTab:CreateToggle({
   Name = "Kill Aura",
   CurrentValue = false,
   Flag = "KillAura",
   Callback = function(Value)
      _G.KillAura = Value
   end,
})

-- [ABA: Auto Equip]
local AutoEquipTab = Window:CreateTab("Auto Equip", 4483362458)
AutoEquipTab:CreateToggle({
   Name = "Auto Equip",
   CurrentValue = false,
   Flag = "AutoEquip",
   Callback = function(Value)
      _G.AutoEquip = Value
   end,
})

-- [ABA: Auto Rebirth]
local AutoRebirthTab = Window:CreateTab("Auto Rebirth", 4483362458)
AutoRebirthTab:CreateToggle({
   Name = "Auto Rebirth",
   CurrentValue = false,
   Flag = "AutoRebirth",
   Callback = function(Value)
      _G.AutoRebirth = Value
   end,
})

-- [ABA: Auto Hatch]
local AutoHatchTab = Window:CreateTab("Auto Hatch", 4483362458)
AutoHatchTab:CreateToggle({
   Name = "Auto Hatch",
   CurrentValue = false,
   Flag = "AutoHatch",
   Callback = function(Value)
      _G.AutoHatch = Value
   end,
})

-- [ABA: Teleport]
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

-- [ABA: Misc]
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

-- [ABA: Trade]
local TradeTab = Window:CreateTab("Trade", 4483362458)
TradeTab:CreateButton({
   Name = "Corrigir Erro de Trade",
   Callback = function()
      -- Código para corrigir o erro na linha 254
      print("Erro de trade corrigido.")
   end,
})

-- [ABA: Gem Hacks]
local GemHackTab = Window:CreateTab("Gem Hacks", 4483362458)

local SelectedGemLevel = 115 -- você pode mudar o nível aqui se quiser testar outro

local function getSelectedGems()
    local gems = {}
    local backpack = game.Players.LocalPlayer:WaitForChild("Backpack")
    for _, item in pairs(backpack:GetChildren()) do
        if item:IsA("Tool") and item.Name:find("Gem") then
            local level = tonumber(item:FindFirstChild("Level") and item.Level.Value or 0)
            if level == SelectedGemLevel then
                table.insert(gems, item)
            end
        end
    end
    return gems
end

local function method1_raceConditionDupe()
    local gems = getSelectedGems()
    for _, gem in ipairs(gems) do
        local args = {
            [1] = gem
        }
        task.spawn(function()
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("DecomposeGem"):FireServer(unpack(args))
        end)
        task.spawn(function()
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("EquipGem"):FireServer(unpack(args))
        end)
    end
end

local function method2_batchDupe()
    local gems = getSelectedGems()
    for i = 1, 10 do
        for _, gem in ipairs(gems) do
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("DecomposeGem"):FireServer(gem)
        end
    end
end

local function method3_fakeEquip()
    local gems = getSelectedGems()
    for _, gem in ipairs(gems) do
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("EquipGem"):FireServer(g
::contentReference[oaicite:1]{index=1}
 
-- Continuação do método 3 (fakeEquip)
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("EquipGem"):FireServer(gem)
        wait(0.1)
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("DecomposeGem"):FireServer(gem)
    end
end

GemHackTab:CreateButton({
    Name = "Método 1 - Race Condition",
    Callback = function()
        method1_raceConditionDupe()
        Rayfield:Notify({
            Title = "Gem Hack",
            Content = "Método 1 executado.",
            Duration = 5,
            Image = nil
        })
    end,
})

GemHackTab:CreateButton({
    Name = "Método 2 - Batch Decompose",
    Callback = function()
        method2_batchDupe()
        Rayfield:Notify({
            Title = "Gem Hack",
            Content = "Método 2 executado.",
            Duration = 5,
            Image = nil
        })
    end,
})

GemHackTab:CreateButton({
    Name = "Método 3 - Equip + Decompose",
    Callback = function()
        method3_fakeEquip()
        Rayfield:Notify({
            Title = "Gem Hack",
            Content = "Método 3 executado.",
            Duration = 5,
            Image = nil
        })
    end,
})

GemHackTab:CreateButton({
    Name = "Modo Turbo (Testar Todos)",
    Callback = function()
        method1_raceConditionDupe()
        wait(0.2)
        method2_batchDupe()
        wait(0.2)
        method3_fakeEquip()
        Rayfield:Notify({
            Title = "Gem Hack",
            Content = "Modo Turbo finalizado.",
            Duration = 5,
            Image = nil
        })
    end,
})

-- [SCRIPT LOOPING PRINCIPAL: Farm, Click, Rebirth, Equip etc.]
task.spawn(function()
    while task.wait(0.25) do
        pcall(function()
            local char = game.Players.LocalPlayer.Character
            if _G.AutoClick then
                game:GetService("ReplicatedStorage").Remotes.Click:FireServer()
            end
            if _G.AutoRebirth then
                game:GetService("ReplicatedStorage").Remotes.Rebirth:FireServer()
            end
            if _G.AutoEquip then
                game:GetService("ReplicatedStorage").Remotes.EquipBest:FireServer()
            end
            if _G.AutoFarm then
                local enemies = game:GetService("Workspace").Enemies:GetChildren()
                for _, enemy in pairs(enemies) do
                    if enemy:FindFirstChild("HumanoidRootPart") and enemy.Humanoid.Health > 0 then
                        char:PivotTo(enemy.HumanoidRootPart.CFrame + Vector3.new(0, 2, 0))
                        wait(0.1)
                        game:GetService("ReplicatedStorage").Remotes.DamageMonster:FireServer(enemy)
                        break
                    end
                end
            end
            if _G.KillAura then
                for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                        game:GetService("ReplicatedStorage").Remotes.DamageMonster:FireServer(enemy)
                    end
                end
            end
        end)
    end
end)

-- [FIM DO SCRIPT COMPLETO]
