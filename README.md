# LinoriaLib
### Modern UI Library for Roblox

A lightweight, optimized, and feature-rich interface library designed for Roblox script development.

---

## Features

- **Lightweight & Optimized** - Minimal performance impact with efficient rendering
- **Modern Interface** - Clean, contemporary design with smooth animations
- **Mobile-Friendly** - Full support for touch controls and mobile devices
- **Easy Integration** - Simple API with comprehensive documentation
- **Save System** - Persistent configuration storage across sessions
- **Theme Support** - Customizable color schemes and visual styles
- **Extensive Components** - Rich set of UI elements for any use case

---

## Quick Start

### Installation

```lua
local repo = "https://raw.githubusercontent.com/DH-SOARESE/LinoriaLib/main/"

local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()
```

### Basic Setup

```lua
-- Configure library settings
Library.ShowToggleFrameInKeybinds = true
Library.ShowCustomCursor = true
Library.NotifySide = 'Right'

-- Create main window
local Window = Library:CreateWindow({
    Title = 'LinoriaLib,
    Center = true,
    AutoShow = true,
    Resizable = true,
    ShowCustomCursor = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

-- Create tabs
local Tabs = {
    Main = Window:AddTab('Main'),
    Settings = Window:AddTab('Settings')
}

-- Create groupboxes
local LeftBox = Tabs.Main:AddLeftGroupbox('Controls')
local RightBox = Tabs.Main:AddRightGroupbox('Display')
```

---

## Core Components

### Window Configuration

```lua
local Window = Library:CreateWindow({
    Title = string,           -- Window title
    Center = boolean,         -- Center on screen
    AutoShow = boolean,       -- Show immediately
    Resizable = boolean,      -- Allow resizing
    ShowCustomCursor = boolean, -- Use custom cursor
    TabPadding = number,      -- Space between tabs
    MenuFadeTime = number     -- Fade animation duration
})
```

### Tabs & Groupboxes

```lua
-- Create tab
local Tab = Window:AddTab('Tab Name', 'IconID')

-- Create groupboxes
local Left = Tab:AddLeftGroupbox('Left Group')
local Center = Tab:AddLeftGroupbox('Center Group', 'Center')
local Right = Tab:AddRightGroupbox('Right Group')

-- Create nested tabs
local SubTabs = Tab:AddLeftTabbox()
local SubTab1 = SubTabs:AddTab('Config')
local SubTab2 = SubTabs:AddTab('Data')
```

---

## UI Elements

### Toggle

Basic toggle with optional keybind and color picker.

```lua
Groupbox:AddToggle('UniqueID', {
    Text = 'Enable Feature',
    Default = false,
    Tooltip = 'Toggle feature on/off',
    Risky = false,
    Callback = function(Value)
        print('Toggle state:', Value)
    end
})

-- With keybind
:AddKeyPicker('KeyID', {
    Default = 'E',
    Mode = 'Toggle',
    Text = 'Hotkey',
    SyncToggleState = true,
    Callback = function(Value)
        print('Keybind state:', Value)
    end
})

-- With color picker
:AddColorPicker('ColorID', {
    Title = 'Color',
    Default = Color3.fromRGB(255, 0, 0),
    Transparency = 0.5,
    Callback = function(Color, Alpha)
        print('Color:', Color, 'Alpha:', Alpha)
    end
})
```

**Toggle Properties**

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| Text | string | Required | Display label |
| Default | boolean | false | Initial state |
| Tooltip | string | nil | Hover tooltip |
| Risky | boolean | false | Red text warning |
| Disabled | boolean | false | Prevent interaction |
| Callback | function | nil | State change handler |

**Methods**
- `Toggle:SetValue(boolean)` - Set state
- `Toggle:OnChanged(function)` - Add change listener

---

### Button

Single or double-click buttons with optional disabled state.

