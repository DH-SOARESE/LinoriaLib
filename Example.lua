-- Enhanced Example Script for LinoriaLib
-- Author: wally (improved for clarity and elegance)
-- Contributions: Suggest changes via pull request

-- === Library Setup ===
local repo = 'https://raw.githubusercontent.com/DH-SOARESE/LinoriaLib/main/'
local Library, ThemeManager, SaveManager

-- Load libraries with error handling
do
    local success, result = pcall(function()
        Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
        ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
        SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
    end)
    if not success then
        error('Failed to load LinoriaLib: ' .. tostring(result))
    end
end

-- Shortcuts for frequently used tables
local Options = Library.Options
local Toggles = Library.Toggles

-- Global library settings
Library.ShowToggleFrameInKeybinds = true -- Show toggle keybinds in UI (great for mobile)
Library.ShowCustomCursor = true          -- Enable custom cursor globally
Library.NotifySide = 'Left'             -- Notification side (Left/Right)

-- === Window Creation ===
local Window = Library:CreateWindow({
    Title = 'Demo Menu',
    Center = true,           -- Center the window on screen
    AutoShow = true,        -- Show the window immediately
    Resizable = true,       -- Allow in-game resizing
    ShowCustomCursor = true,-- Use Linoria's custom cursor
    NotifySide = 'Left',    -- Notification side for this window
    TabPadding = 8,         -- Padding between tabs
    MenuFadeTime = 0.2      -- Smooth fade animation for menu
})

-- === Tab Setup ===
local Tabs = {
    Main = Window:AddTab('Main'),
    Settings = Window:AddTab('UI Settings')
}

-- === Main Tab: Left Groupbox (Core Features) ===
local CoreFeatures = Tabs.Main:AddLeftGroupbox('Core Features')

-- Toggle with multiple color pickers
local FeatureToggle = CoreFeatures:AddToggle('FeatureToggle', {
    Text = 'Enable Feature',
    Tooltip = 'Toggle the main feature on or off',
    Default = true,
    Callback = function(value)
        print('[Toggle] Feature enabled:', value)
    end
})

-- Add color pickers to the toggle
FeatureToggle:AddColorPicker('PrimaryColor', {
    Title = 'Primary Color',
    Default = Color3.new(1, 0, 0), -- Red
    Transparency = 0,
    Callback = function(value, transparency)
        print('[ColorPicker] Primary color:', value, 'Transparency:', transparency)
    end
})

FeatureToggle:AddColorPicker('SecondaryColor', {
    Title = 'Secondary Color',
    Default = Color3.new(0, 1, 0), -- Green
    Transparency = 0,
    Callback = function(value, transparency)
        print('[ColorPicker] Secondary color:', value, 'Transparency:', transparency)
    end
})

-- Monitor toggle changes
Toggles.FeatureToggle:OnChanged(function()
    print('[Toggle Changed] Feature state:', Toggles.FeatureToggle.Value)
end)

-- Example of programmatically setting toggle state
Toggles.FeatureToggle:SetValue(false)

-- Buttons
local MainButton = CoreFeatures:AddButton({
    Text = 'Perform Action',
    Tooltip = 'Click to perform the main action',
    Func = function()
        print('[Button] Action triggered!')
        Library:Notify('Action executed successfully!')
    end
})

MainButton:AddButton({
    Text = 'Secondary Action',
    Tooltip = 'Double-click for secondary action',
    DoubleClick = true,
    Func = function()
        print('[Button] Secondary action triggered!')
        Library:Notify('Secondary action executed!', nil, 4590657391)
    end
})

-- Disabled button example
CoreFeatures:AddButton({
    Text = 'Disabled Action',
    Tooltip = 'This button is disabled',
    DisabledTooltip = 'Cannot interact with this button',
    Disabled = true,
    Func = function()
        print('[Button] Disabled button clicked (should not happen)!')
    end
})

-- Labels and divider
CoreFeatures:AddLabel('Status: Ready')
CoreFeatures:AddLabel('Multi-line status:\nEverything is operational!', true)
CoreFeatures:AddDivider()

-- Slider for numerical input
CoreFeatures:AddSlider('FeatureIntensity', {
    Text = 'Feature Intensity',
    Default = 2.5,
    Min = 0,
    Max = 5,
    Rounding = 1,
    Tooltip = 'Adjust the intensity of the feature',
    Callback = function(value)
        print('[Slider] Intensity set to:', value)
    end
})

-- Slider for numerical input
CoreFeatures:AddSlider('FeatureIntensity', {
    Text = 'Feature Intensity 2',
    Default = 2.5,
    Min = 0,
    Max = 5,
    Rounding = 1,
    Compact = true,
    HideMax = true,
    Tooltip = 'Adjust the intensity of the feature',
    Callback = function(value)
        print('[Slider] Intensity set to:', value)
    end
})

Options.FeatureIntensity:OnChanged(function()
    print('[Slider Changed] New intensity:', Options.FeatureIntensity.Value)
end)
Options.FeatureIntensity:SetValue(3)

-- Text input
CoreFeatures:AddInput('UserInput', {
    Text = 'Custom Input',
    Default = 'Enter text...',
    Placeholder = 'Type here',
    ClearTextOnFocus = true,
    Tooltip = 'Enter custom text for the feature',
    Callback = function(value)
        print('[Input] Text entered:', value)
    end
})

