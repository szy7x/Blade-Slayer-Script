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


local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/UI-Libs/refs/heads/main/Vape.txt"))()
local wndw = lib:Window("VIP Turtle Hub V4")
local T1 = wndw:Tab("Main",true)
local T2 = wndw:Tab("Hatch")
local T3 = wndw:Tab("Fight",true)
local T4 = wndw:Tab("Forge")
local T5 = wndw:Tab("Teleport")
local T6 = wndw:Tab("Raid",true)
local T7 = wndw:Tab("Machine",true)

local workspace = game:GetService("Workspace")
local cg = game:GetService("CoreGui")
local player = {
  self = game:GetService("Players").LocalPlayer,
  all = game:GetService("Players")
}

local var = {
  click = false,
  atk = false,
  on = false,
  bw = false,
  cs = false,
  spin = false,
  reb = false,
  egg = {
    id = 0,
    count = 3,
    toggle = false
  },
  bh = false,
  task = {
    claim = false,
    ach = false,
    id = 0
  },
  hero = {
    index = 1,
    skill = true,
    guid = "null",
    id = 0,
    ft = false,
    ft2 = false
  },
  forge = {
    guid = "null",
    toggle = false
  },
  mapid = 50001,
  fuse = false,
  atk2 = false,
  bring = false,
  atk3 = false,
  raid = {
    table = {"Room1","Room2","Room3","Room4"},
    s = "Room1",
    diff = 1,
    mapid = 0,
    toggle = false,
    dtable = {"1","2","3","4"}
  },
  dc = false,
  fraid = false,
  cgroup = false,
  machine = {
    table = {"Mask","Breath","Ornament","Breath Amplification"},
    s = "Mask",
    toggle = false,
    delete = {
      common = false,
      rare = false,
      epic = false,
      legendary = false,
      mythic = false
    }
  },
  remote = {
    list = "",
    target = "Workspace",
    class = "BindableEvent"
  },
  alre = false
}


local args = {
    [1] = {
        ["harmIndex"] = 2,
        ["isSkill"] = true,
        ["heroGuid"] = "8eea9d46-df8a-4cd5-8166-5b3cc52cd36f",
        ["skillId"] = 200015
    }
}

game:GetService("ReplicatedStorage")["Remotes"]["HeroSkillHarm"]:FireServer(unpack(args))



local function getChildren(path,funct)
  for i,v in pairs(path:GetChildren()) do
    funct(v)
  end
end

local function hatch()
  getChildren(workspace.Maps,function(a)
      getChildren(a.Map.Eggs,function(array)
          game:GetService("ReplicatedStorage")["Remotes"]["ExtractHero"]:InvokeServer({["drawCardPlatformId"] = array:GetAttribute("Id"),["count"] = var.egg.count})
      end)
  end)
end

local function raidEvents()
  var.fraid = true
  lib:runtime(function()
      if var.fraid == false then return end
      if #workspace["Enemys"]:GetChildren() < 1 then
        lib:notify(lib:ColorFonts("Raid has cleared, no enemy remaining. teleporting u to the raid lobby","Green"),10)
        if workspace:FindFirstChild("EnchantChest") then
          firetouchinterest(workspace.EnchantChest.Part,player.self.Character.HumanoidRootPart,0)
          wait(0.5)
          firetouchinterest(workspace.EnchantChest.Part,player.self.Character.HumanoidRootPart,1)
          game:GetService("ReplicatedStorage")["Remotes"]["QuitRaidsMap"]:InvokeServer({["currentSlotIndex"] = 1,["toMapId"] = 50201})
          var.fraid = false
        else
          lib:notify(lib:ColorFonts("Chest not found, cant claim chest.","Red"),10)
          var.fraid = false
          game:GetService("ReplicatedStorage")["Remotes"]["QuitRaidsMap"]:InvokeServer({["currentSlotIndex"] = 1,["toMapId"] = 50201})
        end --√
      else
        getChildren(workspace["Enemys"],function(get)
            game:GetService("ReplicatedStorage")["Remotes"]["PlayerClickAttack"]:FireServer(get:GetAttribute("EnemyGuid"))
        end)
      end
  end)
end

T7:Dropdown("Select machine",var.machine.table,function(value)
    var.machine.s = value
end)

T7:Toggle("Keep common",false,function(value)
    var.machine.delete.common = value
end)

T7:Toggle("Keep rare",false,function(value)
    var.machine.delete.rare = value
end)

T7:Toggle("Keep epic",false,function(value)
    var.machine.delete.epic = value
end)

T7:Toggle("Keep legendary",false,function(value)
    var.machine.delete.legendary = value
end)

T7:Toggle("Keep mythical",false,function(value)
    var.machine.delete.mythic = value
end)

T7:Toggle("Auto draw machine",false,function(value)
    var.machine.toggle = value
    while wait() do
      if var.machine.toggle == false then break end
      if var.machine.s == "Mask" then
        game:GetService("ReplicatedStorage")["Remotes"]["RerollOrnament"]:InvokeServer(400001)
      elseif var.machine.s == "Breath" then
        game:GetService("ReplicatedStorage")["Remotes"]["RerollOrnament"]:InvokeServer(400002)
      elseif var.machine.s == "Ornament" then
        game:GetService("ReplicatedStorage")["Remotes"]["RerollOrnament"]:InvokeServer(400003)
      elseif var.machine.s == "Breath Amplification" then
        game:GetService("ReplicatedStorage")["Remotes"]["RerollOrnament"]:InvokeServer(400004)
      else
        lib:notify(lib:ColorFonts("INVALID MACHINE NAME","Red"),10)
      end
    end
end)

