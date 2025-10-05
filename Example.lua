--[[
    ╔══════════════════════════════════════════════════════════════════════════╗
    ║                         LinoriaLib v3.0.0 - Template                     ║
    ║                      Complete and Documented Example                     ║
    ╠══════════════════════════════════════════════════════════════════════════╣
    ║  Modern and responsive interface                                        ║
    ║  Compatible with PC and Mobile                                           ║
    ║  Automatic saving system                                                 ║
    ║  Customizable themes                                                     ║
    ║  All components available                                                ║
    ╚══════════════════════════════════════════════════════════════════════════╝
]]

-- ═══════════════════════════════════════════════════════════════════════════════
-- INITIAL CONFIGURATION
-- ═══════════════════════════════════════════════════════════════════════════════

local repo = "https://raw.githubusercontent.com/DH-SOARESE/LinoriaLib/main/"

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

-- Shortcuts for quick access to values
local Options = Library.Options
local Toggles = Library.Toggles

-- ═══════════════════════════════════════════════════════════════════════════════
-- GLOBAL SETTINGS
-- ═══════════════════════════════════════════════════════════════════════════════

Library.ShowToggleFrameInKeybinds = true
Library.ShowCustomCursor = true
Library.NotifySide = 'Right'

-- ═══════════════════════════════════════════════════════════════════════════════
-- CREATION OF THE MAIN WINDOW
-- ═══════════════════════════════════════════════════════════════════════════════

