--[[
    ╔══════════════════════════════════════════════════════════════════════════╗
    ║                            LinoriaLib v3.0.0                                          ║
    ║                        Exemplo Completo e Intuitivo                                   ║
    ╠══════════════════════════════════════════════════════════════════════════╣
    ║  • Interface moderna e responsiva                                                     ║
    ║  • Compatível com PC, Mobile                                                          ║
    ║  • Sistema de salvamento automático                                                   ║
    ║  • Temas personalizáveis                                                              ║
    ║  • Notificações elegantes                                                             ║
    ╚══════════════════════════════════════════════════════════════════════════╝
]]

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🔧 CONFIGURAÇÃO INICIAL DA LIBRARY
-- ═══════════════════════════════════════════════════════════════════════════════

local repo = "https://raw.githubusercontent.com/DH-SOARESE/LinoriaLib/main/"

-- Carregamento seguro da library
local Library, ThemeManager, SaveManager
local function loadLinoriaLib()
    local success, result = pcall(function()
        Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
        ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
        SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
    end)
    
    if not success then
        error('❌ Falha ao carregar LinoriaLib: ' .. tostring(result))
    end
    
    print('✅ LinoriaLib carregada com sucesso!')
end

loadLinoriaLib()

-- Atalhos para acesso rápido
local Options = Library.Options
local Toggles = Library.Toggles

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🎨 CONFIGURAÇÕES GLOBAIS DA INTERFACE
-- ═══════════════════════════════════════════════════════════════════════════════

Library.ShowToggleFrameInKeybinds = true  -- Mostra keybinds dos toggles
Library.ShowCustomCursor = true           -- Cursor customizado
Library.NotifySide = 'Right'              -- Lado das notificações

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🏠 CRIAÇÃO DA JANELA PRINCIPAL
-- ═══════════════════════════════════════════════════════════════════════════════

local Window = Library:CreateWindow({
    Title = '🚀 Meu Script Avançado v2.1',
    Center = true,
    AutoShow = true,
    Resizable = true,
    ShowCustomCursor = true,
    NotifySide = 'Right',
    TabPadding = 10,
    MenuFadeTime = 0.3
})

-- ═══════════════════════════════════════════════════════════════════════════════
-- 📁 CRIAÇÃO DAS ABAS
-- ═══════════════════════════════════════════════════════════════════════════════

local Tabs = {
    Combat = Window:AddTab('⚔️ Combat'),
    Player = Window:AddTab('🏃 Player'),
    Visuals = Window:AddTab('👁️ Visuals'), 
    Misc = Window:AddTab('🔧 Misc'),
    Settings = Window:AddTab('⚙️ Settings')
}

-- ═══════════════════════════════════════════════════════════════════════════════
-- ⚔️ ABA COMBAT - RECURSOS DE COMBATE
-- ═══════════════════════════════════════════════════════════════════════════════

-- 🔫 Recursos de Aim
local AimGroup = Tabs.Combat:AddLeftGroupbox('🎯 Aim Assistance')

local AimbotToggle = AimGroup:AddToggle('Aimbot', {
    Text = 'Aimbot Ativado',
    Tooltip = 'Ativa o sistema de mira automática',
    Default = false,
    Callback = function(value)
        print('🎯 Aimbot:', value and 'ATIVADO' or 'DESATIVADO')
        Library:Notify(
            value and '✅ Aimbot Ativado!' or '❌ Aimbot Desativado!',
            nil, 
            value and 4590657391 or 4590657392
        )
    end
})

-- Keybind para o aimbot
AimbotToggle:AddKeyPicker('AimbotKey', {
    Mode = 'Hold', -- Hold, Toggle, Always
    Default = 'MouseButton2',
    Text = 'Aimbot Hold',
    SyncToggleState = false,
    Callback = function(value)
        print('🔑 Aimbot Key:', value and 'PRESSIONADO' or 'SOLTO')
    end
})

-- Color picker para FOV
AimbotToggle:AddColorPicker('AimbotFOV', {
    Title = 'Cor do FOV',
    Default = Color3.new(1, 0, 0),
    Transparency = 0.8,
    Callback = function(color, transparency)
        print('🎨 FOV Color:', color, 'Transparência:', transparency)
    end
})

AimGroup:AddSlider('AimFOV', {
    Text = 'FOV do Aimbot',
    Default = 120,
    Min = 50,
    Max = 360,
    Rounding = 0,
    Compact = false,
    Tooltip = 'Tamanho do campo de visão do aimbot',
    Callback = function(value)
        print('📐 Aimbot FOV:', value)
    end
})