```lua
Groupbox:AddButton({
    Text = 'Execute',
    Tooltip = 'Run action',
    DoubleClick = false,
    Disabled = false,
    Func = function()
        print('Button clicked')
    end
})

-- Chain buttons
Groupbox:AddButton({
    Text = 'Action 1',
    Func = function() end
}):AddButton({
    Text = 'Action 2',
    DoubleClick = true,
    Func = function() end
})
```

**Button Properties**

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| Text | string | Required | Button label |
| Tooltip | string | nil | Hover tooltip |
| DoubleClick | boolean | false | Require double-click |
| Disabled | boolean | false | Prevent clicking |
| DisabledTooltip | string | nil | Disabled state tooltip |
| Func | function | Required | Click handler |

---

### Slider

Numeric value slider with customizable range and formatting.

```lua
local Slider = Groupbox:AddSlider('SliderID', {
    Text = 'Speed',
    Default = 50,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Compact = false,
    Prefix = '',
    Suffix = '%',
    HideMax = false,
    Tooltip = 'Adjust speed',
    Callback = function(Value)
        print('Speed:', Value)
    end
})

-- With value labels
Groupbox:AddSlider('ThresholdID', {
    Text = 'Level',
    Default = 50,
    Min = 0,
    Max = 100,
    Rounding = 0,
    ValueText = {
        {Value = 0, Text = "Off"},
        {Value = 50, Text = "Medium"},
        {Value = 100, Text = "Max"}
    },
    Callback = function(Value) end
})
```

**Slider Properties**

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| Text | string | Required | Display label |
| Default | number | Required | Initial value |
| Min | number | Required | Minimum value |
| Max | number | Required | Maximum value |
| Rounding | number | Required | Decimal places |
| Compact | boolean | false | Compact display |
| Prefix | string | "" | Text before value |
| Suffix | string | "" | Text after value |
| HideMax | boolean | false | Hide max value |
| ValueText | table | {} | Custom labels at values |
| Tooltip | string | nil | Hover tooltip |
| Callback | function | nil | Value change handler |

**Methods**
- `Slider:SetValue(number)` - Set value
- `Slider:SetMin(number)` - Set minimum
- `Slider:SetMax(number)` - Set maximum

---

### Dropdown

Single or multi-select dropdown with search support.

```lua
-- Single select
local Dropdown = Groupbox:AddDropdown('DropdownID', {
    Text = 'Select Mode',
    Values = {'Option A', 'Option B', 'Option C'},
    Default = 1,
    Multi = false,
    Searchable = false,
    AllowNull = false,
    Tooltip = 'Choose mode',
    Callback = function(Value)
        print('Selected:', Value)
    end
})

-- Multi-select
Groupbox:AddDropdown('MultiID', {
    Text = 'Select Items',
    Values = {'Item 1', 'Item 2', 'Item 3'},
    Default = {['Item 1'] = true},
    Multi = true,
    Callback = function(Values)
        for item, enabled in pairs(Values) do
            if enabled then print(item) end
        end
    end
})

-- Player dropdown
Groupbox:AddDropdown('PlayerID', {
    Text = 'Select Player',
    SpecialType = 'Player',
    ExcludeLocalPlayer = true,
    Searchable = true,
    Callback = function(Player) end
})
```

**Dropdown Properties**

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| Text | string | Required | Display label |
| Values | table | Required | Available options |
| Default | any | nil | Initial selection |
| Multi | boolean | false | Allow multiple selection |
| Searchable | boolean | false | Enable search |
| AllowNull | boolean | false | Allow no selection |
| SpecialType | string | nil | 'Player' or 'Team' |
| ExcludeLocalPlayer | boolean | false | Exclude self (Player type) |
| DisabledValues | table | {} | Disabled options |
| Tooltip | string | nil | Hover tooltip |
| Callback | function | nil | Selection handler |

**Methods**
- `Dropdown:SetValue(value)` - Set selection
- `Dropdown:SetValues(table)` - Update options

---

### Input

Text input field with validation and constraints.

