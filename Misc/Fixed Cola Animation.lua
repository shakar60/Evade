local Event = game:GetService("Players").LocalPlayer.PlayerScripts.Events.temporary_events.UseKeybind

local mt = getrawmetatable(Event)
local oldNamecall = mt.__namecall

setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    if (method == "Fire" or method == "FireServer") and self == Event then
        if args[1] and args[1].Key and args[1].Key == "Cola" then
            game:GetService("ReplicatedStorage").Events.Character.ToolAction:FireServer(0,19)
            return wait()
        end
    end
    
    return oldNamecall(self, ...)
end)
setreadonly(mt, true)