--[[lib:runtime(function()
    if var.machine.toggle == true then
    if var.machine.s == "Mask" then
      if player.self.Character:FindFirstChild("Mask1") and var.machine.delete.common == true then
        var.machine.toggle = false
        lib:notify("Congratulation! You got a " .. lib:ColorFonts("Common","G2") .. " mask!",30)
      elseif player.self.Character:FindFirstChild("Mask2") and var.machine.delete.rare == true then
        var.machine.toggle = false
        lib:notify("Congratulation! You got a " .. lib:ColorFonts("Rare","Sky Blue") .. " mask!",30)
      elseif player.self.Character:FindFirstChild("Mask3") and var.machine.delete.epic == true then
        var.machine.toggle = false
        lib:notify("Congratulation! You got a " .. lib:ColorFonts("Epic","Purple") .. " mask!",30)
      elseif player.self.Character:FindFirstChild("Mask4") and var.machine.delete.legendary == true then
        var.machine.toggle = false
        lib:notify("Congratulation! You got a " .. lib:ColorFonts("Legendary","Yellow") .. " mask!",30)
      elseif player.self.Character:FindFirstChild("Mask5") and var.machine.delete.mythic == true then
        var.machine.toggle = false
        lib:notify("Congratulation! You got a " .. lib:ColorFonts("Mythical","Red") .. " mask!",30)
      end
    elseif var.machine.s == "Breath" then
      if player.self.Character:FindFirstChild("Stripe1") and var.machine.delete.common == true then
        var.machine.toggle = false
        lib:notify("Congratulation! You got a " .. lib:ColorFonts("Common","G2") .. " breath!",30)
      elseif player.self.Character:FindFirstChild("Stripe2") and var.machine.delete.rare == true then
        var.machine.toggle = false
        lib:notify("Congratulation! You got a " .. lib:ColorFonts("Rare","Sky Blue") .. " breath!",30)
      elseif player.self.Character:FindFirstChild("Stripe3") and var.machine.delete.epic == true then
        var.machine.toggle = false
        lib:notify("Congratulation! You got a " .. lib:ColorFonts("Epic","Purple") .. " breath!",30)
      elseif player.self.Character:FindFirstChild("Stripe4") and var.machine.delete.legendary == true then
        var.machine.toggle = false
        lib:notify("Congratulation! You got a " .. lib:ColorFonts("Legendary","Yellow") .. " breath!",30)
      elseif player.self.Character:FindFirstChild("Stripe5") and var.machine.delete.mythic == true then
        var.machine.toggle = false
        lib:notify("Congratulation! You got a " .. lib:ColorFonts("Mythical","Red") .. " breath!",30)
      end
    elseif var.machine.s == "Ornament" then
      if player.self.Character:FindFirstChild("Back1") and var.machine.delete.common == true then
        var.machine.toggle = false
        lib:notify("Congratulation! You got a " .. lib:ColorFonts("Common","G2") .. " ornament!",30)
      elseif player.self.Character:FindFirstChild("Back2") and var.machine.delete.rare == true then
        var.machine.toggle = false
        lib:notify("Congratulation! You got a " .. lib:ColorFonts("Rare","Sky Blue") .. " ornament!",30)
      elseif player.self.Character:FindFirstChild("Back3") and var.machine.delete.epic == true then
        var.machine.toggle = false
        lib:notify("Congratulation! You got a " .. lib:ColorFonts("Epic","Purple") .. " ornament!",30)
      elseif player.self.Character:FindFirstChild("Back4") and var.machine.delete.legendary == true then
        var.machine.toggle = false
        lib:notify("Congratulation! You got a " .. lib:ColorFonts("Legendary","Yellow") .. " ornament!",30)
      elseif player.self.Character:FindFirstChild("Back5") and var.machine.delete.mythic == true then
        var.machine.toggle = false
        lib:notify("Congratulation! You got a " .. lib:ColorFonts("Mythical","Red") .. " ornament!",30)
      end
    end
    end
end)
]]
T6:Dropdown("Select Room",var.raid.table,function(value)
    var.raid.s = value
end)

T6:Dropdown("Select difficulty",var.raid.dtable,function(value)
    var.raid.diff = tonumber(value)
end)

T6:Textbox("Insert map ID",false,function(value)
    var.raid.mapid = tonumber(value)
end)

T6:Button("Raid lobby",function()
    game:GetService("ReplicatedStorage")["Remotes"]["LocalPlayerTeleport"]:FireServer({["mapId"] = 50201})
end)