```lua
-- Basic input
local Input = Groupbox:AddInput('InputID', {
    Text = 'Username',
    Default = '',
    Placeholder = 'Enter name...',
    Tooltip = 'Your username',
    Callback = function(Value)
        print('Input:', Value)
    end
})

-- Numeric input
Groupbox:AddInput('NumberID', {
    Text = 'Amount',
    Default = '0',
    Placeholder = 'Enter number',
    Numeric = true,
    Callback = function(Value) end
})

-- Confirmed input (Enter key)
Groupbox:AddInput('CommandID', {
    Text = 'Command',
    Placeholder = 'Press Enter',
    Finished = true,
    Callback = function(Value) end
})

-- Limited input
Groupbox:AddInput('CodeID', {
    Text = 'Code',
    MaxLength = 10,
    AllowEmpty = false,
    EmptyReset = 'DEFAULT',
    Callback = function(Value) end
})
```

**Input Properties**

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| Text | string | Required | Display label |
| Default | string | "" | Initial value |
| Placeholder | string | "" | Empty state text |
| Numeric | boolean | false | Numbers only |
| Finished | boolean | false | Trigger on Enter |
| MaxLength | number | nil | Character limit |
| AllowEmpty | boolean | true | Allow empty input |
| EmptyReset | string | "---" | Reset value if empty |
| ClearTextOnFocus | boolean | true | Clear on focus |
| Disabled | boolean | false | Prevent editing |
| Tooltip | string | nil | Hover tooltip |
| Callback | function | nil | Change handler |

**Methods**
- `Input:SetValue(string)` - Set text
- `Input:OnChanged(function)` - Add listener

---

### ColorPicker

RGB color selector with optional transparency.

```lua
Groupbox:AddColorPicker('ColorID', {
    Title = 'Highlight Color',
    Default = Color3.fromRGB(255, 0, 0),
    Transparency = 0.5,
    Callback = function(Color, Alpha)
        print('RGB:', Color)
        print('Alpha:', Alpha)
    end
})
```

**ColorPicker Properties**

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| Title | string | Required | Picker label |
| Default | Color3 | Required | Initial color |
| Transparency | number | nil | Initial alpha (0-1) |
| Tooltip | string | nil | Hover tooltip |
| Callback | function | nil | Color change handler |

**Note:** Omit `Transparency` property to hide transparency slider.

---

### KeyPicker

Keyboard shortcut binding with multiple modes.

```lua
-- Standalone keybind
Groupbox:AddKeyPicker('KeyID', {
    Default = 'E',
    Mode = 'Toggle',
    Text = 'Activate',
    Callback = function(Value)
        print('Key state:', Value)
    end
})

-- With toggle sync
local Toggle = Groupbox:AddToggle('ToggleID', {
    Text = 'Feature',
    Callback = function(Value) end
})

Toggle:AddKeyPicker('KeyID', {
    Default = 'F',
    Mode = 'Toggle',
    Text = 'Hotkey',
    SyncToggleState = true,
    Callback = function(Value) end
})
```

**KeyPicker Modes**

- `Toggle` - Press to switch on/off
- `Hold` - Active while key held
- `Always` - Permanently active

**KeyPicker Properties**

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| Default | string | Required | Initial key |
| Mode | string | 'Toggle' | Key mode |
| Text | string | Required | Display label |
| SyncToggleState | boolean | false | Sync with toggle |
| NoUI | boolean | false | Hide from keybind list |
| Tooltip | string | nil | Hover tooltip |
| Callback | function | nil | State handler |

---

### Image

Display images from Roblox assets, URLs, or Lucide icons.

```lua
-- Roblox asset
Groupbox:AddImage('ImageID', {
    Image = 'rbxassetid://1234567890',
    Height = 150,
    Color = Color3.fromRGB(255, 255, 255),
    ScaleType = Enum.ScaleType.Fit,
    Transparency = 0,
    Tooltip = 'Logo'
})

-- Lucide icon
Groupbox:AddImage('IconID', {
    Image = 'alert-triangle',
    Height = 60,
    Color = Color3.fromRGB(255, 200, 0),
    ScaleType = Enum.ScaleType.Fit
})

-- External URL
Groupbox:AddImage('BannerID', {
    Image = 'https://i.imgur.com/example.png',
    Height = 180,
    ScaleType = Enum.ScaleType.Crop
})
```

