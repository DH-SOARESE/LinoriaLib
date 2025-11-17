LinoriaLib - Complete Documentation

A modern, lightweight, and optimized UI library for Roblox

Table of Contents

· Features
· Installation
· Quick Start
· Interface Elements
· Containers
· Save System & Themes
· Special Features
· Examples
· Performance

🚀 Features

· ✨ Lightweight and Optimized
· 🎨 Modern Interface
· 📱 Mobile-Friendly
· 🔧 Easy to Use
· 💾 Save System
· 🎭 Customizable Themes

📥 Installation

Quick Install (Direct Loading)

Load the library directly from GitHub. Suitable for testing and simple projects.

```lua
-- Repository base URL
local repo = 'https://raw.githubusercontent.com/DH-SOARESE/LinoriaLib/main/'

-- Load core library and addons
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
```

Advantages: Rapid setup, no file management required.
Disadvantages: Requires internet connectivity for each execution; potential delays from HTTP requests.

---

Local Install (Persistent Files)

Download and save files locally for offline access and improved performance. Recommended for production environments.

```lua
local LinoriaLib = "https://raw.githubusercontent.com/DH-SOARESE/LinoriaLib/main/"
local folderName = "Linoria Library"
local basePath = folderName
local addonsPath = basePath .. "/addons"

-- Create necessary directories
if not isfolder(basePath) then makefolder(basePath) end
if not isfolder(addonsPath) then makefolder(addonsPath) end

-- Helper function to download and save files
local function ensureFile(filePath, url)
    if not isfile(filePath) then
        local success, result = pcall(function()
            return game:HttpGet(url)
        end)
        if success and result then
            writefile(filePath, result)
            print("✓ Downloaded: " .. filePath)
        else
            warn("✗ Failed to download " .. filePath .. ": " .. tostring(result))
        end
    end
end

-- Download library files
ensureFile(basePath .. "/Library.lua", LinoriaLib .. "Library.lua")
ensureFile(addonsPath .. "/SaveManager.lua", LinoriaLib .. "addons/SaveManager.lua")
ensureFile(addonsPath .. "/ThemeManager.lua", LinoriaLib .. "addons/ThemeManager.lua")

-- Load from local files
local Library = loadfile(basePath .. "/Library.lua")()
local SaveManager = loadfile(addonsPath .. "/SaveManager.lua")()
local ThemeManager = loadfile(addonsPath .. "/ThemeManager.lua")()

-- Initialize managers
SaveManager:SetLibrary(Library)
ThemeManager:SetLibrary(Library)
```

Advantages: Offline accessibility, faster loading after initial download, persistence across sessions.
Disadvantages: Requires initial internet connection and file write permissions; more complex implementation.

🛠️ Quick Start

1. Window Creation

Configure global settings and create the primary UI window.

