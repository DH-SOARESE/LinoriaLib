--[[
    ╔══════════════════════════════════════════════════════════════════════════╗
    ║                         LinoriaLib v3.0.0 - Template                     ║
    ║                      Exemplo Completo e Documentado                      ║
    ╠══════════════════════════════════════════════════════════════════════════╣
    ║  Interface moderna e responsiva                                          ║
    ║  Compatível com PC e Mobile                                              ║
    ║  Sistema de salvamento automático                                        ║
    ║  Temas personalizáveis                                                   ║
    ║  Todos os componentes disponíveis                                        ║
    ╚══════════════════════════════════════════════════════════════════════════╝
]]

-- ═══════════════════════════════════════════════════════════════════════════════
-- CONFIGURAÇÃO INICIAL
-- ═══════════════════════════════════════════════════════════════════════════════

local repo = "https://raw.githubusercontent.com/DH-SOARESE/LinoriaLib/main/"

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

-- Atalhos para acesso rápido aos valores
local Options = Library.Options
local Toggles = Library.Toggles

-- ═══════════════════════════════════════════════════════════════════════════════
-- CONFIGURAÇÕES GLOBAIS
-- ═══════════════════════════════════════════════════════════════════════════════

Library.ShowToggleFrameInKeybinds = true
Library.ShowCustomCursor = true
Library.NotifySide = 'Right'

-- ═══════════════════════════════════════════════════════════════════════════════
-- CRIAÇÃO DA JANELA PRINCIPAL
-- ═══════════════════════════════════════════════════════════════════════════════

