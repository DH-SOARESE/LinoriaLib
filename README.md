# LinoriaLib - Complete Documentation

*A modern, lightweight, and optimized UI library for Roblox*

LinoriaLib provides a sleek, user-friendly interface for creating customizable GUIs in Roblox scripts. It's designed for developers who need efficient, mobile-friendly UI elements with built-in support for themes and configuration saving.

### 🚀 Features
- ✨ Lightweight and Optimized
- 🎨 Modern Interface
- 📱 Mobile-Friendly
- 🔧 Easy to Use
- 💾 Save System
- 🎭 Customizable Themes

## 📥 Installation

Choose between quick loading for simplicity or local installation for offline use and faster performance.

### 🚀 Quick Install (Direct Loading)
This method loads the library directly from GitHub each time the script runs. Ideal for testing or simple projects.

```lua
-- Repository base URL
local repo = 'https://raw.githubusercontent.com/DH-SOARESE/LinoriaLib/main/'

-- Load core library and addons
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
```

**Pros:** Fast setup, no file management required.  
**Cons:** Requires internet every time; potential delays from HTTP requests.

---

### 💾 Local Install (Persistent Files)
This method downloads and saves files locally, allowing offline use after the initial download. Recommended for production scripts.

```lua
local LinoriaLib = "https://raw.githubusercontent.com/DH-SOARESE/LinoriaLib/main/"
local folderName = "Linoria Library"
local basePath = folderName
local addonsPath = basePath .. "/addons"

-- Create necessary folders
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

**Pros:** Offline access, faster loading after first run, persistent across sessions.  
**Cons:** Requires initial internet and file write permissions; more code upfront.

## 🛠️ Getting Started

### 1. Creating a Window
Configure global settings and create the main UI window.

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
Tabs organize content within the window.

```lua
local Tabs = {
    Main = Window:AddTab('Main'),
    Settings = Window:AddTab('Settings')
}
```

## 📦 Containers

### Groupboxes
Groupboxes divide tabs into sections. Positions: Left, Center, Right.

```lua
local Left = Tabs.Main:AddLeftGroupbox('Left')  -- Optional name
local Right = Tabs.Main:AddRightGroupbox('Right')
```

### 🎨 Tabboxes
Sub-tabs for further organization within a tab.

```lua
local SubTabs = Tabs.Main:AddRightTabbox()
local Tab1 = SubTabs:AddTab('Sub tab1')
local Tab2 = SubTabs:AddTab('Sub tab2')
```

## 🔤 Interface Elements

All elements are added to Groupboxes or DependencyBoxes. Each returns an object (e.g., `Toggles.MyToggle` or `Options.MySlider`) for later control.

### Toggle
A simple on/off switch.

```lua
Groupbox:AddToggle('BasicToggle', {
    Text = 'Enable Feature',
    Default = false,
    Tooltip = 'Toggles the feature on or off',
    Risky = false,
    Disabled = false,
    DisabledTooltip = false,
    Callback = function(Value)
        print('Toggle:', Value)
    end
})
```

#### Methods
```lua
Toggles.BasicToggle:SetText('New Text')  -- string
Toggles.BasicToggle:SetValue(true)       -- boolean
Toggles.BasicToggle:SetVisible(false)    -- boolean
Toggles.BasicToggle:OnChanged(function(value)
    print('Changed:', value)
end)
```

#### Attaching Addons (KeyPicker/ColorPicker)
```lua
Groupbox:AddToggle('ExampleToggle', { ... }):AddKeyPicker('FeatureKeyPicker', {
    Default = 'E',
    Mode = 'Toggle',
    Text = 'Feature',
    SyncToggleState = true,
    Callback = function(Toggled)
        print('KeyPicker Toggle:', Toggled)
    end
}):AddColorPicker('FeatureColor', {
    Title = 'Feature Color',
    Default = Color3.fromRGB(255, 0, 0),
    Transparency = 0.1,
    Callback = function(Color, Alpha)
        print(string.format('Color: (%d, %d, %d) Alpha: %.2f', math.floor(Color.R * 255), math.floor(Color.G * 255), math.floor(Color.B * 255), Alpha))
    end
})
```

#### Properties
| Property       | Type     | Default              | Description |
|----------------|----------|----------------------|-------------|
| Text          | string   | Required             | Label text. |
| Value         | boolean  | false                | Current state. |
| Visible       | boolean  | true                 | Visibility. |
| Disabled      | boolean  | false                | Interactability. |
| Risky         | boolean  | false                | Marks as risky (red text). |
| Callback      | function | nil                  | On change callback. |
| Tooltip       | string   | nil                  | Hover text. |
| DisabledTooltip | string | nil                | Disabled hover text. |

### Slider
For selecting values in a range.

```lua
Groupbox:AddSlider('ScreenBrightness', {
    Text = 'Screen Brightness',
    Default = 50,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Suffix = '%',
    Disabled = false,
    Tooltip = 'Adjusts screen brightness from 0% to 100%.',
    Callback = function(Value)
        print('Brightness:', Value)
    end
})
```

#### Methods
```lua
Options.ScreenBrightness:SetText('New Text')  -- string
Options.ScreenBrightness:SetMin(0.1)          -- number
Options.ScreenBrightness:SetMax(2.0)          -- number
Options.ScreenBrightness:SetValue(1.2)        -- number
Options.ScreenBrightness:SetPrefix('::')      -- string
Options.ScreenBrightness:SetSuffix('::')      -- string
Options.ScreenBrightness:SetDisabled(true)    -- boolean
Options.ScreenBrightness:SetVisible(false)    -- boolean
Options.ScreenBrightness:OnChanged(function(value)
    print('Changed:', value)
end)
```

#### Properties
| Property   | Type    | Default   | Description |
|------------|---------|-----------|-------------|
| Text      | string  | ""        | Label. |
| Value     | number  | Default   | Current value. |
| Min       | number  | Required  | Minimum. |
| Max       | number  | Required  | Maximum. |
| Rounding  | number  | Required  | Decimal places. |
| Visible   | boolean | true      | Visibility. |
| Disabled  | boolean | false     | Interactability. |
| Prefix    | string  | ""        | Before value. |
| Suffix    | string  | ""        | After value. |
| Compact   | boolean | false     | Compact display. |
| HideMax   | boolean | false     | Hide max value. |
| Tooltip   | string  | nil       | Hover text. |
| DisabledTooltip | string | nil | Disabled hover. |
| Callback  | function| nil       | On change. |

### Dropdown
For selecting from a list.

```lua
Groupbox:AddDropdown('GameMode', {
    Text = 'Select Game Mode',
    Values = {'Easy', 'Medium', 'Hard'},
    Default = 'Medium',
    Multi = false,
    AllowNull = false,
    Tooltip = 'Choose the difficulty level.',
    Callback = function(Value)
        print('Selected mode:', Value)
    end
})
```

#### Special Types (Player/Team)
```lua
Groupbox:AddDropdown('PlayerSelect', {
    Text = 'Select Player',
    SpecialType = 'Player',
    ExcludeLocalPlayer = true,
    Multi = true,
    Tooltip = 'Select one or more players (excludes self).',
    Callback = function(Values)
        print('Selected players:', table.concat(Values, ', '))
    end
})
```

#### Methods
```lua
Options.GameMode:SetText('New Text')               -- string
Options.GameMode:AddValues({'Option1', 'Option2'}) -- table
Options.GameMode:SetValue('Medium')                -- string/table
Options.GameMode:SetDisabledValues({'Easy'})       -- table
Options.GameMode:AddDisabledValues({'Hard'})       -- table
Options.GameMode:SetVisible(true)                  -- boolean
Options.GameMode:SetDisabled(false)                -- boolean
Options.GameMode:OnChanged(function(value)
    print('Changed:', value)
end)
```

#### Properties
| Property              | Type    | Default   | Description |
|-----------------------|---------|-----------|-------------|
| Text                  | string  | ""        | Label. |
| Values                | table   | nil       | Options list. |
| Default               | varies  | nil       | Initial selection. |
| Multi                 | boolean | false     | Multi-select. |
| DictMulti             | boolean | false     | Dictionary multi-select. |
| SpecialType           | string  | nil       | 'Player' or 'Team'. |
| ExcludeLocalPlayer    | boolean | false     | Exclude self (for Player). |
| ReturnInstanceInstead | boolean | false     | Return instances. |
| Searchable            | boolean | false     | Search feature. |
| Disabled              | boolean | false     | Interactability. |
| AllowNull             | boolean | false     | Allow no selection. |
| DisabledValues        | table   | {}        | Disabled options. |
| Tooltip               | string  | nil       | Hover text. |
| DisabledTooltip       | string  | nil       | Disabled hover. |
| MaxVisibleDropdownItems | number| 8       | Max visible items. |
| Visible               | boolean | true      | Visibility. |
| Callback              | function| nil       | On change. |

### ⌨️ Input
For text entry.

```lua
Groupbox:AddInput('UsernameInput', {
    Text = 'Player Name',
    Default = 'Player123',
    Placeholder = 'Enter your username...',
    Callback = function(value)
        print('Name updated to:', value)
    end
})
```

#### Variants
- **On Enter:** Set `Finished = true` to callback only on enter/lost focus.
- **Character Limit:** Use `MaxLength = 6`.
- **Read-Only:** Set `Disabled = true`.

#### Methods
```lua
Options.UsernameInput:SetValue('NewValue')  -- string
Options.UsernameInput:SetDisabled(true)     -- boolean
Options.UsernameInput:SetVisible(false)     -- boolean
Options.UsernameInput:OnChanged(function(v)
    print('Changed:', v)
end)
```

#### Properties
| Property         | Type    | Default   | Description |
|------------------|---------|-----------|-------------|
| Text             | string  | Required  | Label. |
| Value            | string  | ""        | Current text. |
| Numeric          | boolean | false     | Numbers only. |
| Finished         | boolean | false     | Callback on finish. |
| Visible          | boolean | true      | Visibility. |
| Disabled         | boolean | false     | Interactability. |
| AllowEmpty       | boolean | true      | Allow empty. |
| EmptyReset       | string  | '---'     | Reset value if empty. |
| Placeholder      | string  | ""        | Placeholder text. |
| ClearTextOnFocus | boolean | true      | Clear on focus. |
| MaxLength        | number  | nil       | Char limit. |
| Tooltip          | string  | nil       | Hover text. |
| DisabledTooltip  | string  | nil       | Disabled hover. |
| Callback         | function| nil       | On change. |

### 🎨 ColorPicker
For color selection.

```lua
Toggle:AddColorPicker('ColorPicker', {
    Title = 'Highlight Color',
    Default = Color3.fromRGB(255, 0, 0),
    Transparency = 0.1,
    Callback = function(Color, Alpha)
        print(string.format('Color: (%d, %d, %d) Alpha: %.2f', math.floor(Color.R * 255), math.floor(Color.G * 255), math.floor(Color.B * 255), Alpha))
    end
})
```

#### Methods
```lua
ColorPicker:SetValueRGB(Color3.fromRGB(255, 0, 0), 0.5)  -- Color3, number
ColorPicker:OnChanged(function(color, alpha)
    print('Changed:', color, alpha)
end)
```

#### Properties
| Property     | Type     | Default   | Description |
|--------------|----------|-----------|-------------|
| Title        | string   | Required  | Label. |
| Value        | Color3   | Default   | Current color. |
| Transparency | number   | nil       | Alpha (0-1). |
| Visible      | boolean  | true      | Visibility. |
| Disabled     | boolean  | false     | Interactability. |
| Tooltip      | string   | nil       | Hover text. |
| DisabledTooltip | string | nil    | Disabled hover. |
| Callback     | function | nil       | On change. |

### 🔑 KeyPicker
For binding keys.

```lua
Toggle:AddKeyPicker('KeyPicker', {
    Default = 'E',
    Mode = 'Toggle',
    Text = 'Enable',
    Callback = function(isActive)
        print('Active:', isActive)
    end
})
```

#### Methods
```lua
KeyPicker:SetValue({'E', 'Hold'})             -- table
KeyPicker:SetModePickerVisibility(true)      -- boolean
KeyPicker:OnChanged(function(newKey)
    print('Changed:', newKey)
end)
```

#### Properties
| Property          | Type      | Default                  | Description |
|-------------------|-----------|--------------------------|-------------|
| Default           | string/nil| Required                 | Initial key. |
| Text              | string    | ""                       | Display text. |
| Mode              | string    | "Toggle"                 | Mode type. |
| Modes             | table     | {"Always","Toggle","Hold","Press"} | Available modes. |
| Callback          | function  | nil                      | On state change. |
| ChangedCallback   | function  | nil                      | On key change. |
| SyncToggleState   | boolean   | false                    | Sync with parent toggle. |
| NoUI              | boolean   | false                    | No visual UI. |
| InMenu            | boolean   | true                     | Show in keybind menu. |

### 🖼️ Image
For displaying images.

```lua
Groupbox:AddImage('MainLogo', {
    Image = 'rbxassetid://1234567890',
    Height = 150,
    Color = Color3.fromRGB(255, 255, 255),
    RectOffset = Vector2.new(0, 0),
    RectSize = Vector2.new(0, 0),
    ScaleType = Enum.ScaleType.Fit,
    Transparency = 0,
    Visible = true,
    Tooltip = 'Main system logo.'
})
```

#### Variants
- **Lucide Icon:** Use icon name like 'alert-triangle'.
- **URL:** Use external URL.

#### Methods
```lua
Options.MainLogo:SetVisible(true)                   -- boolean
Options.MainLogo:SetTransparency(0.5)               -- number
Options.MainLogo:SetScaleType(Enum.ScaleType.Fit)   -- Enum
Options.MainLogo:SetRectSize(Vector2.new(100, 50))  -- Vector2
Options.MainLogo:SetRectOffset(Vector2.new(0, 0))   -- Vector2
Options.MainLogo:SetColor(Color3.fromRGB(255, 0, 0))-- Color3
Options.MainLogo:SetImage('new-url')                -- string
Options.MainLogo:SetHeight(200)                     -- number
```

#### Properties
| Property     | Type             | Default                  | Description |
|--------------|------------------|--------------------------|-------------|
| Image        | string           | Required                 | Asset/ID/URL. |
| Height       | number           | nil                      | Height. |
| Color        | Color3           | White                    | Tint. |
| RectOffset   | Vector2          | (0,0)                    | Slice offset. |
| RectSize     | Vector2          | (0,0)                    | Slice size. |
| ScaleType    | Enum.ScaleType   | Stretch                  | Scaling mode. |
| Transparency | number           | 0                        | Alpha (0-1). |
| Visible      | boolean          | true                     | Visibility. |
| Tooltip      | string           | nil                      | Hover text. |

### 🎥 Video
For playing videos.

```lua
Groupbox:AddVideo('MyVideo', {
    Video = 'rbxassetid://1234567890',
    Height = 200,
    Looped = true,
    Playing = true,
    Volume = 0.5,
    Visible = true
})
```

#### Methods
```lua
Options.MyVideo:SetVideo('new-id')     -- string
Options.MyVideo:SetVisible(true)       -- boolean
Options.MyVideo:SetPlaying(true)       -- boolean
Options.MyVideo:SetLooped(true)        -- boolean
Options.MyVideo:SetVolume(0.8)         -- number
Options.MyVideo:SetHeight(300)         -- number
```

#### Properties
| Property | Type    | Default | Description |
|----------|---------|---------|-------------|
| Video    | string  | Required| Asset ID. |
| Height   | number  | nil     | Height. |
| Looped   | boolean | false   | Loop playback. |
| Playing  | boolean | false   | Auto-play. |
| Volume   | number  | 0       | Volume (0-1). |
| Visible  | boolean | true    | Visibility. |

### 🔗 DependencyBox
Shows/hides elements based on conditions.

```lua
local FeatureDepBox = Groupbox:AddDependencyBox()
FeatureDepBox:SetupDependencies({ { Toggles.BasicToggle, true } })

