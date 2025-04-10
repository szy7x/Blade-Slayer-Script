local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
   Name = "Blade Slayer | Szy Hub",
   LoadingTitle = "Iniciando...",
   LoadingSubtitle = "By Szy 🇧🇷",
   ConfigurationSaving = {
      Enabled = false
   },
   KeySystem = false
})

Rayfield:Notify({
   Title = "Blade Slayer Script",
   Content = "Carregado com sucesso!",
   Duration = 5
})

-- Aba Farm
local Farm = Window:CreateTab("Farm")
Farm:CreateToggle({
   Name = "Auto Kill",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().AutoKill = Value
      while getgenv().AutoKill do
         print("Executando Auto Kill...")
         task.wait(0.5)
      end
   end
})

Farm:CreateToggle({
   Name = "Auto Upgrade",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().AutoUpgrade = Value
      while getgenv().AutoUpgrade do
         print("Executando Auto Upgrade...")
         task.wait(1)
      end
   end
})

-- Aba Player
local Player = Window:CreateTab("Player")
Player:CreateButton({
   Name = "Velocidade x2",
   Callback = function()
      local plr = game.Players.LocalPlayer
      if plr and plr.Character then
         plr.Character.Humanoid.WalkSpeed = 32
      end
   end
})

-- Aba Teleport
local Teleport = Window:CreateTab("Teleport")
Teleport:CreateButton({
   Name = "Zona 1",
   Callback = function()
      game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 5, 0)
   end
})

-- Aba Misc
local Misc = Window:CreateTab("Misc")
Misc:CreateButton({
   Name = "Fechar GUI",
   Callback = function()
      Rayfield:Destroy()
   end
})
