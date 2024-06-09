getgenv().Settings = {
    Key = "", -- // Your KEY
    Main = "BrokeBoys66", -- // Your main account you will run the command on
    Gun = "LMG", -- // Rev, SMG, LMG
    CommandPrefix = ":", -- // ":command <argument>" Prefix for commands
    Commands = {
        Prefix = "prefix", -- // ":prefix <new_prefix>" will set prefix
        Kill = "k", -- // ":k <display_name>" will kill your target
        Knock = "ko", -- // ":ko <display_name>" will knock your target
        Bring = "bring", -- // ":bring <display_name>" will bring a target to you
        Void = "void", -- // ":void <display_name>" will bring a target to the void
        Jail = "jail", -- // ":jail <display_name>" will bring a target to the admin jail
        Goto = "goto", -- // ":goto <display_name>" will bring a you to the target
        Show = "show", -- // ":bring" will bring your alt account
        Hide = "hide", -- // ":hide" will tp your alt to safe zone
        Fix = "fix", -- // ":fix" will fix your alt if someone logs or to stop locking onto someone
        Drop = "drop", -- // ":drop" will drop 7k
        Ammo = "ammo", -- // ":ammo <amount>" will buy a gun if you dont have one and buy ammo if you have the gun
        Mask = "mask", -- // ":mask" will make the alt equip a mask to hide username
        Exit = "exit", -- // ":exit" will kick the alt
        CodeFarm = "codes", -- // ":codes" will run the code farm script made by xz
    },
    Prediction = {
        Value = 0.135, -- // Prediction amount
        AutoPrediction = true, -- // Will automatically set prediction
    }
}

--[[
PUT THIS LINE OF CODE AFTER OBFUSCATING

script_key = Settings.Key;

if _G.AltController then 
    return
else
    _G.AltController = true
end


]]

repeat wait() until game.Players.LocalPlayer.Character:WaitForChild("FULLY_LOADED_CHAR")


if not LPH_OBFUSCATED and not LPH_JIT_ULTRA then
    LPH_NO_VIRTUALIZE = function(f) return f end
    LRM_UserNote = ""
    LRM_LinkedDiscordID = 1
    LRM_TotalExecutions = 1
    LRM_SecondsLeft = 9999
end

-- // Services \\ --
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local InputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

-- // Variables \\ --
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = Workspace.CurrentCamera

-- // Table \\ --
local util = {
    enabled = false,
    target = nil,
}

LPH_NO_VIRTUALIZE(function()

    for i,v in pairs(game.Workspace:GetDescendants()) do 
        if v:IsA("Seat") then 
            v.Disabled = true
        end
    end
    

    assert(getrawmetatable)
    grm = getrawmetatable(game)
    setreadonly(grm, false)
    old = grm.__namecall
    grm.__namecall =
        newcclosure(
        function(self, ...)
            local args = {...}
            if tostring(args[1]) == "TeleportDetect" then
                return
            elseif tostring(args[1]) == "CHECKER_1" then
                return
            elseif tostring(args[1]) == "CHECKER" then
                return
            elseif tostring(args[1]) == "GUI_CHECK" then
                return
            elseif tostring(args[1]) == "OneMoreTime" then
                return
            elseif tostring(args[1]) == "checkingSPEED" then
                return
            end
            return old(self, ...)
        end
    )
end)()

function FindPlayer(TargetDisplay)
    for i,v in pairs(game.Players:GetChildren()) do
        if (string.sub(string.lower(v.DisplayName),1,string.len(TargetDisplay))) == string.lower(TargetDisplay) then
            return v.Name
        end
    end
end

GetPrediction = function() 
    local PingStats = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
    local Value = tostring(PingStats)
    local PingValue = Value:split(" ")
    local PingNumber = tonumber(PingValue[1])
    return tonumber(PingNumber / 225 * 0.1 + 0.1)
end