FeatureDepBox:AddSlider('Example', { ... })
FeatureDepBox:AddDropdown('Example', { ... })
```

#### Methods
```lua
FeatureDepBox:SetupDependencies({ { Toggles.BasicToggle, false } })
```

#### Properties
| Property     | Type   | Default | Description |
|--------------|--------|---------|-------------|
| Dependencies| table  | {}      | Condition list. |
| Visible      | boolean| true    | Base visibility. |

### 🛎️ Button
For actions.

```lua
Groupbox:AddButton({
    Text = 'Execute Action',
    Tooltip = 'Click to execute',
    Func = function()
        print('Button pressed!')
    end
})
```

#### Variants
- **Double-Click:** Set `DoubleClick = true`.
- **Disabled:** Set `Disabled = true`.

#### Methods
```lua
Button:SetVisible(true)    -- boolean
Button:SetText('New Text') -- string
Button:SetDisabled(true)   -- boolean
```

#### Properties
| Property        | Type     | Default   | Description |
|-----------------|----------|-----------|-------------|
| Text            | string   | Required  | Label. |
| Tooltip         | string   | nil       | Hover text. |
| Func            | function | Required  | On click. |
| DoubleClick     | boolean  | false     | Require double-click. |
| Disabled        | boolean  | false     | Interactability. |
| DisabledTooltip | string   | nil       | Disabled hover. |
| Visible         | boolean  | true      | Visibility. |

### 📝 Labels and Dividers
For text and separation.

```lua
local Label = Groupbox:AddLabel('Status: Connected')
Groupbox:AddLabel('Multi-line:\nEverything working!', true)
Groupbox:AddDivider()
Groupbox:AddDivider('Divider with label')
```

#### Label Methods
```lua
Label:SetText('New Status')
```

#### Label Properties
| Property  | Type    | Default | Description |
|-----------|---------|---------|-------------|
| Text      | string  | Required| Text (\n for lines). |
| Multiline | boolean | false   | Wrap text. |
| Visible   | boolean | true    | Visibility. |
| Tooltip   | string  | nil     | Hover text. |

#### Divider Properties
| Property | Type   | Default | Description |
|----------|--------|---------|-------------|
| Text     | string | nil     | Label on divider. |
| Visible  | boolean| true    | Visibility. |

## 💾 Save System and Themes
Persist settings and apply themes.

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

## ✨ Special Features

### Watermark
Display dynamic info like FPS/ping.

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
Show messages.

```lua
Library:Notify('Success message!')