AimGroup:AddSlider('AimSmooth', {
    Text = 'Suavidade',
    Default = 2.5,
    Min = 0.1,
    Max = 10,
    Rounding = 1,
    Compact = true,
    Tooltip = 'Quão suave será a mira (menor = mais suave)',
    Callback = function(value)
        print('🌊 Aim Smoothness:', value)
    end
})

-- Dropdown para partes do corpo
AimGroup:AddDropdown('AimPart', {
    Text = 'Parte do Corpo',
    Values = {'Head', 'Torso', 'HumanoidRootPart', 'Random'},
    Default = 1,
    Tooltip = 'Selecione qual parte do corpo mirar',
    Callback = function(value)
        print('🎯 Aim Target:', value)
        Library:Notify('🎯 Mirando em: ' .. value)
    end
})

-- 💥 Recursos de Armas
local WeaponGroup = Tabs.Combat:AddRightGroupbox('🔫 Weapon Mods')

WeaponGroup:AddToggle('NoRecoil', {
    Text = 'Sem Recuo',
    Default = false,
    Tooltip = 'Remove o recuo das armas'
})

WeaponGroup:AddToggle('NoSpread', {
    Text = 'Sem Dispersão',
    Default = false,
    Tooltip = 'Remove a dispersão dos tiros'
})

WeaponGroup:AddToggle('InfiniteAmmo', {
    Text = 'Munição Infinita',
    Default = false,
    Tooltip = 'Nunca mais fique sem munição'
})

WeaponGroup:AddToggle('RapidFire', {
    Text = 'Tiro Rápido',
    Default = false,
    Tooltip = 'Aumenta a velocidade de tiro'
})

WeaponGroup:AddSlider('FireRate', {
    Text = 'Taxa de Tiro',
    Default = 1,
    Min = 0.1,
    Max = 10,
    Rounding = 1,
    Tooltip = 'Multiplicador da velocidade de tiro'
})

WeaponGroup:AddDivider()
WeaponGroup:AddLabel('⚠️ Use com moderação!')

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🏃 ABA PLAYER - MODIFICAÇÕES DO JOGADOR
-- ═══════════════════════════════════════════════════════════════════════════════

-- 🚶 Movimento
local MovementGroup = Tabs.Player:AddLeftGroupbox('🚀 Movement')

MovementGroup:AddSlider('WalkSpeed', {
    Text = 'Velocidade de Caminhada',
    Default = 16,
    Min = 1,
    Max = 100,
    Rounding = 0,
    Tooltip = 'Ajusta a velocidade de movimento',
    Callback = function(value)
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild('Humanoid') then
            player.Character.Humanoid.WalkSpeed = value
            print('🏃 Velocidade alterada para:', value)
        end
    end
})

MovementGroup:AddSlider('JumpPower', {
    Text = 'Força do Pulo',
    Default = 50,
    Min = 1,
    Max = 200,
    Rounding = 0,
    Tooltip = 'Ajusta a altura do pulo',
    Callback = function(value)
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild('Humanoid') then
            player.Character.Humanoid.JumpPower = value
            print('🦘 Força do pulo alterada para:', value)
        end
    end
})

local FlyToggle = MovementGroup:AddToggle('Fly', {
    Text = 'Voar',
    Default = false,
    Tooltip = 'Permite voar pelo mapa',
    Callback = function(value)
        if value then
            print('✈️ Modo voo ativado!')
            -- Aqui você implementaria a lógica do fly
        else
            print('🚶 Modo voo desativado!')
        end
    end
})

FlyToggle:AddKeyPicker('FlyKey', {
    Mode = 'Toggle',
    Default = 'F',
    Text = 'Toggle Fly',
    SyncToggleState = true
})

MovementGroup:AddToggle('Noclip', {
    Text = 'Atravessar Paredes',
    Default = false,
    Tooltip = 'Permite atravessar objetos sólidos'
})

-- 💪 Habilidades
local AbilityGroup = Tabs.Player:AddRightGroupbox('💪 Abilities')

AbilityGroup:AddToggle('InfiniteHealth', {
    Text = 'Vida Infinita',
    Default = false,
    Tooltip = 'Mantém a vida sempre no máximo'
})

