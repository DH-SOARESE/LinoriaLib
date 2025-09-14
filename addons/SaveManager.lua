local cloneref = (cloneref or clonereference or function(instance: any) return instance end)
local httpService = cloneref(game:GetService('HttpService'))
local isfolder, isfile, listfiles = isfolder, isfile, listfiles;
local assert = function(condition, errorMessage) 
    if (not condition) then
        error(if errorMessage then errorMessage else "assert failed", 3)
    end
end

if typeof(copyfunction) == "function" then
    -- Fix is_____ functions for shitsploits, those functions should never error, only return a boolean.

    local
        isfolder_copy,
        isfile_copy,
        listfiles_copy = copyfunction(isfolder), copyfunction(isfile), copyfunction(listfiles);

    local isfolder_success, isfolder_error = pcall(function()
        return isfolder_copy("test" .. tostring(math.random(1000000, 9999999)))
    end);

    if isfolder_success == false or typeof(isfolder_error) ~= "boolean" then
        isfolder = function(folder)
            local success, data = pcall(isfolder_copy, folder)
            return (if success then data else false)
        end;

        isfile = function(file)
            local success, data = pcall(isfile_copy, file)
            return (if success then data else false)
        end;

        listfiles = function(folder)
            local success, data = pcall(listfiles_copy, folder)
            return (if success then data else {})
        end;
    end
end

