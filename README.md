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

#### Toggle Properties

| Property      | Type     | Default              | Description |
|---------------|----------|----------------------|-------------|
| Text         | string   | Required             | Label displayed next to the toggle. |
| Value        | boolean  | false                | Current state of the toggle (on/off). |
| Visible      | boolean  | true                 | Whether the toggle is visible. |
| Disabled     | boolean  | false                | If true, the toggle cannot be interacted with. |
| Risky        | boolean  | false                | Marks the toggle as “risky” (red text). |
| Callback     | function | function(Value) end  | Function called whenever the toggle changes. |
| Addons       | table    | {}                   | List of attached UI elements that depend on the toggle (e.g., key pickers). |
| OriginalText | string   | —                    | Stores the initial label text. |
| Tooltip      | string   | nil                  | Tooltip text shown on hover. |
| DisabledTooltip | string | nil                | Tooltip text shown when disabled. |

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

#### Slider Properties

| Property         | Type    | Default              | Description |
|------------------|---------|----------------------|-------------|
| Text             | string  | ""                   | The text displayed next to the slider. |
| Value            | number  | Required (Default)   | Current value of the slider. |
| Min              | number  | Required             | Minimum value of the slider. |
| Max              | number  | Required             | Maximum value of the slider. |
| Rounding         | number  | Required             | Number of decimal places to round the value. |
| Visible          | boolean | true                 | Whether the slider is visible. |
| Disabled         | boolean | false                | Whether the slider is disabled. |
| Prefix           | string  | ""                   | Text displayed before the value. |
| Suffix           | string  | ""                   | Text displayed after the value. |
| ValueTextMin     | string  | ""                   | Custom text displayed when the slider is at minimum. |
| ValueTextMax     | string  | ""                   | Custom text displayed when the slider is at maximum. |
| Callback         | function| function() end       | Function called when the slider value changes. |
| Compact          | boolean | false                | If true, displays text and value in a compact format. |
| HideMax          | boolean | false                | If true, hides the maximum value display. |
| Tooltip          | string  | nil                  | Text displayed on hover. |
| DisabledTooltip  | string  | nil                  | Tooltip displayed when slider is disabled. |

### Dropdown
```lua
local GameModeDropdown = Groupbox:AddDropdown("GameMode", {
    Text = "Select Game Mode",
    Values = {"Easy", "Medium", "Hard"},
    Default = "Medium",
    Multi = false,
    AllowNull = false,
    Tooltip = "Choose the difficulty level.",
    Callback = function(Value)
        print("Selected mode:", Value)
    end
})

local PlayerDropdown = Groupbox:AddDropdown("PlayerSelect", {
    Text = "Select Player",
    SpecialType = "Player",
    ExcludeLocalPlayer = true,
    Multi = true,
    Tooltip = "Select one or more players (excludes self).",
    Callback = function(Values)
        print("Selected players:", table.concat(Values, ", "))
    end
})
```

#### Dropdown Properties

| Property              | Type    | Default              | Description |
|-----------------------|---------|----------------------|-------------|
| Text                  | string  | ""                   | The text displayed on the dropdown. |
| Values                | table   | nil                  | List of options for the dropdown. Ignored if SpecialType is "Player" or "Team". |
| Default               | string/number/table | nil            | Initial selected value. For multi-select, use a table or dictionary {Value = true}. |
| Multi                 | boolean | false                | Allows multiple selections if true. |
| DictMulti             | boolean | false                | Allows using a dictionary with boolean values for multi-select (new format). |
| SpecialType           | string  | nil                  | "Player" or "Team" to automatically populate options. |
| ExcludeLocalPlayer    | boolean | false                | Used with SpecialType = "Player" to exclude the local player. |
| ReturnInstanceInstead | boolean | false                | Returns the Instance of the player or team instead of the name. |
| Searchable            | boolean | false                | Allows searching within the dropdown. |
| Disabled              | boolean | false                | Disables the dropdown. |
| AllowNull             | boolean | false                | Allows no option to be selected. |
| DisabledValues        | table   | {}                   | List of values that cannot be selected. |
| Tooltip               | string  | nil                  | Tooltip text shown when hovering over the dropdown. |
| DisabledTooltip       | string  | nil                  | Tooltip text shown when the dropdown is disabled. |
| MaxVisibleDropdownItems | number | 8                  | Maximum number of items visible when the dropdown is open. |
| Visible               | boolean | true                 | Whether the dropdown is visible. |
| Callback              | function| function(Value) end  | Function called when selection changes. |

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

#### Input Properties

