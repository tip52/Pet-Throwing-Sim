
--#region var1
repeat task.wait() until game:IsLoaded() and game:GetService("ReplicatedStorage"):FindFirstChild("Library") and game.Players.LocalPlayer and game.Players.LocalPlayer.PlayerGui:FindFirstChild("Main") and game.Players.LocalPlayer.PlayerGui.Main:FindFirstChild("Right") and game.Players.LocalPlayer.Character
print("loaded")



getgenv().autoOrb = false
getgenv().autoLaunch = false
getgenv().autoView = false
-- hatching
getgenv().triple = false
getgenv().octuple = false
getgenv().hatch = false
getgenv().EggName = nil
getgenv().tpToEgg = false
getgenv().insanehatch = false
getgenv().luckyhatch = false
local newName,insaneLuck,superLuck = nil,false,false
local wasHatch,wasLaunch,wasTp = false, false, false
local lib= require(game.ReplicatedStorage.Library)
--#endregion

for i,v in pairs(game.CoreGui:GetChildren()) do
    if v:FindFirstChild("Main") and v.Main:FindFirstChild("MainHeader") and v.Main:FindFirstChild("pages") then
        v:Destroy()
    end
end

task.spawn(function()

        game.Players.LocalPlayer.Idled:connect(function()
            game:GetService("VirtualInputManager"):SendKeyEvent(true, "W", false, game)
            wait()
            game:GetService("VirtualInputManager"):SendKeyEvent(false, "W", false, game)
        end)
end)

local function IsBoost(boost)
    local boosts = {
        "Insane Luck",
        "Triple Damage",
        "Super Lucky"
    }
    local inTable = table.find(boosts,boost)
    assert(inTable,"Boost not found")
    local boostFound = false
    for i,v in pairs(lib.ServerBoosts.GetActiveBoosts()) do
        if i == boost then

            for i,v in pairs(v) do
                if i == "totalTimeLeft" and v ~= 0 then
                    boostFound = true
                    _G.time = v
                end
            end
        end
    end
    return boostFound
end

--#region var2

local Network = require(game:GetService("ReplicatedStorage").Library.Client.Network)
local Fire, Invoke = Network.Fire, Network.Invoke
local InvokeHook = hookfunction(debug.getupvalue(Invoke, 1), function(...) return true end)
local FireHook = hookfunction(debug.getupvalue(Fire, 1), function(...) return true end)

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Yeet a Pet by Tip", "Ocean")
local News = Window:NewTab("News")
local Tab = Window:NewTab("Main")
local Eggs = Window:NewTab("Eggs")
local Section = Tab:NewSection("Farming")
--#endregion

Section:NewToggle("Auto Orb", "Auto collects orbs", function(v)
    getgenv().autoOrb = v

end)
Section:NewToggle("Auto Launch", "Automatically launches for you", function(v)
    getgenv().autoLaunch = v
end)

--#region trackers
local orbAmt,curAmt ="0","0"
task.spawn(function()
    orbAmt = game.Players.LocalPlayer.PlayerGui.Main.Right:WaitForChild("Yeet Orbs").Amount.Text
    curAmt = game.Players.LocalPlayer.PlayerGui.Main.Right:WaitForChild("Yeet Coins").Amount.Text
end)
local orblab = Section:NewLabel("Orb amount: "..orbAmt)
local curlab = Section:NewLabel("Currency amount: "..curAmt)
local Section = Tab:NewSection("Visual")

--#endregion

Section:NewToggle("View character", "Views character when on", function(v)
    getgenv().autoView = v
end)
--#region labels
local NewsSection = News:NewSection("News")
NewsSection:NewLabel("- Added hatch when insane luck")
NewsSection:NewLabel("- Added hatch when super lucky")
NewsSection:NewLabel("Script by Tip, enjoy ;)")
--#endregion



local EggSec = Eggs:NewSection("Hatching")

EggSec:NewToggle("Start Hatching", "Auto hatches", function(v)
    getgenv().hatch = v
end)

EggSec:NewToggle("Hatch when insane luck", "Hatches during insane luck and stops after it ends", function(v)
    getgenv().insanehatch = v

end)

EggSec:NewToggle("Hatch when super luck", "Hatches during super luck and stops after it ends", function(v)
    getgenv().luckyhatch = v
end)

EggSec:NewToggle("Tp to egg", "Teleports to egg", function(v)
    getgenv().tpToEgg = v
end)

EggSec:NewDropdown("Eggs", "Eggs", {"Jetpack Egg", "Fireball Egg", "Wild Egg"}, function(v)
    getgenv().EggName = v
end)

EggSec:NewDropdown("Gold Eggs", "Gold Eggs", {"Golden Jetpack Egg", "Golden Fireball Egg", "Golden Wild Egg"}, function(v)
    getgenv().EggName = v
end)

EggSec:NewDropdown("Hatch Mode", "select hatch mode", {"Single", "Triple", "Octuple"}, function(v)
    if v == "Single" then
        getgenv().triple,getgenv().octuple = false,false
    elseif v == "Triple" then
        getgenv().triple = true
        getgenv().octuple = false
    elseif v == "Octuple" then
        getgenv().octuple = true
        getgenv().triple = false
    end
end)

