# LinoriaLib - Complete Documentation
*A modern, lightweight, and optimized UI library for Roblox*

### 🚀 Features
- ✨ Lightweight and Optimized
- 🎨 Modern Interface
- 📱 Mobile-Friendly
- 🔧 Easy to Use
- 💾 Save System
- 🎭 Customizable Themes

### 📦 Installation
```lua
-- Automatic library loading
local repo = "https://raw.githubusercontent.com/DH-SOARESE/LinoriaLib/main/"

local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()
```

### 1. Creating a Window
```lua
-- Global library settings
Library.ShowToggleFrameInKeybinds = true
Library.ShowCustomCursor = true
Library.NotifySide = 'Left'

-- Creating the main window
local Window = Library:CreateWindow({
    Title = 'LinoriaLib',
    Center = true,
    AutoShow = true,
    Resizable = true,
    ShowCustomCursor = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})
```

### 2. Creating Tabs
```lua
local Tabs = {
    Main = Window:AddTab('Main'),
    Settings = Window:AddTab('Settings')
}
```

## 🎛️ Available Components

### Groupboxes
```lua
local Left  = Tabs.Main:AddLeftGroupbox('Left')
local Right = Tabs.Main:AddRightGroupbox('Right')
```

### 🎨 Tabboxes
```lua
local SubTabs = Tabs.Main:AddRightTabbox()
local Tab1 = SubTabs:AddTab('Sub tab1')
local Tab2 = SubTabs:AddTab('Sub tab2')
```

## 📋 Interface Elements

### Toggle
```lua
local MyToggle = Groupbox:AddToggle("ShowESP", {
    Text = "Enable ESP",
    Default = false,
    Tooltip = "Toggles the ESP system",
    Risky = false,
    Disabled = false,
    DisabledTooltip = false,
    Callback = function(Value)
        print("Toggle:", Value)
    end
})

MyToggle:SetValue(true)
MyToggle:OnChanged(function(value)
    print("State changed:", value)
end)
```

#### Toggle with KeyPicker and ColorPicker
```lua
local ToggleExample = Groupbox:AddToggle("ExampleToggle", {
    Text = "Enable ESP",
    Default = false,
    Callback = function(Value)
        print("ESP:", Value and "Enabled" or "Disabled")
    end
})

Groupbox:AddKeyPicker("ESPKeyPicker", {
    Default = "E",
    Mode = "Toggle",
    Text = "ESP",
    SyncToggleState = true,
    Callback = function(Toggled)
        print("ESP KeyPicker Toggle:", Toggled)
    end
})

Groupbox:AddColorPicker("ESPColor", {
    Title = "ESP Color",
    Default = Color3.fromRGB(255, 0, 0),
    Transparency = 0.1,
    Callback = function(Color, Alpha)
        local r = math.floor(Color.R * 255)
        local g = math.floor(Color.G * 255)
        local b = math.floor(Color.B * 255)
        print(string.format("Color: (%d, %d, %d)  Alpha: %.2f", r, g, b, Alpha))
    end
})
```

### 🎚️ Slider
```lua
local BrightnessSlider = Groupbox:AddSlider("ScreenBrightness", {
    Text = "Screen Brightness",
    Default = 50,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Suffix = "%",
    Disabled = false,
    Tooltip = "Adjusts screen brightness from 0% to 100%.",
    Callback = function(Value)
        print("Brightness:", Value)
    end
})

local VolumeSlider = Groupbox:AddSlider("GeneralVolume", {
    Text = "Volume",
    Default = 0.5,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Compact = true,
    Prefix = "::",
    Suffix = "::",
    Tooltip = "Adjusts general volume (0 to 1).",
    Callback = function(Value)
        print("Volume:", Value)
    end
})
```

#### Slider Controls
```lua
VolumeSlider:SetDisabled(false)
VolumeSlider:SetMin(0.1)
VolumeSlider:SetMax(2.0)
VolumeSlider:SetValue(1.2)
```

### ⌨️ Dropdown
#### Basic Dropdown
```lua
local MyDropdown = Groupbox:AddDropdown("SelectItem", {
    Text = "Test Item",
    Values = {"Sword", "Shield", "Potion"},
    Default = "Sword",
    Tooltip = "Select an item from the list.",
    Callback = function(Value)
        print("Selected:", Value)
    end
})
```

