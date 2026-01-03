local WindUI
local Local = {}

do
    local ok, result = pcall(function()
        return require("./src/Init")
    end)
    
    if ok then
        WindUI = result
    else 
        WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
    end
end

Local.GameInfo = loadstring(game:HttpGet("https://raw.githubusercontent.com/TheRealXORA/Roblox/refs/heads/Main/Scripts%20/Utilities%20/Fetch%20Game%20Information.luau", true))()
Local.Window = WindUI:CreateWindow({
    Title = "Evade",
    Icon = "star",
    Author = "by sh4kar60",
    Folder = "Evade Script",
    Size = UDim2.fromOffset(595, 485),
    HidePanelBackground = false,
    SideBarWidth = 200,
    IgnoreAlerts = true,
    Transparent = true,
    HideSearchbar = false,
    Topbar = {Height = 44,ButtonsType = "Default"},
    User = {Enabled = true,},
    OpenButton = {
        Title = "Evade",
        IconColor = Color3.fromRGB(255,255,255),
        CornerRadius = UDim.new(0,18),
        Enabled = true,
        Draggable = true,
        StrokeThickness = 0,
        Color = ColorSequence.new(
            Color3.fromRGB(150,0,0), 
            Color3.fromRGB(0,0,0)
        )
    }
})

Local.Sections = {
    Main = Local.Window:Section({ Title = "Main", Opened = true, Icon = "bolt"}),
    Misc = Local.Window:Section({ Title = "Miscellaneous", Opened = true, Icon = "diamond"}),
    Settings = Local.Window:Section({ Title = "Settings", Opened = true, Icon = "settings"})
}

Local.Tabs = {
    Automations = Local.Sections.Main:Tab({
        Title = "Automations",
        Icon = "repeat",
        IconColor = Color3.fromRGB(255,255,255),
        Locked = not (Local.GameInfo.Name:find("Evade") and Local.GameInfo.Creator.Name == "Hexagon Development Community")
    }),
    Visual = Local.Sections.Main:Tab({
        Title = "Visual",
        Icon = "eye",
        IconColor = Color3.fromRGB(255,255,255),
        Locked = not (Local.GameInfo.Name:find("Evade") and Local.GameInfo.Creator.Name == "Hexagon Development Community")
    }),
    Player = Local.Sections.Main:Tab({
        Title = "Player", Icon = "user", 
        IconColor = Color3.fromRGB(255,255,255),
        Locked = not (Local.GameInfo.Name:find("Evade") and Local.GameInfo.Creator.Name == "Hexagon Development Community")
    }),
    Miscellaneous = Local.Sections.Misc:Tab({ Title = "Miscellaneous", Icon = "notepad-text", IconColor = Color3.fromRGB(255,255,255)}),
    Overlay = Local.Sections.Misc:Tab({
        Title = "Overlay", Icon = "blend", 
        IconColor = Color3.fromRGB(255,255,255),
        Locked = not (Local.GameInfo.Name:find("Evade") and Local.GameInfo.Creator.Name == "Hexagon Development Community")
    }),
    LagSwitch = Local.Sections.Misc:Tab({ Title = "Lag Switch", Icon = "wifi-cog", IconColor = Color3.fromRGB(255,255,255)}),
    Settings = Local.Sections.Settings:Tab({ Title = "Configuration", Icon = "folder", IconColor = Color3.fromRGB(255,255,255)}),
    Discord = Local.Sections.Settings:Tab({ Title = "Discord", Icon = "layout-panel-left", IconColor = Color3.fromRGB(255,255,255)})
}

if Local.GameInfo.Name:find("Evade") and Local.GameInfo.Creator.Name == "Hexagon Development Community" then 
    Local.Tabs.Automations:Select()
else
    Local.Tabs.LagSwitch:Select()
end
