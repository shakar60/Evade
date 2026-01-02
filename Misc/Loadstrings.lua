loadstring(game:HttpGet("https://raw.githubusercontent.com/shakar60/Evade/refs/heads/main/Misc/Leaderboard%20Buttons.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/shakar60/Evade/refs/heads/main/Misc/Padding%20Space%20Detector.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/shakar60/Evade/refs/heads/main/Misc/Reload%20%26%20Front%20View.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/shakar60/Evade/refs/heads/main/Misc/TimerGUI%20No%20Repeat.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/shakar60/Evade/refs/heads/main/Misc/Top%20Bar%20Buttons.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/shakar60/Evade/refs/heads/main/Misc/VIP%20Macro%20Command.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/shakar60/Evade/refs/heads/main/Misc/Zoom%20Button.lua"))()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local function waitForVisibleButton()
    while true do
        local global = PlayerGui:FindFirstChild("Global")
        if global then
            local canDisable = global:FindFirstChild("CanDisable")
            if canDisable then
                local voteActive = canDisable:FindFirstChild("VoteActive")
                if voteActive then
                    local maximizeButton = voteActive:FindFirstChild("MaximizeButton")
                    if maximizeButton and maximizeButton.Visible then
                        return maximizeButton
                    end
                end
            end
        end
        task.wait(0.5)
    end
end

local lastVoteMaps = nil
local lastVoteGamemodes = nil

game:GetService("ReplicatedStorage").Events.Player.Vote.OnClientEvent:Connect(
    function(voteMaps, voteGamemodes)
        if voteMaps and type(voteMaps) == "table" then
            lastVoteMaps = voteMaps
        end

        if voteGamemodes and type(voteGamemodes) == "table" then
            lastVoteGamemodes = voteGamemodes
            print("Captured VoteGamemodes:", table.concat(voteGamemodes, ", "))
        else
            lastVoteGamemodes = nil
        end
    end
)

local function createDuplicateRevoteButton(originalButton)
    local duplicate = originalButton:Clone()
    duplicate.Name = "FixedRevoteButtonWhyTFDidEvadeDevMessThisShitUp"
    duplicate.Parent = originalButton.Parent

    duplicate.Position = originalButton.Position

    originalButton.Position = originalButton.Position - UDim2.new(0, 0, 0, 0)

    duplicate.Text = "Revote"

    duplicate.Activated:Connect(
        function()
            if not lastVoteMaps then
                game:GetService("StarterGui"):SetCore(
                    "SendNotification",
                    {
                        Title = "VoteMaps",
                        Text = "No VoteMaps stored yet. Waiting for next 1-3 rounds.",
                        Duration = 5
                    }
                )
                return
            end

            if lastVoteGamemodes then
                firesignal(
                    game:GetService("ReplicatedStorage").Events.Player.Vote.OnClientEvent,
                    lastVoteMaps,
                    lastVoteGamemodes
                )
            else
                firesignal(game:GetService("ReplicatedStorage").Events.Player.Vote.OnClientEvent, lastVoteMaps)
            end
        end
    )

    return duplicate
end

local function monitorButtonVisibility()
    print("Monitoring for maximize button visibility...")

    while true do
        local global = PlayerGui:FindFirstChild("Global")
        if global then
            local canDisable = global:FindFirstChild("CanDisable")
            if canDisable then
                local voteActive = canDisable:FindFirstChild("VoteActive")
                if voteActive then
                    local maximizeButton = voteActive:FindFirstChild("MaximizeButton")
                    if maximizeButton then
                        if maximizeButton.Visible then
                            if not voteActive:FindFirstChild("FixShitRevoteButton") then
                                print("Maximize button is visible! Creating duplicate...")
                                createDuplicateRevoteButton(maximizeButton)
                                break
                            end
                        end
                    end
                end
            end
        end
        task.wait(0.1)
    end
end

monitorButtonVisibility()
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local events = player.PlayerScripts.Events.temporary_events

events.UseKeybind.Event:Connect(
    function(args)
        if args.Forced and args.Key == "Cola" and args.Down then
            local SoundService = game:GetService("SoundService")
            local Players = game:GetService("Players")

            local player = Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()

            local sounds = {
                "rbxassetid://6911756259",
                "rbxassetid://6911756959",
                "rbxassetid://608509471"
            }

            local function playSoundAndWait(soundId, soundName)
                local sound = Instance.new("Sound")
                sound.SoundId = soundId
                sound.Parent = character:FindFirstChild("Head") or character
                sound.Name = soundName

                print("Playing: " .. soundName)
                sound:Play()

                sound.Ended:Wait()
                print("Finished: " .. soundName)

                sound:Destroy()
            end

            local function playSequentialSounds()
                print("Starting sequential sound playback...")

                playSoundAndWait(sounds[1], "Opening_Can")
                playSoundAndWait(sounds[2], "Drinking")
                playSoundAndWait(sounds[3], "Burp_Finish")

                print("All sounds completed in sequence!")
            end

            playSequentialSounds()
        end
    end
)