#### Multi-Select Dropdown
```lua
local MultiSelect = Groupbox:AddDropdown("MultiItem", {
    Text = "Active Items",
    Values = {"ESP", "Aimbot", "TriggerBot"},
    Multi = true,
    Disabled = false,
    DisabledTooltip = false,
    Default = {"ESP"},
    Tooltip = "Select multiple features.",
    Callback = function(Values)
        print("Selected:", Values)
        for item, enabled in pairs(Values) do
            print(item, enabled)
        end
    end
})

local MultiSelect = Groupbox:AddDropdown("EspTracerOrigin", {
    Text = 'Example",
    Values = { "Banana", "Jery", "Bold" },
    Multi = false,
    DictMulti = true, -- New
    Default = {Banana = true, Jery = true, Bold = true}, --New
    Callback = function(value)
        print("Options:", value)
    end
})
```

#### Player Dropdown
```lua
local PlayerSelect = Groupbox:AddDropdown("Players", {
    Text = "Select Player",
    SpecialType = "Player",
    ExcludeLocalPlayer = true,
    Searchable = true,
    Tooltip = "Select a player from the list.",
    Callback = function(Player)
        print("Selected player:", Player)
    end
})
```

### ⌨️ Input
#### Basic Input
```lua
local InputExample = Groupbox:AddInput("UsernameInput", {
    Text = "Player Name",
    Default = "Player123",
    Placeholder = "Enter your username...",
    Callback = function(value)
        print("Name updated to:", value)
    end
})
```

#### Input on Enter
```lua
Groupbox:AddInput("CommandInput", {
    Text = "Execute Command",
    Placeholder = "Enter a command...",
    Finished = true,
    Callback = function(cmd)
        print("Executing command:", cmd)
    end
})
```

#### Input with Character Limit
```lua
Groupbox:AddInput("CodeInput", {
    Text = "Code",
    Placeholder = "ABC123",
    MaxLength = 6,
    AllowEmpty = false,
    EmptyReset = "ABC123",
    Callback = function(value)
        print("New code:", value)
    end
})
```

#### Disabled Input (Read-Only)
```lua
Groupbox:AddInput("LockedInput", {
    Text = "Read-Only",
    Default = "Locked",
    Disabled = true,
    Tooltip = "This field cannot be edited",
})
```

#### Input Controls
```lua
InputExample:SetValue("New text")
InputExample:SetDisabled(true)
InputExample:SetVisible(false)
InputExample:OnChanged(function(v)
    print("Value changed:", v)
end)
```

### 🎨 ColorPicker
```lua
Groupbox:AddColorPicker("ColorPicker", {
    Title = "Highlight Color",
    Default = Color3.fromRGB(255, 0, 0),
    Transparency = 0.1,
    Callback = function(Color, Alpha)
        local r = math.floor(Color.R * 255)
        local g = math.floor(Color.G * 255)
        local b = math.floor(Color.B * 255)
        print(string.format("Color: (%d, %d, %d)  Alpha: %.2f", r, g, b, Alpha))
    end
})
```

### ⌨️ KeyPicker
```lua
Groupbox:AddKeyPicker("ToggleESP", {
    Default = "E",
    Mode = "Toggle",
    Text = "Enable ESP",
    Callback = function(isActive)
        print("ESP Toggle:", isActive)
    end
})

Groupbox:AddKeyPicker("ESPKey", {
    Default = "E",
    Mode = "Toggle",
    Text = "Primary ESP",
    SyncToggleState = true,
    Callback = function(Toggled)
        print("ESP KeyPicker Toggle:", Toggled)
    end
}):AddKeyPicker("KeyESPKEY", {
    Default = "N",
    Mode = "Toggle",
    Text = "M",
    SyncToggleState = true,
    Callback = function(Toggled)
        print("ESP KEYKeyPicker Toggle:", Toggled)
    end
})
```

### 🖼️ Image
#### Roblox Asset Image
```lua
local Logo = Groupbox:AddImage("MainLogo", {
    Image = "rbxassetid://1234567890",
    Height = 150,
    Color = Color3.fromRGB(255, 255, 255),
    RectOffset = Vector2.new(0, 0),
    RectSize = Vector2.new(0, 0),
    ScaleType = Enum.ScaleType.Fit,
    Transparency = 0,
    Visible = true,
    Tooltip = "Main system logo."
})
```

#### Lucide Icon
```lua
local Icon = Groupbox:AddImage("WarningIcon", {
    Image = "alert-triangle",
    Color = Color3.fromRGB(255, 200, 0),
    Height = 60,
    ScaleType = Enum.ScaleType.Fit,
    Transparency = 0,
    Visible = true,
    Tooltip = "Yellow warning icon."
})
```

