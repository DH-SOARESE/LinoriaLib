local repo = "https://raw.githubusercontent.com/DH-SOARESE/LinoriaLib/main/"

-- Load libraries with error handling
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))() or error("Failed to load Library")
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))() or error("Failed to load ThemeManager")
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))() or error("Failed to load SaveManager")

-- Shortcuts for quick access
local Options = Library.Options
local Toggles = Library.Toggles

-- ═══════════════════════════════════════════════════════════════════════════════
-- GLOBAL SETTINGS
-- ═══════════════════════════════════════════════════════════════════════════════

Library.ShowToggleFrameInKeybinds = true
Library.ShowCustomCursor = true
Library.NotifySide = 'Left'

-- ═══════════════════════════════════════════════════════════════════════════════
-- MAIN WINDOW CREATION
-- ═══════════════════════════════════════════════════════════════════════════════

local Window = Library:CreateWindow({
    Title = 'LinoriaLib Example',
    Center = true,
    AutoShow = true,
    Resizable = true,
    ShowCustomCursor = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

local Tabs = {
    Main = Window:AddTab('Main'),
    Settings = Window:AddTab('Settings')
}

-- ═══════════════════════════════════════════════════════════════════════════════
-- MAIN TAB - UI ELEMENT EXAMPLES
-- ═══════════════════════════════════════════════════════════════════════════════

-- ────────────────────────────────────────────────────────────────────────────────
-- TOGGLE EXAMPLES
-- ────────────────────────────────────────────────────────────────────────────────

local ToggleGroup = Tabs.Main:AddLeftGroupbox('Toggle Examples', "Left") -- Label alignment: "Left", "Center" or "Right"

-- Simple toggle with key picker
local MyToggle = ToggleGroup:AddToggle('MyToggle', {
    Text = 'Simple Toggle',
    Default = false,
    Tooltip = 'A basic toggle example',
    Callback = function(value)
        print('Simple Toggle changed to:', value)
    end
}):AddKeyPicker('KeyToggle', {
    Mode = 'Toggle',
    Default = 'E',
    Text = 'Toggle with Key',
    SyncToggleState = true
})

-- Toggle with color picker
local ColorToggle = ToggleGroup:AddToggle('ColorToggle', {
    Text = 'Toggle with Color',
    Default = false,
    Tooltip = 'Toggle that includes a color picker',
    Callback = function(value)
        print('Color Toggle changed to:', value)
    end
})

ColorToggle:AddColorPicker('ColorPicker', {
    Title = 'Custom Color',
    Default = Color3.fromRGB(255, 0, 0),
    Transparency = 0.5,
    Callback = function(color, transparency)
        print('Color changed to:', color, 'Transparency:', transparency)
    end
})

-- Risky toggle
ToggleGroup:AddToggle('RiskyToggle', {
    Text = 'Dangerous Option',
    Default = false,
    Risky = true,
    Tooltip = 'Use with caution! This is a risky option',
    Callback = function(value)
        print('Risky Toggle changed to:', value)
    end
})

-- Disabled toggle
ToggleGroup:AddToggle('DisabledToggle', {
    Text = 'Disabled Toggle',
    Default = false,
    Disabled = true,
    DisabledTooltip = 'This toggle is disabled and cannot be changed',
    Tooltip = 'Example of a disabled toggle'
})

-- ────────────────────────────────────────────────────────────────────────────────
-- SLIDER EXAMPLES
-- ────────────────────────────────────────────────────────────────────────────────

local SliderGroup = Tabs.Main:AddRightGroupbox('Slider Examples')

-- Normal slider
SliderGroup:AddSlider('NormalSlider', {
    Text = 'Normal Slider',
    Default = 50,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Suffix = '%',
    Tooltip = 'Basic slider from 0 to 100',
    Callback = function(value)
        print('Normal Slider changed to:', value)
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
    Tooltip = 'Compact slider for precise decimal values',
    Callback = function(value)
        print('Compact Slider changed to:', value)
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
    Tooltip = 'Slider with custom prefix and suffix',
    Callback = function(value)
        print('Custom Slider changed to:', value)
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
    Tooltip = 'Slider that hides the maximum value display',
    Callback = function(value)
        print('Hidden Max Slider changed to:', value)
    end
})

-- ────────────────────────────────────────────────────────────────────────────────
-- DROPDOWN EXAMPLES
-- ────────────────────────────────────────────────────────────────────────────────

local DropdownGroup = Tabs.Main:AddLeftGroupbox('Dropdown Examples')

-- Simple dropdown
DropdownGroup:AddDropdown('SimpleDropdown', {
    Text = 'Simple Dropdown',
    Values = {'Option 1', 'Option 2', 'Option 3'},
    Default = 1,
    Tooltip = 'Basic single-select dropdown',
    Callback = function(value)
        print('Simple Dropdown selected:', value)
    end
})

-- Dropdown with search
DropdownGroup:AddDropdown('SearchableDropdown', {
    Text = 'Dropdown with Search',
    Values = {'Alpha', 'Beta', 'Gamma', 'Delta', 'Epsilon'},
    Default = 1,
    Searchable = true,
    Tooltip = 'Dropdown with search functionality',
    Callback = function(value)
        print('Searchable Dropdown selected:', value)
    end
})

-- Multiple selection dropdown
DropdownGroup:AddDropdown('MultiDropdown', {
    Text = 'Multiple Selection',
    Values = {'ESP', 'Aimbot', 'Speed', 'Fly'},
    Default = {['ESP'] = true},
    Multi = true,
    Tooltip = 'Dropdown allowing multiple selections',
    Callback = function(values)
        print('Multi Dropdown selections:')
        for item, enabled in pairs(values) do
            if enabled then
                print('  -', item)
            end
        end
    end
})

-- Player dropdown
DropdownGroup:AddDropdown('PlayerDropdown', {
    Text = 'Select Player',
    SpecialType = 'Player',
    ExcludeLocalPlayer = true,
    Searchable = true,
    Tooltip = 'Dropdown listing players on the server',
    Callback = function(player)
        print('Player Dropdown selected:', player)
    end
})

-- ────────────────────────────────────────────────────────────────────────────────
-- INPUT EXAMPLES
-- ────────────────────────────────────────────────────────────────────────────────

local InputGroup = Tabs.Main:AddRightGroupbox('Input Examples')

-- Basic input
InputGroup:AddInput('BasicInput', {
    Text = 'Basic Input',
    Default = 'Default text',
    Placeholder = 'Type here...',
    Tooltip = 'Simple text input field',
    Callback = function(value)
        print('Basic Input changed to:', value)
    end
})

-- Input with Enter (Finished)
InputGroup:AddInput('FinishedInput', {
    Text = 'Input with Enter',
    Placeholder = 'Press Enter...',
    Finished = true,
    Tooltip = 'Callback triggers only on Enter key',
    Callback = function(value)
        print('Finished Input confirmed:', value)
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
    Tooltip = 'Input limited to 10 characters',
    Callback = function(value)
        print('Limited Input changed to:', value)
    end
})

-- Numeric input
InputGroup:AddInput('NumericInput', {
    Text = 'Numeric Input',
    Default = '100',
    Placeholder = 'Numbers only',
    Numeric = true,
    Tooltip = 'Input that accepts only numeric values',
    Callback = function(value)
        local num = tonumber(value)
        if num then
            print('Numeric Input changed to:', num)
        end
    end
})

-- Disabled input
InputGroup:AddInput('DisabledInput', {
    Text = 'Disabled Input',
    Default = 'Read only',
    Disabled = true,
    Tooltip = 'Input field that cannot be edited'
})

-- ────────────────────────────────────────────────────────────────────────────────
-- BUTTON EXAMPLES
-- ────────────────────────────────────────────────────────────────────────────────

local ButtonGroup = Tabs.Main:AddLeftGroupbox('Button Examples')

-- Simple button
ButtonGroup:AddButton({
    Text = 'Simple Button',
    Tooltip = 'Basic button example',
    Func = function()
        print('Simple Button pressed!')
        Library:Notify('Button clicked!')
    end
})

-- Button with double click
ButtonGroup:AddButton({
    Text = 'Double Click',
    DoubleClick = true,
    Tooltip = 'Requires double click to activate',
    Func = function()
        print('Double Click Button confirmed!')
        Library:Notify('Action confirmed with double click!')
    end
})

-- Disabled button
ButtonGroup:AddButton({
    Text = 'Disabled Button',
    Disabled = true,
    DisabledTooltip = 'This button is disabled',
    Tooltip = 'Example of a disabled button',
    Func = function()
        print('This should not print as button is disabled')
    end
})

-- Important action button
ButtonGroup:AddButton({
    Text = 'Important Action',
    Tooltip = 'Triggers a notification for an important action',
    Func = function()
        Library:Notify('Executing important action...', 3)
    end
})

-- ────────────────────────────────────────────────────────────────────────────────
-- KEYPICKER EXAMPLES
-- ────────────────────────────────────────────────────────────────────────────────

local KeyGroup = Tabs.Main:AddRightGroupbox('KeyPicker Examples')

-- KeyPicker Toggle
KeyGroup:AddLabel('KeyPicker Toggle'):AddKeyPicker('ToggleKey', {
    Default = 'F',
    Mode = 'Toggle',
    Text = 'Toggle Mode',
    Callback = function(value)
        print('Toggle KeyPicker changed to:', value)
    end
})

-- KeyPicker Hold
KeyGroup:AddLabel('KeyPicker Hold'):AddKeyPicker('HoldKey', {
    Default = 'LeftShift',
    Mode = 'Hold',
    Text = 'Hold Mode',
    Callback = function(value)
        print('Hold KeyPicker changed to:', value)
    end
})

-- KeyPicker Always
KeyGroup:AddLabel('KeyPicker Always'):AddKeyPicker('AlwaysKey', {
    Default = 'C',
    Mode = 'Always',
    Text = 'Always Mode',
    Callback = function(value)
        print('Always KeyPicker changed to:', value)
    end
})

-- ────────────────────────────────────────────────────────────────────────────────
-- IMAGE EXAMPLE
-- ────────────────────────────────────────────────────────────────────────────────

local ImageGroup = Tabs.Main:AddLeftGroupbox('Image Example')

-- Roblox Asset Image
ImageGroup:AddImage('RobloxImage', {
    Image = 'rbxassetid://9328294962',
    Height = 100,
    Color = Color3.fromRGB(255, 255, 255),
    ScaleType = Enum.ScaleType.Fit,
    Transparency = 0,
    Visible = true,
    Tooltip = 'Example of displaying a Roblox asset image'
})

-- ────────────────────────────────────────────────────────────────────────────────
-- LABELS AND DIVIDERS EXAMPLES
-- ────────────────────────────────────────────────────────────────────────────────

local LabelGroup = Tabs.Main:AddRightGroupbox('Label & Divider Examples')

LabelGroup:AddLabel('Simple Label')
LabelGroup:AddLabel('Label with multiple lines:\nLine 2\nLine 3', true)
LabelGroup:AddDivider()
LabelGroup:AddLabel('After the divider')
LabelGroup:AddDivider('Banana')  -- Divider with label

-- ────────────────────────────────────────────────────────────────────────────────
-- DEPENDENCY BOX EXAMPLE
-- ────────────────────────────────────────────────────────────────────────────────

local DependencyGroup = Tabs.Main:AddLeftGroupbox('Dependency Box Example')

local MasterToggle = DependencyGroup:AddToggle('MasterToggle', {
    Text = 'Enable Advanced Options',
    Default = false,
    Tooltip = 'Toggles visibility of dependent options',
    Callback = function(value)
        print('Master Toggle changed to:', value)
    end
})

local DepBox = DependencyGroup:AddDependencyBox()
DepBox:SetupDependencies({{Toggles.MasterToggle, true}})

DepBox:AddSlider('DepSlider', {
    Text = 'Dependent Slider',
    Default = 50,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Tooltip = 'Slider visible only when MasterToggle is enabled',
    Callback = function(value)
        print('Dependent Slider changed to:', value)
    end
})

DepBox:AddDropdown('DepDropdown', {
    Text = 'Dependent Dropdown',
    Values = {'A', 'B', 'C'},
    Default = 1,
    Tooltip = 'Dropdown visible only when MasterToggle is enabled',
    Callback = function(value)
        print('Dependent Dropdown selected:', value)
    end
})

-- ────────────────────────────────────────────────────────────────────────────────
-- TABBOX (NESTED TABS) EXAMPLE
-- ────────────────────────────────────────────────────────────────────────────────

local SubTabbox = Tabs.Main:AddRightTabbox()
local SubTab1 = SubTabbox:AddTab('Sub-Tab 1')
local SubTab2 = SubTabbox:AddTab('Sub-Tab 2')

SubTab1:AddToggle('SubToggle1', {
    Text = 'Toggle in Sub-Tab 1',
    Default = false,
    Tooltip = 'Toggle inside a nested tab',
    Callback = function(value)
        print('Sub-Tab 1 Toggle changed to:', value)
    end
})

SubTab2:AddSlider('SubSlider2', {
    Text = 'Slider in Sub-Tab 2',
    Default = 50,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Tooltip = 'Slider inside a nested tab',
    Callback = function(value)
        print('Sub-Tab 2 Slider changed to:', value)
    end
})

-- ═══════════════════════════════════════════════════════════════════════════════
-- SETTINGS TAB - MENU CONTROLS AND SAVING
-- ═══════════════════════════════════════════════════════════════════════════════

local MenuGroup = Tabs.Settings:AddLeftGroupbox('Menu Controls')

Library.KeybindFrame.Visible = true

MenuGroup:AddToggle('ShowKeybinds', {
    Text = 'Show Keybinds',
    Default = true,
    Tooltip = 'Toggles visibility of the keybind frame',
    Callback = function(value)
        Library.KeybindFrame.Visible = value
    end
})

MenuGroup:AddToggle('ShowWatermark', {
    Text = 'Show Watermark',
    Default = true,
    Tooltip = 'Toggles visibility of the watermark',
    Callback = function(value)
        Library:SetWatermarkVisibility(value)
    end
})

MenuGroup:AddLabel('Menu Keybind'):AddKeyPicker('MenuKeybind', {
    Default = 'RightShift',
    NoUI = true,
    Text = 'Toggle Menu',
    Callback = function(value)
        print('Menu Keybind changed to:', value)
    end
})

MenuGroup:AddDivider()

MenuGroup:AddButton({
    Text = 'Test Notification',
    Tooltip = 'Displays a test notification',
    Func = function()
        Library:Notify('This is a test notification!')
    end
})

MenuGroup:AddButton({
    Text = 'Unload Menu',
    Tooltip = 'Unloads the entire UI library',
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
            'LinoriaLib Example | %d FPS | %dms',
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