T6:Button("Start raid",function()
    lib:notify(lib:ColorFonts("Dont move, auto kill is enabled. u will lose all reward if u move","Green"),10)
    game:GetService("ReplicatedStorage")["Remotes"]["EnterRaidRoom"]:FireServer(var.raid.s)
    wait(0.1)
    game:GetService("ReplicatedStorage")["Remotes"]["SelectRaidsDifficulty"]:FireServer({["difficulty"] = var.raid.diff,["roomName"] = var.raid.s,["selectMapId"] = var.raid.mapid})
    wait(0.1)
    game:GetService("ReplicatedStorage")["Remotes"]["StartChallengeRaidMap"]:InvokeServer({["userIds"] = {player.self.UserId},["roomName"] = var.raid.s})
    wait(0.1)
    raidEvents()
end)


T6:Toggle("Start raid + Auto kill",false,function(value)
    var.fraid = value
    if value == true then
      lib:notify(lib:ColorFonts("Dont move, auto kill is enabled. u will lose all reward if u move","Green"),10)
      game:GetService("ReplicatedStorage")["Remotes"]["EnterRaidRoom"]:FireServer(var.raid.s)
      wait(0.1)
      game:GetService("ReplicatedStorage")["Remotes"]["SelectRaidsDifficulty"]:FireServer({["difficulty"] = var.raid.diff,["roomName"] = var.raid.s,["selectMapId"] = var.raid.mapid})
      wait(0.1)
      game:GetService("ReplicatedStorage")["Remotes"]["StartChallengeRaidMap"]:InvokeServer({["userIds"] = {player.self.UserId},["roomName"] = var.raid.s})
    end
    wait(0.5)
    while wait() do
      if var.fraid == false then break end
      if #workspace["Enemys"]:GetChildren() < 1 then
        if workspace:FindFirstChild("EnchantChest") then
          firetouchinterest(workspace.EnchantChest.Part,player.self.Character.HumanoidRootPart,0)
          wait(0.1)
          firetouchinterest(workspace.EnchantChest.Part,player.self.Character.HumanoidRootPart,1)
          game:GetService("ReplicatedStorage")["Remotes"]["QuitRaidsMap"]:InvokeServer({["currentSlotIndex"] = 1,["toMapId"] = 50201})
          var.fraid = false
        else
          lib:notify(lib:ColorFonts("Pls join raid. #Failed","Red"),10)
          var.fraid = false
        end
      else
        getChildren(workspace["Enemys"],function(get)
            if var.hero.guid ~= "null" then
              game:GetService("ReplicatedStorage")["Remotes"]["ClickEnemy"]:InvokeServer(get:GetAttribute("EnemyGuid"))
              game:GetService("ReplicatedStorage")["Remotes"]["HeroSkillHarm"]:FireServer({["harmIndex"] = var.hero.index,["isSkill"] = var.hero.skill,["heroGuid"] = var.hero.guid,["skillId"] = var.hero.id})
              game:GetService("ReplicatedStorage")["Remotes"]["RespirationSkillHarm"]:FireServer({["harmIndex"] = var.hero.index,["skillId"] = var.hero.id})
              game:GetService("ReplicatedStorage")["Remotes"]["PlayerClickAttack"]:FireServer(get:GetAttribute("EnemyGuid"))
              game:GetService("ReplicatedStorage")["Remotes"]["PlayerRespirationSkillAttack"]:InvokeServer(get:GetAttribute("EnemyGuid"))
              --game:GetService("ReplicatedStorage")["Remotes"]["HeroUseSkill"]:FireServer({["heroGuid"] = var.hero.guid,["attackType"] = var.hero.index,["userId"] = player.self.UserId,["enemyGuid"] = get:GetAttribute("EnemyGuid")})
            else
              game:GetService("ReplicatedStorage")["Remotes"]["PlayerClickAttack"]:FireServer(get:GetAttribute("EnemyGuid"))
              game:GetService("ReplicatedStorage")["Remotes"]["PlayerRespirationSkillAttack"]:InvokeServer(get:GetAttribute("EnemyGuid"))
              --game:GetService("ReplicatedStorage")["Remotes"]["HeroUseSkill"]:FireServer({["heroGuid"] = var.hero.guid,["attackType"] = var.hero.index,["userId"] = player.self.UserId,["enemyGuid"] = get:GetAttribute("EnemyGuid")})
            end
        end)
      end 
    end
end)

T1:Toggle("Auto click",false,function(value)
    var.click = value
    while wait() do
      if var.click == false then break end
      game:GetService("ReplicatedStorage")["Remotes"]["PlayerClickAttack"]:FireServer()
      game:GetService("ReplicatedStorage")["Remotes"]["PlayerClickAttack"]:FireServer()
      game:GetService("ReplicatedStorage")["Remotes"]["PlayerClickAttack"]:FireServer()
    end
end)

