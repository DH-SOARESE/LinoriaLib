function BaseGroupboxFuncs:AddSlider(Idx, Info)
assert(Info.Default,    string.format('AddSlider (IDX: %s): Missing default value.', tostring(Idx)));
assert(Info.Text,       string.format('AddSlider (IDX: %s): Missing slider text.', tostring(Idx)));
assert(Info.Min,        string.format('AddSlider (IDX: %s): Missing minimum value.', tostring(Idx)));
assert(Info.Max,        string.format('AddSlider (IDX: %s): Missing maximum value.', tostring(Idx)));
assert(Info.Rounding,   string.format('AddSlider (IDX: %s): Missing rounding value.', tostring(Idx)));

local Slider = {  
        Value = Info.Default;  
        Min = Info.Min;  
        Max = Info.Max;  
        Rounding = Info.Rounding;  
        MaxSize = 232;  
        Type = 'Slider';  
        Visible = if typeof(Info.Visible) == "boolean" then Info.Visible else true;  
        Disabled = if typeof(Info.Disabled) == "boolean" then Info.Disabled else false;  
        OriginalText = Info.Text; Text = Info.Text;  

        Prefix = typeof(Info.Prefix) == "string" and Info.Prefix or "";  
        Suffix = typeof(Info.Suffix) == "string" and Info.Suffix or "";  
        
        ValueTextMax = typeof(Info.ValueTextMax) == "string" and Info.ValueTextMax or "";  
        ValueTextMin = typeof(Info.ValueTextMin) == "string" and Info.ValueTextMin or "";  

        Callback = Info.Callback or function(Value) end;  
    };  

    local Blanks = {};  
    local SliderText = nil;  
    local Groupbox = self;  
    local Container = Groupbox.Container;  
    local Tooltip;  

    if not Info.Compact then  
        SliderText = Library:CreateLabel({  
            Size = UDim2.new(1, 0, 0, 10);  
            TextSize = 14;  
            Text = Info.Text;  
            TextXAlignment = Enum.TextXAlignment.Left;  
            TextYAlignment = Enum.TextYAlignment.Bottom;  
            Visible = Slider.Visible;  
            ZIndex = 5;  
            Parent = Container;  
            RichText = true;  
        });  

        table.insert(Blanks, Groupbox:AddBlank(3, Slider.Visible));  
    end  

    local SliderOuter = Library:Create('Frame', {  
        BackgroundColor3 = Color3.new(0, 0, 0);  
        BorderColor3 = Color3.new(0, 0, 0);  
        Size = UDim2.new(1, -4, 0, 13);  
        Visible = Slider.Visible;  
        ZIndex = 5;  
        Parent = Container;  
    });  

    SliderOuter:GetPropertyChangedSignal('AbsoluteSize'):Connect(function()  
        Slider.MaxSize = SliderOuter.AbsoluteSize.X - 2;  
    end);  

    Library:AddToRegistry(SliderOuter, {  
        BorderColor3 = 'Black';  
    });  

    local SliderInner = Library:Create('Frame', {  
        BackgroundColor3 = Library.MainColor;  
        BorderColor3 = Library.OutlineColor;  
        BorderMode = Enum.BorderMode.Inset;  
        Size = UDim2.new(1, 0, 1, 0);  
        ZIndex = 6;  
        Parent = SliderOuter;  
    });  

    Library:AddToRegistry(SliderInner, {  
        BackgroundColor3 = 'MainColor';  
        BorderColor3 = 'OutlineColor';  
    });  

    local Fill = Library:Create('Frame', {  
        BackgroundColor3 = Library.AccentColor;  
        BorderColor3 = Library.AccentColorDark;  
        Size = UDim2.new(0, 0, 1, 0);  
        ZIndex = 7;  
        Parent = SliderInner;  
    });  

    Library:AddToRegistry(Fill, {  
        BackgroundColor3 = 'AccentColor';  
        BorderColor3 = 'AccentColorDark';  
    });  

    local HideBorderRight = Library:Create('Frame', {  
        BackgroundColor3 = Library.AccentColor;  
        BorderSizePixel = 0;  
        Position = UDim2.new(1, 0, 0, 0);  
        Size = UDim2.new(0, 1, 1, 0);  
        ZIndex = 8;  
        Parent = Fill;  
    });  

    Library:AddToRegistry(HideBorderRight, {  
        BackgroundColor3 = 'AccentColor';  
    });  

    local DisplayLabel = Library:CreateLabel({  
        Size = UDim2.new(1, 0, 1, 0);  
        TextSize = 14;  
        Text = 'Infinite';  
        ZIndex = 9;  
        Parent = SliderInner;  
        RichText = true;  
    });  

    Library:OnHighlight(SliderOuter, SliderOuter,  
        { BorderColor3 = 'AccentColor' },  
        { BorderColor3 = 'Black' },  
        function()  
            return not Slider.Disabled;  
        end  
    );  

    if typeof(Info.Tooltip) == "string" or typeof(Info.DisabledTooltip) == "string" then  
        Tooltip = Library:AddToolTip(Info.Tooltip, Info.DisabledTooltip, SliderOuter)  
        Tooltip.Disabled = Slider.Disabled;  
    end  

    function Slider:UpdateColors()  
        if SliderText then  
            SliderText.TextColor3 = Slider.Disabled and Library.DisabledAccentColor or Color3.new(1, 1, 1);  
        end;  
        DisplayLabel.TextColor3 = Slider.Disabled and Library.DisabledAccentColor or Color3.new(1, 1, 1);  

        HideBorderRight.BackgroundColor3 = Slider.Disabled and Library.DisabledAccentColor or Library.AccentColor;  

        Fill.BackgroundColor3 = Slider.Disabled and Library.DisabledAccentColor or Library.AccentColor;  
        Fill.BorderColor3 = Slider.Disabled and Library.DisabledOutlineColor or Library.AccentColorDark;  

        Library.RegistryMap[HideBorderRight].Properties.BackgroundColor3 = Slider.Disabled and 'DisabledAccentColor' or 'AccentColor';  

        Library.RegistryMap[Fill].Properties.BackgroundColor3 = Slider.Disabled and 'DisabledAccentColor' or 'AccentColor';  
        Library.RegistryMap[Fill].Properties.BorderColor3 = Slider.Disabled and 'DisabledOutlineColor' or 'AccentColorDark';  
    end;  
      
    function Slider:Display()  
        local FormattedValue;
        
        -- Verifica se está no máximo e tem ValueTextMax definido
        if Slider.Value == Slider.Max and Slider.ValueTextMax ~= "" then
            FormattedValue = Slider.ValueTextMax;
        -- Verifica se está no mínimo e tem ValueTextMin definido
        elseif Slider.Value == Slider.Min and Slider.ValueTextMin ~= "" then
            FormattedValue = Slider.ValueTextMin;
        else
            FormattedValue = (Slider.Value == 0 or Slider.Value == -0) and "0" or tostring(Slider.Value);
        end
        
        if Info.Compact then  
            DisplayLabel.Text = string.format("%s: %s%s%s", Slider.Text, Slider.Prefix, FormattedValue, Slider.Suffix);  

        elseif Info.HideMax then  
            DisplayLabel.Text = string.format("%s%s%s", Slider.Prefix, FormattedValue, Slider.Suffix);  

        else  
            DisplayLabel.Text = string.format("%s%s%s/%s%s%s",   
                Slider.Prefix, FormattedValue, Slider.Suffix,  
                Slider.Prefix, tostring(Slider.Max), Slider.Suffix);  
        end;  

        local X = Library:MapValue(Slider.Value, Slider.Min, Slider.Max, 0, 1);  
        Fill.Size = UDim2.new(X, 0, 1, 0);  

        -- I have no idea what this is  
        HideBorderRight.Visible = not (X == 1 or X == 0);  
    end;  

    function Slider:OnChanged(Func)  
        Slider.Changed = Func;  

        if Slider.Disabled then  
            return;  
        end;  
          
        Library:SafeCallback(Func, Slider.Value);  
    end;  

    local function Round(Value)  
        if Slider.Rounding == 0 then  
            return math.floor(Value);  
        end;  

        return tonumber(string.format('%.' .. Slider.Rounding .. 'f', Value))  
    end;  

    function Slider:GetValueFromXScale(X)  
        return Round(Library:MapValue(X, 0, 1, Slider.Min, Slider.Max));  
    end;  
      
    function Slider:SetMax(Value)  
        assert(Value > Slider.Min, 'Max value cannot be less than the current min value.');  
          
        Slider.Value = math.clamp(Slider.Value, Slider.Min, Value);  
        Slider.Max = Value;  
        Slider:Display();  
    end;  
      
    function Slider:SetMin(Value)  
        assert(Value < Slider.Max, 'Min value cannot be greater than the current max value.');  

        Slider.Value = math.clamp(Slider.Value, Value, Slider.Max);  
        Slider.Min = Value;  
        Slider:Display();  
    end;  

    function Slider:SetValue(Str)  
        if Slider.Disabled then  
            return;  
        end;  

        local Num = tonumber(Str);  

        if (not Num) then  
            return;  
        end;  

        Num = math.clamp(Num, Slider.Min, Slider.Max);  

        Slider.Value = Num;  
        Slider:Display();  

        if not Slider.Disabled then  
            Library:SafeCallback(Slider.Callback, Slider.Value);  
            Library:SafeCallback(Slider.Changed, Slider.Value);  
        end;  
    end;  

    function Slider:SetVisible(Visibility)  
        Slider.Visible = Visibility;  

        if SliderText then SliderText.Visible = Slider.Visible end;  
        SliderOuter.Visible = Slider.Visible;  

        for _, Blank in pairs(Blanks) do  
            Blank.Visible = Slider.Visible  
        end  

        Groupbox:Resize();  
    end;  

    function Slider:SetDisabled(Disabled)  
        Slider.Disabled = Disabled;  

        if Tooltip then  
            Tooltip.Disabled = Disabled;  
        end  

        Slider:UpdateColors();  
    end;  

    function Slider:SetText(Text)  
        if typeof(Text) == "string" then  
            Slider.Text = Text;  

            if SliderText then SliderText.Text = Slider.Text end;  
            Slider:Display();  
        end  
    end;  

    function Slider:SetPrefix(Prefix)  
        if typeof(Prefix) == "string" then  
            Slider.Prefix = Prefix;  
            Slider:Display();  
        end  
    end;  

    function Slider:SetSuffix(Suffix)  
        if typeof(Suffix) == "string" then  
            Slider.Suffix = Suffix;  
            Slider:Display();  
        end  
    end;  

    SliderInner.InputBegan:Connect(function(Input)  
        if Slider.Disabled then  
            return;  
        end;  

        if (Input.UserInputType == Enum.UserInputType.MouseButton1 and not Library:MouseIsOverOpenedFrame()) or Input.UserInputType == Enum.UserInputType.Touch then  
            if Library.IsMobile then  
                Library.CanDrag = false;  
            end;  

            local Sides = {};  
            if Library.Window then  
                Sides = Library.Window.Tabs[Library.ActiveTab]:GetSides();  
            end  

            for _, Side in pairs(Sides) do  
                if typeof(Side) == "Instance" then  
                    if Side:IsA("ScrollingFrame") then  
                        Side.ScrollingEnabled = false;  
                    end  
                end;  
            end;  

            local mPos = Mouse.X;  
            local gPos = Fill.AbsoluteSize.X;  
            local Diff = mPos - (Fill.AbsolutePosition.X + gPos);  

            while InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1 or Enum.UserInputType.Touch) do  
                local nMPos = Mouse.X;  
                local nXOffset = math.clamp(gPos + (nMPos - mPos) + Diff, 0, Slider.MaxSize); -- what in tarnation are these variable names  
                local nXScale = Library:MapValue(nXOffset, 0, Slider.MaxSize, 0, 1);  

                local nValue = Slider:GetValueFromXScale(nXScale);  
                local OldValue = Slider.Value;  
                Slider.Value = nValue;  

                Slider:Display();  

                if nValue ~= OldValue then  
                    Library:SafeCallback(Slider.Callback, Slider.Value);  
                    Library:SafeCallback(Slider.Changed, Slider.Value);  
                end;  

                RenderStepped:Wait();  
            end;  

            if Library.IsMobile then  
                Library.CanDrag = true;  
            end;  
              
            for _, Side in pairs(Sides) do  
                if typeof(Side) == "Instance" then  
                    if Side:IsA("ScrollingFrame") then  
                        Side.ScrollingEnabled = true;  
                    end  
                end;  
            end;  

            Library:AttemptSave();  
        end;  
    end);  

    task.delay(0.1, Slider.UpdateColors, Slider);  
    Slider:Display();  
    table.insert(Blanks, Groupbox:AddBlank(Info.BlankSize or 6, Slider.Visible));  
    Groupbox:Resize();  

    Options[Idx] = Slider;  

    return Slider;  
end;