local Window = Library:CreateWindow({
    Title = 'Meu Script v1.0',
    Center = true,
    AutoShow = true,
    Resizable = true,
    ShowCustomCursor = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

-- ═══════════════════════════════════════════════════════════════════════════════
-- CRIAÇÃO DAS ABAS
-- ═══════════════════════════════════════════════════════════════════════════════

local Tabs = {
    Main = Window:AddTab('Principal'),
    Visuals = Window:AddTab('Visual'),
    Settings = Window:AddTab('Configurações')
}

-- ═══════════════════════════════════════════════════════════════════════════════
-- ABA PRINCIPAL - EXEMPLOS DE TODOS OS COMPONENTES
-- ═══════════════════════════════════════════════════════════════════════════════

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- TOGGLE (Botão Liga/Desliga)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local ToggleGroup = Tabs.Main:AddLeftGroupbox('Toggle Examples')

-- Toggle simples
local MyToggle = ToggleGroup:AddToggle('MyToggle', {
    Text = 'Toggle Simples',
    Default = false,
    Tooltip = 'Um toggle básico',
    Callback = function(value)
        print('Toggle:', value)
    end
})

-- Toggle com KeyPicker
local KeyToggle = ToggleGroup:AddToggle('KeyToggle', {
    Text = 'Toggle com Tecla',
    Default = false,
    Callback = function(value)
        print('Toggle com tecla:', value)
    end
})

KeyToggle:AddKeyPicker('KeyTogglePicker', {
    Default = 'E',
    Mode = 'Toggle',
    Text = 'Atalho Toggle',
    SyncToggleState = true,
    Callback = function(value)
        print('Tecla pressionada:', value)
    end
})

-- Toggle com ColorPicker
local ColorToggle = ToggleGroup:AddToggle('ColorToggle', {
    Text = 'Toggle com Cor',
    Default = false,
    Callback = function(value)
        print('Toggle colorido:', value)
    end
})

ColorToggle:AddColorPicker('ColorPicker', {
    Title = 'Cor Personalizada',
    Default = Color3.fromRGB(255, 0, 0),
    Transparency = 0.5,
    Callback = function(color, transparency)
        print('Cor:', color, 'Transparência:', transparency)
    end
})

-- Toggle de risco
ToggleGroup:AddToggle('RiskyToggle', {
    Text = 'Opção Perigosa',
    Default = false,
    Risky = true,
    Tooltip = 'Use com cuidado!'
})

-- Toggle desabilitado
ToggleGroup:AddToggle('DisabledToggle', {
    Text = 'Toggle Desabilitado',
    Default = false,
    Disabled = true,
    DisabledTooltip = 'Este toggle está desabilitado'
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- SLIDER (Barra Deslizante)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local SliderGroup = Tabs.Main:AddRightGroupbox('Slider Examples')

-- Slider normal
SliderGroup:AddSlider('NormalSlider', {
    Text = 'Slider Normal',
    Default = 50,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Suffix = '%',
    Tooltip = 'Slider de 0 a 100',
    Callback = function(value)
        print('Slider normal:', value)
    end
})

-- Slider compacto
SliderGroup:AddSlider('CompactSlider', {
    Text = 'Slider Compacto',
    Default = 0.5,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Compact = true,
    Tooltip = 'Formato compacto',
    Callback = function(value)
        print('Slider compacto:', value)
    end
})

-- Slider com prefixo e sufixo
SliderGroup:AddSlider('CustomSlider', {
    Text = 'Slider Customizado',
    Default = 100,
    Min = 1,
    Max = 500,
    Rounding = 0,
    Prefix = '$',
    Suffix = ' coins',
    Tooltip = 'Com prefixo e sufixo',
    Callback = function(value)
        print('Valor customizado:', value)
    end
})

-- Slider sem exibir máximo
SliderGroup:AddSlider('HiddenMaxSlider', {
    Text = 'Sem Mostrar Máximo',
    Default = 25,
    Min = 1,
    Max = 100,
    Rounding = 0,
    HideMax = true,
    Tooltip = 'Não mostra o valor máximo',
    Callback = function(value)
        print('Slider sem max:', value)
    end
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- DROPDOWN (Menu Suspenso)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local DropdownGroup = Tabs.Main:AddLeftGroupbox('Dropdown Examples')

-- Dropdown simples
DropdownGroup:AddDropdown('SimpleDropdown', {
    Text = 'Dropdown Simples',
    Values = {'Opção 1', 'Opção 2', 'Opção 3'},
    Default = 1,
    Tooltip = 'Selecione uma opção',
    Callback = function(value)
        print('Opção selecionada:', value)
    end
})

-- Dropdown com busca
DropdownGroup:AddDropdown('SearchableDropdown', {
    Text = 'Dropdown com Busca',
    Values = {'Alpha', 'Beta', 'Gamma', 'Delta', 'Epsilon'},
    Default = 1,
    Searchable = true,
    Tooltip = 'Digite para buscar',
    Callback = function(value)
        print('Busca selecionada:', value)
    end
})

-- Dropdown múltipla seleção
DropdownGroup:AddDropdown('MultiDropdown', {
    Text = 'Seleção Múltipla',
    Values = {'ESP', 'Aimbot', 'Speed', 'Fly'},
    Default = {'ESP'},
    Multi = true,
    Tooltip = 'Selecione múltiplos itens',
    Callback = function(values)
        print('Itens selecionados:')
        for item, enabled in pairs(values) do
            print('  ', item, enabled)
        end
    end
})

-- Dropdown de jogadores
DropdownGroup:AddDropdown('PlayerDropdown', {
    Text = 'Selecionar Jogador',
    SpecialType = 'Player',
    ExcludeLocalPlayer = true,
    Searchable = true,
    Tooltip = 'Lista de jogadores no servidor',
    Callback = function(player)
        print('Jogador selecionado:', player)
    end
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- INPUT (Campo de Texto)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local InputGroup = Tabs.Main:AddRightGroupbox('Input Examples')

-- Input básico
InputGroup:AddInput('BasicInput', {
    Text = 'Input Básico',
    Default = 'Texto padrão',
    Placeholder = 'Digite aqui...',
    Tooltip = 'Campo de texto simples',
    Callback = function(value)
        print('Input básico:', value)
    end
})

-- Input com Enter (Finished)
InputGroup:AddInput('FinishedInput', {
    Text = 'Input com Enter',
    Placeholder = 'Pressione Enter...',
    Finished = true,
    Tooltip = 'Callback apenas ao pressionar Enter',
    Callback = function(value)
        print('Enter pressionado:', value)
        Library:Notify('Texto confirmado: ' .. value)
    end
})

-- Input com limite de caracteres
InputGroup:AddInput('LimitedInput', {
    Text = 'Input Limitado',
    Placeholder = 'Máx 10 caracteres',
    MaxLength = 10,
    AllowEmpty = false,
    EmptyReset = 'Padrão',
    Tooltip = 'Máximo de 10 caracteres',
    Callback = function(value)
        print('Input limitado:', value)
    end
})

-- Input numérico
InputGroup:AddInput('NumericInput', {
    Text = 'Input Numérico',
    Default = '100',
    Placeholder = 'Apenas números',
    Numeric = true,
    Tooltip = 'Aceita apenas números',
    Callback = function(value)
        local num = tonumber(value)
        if num then
            print('Número inserido:', num)
        end
    end
})

-- Input desabilitado
InputGroup:AddInput('DisabledInput', {
    Text = 'Input Desabilitado',
    Default = 'Somente leitura',
    Disabled = true,
    Tooltip = 'Este campo não pode ser editado'
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- BUTTON (Botões)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local ButtonGroup = Tabs.Main:AddLeftGroupbox('Button Examples')

-- Botão simples
ButtonGroup:AddButton({
    Text = 'Botão Simples',
    Tooltip = 'Clique para executar',
    Func = function()
        print('Botão pressionado!')
        Library:Notify('Botão clicado!')
    end
})

-- Botão com duplo clique
ButtonGroup:AddButton({
    Text = 'Duplo Clique',
    DoubleClick = true,
    Tooltip = 'Requer duplo clique para segurança',
    Func = function()
        print('Duplo clique confirmado!')
        Library:Notify('Ação confirmada com duplo clique!')
    end
})

-- Botão desabilitado
ButtonGroup:AddButton({
    Text = 'Botão Desabilitado',
    Disabled = true,
    DisabledTooltip = 'Este botão está desabilitado',
    Func = function()
        print('Este botão não deveria funcionar')
    end
})

-- Botão de ação importante
ButtonGroup:AddButton({
    Text = 'Ação Importante',
    Tooltip = 'Executa uma ação crítica',
    Func = function()
        Library:Notify('Executando ação importante...', 3)
    end
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- KEYPICKER (Seletor de Teclas)
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
-- IMAGE (Imagens)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local ImageGroup = Tabs.Main:AddLeftGroupbox('Image Example')

-- Imagem Roblox Asset
ImageGroup:AddImage('RobloxImage', {
    Image = 'rbxassetid://9328294962',
    Height = 100,
    Color = Color3.fromRGB(255, 255, 255),
    ScaleType = Enum.ScaleType.Fit,
    Transparency = 0,
    Visible = true,
    Tooltip = 'Imagem do Roblox'
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- LABELS E DIVISORES
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local LabelGroup = Tabs.Main:AddRightGroupbox('Label & Divider Examples')

LabelGroup:AddLabel('Label Simples')
LabelGroup:AddLabel('Label com múltiplas linhas:\nLinha 2\nLinha 3', true)
LabelGroup:AddDivider()
LabelGroup:AddLabel('Após o divisor')

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- DEPENDENCY BOX (Caixa de Dependências)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local DependencyGroup = Tabs.Main:AddLeftGroupbox('Dependency Box Example')

local MasterToggle = DependencyGroup:AddToggle('MasterToggle', {
    Text = 'Ativar Opções Avançadas',
    Default = false,
    Tooltip = 'Habilita configurações adicionais'
})

local DepBox = DependencyGroup:AddDependencyBox()
DepBox:SetupDependencies({{Toggles.MasterToggle, true}})

DepBox:AddSlider('DepSlider', {
    Text = 'Opção Dependente',
    Default = 50,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Tooltip = 'Só aparece quando MasterToggle está ativo'
})

DepBox:AddDropdown('DepDropdown', {
    Text = 'Dropdown Dependente',
    Values = {'A', 'B', 'C'},
    Default = 1,
    Tooltip = 'Opção dependente do toggle'
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- TABBOX (Abas Aninhadas)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local SubTabbox = Tabs.Main:AddRightTabbox()
local SubTab1 = SubTabbox:AddTab('Sub-Aba 1')
local SubTab2 = SubTabbox:AddTab('Sub-Aba 2')

SubTab1:AddToggle('SubToggle1', {
    Text = 'Toggle na Sub-Aba 1',
    Default = false
})

SubTab2:AddSlider('SubSlider2', {
    Text = 'Slider na Sub-Aba 2',
    Default = 50,
    Min = 0,
    Max = 100,
    Rounding = 0
})

-- ═══════════════════════════════════════════════════════════════════════════════
-- ABA VISUAL - EXEMPLOS PRÁTICOS
-- ═══════════════════════════════════════════════════════════════════════════════

local ESPGroup = Tabs.Visuals:AddLeftGroupbox('ESP Settings')

local PlayerESP = ESPGroup:AddToggle('PlayerESP', {
    Text = 'ESP de Jogadores',
    Default = false,
    Tooltip = 'Mostra jogadores através das paredes'
})

PlayerESP:AddColorPicker('ESPColor', {
    Title = 'Cor do ESP',
    Default = Color3.fromRGB(0, 255, 0),
    Transparency = 0.5
})

ESPGroup:AddSlider('ESPDistance', {
    Text = 'Distância Máxima',
    Default = 500,
    Min = 100,
    Max = 2000,
    Rounding = 0,
    Suffix = ' studs'
})

ESPGroup:AddDropdown('ESPStyle', {
    Text = 'Estilo do ESP',
    Values = {'Box', 'Highlight', 'Outline', 'Glow'},
    Default = 1
})

-- ═══════════════════════════════════════════════════════════════════════════════
-- ABA SETTINGS - CONFIGURAÇÕES E SALVAMENTO
-- ═══════════════════════════════════════════════════════════════════════════════

local MenuGroup = Tabs.Settings:AddLeftGroupbox('Menu Controls')

MenuGroup:AddToggle('ShowKeybinds', {
    Text = 'Mostrar Keybinds',
    Default = true,
    Callback = function(value)
        Library.KeybindFrame.Visible = value
    end
})

MenuGroup:AddToggle('ShowWatermark', {
    Text = 'Mostrar Watermark',
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
    Text = 'Testar Notificação',
    Func = function()
        Library:Notify('Esta é uma notificação de teste!')
    end
})

MenuGroup:AddButton({
    Text = 'Descarregar Menu',
    Func = function()
        Library:Unload()
    end
})

-- ═══════════════════════════════════════════════════════════════════════════════
-- WATERMARK DINÂMICO
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
            'Meu Script v1.0 | %d FPS | %dms',
            math.floor(FPS),
            math.floor(ping)
        ))
    end)
end

updateWatermark()

-- ═══════════════════════════════════════════════════════════════════════════════
-- SISTEMA DE SALVAMENTO
-- ═══════════════════════════════════════════════════════════════════════════════

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({'MenuKeybind'})

ThemeManager:SetFolder('MeuScript')
SaveManager:SetFolder('MeuScript/configs')

SaveManager:BuildConfigSection(Tabs.Settings)
ThemeManager:ApplyToTab(Tabs.Settings)

SaveManager:LoadAutoloadConfig()

-- ═══════════════════════════════════════════════════════════════════════════════
-- EXEMPLOS DE USO AVANÇADO
-- ═══════════════════════════════════════════════════════════════════════════════

-- Monitorar mudanças em tempo real
Toggles.PlayerESP:OnChanged(function()
    print('PlayerESP mudou para:', Toggles.PlayerESP.Value)
end)

-- Acessar valores
task.spawn(function()
    while true do
        wait(1)
        -- Exemplo de como acessar valores dos componentes
        if Toggles.PlayerESP and Toggles.PlayerESP.Value then
            local distance = Options.ESPDistance.Value
            print('ESP ativo com distância:', distance)
        end
    end
end)

-- ═══════════════════════════════════════════════════════════════════════════════
-- FINALIZAÇÃO
-- ═══════════════════════════════════════════════════════════════════════════════

print('Menu carregado com sucesso!')
print('Usuário:', game.Players.LocalPlayer.Name)
print('Pressione', Options.MenuKeybind.Value, 'para abrir/fechar o menu')

Library:Notify('Menu carregado com sucesso!')