AbilityGroup:AddToggle('InfiniteStamina', {
    Text = 'Stamina Infinita',
    Default = false,
    Tooltip = 'Nunca mais se canse'
})

AbilityGroup:AddButton({
    Text = 'Regenerar Vida',
    Tooltip = 'Restaura a vida instantaneamente',
    Func = function()
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild('Humanoid') then
            player.Character.Humanoid.Health = player.Character.Humanoid.MaxHealth
            Library:Notify('❤️ Vida restaurada!', nil, 4590657391)
        end
    end
})

AbilityGroup:AddButton({
    Text = 'Respawn',
    Tooltip = 'Renascer instantaneamente',
    DoubleClick = true,
    Func = function()
        local player = game.Players.LocalPlayer
        player:LoadCharacter()
        Library:Notify('🔄 Respawn realizado!', nil, 4590657391)
    end
})

-- ═══════════════════════════════════════════════════════════════════════════════
-- 👁️ ABA VISUALS - RECURSOS VISUAIS
-- ═══════════════════════════════════════════════════════════════════════════════

-- 📦 ESP (Extra Sensory Perception)
local ESPGroup = Tabs.Visuals:AddLeftGroupbox('👁️ ESP & Wallhacks')

local PlayerESP = ESPGroup:AddToggle('PlayerESP', {
    Text = 'ESP de Jogadores',
    Default = false,
    Tooltip = 'Vê jogadores através das paredes'
})

PlayerESP:AddColorPicker('ESPColor', {
    Title = 'Cor do ESP',
    Default = Color3.new(0, 1, 0),
    Transparency = 0.5
})

ESPGroup:AddToggle('ItemESP', {
    Text = 'ESP de Itens',
    Default = false,
    Tooltip = 'Mostra itens importantes no mapa'
})

ESPGroup:AddToggle('ChestESP', {
    Text = 'ESP de Baús',
    Default = false,
    Tooltip = 'Localiza baús no mapa'
})

ESPGroup:AddDropdown('ESPStyle', {
    Text = 'Estilo do ESP',
    Values = {'Box', 'Highlight', 'Outline', 'Glow'},
    Default = 1,
    Tooltip = 'Escolha o estilo visual do ESP'
})

-- 🎨 Interface
local UIGroup = Tabs.Visuals:AddRightGroupbox('🎨 Interface')

UIGroup:AddToggle('RemoveFog', {
    Text = 'Remover Névoa',
    Default = false,
    Tooltip = 'Remove a névoa do jogo para melhor visibilidade'
})

UIGroup:AddToggle('Fullbright', {
    Text = 'Brilho Total',
    Default = false,
    Tooltip = 'Ilumina todo o ambiente'
})

UIGroup:AddSlider('FOVChanger', {
    Text = 'Campo de Visão',
    Default = 70,
    Min = 30,
    Max = 120,
    Rounding = 0,
    Tooltip = 'Ajusta o campo de visão da câmera'
})

-- Sistema de Crosshair personalizado
local CrosshairGroup = Tabs.Visuals:AddRightTabbox()
local CrosshairTab = CrosshairGroup:AddTab('🎯 Crosshair')

CrosshairTab:AddToggle('ShowCrosshair', {
    Text = 'Mostrar Crosshair',
    Default = false,
    Tooltip = 'Exibe uma mira personalizada na tela'
})

CrosshairTab:AddSlider('CrosshairSize', {
    Text = 'Tamanho',
    Default = 10,
    Min = 5,
    Max = 50,
    Rounding = 0
})

CrosshairTab:AddToggle('CrosshairDot', {
    Text = 'Ponto Central',
    Default = true,
    Tooltip = 'Adiciona um ponto no centro da mira'
})

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🔧 ABA MISC - RECURSOS DIVERSOS
-- ═══════════════════════════════════════════════════════════════════════════════

-- 🎮 Auto-Farm
local AutoFarmGroup = Tabs.Misc:AddLeftGroupbox('🤖 Auto Farm')

AutoFarmGroup:AddToggle('AutoFarm', {
    Text = 'Auto Farm Ativo',
    Default = false,
    Tooltip = 'Automatiza ações repetitivas'
})

AutoFarmGroup:AddDropdown('FarmTarget', {
    Text = 'Alvo do Farm',
    Values = {'Coins', 'XP', 'Items', 'Kills'},
    Default = 1,
    Tooltip = 'O que você quer farmar automaticamente'
})