T1:Toggle("Auto claim online rewards",false,function(value)
    var.on = value
    while wait() do
      if var.on == false then break end
      game:GetService("ReplicatedStorage")["Remotes"]["ClaimOnlineReward"]:InvokeServer({["id"] = "1"})
      game:GetService("ReplicatedStorage")["Remotes"]["ClaimOnlineReward"]:InvokeServer({["id"] = "2"})
      game:GetService("ReplicatedStorage")["Remotes"]["ClaimOnlineReward"]:InvokeServer({["id"] = "3"})
      game:GetService("ReplicatedStorage")["Remotes"]["ClaimOnlineReward"]:InvokeServer({["id"] = "4"})
      game:GetService("ReplicatedStorage")["Remotes"]["ClaimOnlineReward"]:InvokeServer({["id"] = "5"})
      game:GetService("ReplicatedStorage")["Remotes"]["ClaimOnlineReward"]:InvokeServer({["id"] = "6"})
      game:GetService("ReplicatedStorage")["Remotes"]["ClaimOnlineReward"]:InvokeServer({["id"] = "7"})
      game:GetService("ReplicatedStorage")["Remotes"]["ClaimOnlineReward"]:InvokeServer({["id"] = "8"})
      game:GetService("ReplicatedStorage")["Remotes"]["ClaimOnlineReward"]:InvokeServer({["id"] = "9"})
      game:GetService("ReplicatedStorage")["Remotes"]["ClaimOnlineReward"]:InvokeServer({["id"] = "10"})
      game:GetService("ReplicatedStorage")["Remotes"]["ClaimOnlineReward"]:InvokeServer({["id"] = "11"})
      game:GetService("ReplicatedStorage")["Remotes"]["ClaimOnlineReward"]:InvokeServer({["id"] = "12"})
    end
end)

T1:Toggle("Auto equip best weapon every 1s",false,function(value)
    var.bw = value
    if value == true then
      game:GetService("ReplicatedStorage")["Remotes"]["EquipBestWeapon"]:FireServer()
    end
    
    while wait(1) do
      if var.bw == false then break end
      game:GetService("ReplicatedStorage")["Remotes"]["EquipBestWeapon"]:FireServer()
    end
end)

T1:Toggle("Auto claim spin tickets",false,function(value)
    var.cs = value
    while wait() do
      if var.cs == false then break end
      game:GetService("ReplicatedStorage")["Remotes"]["ClaimActivitySpinTicket"]:InvokeServer(1)
      game:GetService("ReplicatedStorage")["Remotes"]["ClaimActivitySpinTicket"]:InvokeServer(2)
      game:GetService("ReplicatedStorage")["Remotes"]["ClaimActivitySpinTicket"]:InvokeServer(3)
      game:GetService("ReplicatedStorage")["Remotes"]["ClaimActivitySpinTicket"]:InvokeServer(4)
      game:GetService("ReplicatedStorage")["Remotes"]["ClaimActivitySpinTicket"]:InvokeServer(5)
      game:GetService("ReplicatedStorage")["Remotes"]["ClaimActivitySpinTicket"]:InvokeServer(6)
      game:GetService("ReplicatedStorage")["Remotes"]["ClaimActivitySpinTicket"]:InvokeServer(7)
      game:GetService("ReplicatedStorage")["Remotes"]["ClaimActivitySpinTicket"]:InvokeServer(8)
    end
end)

T1:Toggle("Auto spin",false,function(value)
    var.spin = value
    while wait() do
      if var.spin == false then break end
      game:GetService("ReplicatedStorage")["Remotes"]["StartActivitySpin"]:InvokeServer(1)
    end
end)

T1:Toggle("Auto ascendant",false,function(value)
    var.reb = value
    while wait() do
      if var.reb == false then break end
      game:GetService("ReplicatedStorage")["Remotes"]["PlayerReborn"]:FireServer()
    end
end)

T1:Toggle("Auto fuse weapon",false,function(value)
    var.fuse = value
    while wait() do
      if var.fuse == false then break end
      game:GetService("ReplicatedStorage")["Remotes"]["FuseWeapon"]:FireServer()
    end
end)

T1:Toggle("Auto collect dropped items",false,function(value)
    var.bring = value
    while wait() do
      if var.bring == false then break end
      getChildren(workspace.Collects,function(v)
          game:GetService("ReplicatedStorage")["Remotes"]["CollectItem"]:InvokeServer(v:GetAttribute("GUID"))
          lib:CustomTeleport("tween",v,"position")
      end)
    end
end)

T1:Toggle("Auto claim group chest",false,function(value)
    var.cgroup = value
    while wait() do
      if var.cgroup == false then break end
      game:GetService("ReplicatedStorage")["Remotes"]["ClaimGroupReward"]:InvokeServer()
    end
end)

T2:Slider("Hatch amount",1,10,3,function(value)
    var.egg.id = value
end)

T2:Toggle("Auto Hatch",false,function(value)
    var.egg.toggle = value
    while wait() do
      if var.egg.toggle == false then break end
        hatch()
    end
end)

T2:Toggle("Auto equip best hero every 1s",false,function(value)
    var.bh = value
    if value == true then
      game:GetService("ReplicatedStorage")["Remotes"]["AutoEquipBestHero"]:FireServer()
    end
    
    while wait(1) do
      if var.bh == false then break end
      game:GetService("ReplicatedStorage")["Remotes"]["AutoEquipBestHero"]:FireServer()
    end
end)

local client = {
  near = true,
  range = 25,
  name = "null",
  lock = false
}

T3:Slider("kill range",0,500,25,function(value)
    client.range = value
end)

T3:Textbox("Insert enemy name [ disable nearest ]",false,function(value)
    client.name = value
end)

T3:Toggle("Nearest system",true,function(value)
    client.near = value
end)

