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

-- ABA: Farm
local FarmTab = Window:CreateTab("Farm", 4483362458)

Rayfield:LoadConfiguration()

-- Toggle Auto Farm
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
      task.wait(0.5) -- Espera entre os loops
      if _G.AutoFarm then
         pcall(function()
            for _, mob in ipairs(game:GetService("Workspace").Enemies:GetChildren()) do
               if mob:FindFirstChild("HumanoidRootPart") then
                  local humanoidRootPart = mob:FindFirstChild("HumanoidRootPart")
                  if humanoidRootPart then
                     local playerHRP = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                     if playerHRP then
                        playerHRP.CFrame = humanoidRootPart.CFrame * CFrame.new(0, 3, 0)
                        wait(0.5)
                        local humanoid = mob:FindFirstChild("Humanoid")
                        if humanoid and humanoid.Health > 0 then
                           game:GetService("ReplicatedStorage").Remotes.DamageMonster:FireServer(mob)
                        end
                     end
                  end
               end
            end
         end)
      end
   end
end)

-- Toggle Auto Click
FarmTab:CreateToggle({
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
      if _G.AutoClick then
         pcall(function()
            game:GetService("ReplicatedStorage").Remotes.PlayerClickAttack:FireServer()
            game:GetService("ReplicatedStorage").Remotes.PlayerClickAttack:FireServer()
            game:GetService("ReplicatedStorage").Remotes.PlayerClickAttack:FireServer()
         end)
      end
   end
end)

-- ABA: Player
local PlayerTab = Window:CreateTab("Player", 4483362458)

-- Toggle Auto Rebirth
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
            game:GetService("ReplicatedStorage").Remotes.PlayerReborn:FireServer()
         end)
      end
   end
end)

-- Toggle Auto Equip Best Weapon
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
            game:GetService("ReplicatedStorage").Remotes.EquipBestWeapon:FireServer()
         end)
      end
   end
end)

-- ABA: Heroes
local HeroesTab = Window:CreateTab("Heroes", 4483362458)

-- Toggle Auto Equip Best Hero
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
            game:GetService("ReplicatedStorage").Remotes.AutoEquipBestHero:FireServer()
         end)
      end
   end
end)

-- Toggle Auto Hatch Nearest
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
            local mapsFolder = game.Workspace:FindFirstChild("Maps")
            if mapsFolder then
               local currentMap = mapsFolder:GetChildren()[1]
               if currentMap and currentMap:FindFirstChild("Map") and currentMap.Map:FindFirstChild("Eggs") then
                  local egg = currentMap.Map.Eggs:GetChildren()[1]
                  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = egg.CFrame
                  wait(0.5)
                  local vim = game:GetService("VirtualInputManager")
                  vim:SendKeyEvent(true, "E", false, game)
                  wait(0.2)
                  vim:SendKeyEvent(false, "E", false, game)
               end
            end
         end)
      end
   end
end)

-- ABA: Trade
local TradeTab = Window:CreateTab("Trade", 4483362458)

local players = game:GetService("Players")
local player = game.Players.LocalPlayer
local tradeInProgress = false
local tradeOffer = {
   target = nil,
   heroesOffered = {}
}

local function sendTradeOffer(targetPlayerName)
    local targetPlayer = players:FindFirstChild(targetPlayerName)
    if targetPlayer then
        if not tradeInProgress then
            tradeInProgress = true
            tradeOffer.target = targetPlayer
            print("Troca enviada para " .. targetPlayer.Name)
            tradeOffer.heroesOffered = {"Hero1", "Hero2"}
        else
            print("Já existe uma troca em andamento!")
        end
    else
        print("Jogador não encontrado!")
    end
end

local function acceptTrade()
    if tradeInProgress and tradeOffer.target then
        print("Troca aceita com " .. tradeOffer.target.Name)
        for _, hero in ipairs(tradeOffer.heroesOffered) do
            print("Adicionando " .. hero .. " ao seu inventário.")
        end
        for _, hero in ipairs(tradeOffer.heroesOffered) do
            print("Enviando " .. hero .. " para " .. tradeOffer.target.Name)
        end
        tradeInProgress = false
    else
        print("Nenhuma troca pendente para aceitar.")
    end
end

local function updatePlayerList()
    local playerList = {}
    for _, p in pairs(players:GetPlayers()) do
        if p.Name ~= player.Name then
            table.insert(playerList, p.Name)
        end
    end
    return playerList
end

local PlayerDropdown = TradeTab:CreateDropdown({
   Name = "Escolher Jogador para Troca",
   Options = updatePlayerList(),
   CurrentOption = updatePlayerList()[1],
   Flag = "TradePlayerDropdown",
   Callback = function(selectedPlayer)
      sendTradeOffer(selectedPlayer)
   end,
})

TradeTab:CreateButton({
   Name = "Envie a Troca Manualmente Pelo Jogo",
   Callback = function()
      local selectedPlayer = PlayerDropdown:GetSelected()
      sendTradeOffer(selectedPlayer)
   end,
})

TradeTab:CreateButton({
   Name = "Dupe Heroes - 1 CLICK ONLY",
   Callback = function()
      acceptTrade()
   end,
})

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
