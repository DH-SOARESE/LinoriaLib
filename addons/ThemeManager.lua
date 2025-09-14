-- Utility Functions and Fixes
local cloneref = (cloneref or clonereference or function(instance) return instance end)
local httpService = cloneref(game:GetService('HttpService'))
local httprequest = (syn and syn.request) or request or http_request or (http and http.request)
local getassetfunc = getcustomasset or getsynasset
local isfolder, isfile, listfiles = isfolder, isfile, listfiles
local assert = function(condition, errorMessage)
    if not condition then
        error(errorMessage or "assert failed", 3)
    end
end

-- String split utility (if not available)
local function split(str, delimiter)
    local result = {}
    local from = 1
    local delim_from, delim_to = string.find(str, delimiter, from)
    while delim_from do
        table.insert(result, string.sub(str, from, delim_from - 1))
        from = delim_to + 1
        delim_from, delim_to = string.find(str, delimiter, from)
    end
    table.insert(result, string.sub(str, from))
    return result
end

-- Fix isfolder, isfile, listfiles for exploits that may error
if typeof(copyfunction) == "function" then
    local isfolder_copy = copyfunction(isfolder)
    local isfile_copy = copyfunction(isfile)
    local listfiles_copy = copyfunction(listfiles)

    local isfolder_success, isfolder_error = pcall(isfolder_copy, "test" .. tostring(math.random(1000000, 9999999)))

    if not isfolder_success or typeof(isfolder_error) ~= "boolean" then
        isfolder = function(folder)
            local success, data = pcall(isfolder_copy, folder)
            return success and data or false
        end

        isfile = function(file)
            local success, data = pcall(isfile_copy, file)
            return success and data or false
        end

        listfiles = function(folder)
            local success, data = pcall(listfiles_copy, folder)
            return success and data or {}
        end
    end
end

