local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
   Name = "Blade Slayer | Szy Hub",
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

-- ABA: Farm
local FarmTab = Window:CreateTab("Farm", 4483362458)

FarmTab:CreateToggle({
   Name = "Auto Kill",
   CurrentValue = false,
   Flag = "AutoKill",
   Callback = function(Value)
      getgenv().autoKill = Value
      while getgenv().autoKill do
         -- Comando de auto kill
         print("Matando...")
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
         -- Comando para upgrade
         print("Upando...")
         task.wait(1)
      end
   end
})

-- ABA: Player
local PlayerTab = Window:CreateTab("Player", 4483362458)

PlayerTab:CreateButton({
   Name = "Speed x2",
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