local Window = Library:CreateWindow({
    Title = 'My Script v1.0',
    Center = true,
    AutoShow = true,
    Resizable = true,
    ShowCustomCursor = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

-- ═══════════════════════════════════════════════════════════════════════════════
-- CREATION OF TABS
-- ═══════════════════════════════════════════════════════════════════════════════

local Tabs = {
    Main = Window:AddTab('Main'),
    Visuals = Window:AddTab('Visuals'),
    Settings = Window:AddTab('Settings')
}

-- ═══════════════════════════════════════════════════════════════════════════════
-- MAIN TAB - EXAMPLES OF ALL COMPONENTS
-- ═══════════════════════════════════════════════════════════════════════════════

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- TOGGLE (On/Off Button)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local ToggleGroup = Tabs.Main:AddLeftGroupbox('Toggle Examples')

-- Simple toggle
local MyToggle = ToggleGroup:AddToggle('MyToggle', {
    Text = 'Simple Toggle',
    Default = false,
    Tooltip = 'A basic toggle',
    Callback = function(value)
        print('Toggle:', value)
    end
})

-- Toggle with KeyPicker
local KeyToggle = ToggleGroup:AddToggle('KeyToggle', {
    Text = 'Toggle with Key',
    Default = false,
    Callback = function(value)
        print('Toggle with key:', value)
    end
})

KeyToggle:AddKeyPicker('KeyTogglePicker', {
    Default = 'E',
    Mode = 'Toggle',
    Text = 'Toggle Shortcut',
    SyncToggleState = true,
    Callback = function(value)
        print('Key pressed:', value)
    end
})

-- Toggle with ColorPicker
local ColorToggle = ToggleGroup:AddToggle('ColorToggle', {
    Text = 'Toggle with Color',
    Default = false,
    Callback = function(value)
        print('Colored toggle:', value)
    end
})

ColorToggle:AddColorPicker('ColorPicker', {
    Title = 'Custom Color',
    Default = Color3.fromRGB(255, 0, 0),
    Transparency = 0.5,
    Callback = function(color, transparency)
        print('Color:', color, 'Transparency:', transparency)
    end
})

-- Risky toggle
ToggleGroup:AddToggle('RiskyToggle', {
    Text = 'Dangerous Option',
    Default = false,
    Risky = true,
    Tooltip = 'Use with caution!'
})

-- Disabled toggle
ToggleGroup:AddToggle('DisabledToggle', {
    Text = 'Disabled Toggle',
    Default = false,
    Disabled = true,
    DisabledTooltip = 'This toggle is disabled'
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- SLIDER (Slider Bar)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local SliderGroup = Tabs.Main:AddRightGroupbox('Slider Examples')

-- Normal slider
SliderGroup:AddSlider('NormalSlider', {
    Text = 'Normal Slider',
    Default = 50,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Suffix = '%',
    Tooltip = 'Slider from 0 to 100',
    Callback = function(value)
        print('Normal slider:', value)
    end
})

-- Compact slider
SliderGroup:AddSlider('CompactSlider', {
    Text = 'Compact Slider',
    Default = 0.5,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Compact = true,
    Tooltip = 'Compact format',
    Callback = function(value)
        print('Compact slider:', value)
    end
})

-- Slider with prefix and suffix
SliderGroup:AddSlider('CustomSlider', {
    Text = 'Custom Slider',
    Default = 100,
    Min = 1,
    Max = 500,
    Rounding = 0,
    Prefix = '$',
    Suffix = ' coins',
    Tooltip = 'With prefix and suffix',
    Callback = function(value)
        print('Custom value:', value)
    end
})

-- Slider without showing maximum
SliderGroup:AddSlider('HiddenMaxSlider', {
    Text = 'Without Showing Maximum',
    Default = 25,
    Min = 1,
    Max = 100,
    Rounding = 0,
    HideMax = true,
    Tooltip = 'Does not show the maximum value',
    Callback = function(value)
        print('Slider without max:', value)
    end
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- DROPDOWN (Dropdown Menu)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local DropdownGroup = Tabs.Main:AddLeftGroupbox('Dropdown Examples')

-- Simple dropdown
DropdownGroup:AddDropdown('SimpleDropdown', {
    Text = 'Simple Dropdown',
    Values = {'Option 1', 'Option 2', 'Option 3'},
    Default = 1,
    Tooltip = 'Select an option',
    Callback = function(value)
        print('Selected option:', value)
    end
})

-- Dropdown with search
DropdownGroup:AddDropdown('SearchableDropdown', {
    Text = 'Dropdown with Search',
    Values = {'Alpha', 'Beta', 'Gamma', 'Delta', 'Epsilon'},
    Default = 1,
    Searchable = true,
    Tooltip = 'Type to search',
    Callback = function(value)
        print('Search selected:', value)
    end
})

-- Multiple selection dropdown
DropdownGroup:AddDropdown('MultiDropdown', {
    Text = 'Multiple Selection',
    Values = {'ESP', 'Aimbot', 'Speed', 'Fly'},
    Default = {'ESP'},
    Multi = true,
    Tooltip = 'Select multiple items',
    Callback = function(values)
        print('Selected items:')
        for item, enabled in pairs(values) do
            print('  ', item, enabled)
        end
    end
})

-- Player dropdown
DropdownGroup:AddDropdown('PlayerDropdown', {
    Text = 'Select Player',
    SpecialType = 'Player',
    ExcludeLocalPlayer = true,
    Searchable = true,
    Tooltip = 'List of players on the server',
    Callback = function(player)
        print('Selected player:', player)
    end
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- INPUT (Text Field)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local InputGroup = Tabs.Main:AddRightGroupbox('Input Examples')

-- Basic input
InputGroup:AddInput('BasicInput', {
    Text = 'Basic Input',
    Default = 'Default text',
    Placeholder = 'Type here...',
    Tooltip = 'Simple text field',
    Callback = function(value)
        print('Basic input:', value)
    end
})

-- Input with Enter (Finished)
InputGroup:AddInput('FinishedInput', {
    Text = 'Input with Enter',
    Placeholder = 'Press Enter...',
    Finished = true,
    Tooltip = 'Callback only on pressing Enter',
    Callback = function(value)
        print('Enter pressed:', value)
        Library:Notify('Text confirmed: ' .. value)
    end
})

-- Input with character limit
InputGroup:AddInput('LimitedInput', {
    Text = 'Limited Input',
    Placeholder = 'Max 10 characters',
    MaxLength = 10,
    AllowEmpty = false,
    EmptyReset = 'Default',
    Tooltip = 'Maximum of 10 characters',
    Callback = function(value)
        print('Limited input:', value)
    end
})

-- Numeric input
InputGroup:AddInput('NumericInput', {
    Text = 'Numeric Input',
    Default = '100',
    Placeholder = 'Numbers only',
    Numeric = true,
    Tooltip = 'Accepts only numbers',
    Callback = function(value)
        local num = tonumber(value)
        if num then
            print('Inserted number:', num)
        end
    end
})

-- Disabled input
InputGroup:AddInput('DisabledInput', {
    Text = 'Disabled Input',
    Default = 'Read only',
    Disabled = true,
    Tooltip = 'This field cannot be edited'
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- BUTTON (Buttons)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local ButtonGroup = Tabs.Main:AddLeftGroupbox('Button Examples')

-- Simple button
ButtonGroup:AddButton({
    Text = 'Simple Button',
    Tooltip = 'Click to execute',
    Func = function()
        print('Button pressed!')
        Library:Notify('Button clicked!')
    end
})

-- Button with double click
ButtonGroup:AddButton({
    Text = 'Double Click',
    DoubleClick = true,
    Tooltip = 'Requires double click for safety',
    Func = function()
        print('Double click confirmed!')
        Library:Notify('Action confirmed with double click!')
    end
})

-- Disabled button
ButtonGroup:AddButton({
    Text = 'Disabled Button',
    Disabled = true,
    DisabledTooltip = 'This button is disabled',
    Func = function()
        print('This button should not work')
    end
})

-- Important action button
ButtonGroup:AddButton({
    Text = 'Important Action',
    Tooltip = 'Executes a critical action',
    Func = function()
        Library:Notify('Executing important action...', 3)
    end
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- KEYPICKER (Key Selector)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local KeyGroup = Tabs.Main:AddRightGroupbox('KeyPicker Examples')

-- KeyPicker Toggle
KeyGroup:AddLabel('KeyPicker Toggle'):AddKeyPicker('ToggleKey', {
    Default = 'F',
    Mode = 'Toggle',
    Text = 'Toggle Mode',
    Callback = function(value)
        print('Toggle Key:', value)
    end
})

-- KeyPicker Hold
KeyGroup:AddLabel('KeyPicker Hold'):AddKeyPicker('HoldKey', {
    Default = 'LeftShift',
    Mode = 'Hold',
    Text = 'Hold Mode',
    Callback = function(value)
        print('Hold Key:', value)
    end
})

-- KeyPicker Always
KeyGroup:AddLabel('KeyPicker Always'):AddKeyPicker('AlwaysKey', {
    Default = 'C',
    Mode = 'Always',
    Text = 'Always Mode',
    Callback = function(value)
        print('Always Key:', value)
    end
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- IMAGE (Images)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local ImageGroup = Tabs.Main:AddLeftGroupbox('Image Example')

-- Roblox Asset Image
ImageGroup:AddImage('RobloxImage', {
    Image = 'rbxassetid://9328294962',
    Height = 100,
    Color = Color3.fromRGB(255, 255, 255),
    ScaleType = Enum.ScaleType.Fit,
    Transparency = 0,
    Visible = true,
    Tooltip = 'Roblox Image'
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- LABELS AND DIVIDERS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local LabelGroup = Tabs.Main:AddRightGroupbox('Label & Divider Examples')

LabelGroup:AddLabel('Simple Label')
LabelGroup:AddLabel('Label with multiple lines:\nLine 2\nLine 3', true)
LabelGroup:AddDivider()
LabelGroup:AddLabel('After the divider')

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- DEPENDENCY BOX (Dependency Box)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local DependencyGroup = Tabs.Main:AddLeftGroupbox('Dependency Box Example')

local MasterToggle = DependencyGroup:AddToggle('MasterToggle', {
    Text = 'Enable Advanced Options',
    Default = false,
    Tooltip = 'Enables additional settings'
})

local DepBox = DependencyGroup:AddDependencyBox()
DepBox:SetupDependencies({{Toggles.MasterToggle, true}})

DepBox:AddSlider('DepSlider', {
    Text = 'Dependent Option',
    Default = 50,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Tooltip = 'Only appears when MasterToggle is active'
})

DepBox:AddDropdown('DepDropdown', {
    Text = 'Dependent Dropdown',
    Values = {'A', 'B', 'C'},
    Default = 1,
    Tooltip = 'Option dependent on the toggle'
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- TABBOX (Nested Tabs)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local SubTabbox = Tabs.Main:AddRightTabbox()
local SubTab1 = SubTabbox:AddTab('Sub-Tab 1')
local SubTab2 = SubTabbox:AddTab('Sub-Tab 2')

SubTab1:AddToggle('SubToggle1', {
    Text = 'Toggle in Sub-Tab 1',
    Default = false
})

SubTab2:AddSlider('SubSlider2', {
    Text = 'Slider in Sub-Tab 2',
    Default = 50,
    Min = 0,
    Max = 100,
    Rounding = 0
})

-- ═══════════════════════════════════════════════════════════════════════════════
-- VISUALS TAB - PRACTICAL EXAMPLES
-- ═══════════════════════════════════════════════════════════════════════════════

local ESPGroup = Tabs.Visuals:AddLeftGroupbox('ESP Settings')

local PlayerESP = ESPGroup:AddToggle('PlayerESP', {
    Text = 'Player ESP',
    Default = false,
    Tooltip = 'Shows players through walls'
})

PlayerESP:AddColorPicker('ESPColor', {
    Title = 'ESP Color',
    Default = Color3.fromRGB(0, 255, 0),
    Transparency = 0.5
})

ESPGroup:AddSlider('ESPDistance', {
    Text = 'Maximum Distance',
    Default = 500,
    Min = 100,
    Max = 2000,
    Rounding = 0,
    Suffix = ' studs'
})

ESPGroup:AddDropdown('ESPStyle', {
    Text = 'ESP Style',
    Values = {'Box', 'Highlight', 'Outline', 'Glow'},
    Default = 1
})

-- ═══════════════════════════════════════════════════════════════════════════════
-- SETTINGS TAB - SETTINGS AND SAVING
-- ═══════════════════════════════════════════════════════════════════════════════

local MenuGroup = Tabs.Settings:AddLeftGroupbox('Menu Controls')

MenuGroup:AddToggle('ShowKeybinds', {
    Text = 'Show Keybinds',
    Default = true,
    Callback = function(value)
        Library.KeybindFrame.Visible = value
    end
})

MenuGroup:AddToggle('ShowWatermark', {
    Text = 'Show Watermark',
    Default = true,
    Callback = function(value)
        Library:SetWatermarkVisibility(value)
    end
})

MenuGroup:AddLabel('Menu Keybind'):AddKeyPicker('MenuKeybind', {
    Default = 'RightShift',
    NoUI = true,
    Text = 'Toggle Menu'
})

MenuGroup:AddDivider()

MenuGroup:AddButton({
    Text = 'Test Notification',
    Func = function()
        Library:Notify('This is a test notification!')
    end
})

MenuGroup:AddButton({
    Text = 'Unload Menu',
    Func = function()
        Library:Unload()
    end
})

-- ═══════════════════════════════════════════════════════════════════════════════
-- DYNAMIC WATERMARK
-- ═══════════════════════════════════════════════════════════════════════════════

Library:SetWatermarkVisibility(true)

local function updateWatermark()
    local RunService = game:GetService('RunService')
    local Stats = game:GetService('Stats')
    
    local frameStart = tick()
    local frameCount = 0
    local FPS = 60
    
    RunService.Heartbeat:Connect(function()
        frameCount = frameCount + 1
        
        if tick() - frameStart >= 1 then
            FPS = frameCount
            frameStart = tick()
            frameCount = 0
        end
        
        local ping = Stats.Network.ServerStatsItem['Data Ping']:GetValue()
        
        Library:SetWatermark(string.format(
            'My Script v1.0 | %d FPS | %dms',
            math.floor(FPS),
            math.floor(ping)
        ))
    end)
end

updateWatermark()

-- ═══════════════════════════════════════════════════════════════════════════════
-- SAVING SYSTEM
-- ═══════════════════════════════════════════════════════════════════════════════

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({'MenuKeybind'})

ThemeManager:SetFolder('MyScript')
SaveManager:SetFolder('MyScript/configs')

SaveManager:BuildConfigSection(Tabs.Settings)
ThemeManager:ApplyToTab(Tabs.Settings)

SaveManager:LoadAutoloadConfig()

-- ═══════════════════════════════════════════════════════════════════════════════
-- ADVANCED USAGE EXAMPLES
-- ═══════════════════════════════════════════════════════════════════════════════

-- Monitor changes in real time
Toggles.PlayerESP:OnChanged(function()
    print('PlayerESP changed to:', Toggles.PlayerESP.Value)
end)

-- Access values
task.spawn(function()
    while true do
        wait(1)
        -- Example of how to access component values
        if Toggles.PlayerESP and Toggles.PlayerESP.Value then
            local distance = Options.ESPDistance.Value
            print('ESP active with distance:', distance)
        end
    end
end)

-- ═══════════════════════════════════════════════════════════════════════════════
-- FINALIZATION
-- ═══════════════════════════════════════════════════════════════════════════════

print('Menu loaded successfully!')
print('User:', game.Players.LocalPlayer.Name)
print('Press', Options.MenuKeybind.Value, 'to open/close the menu')

Library:Notify('Menu loaded successfully!')