local SaveManager = {} do
    SaveManager.Folder = 'Kolt HUB'
    SaveManager.SubFolder = ''
    SaveManager.Ignore = {}
    SaveManager.Library = nil
    SaveManager.Parser = {
        Toggle = {
            Save = function(idx, object)
                return { type = 'Toggle', idx = idx, value = object.Value }
            end,
            Load = function(idx, data)
                local object = SaveManager.Library.Toggles[idx]
                if object and object.Value ~= data.value then
                    object:SetValue(data.value)
                end
            end,
        },
        Slider = {
            Save = function(idx, object)
                return { type = 'Slider', idx = idx, value = tostring(object.Value) }
            end,
            Load = function(idx, data)
                local object = SaveManager.Library.Options[idx]
                if object and object.Value ~= data.value then
                    object:SetValue(data.value)
                end
            end,
        },
        Dropdown = {
            Save = function(idx, object)
                return { type = 'Dropdown', idx = idx, value = object.Value, multi = object.Multi }
            end,
            Load = function(idx, data)
                local object = SaveManager.Library.Options[idx]
                if object and object.Value ~= data.value then
                    object:SetValue(data.value)
                end
            end,
        },
        ColorPicker = {
            Save = function(idx, object)
                return { type = 'ColorPicker', idx = idx, value = object.Value:ToHex(), transparency = object.Transparency }
            end,
            Load = function(idx, data)
                if SaveManager.Library.Options[idx] then
                    SaveManager.Library.Options[idx]:SetValueRGB(Color3.fromHex(data.value), data.transparency)
                end
            end,
        },
        KeyPicker = {
            Save = function(idx, object)
                return { type = 'KeyPicker', idx = idx, mode = object.Mode, key = object.Value }
            end,
            Load = function(idx, data)
                if SaveManager.Library.Options[idx] then
                    SaveManager.Library.Options[idx]:SetValue({ data.key, data.mode })
                end
            end,
        },
        Input = {
            Save = function(idx, object)
                return { type = 'Input', idx = idx, text = object.Value }
            end,
            Load = function(idx, data)
                local object = SaveManager.Library.Options[idx]
                if object and object.Value ~= data.text and type(data.text) == 'string' then
                    SaveManager.Library.Options[idx]:SetValue(data.text)
                end
            end,
        },
    }

    function SaveManager:SetLibrary(library)
        self.Library = library
    end

    function SaveManager:IgnoreThemeSettings()
        self:SetIgnoreIndexes({
            "BackgroundColor", "MainColor", "AccentColor", "OutlineColor", "FontColor", -- themes
            "ThemeManager_ThemeList", 'ThemeManager_CustomThemeList', 'ThemeManager_CustomThemeName', -- themes
            "VideoLink",
        })
    end

    local function getSubFolder(self)
        return if self.SubFolder == "" then "global" else self.SubFolder
    end

    local function getSettingsPath(self)
        local sub = getSubFolder(self)
        return self.Folder .. "/" .. sub .. "/settings"
    end

    --// Folders \\--
    function SaveManager:CheckSubFolder(createFolder)
        local sub = getSubFolder(self)
        local settingsPath = self.Folder .. "/" .. sub .. "/settings"

        if createFolder then
            local rootPath = self.Folder
            local subPath = self.Folder .. "/" .. sub

            if not isfolder(rootPath) then
                makefolder(rootPath)
            end
            if not isfolder(subPath) then
                makefolder(subPath)
            end
            if not isfolder(settingsPath) then
                makefolder(settingsPath)
            end
        end

        return true
    end

    function SaveManager:GetPaths()
        local paths = {}

        local parts = self.Folder:split('/')
        for idx = 1, #parts do
            local path = table.concat(parts, '/', 1, idx)
            if not table.find(paths, path) then paths[#paths + 1] = path end
        end

        paths[#paths + 1] = self.Folder .. '/themes'

        local sub = getSubFolder(self)
        local subPath = self.Folder .. "/" .. sub
        local settingsPath = subPath .. "/settings"

        parts = subPath:split('/')
        for idx = 1, #parts do
            local path = table.concat(parts, '/', 1, idx)
            if not table.find(paths, path) then paths[#paths + 1] = path end
        end

        parts = settingsPath:split('/')
        for idx = 1, #parts do
            local path = table.concat(parts, '/', 1, idx)
            if not table.find(paths, path) then paths[#paths + 1] = path end
        end

        return paths
    end

    function SaveManager:BuildFolderTree()
        local paths = self:GetPaths()

        for i = 1, #paths do
            local str = paths[i]
            if isfolder(str) then continue end

            makefolder(str)
        end
    end

    function SaveManager:CheckFolderTree()
        if isfolder(self.Folder) then return end
        SaveManager:BuildFolderTree()

        task.wait(0.1)
    end

    function SaveManager:SetIgnoreIndexes(list)
        for _, key in next, list do
            self.Ignore[key] = true
        end
    end

    function SaveManager:SetFolder(folder)
        self.Folder = folder;
        self:BuildFolderTree()
    end

    function SaveManager:SetSubFolder(folder)
        self.SubFolder = folder or "";
        self:BuildFolderTree()
    end

    --// Save, Load, Delete, Refresh \\--
    function SaveManager:Save(name)
        if (not name) then
            return false, 'no config file is selected'
        end
        SaveManager:CheckFolderTree()

        local sub = getSubFolder(self)
        local fullPath = self.Folder .. '/' .. sub .. '/settings/' .. name .. '.json'

        local data = {
            objects = {}
        }

        for idx, toggle in next, self.Library.Toggles do
            if not toggle.Type then continue end
            if not self.Parser[toggle.Type] then continue end
            if self.Ignore[idx] then continue end

            table.insert(data.objects, self.Parser[toggle.Type].Save(idx, toggle))
        end

        for idx, option in next, self.Library.Options do
            if not option.Type then continue end
            if not self.Parser[option.Type] then continue end
            if self.Ignore[idx] then continue end

            table.insert(data.objects, self.Parser[option.Type].Save(idx, option))
        end

        local success, encoded = pcall(httpService.JSONEncode, httpService, data)
        if not success then
            return false, 'failed to encode data'
        end

        writefile(fullPath, encoded)
        return true
    end

    function SaveManager:Load(name)
        if (not name) then
            return false, 'no config file is selected'
        end
        SaveManager:CheckFolderTree()

        local sub = getSubFolder(self)
        local file = self.Folder .. '/' .. sub .. '/settings/' .. name .. '.json'

        if not isfile(file) then return false, 'invalid file' end

        local success, decoded = pcall(httpService.JSONDecode, httpService, readfile(file))
        if not success then return false, 'decode error' end

        for _, option in next, decoded.objects do
            if not option.type then continue end
            if not self.Parser[option.type] then continue end

            task.spawn(self.Parser[option.type].Load, option.idx, option) -- task.spawn() so the config loading wont get stuck.
        end

        return true
    end

    function SaveManager:Delete(name)
        if (not name) then
            return false, 'no config file is selected'
        end

        local sub = getSubFolder(self)
        local file = self.Folder .. '/' .. sub .. '/settings/' .. name .. '.json'

        if not isfile(file) then return false, 'invalid file' end

        local success = pcall(delfile, file)
        if not success then return false, 'delete file error' end

        return true
    end

    function SaveManager:RefreshConfigList()
        local success, data = pcall(function()
            SaveManager:CheckFolderTree()

            local sub = getSubFolder(SaveManager)
            local settingsDir = SaveManager.Folder .. '/' .. sub .. '/settings'
            local list = listfiles(settingsDir)
            if typeof(list) ~= "table" then list = {} end

            local out = {}

            for i = 1, #list do
                local file = list[i]
                if file:sub(-5) == '.json' then
                    -- i hate this but it has to be done ...

                    local pos = file:find('.json', 1, true)
                    local start = pos

                    local char = file:sub(pos, pos)
                    while char ~= '/' and char ~= '\\' and char ~= '' do
                        pos = pos - 1
                        char = file:sub(pos, pos)
                    end

                    if char == '/' or char == '\\' then
                        table.insert(out, file:sub(pos + 1, start - 1))
                    end
                end
            end

            return out
        end)

        if (not success) then
            if self.Library then
                self.Library:Notify('Failed to load config list: ' .. tostring(data))
            else
                warn('Failed to load config list: ' .. tostring(data))
            end

            return {}
        end

        return data
    end

    --// Auto Load \\--
    function SaveManager:GetAutoloadConfig()
        SaveManager:CheckFolderTree()

        local sub = getSubFolder(self)
        local autoLoadPath = self.Folder .. '/' .. sub .. '/settings/autoload.txt'

        if isfile(autoLoadPath) then
            local successRead, name = pcall(readfile, autoLoadPath)
            if not successRead then
                return "None"
            end

            name = tostring(name)
            return if name == "" then "None" else name
        end

        return "None"
    end

    function SaveManager:LoadAutoloadConfig()
        SaveManager:CheckFolderTree()

        local name = self:GetAutoloadConfig()
        if name == "None" then return end

        local autoLoadPath = getSettingsPath(self) .. "/autoload.txt"

        if isfile(autoLoadPath) then
            local successRead, content = pcall(readfile, autoLoadPath)
            if not successRead then
                return self.Library:Notify('Failed to load autoload config: write file error')
            end

            name = tostring(content):gsub("\n", ""):gsub("\r", "")

            local success, err = self:Load(name)
            if not success then
                return self.Library:Notify('Failed to load autoload config: ' .. err)
            end

            self.Library:Notify(string.format('Auto loaded config %q', name))
        end
    end

    function SaveManager:SaveAutoloadConfig(name)
        SaveManager:CheckFolderTree()

        local sub = getSubFolder(self)
        local autoLoadPath = self.Folder .. '/' .. sub .. '/settings/autoload.txt'

        local success = pcall(writefile, autoLoadPath, name)
        if not success then return false, 'write file error' end

        return true, ""
    end

    function SaveManager:DeleteAutoLoadConfig()
        SaveManager:CheckFolderTree()

        local sub = getSubFolder(self)
        local autoLoadPath = self.Folder .. '/' .. sub .. '/settings/autoload.txt'

        local success = pcall(delfile, autoLoadPath)
        if not success then return false, 'delete file error' end

        return true, ""
    end

    --// GUI \\--
    function SaveManager:BuildConfigSection(tab)
        assert(self.Library, 'SaveManager:BuildConfigSection -> Must set SaveManager.Library')

        local section = tab:AddRightGroupbox('Configuration')

        section:AddInput('SaveManager_ConfigName',    { Text = 'Config name' })
        section:AddButton('Create config', function()
            local name = self.Library.Options.SaveManager_ConfigName.Value

            if name:gsub(' ', '') == '' then
                return self.Library:Notify('Invalid config name (empty)', 2)
            end

            local success, err = self:Save(name)
            if not success then
                return self.Library:Notify('Failed to create config: ' .. err)
            end

            self.Library:Notify(string.format('Created config %q', name))

            self.Library.Options.SaveManager_ConfigList:SetValues(self:RefreshConfigList())
            self.Library.Options.SaveManager_ConfigList:SetValue(nil)
        end)

        section:AddDivider()

        section:AddDropdown('SaveManager_ConfigList', { Text = 'Config list', Values = self:RefreshConfigList(), AllowNull = true })
        section:AddButton('Load config', function()
            local name = self.Library.Options.SaveManager_ConfigList.Value

            local success, err = self:Load(name)
            if not success then
                return self.Library:Notify('Failed to load config: ' .. err)
            end

            self.Library:Notify(string.format('Loaded config %q', name))
        end)
        section:AddButton('Overwrite config', function()
            local name = self.Library.Options.SaveManager_ConfigList.Value

            local success, err = self:Save(name)
            if not success then
                return self.Library:Notify('Failed to overwrite config: ' .. err)
            end

            self.Library:Notify(string.format('Overwrote config %q', name))
        end)

        section:AddButton('Delete config', function()
            local name = self.Library.Options.SaveManager_ConfigList.Value

            local success, err = self:Delete(name)
            if not success then
                return self.Library:Notify('Failed to delete config: ' .. err)
            end

            self.Library:Notify(string.format('Deleted config %q', name))
            self.Library.Options.SaveManager_ConfigList:SetValues(self:RefreshConfigList())
            self.Library.Options.SaveManager_ConfigList:SetValue(nil)
        end)

        section:AddButton('Refresh list', function()
            self.Library.Options.SaveManager_ConfigList:SetValues(self:RefreshConfigList())
            self.Library.Options.SaveManager_ConfigList:SetValue(nil)
        end)

        section:AddButton('Set as autoload', function()
            local name = self.Library.Options.SaveManager_ConfigList.Value

            local success, err = self:SaveAutoloadConfig(name)
            if not success then
                return self.Library:Notify('Failed to set autoload config: ' .. err)
            end

            self.AutoloadStatusLabel:SetText('Autoload configuration: ' .. (name or 'None'))
            self.Library:Notify(string.format('Set %q to auto load', name))
        end)
        section:AddButton('Reset autoload', function()
            local success, err = self:DeleteAutoLoadConfig()
            if not success then
                return self.Library:Notify('Failed to set autoload config: ' .. err)
            end

            self.Library:Notify('Autoload set to None')
            self.AutoloadStatusLabel:SetText('Autoload configuration: None')
        end)

        self.AutoloadStatusLabel = section:AddLabel("Autoload configuration: " .. self:GetAutoloadConfig())
        self:LoadAutoloadConfig()

        self:SetIgnoreIndexes({ 'SaveManager_ConfigList', 'SaveManager_ConfigName' })
    end

    SaveManager:BuildFolderTree()
end

return SaveManager