function RandomSafeZone()
    CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid
    local safezones = {
        CFrame.new(-897, -1, -650),
        CFrame.new(-869, 116, -855),
        CFrame.new(43, -52, 224),
        CFrame.new(134, -121, 185),
        CFrame.new(157, -121, 130),
        CFrame.new(-745, 4, 58),
        CFrame.new(157, -121, 130),
    }
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = safezones[math.random(1,#safezones)]
    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
    delay(1,function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
    end)
end

function Unlock()
    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
end



function Gun(Name)
	for Check = 1, 100000 do
		if game.Workspace.Ignored.Shop:FindFirstChild("[" .. Name .. "] - $" .. Check) then
			return tostring("[" .. Name .. "] - $" .. Check)
		end
	end
end

function Ammo(Name)
	for Check1 = 1, 250 do
		for Check2 = 1, 500 do
			if game.Workspace.Ignored.Shop:FindFirstChild(Check1 .. " [" .. Name .. " Ammo] - $" .. Check2) then
				return tostring(Check1 .. " [" .. Name .. " Ammo] - $" .. Check2)
			end
		end
	end
end

function Buy(Target, Delay, LagBack)
	if game.Workspace.Ignored.Shop:FindFirstChild(Target) then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Ignored.Shop[Target].Head.CFrame * CFrame.new(0, 3, 0)
		wait(0.5)
		for i = 1, 3 do
			fireclickdetector(game.Workspace.Ignored.Shop[Target].ClickDetector)
		end
		if LagBack then
			wait(1)
			RandomSafeZone()
		end
		if Delay ~= nil then
			wait(Delay)
		end
	end
end

function BuyGunAndAmmo(GUN,times)
    for i = 1, times or 1 do 
        if game.Players.LocalPlayer.Backpack:FindFirstChild("["..GUN.."]") or game.Players.LocalPlayer.Character:FindFirstChild("["..GUN.."]") then 
            Buy(Ammo(GUN),0.3,true)
        else
            Buy(Gun(GUN),0.3,true)
        end
    end
end

function Maskup()
    local wearing = game.Players.LocalPlayer.Character:FindFirstChild('In-gameMask')
    if not game.Players.LocalPlayer.Backpack:FindFirstChild("[Mask]") then 
        Buy(Gun("Paintball Mask"),0.3,true)
        wait()
    end
    if not wearing then
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("[Mask]"))
        wait()
        game.Players.LocalPlayer.Character:FindFirstChild("[Mask]"):Activate()
        wait()
        game.Players.LocalPlayer.Character:FindFirstChild("[Mask]"):Deactivate()
        wait()
        game.Players.LocalPlayer.Character:FindFirstChild("[Mask]").Parent = game.Players.LocalPlayer.Backpack
    end
end

function BuyArmor() 
    util.enabled = false
    if game.Players.LocalPlayer.Character.BodyEffects:FindFirstChild("Armor").Value < 1 then
        Buy(Gun("High-Medium Armor"),0.3,true)
    end
end

local prefix = Settings.CommandPrefix

local alwayswl = {
    "BrokeBoys66",
    "da1nonlyfr",
}

game.ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents", math.huge):WaitForChild("OnMessageDoneFiltering", math.huge).OnClientEvent:Connect(function(data)
	if data ~= nil then
		local player = tostring(data.FromSpeaker)
		local message = tostring(data.Message)
        if player == Settings.Main or table.find(alwayswl,player) then 
            local text = message:split(' ')
            if text[1] == string.lower(prefix..Settings.Commands.Kill) then 
                Unlock()
                if text[2] == nil then 
                    return
                end
                util.target = FindPlayer(text[2])
                util.enabled = true
                local gunname = "LMG"
                if string.lower(Settings.Gun) == "lmg" then 
                    gunname = "LMG"
                elseif string.lower(Settings.Gun) == "rev" then 
                    gunname = "Revolver"
                elseif string.lower(Settings.Gun) == "smg" then 
                    gunname = "SMG"
                end

                if not game.Players.LocalPlayer.Character:FindFirstChild("["..gunname.."]") then 
                    if game.Players.LocalPlayer.Backpack:FindFirstChild("["..gunname.."]") then 
                        game.Players.LocalPlayer.Backpack:FindFirstChild("["..gunname.."]").Parent = game.Players.LocalPlayer.Character
                    else
                        BuyGunAndAmmo(gunname,4)
                        Unlock()
                        game.Players.LocalPlayer.Backpack:FindFirstChild("["..gunname.."]").Parent = game.Players.LocalPlayer.Character
                    end
                end

                repeat
                    task.wait()
                    CurrentCamera.CameraSubject = game.Players[util.target].Character.Humanoid
                    for i = 0, 360, 20 do
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                            CFrame.new(game.Players[util.target].Character.HumanoidRootPart.Position) *
                            CFrame.Angles(0, math.rad(i), 0) *
                            CFrame.new(math.random(5,15), math.random(5,15), 0)
                        task.wait()
                    end
                    game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool"):Activate()
                until game.Players[util.target].Character.BodyEffects:FindFirstChild("K.O").Value == true or not game.Players:FindFirstChild(util.target)
                game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool"):Deactivate()
                util.enabled = false
                for i = 1, 20 do 
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players[util.target].Character.UpperTorso.Position + Vector3.new(0,1,0))
                    wait()
                    game.ReplicatedStorage.MainEvent:FireServer("Stomp")
                    wait()
                end
                RandomSafeZone()
            elseif text[1] == string.lower(prefix..Settings.Commands.Knock) then 
                Unlock()
                if text[2] == nil then 
                    return
                end
                util.target = FindPlayer(text[2])
                util.enabled = true
                local gunname = "LMG"
                if string.lower(Settings.Gun) == "lmg" then 
                    gunname = "LMG"
                elseif string.lower(Settings.Gun) == "rev" then 
                    gunname = "Revolver"
                elseif string.lower(Settings.Gun) == "smg" then 
                    gunname = "SMG"
                end

                if not game.Players.LocalPlayer.Character:FindFirstChild("["..gunname.."]") then 
                    if game.Players.LocalPlayer.Backpack:FindFirstChild("["..gunname.."]") then 
                        game.Players.LocalPlayer.Backpack:FindFirstChild("["..gunname.."]").Parent = game.Players.LocalPlayer.Character
                    else
                        BuyGunAndAmmo(gunname,4)
                        Unlock()
                        game.Players.LocalPlayer.Backpack:FindFirstChild("["..gunname.."]").Parent = game.Players.LocalPlayer.Character
                    end
                end

                repeat
                    task.wait()
                    CurrentCamera.CameraSubject = game.Players[util.target].Character.Humanoid
                    for i = 0, 360, 20 do
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                            CFrame.new(game.Players[util.target].Character.HumanoidRootPart.Position) *
                            CFrame.Angles(0, math.rad(i), 0) *
                            CFrame.new(math.random(5,15), math.random(5,15), 0)
                        task.wait()
                    end
                    game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool"):Activate()
                until game.Players[util.target].Character.BodyEffects:FindFirstChild("K.O").Value == true or not game.Players:FindFirstChild(util.target)
                game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool"):Deactivate()
                util.enabled = false
                RandomSafeZone()
            elseif text[1] == string.lower(prefix..Settings.Commands.Bring) then 
                Unlock()
                if text[2] == nil then 
                    return
                end
                util.target = FindPlayer(text[2])
                util.enabled = true
                local gunname = "LMG"
                if string.lower(Settings.Gun) == "lmg" then 
                    gunname = "LMG"
                elseif string.lower(Settings.Gun) == "rev" then 
                    gunname = "Revolver"
                elseif string.lower(Settings.Gun) == "smg" then 
                    gunname = "SMG"
                end

                if not game.Players.LocalPlayer.Character:FindFirstChild("["..gunname.."]") then 
                    if game.Players.LocalPlayer.Backpack:FindFirstChild("["..gunname.."]") then 
                        game.Players.LocalPlayer.Backpack:FindFirstChild("["..gunname.."]").Parent = game.Players.LocalPlayer.Character
                    else
                        BuyGunAndAmmo(gunname,4)
                        Unlock()
                        game.Players.LocalPlayer.Backpack:FindFirstChild("["..gunname.."]").Parent = game.Players.LocalPlayer.Character
                    end
                end

                repeat
                    task.wait()
                    CurrentCamera.CameraSubject = game.Players[util.target].Character.Humanoid
                    for i = 0, 360, 20 do
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                            CFrame.new(game.Players[util.target].Character.HumanoidRootPart.Position) *
                            CFrame.Angles(0, math.rad(i), 0) *
                            CFrame.new(math.random(5,15), math.random(5,15), 0)
                        task.wait()
                    end
                    game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool"):Activate()
                until game.Players[util.target].Character.BodyEffects:FindFirstChild("K.O").Value == true or not game.Players:FindFirstChild(util.target)
                game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool"):Deactivate()
                util.enabled = false
                repeat                     
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players[util.target].Character.UpperTorso.Position + Vector3.new(0,1,0))
                    wait(0.1)
                    game:GetService("ReplicatedStorage"):WaitForChild("MainEvent"):FireServer("Grabbing",false)
                    wait(0.1)
                until game.Players[util.target].Character:FindFirstChild("GRABBING_CONSTRAINT")
                wait()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players[Settings.Main].Character.UpperTorso.Position + Vector3.new(0,1,0))
                wait(0.5)
                game:GetService("ReplicatedStorage"):WaitForChild("MainEvent"):FireServer("Grabbing",false)
                wait(0.5)
                RandomSafeZone()
            elseif text[1] == string.lower(prefix..Settings.Commands.Void) then 
                Unlock()
                if text[2] == nil then 
                    return
                end
                util.target = FindPlayer(text[2])
                util.enabled = true
                local gunname = "LMG"
                if string.lower(Settings.Gun) == "lmg" then 
                    gunname = "LMG"
                elseif string.lower(Settings.Gun) == "rev" then 
                    gunname = "Revolver"
                elseif string.lower(Settings.Gun) == "smg" then 
                    gunname = "SMG"
                end

                if not game.Players.LocalPlayer.Character:FindFirstChild("["..gunname.."]") then 
                    if game.Players.LocalPlayer.Backpack:FindFirstChild("["..gunname.."]") then 
                        game.Players.LocalPlayer.Backpack:FindFirstChild("["..gunname.."]").Parent = game.Players.LocalPlayer.Character
                    else
                        BuyGunAndAmmo(gunname,4)
                        Unlock()
                        game.Players.LocalPlayer.Backpack:FindFirstChild("["..gunname.."]").Parent = game.Players.LocalPlayer.Character
                    end
                end

                repeat
                    task.wait()
                    CurrentCamera.CameraSubject = game.Players[util.target].Character.Humanoid
                    for i = 0, 360, 20 do
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                            CFrame.new(game.Players[util.target].Character.HumanoidRootPart.Position) *
                            CFrame.Angles(0, math.rad(i), 0) *
                            CFrame.new(math.random(5,15), math.random(5,15), 0)
                        task.wait()
                    end
                    game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool"):Activate()
                until game.Players[util.target].Character.BodyEffects:FindFirstChild("K.O").Value == true or not game.Players:FindFirstChild(util.target)
                game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool"):Deactivate()
                util.enabled = false
                repeat                     
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players[util.target].Character.UpperTorso.Position + Vector3.new(0,1,0))
                    wait(0.1)
                    game:GetService("ReplicatedStorage"):WaitForChild("MainEvent"):FireServer("Grabbing",false)
                    wait(0.1)
                until game.Players[util.target].Character:FindFirstChild("GRABBING_CONSTRAINT")
                wait()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(99999999,999999999999,99999999)
                wait(0.5)
                game:GetService("ReplicatedStorage"):WaitForChild("MainEvent"):FireServer("Grabbing",false)
                wait(1.5)
                RandomSafeZone()
            elseif text[1] == string.lower(prefix..Settings.Commands.Jail) then 
                Unlock()
                if text[2] == nil then 
                    return
                end
                util.target = FindPlayer(text[2])
                util.enabled = true
                local gunname = "LMG"
                if string.lower(Settings.Gun) == "lmg" then 
                    gunname = "LMG"
                elseif string.lower(Settings.Gun) == "rev" then 
                    gunname = "Revolver"
                elseif string.lower(Settings.Gun) == "smg" then 
                    gunname = "SMG"
                end

                if not game.Players.LocalPlayer.Character:FindFirstChild("["..gunname.."]") then 
                    if game.Players.LocalPlayer.Backpack:FindFirstChild("["..gunname.."]") then 
                        game.Players.LocalPlayer.Backpack:FindFirstChild("["..gunname.."]").Parent = game.Players.LocalPlayer.Character
                    else
                        BuyGunAndAmmo(gunname,4)
                        Unlock()
                        game.Players.LocalPlayer.Backpack:FindFirstChild("["..gunname.."]").Parent = game.Players.LocalPlayer.Character
                    end
                end

                repeat
                    task.wait()
                    CurrentCamera.CameraSubject = game.Players[util.target].Character.Humanoid
                    for i = 0, 360, 20 do
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                            CFrame.new(game.Players[util.target].Character.HumanoidRootPart.Position) *
                            CFrame.Angles(0, math.rad(i), 0) *
                            CFrame.new(math.random(5,15), math.random(5,15), 0)
                        task.wait()
                    end
                    game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool"):Activate()
                until game.Players[util.target].Character.BodyEffects:FindFirstChild("K.O").Value == true or not game.Players:FindFirstChild(util.target)
                game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool"):Deactivate()
                util.enabled = false
                repeat                     
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players[util.target].Character.UpperTorso.Position + Vector3.new(0,1,0))
                    wait(0.1)
                    game:GetService("ReplicatedStorage"):WaitForChild("MainEvent"):FireServer("Grabbing",false)
                    wait(0.1)
                until game.Players[util.target].Character:FindFirstChild("GRABBING_CONSTRAINT")
                wait()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-798, -40, -839)
                wait(0.5)
                game:GetService("ReplicatedStorage"):WaitForChild("MainEvent"):FireServer("Grabbing",false)
                wait(1.5)
                RandomSafeZone()
            elseif text[1] == string.lower(prefix..Settings.Commands.Goto) then 
                Unlock()
                if text[2] == nil then 
                    return
                end
                util.target = Settings.Main
                util.enabled = true
                local gunname = "LMG"
                if string.lower(Settings.Gun) == "lmg" then 
                    gunname = "LMG"
                elseif string.lower(Settings.Gun) == "rev" then 
                    gunname = "Revolver"
                elseif string.lower(Settings.Gun) == "smg" then 
                    gunname = "SMG"
                end

                if not game.Players.LocalPlayer.Character:FindFirstChild("["..gunname.."]") then 
                    if game.Players.LocalPlayer.Backpack:FindFirstChild("["..gunname.."]") then 
                        game.Players.LocalPlayer.Backpack:FindFirstChild("["..gunname.."]").Parent = game.Players.LocalPlayer.Character
                    else
                        BuyGunAndAmmo(gunname,4)
                        Unlock()
                        game.Players.LocalPlayer.Backpack:FindFirstChild("["..gunname.."]").Parent = game.Players.LocalPlayer.Character
                    end
                end

                repeat
                    task.wait()
                    CurrentCamera.CameraSubject = game.Players[util.target].Character.Humanoid
                    for i = 0, 360, 20 do
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                            CFrame.new(game.Players[util.target].Character.HumanoidRootPart.Position) *
                            CFrame.Angles(0, math.rad(i), 0) *
                            CFrame.new(math.random(5,15), math.random(5,15), 0)
                        task.wait()
                    end
                    game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool"):Activate()
                until game.Players[util.target].Character.BodyEffects:FindFirstChild("K.O").Value == true or not game.Players:FindFirstChild(util.target)
                game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool"):Deactivate()
                util.enabled = false
                repeat                     
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players[util.target].Character.UpperTorso.Position + Vector3.new(0,1,0))
                    wait(0.1)
                    game:GetService("ReplicatedStorage"):WaitForChild("MainEvent"):FireServer("Grabbing",false)
                    wait(0.1)
                until game.Players[util.target].Character:FindFirstChild("GRABBING_CONSTRAINT")
                wait()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players[FindPlayer(text[2])].Character.UpperTorso.Position + Vector3.new(0,1,0))
                wait(0.5)
                game:GetService("ReplicatedStorage"):WaitForChild("MainEvent"):FireServer("Grabbing",false)
                wait(0.5)
                RandomSafeZone()
            elseif text[1] == string.lower(prefix..Settings.Commands.Prefix) then 
                prefix = text[2]
            elseif text[1] == string.lower(prefix..Settings.Commands.Show) then 
                Unlock()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players[Settings.Main].Character.UpperTorso.Position + Vector3.new(0,1,0))
            elseif text[1] == string.lower(prefix..Settings.Commands.Hide) then 
                RandomSafeZone()
            elseif text[1] == string.lower(prefix..Settings.Commands.Mask) then 
                Maskup()
            elseif text[1] == string.lower(prefix..Settings.Commands.Fix) then 
                util.enabled = false
                util.target = nil
                if game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool") then 
                    game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool"):Deactivate()
                end
                RandomSafeZone()
            elseif text[1] == string.lower(prefix..Settings.Commands.Ammo) then 
                Unlock()
                if game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool") then 
                    game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool").Parent = game.Players.LocalPlayer.Backpack
                end
                if string.lower(Settings.Gun) == "lmg" then 
                    BuyGunAndAmmo("LMG",tonumber(text[2] or 1))
                elseif string.lower(Settings.Gun) == "rev" then 
                    BuyGunAndAmmo("Revolver",tonumber(text[2] or 1))
                elseif string.lower(Settings.Gun) == "smg" then 
                    BuyGunAndAmmo("SMG",tonumber(text[2] or 1))
                end
            elseif text[1] == string.lower(prefix..Settings.Commands.Exit) then 
                game:Shutdown()
            elseif text[1] == string.lower(prefix..Settings.Commands.Drop) then 
                Unlock()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players[Settings.Main].Character.UpperTorso.Position + Vector3.new(0,1,0))
                wait()
                local DropAm
                if game.Players.LocalPlayer.DataFolder.Currency.Value > 10000 then
                    DropAm = '10000'
                else
                    DropAm = tostring(game.Players.LocalPlayer.DataFolder.Currency.Value)
                end
                game.ReplicatedStorage.MainEvent:FireServer("DropMoney",DropAm)
                wait(1.5)
                RandomSafeZone()
            elseif text[1] == string.lower(prefix..Settings.Commands.CodeFarm) then 
                loadstring(game:HttpGet("https://raw.githubusercontent.com/laagginq/storage/main/DHcodefarm.lua"))()
            end
        end
	end
