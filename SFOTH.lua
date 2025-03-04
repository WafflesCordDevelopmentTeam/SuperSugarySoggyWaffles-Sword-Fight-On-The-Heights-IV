-- Roblox Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ChatService = game:GetService("Chat")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterPack = game:GetService("StarterPack")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- Local player setup
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local backpack = player.Backpack
local humanoid = char:WaitForChild("Humanoid")

-- Helper Functions
local function sendMessage(msg, chatColor)
    chatColor = chatColor or Enum.ChatColor.Blue
    -- Send a message in the chat from the local player's head
    ChatService:Chat(char.Head, msg, chatColor)
end

local function dropTool(tool)
    -- Drop a specific tool from the character into the workspace
    if tool:IsA("Tool") then
        tool.Parent = Workspace
        tool.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5)  -- Drops the tool slightly in front
        sendMessage("Dropped tool: " .. tool.Name)
    end
end

local function grab()
    -- Grab any tool from the workspace that has the name "Handle"
    for _, part in ipairs(Workspace:GetDescendants()) do
        if part:IsA("Part") and part.Name == "Handle" and part.Parent:IsA("Tool") then
            part.Parent.Parent = backpack  -- Moves tool to the backpack
            sendMessage("Grabbed tool: " .. part.Parent.Name)
            return  -- Continue to the next iteration of the loop, skip the rest if we grabbed a tool
        end
    end
end

local function resetTools()
    -- Resets tools by clearing them from the character and backpack
    for _, tool in ipairs(char:GetChildren()) do
        if tool:IsA("Tool") then
            tool.Parent = nil  -- Removes tool from the character
        end
    end
    for _, tool in ipairs(backpack:GetChildren()) do
        if tool:IsA("Tool") then
            tool.Parent = nil  -- Removes tool from the backpack
        end
    end
    sendMessage("All tools have been reset.")
end

local function equipAllTools()
    -- Equip all tools from the backpack to the character
    for _, tool in ipairs(backpack:GetChildren()) do
        if tool:IsA("Tool") then
            tool.Parent = char  -- Moves tool to character
            sendMessage("Equipped tool: " .. tool.Name)
        end
    end
end

local function dropAllTools()
    -- Drop all tools in the character's backpack and on the character at once
    for _, tool in ipairs(backpack:GetChildren()) do
        if tool:IsA("Tool") then
            dropTool(tool)
        end
    end
    -- Drop any tools equipped on the character as well
    for _, tool in ipairs(char:GetChildren()) do
        if tool:IsA("Tool") then
            dropTool(tool)
        end
    end
end

local function teleportTo(locationName)
    -- Teleports the player to a specific location in the workspace
    local target = Workspace:FindFirstChild(locationName)
    if target then
        char:SetPrimaryPartCFrame(target.CFrame)
        sendMessage("Teleported to " .. locationName)
    else
        sendMessage("Location " .. locationName .. " not found.", Enum.ChatColor.Red)
    end
end

local function regenPickups()
    -- Regenerate all tools/pickups in the workspace and log them
    for _, part in ipairs(Workspace.Regen:GetChildren()) do
        sendMessage("Regen tool: " .. part.Name)
    end
    for _, part in ipairs(Workspace.Pickups:GetChildren()) do
        sendMessage("Pickup: " .. part.Name)
    end
end

local function killAll()
    -- Kill all players in the game by destroying their humanoids
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Character and p.Character:FindFirstChild("Humanoid") then
            p.Character.Humanoid.Health = 0  -- Set humanoid health to 0, killing the player
            sendMessage("Killed player: " .. p.Name)
        end
    end
end

-- Null Platform: Teleports player to a safe spot with a new platform
local nullPlatform
local function createNullPlatform()
    if not nullPlatform then
        nullPlatform = Instance.new("Part")
        nullPlatform.Size = Vector3.new(500, 1, 500)
        nullPlatform.Position = char.HumanoidRootPart.Position - Vector3.new(0, 5, 0)
        nullPlatform.Anchored = true
        nullPlatform.CanCollide = true
        nullPlatform.Transparency = 0.5
        nullPlatform.Color = Color3.fromRGB(255, 255, 255)
        nullPlatform.Parent = Workspace
        char:SetPrimaryPartCFrame(nullPlatform.CFrame + Vector3.new(0, 5, 0))  -- Teleports the player onto the platform
        sendMessage("Created and teleported to Null Platform.")
    end
end

local function removeNullPlatform()
    -- Removes the null platform if it exists
    if nullPlatform then
        nullPlatform:Destroy()
        nullPlatform = nil
        sendMessage("Null Platform removed.")
    end
end

-- Command Listener (processes user chat input)
game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.OnMessageDoneFiltering.OnClientEvent:Connect(function(message, sender)
    if sender == player then  -- Ensure it's the local player sending the command
        -- Command parsing
        local cmd = message:sub(1, 1) == "." and message:sub(2):lower() or ""

        -- Command checks
        if cmd == "grab" then
            grab()
        elseif cmd == "reset" then
            resetTools()
        elseif cmd == "equip" then
            equipAllTools()
        elseif cmd == "drop" then
            dropAllTools()
        elseif cmd == "stp" then
            teleportTo("SafePlate")
        elseif cmd == "death" then
            teleportTo("DeathPlates")
        elseif cmd == "regenpickups" then
            regenPickups()
        elseif cmd == "killall" then
            killAll()
        elseif cmd == "null" then
            createNullPlatform()
        elseif cmd == "-unnull" then
            removeNullPlatform()
        else
            sendMessage("Unknown command: " .. cmd, Enum.ChatColor.Red)
        end
    else
        sendMessage("You do not have permission to execute commands.", Enum.ChatColor.Red)
    end
end)

-- Adding command listeners for further command handling and checks
player.Chatted:Connect(function(msg)
    local cmd = msg:lower():sub(1, 1) == "." and msg:sub(2):lower() or ""

    -- Use if-then to determine command execution and check if it's the local player
    if sender == player then
        if cmd == "grab" then
            grab()
        elseif cmd == "reset" then
            resetTools()
        elseif cmd == "equip" then
            equipAllTools()
        elseif cmd == "drop" then
            dropAllTools()
        elseif cmd == "stp" then
            teleportTo("SafePlate")
        elseif cmd == "death" then
            teleportTo("DeathPlates")
        elseif cmd == "regenpickups" then
            regenPickups()
        elseif cmd == "killall" then
            killAll()
        elseif cmd == "null" then
            createNullPlatform()
        elseif cmd == "-unnull" then
            removeNullPlatform()
        else
            sendMessage("Unknown command: " .. cmd, Enum.ChatColor.Red)
        end
    else
        sendMessage("You cannot execute this command.", Enum.ChatColor.Red)
    end
end)