```lua
-- Global library configuration
Library.ShowToggleFrameInKeybinds = true
Library.ShowCustomCursor = true
Library.NotifySide = 'Left'

-- Create main window
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

2. Tab Organization

Structure content using tabs.

```lua
local Tabs = {
    Main = Window:AddTab('Main'),
    Settings = Window:AddTab('Settings')
}
```

📦 Containers

Groupboxes

Organize content into sections. Available positions: Left, Center, Right.

```lua
local LeftGroup = Tabs.Main:AddLeftGroupbox('Left Panel')  -- Optional name parameter
local RightGroup = Tabs.Main:AddRightGroupbox('Right Panel')
```

Tabboxes

Create sub-tabs for additional organization within primary tabs.

```lua
local SubTabs = Tabs.Main:AddRightTabbox()
local PrimaryTab = SubTabs:AddTab('Primary')
local SecondaryTab = SubTabs:AddTab('Secondary')
```

🔤 Interface Elements

All interface components are added to Groupboxes or DependencyBoxes. Each element returns an object for programmatic control.

Toggle

Binary switch for enabling/disabling features.

```lua
Groupbox:AddToggle('FeatureToggle', {
    Text = 'Enable Feature',
    Default = false,
    Tooltip = 'Activates or deactivates the feature',
    Risky = false,
    Disabled = false,
    DisabledTooltip = false,
    Callback = function(Value)
        print('Toggle State:', Value)
    end
})
```

Methods

```lua
Toggles.FeatureToggle:SetText('Updated Label')  -- string
Toggles.FeatureToggle:SetValue(true)            -- boolean
Toggles.FeatureToggle:SetVisible(false)         -- boolean
Toggles.FeatureToggle:OnChanged(function(value)
    print('State Changed:', value)
end)
```

Addon Integration

```lua
Groupbox:AddToggle('AdvancedToggle', { ... }):AddKeyPicker('ToggleKeybind', {
    Default = 'E',
    Mode = 'Toggle',
    Text = 'Feature Activation',
    SyncToggleState = true,
    Callback = function(Toggled)
        print('Keybind State:', Toggled)
    end
}):AddColorPicker('FeatureColor', {
    Title = 'Feature Color',
    Default = Color3.fromRGB(255, 0, 0),
    Transparency = 0.1,
    Callback = function(Color, Alpha)
        print(string.format('Color: (%d, %d, %d) Alpha: %.2f', 
            math.floor(Color.R * 255), 
            math.floor(Color.G * 255), 
            math.floor(Color.B * 255), 
            Alpha))
    end
})
```

Slider

Numerical value selector within a defined range.

```lua
Groupbox:AddSlider('BrightnessControl', {
    Text = 'Screen Brightness',
    Default = 50,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Suffix = '%',
    Disabled = false,
    Tooltip = 'Adjusts display brightness from 0% to 100%',
    Callback = function(Value)
        print('Brightness Level:', Value)
    end
})
```

Methods

```lua
Options.BrightnessControl:SetText('New Label')    -- string
Options.BrightnessControl:SetMin(0.1)             -- number
Options.BrightnessControl:SetMax(2.0)             -- number
Options.BrightnessControl:SetValue(1.2)           -- number
Options.BrightnessControl:SetPrefix('::')         -- string
Options.BrightnessControl:SetSuffix('::')         -- string
Options.BrightnessControl:SetDisabled(true)       -- boolean
Options.BrightnessControl:SetVisible(false)       -- boolean
Options.BrightnessControl:OnChanged(function(value)
    print('Value Changed:', value)
end)
```

Dropdown

Selection interface for multiple options.

```lua
Groupbox:AddDropdown('DifficultySelection', {
    Text = 'Select Difficulty',
    Values = {'Easy', 'Medium', 'Hard'},
    Default = 'Medium',
    Multi = false,
    AllowNull = false,
    Tooltip = 'Choose the challenge level',
    Callback = function(Value)
        print('Selected Difficulty:', Value)
    end
})
```

Specialized Dropdown Types

```lua
Groupbox:AddDropdown('PlayerSelection', {
    Text = 'Select Player',
    SpecialType = 'Player',
    ExcludeLocalPlayer = true,
    Multi = true,
    Tooltip = 'Select one or multiple players (excluding local player)',
    Callback = function(Values)
        print('Selected Players:', table.concat(Values, ', '))
    end
})
```

Methods

```lua
Options.DifficultySelection:SetText('New Label')           -- string
Options.DifficultySelection:AddValues({'Option1', 'Option2'}) -- table
Options.DifficultySelection:SetValue('Medium')             -- string/table
Options.DifficultySelection:SetDisabledValues({'Easy'})    -- table
Options.DifficultySelection:AddDisabledValues({'Hard'})    -- table
Options.DifficultySelection:SetVisible(true)               -- boolean
Options.DifficultySelection:SetDisabled(false)             -- boolean
Options.DifficultySelection:OnChanged(function(value)
    print('Selection Changed:', value)
end)
```

Input

Text input field for user data entry.

```lua
Groupbox:AddInput('PlayerName', {
    Text = 'Player Name',
    Default = 'Player123',
    Placeholder = 'Enter your username...',
    Callback = function(value)
        print('Username Updated:', value)
    end
})
```

Input Variants

· On Enter Submission: Configure with Finished = true for callback on enter key or focus loss
· Character Limitation: Implement with MaxLength = 6
· Read-Only Mode: Set Disabled = true

Methods

```lua
Options.PlayerName:SetValue('NewUsername')  -- string
Options.PlayerName:SetDisabled(true)        -- boolean
Options.PlayerName:SetVisible(false)        -- boolean
Options.PlayerName:OnChanged(function(value)
    print('Input Changed:', value)
end)
```

ColorPicker

Color selection interface with transparency support.

```lua
Toggle:AddColorPicker('HighlightColor', {
    Title = 'Highlight Color',
    Default = Color3.fromRGB(255, 0, 0),
    Transparency = 0.1,
    Callback = function(Color, Alpha)
        print(string.format('Selected Color: (%d, %d, %d) Alpha: %.2f', 
            math.floor(Color.R * 255), 
            math.floor(Color.G * 255), 
            math.floor(Color.B * 255), 
            Alpha))
    end
})
```

Methods

```lua
ColorPicker:SetValueRGB(Color3.fromRGB(255, 0, 0), 0.5)  -- Color3, number
ColorPicker:OnChanged(function(color, alpha)
    print('Color Changed:', color, alpha)
end)
```

KeyPicker

Keyboard key binding interface.

```lua
Toggle:AddKeyPicker('ActivationKey', {
    Default = 'E',
    Mode = 'Toggle',
    Text = 'Activation',
    Callback = function(isActive)
        print('Key State:', isActive)
    end
})
```

Methods

```lua
KeyPicker:SetValue({'E', 'Hold'})             -- table
KeyPicker:SetModePickerVisibility(true)      -- boolean
KeyPicker:OnChanged(function(newKey)
    print('Key Binding Changed:', newKey)
end)
```

Image

Image display component.

```lua
Groupbox:AddImage('ApplicationLogo', {
    Image = 'rbxassetid://1234567890',
    Height = 150,
    Color = Color3.fromRGB(255, 255, 255),
    RectOffset = Vector2.new(0, 0),
    RectSize = Vector2.new(0, 0),
    ScaleType = Enum.ScaleType.Fit,
    Transparency = 0,
    Visible = true,
    Tooltip = 'Application logo'
})
```

Image Variants

· Lucide Icons: Utilize icon names like 'alert-triangle'
· External URLs: Support for web-hosted images

Methods

```lua
Options.ApplicationLogo:SetVisible(true)                   -- boolean
Options.ApplicationLogo:SetTransparency(0.5)               -- number
Options.ApplicationLogo:SetScaleType(Enum.ScaleType.Fit)   -- Enum
Options.ApplicationLogo:SetRectSize(Vector2.new(100, 50))  -- Vector2
Options.ApplicationLogo:SetRectOffset(Vector2.new(0, 0))   -- Vector2
Options.ApplicationLogo:SetColor(Color3.fromRGB(255, 0, 0))-- Color3
Options.ApplicationLogo:SetImage('new-image-url')          -- string
Options.ApplicationLogo:SetHeight(200)                     -- number
```

Video

Video playback component.

```lua
Groupbox:AddVideo('TutorialVideo', {
    Video = 'rbxassetid://1234567890',
    Height = 200,
    Looped = true,
    Playing = true,
    Volume = 0.5,
    Visible = true
})
```

Methods

```lua
Options.TutorialVideo:SetVideo('new-video-id')  -- string
Options.TutorialVideo:SetVisible(true)          -- boolean
Options.TutorialVideo:SetPlaying(true)          -- boolean
Options.TutorialVideo:SetLooped(true)           -- boolean
Options.TutorialVideo:SetVolume(0.8)            -- number
Options.TutorialVideo:SetHeight(300)            -- number
```

DependencyBox

Conditional visibility container.

```lua
local ConditionalBox = Groupbox:AddDependencyBox()
ConditionalBox:SetupDependencies({ { Toggles.FeatureToggle, true } })