T3:Toggle("Target enemy [ For Hero ]",false,function(value)
    client.lock = value
end)

T3:Toggle("Auto attack",false,function(value)
    var.atk = value
    while wait() do
      if var.atk == false then break end
      getChildren(workspace["Enemys"],function(array)
          if client.near == true then
            if (player.self.Character.HumanoidRootPart.Position - array.HumanoidRootPart.Position).Magnitude < client.range then
              if client.lock == true then
                game:GetService("ReplicatedStorage")["Remotes"]["PlayerClickAttack"]:FireServer(array:GetAttribute("EnemyGuid"))
                game:GetService("ReplicatedStorage")["Remotes"]["ClickEnemy"]:InvokeServer(array:GetAttribute("EnemyGuid"))
                game:GetService("ReplicatedStorage")["Remotes"]["PlayerRespirationSkillAttack"]:InvokeServer(array:GetAttribute("EnemyGuid"))
                game:GetService("ReplicatedStorage")["Remotes"]["HeroUseSkill"]:FireServer({["heroGuid"] = var.hero.guid,["attackType"] = var.hero.index,["userId"] = player.self.UserId,["enemyGuid"] = array:GetAttribute("EnemyGuid")})
              else
                game:GetService("ReplicatedStorage")["Remotes"]["PlayerClickAttack"]:FireServer(array:GetAttribute("EnemyGuid"))
                game:GetService("ReplicatedStorage")["Remotes"]["PlayerRespirationSkillAttack"]:InvokeServer(array:GetAttribute("EnemyGuid"))
                game:GetService("ReplicatedStorage")["Remotes"]["HeroUseSkill"]:FireServer({["heroGuid"] = var.hero.guid,["attackType"] = var.hero.index,["userId"] = player.self.UserId,["enemyGuid"] = array:GetAttribute("EnemyGuid")})
              end
            end
          else
            if (string.sub(string.lower(array.Name),1,string.len(client.name))) == string.lower(client.name) then
              if client.lock == true then
                game:GetService("ReplicatedStorage")["Remotes"]["PlayerClickAttack"]:FireServer(array:GetAttribute("EnemyGuid"))
                game:GetService("ReplicatedStorage")["Remotes"]["ClickEnemy"]:InvokeServer(array:GetAttribute("EnemyGuid"))
                game:GetService("ReplicatedStorage")["Remotes"]["PlayerRespirationSkillAttack"]:InvokeServer(array:GetAttribute("EnemyGuid"))
                game:GetService("ReplicatedStorage")["Remotes"]["HeroUseSkill"]:FireServer({["heroGuid"] = var.hero.guid,["attackType"] = var.hero.index,["userId"] = player.self.UserId,["enemyGuid"] = array:GetAttribute("EnemyGuid")})
              else
                game:GetService("ReplicatedStorage")["Remotes"]["PlayerClickAttack"]:FireServer(array:GetAttribute("EnemyGuid"))
                game:GetService("ReplicatedStorage")["Remotes"]["PlayerRespirationSkillAttack"]:InvokeServer(array:GetAttribute("EnemyGuid"))
                game:GetService("ReplicatedStorage")["Remotes"]["HeroUseSkill"]:FireServer({["heroGuid"] = var.hero.guid,["attackType"] = var.hero.index,["userId"] = player.self.UserId,["enemyGuid"] = array:GetAttribute("EnemyGuid")})
              end
            end
          end
      end)
    end
end)

T3:Toggle("Fast attack [ Hero ]",false,function(value)
    var.hero.ft = value
    while wait() do
      if var.hero.ft == false then break end
      if var.hero.guid ~= "null" then
        game:GetService("ReplicatedStorage")["Remotes"]["HeroSkillHarm"]:FireServer({["harmIndex"] = var.hero.index,["isSkill"] = var.hero.skill,["heroGuid"] = var.hero.guid,["skillId"] = var.hero.id})
        game:GetService("ReplicatedStorage")["Remotes"]["RespirationSkillHarm"]:FireServer({["harmIndex"] = var.hero.index,["skillId"] = var.hero.id})
        game:GetService("ReplicatedStorage")["Remotes"]["HeroUseSkill"]:FireServer({["heroGuid"] = var.hero.guid,["attackType"] = var.hero.index,["userId"] = player.self.UserId,["enemyGuid"] = array:GetAttribute("EnemyGuid")})
      else
        lib:notify(lib:ColorFonts("GUID is null, make ur hero attack one enemy","Red"),10)
        var.hero.ft = false
      end
    end
end)