**Image Properties**

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| Image | string | Required | Asset/URL/Icon name |
| Height | number | nil | Image height |
| Color | Color3 | White | Tint color |
| ScaleType | Enum | Stretch | Scale mode |
| Transparency | number | 0 | Transparency (0-1) |
| RectOffset | Vector2 | (0,0) | Slice offset |
| RectSize | Vector2 | (0,0) | Slice size |
| Tooltip | string | nil | Hover tooltip |

---

### Video

Video player with playback controls.

```lua
local Video = Groupbox:AddVideo('VideoID', {
    Video = 'rbxassetid://1234567890',
    Height = 200,
    Looped = true,
    Playing = true,
    Volume = 0.5,
    Visible = true
})
```

**Video Properties**

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| Video | string | Required | Asset ID |
| Height | number | nil | Player height |
| Looped | boolean | false | Loop playback |
| Playing | boolean | false | Auto-play |
| Volume | number | 0.5 | Volume (0-1) |
| Visible | boolean | true | Show player |

---

### Label & Divider

Static text and visual separators.

```lua
-- Simple label
Groupbox:AddLabel('Status: Active')

-- Multi-line label
Groupbox:AddLabel('Line 1\nLine 2\nLine 3', true)

-- Simple divider
Groupbox:AddDivider()

-- Named divider
Groupbox:AddDivider('Section Name')
```

**Label Properties**

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| Text | string | Required | Display text |
| Multiline | boolean | false | Allow wrapping |
| Tooltip | string | nil | Hover tooltip |

---

### DependencyBox

Container that shows/hides based on toggle states.

```lua
local MasterToggle = Groupbox:AddToggle('MasterID', {
    Text = 'Enable Advanced',
    Default = false
})

local DepBox = Groupbox:AddDependencyBox()
DepBox:SetupDependencies({{MasterToggle, true}})

DepBox:AddSlider('DepSliderID', {
    Text = 'Advanced Setting',
    Default = 50,
    Min = 0,
    Max = 100,
    Rounding = 0
})

DepBox:AddDropdown('DepDropdownID', {
    Text = 'Advanced Mode',
    Values = {'A', 'B', 'C'},
    Default = 1
})
```

**DependencyBox Properties**

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| Dependencies | table | Required | List of {Toggle, State} pairs |

---

## Advanced Features

### Viewport (3D Preview)

Display 3D objects with interactive camera.

```lua
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function CloneCharacter(character)
    local clone = Instance.new("Model")
    for _, obj in ipairs(character:GetDescendants()) do
        if obj:IsA("BasePart") then
            local part = obj:Clone()
            part.Anchored = true
            part.CanCollide = false
            part.Parent = clone
        end
    end
    return clone
end

local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local CharClone = CloneCharacter(Character)

local Viewport = Groupbox:AddViewport('ViewportID', {
    Object = CharClone,
    Clone = false,
    Interactive = true,
    AutoFocus = true,
    Height = 250,
    Visible = true
})
```

---

### Save System

Persist configurations across sessions.

```lua
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

-- Ignore theme settings in config
SaveManager:IgnoreThemeSettings()

-- Ignore specific options
SaveManager:SetIgnoreIndexes({'MenuKeybind'})

-- Set save locations
ThemeManager:SetFolder('MyScript')
SaveManager:SetFolder('MyScript/Configs')

-- Build UI in settings tab
SaveManager:BuildConfigSection(Tabs.Settings)
ThemeManager:ApplyToTab(Tabs.Settings)

-- Load autoload config
SaveManager:LoadAutoloadConfig()
```

---

### Watermark

Dynamic information display.

