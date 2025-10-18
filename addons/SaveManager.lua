local cloneref = (cloneref or clonereference or function(instance: any) return instance end)
local httpService = cloneref(game:GetService('HttpService'))
local isfolder, isfile, listfiles = isfolder, isfile, listfiles

local assert = function(condition, errorMessage) 
    if (not condition) then
        error(if errorMessage then errorMessage else "assert failed", 3)
    end
end

if typeof(copyfunction) == "function" then
    -- Fix is_____ functions for exploits where they might error instead of returning boolean
    local isfolder_copy, isfile_copy, listfiles_copy = copyfunction(isfolder), copyfunction(isfile), copyfunction(listfiles)

    local isfolder_success, isfolder_error = pcall(function()
        return isfolder_copy("test" .. tostring(math.random(1000000, 9999999)))
    end)

    if isfolder_success == false or typeof(isfolder_error) ~= "boolean" then
        isfolder = function(folder)
            local success, data = pcall(isfolder_copy, folder)
            return (if success then data else false)
        end

        isfile = function(file)
            local success, data = pcall(isfile_copy, file)
            return (if success then data else false)
        end

        listfiles = function(folder)
            local success, data = pcall(listfiles_copy, folder)
            return (if success then data else {})
        end
    end
end

local SaveManager = {} do
    -- === Setup ===
    SaveManager.Folder = 'LinoriaLibSettings'
    SaveManager.SubFolder = ''
    SaveManager.Ignore = {}
    SaveManager.Library = nil
    SaveManager.SaveVersion = 1  -- Added for future-proofing
    SaveManager.AutoSaveName = nil
    SaveManager.AutoSaveTask = nil

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

    -- === Folder Management ===
    function SaveManager:HasSubFolder()
        return typeof(self.SubFolder) == "string" and self.SubFolder ~= ""
    end

    function SaveManager:EnsureSubFolder()
        if not self:HasSubFolder() then return false end
        local subPath = self.Folder .. "/settings/" .. self.SubFolder
        if not isfolder(subPath) then
            makefolder(subPath)
        end
        return true
    end

    function SaveManager:GetPaths()
        local paths = {}
        local parts = self.Folder:split('/')
        for idx = 1, #parts do
            local path = table.concat(parts, '/', 1, idx)
            if not table.find(paths, path) then
                table.insert(paths, path)
            end
        end
        table.insert(paths, self.Folder .. '/themes')
        table.insert(paths, self.Folder .. '/settings')

        if self:HasSubFolder() then
            local subFolder = self.Folder .. "/settings/" .. self.SubFolder
            parts = subFolder:split('/')
            for idx = 1, #parts do
                local path = table.concat(parts, '/', 1, idx)
                if not table.find(paths, path) then
                    table.insert(paths, path)
                end
            end
        end

        return paths
    end

    function SaveManager:BuildFolderTree()
        local paths = self:GetPaths()
        for _, path in ipairs(paths) do
            if not isfolder(path) then
                makefolder(path)
            end
        end
    end

    function SaveManager:EnsureFolderTree()
        if not isfolder(self.Folder) then
            self:BuildFolderTree()
            task.wait(0.1)  -- Small delay to ensure folders are created
        end
    end

    function SaveManager:SetFolder(folder)
        self.Folder = folder
        self:BuildFolderTree()
    end

    function SaveManager:SetSubFolder(folder)
        self.SubFolder = folder
        self:BuildFolderTree()
    end

    -- === Ignore Handling ===
    function SaveManager:SetIgnoreIndexes(list)
        for _, key in ipairs(list) do
            self.Ignore[key] = true
        end
    end

    -- === Parser ===
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
                local object = SaveManager.Library.Options[idx]
                if object then
                    object:SetValueRGB(Color3.fromHex(data.value), data.transparency)
                end
            end,
        },
        KeyPicker = {
            Save = function(idx, object)
                return { type = 'KeyPicker', idx = idx, mode = object.Mode, key = object.Value }
            end,
            Load = function(idx, data)
                local object = SaveManager.Library.Options[idx]
                if object then
                    object:SetValue({ data.key, data.mode })
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
                    object:SetValue(data.text)
                end
            end,
        },
    }

    -- === Save/Load/Delete/Refresh ===
    function SaveManager:GetConfigPath(name)
        local basePath = self.Folder .. '/settings/' .. name .. '.json'
        if self:HasSubFolder() then
            self:EnsureSubFolder()
            basePath = self.Folder .. "/settings/" .. self.SubFolder .. "/" .. name .. '.json'
        end
        return basePath
    end

    function SaveManager:Save(name)
        if not name or name == '' then
            return false, 'No config name provided'
        end
        self:EnsureFolderTree()

        local fullPath = self:GetConfigPath(name)

        local data = {
            version = self.SaveVersion,  -- Added version for future compatibility
            objects = {}
        }

        for idx, toggle in pairs(self.Library.Toggles) do
            if not toggle.Type or not self.Parser[toggle.Type] or self.Ignore[idx] then continue end
            table.insert(data.objects, self.Parser[toggle.Type].Save(idx, toggle))
        end

        for idx, option in pairs(self.Library.Options) do
            if not option.Type or not self.Parser[option.Type] or self.Ignore[idx] then continue end
            table.insert(data.objects, self.Parser[option.Type].Save(idx, option))
        end

        if #data.objects == 0 then
            return false, 'No data to save (empty config)'
        end

        local success, encoded = pcall(httpService.JSONEncode, httpService, data)
        if not success then
            return false, 'Failed to encode data: ' .. tostring(encoded)
        end

        writefile(fullPath, encoded)
        return true, 'Config saved successfully'
    end

    function SaveManager:Load(name)
        if not name or name == '' then
            return false, 'No config name provided'
        end
        self:EnsureFolderTree()

        local file = self:GetConfigPath(name)
        if not isfile(file) then
            return false, 'Config file does not exist'
        end

        local success, decoded = pcall(httpService.JSONDecode, httpService, readfile(file))
        if not success then
            return false, 'Failed to decode data: ' .. tostring(decoded)
        end

        -- Check version (for future use)
        if decoded.version ~= self.SaveVersion then
            warn('Config version mismatch: ' .. tostring(decoded.version) .. ' (expected ' .. self.SaveVersion .. ')')
            -- Could add migration logic here in the future
        end

        for _, option in ipairs(decoded.objects or {}) do
            if not option.type or not self.Parser[option.type] then continue end
            task.spawn(self.Parser[option.type].Load, option.idx, option)
        end

        return true, 'Config loaded successfully'
    end

    function SaveManager:Delete(name)
        if not name or name == '' then
            return false, 'No config name provided'
        end

        local file = self:GetConfigPath(name)
        if not isfile(file) then
            return false, 'Config file does not exist'
        end

        local success, err = pcall(delfile, file)
        if not success then
            return false, 'Failed to delete file: ' .. tostring(err)
        end

        return true, 'Config deleted successfully'
    end

    function SaveManager:RefreshConfigList()
        self:EnsureFolderTree()

        local folder = self.Folder .. "/settings"
        if self:HasSubFolder() then
            folder = folder .. "/" .. self.SubFolder
        end

        local success, files = pcall(listfiles, folder)
        if not success then
            if self.Library then
                self.Library:Notify('Failed to refresh config list: ' .. tostring(files))
            else
                warn('Failed to refresh config list: ' .. tostring(files))
            end
            return {}
        end

        local configList = {}
        for _, file in ipairs(files or {}) do
            if file:sub(-5) == '.json' then
                local pos = file:find('.json', 1, true)
                local start = pos
                while pos > 0 do
                    local char = file:sub(pos, pos)
                    if char == '/' or char == '\\' then
                        break
                    end
                    pos = pos - 1
                end
                if pos > 0 then
                    table.insert(configList, file:sub(pos + 1, start - 1))
                end
            end
        end

        return configList
    end

    -- === Autoload ===
    function SaveManager:GetAutoloadPath()
        local basePath = self.Folder .. "/settings/AutoLoad.txt"
        if self:HasSubFolder() then
            self:EnsureSubFolder()
            basePath = self.Folder .. "/settings/" .. self.SubFolder .. "/AutoLoad.txt"
        end
        return basePath
    end

    function SaveManager:GetAutoloadConfig()
        self:EnsureFolderTree()

        local autoLoadPath = self:GetAutoloadPath()
        if not isfile(autoLoadPath) then
            return "none"
        end

        local success, name = pcall(readfile, autoLoadPath)
        if not success then
            return "none"
        end

        name = name:match("^%s*(.-)%s*$")  -- Trim whitespace
        return name ~= "" and name or "none"
    end

    function SaveManager:LoadAutoloadConfig()
        self:EnsureFolderTree()

        local autoLoadPath = self:GetAutoloadPath()
        if not isfile(autoLoadPath) then return end

        local successRead, name = pcall(readfile, autoLoadPath)
        if not successRead then
            if self.Library then self.Library:Notify('Failed to read autoload config: ' .. tostring(name)) end
            return
        end

        local success, err = self:Load(name)
        if not success then
            if self.Library then self.Library:Notify('Failed to load autoload config: ' .. err) end
            return
        end

        if self.Library then
            self.Library:Notify(string.format('Auto loaded config %q', name))
        end
    end

    function SaveManager:SaveAutoloadConfig(name)
        if not name or name == '' then
            return false, 'No config name provided'
        end
        self:EnsureFolderTree()

        local autoLoadPath = self:GetAutoloadPath()
        local success, err = pcall(writefile, autoLoadPath, name)
        if not success then
            return false, 'Failed to write autoload file: ' .. tostring(err)
        end

        return true, 'Autoload config saved'
    end

    function SaveManager:DeleteAutoLoadConfig()
        self:EnsureFolderTree()

        local autoLoadPath = self:GetAutoloadPath()
        if not isfile(autoLoadPath) then
            return true, 'No autoload config to delete'
        end

        local success, err = pcall(delfile, autoLoadPath)
        if not success then
            return false, 'Failed to delete autoload file: ' .. tostring(err)
        end

        return true, 'Autoload config deleted'
    end

    -- === GUI ===
    function SaveManager:BuildConfigSection(tab)
        assert(self.Library, 'SaveManager:BuildConfigSection -> Must set SaveManager.Library')

        local section = tab:AddRightGroupbox('Configuration')

        section:AddInput('SaveManager_ConfigName', { Text = 'Config name' })
        section:AddButton('Create config', function()
            local name = self.Library.Options.SaveManager_ConfigName.Value
            if not name or name:gsub(' ', '') == '' then
                return self.Library:Notify('Invalid config name (empty)', 2)
            end

            local success, msg = self:Save(name)
            if not success then
                return self.Library:Notify('Failed to create config: ' .. msg)
            end

            self.Library:Notify(string.format('Created config %q', name))
            self.Library.Options.SaveManager_ConfigList:SetValues(self:RefreshConfigList())
            self.Library.Options.SaveManager_ConfigList:SetValue(nil)
        end)

        section:AddDivider()

        section:AddDropdown('SaveManager_ConfigList', { Text = 'Config list', Values = self:RefreshConfigList(), AllowNull = true })
        section:AddButton('Load config', function()
            local name = self.Library.Options.SaveManager_ConfigList.Value
            if not name then return self.Library:Notify('No config selected') end

            local success, msg = self:Load(name)
            if not success then
                return self.Library:Notify('Failed to load config: ' .. msg)
            end

            self.Library:Notify(string.format('Loaded config %q', name))
        end)
        section:AddButton('Overwrite config', function()
            local name = self.Library.Options.SaveManager_ConfigList.Value
            if not name then return self.Library:Notify('No config selected') end

            local success, msg = self:Save(name)
            if not success then
                return self.Library:Notify('Failed to overwrite config: ' .. msg)
            end

            self.Library:Notify(string.format('Overwrote config %q', name))
        end)

        section:AddButton('Delete config', function()
            local name = self.Library.Options.SaveManager_ConfigList.Value
            if not name then return self.Library:Notify('No config selected') end

            local success, msg = self:Delete(name)
            if not success then
                return self.Library:Notify('Failed to delete config: ' .. msg)
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
            if not name then return self.Library:Notify('No config selected') end

            local success, msg = self:SaveAutoloadConfig(name)
            if not success then
                return self.Library:Notify('Failed to set autoload: ' .. msg)
            end

            self.AutoloadStatusLabel:SetText('Current autoload config: ' .. name)
            self.Library:Notify(string.format('Set %q to auto load', name))
        end)
        section:AddButton('Reset autoload', function()
            local success, msg = self:DeleteAutoLoadConfig()
            if not success then
                return self.Library:Notify('Failed to reset autoload: ' .. msg)
            end

            self.Library:Notify('Autoload set to None')
            self.AutoloadStatusLabel:SetText('Autoload configuration: None')
        end)

        self.AutoloadStatusLabel = section:AddLabel("Autoload configuration: " .. self:GetAutoloadConfig(), true)

        section:AddDivider()

        section:AddToggle('SaveManager_AutoSaveEnabled', { Text = 'Enable Auto Save', Default = false }):OnChanged(function(value)
            local option = self.Library.Options.SaveManager_AutoSaveEnabled
            if value then
                local config = self.Library.Options.SaveManager_ConfigList.Value
                if not config then
                    self.Library:Notify('No config selected for auto save')
                    option:SetValue(false)
                    return
                end
                local interval = self.Library.Options.SaveManager_AutoSaveInterval.Value
                self.AutoSaveName = config
                if self.AutoSaveTask then
                    task.cancel(self.AutoSaveTask)
                end
                self.AutoSaveTask = task.spawn(function()
                    while task.wait(interval) do
                        local success, msg = self:Save(self.AutoSaveName)
                        if not success then
                            self.Library:Notify('Auto save failed: ' .. msg)
                            option:SetValue(false)
                            break
                        else
                            self.Library:Notify('Auto saved config "' .. self.AutoSaveName .. '"')
                        end
                    end
                    self.AutoSaveTask = nil
                end)
                self.AutoSaveLabel:SetText('Auto saving to: ' .. config .. ' every ' .. interval .. 's')
            else
                if self.AutoSaveTask then
                    task.cancel(self.AutoSaveTask)
                    self.AutoSaveTask = nil
                end
                self.AutoSaveName = nil
                self.AutoSaveLabel:SetText('Auto save: disabled')
            end
        end)

        section:AddSlider('SaveManager_AutoSaveInterval', { Text = 'Auto Save Interval', Default = 60, Min = 10, Max = 300, Rounding = 0, Suffix = 's' })

        self.AutoSaveLabel = section:AddLabel('Auto save: disabled', true)

        self:LoadAutoloadConfig()  -- Uncommented to auto-load on section build
        self:SetIgnoreIndexes({ 'SaveManager_ConfigList', 'SaveManager_ConfigName', 'SaveManager_AutoSaveEnabled', 'SaveManager_AutoSaveInterval' })
    end

    SaveManager:BuildFolderTree()
end

return SaveManager
