###21.11.2025
```diff
+ Added 'ResetUI' option to reset features to their original values
+ Added function to keep the UI above any other UI at all times
+ Added video feature
```

###15.11.2025
```diff
+ Floating menus can now be moved only by their title
+ Toggle clickable area now spans from the box to the end of the label text
+ Slider now allows only one active slider at a time
```

###08.11.2025
```diff
+ Customizable cursor guide added
+ ColorPicker menu can now be dragged
```

###02.11.2025
```diff
+ Tooltip is now optional
+ Fixed watermarkText error that always made it visible after disabling
+ Divider now supports text in the middle, leaving space for label
```

###25.10.2025
```diff
+ Added icon option in Tabs
+ Mobile buttons can now start on the left or right, default is left
```

### 04.08.2025
```diff
+ Fixed UpdateWarningBox resizing to invalid Y size
```

### 04.08.2025
```diff
+ Added 'LockSize' option to Tab:UpdateWarningBox
+ Added Tab:Show() and Tab:Hide() aliases
```

### 06.08.2025
```diff
+ Added support for executors that do not support getgenv
+ Added support for MouseButton3 (middle mouse button)

+ Improved KeyPicker:
    + Added unbinding functionality
    + Added proper type checking for KeyPicker:SetValue
    + Key Picker does not force auto save for every single change anymore (user needs to manually save the config now)
+ Dropdowns now resize to fit the longest item in the list

+ Fixed Key Mode menu having its Y position off by 1 pixel
+ Fixed Keybinds Menu having overflowing text
+ Fixed issue where Slider could display -0
+ Fixed sub-buttons not resizing correctly
+ Fixed alignment issues with Toggles that include Key Pickers, Color Pickers, and Dropdowns
+ Fixed loading issues in Roblox Studio
```

### 04.08.2025
```diff
+ Added 'Bottom' option to Tab:UpdateWarningBox
```

### 14.07.2025
```diff
+ Added 'AddViewport' and 'AddImage' (thanks upio)
```

### 22.6.2025
```diff
+ Added IDX to errors on element creations for easier DEBUG
```

### 27.4.2025
```diff
+ Fixed an issue where clicking on the UI would click on in-game UI
+ You can now move the UI in first person
```

### 10.3.2025
```diff
+ Callback (OnChanged) in ColorPickers now return the color and transparency (PR #31 - ty RectangularObject)
```

### 14.2.2025
```diff
+ Fixed AddValues and AddDisabledValues missing in certain Dropdowns
+ Fixed certain issues with Tooltips, Notifications and unloading (ty RectangularObject for the PR)
```

### 12.02.2025
```diff
+ Added Notification:ChangeTitle, Notification:ChangeDescription
```

### 31.01.2025
```diff
+ Added AddDropdown as an Addon
```

### 18.01.2025
```diff
+ Added ReturnInstanceInstead for Dropdowns (Will return Team/Player instance with SpecialType dropdowns if set to true)
+ Better Library:SafeCallback error messages (thanks deivid)
```

### 03.01.2025
```diff
+ Added FormatDisplayValue option for Dropdowns
+ Added MaxVisibleDropdownItems option for Dropdowns
+ Fixed Searchable dropdowns not closing properly
+ Improved Example.lua dropdowns
```

### 30.12.2024
```diff
+ Added Prefix and Suffix to Sliders (Slider:SetPrefix, Slider:SetSuffix)
+ Added Searchable Dropdowns
+ Added SubButton:SetText
+ Added Visible, Disabled, SetVisible and SetDisabled to Inputs
+ Added ExcludeLocalPlayer for Dropdowns (Player type)
+ Enabled RichText for labels
+ Fixed 'Team' type (Dropdowns) not being updated
+ Fixed 'AddTooltip' typo to 'AddToolTip'
+ OnChanged now uses SafeCallback
```
