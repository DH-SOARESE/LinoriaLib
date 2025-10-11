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
    ['BBot'] = {2, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"1a1a1e","AccentColor":"8b5cf6","BackgroundColor":"0f0f12","OutlineColor":"2d2d35"}')},
    ['Fatality'] = {3, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"1e1538","AccentColor":"e11d48","BackgroundColor":"150f2a","OutlineColor":"2d2554"}')},
    ['Jester'] = {4, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"1f1f23","AccentColor":"f43f5e","BackgroundColor":"18181b","OutlineColor":"3f3f46"}')},
    ['Mint'] = {5, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"1a1f1d","AccentColor":"10b981","BackgroundColor":"111614","OutlineColor":"2d3631"}')},
    ['Tokyo Night'] = {6, httpService:JSONDecode('{"FontColor":"c0caf5","MainColor":"1a1b26","AccentColor":"7aa2f7","BackgroundColor":"16161e","OutlineColor":"292e42"}')},
    ['Ubuntu'] = {7, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"2c2c2c","AccentColor":"ff6b35","BackgroundColor":"1e1e1e","OutlineColor":"0e0e0e"}')},
    ['Quartz'] = {8, httpService:JSONDecode('{"FontColor":"e8e8e8","MainColor":"1e1e2e","AccentColor":"89b4fa","BackgroundColor":"181825","OutlineColor":"313244"}')},

    -- Neon & Cyberpunk Themes
    ['Cyber Neon'] = {9, httpService:JSONDecode('{"FontColor":"00ffff","MainColor":"0a0a0f","AccentColor":"ff00ff","BackgroundColor":"050508","OutlineColor":"1a1a2e"}')},
    ['Electric Dream'] = {10, httpService:JSONDecode('{"FontColor":"f0ff00","MainColor":"1a0f2e","AccentColor":"ff006e","BackgroundColor":"120a21","OutlineColor":"2e1f42"}')},
    ['Neon Pulse'] = {11, httpService:JSONDecode('{"FontColor":"00ffc8","MainColor":"0d0d12","AccentColor":"ff3864","BackgroundColor":"070709","OutlineColor":"1a1a24"}')},

    -- Natural & Organic Themes
    ['Sunset Glow'] = {12, httpService:JSONDecode('{"FontColor":"fff5eb","MainColor":"2b1e13","AccentColor":"fb923c","BackgroundColor":"1c1410","OutlineColor":"3d2d1f"}')},
    ['Ocean Breeze'] = {13, httpService:JSONDecode('{"FontColor":"e0f2fe","MainColor":"0c1821","AccentColor":"06b6d4","BackgroundColor":"07111a","OutlineColor":"172532"}')},
    ['Forest Mist'] = {14, httpService:JSONDecode('{"FontColor":"ecfdf5","MainColor":"0f1d14","AccentColor":"34d399","BackgroundColor":"0a140e","OutlineColor":"1a2f21"}')},
    ['Cherry Blossom'] = {15, httpService:JSONDecode('{"FontColor":"fdf2f8","MainColor":"2d1a24","AccentColor":"f472b6","BackgroundColor":"1f1119","OutlineColor":"3d2531"}')},

    -- Dark & Intense Themes
    ['Blood Moon'] = {16, httpService:JSONDecode('{"FontColor":"fee2e2","MainColor":"1f0a0a","AccentColor":"dc2626","BackgroundColor":"150707","OutlineColor":"3f0f0f"}')},
    ['Midnight Void'] = {17, httpService:JSONDecode('{"FontColor":"e4e4e7","MainColor":"09090b","AccentColor":"6366f1","BackgroundColor":"000000","OutlineColor":"18181b"}')},
    ['Shadow Realm'] = {18, httpService:JSONDecode('{"FontColor":"e0e7ff","MainColor":"1e1b29","AccentColor":"a855f7","BackgroundColor":"151320","OutlineColor":"2d2a3d"}')},

    -- Premium & Elegant Themes
    ['Royal Gold'] = {19, httpService:JSONDecode('{"FontColor":"fef3c7","MainColor":"2d1f0f","AccentColor":"f59e0b","BackgroundColor":"1f1508","OutlineColor":"442d14"}')},
    ['Diamond Luxury'] = {20, httpService:JSONDecode('{"FontColor":"f0f9ff","MainColor":"1e293b","AccentColor":"38bdf8","BackgroundColor":"0f172a","OutlineColor":"334155"}')},
    ['Platinum Elite'] = {21, httpService:JSONDecode('{"FontColor":"f8fafc","MainColor":"1e293b","AccentColor":"cbd5e1","BackgroundColor":"0f172a","OutlineColor":"334155"}')},

    -- Pastel & Soft Themes
    ['Cotton Candy'] = {22, httpService:JSONDecode('{"FontColor":"fdf4ff","MainColor":"322640","AccentColor":"e879f9","BackgroundColor":"2e1c3d","OutlineColor":"4a3354"}')},
    ['Lavender Dreams'] = {23, httpService:JSONDecode('{"FontColor":"f5f3ff","MainColor":"2e2639","AccentColor":"c084fc","BackgroundColor":"231d2e","OutlineColor":"3d3449"}')},
    ['Mint Cream'] = {24, httpService:JSONDecode('{"FontColor":"f0fdf4","MainColor":"1a2e20","AccentColor":"4ade80","BackgroundColor":"142218","OutlineColor":"2d4030"}')},

    -- Professional Themes
    ['Carbon Fiber'] = {25, httpService:JSONDecode('{"FontColor":"d4d4d8","MainColor":"18181b","AccentColor":"71717a","BackgroundColor":"09090b","OutlineColor":"27272a"}')},
    ['Arctic Storm'] = {26, httpService:JSONDecode('{"FontColor":"f0f9ff","MainColor":"1e3a4f","AccentColor":"0ea5e9","BackgroundColor":"0c1e2e","OutlineColor":"2d4f66"}')},
    ['Phoenix Fire'] = {27, httpService:JSONDecode('{"FontColor":"fff7ed","MainColor":"2d1a0f","AccentColor":"f97316","BackgroundColor":"1c1008","OutlineColor":"442818"}')},

    -- Classic Modern Themes
    ['Solarized Dark'] = {28, httpService:JSONDecode('{"FontColor":"839496","MainColor":"073642","AccentColor":"268bd2","BackgroundColor":"002b36","OutlineColor":"0d4a59"}')},
    ['Dracula Modern'] = {29, httpService:JSONDecode('{"FontColor":"f8f8f2","MainColor":"44475a","AccentColor":"ff79c6","BackgroundColor":"282a36","OutlineColor":"6272a4"}')},
    ['Monokai Pro'] = {30, httpService:JSONDecode('{"FontColor":"fcfcfa","MainColor":"2d2a2e","AccentColor":"ff6188","BackgroundColor":"221f22","OutlineColor":"5b595c"}')}
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