AutoFarmGroup:AddSlider('FarmDelay', {
    Text = 'Delay (segundos)',
    Default = 1,
    Min = 0.1,
    Max = 5,
    Rounding = 1,
    Tooltip = 'Tempo entre cada ação do farm'
})

-- 🌐 Servidor
local ServerGroup = Tabs.Misc:AddRightGroupbox('🌐 Server Tools')

ServerGroup:AddButton({
    Text = 'Copiar Job ID',
    Tooltip = 'Copia o ID do servidor atual',
    Func = function()
        setclipboard(game.JobId)
        Library:Notify('📋 Job ID copiado!', nil, 4590657391)
    end
})

ServerGroup:AddButton({
    Text = 'Server Hop',
    Tooltip = 'Muda para outro servidor',
    Func = function()
        Library:Notify('🔄 Procurando novo servidor...', nil, 4590657391)
        -- Aqui você implementaria a lógica do server hop
    end
})

ServerGroup:AddButton({
    Text = 'Rejoin Server',
    Tooltip = 'Reconecta ao servidor atual',
    DoubleClick = true,
    Func = function()
        game:GetService('TeleportService'):Teleport(game.PlaceId)
    end
})

-- 📊 Informações
local InfoGroup = Tabs.Misc:AddLeftGroupbox('📊 Informações')

InfoGroup:AddLabel('👤 Jogador: ' .. game.Players.LocalPlayer.Name)
InfoGroup:AddLabel('🆔 User ID: ' .. game.Players.LocalPlayer.UserId)
InfoGroup:AddLabel('🎮 Jogo: ' .. game:GetService('MarketplaceService'):GetProductInfo(game.PlaceId).Name, true)

-- Atualizar ping em tempo real
local PingLabel = InfoGroup:AddLabel('📶 Ping: Calculando...')
spawn(function()
    while true do
        wait(1)
        local ping = game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue()
        PingLabel:SetText('📶 Ping: ' .. math.floor(ping) .. 'ms')
    end
end)

-- ═══════════════════════════════════════════════════════════════════════════════
-- ⚙️ ABA SETTINGS - CONFIGURAÇÕES
-- ═══════════════════════════════════════════════════════════════════════════════

-- 🎛️ Controles do Menu
local MenuGroup = Tabs.Settings:AddLeftGroupbox('🎛️ Menu Controls')

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

MenuGroup:AddToggle('CustomCursor', {
    Text = 'Cursor Customizado',
    Default = true,
    Callback = function(value)
        Library.ShowCustomCursor = value
    end
})

MenuGroup:AddDropdown('NotificationSide', {
    Text = 'Lado das Notificações',
    Values = {'Left', 'Right'},
    Default = 2,
    Callback = function(value)
        Library.NotifySide = value
    end
})

-- Keybind principal do menu
MenuGroup:AddLabel('🔑 Menu Toggle'):AddKeyPicker('MenuKeybind', {
    Default = 'RightShift',
    NoUI = true,
    Text = 'Toggle Menu'
})

-- Botões de controle
MenuGroup:AddDivider()
MenuGroup:AddButton({
    Text = '🧪 Testar Notificação',
    Func = function()
        Library:Notify('🎉 Esta é uma notificação de teste!', nil, 4590657391)
    end
})

MenuGroup:AddButton({
    Text = '🔄 Recarregar Menu',
    Func = function()
        Library:Notify('🔄 Recarregando interface...', nil, 4590657391)
        wait(1)
        -- Aqui você poderia recarregar o script
    end
})

MenuGroup:AddButton({
    Text = '❌ Descarregar Menu',
    Func = function()
        Library:Unload()
    end
})

-- Sistema de dependências avançado
local AdvancedGroup = Tabs.Settings:AddRightGroupbox('⚙️ Advanced Settings')

local EnableAdvanced = AdvancedGroup:AddToggle('EnableAdvanced', {
    Text = 'Ativar Configurações Avançadas',
    Default = false,
    Tooltip = 'Desbloqueia opções experimentais'
})

local DependencyBox = AdvancedGroup:AddDependencyBox()

DependencyBox:AddToggle('ExperimentalFeatures', {
    Text = 'Recursos Experimentais',
    Default = false,
    Tooltip = 'ATENÇÃO: Pode causar instabilidade'
})

DependencyBox:AddSlider('PerformanceMode', {
    Text = 'Modo Performance',
    Default = 1,
    Min = 1,
    Max = 3,
    Rounding = 0,
    Tooltip = '1=Balanced, 2=Performance, 3=Quality'
})