#### External Image (URL)
```lua
local Banner = Groupbox:AddImage("PromoBanner", {
    Image = "https://i.imgur.com/Example.png",
    Height = 180,
    Color = Color3.fromRGB(255, 255, 255),
    ScaleType = Enum.ScaleType.Crop,
    Transparency = 0.1,
    Visible = true,
    Tooltip = "Example promotional banner."
})
```

### 🔗 DependencyBox
```lua
local ToggleESP = Groupbox:AddToggle("ShowESP", {
    Text = "Enable ESP",
    Default = false,
    Tooltip = "Enables the ESP system.",
    Callback = function(Value)
        print("ESP:", Value)
    end
})

local ESPDepBox = Groupbox:AddDependencyBox()
ESPDepBox:SetupDependencies({ { ToggleESP, true } })

ESPDepBox:AddSlider("ESPTransparency", {
    Text = "ESP Transparency",
    Default = 0.5,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Tooltip = "Adjusts ESP opacity.",
    Callback = function(Value)
        print("Transparency:", Value)
    end
})

ESPDepBox:AddDropdown("ESPMode", {
    Text = "Highlight Mode",
    Values = { "Outline", "Fill", "Both" },
    Default = "Outline",
    Tooltip = "Sets ESP style.",
    Callback = function(Value)
        print("Mode:", Value)
    end
})
```

### 🔲 Buttons
```lua
Groupbox:AddButton({
    Text = 'Execute Action',
    Tooltip = 'Click to execute',
    Func = function()
        print('Button pressed!')
        Library:Notify('Action executed successfully!')
    end
})

Groupbox:AddButton({
    Text = 'Special Action',
    DoubleClick = true,
    Func = function()
        Library:Notify('Special action executed!', 3)
    end
})

Groupbox:AddButton({
    Text = 'Unavailable',
    Disabled = true,
    DisabledTooltip = 'This function is unavailable',
    Func = function() end
})
```

### 📝 Labels and Dividers
```lua
Groupbox:AddLabel('Status: Connected')
Groupbox:AddLabel('Multi-line:\nEverything working!', true)
Groupbox:AddDivider()
Groupbox:AddDivider("Divider with label")
```

## 💾 Save System and Themes
```lua
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({'MenuKeybind'})

ThemeManager:SetFolder('MyScript')
SaveManager:SetFolder('MyScript/Configs')

SaveManager:BuildConfigSection(Tabs.Settings)
ThemeManager:ApplyToTab(Tabs.Settings)

SaveManager:LoadAutoloadConfig()
```

## 🎪 Special Features

### Watermark
```lua
Library:SetWatermarkVisibility(true)

local function updateWatermark()
    game:GetService('RunService').Heartbeat:Connect(function()
        local fps = math.floor(1 / game:GetService('RunService').Heartbeat:Wait())
        local ping = game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue()
        Library:SetWatermark(('LinoriaLib | %d FPS | %d ms'):format(fps, ping))
    end)
end
updateWatermark()
```

### Notifications
```lua
Library:Notify('Success message!')

Library:Notify('Error detected!', 10, 4590657391)
```

## 🎯 Accessing and Manipulating Values
```lua
print(Toggles.MyToggle.Value)
print(Options.Speed.Value)
print(Options.GameMode.Value)

Toggles.MyToggle:SetValue(true)
Options.Speed:SetValue(50)
Options.GameMode:SetValue('Fast')
```

## 📱 Menu Controls
```lua
local MenuControls = Tabs.Settings:AddLeftGroupbox('Menu Controls')

MenuControls:AddToggle('ShowKeybinds', {
    Text = 'Show Keybinds Menu',
    Default = true,
    Callback = function(value)
        Library.KeybindFrame.Visible = value
    end
})

MenuControls:AddButton({
    Text = 'Unload Menu',
    Func = function()
        Library:Unload()
    end
})
```
## 🔧 Complete Example  
[Example with all Library options](https://github.com/DH-SOARESE/LinoriaLib/blob/main/Example.lua)

## 🔧 Complete Example  
[UI Library](https://github.com/DH-SOARESE/LinoriaLib/blob/main/Library.lua)



### Playbook Tips
- Organize features in groupboxes for readability.
- Use tooltips to explain each control.
- Implement callbacks for all functionalities.
- Set up the save system to persist configurations.
- Add keybinds for quick access.
- Test on mobile devices for compatibility.
- Use dependency boxes for advanced options.
- Leverage ColorPickers and KeyPickers for customization.

### Performance
LinoriaLib is optimized for maximum performance:
- Efficient Rendering
- Clean Code
- Mobile Optimized
- Fast Loading

*Developed with ❤️ for the Roblox community*

