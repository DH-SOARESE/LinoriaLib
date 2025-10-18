local LinoriaLib = "https://raw.githubusercontent.com/DH-SOARESE/LinoriaLib/main/"

local function loadLibrary(path)
    local success, result = pcall(function()
        return loadstring(game:HttpGet(LinoriaLib .. path))()
    end)
    
    if not success then
        error("Failed to load " .. path .. ": " .. tostring(result))
    end
    
    return result
end

local Library = loadLibrary('Library.lua')
local ThemeManager = loadLibrary('addons/ThemeManager.lua')
local SaveManager = loadLibrary('addons/SaveManager.lua')

local Options = Library.Options
local Toggles = Library.Toggles

Library.ShowToggleFrameInKeybinds = true
Library.ShowCustomCursor = true
Library.NotifySide = 'Right' -- Notification position: 'Left' or 'Right'

-- Create Window
local Window = Library:CreateWindow({
    Title = 'LinoriaLib | Complete Examples',
    Center = true,
    AutoShow = true,
    Resizable = true,
    ShowCustomCursor = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

-- Create Tabs
local Tabs = {
    Components = Window:AddTab('Main', '8301879545'),
    Advanced = Window:AddTab('Advanced'),
    Settings = Window:AddTab('Settings', '7963356958')
}

-- UI Elements

-- Toggles
local ToggleBox = Tabs.Components:AddLeftGroupbox('Toggles')

-- Basic Toggle
ToggleBox:AddToggle('BasicToggle', {
    Text = 'Basic Toggle',
    Default = false,
    Tooltip = 'Simple on/off switch',
    Callback = function(value)
        print('[Basic Toggle] State:', value)
    end
})

-- Toggle with Keybind
ToggleBox:AddToggle('KeybindToggle', {
    Text = 'Toggle with Keybind',
    Default = false,
    Tooltip = 'Can be toggled via keybind',
    Callback = function(value)
        print('[Keybind Toggle] State:', value)
    end
}):AddKeyPicker('KeybindTogglePicker', {
    Mode = 'Toggle', -- Toggle, Hold, Always
    Default = 'E',
    Text = 'Toggle Key',
    SyncToggleState = true,
    Callback = function(value)
        print('[Keybind] Key changed to:', value)
    end
})

-- Toggle with Color Picker
ToggleBox:AddToggle('ColorToggle', {
    Text = 'Toggle with Color',
    Default = false,
    Tooltip = 'Includes color customization',
    Callback = function(value)
        print('[Color Toggle] State:', value)
    end
}):AddColorPicker('ColorPicker', {
    Title = 'Choose Color',
    Default = Color3.fromRGB(0, 150, 255),
    Transparency = 0.5,
    Callback = function(color, transparency)
        print('[Color] RGB:', color, '| Alpha:', transparency)
    end
})

-- Risky Toggle (Red text warning)
ToggleBox:AddToggle('RiskyToggle', {
    Text = 'Risky Option',
    Default = false,
    Risky = true,
    Tooltip = 'Potentially dangerous feature - use with caution',
    Callback = function(value)
        print('[Risky Toggle] State:', value)
    end
})

-- Disabled Toggle
ToggleBox:AddToggle('DisabledToggle', {
    Text = 'Disabled Toggle',
    Default = false,
    Disabled = true,
    DisabledTooltip = 'This feature is currently unavailable',
    Tooltip = 'Cannot be modified'
})

-- Buttons
local ButtonBox = Tabs.Components:AddLeftGroupbox('Buttons')

-- Standard and Double-Click Buttons (side-by-side)
local StandardButton = ButtonBox:AddButton({
    Text = 'Standard Button',
    Tooltip = 'Click to execute action',
    Func = function()
        Library:Notify('Button clicked!', 3)
        print('[Button] Standard button pressed')
    end
}):AddButton({
    Text = 'Confirm Action',
    DoubleClick = true,
    Tooltip = 'Double-click to confirm',
    Func = function()
        Library:Notify('Action confirmed!', 3)
        print('[Button] Confirmation button activated')
    end
})

-- Disabled Button (standalone, as limit is 2 per row)
ButtonBox:AddButton({
    Text = 'Disabled Button',
    Disabled = true,
    DisabledTooltip = 'This action is unavailable',
    Tooltip = 'Cannot be clicked',
    Func = function()
        print('[Button] This should never print')
    end
})

-- Sliders
local SliderBox = Tabs.Components:AddRightGroupbox('Sliders')

-- Integer Slider
SliderBox:AddSlider('IntegerSlider', {
    Text = 'Integer Slider',
    Default = 50,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Suffix = '%',
    Tooltip = 'Whole numbers from 0 to 100',
    Callback = function(value)
        print('[Slider] Integer value:', value)
    end
})

-- Decimal Slider
SliderBox:AddSlider('DecimalSlider', {
    Text = 'Decimal Slider',
    Default = 0.5,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Compact = true,
    Tooltip = 'Precise decimal values (0.00 - 1.00)',
    Callback = function(value)
        print('[Slider] Decimal value:', value)
    end
})

-- Slider with Custom Prefix/Suffix
SliderBox:AddSlider('CurrencySlider', {
    Text = 'Currency Slider',
    Default = 250,
    Min = 1,
    Max = 1000,
    Rounding = 0,
    Prefix = '$',
    Suffix = ' USD',
    Tooltip = 'Value with currency formatting',
    Callback = function(value)
        print('[Slider] Currency value:', value)
    end
})

-- Slider with Value Text
SliderBox:AddSlider('ValueTextSlider', {
    Text = 'Value Text',
    Default = 0,
    Min = 0,
    Max = 20,
    Rounding = 0,
    ValueText = {
    {Value = 0, Text = "Calm"},
    {Value = 10, Text = "Tense"},
    {Value = 20, Text = "Extreme"}},
    Tooltip = 'Shows text labels at extremes',
    Callback = function(value)
        print('[Slider] Value:', value)
    end
})

-- Slider Without Max Display
SliderBox:AddSlider('NoMaxSlider', {
    Text = 'Hidden Maximum',
    Default = 50,
    Min = 0,
    Max = 200,
    Rounding = 0,
    HideMax = true,
    Tooltip = 'Maximum value not shown',
    Callback = function(value)
        print('[Slider] Value:', value)
    end
})

-- Dropdowns
local DropdownBox = Tabs.Components:AddRightGroupbox('Dropdowns')

-- Single Selection
DropdownBox:AddDropdown('SingleSelect', {
    Text = 'Single Selection',
    Values = {'Option A', 'Option B', 'Option C', 'Option D'},
    Default = 1,
    Tooltip = 'Choose one option',
    Callback = function(value)
        print('[Dropdown] Selected:', value)
    end
})

-- Searchable Dropdown
DropdownBox:AddDropdown('SearchableDropdown', {
    Text = 'Searchable List',
    Values = {'Alpha', 'Beta', 'Gamma', 'Delta', 'Epsilon', 'Zeta', 'Eta', 'Theta'},
    Default = 1,
    Searchable = true,
    Tooltip = 'Type to filter options',
    Callback = function(value)
        print('[Dropdown] Searched and selected:', value)
    end
})

-- Multi-Selection
DropdownBox:AddDropdown('MultiSelect', {
    Text = 'Multi-Selection',
    Values = {'Feature 1', 'Feature 2', 'Feature 3', 'Feature 4'},
    Default = {['Feature 1'] = true},
    Multi = true,
    Tooltip = 'Select multiple options',
    Callback = function(values)
        print('[Dropdown] Multi-select changed:')
        for item, enabled in pairs(values) do
            if enabled then
                print('  ✓', item)
            end
        end
    end
})

-- Player Dropdown
DropdownBox:AddDropdown('PlayerSelect', {
    Text = 'Select Player',
    SpecialType = 'Player',
    ExcludeLocalPlayer = true,
    Searchable = true,
    Tooltip = 'Choose from server players',
    Callback = function(player)
        print('[Dropdown] Selected player:', player)
    end
})

-- Input Fields
local InputBox = Tabs.Components:AddLeftGroupbox('Input Fields')

-- Standard Text Input
InputBox:AddInput('StandardInput', {
    Text = 'Text Input',
    Default = '',
    Placeholder = 'Type here...',
    Tooltip = 'Enter any text',
    Callback = function(value)
        print('[Input] Text entered:', value)
    end
})

-- Input with Enter to Confirm
InputBox:AddInput('ConfirmInput', {
    Text = 'Confirm Input',
    Default = '',
    Placeholder = 'Press Enter to confirm',
    Finished = true,
    Tooltip = 'Callback triggers only on Enter',
    Callback = function(value)
        print('[Input] Confirmed text:', value)
        Library:Notify('Text confirmed: ' .. value, 3)
    end
})

-- Character Limited Input
InputBox:AddInput('LimitedInput', {
    Text = 'Limited Input (15)',
    Default = '',
    Placeholder = 'Max 15 characters',
    MaxLength = 15,
    AllowEmpty = false,
    EmptyReset = 'Reset',
    Tooltip = 'Cannot exceed 15 characters',
    Callback = function(value)
        print('[Input] Limited text:', value)
    end
})

-- Numeric Only Input
InputBox:AddInput('NumericInput', {
    Text = 'Numeric Input',
    Default = '0',
    Placeholder = 'Numbers only',
    Numeric = true,
    Tooltip = 'Accepts only numbers',
    Callback = function(value)
        local num = tonumber(value)
        if num then
            print('[Input] Number entered:', num)
        end
    end
})

-- Read-Only Input
InputBox:AddInput('ReadOnlyInput', {
    Text = 'Read-Only',
    Default = 'Cannot be edited',
    Disabled = true,
    Tooltip = 'This field is read-only'
})

-- Key Bindings
local KeyBox = Tabs.Components:AddRightGroupbox('Key Bindings')

-- Toggle Mode
KeyBox:AddLabel('Toggle Mode (On/Off)'):AddKeyPicker('ToggleModeKey', {
    Default = 'F',
    Mode = 'Toggle',
    Text = 'Toggle',
    Callback = function(value)
        print('[KeyPicker] Toggle key changed to:', value)
    end
})

-- Hold Mode
KeyBox:AddLabel('Hold Mode (Active while held)'):AddKeyPicker('HoldModeKey', {
    Default = 'LeftShift',
    Mode = 'Hold',
    Text = 'Hold',
    Callback = function(value)
        print('[KeyPicker] Hold key changed to:', value)
    end
})

-- Always Mode
KeyBox:AddLabel('Always Mode (Permanent activation)'):AddKeyPicker('AlwaysModeKey', {
    Default = 'None',
    Mode = 'Always',
    Text = 'Always Active',
    Callback = function(value)
        print('[KeyPicker] Always key changed to:', value)
    end
})

-- Advanced Tab - Complex Features

-- Dependency System
local DependencyBox = Tabs.Advanced:AddLeftGroupbox('Dependency System')

DependencyBox:AddLabel('Enable master toggle to reveal options:')

local MasterToggle = DependencyBox:AddToggle('MasterToggle', {
    Text = 'Enable Advanced Features',
    Default = false,
    Tooltip = 'Toggle to show/hide dependent options',
    Callback = function(value)
        print('[Dependency] Master toggle:', value)
    end
})

-- Dependency Container
local DependentBox = DependencyBox:AddDependencyBox()
DependentBox:SetupDependencies({{Toggles.MasterToggle, true}})

DependentBox:AddToggle('DependentToggle', {
    Text = 'Dependent Toggle',
    Default = false,
    Tooltip = 'Only visible when master is enabled',
    Callback = function(value)
        print('[Dependency] Child toggle:', value)
    end
})

DependentBox:AddSlider('DependentSlider', {
    Text = 'Dependent Slider',
    Default = 50,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Tooltip = 'Only visible when master is enabled',
    Callback = function(value)
        print('[Dependency] Child slider:', value)
    end
})

DependentBox:AddDropdown('DependentDropdown', {
    Text = 'Dependent Dropdown',
    Values = {'Choice 1', 'Choice 2', 'Choice 3'},
    Default = 1,
    Tooltip = 'Only visible when master is enabled',
    Callback = function(value)
        print('[Dependency] Child dropdown:', value)
    end
})

-- Labels and Dividers
local LabelBox = Tabs.Advanced:AddLeftGroupbox('Labels & Dividers')

LabelBox:AddLabel('Simple label text')
LabelBox:AddLabel('Multi-line label:\n• Line 1\n• Line 2\n• Line 3', true)
LabelBox:AddDivider()
LabelBox:AddLabel('After divider')
LabelBox:AddDivider('Section Title')
LabelBox:AddLabel('After titled divider')

-- Nested Tabs (Tabbox)
local NestedTabbox = Tabs.Advanced:AddRightTabbox()
local NestedTab1 = NestedTabbox:AddTab('Sub-Tab 1', '10511855986')
local NestedTab2 = NestedTabbox:AddTab('Sub-Tab 2')
local NestedTab3 = NestedTabbox:AddTab('Sub-Tab 3')

-- Sub-Tab 1 Content
NestedTab1:AddToggle('NestedToggle1', {
    Text = 'Feature in Sub-Tab 1',
    Default = false,
    Tooltip = 'Toggle within nested tab',
    Callback = function(value)
        print('[Nested] Tab 1 toggle:', value)
    end
})

NestedTab1:AddInput('NestedInput1', {
    Text = 'Input in Sub-Tab 1',
    Default = '',
    Placeholder = 'Type something...',
    Tooltip = 'Input within nested tab',
    Callback = function(value)
        print('[Nested] Tab 1 input:', value)
    end
})

-- Sub-Tab 2 Content
NestedTab2:AddSlider('NestedSlider2', {
    Text = 'Slider in Sub-Tab 2',
    Default = 75,
    Min = 0,
    Max = 150,
    Rounding = 0,
    Tooltip = 'Slider within nested tab',
    Callback = function(value)
        print('[Nested] Tab 2 slider:', value)
    end
})

NestedTab2:AddDropdown('NestedDropdown2', {
    Text = 'Dropdown in Sub-Tab 2',
    Values = {'Red', 'Green', 'Blue', 'Yellow'},
    Default = 1,
    Tooltip = 'Dropdown within nested tab',
    Callback = function(value)
        print('[Nested] Tab 2 dropdown:', value)
    end
})

-- Sub-Tab 3 Content
NestedTab3:AddButton({
    Text = 'Button in Sub-Tab 3',
    Tooltip = 'Button within nested tab',
    Func = function()
        Library:Notify('Sub-Tab 3 button clicked!', 3)
        print('[Nested] Tab 3 button pressed')
    end
})

-- Image Display
local ImageBox = Tabs.Advanced:AddRightGroupbox('Image Display')

ImageBox:AddImage('ExampleImage', {
    Image = 'rbxassetid://10511855986',
    Height = 250,
    Color = Color3.fromRGB(255, 255, 255),
    ScaleType = Enum.ScaleType.Fit,
    Transparency = 0,
    Visible = true,
    Tooltip = 'Displaying Roblox asset image'
})

ImageBox:AddVideo("DemoVideo", {
    Video = "rbxassetid://5670824523",
    Height = 250,
    Looped = true,
    Playing = true,
    Volume = 0.6,
    Visible = true
})

ImageBox:AddLabel('Image & Video from Roblox asset ID')

-- Settings Tab - Menu Configuration

local MenuBox = Tabs.Settings:AddLeftGroupbox('Menu Configuration')

-- Keybind Frame Visibility
Library.KeybindFrame.Visible = true

MenuBox:AddToggle('ShowKeybindFrame', {
    Text = 'Show Keybind List',
    Default = true,
    Tooltip = 'Display active keybinds frame',
    Callback = function(value)
        Library.KeybindFrame.Visible = value
    end
})

-- Watermark Visibility
MenuBox:AddToggle('ShowWatermark', {
    Text = 'Show Watermark',
    Default = true,
    Tooltip = 'Display watermark with info',
    Callback = function(value)
        Library:SetWatermarkVisibility(value)
    end
})

-- Menu Toggle Keybind
MenuBox:AddLabel('Menu Toggle Keybind'):AddKeyPicker('MenuKeybind', {
    Default = 'RightShift',
    NoUI = true,
    Text = 'Toggle Menu',
    Callback = function(value)
        print('[Menu] Keybind changed to:', value)
    end
})

MenuBox:AddDivider()

-- Notification Test and Unload UI Buttons (side-by-side)
local TestNotifyButton = MenuBox:AddButton({
    Text = 'Test Notification',
    Tooltip = 'Display test notification',
    Func = function()
        Library:Notify('This is a test notification message!', 5)
    end
}):AddButton({
    Text = 'Unload UI',
    DoubleClick = true,
    Tooltip = 'Double-click to unload entire UI',
    Func = function()
        Library:Notify('Unloading UI...', 2)
        task.wait(0.5)
        Library:Unload()
    end
})

-- Dynamic Watermark
Library:SetWatermarkVisibility(true)

local function InitializeWatermark()
    local RunService = game:GetService('RunService')
    local Stats = game:GetService('Stats')
    
    local frameStart = tick()
    local frameCount = 0
    local currentFPS = 60
    
    RunService.Heartbeat:Connect(function()
        frameCount = frameCount + 1
        
        if tick() - frameStart >= 1 then
            currentFPS = frameCount
            frameStart = tick()
            frameCount = 0
        end
        
        local ping = Stats.Network.ServerStatsItem['Data Ping']:GetValue()
        
        Library:SetWatermark(string.format(
            'LinoriaLib Examples | %d FPS | %dms Ping',
            math.floor(currentFPS),
            math.floor(ping)
        ))
    end)
end

InitializeWatermark()

-- Save System Configuration
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

-- Ignore theme settings in configs
SaveManager:IgnoreThemeSettings()

-- Ignore menu keybind from being saved
SaveManager:SetIgnoreIndexes({'MenuKeybind'})

-- Set save folders
ThemeManager:SetFolder('LinoriaExamples')
SaveManager:SetFolder('LinoriaExamples/configs')

-- Build UI for save system
SaveManager:BuildConfigSection(Tabs.Settings)
ThemeManager:ApplyToTab(Tabs.Settings)

-- Load autoload config if exists
SaveManager:LoadAutoloadConfig()

-- Final Message
Library:Notify('LinoriaLib Examples loaded successfully!', 5)