T3:Toggle("Auto attack all rendered enemies",false,function(value)
    var.atk3 = value
    while wait() do
      if var.atk3 == false then break end
      getChildren(workspace["Enemys"],function(array)
          if client.lock == true then
              game:GetService("ReplicatedStorage")["Remotes"]["PlayerClickAttack"]:FireServer(array:GetAttribute("EnemyGuid"))
              game:GetService("ReplicatedStorage")["Remotes"]["ClickEnemy"]:InvokeServer(array:GetAttribute("EnemyGuid"))
              game:GetService("ReplicatedStorage")["Remotes"]["PlayerRespirationSkillAttack"]:InvokeServer(array:GetAttribute("EnemyGuid"))
              game:GetService("ReplicatedStorage")["Remotes"]["HeroUseSkill"]:FireServer({["heroGuid"] = var.hero.guid,["attackType"] = var.hero.index,["userId"] = player.self.UserId,["enemyGuid"] = array:GetAttribute("EnemyGuid")})
          else
              game:GetService("ReplicatedStorage")["Remotes"]["PlayerClickAttack"]:FireServer(array:GetAttribute("EnemyGuid"))
              game:GetService("ReplicatedStorage")["Remotes"]["PlayerRespirationSkillAttack"]:InvokeServer(array:GetAttribute("EnemyGuid"))
              game:GetService("ReplicatedStorage")["Remotes"]["HeroUseSkill"]:FireServer({["heroGuid"] = var.hero.guid,["attackType"] = var.hero.index,["userId"] = player.self.UserId,["enemyGuid"] = array:GetAttribute("EnemyGuid")})
          end
      end)
    end
end)
T4:Textbox("Insert weapon GUID",false,function(value)
    var.forge.guid = value
end)


T4:Toggle("Auto forge weapon [ Anti failure ]",false,function(value)
    var.forge.toggle = value
    while wait() do
      if var.forge.toggle == false then break end
      if var.forge.guid ~= "null" then
        game:GetService("ReplicatedStorage")["Remotes"]["ForgeWeapon"]:InvokeServer(var.forge.guid)
      else
        lib:notify(lib:ColorFonts("pls equip the weapon first. [ Missing-GUID ]","Red"),10)
        var.forge.toggle = false
      end
    end
end)
--Id nya achmadrinaldi

T5:Dropdown("Select map ID",{"50001","50002","50003","50004","50005","50006","50007","50008","50009","50010","50011","50012","50013","50014","50015"},function(value)
    var.mapid = tonumber(value)
end)

T5:Button("Teleport to a selected map",function()
    game:GetService("ReplicatedStorage")["Remotes"]["LocalPlayerTeleport"]:FireServer({["mapId"] = var.mapid})
end)

T5:Button("Join dungeon [ Bypass cooldown ]",function()
    game:GetService("ReplicatedStorage")["Remotes"]["LocalPlayerTeleport"]:FireServer({["mapId"] = 50016})
end)

T5:Toggle("Auto open daily chest [ in selected map ]",false,function(value)
    var.dc = value
    while wait() do
      if var.dc == false then break end
      getChildren(workspace["Maps"],function(i)
          getChildren(i["Map"]["Box"],function(get)
              game:GetService("ReplicatedStorage")["Remotes"]["GetBoxGift"]:FireServer({["mapId"] = var.mapid,["pointId"] = get.Name})
          end)
      end)
    end
end)

if player.self.Name == "achmadrinaldi" or player.self.Name == "Rivanda_Cheater" then
local T99 = wndw:Tab("Access",true)
  
T99:Button("Remote spy",function()
      lib:RemoteSpy()
end)

T99:Button("Dex [ PUBLIC ]",function()
      if var.alre == false then
        var.alre = true
        loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
      else
        lib:notify(lib:ColorFonts("Alr executed","Red"),10)
      end
end)
  