-- Background Video Application
local function ApplyBackgroundVideo(videoLink, library)
    if typeof(videoLink) ~= "string" or not (getassetfunc and writefile and readfile and isfile) or not library.InnerVideoBackground then
        return
    end

    local videoInstance = library.InnerVideoBackground
    local extension = videoLink:match(".*/(.-)$") or ""
    local filename = string.sub(extension, 1, #extension - 5) -- Remove .webm
    local _, domain = videoLink:match("^(https?://)([^/]+)")
    domain = domain or ""

    if videoLink == "" then
        videoInstance:Pause()
        videoInstance.Video = ""
        videoInstance.Visible = false
        return
    end

    if #extension > 5 and string.sub(extension, -5) ~= ".webm" then
        return
    end

    local videoFile = library.ThemeManager.Folder .. "/themes/" .. string.sub(domain .. filename, 1, 249) .. ".webm"
    if not isfile(videoFile) then
        local success, requestRes = pcall(httprequest, { Url = videoLink, Method = 'GET' })
        if not (success and typeof(requestRes) == "table" and typeof(requestRes.Body) == "string") then
            return
        end
        writefile(videoFile, requestRes.Body)
    end

    videoInstance.Video = getassetfunc(videoFile)
    videoInstance.Visible = true
    videoInstance:Play()
end

-- ThemeManager Module
local ThemeManager = {}
ThemeManager.Folder = 'LinoriaLibSettings'
ThemeManager.Library = nil

-- Built-in Themes (Organized by Category)
ThemeManager.BuiltInThemes = {
    -- Classic Themes
    ['Default'] = {1, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"1e1e1e","AccentColor":"0021ff","BackgroundColor":"232323","OutlineColor":"141414"}')},
    ['BBot'] = {2, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"1e1e1e","AccentColor":"7e48a3","BackgroundColor":"232323","OutlineColor":"141414"}')},
    ['Fatality'] = {3, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"1e1842","AccentColor":"c50754","BackgroundColor":"191335","OutlineColor":"3c355d"}')},
    ['Jester'] = {4, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"242424","AccentColor":"db4467","BackgroundColor":"1c1c1c","OutlineColor":"373737"}')},
    ['Mint'] = {5, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"242424","AccentColor":"3db488","BackgroundColor":"1c1c1c","OutlineColor":"373737"}')},
    ['Tokyo Night'] = {6, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"191925","AccentColor":"6759b3","BackgroundColor":"16161f","OutlineColor":"323232"}')},
    ['Ubuntu'] = {7, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"3e3e3e","AccentColor":"e2581e","BackgroundColor":"323232","OutlineColor":"191919"}')},
    ['Quartz'] = {8, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"232330","AccentColor":"426e87","BackgroundColor":"1d1b26","OutlineColor":"27232f"}')},

    -- Neon & Cyberpunk Themes
    ['Cyber Neon'] = {9, httpService:JSONDecode('{"FontColor":"00fff7","MainColor":"0d0d0d","AccentColor":"ff00ff","BackgroundColor":"121212","OutlineColor":"1a1a1a"}')},
    ['Electric Dream'] = {10, httpService:JSONDecode('{"FontColor":"e6ff00","MainColor":"1a0f2e","AccentColor":"ff0080","BackgroundColor":"0f0a1a","OutlineColor":"2e1f42"}')},
    ['Neon Pulse'] = {11, httpService:JSONDecode('{"FontColor":"00ffaa","MainColor":"0f0f0f","AccentColor":"ff4400","BackgroundColor":"050505","OutlineColor":"1f1f1f"}')},

    -- Natural & Organic Themes
    ['Sunset Glow'] = {12, httpService:JSONDecode('{"FontColor":"fff2e6","MainColor":"2b1d0e","AccentColor":"ff914d","BackgroundColor":"1a1207","OutlineColor":"332417"}')},
    ['Ocean Breeze'] = {13, httpService:JSONDecode('{"FontColor":"e6faff","MainColor":"0e1f2b","AccentColor":"00c2ff","BackgroundColor":"09141a","OutlineColor":"133040"}')},
    ['Forest Mist'] = {14, httpService:JSONDecode('{"FontColor":"eaffea","MainColor":"0f1a12","AccentColor":"00ff88","BackgroundColor":"08100b","OutlineColor":"123322"}')},
    ['Cherry Blossom'] = {15, httpService:JSONDecode('{"FontColor":"fff0f5","MainColor":"2d1b24","AccentColor":"ff69b4","BackgroundColor":"1f1319","OutlineColor":"3d2631"}')},

    -- Dark & Intense Themes
    ['Blood Moon'] = {16, httpService:JSONDecode('{"FontColor":"ffcccc","MainColor":"1a0b0b","AccentColor":"ff1a1a","BackgroundColor":"120808","OutlineColor":"330000"}')},
    ['Midnight Void'] = {17, httpService:JSONDecode('{"FontColor":"b3b3b3","MainColor":"0a0a0a","AccentColor":"4d4dff","BackgroundColor":"000000","OutlineColor":"1a1a1a"}')},
    ['Shadow Realm'] = {18, httpService:JSONDecode('{"FontColor":"cccccc","MainColor":"1a1a2e","AccentColor":"9d4edd","BackgroundColor":"16213e","OutlineColor":"0f3460"}')},

    -- Premium & Elegant Themes
    ['Royal Gold'] = {19, httpService:JSONDecode('{"FontColor":"ffeaa7","MainColor":"2d1810","AccentColor":"fdcb6e","BackgroundColor":"1e1008","OutlineColor":"3d2615"}')},
    ['Diamond Luxury'] = {20, httpService:JSONDecode('{"FontColor":"f0f0f0","MainColor":"2a2a2a","AccentColor":"87ceeb","BackgroundColor":"1f1f1f","OutlineColor":"3a3a3a"}')},
    ['Platinum Elite'] = {21, httpService:JSONDecode('{"FontColor":"e8e8e8","MainColor":"2c2c2c","AccentColor":"c0c0c0","BackgroundColor":"202020","OutlineColor":"383838"}')},

    -- Pastel & Soft Themes
    ['Cotton Candy'] = {22, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"40384a","AccentColor":"ff9ff3","BackgroundColor":"2e2933","OutlineColor":"5a4d66"}')},
    ['Lavender Dreams'] = {23, httpService:JSONDecode('{"FontColor":"f5f3ff","MainColor":"2d2838","AccentColor":"b19cd9","BackgroundColor":"201b2b","OutlineColor":"3d3347"}')},
    ['Mint Cream'] = {24, httpService:JSONDecode('{"FontColor":"f0fff0","MainColor":"1e2d1e","AccentColor":"98fb98","BackgroundColor":"152015","OutlineColor":"2d3d2d"}')},

    -- Professional Themes
    ['Carbon Fiber'] = {25, httpService:JSONDecode('{"FontColor":"cfcfcf","MainColor":"1a1a1a","AccentColor":"808080","BackgroundColor":"0f0f0f","OutlineColor":"2b2b2b"}')},
    ['Arctic Storm'] = {26, httpService:JSONDecode('{"FontColor":"e6f3ff","MainColor":"1a252e","AccentColor":"5bc0de","BackgroundColor":"0f1a21","OutlineColor":"243540"}')},
    ['Phoenix Fire'] = {27, httpService:JSONDecode('{"FontColor":"ffe6cc","MainColor":"2e1a0f","AccentColor":"ff6b35","BackgroundColor":"1a0f08","OutlineColor":"3d2817"}')},

    -- Classic Modern Themes
    ['Solarized Dark'] = {28, httpService:JSONDecode('{"FontColor":"93a1a1","MainColor":"002b36","AccentColor":"268bd2","BackgroundColor":"001f27","OutlineColor":"073642"}')},
    ['Dracula Modern'] = {29, httpService:JSONDecode('{"FontColor":"f8f8f2","MainColor":"44475a","AccentColor":"ff79c6","BackgroundColor":"282a36","OutlineColor":"6272a4"}')},
    ['Monokai Pro'] = {30, httpService:JSONDecode('{"FontColor":"fcfcfa","MainColor":"403e41","AccentColor":"ff6188","BackgroundColor":"2d2a2e","OutlineColor":"5b595c"}')}
}

-- Core Methods
function ThemeManager:SetLibrary(library)
    self.Library = library
end

function ThemeManager:GetPaths()
    local paths = {}
    local parts = split(self.Folder, '/')
    for idx = 1, #parts do
        table.insert(paths, table.concat(parts, '/', 1, idx))
    end
    table.insert(paths, self.Folder .. '/themes')
    return paths
end

function ThemeManager:BuildFolderTree()
    local paths = self:GetPaths()
    for _, path in ipairs(paths) do
        if not isfolder(path) then
            makefolder(path)
        end
    end
end

function ThemeManager:CheckFolderTree()
    if not isfolder(self.Folder) then
        self:BuildFolderTree()
        task.wait(0.1)
    end
end

function ThemeManager:SetFolder(folder)
    self.Folder = folder
    self:BuildFolderTree()
end

function ThemeManager:ApplyTheme(theme)
    local customThemeData = self:GetCustomTheme(theme)
    local data = customThemeData or self.BuiltInThemes[theme]
    if not data then return end

    local scheme = customThemeData or data[2]
    for idx, col in pairs(scheme) do
        if idx == "VideoLink" then
            self.Library[idx] = col
            if self.Library.Options[idx] then
                self.Library.Options[idx]:SetValue(col)
            end
            ApplyBackgroundVideo(col, self.Library)
        else
            self.Library[idx] = Color3.fromHex(col)
            if self.Library.Options[idx] then
                self.Library.Options[idx]:SetValueRGB(Color3.fromHex(col))
            end
        end
    end

    self:ThemeUpdate()
end

function ThemeManager:ThemeUpdate()
    if self.Library.InnerVideoBackground then
        self.Library.InnerVideoBackground.Visible = false
    end

    local options = {"FontColor", "MainColor", "AccentColor", "BackgroundColor", "OutlineColor", "VideoLink"}
    for _, field in ipairs(options) do
        if self.Library.Options and self.Library.Options[field] then
            if field == "VideoLink" then
                self.Library[field] = self.Library.Options[field].Value
                ApplyBackgroundVideo(self.Library.Options[field].Value, self.Library)
            else
                self.Library[field] = self.Library.Options[field].Value
            end
        end
    end

    self.Library.AccentColorDark = self.Library:GetDarkerColor(self.Library.AccentColor)
    self.Library:UpdateColorsUsingRegistry()
end

-- Theme Management
function ThemeManager:GetCustomTheme(file)
    local path = self.Folder .. '/themes/' .. file .. '.json'
    if not isfile(path) then return nil end

    local data = readfile(path)
    local success, decoded = pcall(httpService.JSONDecode, httpService, data)
    return success and decoded or nil
end

function ThemeManager:LoadDefault()
    local theme = 'Default'
    local defaultPath = self.Folder .. '/themes/default.txt'
    local content = isfile(defaultPath) and readfile(defaultPath)

    local isDefault = true
    if content then
        if self.BuiltInThemes[content] or self:GetCustomTheme(content) then
            theme = content
            isDefault = self.BuiltInThemes[content] ~= nil
        end
    elseif self.BuiltInThemes[self.DefaultTheme] then
        theme = self.DefaultTheme
    end

    if isDefault then
        self.Library.Options.ThemeManager_ThemeList:SetValue(theme)
    else
        self:ApplyTheme(theme)
    end
end

function ThemeManager:SaveDefault(theme)
    writefile(self.Folder .. '/themes/default.txt', theme)
end

function ThemeManager:SaveCustomTheme(file)
    if file:gsub(' ', '') == '' then
        return self.Library:Notify('Invalid file name for theme (empty)', 3)
    end

    local theme = {}
    local fields = {"FontColor", "MainColor", "AccentColor", "BackgroundColor", "OutlineColor", "VideoLink"}

    for _, field in ipairs(fields) do
        if field == "VideoLink" then
            theme[field] = self.Library.Options[field].Value
        else
            theme[field] = self.Library.Options[field].Value:ToHex()
        end
    end

    writefile(self.Folder .. '/themes/' .. file .. '.json', httpService:JSONEncode(theme))
end

function ThemeManager:Delete(name)
    if not name then return false, 'no config file is selected' end

    local file = self.Folder .. '/themes/' .. name .. '.json'
    if not isfile(file) then return false, 'invalid file' end

    local success = pcall(delfile, file)
    return success, success and nil or 'delete file error'
end

function ThemeManager:ReloadCustomThemes()
    local list = listfiles(self.Folder .. '/themes') or {}
    local out = {}

    for _, file in ipairs(list) do
        if file:match('%.json$') then
            local pos = file:find('.json', 1, true)
            if pos then
                local start = pos
                local char = file:sub(pos, pos)
                while char ~= '/' and char ~= '\\' and char ~= '' do
                    pos = pos - 1
                    char = file:sub(pos, pos)
                end
                if char == '/' or char == '\\' then
                    table.insert(out, file:sub(pos + 1, start - 6)) -- Remove .json
                end
            end
        end
    end

    return out
end

-- GUI Creation
function ThemeManager:CreateThemeManager(groupbox)
    groupbox:AddLabel('Background color'):AddColorPicker('BackgroundColor', {Default = self.Library.BackgroundColor})
    groupbox:AddLabel('Main color'):AddColorPicker('MainColor', {Default = self.Library.MainColor})
    groupbox:AddLabel('Accent color'):AddColorPicker('AccentColor', {Default = self.Library.AccentColor})
    groupbox:AddLabel('Outline color'):AddColorPicker('OutlineColor', {Default = self.Library.OutlineColor})
    groupbox:AddLabel('Font color'):AddColorPicker('FontColor', {Default = self.Library.FontColor})

    local ThemesArray = {}
    for name in pairs(self.BuiltInThemes) do
        table.insert(ThemesArray, name)
    end
    table.sort(ThemesArray, function(a, b) return self.BuiltInThemes[a][1] < self.BuiltInThemes[b][1] end)

    groupbox:AddDivider()
    groupbox:AddDropdown('ThemeManager_ThemeList', {Text = 'Theme list', Values = ThemesArray, Default = 1})
    groupbox:AddButton('Set as default', function()
        self:SaveDefault(self.Library.Options.ThemeManager_ThemeList.Value)
        self.Library:Notify(string.format('Set default theme to %q', self.Library.Options.ThemeManager_ThemeList.Value))
    end)

    self.Library.Options.ThemeManager_ThemeList:OnChanged(function()
        self:ApplyTheme(self.Library.Options.ThemeManager_ThemeList.Value)
    end)

    groupbox:AddDivider()

    groupbox:AddInput('ThemeManager_CustomThemeName', {Text = 'Custom theme name'})
    groupbox:AddButton('Create theme', function()
        self:SaveCustomTheme(self.Library.Options.ThemeManager_CustomThemeName.Value)
        self.Library.Options.ThemeManager_CustomThemeList:SetValues(self:ReloadCustomThemes())
        self.Library.Options.ThemeManager_CustomThemeList:SetValue(nil)
    end)

    groupbox:AddDivider()

    groupbox:AddDropdown('ThemeManager_CustomThemeList', {Text = 'Custom themes', Values = self:ReloadCustomThemes(), AllowNull = true, Default = 1})
    groupbox:AddButton('Load theme', function()
        local name = self.Library.Options.ThemeManager_CustomThemeList.Value
        if name then
            self:ApplyTheme(name)
            self.Library:Notify(string.format('Loaded theme %q', name))
        end
    end)
    groupbox:AddButton('Overwrite theme', function()
        local name = self.Library.Options.ThemeManager_CustomThemeList.Value
        if name then
            self:SaveCustomTheme(name)
            self.Library:Notify(string.format('Overwrote theme %q', name))
        end
    end)
    groupbox:AddButton('Delete theme', function()
        local name = self.Library.Options.ThemeManager_CustomThemeList.Value
        if name then
            local success, err = self:Delete(name)
            if not success then
                return self.Library:Notify('Failed to delete theme: ' .. (err or 'unknown error'))
            end
            self.Library:Notify(string.format('Deleted theme %q', name))
            self.Library.Options.ThemeManager_CustomThemeList:SetValues(self:ReloadCustomThemes())
            self.Library.Options.ThemeManager_CustomThemeList:SetValue(nil)
        end
    end)
    groupbox:AddButton('Refresh list', function()
        self.Library.Options.ThemeManager_CustomThemeList:SetValues(self:ReloadCustomThemes())
        self.Library.Options.ThemeManager_CustomThemeList:SetValue(nil)
    end)
    groupbox:AddButton('Set as default', function()
        local name = self.Library.Options.ThemeManager_CustomThemeList.Value
        if name and name ~= '' then
            self:SaveDefault(name)
            self.Library:Notify(string.format('Set default theme to %q', name))
        end
    end)
    groupbox:AddButton('Reset default', function()
        local success = pcall(delfile, self.Folder .. '/themes/default.txt')
        if not success then
            return self.Library:Notify('Failed to reset default: delete file error')
        end
        self.Library:Notify('Reset default theme')
    end)

    self:LoadDefault()

    local function UpdateTheme() self:ThemeUpdate() end
    self.Library.Options.BackgroundColor:OnChanged(UpdateTheme)
    self.Library.Options.MainColor:OnChanged(UpdateTheme)
    self.Library.Options.AccentColor:OnChanged(UpdateTheme)
    self.Library.Options.OutlineColor:OnChanged(UpdateTheme)
    self.Library.Options.FontColor:OnChanged(UpdateTheme)
end

function ThemeManager:CreateGroupBox(tab)
    assert(self.Library, 'ThemeManager:CreateGroupBox -> Must set ThemeManager.Library first!')
    return tab:AddLeftGroupbox('Themes')
end

function ThemeManager:ApplyToTab(tab)
    assert(self.Library, 'ThemeManager:ApplyToTab -> Must set ThemeManager.Library first!')
    local groupbox = self:CreateGroupBox(tab)
    self:CreateThemeManager(groupbox)
end

function ThemeManager:ApplyToGroupbox(groupbox)
    assert(self.Library, 'ThemeManager:ApplyToGroupbox -> Must set ThemeManager.Library first!')
    self:CreateThemeManager(groupbox)
end

-- Initialize
ThemeManager:BuildFolderTree()
getgenv().LinoriaThemeManager = ThemeManager
return ThemeManager