ConditionalBox:AddSlider('DependentSlider', { ... })
ConditionalBox:AddDropdown('DependentDropdown', { ... })
```

Methods

```lua
ConditionalBox:SetupDependencies({ { Toggles.FeatureToggle, false } })
```

Button

Action execution component.

```lua
Groupbox:AddButton({
    Text = 'Execute Action',
    Tooltip = 'Click to perform action',
    Func = function()
        print('Action executed!')
    end
})
```

Button Variants

· Double-Click Requirement: Configure with DoubleClick = true
· Disabled State: Set Disabled = true

Methods

```lua
Button:SetVisible(true)        -- boolean
Button:SetText('New Label')    -- string
Button:SetDisabled(true)       -- boolean
```

Labels and Dividers

Text display and visual separation components.

```lua
local StatusLabel = Groupbox:AddLabel('Status: Connected')
Groupbox:AddLabel('Multi-line Information:\nSystem operational!', true)
Groupbox:AddDivider()
Groupbox:AddDivider('Section Divider')
```

Label Methods

```lua
StatusLabel:SetText('Status: Disconnected')
```

💾 Save System & Themes

Persistent configuration storage and theme management.

```lua
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({'MenuKeybind'})

ThemeManager:SetFolder('MyApplication')
SaveManager:SetFolder('MyApplication/Configurations')