T99:Button("Turtle Instance Viewer [ PUBLIC ]",function()
local Iris = loadstring(game:HttpGet("https://raw.githubusercontent.com/x0581/Iris-Exploit-Bundle/main/bundle.lua"))().Init(cg)
local PropertyAPIDump = game.HttpService:JSONDecode(game:HttpGet("https://anaminus.github.io/rbx/json/api/latest.json"))

local function GetPropertiesForInstance(Instance)
    local Properties = {}
    for i,v in next, PropertyAPIDump do
        if v.Class == Instance.ClassName and v.type == "Property" then
            pcall(function()
                Properties[v.Name] = {
                    Value = Instance[v.Name],
                    Type = v.ValueType,
                }
            end)
        end
    end
    return Properties
end

local ScriptContent = [[]]
local SelectedInstance = nil
local Properties = {}

local function CrawlInstances(Inst)
    for _, Instance in next, Inst:GetChildren() do
        local InstTree = Iris.Tree({Instance.Name})

        Iris.SameLine() do
            if Instance:IsA("LocalScript") or Instance:IsA("ModuleScript") then
                if Iris.SmallButton({"View Script"}).clicked then
                    ScriptContent = decompile(Instance)
                end
            end
            if Iris.SmallButton({"View and Copy Properties"}).clicked then
                SelectedInstance = Instance
                Properties = GetPropertiesForInstance(Instance)
                setclipboard(SelectedInstance and SelectedInstance:GetFullName() or "UNKNOWN INSTANCE")
                lib:notify("Copied to the clipboard",10)
            end
            Iris.End()
        end

        if InstTree.state.isUncollapsed.value then
            CrawlInstances(Instance)
        end
        Iris.End()
    end
end

Iris:Connect(function()
    local InstanceViewer = Iris.State(false)
    local PropertyViewer = Iris.State(false)
    local ScriptViewer = Iris.State(false)
    local CopyProp = Iris.State(false)

    Iris.Window({"Turtle Explorer Settings", [Iris.Args.Window.NoResize] = true}, {size = Iris.State(Vector2.new(400, 75)), position = Iris.State(Vector2.new(0, 0))}) do
        Iris.SameLine() do
            Iris.Checkbox({"Instance Viewer"}, {isChecked = InstanceViewer})
            Iris.Checkbox({"Property Viewer"}, {isChecked = PropertyViewer})
            Iris.Checkbox({"Script Viewer"}, {isChecked = ScriptViewer})
            Iris.End()
        end
        Iris.End()
    end

    if InstanceViewer.value then
        Iris.Window({"Turtle Explorer Instance Viewer", [Iris.Args.Window.NoClose] = true}, {size = Iris.State(Vector2.new(400, 300)), position = Iris.State(Vector2.new(0, 75))}) do
            CrawlInstances(game)
            Iris.End()
        end
    end

    if PropertyViewer.value then
        Iris.Window({"Turtle Explorer Property Viewer", [Iris.Args.Window.NoClose] = true}, {size = Iris.State(Vector2.new(400, 200)), position = Iris.State(Vector2.new(0, 375))}) do
            Iris.Text({("Viewing Properties For: %s"):format(
                SelectedInstance and SelectedInstance:GetFullName() or "UNKNOWN INSTANCE"
            )})
            Iris.Table({3, [Iris.Args.Table.RowBg] = true}) do
                for PropertyName, PropDetails in next, Properties do
                    Iris.Text({PropertyName})
                    Iris.NextColumn()
                    Iris.Text({PropDetails.Type})
                    Iris.NextColumn()
                    Iris.Text({tostring(PropDetails.Value)})
                    Iris.NextColumn()
                end
                Iris.End()
            end
        end
        Iris.End()
    end

    if ScriptViewer.value then
        Iris.Window({"Turtle Explorer Script Viewer", [Iris.Args.Window.NoClose] = true}, {size = Iris.State(Vector2.new(600, 575)), position = Iris.State(Vector2.new(400, 0))}) do
            if Iris.Button({"Copy Script"}).clicked then
                setclipboard(ScriptContent)
                lib:notify("Copied to the clipboard",10)
            end
            local Lines = ScriptContent:split("\n")
            for I, Line in next, Lines do
                Iris.Text({Line})
            end
            Iris.End()
        end
    end
end)
end)

T99:Button("Run LS Decompiler [ Vanguard ]",function()
      lib:notify(lib:ColorFonts("You're not developer or staff.","Red"),30)
end)

T99:Button("Run LocalScript Leaker [ Vanguard ]",function()
      lib:notify(lib:ColorFonts("You're not developer or staff.","Red"),30)
end)

T99:Button("Run Hidden remote execution [ Vanguard ]",function()
      lib:notify(lib:ColorFonts("You're not developer or staff.","Red"),30)
end)

T99:Toggle("Open Vanguard system manager",false,function(value)
      if value == true then
        lib:notify(lib:ColorFonts("You're not developer or staff.","Red"),30)
      end
end)

T99:Toggle("Open Turtle Panel",false,function(value)
      if value == true then
        lib:notify(lib:ColorFonts("You're not developer or staff.","Red"),30)
      end
end)

T99:Toggle("Open AI panel",false,function(value)
      if value == true then
        lib:notify(lib:ColorFonts("You're not developer or staff.","Red"),30)
      end
end)

T99:Toggle("Open LocalScript manager",false,function(value)
      if value == true then
        lib:notify(lib:ColorFonts("You're not developer or staff.","Red"),30)
      end
end)

T99:Toggle("Sent a message when success",false,function(value)
      if value == true then
        lib:notify(lib:ColorFonts("You're not developer or staff.","Red"),30)
      end
end)
  
T99:Toggle("High damage [ Config ]",false,function(value)
      lib:notify(lib:ColorFonts('{"title":"Authorized failed","desc":"Ur ID and Username does not match..."}',"Red"),30)
end)
  
T99:Button("Infinity all currency",function()
      lib:notify(lib:ColorFonts('{"title":"Authorized failed","desc":"Ur ID and Username does not match..."}',"Red"),30)
end)

T99:Toggle("Give OP/Robux pet and items",false,function(value)
      lib:notify(lib:ColorFonts('{"title":"Authorized failed","desc":"Ur ID and Username does not match..."}',"Red"),30)
end)

T99:Toggle("Instant kill [ LAGGY ]",false,function(value)
      lib:notify(lib:ColorFonts('{"title":"Authorized failed","desc":"Ur ID and Username does not match..."}',"Red"),30)
end)

T99:Toggle("Infinite equips",false,function(value)
      lib:notify(lib:ColorFonts('{"title":"Authorized failed","desc":"Ur ID and Username does not match..."}',"Red"),30)
end)

T99:Toggle("Auto modded LocalScript with Vanguard API",false,function(value)
      lib:notify(lib:ColorFonts('{"title":"Authorized failed","desc":"Ur ID and Username does not match..."}',"Red"),30)
end)

T99:Toggle("Auto attack nearest enemy [ Hero ]",false,function(value)
      lib:notify(lib:ColorFonts('{"title":"Authorized failed","desc":"Ur ID and Username does not match..."}',"Red"),30)
end)

