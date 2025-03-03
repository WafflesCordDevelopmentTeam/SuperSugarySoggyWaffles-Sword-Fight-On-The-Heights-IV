-- Your Discord account info message
local discordAccountInfo = [[
888       888           .d888  .d888 888         d8b                   888 d8b                                       888                         Y88b                           888                  d8b          
888   o   888          d88P"  d88P"  888         88P                   888 Y8P                                       888                          Y88b                          888                  Y8P          
888  d8b  888          888    888    888         8P                    888                                           888                           Y88b                         888                               
888 d888b 888  8888b.  888888 888888 888  .d88b. "  .d8888b        .d88888 888 .d8888b   .d8888b .d88b.  888d888 .d88888                            Y88b       .d8888b  8888b.  888888 888  888  888 888 888  888 
888d88888b888     "88b 888    888    888 d8P  Y8b   88K           d88" 888 888 88K      d88P"   d88""88b 888P"  d88" 888                            d88P      d88P"        "88b 888    888  888  888 888 `Y8bd8P' 
88888P Y88888 .d888888 888    888    888 88888888   "Y8888b.      888  888 888 "Y8888b. 888     888  888 888    888  888      888888 888888 888888 d88P       888      .d888888 888    888  888  888 888   X88K   
8888P   Y8888 888  888 888    888    888 Y8b.            X88      Y88b 888 888      X88 Y88b.   Y88..88P 888    Y88b 888                          d88P        Y88b.    888  888 Y88b.  Y88b 888 d88P 888 .d8""8b. 
888P     Y888 "Y888888 888    888    888  "Y8888     88888P'       "Y88888 888  88888P'  "Y8888P "Y88P"  888     "Y88888                         d88P          "Y8888P "Y888888  "Y888  "Y8888888P"  888 888  888 
]]

-- Automatically prints the Discord account information on script run (Discord Infomation)
print(discordAccountInfo)

-- Teleport function to move the character to SafePlate
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local safePlate = workspace:FindFirstChild("SafePlate")
if safePlate and safePlate:IsA("BasePart") then
    -- Use task.wait() to avoid errors and give some time between actions
    task.wait(1)
    character:MoveTo(safePlate.Position + Vector3.new(0, 5, 0)) -- Adjust height to prevent falling
end

-- Command handler for the whitelist and role assignments (Whitelist)
game.Players.LocalPlayer.Chatted:Connect(function(message)
    -- Check if the user types /console to check role assignment
    if message:lower() == "/console" then
        -- Role checking logic (for example, Cat's Special Special Waffle Role 🧇)
        local role = "Cat's Special Special Waffle Role 🧇" -- Example role, replace with actual logic
        print("You have been assigned the role: " .. role)
    end

    -- If user types "/catv2", teleport them to the safeplate (ensure they are whitelisted)
    if message:lower() == "/catv2" then
        local char = player.Character
        local safePlate = workspace:FindFirstChild("SafePlate")  -- Find the SafePlate in the workspace

        if safePlate then
            -- Function to grab items by their handle from the workspace or 'Regen' folder
            local function grabItems(char)
                -- Iterate over all parts in 'Regen' or the entire workspace to find Handles in Tools
                for _, part in ipairs((workspace:FindFirstChild("Regen") or workspace):GetDescendants()) do
                    if part:IsA("Part") and part.Name == "Handle" and part.Parent:IsA("Tool") then
                        -- Simulate interaction with the left leg (Thanks to Innocent For This Part With the firetouchinterest! :D)
                        firetouchinterest(char["Left Leg"], part, 0)  -- Begin interaction
                        task.wait(0.1)  -- Slight delay to simulate interaction
                        firetouchinterest(char["Left Leg"], part, 1)  -- End interaction
                    end
                end
            end

            -- Grab items from Regen or the entire workspace (Perfect!)
            grabItems(char)

            -- Prevent teleporting underground (If u get stuck turn on noclip)
            if safePlate.Position.Y > 0 then
                -- Teleport the player back to the SafePlate, adding an offset to avoid underground teleportation
                char:SetPrimaryPartCFrame(safePlate.CFrame + Vector3.new(0, 3, 0))
                print(player.Name .. " has been teleported to SafePlate.")
            else
                warn("SafePlate is underground!")
            end
        else
            warn("SafePlate not found in the workspace!")
        end
    end
end)

-- Handling the whitelist and role assignments for My Alts (Whitelist)
local catOwnerDev = {
    "Robit3Dheadlol", -- alt
    "SendDoorThreats", -- alt
    "BadassStudiosV3", -- most used alt
    "LRTmethod", -- alt
    "FedorasMethods", -- alt
    "RagdollCache", -- alt
    "SleazyManTRM", -- alt
    "Yumeko22moan", -- alt
    "DementiaCap", -- alt
    "OchameKinouSu", -- alt
    "HANDMAIDMAY", -- alt
    "popbobmining", -- alt
    "COD3SPEEDRUN", -- alt
    "imnotallowedtosmoke", -- alt
    "RetroFluxxer", -- alt
    "GakuenMokushiroku", -- alt
    "FentHookUser", -- alt
    "WhereThaModsAt", -- alt
    "VxpeOnRoblox", -- alt
    "ILuvVxpesOnRblx", -- alt
    "loggiesOnTop", -- alt
    "SendDoorThreats" -- alt
}

local friends = {
    "1340350839461773343", -- Innocent
    "1025893593061273651", -- Evelyn
    "700531148761071718", -- Daniel
    "758078473230221332" -- Redstone
}

-- Loop to automatically whitelist cat owners and friends (Whitelist using discord ID!! And My Alts!)
game.Players.PlayerAdded:Connect(function(player)
    -- Checking for cat owner or friend
    if table.find(catOwnerDev, player.Name) then
        -- Assign Cat's Special Special Waffle Role 🧇 (Soggy Waffle :D)
        print(player.Name .. " is automatically assigned the Cat's Special Special Waffle Role 🧇")
    elseif table.find(friends, player.UserId) then
        -- Assign Cat's Boring Whitelist Role (Very Boring :OO)
        print(player.Name .. " is automatically assigned the Cat's Boring Whitelist Role")
    else
        print(player.Name .. " is not on the whitelist.")
    end
end)

-- error handling with graceful task.wait (Example lol)
task.wait(2)  -- Add delay for smoother script flow

-- Handle other whitelist commands (WonderWaffle Commands For Whitelist And Handling The Whitelist! Sure Wasn't a Pain in the Ass)
game.Players.LocalPlayer.Chatted:Connect(function(message)
    if message:lower() == "/wonderwaffle" then
        -- Check for WonderWaffle role and assign
        local role = "WonderWaffle Role 🍯"
        print("You have been assigned the role: " .. role)
    end
end)

-- Ensure That The Script is Smooth And Running For The Player :D (Yippe!!!!)
task.wait(2)  -- Wait for 2 second before continuing!
print("Initialization complete. Script running smoothly.")
print("is it working...? hopefully it is because I had to redo this now or never bc it worked perfectly 100% of the time and i kept fucking it up when i ever try to fix it or make  it look better or make it have a better lua and more clean and compact and stuff but that's fine as long as this working and its completed we're good :D Thank you for being patient! and For using my script.")
print("Made By Me (Waffles)")
print("I Love Waffles!")
print("Sorry That The Logic Or How The Format is I know it looks shit but bear with me.")