Library:Notify('Error detected!', 10, 4590657391)  -- Duration, SoundID

Library:Notify({
    Title = 'ExampleLib',
    Description = 'Example of Description',
    Time = 7,
    SoundId = 6534947243
})

-- Persistent until object destroyed
local signal = Instance.new('Attachment')
Library:Notify({
    Title = 'Monitor',
    Description = 'To last as long as the object exists.',
    Time = signal
})
```

## 🔍 Accessing Values
Retrieve or set values dynamically.

```lua
print(Toggles.BasicToggle.Value)
print(Options.Speed.Value)
print(Options.GameMode.Value)

Toggles.BasicToggle:SetValue(true)
Options.Speed:SetValue(50)
Options.GameMode:SetValue('Fast')
```

## ⚙️ Menu Controls
Add controls for the UI itself.

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

## 📘 Complete Example
See a full script with all features: [Example.lua](https://github.com/DH-SOARESE/LinoriaLib/blob/main/Example.lua)

## 🔗 Resources
- [UI Library Code](https://github.com/DH-SOARESE/LinoriaLib/blob/main/Library.lua)
- [Original Project](https://github.com/mstudio45/LinoriaLib)

## 💡 Playbook Tips
- Group features logically in groupboxes/tabs for better UX.
- Add tooltips to every element for clarity.
- Use callbacks to handle changes immediately.
- Configure saving to load user prefs automatically.
- Bind keys for quick toggles.
- Test on mobile to ensure responsiveness.
- Use DependencyBoxes for conditional options.
- Customize with ColorPickers/KeyPickers.

## 📈 Performance
LinoriaLib is built for efficiency:
- Minimal rendering overhead.
- Clean, modular code.
- Optimized for mobile devices.
- Quick load times.

*Developed with ❤️ for the Roblox community*