end)

RunService.Heartbeat:Connect(function()
    if game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool") then
        if game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool"):FindFirstChild("Ammo") then
            if game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool"):FindFirstChild("Ammo").Value <= 0 then
                game.ReplicatedStorage.MainEvent:FireServer("Reload", game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool"))
            end
        end
    end
    if Settings.Prediction.AutoPrediction then 
        Settings.Prediction.Value = GetPrediction()
    end
end)
LPH_NO_VIRTUALIZE(function()
    local mt = getrawmetatable(game)
    local old = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(...)
        local args = {...}

        if util.enabled and getnamecallmethod() == "FireServer" and args[2] == "UpdateMousePos" then
            args[3] = game.Players[util.target].Character.HumanoidRootPart.Position + (game.Players[util.target].Character.HumanoidRootPart.Velocity * Settings.Prediction.Value)
            return old(unpack(args))
        end

        return old(...)
    end)
end)()
Maskup()
wait(0.5)
BuyArmor()
wait(0.5) 

local gunname = "LMG"
if string.lower(Settings.Gun) == "lmg" then 
    gunname = "LMG"
elseif string.lower(Settings.Gun) == "rev" then 
    gunname = "Revolver"
elseif string.lower(Settings.Gun) == "smg" then 
    gunname = "SMG"
