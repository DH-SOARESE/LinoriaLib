# LinoriaLib - Guia Completo
*Uma biblioteca de UI moderna, leve e otimizada para Roblox*

## 🚀 Características
- ✨ **Leve e otimizada** - Funciona perfeitamente em qualquer dispositivo
- 🎨 **Interface moderna** - Design limpo e profissional
- 📱 **Mobile friendly** - Suporte completo para dispositivos móveis
- 🔧 **Fácil de usar** - API simples e intuitiva
- 💾 **Sistema de salvamento** - Configurações persistem entre sessões
- 🎭 **Temas customizáveis** - Múltiplos temas inclusos

## 📦 Instalação

```lua
-- Carregamento automático da biblioteca
local repo = "https://raw.githubusercontent.com/DH-SOARESE/LinoriaLib/main/"

local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()
```

## 🏗️ Configuração Básica

### 1. Criando uma Janela

```lua
-- Configurações globais da biblioteca
Library.ShowToggleFrameInKeybinds = true -- Mostra keybinds na UI (ótimo para mobile)
Library.ShowCustomCursor = true          -- Cursor customizado
Library.NotifySide = 'Left'              -- Lado das notificações

-- Criando a janela principal
local Window = Library:CreateWindow({
    Title = 'Meu Script',
    Center = true,           -- Centralizar na tela
    AutoShow = true,        -- Mostrar automaticamente
    Resizable = true,       -- Permitir redimensionar
    ShowCustomCursor = true,-- Usar cursor customizado
    TabPadding = 8,         -- Espaçamento entre abas
    MenuFadeTime = 0.2      -- Animação suave
})
```

### 2. Criando Abas

```lua
local Tabs = {
    Main = Window:AddTab('Principal'),
    Player = Window:AddTab('Jogador'),
    Visuals = Window:AddTab('Visual'),
    Settings = Window:AddTab('Configurações')
}
```

## 🎛️ Componentes Disponíveis

### Groupboxes (Caixas de Agrupamento)

```lua
-- Groupbox à esquerda
local MainFeatures = Tabs.Main:AddLeftGroupbox('Funcionalidades Principais')

-- Groupbox à direita
local ExtraOptions = Tabs.Main:AddRightGroupbox('Opções Extras')
```

### Toggles (Botões Liga/Desliga)

```lua
-- Toggle simples
local MyToggle = MainFeatures:AddToggle('MyToggle', {
    Text = 'Ativar Funcionalidade',
    Tooltip = 'Liga/desliga a funcionalidade principal',
    Default = false,
    Callback = function(value)
        print('Toggle ativado:', value)
    end
})

-- Toggle com keybind
MyToggle:AddKeyPicker('MyToggleKey', {
    Mode = 'Toggle',           -- Modo: Toggle, Hold, Always
    Default = 'E',            -- Tecla padrão
    Text = 'Atalho Toggle',
    SyncToggleState = true    -- Sincronizar com o estado do toggle
})

-- Toggle com color picker
MyToggle:AddColorPicker('MyColor', {
    Title = 'Cor Principal',
    Default = Color3.new(1, 0, 0), -- Vermelho
    Transparency = 0,
    Callback = function(color, transparency)
        print('Cor selecionada:', color, 'Transparência:', transparency)
    end
})
```

### Sliders (Barras Deslizantes)

```lua
-- Slider normal
MainFeatures:AddSlider('Speed', {
    Text = 'Velocidade',
    Default = 16,
    Min = 1,
    Max = 100,
    Rounding = 0,             -- Casas decimais
    Tooltip = 'Ajusta a velocidade do personagem',
    Callback = function(value)
        print('Velocidade definida:', value)
    end
})

-- Slider compacto
MainFeatures:AddSlider('FOV', {
    Text = 'Campo de Visão',
    Default = 70,
    Min = 60,
    Max = 120,
    Rounding = 0,
    Compact = true,           -- Formato compacto
    HideMax = true,          -- Esconder valor máximo
    Callback = function(value)
        workspace.CurrentCamera.FieldOfView = value
    end
})
```

### Dropdowns (Menus Suspensos)

