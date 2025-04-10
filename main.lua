local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Szy Blade Slayer Hub",
    SubTitle = "by Szy",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Darker"
})

local Tab = Window:AddTab({ Title = "Main", Icon = "sword" })

-- Controles
local autoFarm = false

function startAutoFarm()
    task.spawn(function()
        while autoFarm do
            local mobs = workspace:FindFirstChild("Mobs")
            if mobs then
                for _, mob in pairs(mobs:GetChildren()) do
                    if mob:FindFirstChild("HumanoidRootPart") then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                        game:GetService("ReplicatedStorage").Remotes.Damage:FireServer(mob)
                    end
                end
            end
            task.wait(0.3)
        end
    end)
end

-- Botões na interface
Tab:AddToggle("Auto Farm", {Default = false}, function(state)
    autoFarm = state
    if state then startAutoFarm() end
end)

Window:SelectTab(1)