task.spawn(function()
    while task.wait() do -- loop
        if getgenv().autoOrb then
            if #workspace:WaitForChild("__MAP"):WaitForChild("Interactive"):WaitForChild("Orbs"):GetChildren() ~= 0 then -- not do the whole thing unless thingy spawned
                for _,v in pairs(workspace:WaitForChild("__MAP"):WaitForChild("Interactive"):WaitForChild("Orbs"):GetChildren()) do -- could make this more potato pc friendly but was too lazy
                    task.spawn(function() v.Orb.CFrame = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame end) -- collect all orbs (this works because you are network owner LOL)
                    Fire("Yeet: Claim Orbs",v.Name) -- not even needed lmfao
            end
            end
    end
    end
end)
task.spawn(function()
    while task.wait() do -- loop
        if getgenv().autoLaunch then
            local plr = game.Players.LocalPlayer
            local chr
            repeat task.wait() chr = plr.Character until chr ~= nil
            local hum = chr:WaitForChild("HumanoidRootPart")
            hum.CFrame = CFrame.new(6727.01953, -16.339798, -869.642334, -0.0522250049, -1.02990164e-07, 0.998635352, 3.01589438e-08, 1, 1.04708107e-07, -0.998635352, 3.55861687e-08, -0.0522250049)
            task.wait(0.3)
            Invoke("Yeet a Pet: Throw")
    end
    end
end)

task.spawn(function()
    while task.wait() do -- loop
        if getgenv().autoView then
            local camera = workspace.CurrentCamera
            local plr = game.Players.LocalPlayer
            local chr
            repeat task.wait() chr = plr.Character until chr ~= nil
            local hum = chr:WaitForChild("Humanoid")
            if camera.CameraSubject ~= hum then
                camera.CameraSubject = hum
            end
    else
        if workspace:WaitForChild("__THINGS"):WaitForChild("Yeet"):FindFirstChild(game.Players.LocalPlayer.Name .."_CLIENT") then
            workspace.CurrentCamera.CameraSubject = workspace:WaitForChild("__THINGS"):WaitForChild("Yeet"):FindFirstChild(game.Players.LocalPlayer.Name .."_CLIENT")
        end
    end
    end
end)

task.spawn(function()
    while task.wait() do -- loop
        if getgenv().hatch and getgenv().EggName ~= nil then

            if getgenv().tpToEgg then
                local EggsFolder = workspace:WaitForChild("__MAP"):FindFirstChild("Eggs")
                newName = getgenv().EggName
                if string.find(getgenv().EggName,"Golden ") then
                    newName = string.gsub(getgenv().EggName,"Golden ","")
                end
                for i,v in pairs(EggsFolder:GetChildren()) do
                    for i,v in pairs(v:GetChildren()) do
                        if v.Name == "PLATFORM" and v:FindFirstChild("SectionName") and v.SectionName:FindFirstChild("SurfaceGui") and v.SectionName.SurfaceGui:FindFirstChild("TextLabel") and string.find(v.SectionName.SurfaceGui.TextLabel.Text,newName) then
                            game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = v.SectionName.CFrame * CFrame.new(0,3,0)
                        end
                    end
                end

            end
            Invoke("Buy Egg",getgenv().EggName,getgenv().triple,getgenv().octuple)
    end
    end
end)

task.spawn(function()
    while task.wait() do
        if orbAmt ~= game.Players.LocalPlayer.PlayerGui.Main.Right:WaitForChild("Yeet Orbs").Amount.Text then
            orbAmt = game.Players.LocalPlayer.PlayerGui.Main.Right:WaitForChild("Yeet Orbs").Amount.Text
            orblab:UpdateLabel("Orb amount: "..orbAmt)
        elseif curAmt ~= game.Players.LocalPlayer.PlayerGui.Main.Right:WaitForChild("Yeet Coins").Amount.Text then
            curAmt = game.Players.LocalPlayer.PlayerGui.Main.Right:WaitForChild("Yeet Coins").Amount.Text
            curlab:UpdateLabel("Currency amount: "..curAmt)
        end
    end
end)


task.spawn(function()
    while task.wait() do
        if getgenv().insanehatch then
    
        if IsBoost("Insane Luck") then
           
            if getgenv().hatch then
                wasHatch = true
            elseif getgenv().autoLaunch then
                wasLaunch = true
            elseif getgenv().tpToEgg then
                wasTp = true
            end
            getgenv().hatch = true
            getgenv().autoLaunch = false
            getgenv().tpToEgg = true
            insaneLuck = true

        else
            if insaneLuck then
                if wasHatch then
                    wasHatch = false
                    getgenv().hatch = true
                else
                    wasHatch = false
                    getgenv().hatch = false
                end


                if wasTp then
                    wasTp = false
                    getgenv().tpToEgg = true
                else
                    wasTp = false
                    getgenv().tpToEgg = false
                end


                if wasLaunch then
                    wasLaunch = false
                    getgenv().autoLaunch = true
                end


                insaneLuck = false
            end
        end
    else
        if insaneLuck then
            getgenv().hatch = false
        end
    end


end
end )

task.spawn(function ()

    while task.wait() do
        if getgenv().luckyhatch then
            
        if IsBoost("Super Lucky") then
        
            if getgenv().hatch then
                wasHatch = true
            elseif getgenv().autoLaunch then
                wasLaunch = true
            elseif getgenv().tpToEgg then
                wasTp = true
            end
            getgenv().hatch = true
            getgenv().autoLaunch = false
            getgenv().tpToEgg = true
            superLuck = true

        else


            if superLuck then
                if wasHatch then
                    wasHatch = false
                    getgenv().hatch = true
                else
                    wasHatch = false
                    getgenv().hatch = false
                end


                if wasTp then
                    wasTp = false
                    getgenv().tpToEgg = true
                else
                    wasTp = false
                    getgenv().tpToEgg = false
                end


                if wasLaunch then
                    wasLaunch = false
                    getgenv().autoLaunch = true
                end


                superLuck = false
            end


        end


    else
        if superLuck then
            getgenv().hatch = false
        end
    end






end
    
end)
