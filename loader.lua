if game.PlaceId == 6604417568 then

    local library = loadstring(game:HttpGet(('https://raw.githubusercontent.com/AikaV3rm/UiLib/master/Lib.lua')))()

    local w = library:CreateWindow("Minerscave 1.3") -- Creates the window
    local b = w:CreateFolder("Character") -- Creates the folder(U will put here your buttons,etc)
    local d = w:CreateFolder("Gui") -- Creates the folder(U will put here your buttons,etc)
    local Combat = w:CreateFolder("Combat") -- Creates the folder(U will put here your buttons,etc)

--b:Label("Pretty Useless NGL",{
    --TextSize = 25; -- Self Explaining
    --TextColor = Color3.fromRGB(255,255,255); -- Self Explaining
  --  BgColor = Color3.fromRGB(69,69,69); -- Self Explaining
    
--})

b:Slider("Walkspeed",{
    min = 16; -- min value of the slider
    max = 250; -- max value of the slider
    precise = true; -- max 2 decimals
},function(value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
end)

b:Slider("Jumppower",{
    min = 50; -- min value of the slider
    max = 250; -- max value of the slider
    precise = true; -- max 2 decimals
},function(value)
    game.Players.LocalPlayer.Character.Humanoid.UseJumpPower = true
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
end)

getgenv().start = 9
getgenv().ende = 36

Combat:Bind("Inv Cleaner",Enum.KeyCode.H,function() --Default bind
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Module Manager";
        Text = "Clearing Inventory";
        })
    local num = getgenv().start
    repeat
        local args = {
            [1] = num,
            [2] = -1
            }
        
            game:GetService("ReplicatedStorage").GameRemotes.MoveItem:InvokeServer(unpack(args))
            local args = {
                [1] = true
            }
            game:GetService("ReplicatedStorage").GameRemotes.DropItem:InvokeServer(unpack(args))
        num = num + 1
    until num == getgenv().ende + 1
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Inv Cleaner";
        Text = "Cleaned Inventory!";
        })
end)

Combat:Button("No Fall",function()
    local mt = getrawmetatable(game)
    local namecall = mt.__namecall
    setreadonly(mt,false)
    mt.__namecall = newcclosure(function(self,...) -- self ( the instance )  and args 
        if getnamecallmethod() == 'FireServer' and tostring(self) == 'Demo' then -- checking if we're firing a remote

                return
        end
        return namecall(self,...)
    end)
    setreadonly(mt,true)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Module Manager";
        Text = "Nofall";
        })
end)
getgenv().killaura = false
Combat:Toggle("Kill Aura",function(bool)
    shared.toggle = bool
    getgenv().killaura = shared.toggle
    
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer



    local function GetClosest()
        local Character = LocalPlayer.Character
        local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
        if not (Character or HumanoidRootPart) then return end

        local TargetDistance = math.huge
        local Target

        for i,v in ipairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local TargetHRP = v.Character.HumanoidRootPart
                local mag = (HumanoidRootPart.Position - TargetHRP.Position).magnitude
                if mag < TargetDistance then
                    TargetDistance = mag
                    Target = v
                end
            end
        end

        return Target
    end


    while true do
    wait(0.1)
    local Target = GetClosest()
    print(Target)
    if getgenv().killaura == true then
        
                print(Target)
                local args = {
                    [1] = Target.Character
                }
                
                game:GetService("ReplicatedStorage").GameRemotes.Attack:InvokeServer(unpack(args))
                
        end
    end
    
    
end)

Combat:Slider("Inv Manager Start",{
    min = 1; -- min value of the slider
    max = 36; -- max value of the slider
    precise = true; -- max 2 decimals
},function(value)
    getgenv().start = value
end)
Combat:Slider("Inv Manager End",{
    min = 1; -- min value of the slider
    max = 37; -- max value of the slider
    precise = true; -- max 2 decimals
},function(value)
    getgenv().ende = value
end)

d:DestroyGui()

--[[
How to refresh a dropdown:
1)Create the dropdown and save it in a variable
local yourvariable = b:Dropdown("Hi",yourtable,function(a)
    print(a)
end)
2)Refresh it using the function
yourvariable:Refresh(yourtable)
How to refresh a label:
1)Create your label and save it in a variable
local yourvariable = b:Label("Pretty Useless NGL",{
    TextSize = 25; -- Self Explaining
    TextColor = Color3.fromRGB(255,255,255);
    BgColor = Color3.fromRGB(69,69,69);
})
2)Refresh it using the function
yourvariable:Refresh("Hello") It will only change the text ofc
]]
end