SaveManager:BuildConfigSection(Tabs.Settings)
ThemeManager:ApplyToTab(Tabs.Settings)

SaveManager:LoadAutoloadConfig()
```

✨ Special Features

Watermark

Dynamic information display with real-time updates.

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

Notifications

User notification system.

```lua
Library:Notify('Operation completed successfully!')

Library:Notify('Error encountered!', 10, 4590657391)  -- Duration, SoundID

Library:Notify({
    Title = 'System Notification',
    Description = 'Detailed notification message',
    Time = 7,
    SoundId = 6534947243
})

-- Persistent notification tied to object lifetime
local signal = Instance.new('Attachment')
Library:Notify({
    Title = 'System Monitor',
    Description = 'Notification persists until object destruction',
    Time = signal
})
```

🔍 Value Access

Programmatic value retrieval and modification.

```lua
print(Toggles.FeatureToggle.Value)
print(Options.BrightnessControl.Value)
print(Options.DifficultySelection.Value)

Toggles.FeatureToggle:SetValue(true)
Options.BrightnessControl:SetValue(50)
Options.DifficultySelection:SetValue('Hard')
```

⚙️ Menu Controls

Interface management components.

```lua
local MenuSection = Tabs.Settings:AddLeftGroupbox('Menu Controls')

MenuSection:AddToggle('KeybindDisplay', {
    Text = 'Display Keybinds Menu',
    Default = true,
    Callback = function(value)
        Library.KeybindFrame.Visible = value
    end
})

MenuSection:AddButton({
    Text = 'Unload Interface',
    Func = function()
        Library:Unload()
    end
})
```

📘 Complete Example

Comprehensive implementation example: Example.lua

🔗 Resources

· UI Library Source
· Original Project Repository

💡 Implementation Guidelines

· Organize features logically using groupboxes and tabs for optimal user experience
· Implement tooltips for all interface elements to enhance usability
· Utilize callbacks for immediate response to user interactions
· Configure automatic saving to preserve user preferences
· Implement key bindings for rapid feature access
· Conduct mobile device testing to ensure responsive design
· Employ DependencyBoxes for conditional option display
· Enhance customization through ColorPickers and KeyPickers

📈 Performance

LinoriaLib is engineered for optimal performance:

· Minimal rendering overhead
· Modular, clean codebase
· Mobile device optimization
· Rapid loading capabilities

Developed with dedication for the Roblox development community