```lua
-- Dropdown simples
ExtraOptions:AddDropdown('GameMode', {
    Text = 'Modo de Jogo',
    Values = {'Normal', 'Rápido', 'Especialista'},
    Default = 1,              -- Índice da opção padrão
    Tooltip = 'Selecione o modo de jogo',
    Callback = function(value)
        print('Modo selecionado:', value)
    end
})

-- Dropdown com busca
ExtraOptions:AddDropdown('PlayerList', {
    Text = 'Lista de Jogadores',
    Values = {'Jogador1', 'Jogador2', 'Jogador3'},
    Default = 1,
    Searchable = true,        -- Permitir busca
    Callback = function(value)
        print('Jogador selecionado:', value)
    end
})

-- Dropdown de múltipla seleção
ExtraOptions:AddDropdown('Features', {
    Text = 'Funcionalidades',
    Values = {'ESP', 'Aimbot', 'Speed', 'Jump'},
    Default = 1,
    Multi = true,             -- Seleção múltipla
    Callback = function(value)
        print('Funcionalidades selecionadas:')
        for feature, enabled in pairs(value) do
            print(feature, enabled)
        end
    end
})

-- Dropdown de jogadores (automático)
ExtraOptions:AddDropdown('TargetPlayer', {
    SpecialType = 'Player',   -- Tipo especial para jogadores
    ExcludeLocalPlayer = true,-- Excluir jogador local
    Text = 'Jogador Alvo',
    Callback = function(value)
        print('Alvo selecionado:', value)
    end
})
```

### Inputs (Campos de Texto)

```lua
MainFeatures:AddInput('CustomText', {
    Text = 'Texto Personalizado',
    Default = 'Digite aqui...',
    Placeholder = 'Insira seu texto',
    ClearTextOnFocus = true,  -- Limpar ao focar
    Tooltip = 'Digite um texto personalizado',
    Callback = function(value)
        print('Texto inserido:', value)
    end
})
```

### Botões

```lua
-- Botão simples
MainFeatures:AddButton({
    Text = 'Executar Ação',
    Tooltip = 'Clique para executar',
    Func = function()
        print('Botão pressionado!')
        Library:Notify('Ação executada com sucesso!')
    end
})

-- Botão com duplo clique
MainFeatures:AddButton({
    Text = 'Ação Especial',
    DoubleClick = true,       -- Requer duplo clique
    Func = function()
        Library:Notify('Ação especial executada!', nil, 3)
    end
})

-- Botão desabilitado
MainFeatures:AddButton({
    Text = 'Indisponível',
    Disabled = true,          -- Botão desabilitado
    DisabledTooltip = 'Esta função não está disponível',
    Func = function() end
})
```

### Elementos Visuais

```lua
-- Labels (textos)
MainFeatures:AddLabel('Status: Conectado')
MainFeatures:AddLabel('Múltiplas linhas:\nTudo funcionando!', true)

-- Divisor
MainFeatures:AddDivider()
```

## 🎨 Tabboxes (Abas Aninhadas)

```lua
local SubTabs = Tabs.Main:AddRightTabbox()
local Combat = SubTabs:AddTab('Combate')
local Movement = SubTabs:AddTab('Movimento')

Combat:AddToggle('Aimbot', {Text = 'Aimbot', Default = false})
Movement:AddSlider('WalkSpeed', {Text = 'Velocidade', Min = 1, Max = 100, Default = 16})
```

## 🔗 Sistema de Dependências

```lua
-- Toggle principal
local EnableAdvanced = MainFeatures:AddToggle('EnableAdvanced', {
    Text = 'Habilitar Configurações Avançadas',
    Default = false
})

-- Caixa de dependência
local AdvancedBox = MainFeatures:AddDependencyBox()
AdvancedBox:AddSlider('AdvancedValue', {
    Text = 'Valor Avançado',
    Min = 0, Max = 100, Default = 50
})

-- Configurar dependência (só aparece quando EnableAdvanced estiver ativo)
AdvancedBox:SetupDependencies({
    {Toggles.EnableAdvanced, true}
})
```

## 💾 Sistema de Salvamento e Temas

```lua
-- Configurar gerenciadores
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

-- Configurações de salvamento
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({'MenuKeybind'}) -- Ignorar certas configurações

-- Definir pastas
ThemeManager:SetFolder('MeuScript')
SaveManager:SetFolder('MeuScript/Configs')

-- Adicionar seções de configuração
SaveManager:BuildConfigSection(Tabs.Settings)
ThemeManager:ApplyToTab(Tabs.Settings)

-- Carregar configuração automática
SaveManager:LoadAutoloadConfig()
```