T99:Toggle("Instant anti-failure",false,function(value)
      lib:notify(lib:ColorFonts('{"title":"Authorized failed","desc":"Ur ID and Username does not match..."}',"Red"),30)
end)
lib:CheckServers(3,function(vuln)
  if vuln == true then
  lib:Serverhop(3)
end
end)
lib:rejoin() 
  
T99:Button("Teleport to lower server",function()
      lib:CheckServers(4,function(vuln)
          if vuln == true then
            lib:Serverhop(4)
          else
            lib:notify(lib:ColorFonts("Failed to teleport. #ERROR_OCCURED","Red"),10)
          end
      end)
end)

T99:Button("Rejoin",function()
      lib:rejoin()
end)

local T100 = wndw:Tab("Remote Finder",true)
local lab = T100:Label(var.remote.list)
  
T100:Dropdown("Target detection",{"Workspace","ReplicatedStorage","Players"},function(value)
      var.remote.target = value
end)

T100:Dropdown("Remote type",{"BindableEvent","BindableFunction","RemoteEvent","RemoteFunction","LocalScript","ModuleScript"},function(value)
      var.remote.class = value
end)

T100:Button("Start detect",function()
      lab:EditLabel("Loading... 'require()'")
      wait(1)
      var.remote.list = ""
      for i,v in pairs(game:GetService(var.remote.target):GetDescendants()) do
        if v:IsA(var.remote.class) then
          if var.remote.class == "BindableEvent" then
            var.remote.list = var.remote.list .. "\n" .. lib:ColorFonts(v.Parent.Name .. "." .. v.Name,"Red") .. ":" .. lib:ColorFonts("Fire()","Yellow")
          elseif var.remote.class == "BindableFunction" then
            var.remote.list = var.remote.list .. "\n" .. lib:ColorFonts(v.Parent.Name .. "." .. v.Name,"Red") .. ":" .. lib:ColorFonts("Invoke()","Blue")
          elseif var.remote.class == "RemoteEvent" then
            var.remote.list = var.remote.list .. "\n" .. lib:ColorFonts(v.Parent.Name .. "." .. v.Name,"Red") .. ":" .. lib:ColorFonts("FireServer()","Yellow")
          elseif var.remote.class == "RemoteFunction" then
            var.remote.list = var.remote.list .. "\n" .. lib:ColorFonts(v.Parent.Name .. "." .. v.Name,"Red") .. ":" .. lib:ColorFonts("InvokeServer()","Blue")
          elseif var.remote.list == "LocalScript" then
            var.remote.list = var.remote.list .. "\n" .. lib:ColorFonts(v.Parent.Name .. "." .. v.Name,"Red") .. " -> " .. lib:ColorFonts("LocalScript","Green")
          elseif var.remote.list == "ModuleScript" then
            var.remote.list = var.remote.list .. "\n" .. lib:ColorFonts(v.Parent.Name .. "." .. v.Name,"Red") .. " -> " .. lib:ColorFonts("ModuleScript","Green")
          end
        end
      end
      lab:EditLabel(var.remote.list)
end)

end

T3:Toggle("Receive task - TESTING",false,function(value)
    var.task.ach = value
    while wait() do
      if var.task.ach == false then break end
      game:GetService("ReplicatedStorage")["Remotes"]["ReceiveTask"]:FireServer(var.task.id + 1)
    end
end)





local args = {
    [1] = {
        ["harmIndex"] = 2,
        ["isSkill"] = true,
        ["heroGuid"] = "8eea9d46-df8a-4cd5-8166-5b3cc52cd36f",
        ["skillId"] = 200015
    }
}

game:GetService("ReplicatedStorage")["Remotes"]["HeroSkillHarm"]:FireServer(unpack(args))

local args = {
    [1] = "6cd1497a-299a-455f-a250-aace178fcef5"
}

game:GetService("ReplicatedStorage")["Remotes"]["PlayerRespirationSkillAttack"]:InvokeServer(unpack(args))
local args = {
    [1] = "72b7f289-8d06-45f5-a439-bd0b65f703b0"
}

game:GetService("ReplicatedStorage")["Remotes"]["EquipWeapon"]:FireServer(unpack(args))



game:GetService("ReplicatedStorage")["Remotes"]["FinishTask"]:FireServer(unpack(args))
lib:HookFunction(function(method,self,args)
    if method == "InvokeServer" and self == "ExtractHero" then
      var.egg.id = args[1]["drawCardPlatformId"]
      var.egg.count = args[1]["count"]
    elseif method == "FireServer" and self == "FinishTask" then
      var.task.id = args[1]
    elseif method == "FireServer" and self == "HeroSkillHarm" then
      var.hero.index = args[1]["harmIndex"]
      var.hero.skill = args[1]["isSkill"]
      var.hero.guid = args[1]["heroGuid"]
      var.hero.id = args[1]["skillId"]
    elseif method == "FireServer" and self == "HeroSkillHarm" and var.hero.ft2 == true then
      if args[1]["harmIndex"] > var.hero.index then
        var.hero.index = args[1]["harmIndex"]
        var.hero.skill = args[1]["isSkill"]
        var.hero.id = args[1]["skillId"]
      end
    elseif method == "FireServer" and self == "EquipWeapon" then
      var.forge.guid = args[1]
    end
end)