local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
   Name = "Blade Slayer | Wing Hub",
   LoadingTitle = "Blade Slayer Script",
   LoadingSubtitle = "By Szy",
   ConfigurationSaving = {
      Enabled = false
   },
   Discord = {
      Enabled = false
   },
   KeySystem = false
})

Rayfield:Notify({
   Title = "Szy Hub",
   Content = "Script carregado com sucesso!",
   Duration = 6.5,
   Image = 4483362458,
})

-- ABA: Farm
local FarmTab = Window:CreateTab("Farm", 4483362458)

FarmTab:CreateToggle({
   Name = "Auto Kill",
   CurrentValue = false,
   Flag = "AutoKill",
   Callback = function(Value)
      getgenv().autoKill = Value
      while getgenv().autoKill do
         print("Matando inimigos...")
         task.wait(0.5)
      end
   end
})

FarmTab:CreateToggle({
   Name = "Auto Upgrade",
   CurrentValue = false,
   Flag = "AutoUpgrade",
   Callback = function(Value)
      getgenv().autoUpgrade = Value
      while getgenv().autoUpgrade do
         print("Fazendo upgrade...")
         task.wait(1)
      end
   end
})

-- ABA: Player
local PlayerTab = Window:CreateTab("Player", 4483362458)

PlayerTab:CreateButton({
   Name = "Velocidade x2",
   Callback = function()
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 32
   end
})

-- ABA: Teleport
local TeleportTab = Window:CreateTab("Teleport", 4483362458)

TeleportTab:CreateButton({
   Name = "Ir para Zona 1",
   Callback = function()
      game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 5, 0)
   end
})

-- ABA: Misc
local MiscTab = Window:CreateTab("Misc", 4483362458)

MiscTab:CreateButton({
   Name = "Fechar GUI",
   Callback = function()
      Rayfield:Destroy()
   end
})