| Property         | Type    | Default              | Description |
|------------------|---------|----------------------|-------------|
| Text             | string  | Required             | Label text displayed above the input box. |
| Value            | string  | "" or Default        | Current value of the input box. |
| Numeric          | boolean | false                | If true, only allows numeric input. |
| Finished         | boolean | false                | If true, triggers callback only after focus is lost or enter is pressed. |
| Visible          | boolean | true                 | Whether the input box is visible. |
| Disabled         | boolean | false                | Whether the input box is disabled. |
| AllowEmpty       | boolean | true                 | If false, empty input resets to EmptyReset. |
| EmptyReset       | string  | "---"                | Value used when input is empty and AllowEmpty is false. |
| Placeholder      | string  | ""                   | Placeholder text shown when input is empty. |
| ClearTextOnFocus | boolean | true                 | Clears the input text when focused (if not disabled). |
| MaxLength        | number  | nil                  | Maximum number of characters allowed. |
| Tooltip          | string  | nil                  | Tooltip text shown on hover. |
| DisabledTooltip  | string  | nil                  | Tooltip text shown when input is disabled. |
| Callback         | function| function(Value) end  | Function called when input value changes. |

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

#### ColorPicker Properties

| Property     | Type     | Default                     | Description |
|--------------|----------|-----------------------------|-------------|
| Title        | string   | Required                    | The title of the color picker. |
| Value        | Color3   | Required (Default)          | Current color value. |
| Transparency | number   | nil                         | Initial transparency value (0-1). |
| Visible      | boolean  | true                        | Whether the color picker is visible. |
| Disabled     | boolean  | false                       | Whether the color picker is disabled. |
| Tooltip      | string   | nil                         | Tooltip text shown on hover. |
| DisabledTooltip | string | nil                       | Tooltip text shown when disabled. |
| Callback     | function | function(Color, Transparency) end | Called when color or transparency changes. |

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

#### KeyPicker Properties

| Property         | Type    | Default              | Description |
|------------------|---------|----------------------|-------------|
| Default          | string  | Required             | Default key (e.g., "E"). |
| Mode             | string  | "Toggle"             | Mode: "Toggle", "Hold", "Always". |
| Text             | string  | Required             | Label text. |
| SyncToggleState  | boolean | false                | If true, syncs state with an attached toggle. |
| NoSync           | boolean | false                | If true, disables syncing. |
| Visible          | boolean | true                 | Whether the key picker is visible. |
| Disabled         | boolean | false                | Whether the key picker is disabled. |
| Tooltip          | string  | nil                  | Tooltip text shown on hover. |
| DisabledTooltip  | string  | nil                  | Tooltip text shown when disabled. |
| Callback         | function| function(Value) end  | Called when the key is pressed or state changes. |

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

#### Image Properties

| Property     | Type             | Default              | Description |
|--------------|------------------|----------------------|-------------|
| Image        | string           | Required             | Image asset ID, Lucide icon name, or URL. |
| Height       | number           | nil                  | Height of the image (width auto-adjusts). |
| Color        | Color3           | Color3.fromRGB(255, 255, 255) | Tint color applied to the image. |
| RectOffset   | Vector2          | Vector2.new(0, 0)    | Offset for slicing the image. |
| RectSize     | Vector2          | Vector2.new(0, 0)    | Size for slicing the image (0 uses full size). |
| ScaleType    | Enum.ScaleType   | Enum.ScaleType.Stretch | How the image scales: Stretch, Fit, Crop, etc. |
| Transparency | number           | 0                    | Transparency level (0-1). |
| Visible      | boolean          | true                 | Whether the image is visible. |
| Tooltip      | string           | nil                  | Tooltip text shown on hover. |

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

#### DependencyBox Properties

| Property      | Type     | Default              | Description |
|---------------|----------|----------------------|-------------|
| Dependencies | table    | {}                   | Table of dependencies, e.g., { { Toggle, true } }. Visibility depends on these. |
| Visible       | boolean  | true                 | Whether the dependency box and its children are visible (overridden by dependencies). |

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

#### Button Properties

| Property        | Type     | Default              | Description |
|-----------------|----------|----------------------|-------------|
| Text            | string   | Required             | Button text. |
| Tooltip         | string   | nil                  | Tooltip text shown on hover. |
| Func            | function | Required             | Function called when the button is clicked. |
| DoubleClick     | boolean  | false                | If true, requires double-click to activate. |
| Disabled        | boolean  | false                | If true, the button cannot be clicked. |
| DisabledTooltip | string   | nil                  | Tooltip shown when the button is disabled. |
| Visible         | boolean  | true                 | Whether the button is visible. |

### 📝 Labels and Dividers
```lua
Groupbox:AddLabel('Status: Connected')
Groupbox:AddLabel('Multi-line:\nEverything working!', true)
Groupbox:AddDivider()
Groupbox:AddDivider("Divider with label")
```

#### Label Properties

| Property   | Type    | Default  | Description |
|------------|---------|----------|-------------|
| Text       | string  | Required | Label text (supports \n for new lines). |
| Multiline  | boolean | false    | If true, allows multi-line text wrapping. |
| Visible    | boolean | true     | Whether the label is visible. |
| Tooltip    | string  | nil      | Tooltip text shown on hover. |

#### Divider Properties

| Property | Type   | Default  | Description |
|----------|--------|----------|-------------|
| Text     | string | nil      | Optional text displayed on the divider. |
| Visible  | boolean| true     | Whether the divider is visible. |

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

## 🔧 UI library Code 
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