DependencyBox:AddInput('CustomScript', {
    Text = 'Script Personalizado',
    Placeholder = 'print("Hello World")',
    Tooltip = 'Execute código Lua personalizado'
})

-- Configurar dependência
DependencyBox:SetupDependencies({{Toggles.EnableAdvanced, true}})

-- ═══════════════════════════════════════════════════════════════════════════════
-- 💧 SISTEMA DE WATERMARK DINÂMICO
-- ═══════════════════════════════════════════════════════════════════════════════

Library:SetWatermarkVisibility(true)

local function updateWatermark()
    local RunService = game:GetService('RunService')
    local Players = game:GetService('Players')
    local Stats = game:GetService('Stats')
    
    local frameStart = tick()
    local frameCount = 0
    local FPS = 60
    
    local connection = RunService.Heartbeat:Connect(function()
        frameCount = frameCount + 1
        
        if tick() - frameStart >= 1 then
            FPS = frameCount
            frameStart = tick()
            frameCount = 0
        end
        
        local ping = Stats.Network.ServerStatsItem['Data Ping']:GetValue()
        local playerCount = #Players:GetPlayers()
        
        Library:SetWatermark(string.format(
            '🚀 Meu Script v2.1 | 👥 %d Players | 📶 %dms | 🎯 %d FPS',
            playerCount,
            math.floor(ping),
            math.floor(FPS)
        ))
    end)
    
    Library:OnUnload(function()
        connection:Disconnect()
        print('👋 Menu descarregado com sucesso!')
    end)
end

updateWatermark()

-- ═══════════════════════════════════════════════════════════════════════════════
-- 💾 SISTEMA DE SALVAMENTO E TEMAS
-- ═══════════════════════════════════════════════════════════════════════════════

-- Configurar gerenciadores
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

-- Ignorar configurações de tema no save
SaveManager:IgnoreThemeSettings()

-- Ignorar keybind do menu
SaveManager:SetIgnoreIndexes({'MenuKeybind'})

-- Definir pastas
ThemeManager:SetFolder('MeuScript')
SaveManager:SetFolder('MeuScript/configs')

-- Adicionar seções de configuração
SaveManager:BuildConfigSection(Tabs.Settings)
ThemeManager:ApplyToTab(Tabs.Settings)

-- Carregar configuração automaticamente
SaveManager:LoadAutoloadConfig()

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🎯 EXEMPLOS DE USO AVANÇADO
-- ═══════════════════════════════════════════════════════════════════════════════

-- Monitorar mudanças em tempo real
Toggles.Aimbot:OnChanged(function()
    local state = Toggles.Aimbot.Value
    print('🎯 Aimbot state changed:', state)
    
    if state then
        Library:Notify('🎯 Aimbot Ativado!', nil, 4590657391)
    else
        Library:Notify('🎯 Aimbot Desativado!', nil, 4590657392)
    end
end)

-- Exemplo de como usar valores
Options.WalkSpeed:OnChanged(function()
    local speed = Options.WalkSpeed.Value
    local player = game.Players.LocalPlayer
    
    if player.Character and player.Character:FindFirstChild('Humanoid') then
        player.Character.Humanoid.WalkSpeed = speed
    end
end)

-- Sistema de notificações personalizadas
local function showCustomNotification(title, message, icon)
    Library:Notify(title .. ': ' .. message, nil, icon or 4590657391)
end

-- Exemplo de uso das funções
showCustomNotification('Sistema', 'Script carregado com sucesso!', 4590657391)

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🚀 FINALIZAÇÃO
-- ═══════════════════════════════════════════════════════════════════════════════

print('═══════════════════════════════════════════')
print('🎉 MENU CARREGADO COM SUCESSO!')
print('📝 Versão: 2.1')
print('👤 Usuário:', game.Players.LocalPlayer.Name)
print('🎮 Jogo:', game:GetService('MarketplaceService'):GetProductInfo(game.PlaceId).Name)
print('⚡ Status: Pronto para uso!')
print('═══════════════════════════════════════════')

-- Notificação de boas-vindas
wait(0.5)
Library:Notify('🎉 Bem-vindo, ' .. game.Players.LocalPlayer.Name .. '!', nil, 4590657391)
wait(2)
Library:Notify('💡 Pressione RightShift para abrir/fechar o menu', nil, 4590657391)
