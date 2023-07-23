getgenv().autoOrb = false
getgenv().autoLaunch = false
getgenv().autoView = false

local Network = require(game:GetService("ReplicatedStorage").Library.Client.Network)
local Fire, Invoke = Network.Fire, Network.Invoke
local InvokeHook = hookfunction(debug.getupvalue(Invoke, 1), function(...) return true end)
local FireHook = hookfunction(debug.getupvalue(Fire, 1), function(...) return true end)
local orbs = workspace:WaitForChild("__MAP"):WaitForChild("Interactive"):WaitForChild("Orbs")

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Yeet a Pet by Hellsend", "Ocean")
local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("Farming")
Section:NewToggle("Auto Orb", "Auto collects orbs", function(v)
    getgenv().autoOrb = v
    print(v)
end)
Section:NewToggle("Auto Launch", "Automatically launches for you", function(v)
    getgenv().autoLaunch = v
    print(v)
end)

local Section = Tab:NewSection("Visual")
Section:NewButton("View character", "Views your character", function()
    local camera = workspace.CurrentCamera
    local plr = game.Players.LocalPlayer
    local chr = plr.Character
    local hum = chr:WaitForChild("Humanoid")
    camera.CameraSubject = hum
end)
Section:NewToggle("Auto view character", "Stops camera from changing subjects", function(v)
    getgenv().autoView = v
end)



task.spawn(function()
    while task.wait() do -- loop
        if getgenv().autoOrb then
            if #orbs:GetChildren() ~= 0 then -- not do the whole thing unless thingy spawned
                for _,v in pairs(orbs:GetChildren()) do -- could make this more potato pc friendly but was too lazy
                    v.Orb.CFrame = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame -- collect all orbs (this works because you are network owner LOL)
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
            local chr = plr.Character
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
            local chr = plr.Character
            local hum = chr:WaitForChild("Humanoid")
            if camera.CameraSubject ~= hum then
                camera.CameraSubject = hum
            end
    end
    end
end)