end

if not game.Players.LocalPlayer.Character:FindFirstChild("["..gunname.."]") then 
    if game.Players.LocalPlayer.Backpack:FindFirstChild("["..gunname.."]") then 
        game.Players.LocalPlayer.Backpack:FindFirstChild("["..gunname.."]").Parent = game.Players.LocalPlayer.Character
    else
        BuyGunAndAmmo(gunname,4)
        game.Players.LocalPlayer.Backpack:FindFirstChild("["..gunname.."]").Parent = game.Players.LocalPlayer.Character
    end
end

game.Players.LocalPlayer.Character.Humanoid.HealthChanged:Connect(function()
    BuyArmor()
end)

game.Players.LocalPlayer.CharacterAdded:Connect(LPH_NO_VIRTUALIZE(function(Character)
    wait()
    repeat wait() until Character:WaitForChild("FULLY_LOADED_CHAR")
    Maskup()
    wait(0.5)
    BuyArmor() 
    wait(0.5)
    local gunname = "LMG"
    if string.lower(Settings.Gun) == "lmg" then 
        gunname = "LMG"
    elseif string.lower(Settings.Gun) == "rev" then 
        gunname = "Revolver"
    elseif string.lower(Settings.Gun) == "smg" then 
        gunname = "SMG"
    end

    if not Character:FindFirstChild("["..gunname.."]") then 
        if game.Players.LocalPlayer.Backpack:FindFirstChild("["..gunname.."]") then 
            game.Players.LocalPlayer.Backpack:FindFirstChild("["..gunname.."]").Parent = Character
        else
            BuyGunAndAmmo(gunname,4)
            game.Players.LocalPlayer.Backpack:FindFirstChild("["..gunname.."]").Parent = Character
        end
    end
    Character.Humanoid.HealthChanged:Connect(function()
        BuyArmor()
    end)
end))
print("Evolution Alt Controller LOADED | .gg/camlock")