-- === Main Tab: Right Groupbox (Dropdowns) ===
local Dropdowns = Tabs.Main:AddRightGroupbox('Dropdown Options')

-- Standard dropdown
Dropdowns:AddDropdown('SelectMode', {
    Text = 'Operation Mode',
    Values = {'Normal', 'Advanced', 'Expert'},
    Default = 1,
    Tooltip = 'Select the operation mode',
    Callback = function(value)
        print('[Dropdown] Mode selected:', value)
    end
})

Options.SelectMode:SetValue('Advanced')

-- Searchable dropdown
Dropdowns:AddDropdown('SearchableOptions', {
    Text = 'Searchable Options',
    Values = {'Option1', 'Option2', 'Option3', 'Option4', 'Option5'},
    Default = 1,
    Searchable = true,
    Tooltip = 'Search through available options',
    Callback = function(value)
        print('[Dropdown] Searchable option selected:', value)
    end
})

-- Multi-select dropdown
Dropdowns:AddDropdown('MultiSelect', {
    Text = 'Multi-Select Options',
    Values = {'A', 'B', 'C', 'D'},
    Default = 1,
    Multi = true,
    Tooltip = 'Select multiple options',
    Callback = function(value)
        print('[Dropdown] Multi-select changed:')
        for key, selected in pairs(value) do
            print(key, selected)
        end
    end
})

Options.MultiSelect:SetValue({A = true, C = true})

-- Player dropdown
Dropdowns:AddDropdown('PlayerSelect', {
    SpecialType = 'Player',
    ExcludeLocalPlayer = true,
    Text = 'Select Player',
    Tooltip = 'Choose a player (excludes yourself)',
    Callback = function(value)
        print('[Dropdown] Player selected:', value)
    end
})

-- === Main Tab: Right Tabbox (Additional Features) ===
local FeatureTabs = Tabs.Main:AddRightTabbox()
local Tab1 = FeatureTabs:AddTab('Tab 1')
local Tab2 = FeatureTabs:AddTab('Tab 2')

Tab1:AddToggle('Tab1Feature', {Text = 'Tab 1 Feature', Default = false})
Tab2:AddToggle('Tab2Feature', {Text = 'Tab 2 Feature', Default = false})

-- === Main Tab: Dependency Box ===
local AdvancedSettings = Tabs.Main:AddRightGroupbox('Advanced Settings')
local EnableAdvanced = AdvancedSettings:AddToggle('EnableAdvanced', {
    Text = 'Enable Advanced Settings',
    Default = false
})

local DepBox = AdvancedSettings:AddDependencyBox()
DepBox:AddSlider('AdvancedValue', {
    Text = 'Advanced Value',
    Default = 50,
    Min = 0,
    Max = 100,
    Rounding = 0
})
DepBox:AddDropdown('AdvancedOption', {
    Text = 'Advanced Option',
    Values = {'Option A', 'Option B', 'Option C'},
    Default = 1
})

DepBox:SetupDependencies({{Toggles.EnableAdvanced, true}})

-- === UI Settings Tab ===
local MenuSettings = Tabs.Settings:AddLeftGroupbox('Menu Controls')

MenuSettings:AddToggle('ShowKeybinds', {
    Text = 'Show Keybind Menu',
    Default = Library.KeybindFrame.Visible,
    Callback = function(value)
        Library.KeybindFrame.Visible = value
    end
})

MenuSettings:AddToggle('CustomCursor', {
    Text = 'Use Custom Cursor',
    Default = true,
    Callback = function(value)
        Library.ShowCustomCursor = value
    end
})

MenuSettings:AddDivider()
MenuSettings:AddLabel('Menu Keybind'):AddKeyPicker('MenuKeybind', {
    Default = 'RightShift',
    NoUI = true,
    Text = 'Toggle Menu',
    Callback = function(value)
        print('[Keybind] Menu toggle:', value)
    end
})

MenuSettings:AddButton({
    Text = 'Unload Menu',
    Func = function()
        Library:Unload()
    end
})

-- === Watermark Setup ===
Library:SetWatermarkVisibility(true)

local function updateWatermark()
    local FPS = 60
    local FrameTimer, FrameCounter = tick(), 0
    local connection = game:GetService('RunService').RenderStepped:Connect(function()
        FrameCounter = FrameCounter + 1
        if tick() - FrameTimer >= 1 then
            FPS = FrameCounter
            FrameTimer = tick()
            FrameCounter = 0
        end
        Library:SetWatermark(('Demo Menu | %d FPS | %d ms'):format(
            math.floor(FPS),
            math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue())
        ))
    end)
    Library:OnUnload(function()
        connection:Disconnect()
        print('[System] Menu unloaded')
        Library.Unloaded = true
    end)
end
updateWatermark()

-- === Save and Theme Management ===
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({'MenuKeybind'})

ThemeManager:SetFolder('DemoMenu')
SaveManager:SetFolder('DemoMenu/Settings')
SaveManager:BuildConfigSection(Tabs.Settings)
ThemeManager:ApplyToTab(Tabs.Settings)
SaveManager:LoadAutoloadConfig()

-- === Final Notes ===
print('[System] Demo Menu loaded successfully!')