```lua
Library:SetWatermarkVisibility(true)

local RunService = game:GetService('RunService')
local Stats = game:GetService('Stats')

local frameCount = 0
local lastUpdate = tick()

RunService.Heartbeat:Connect(function()
    frameCount = frameCount + 1
    
    if tick() - lastUpdate >= 1 then
        local fps = frameCount
        local ping = Stats.Network.ServerStatsItem['Data Ping']:GetValue()
        
        Library:SetWatermark(string.format(
            'Script Name | %d FPS | %dms',
            fps,
            math.floor(ping)
        ))
        
        frameCount = 0
        lastUpdate = tick()
    end
end)
```

---

### Notifications

Display temporary messages to users.

```lua
-- Simple notification
Library:Notify('Operation complete!')

-- With duration
Library:Notify('Warning message', 5)

-- With duration and sound 
Library:Notify('Error detected', 10, 4590657391)
```

---

## Accessing Values

All UI elements can be accessed through global tables.

```lua
-- Access toggles
print(Toggles.MyToggle.Value)
Toggles.MyToggle:SetValue(true)

-- Access options (everything else)
print(Options.MySlider.Value)
print(Options.MyDropdown.Value)
print(Options.MyInput.Value)

Options.MySlider:SetValue(75)
Options.MyDropdown:SetValue('Option B')
Options.MyInput:SetValue('New text')

-- Add listeners
Toggles.MyToggle:OnChanged(function(value)
    print('Toggle changed:', value)
end)

Options.MySlider:OnChanged(function(value)
    print('Slider changed:', value)
end)
```

---

## Menu Controls

Standard menu management options.

```lua
local MenuGroup = Tabs.Settings:AddLeftGroupbox('Menu')

-- Toggle keybind frame
MenuGroup:AddToggle('ShowKeybinds', {
    Text = 'Show Keybind List',
    Default = true,
    Callback = function(value)
        Library.KeybindFrame.Visible = value
    end
})

-- Toggle watermark
MenuGroup:AddToggle('ShowWatermark', {
    Text = 'Show Watermark',
    Default = true,
    Callback = function(value)
        Library:SetWatermarkVisibility(value)
    end
})

-- Menu keybind
MenuGroup:AddLabel('Menu Keybind:')
MenuGroup:AddToggle('MenuToggle', {
    Text = 'Menu Toggle',
    Default = false
}):AddKeyPicker('MenuKeybind', {
    Default = 'RightShift',
    NoUI = true,
    Text = 'Menu',
    SyncToggleState = true
})

-- Unload menu
MenuGroup:AddButton({
    Text = 'Unload Interface',
    DoubleClick = true,
    Func = function()
        Library:Notify('Unloading...', 2)
        task.wait(0.5)
        Library:Unload()
    end
})

-- Unload callback
Library:OnUnload(function()
    print('Interface unloaded')
end)
```

---

## Best Practices

### Organization
- Group related features in groupboxes
- Use clear, descriptive labels
- Add tooltips to explain functionality
- Organize tabs logically by feature category

### User Experience
- Implement all callbacks for real-time feedback
- Use dependency boxes for advanced options
- Add keybinds for frequently used features
- Test on both desktop and mobile devices

### Performance
- Use local variables for frequently accessed elements
- Minimize callback complexity
- Avoid unnecessary updates
- Leverage the built-in optimization features

### Configuration
- Set up save system for persistent settings
- Use autoload for user convenience
- Ignore sensitive options from saving
- Provide config import/export UI

---

## Resources

- **Full Example**: [Example.lua](https://github.com/DH-SOARESE/LinoriaLib/blob/main/Example.lua)
- **Library Source**: [Library.lua](https://github.com/DH-SOARESE/LinoriaLib/blob/main/Library.lua)
- **Original Project**: [mstudio45/LinoriaLib](https://github.com/mstudio45/LinoriaLib)

---

## Performance

LinoriaLib is designed for optimal performance:

- **Efficient Rendering** - Smart update batching and minimal redraws
- **Clean Code** - Well-structured, maintainable codebase
- **Mobile Optimized** - Touch-friendly controls and responsive layout
- **Fast Loading** - Minimal initialization time and memory footprint

---

**Developed for the Roblox scripting community**