## 🎪 Recursos Especiais

### Watermark (Marca d'água)

```lua
Library:SetWatermarkVisibility(true)

-- Atualizar watermark dinamicamente
local function updateWatermark()
    game:GetService('RunService').Heartbeat:Connect(function()
        local fps = math.floor(1/game:GetService('RunService').Heartbeat:Wait())
        local ping = game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue()
        
        Library:SetWatermark(('Meu Script | %d FPS | %d ms'):format(fps, ping))
    end)
end
updateWatermark()
```

### Keybinds Globais

```lua
-- Keybind para o menu
Options.MenuKeybind = Library.MenuKeybind or Library:AddKeyPicker('MenuKeybind', {
    Default = 'RightShift',
    Text = 'Toggle Menu'
})
```

### Notificações

```lua
-- Notificação simples
Library:Notify('Mensagem de sucesso!')

-- Notificação com ícone e duração
Library:Notify('Erro detectado!', nil, 4590657391) -- Message, Time, SOUND_ID 
Library:Notify('Erro detectado!', 10, 4590657391) 
```

## 🎯 Acessando Valores

```lua
-- Acessar valores de toggles
print(Toggles.MyToggle.Value)

-- Acessar valores de outros componentes
print(Options.Speed.Value)
print(Options.GameMode.Value)

-- Definir valores programaticamente
Toggles.MyToggle:SetValue(true)
Options.Speed:SetValue(50)
Options.GameMode:SetValue('Rápido')
```

## 📱 Controles de Menu

```lua
local MenuControls = Tabs.Settings:AddLeftGroupbox('Controles do Menu')

-- Toggle para mostrar keybinds
MenuControls:AddToggle('ShowKeybinds', {
    Text = 'Mostrar Menu de Keybinds',
    Default = true,
    Callback = function(value)
        Library.KeybindFrame.Visible = value
    end
})

-- Botão para descarregar menu
MenuControls:AddButton({
    Text = 'Descarregar Menu',
    Func = function()
        Library:Unload()
    end
})
```

## 🔧 Exemplo Completo

```lua
-- === CONFIGURAÇÃO INICIAL ===
local repo = "https://raw.githubusercontent.com/DH-SOARESE/LinoriaLib/main/"

local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

-- === CRIANDO INTERFACE ===
local Window = Library:CreateWindow({
    Title = 'Meu Script v1.0',
    Center = true,
    AutoShow = true,
    Resizable = true
})

local Tabs = {
    Main = Window:AddTab('Principal'),
    Settings = Window:AddTab('Configurações')
}

-- === FUNCIONALIDADES PRINCIPAIS ===
local MainGroup = Tabs.Main:AddLeftGroupbox('Funcionalidades')

local SpeedToggle = MainGroup:AddToggle('Speed', {
    Text = 'Velocidade Extra',
    Default = false,
    Callback = function(value)
        if value then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50
        else
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
    end
})

SpeedToggle:AddKeyPicker('SpeedKey', {
    Default = 'LeftShift',
    Mode = 'Toggle',
    Text = 'Atalho Velocidade'
})

-- === CONFIGURAÇÕES ===
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:SetFolder('MeuScript/Configs')
SaveManager:BuildConfigSection(Tabs.Settings)
ThemeManager:ApplyToTab(Tabs.Settings)
SaveManager:LoadAutoloadConfig()

print('Script carregado com sucesso!')
```

## 📚 Dicas e Boas Práticas

1. **Organize suas funcionalidades em groupboxes** para melhor legibilidade
2. **Use tooltips** para explicar o que cada controle faz
3. **Implemente callbacks** para todas as suas funcionalidades
4. **Configure o sistema de salvamento** para persistir configurações
5. **Use keybinds** para funcionalidades importantes
6. **Teste em dispositivos móveis** para garantir compatibilidade
7. **Use notificações** para dar feedback ao usuário

## ⚡ Performance

A LinoriaLib é otimizada para performance máxima:
- **Renderização eficiente** - Não impacta o FPS do jogo
- **Código limpo** - Sem vazamentos de memória
- **Mobile optimized** - Funciona perfeitamente em dispositivos móveis
- **Carregamento rápido** - Interface aparece instantaneamente

---

*Desenvolvido com ❤️ para a comunidade Roblox*
