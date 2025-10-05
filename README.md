# LinoriaLib - Documentação Completa
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

---

## 📋 Elementos de Interface

### 🔘 Toggle (Botão Liga/Desliga)

```lua
-- Toggle simples
local MeuToggle = Groupbox:AddToggle("MostrarESP", {
    Text = "Ativar ESP",                              -- Texto visível
    Default = false,                                  -- Valor inicial
    Tooltip = "Liga ou desliga o sistema de ESP",     -- Dica ao passar o mouse
    Risky = false,                                    -- Mostra em vermelho se for perigoso
    Disabled = false,                                 -- Impede interação se true
    DisabledTooltip = false,                          -- Tooltip alternativa se desativado
    Callback = function(Value)
        print("Toggle:", Value)
    end
})

-- Manipular toggle programaticamente
MeuToggle:SetValue(true)
MeuToggle:OnChanged(function(value)
    print("Estado mudou:", value)
end)
```

#### Toggle com KeyPicker e ColorPicker

```lua
local Toggle_Example = Groupbox:AddToggle("ExampleToggle", {
    Text = "Ativar ESP",
    Default = false,
    Callback = function(Value)
        print("ESP:", Value and "Ativado" ou "Desativado")
    end
})

-- Adicionar KeyPicker ao Toggle
Groupbox:AddKeyPicker("ESPKeyPicker", {
    Default = "E",              -- Tecla padrão
    Mode = "Toggle",            -- Modos: "Always", "Hold" ou "Toggle"
    Text = "ESP",               -- Nome visível no KeybindsFrame
    SyncToggleState = true,     -- Sincroniza com o estado do toggle
    Callback = function(Toggled)
        print("ESP KeyPicker Toggle:", Toggled)
    end
})

-- Adicionar ColorPicker ao Toggle
Groupbox:AddColorPicker("ESPColor", {
    Title = "Cor do ESP",
    Default = Color3.fromRGB(255, 0, 0),
    Transparency = 0.1,
    Callback = function(Color, Alpha)
        local r = math.floor(Color.R * 255)
        local g = math.floor(Color.G * 255)
        local b = math.floor(Color.B * 255)
        print(string.format("Color: (%d, %d, %d)  Alpha: %.2f", r, g, b, Alpha))
    end
})
```

---

### 🎚️ Slider (Barra Deslizante)

```lua
-- Slider normal
local BrilhoSlider = Groupbox:AddSlider("BrilhoTela", {
    Text = "Brilho da Tela",                          -- Título
    Default = 50,                                     -- Valor inicial
    Min = 0,                                          -- Mínimo
    Max = 100,                                        -- Máximo
    Rounding = 0,                                     -- Casas decimais
    Suffix = "%",                                     -- Sufixo exibido
    Disabled = false,
    Tooltip = "Ajusta o brilho da tela entre 0% e 100%.",
    Callback = function(Value)
        print("Brilho:", Value)
    end
})

-- Slider compacto
local VolumeSlider = Groupbox:AddSlider("VolumeGeral", {
    Text = "Volume",
    Default = 0.5,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Compact = true,                                   -- Layout compacto
    Prefix = "::",                                    -- Texto antes do número
    Suffix = "::",                                    -- Texto depois do número
    Tooltip = "Ajusta o volume geral (0 a 1).",
    Callback = function(Value)
        print("Volume:", Value)
    end
})

-- Controles do Slider
VolumeSlider:SetDisabled(false)
VolumeSlider:SetMin(0.1)
VolumeSlider:SetMax(2.0)
VolumeSlider:SetValue(1.2)
```

---

### 📝 Dropdown (Menu Suspenso)

#### Dropdown Simples

```lua
local MeuDropdown = Groupbox:AddDropdown("EscolherItem", {
    Text = "Item de Teste",
    Values = {"Espada", "Escudo", "Poção"},
    Default = "Espada",
    Tooltip = "Escolha um item da lista.",
    Callback = function(Value)
        print("Selecionado:", Value)
    end
})
```

#### Dropdown com Múltipla Seleção

```lua
local MultiSelect = Groupbox:AddDropdown("MultiItem", {
    Text = "Itens Ativos",
    Values = {"ESP", "Aimbot", "TriggerBot"},
    Multi = true,                                     -- Permite múltiplas seleções
    Disabled = false,
    DisabledTooltip = false,
    Default = {"ESP"},
    Tooltip = "Selecione múltiplos recursos.",
    Callback = function(Values)
        print("Selecionados:", Values)
        for item, enabled in pairs(Values) do
            print(item, enabled)
        end
    end
})
```

#### Dropdown de Jogadores

```lua
local ProcurarJogador = Groupbox:AddDropdown("Jogadores", {
    Text = "Selecionar Jogador",
    SpecialType = "Player",                           -- Preenche com jogadores
    ExcludeLocalPlayer = true,                        -- Ignora o próprio jogador
    Searchable = true,                                -- Habilita busca
    Tooltip = "Selecione um jogador da lista.",
    Callback = function(Player)
        print("Jogador selecionado:", Player)
    end
})
```

---

### ⌨️ Input (Campo de Texto)

#### Input Básico

```lua
local Input_Example = Groupbox:AddInput("UsernameInput", {
    Text = "Nome do jogador",
    Default = "Player123",
    Placeholder = "Digite seu nick...",
    Callback = function(value)
        print("Nome atualizado para:", value)
    end
})
```

#### Input com Enter (Finished)

```lua
Groupbox:AddInput("CommandInput", {
    Text = "Executar comando",
    Placeholder = "Digite um comando...",
    Finished = true,                                  -- Só chama callback ao apertar Enter
    Callback = function(cmd)
        print("Executando comando:", cmd)
    end
})
```

#### Input com Limite de Caracteres

```lua
Groupbox:AddInput("CodeInput", {
    Text = "Código",
    Placeholder = "ABC123",
    MaxLength = 6,                                    -- Limite de caracteres
    AllowEmpty = false,                               -- Não permite campo vazio
    EmptyReset = "ABC123",                            -- Valor ao esvaziar
    Callback = function(value)
        print("Novo código:", value)
    end
})
```

#### Input Desabilitado (Somente Leitura)

```lua
Groupbox:AddInput("LockedInput", {
    Text = "Somente leitura",
    Default = "Bloqueado",
    Disabled = true,
    Tooltip = "Este campo não pode ser editado",
})
```

#### Controles do Input

```lua
Input_Example:SetValue("Novo texto")
Input_Example:SetDisabled(true)
Input_Example:SetVisible(false)
Input_Example:OnChanged(function(v)
    print("Valor mudou:", v)
end)
```

---

### 🎨 ColorPicker (Seletor de Cores)

```lua
Groupbox:AddColorPicker("ColorPicker", {
    Title = "Cor de Destaque",                        -- Nome exibido no menu
    Default = Color3.fromRGB(255, 0, 0),              -- Cor padrão
    Transparency = 0.1,                               -- Transparência inicial (opcional)
    Callback = function(Color, Alpha)
        -- Extrai os valores RGB da cor (0–255)
        local r = math.floor(Color.R * 255)
        local g = math.floor(Color.G * 255)
        local b = math.floor(Color.B * 255)
        print(string.format("Color: (%d, %d, %d)  Alpha: %.2f", r, g, b, Alpha))
    end
})
```

---

### ⌨️ KeyPicker (Seletor de Teclas)

```lua
Groupbox:AddKeyPicker("ToggleESP", {
    Default = "E",                                    -- Tecla inicial
    Mode = "Toggle",                                  -- Pode ser "Toggle", "Hold" ou "Always"
    Text = "Ativar ESP",                              -- Nome visível
    Callback = function(isActive)
        print("ESP Toggle:", isActive)
    end
})

-- KeyPicker encadeado (múltiplas teclas)
Groupbox:AddKeyPicker("ESPKey", {
    Default = "E",
    Mode = "Toggle",
    Text = "ESP Principal",
    SyncToggleState = true,
    Callback = function(Toggled)
        print("ESP KeyPicker Toggle:", Toggled)
    end
}):AddKeyPicker("KeyESPKEY", {
    Default = "N",
    Mode = "Toggle",
    Text = "M",
    SyncToggleState = true,
    Callback = function(Toggled)
        print("ESP KEYKeyPicker Toggle:", Toggled)
    end
})
```

---

### 🖼️ Image (Imagens)

#### Imagem Roblox Asset

```lua
local Logo = Groupbox:AddImage("LogoPrincipal", {
    Image = "rbxassetid://1234567890",                -- ID Roblox
    Height = 150,                                     -- Altura
    Color = Color3.fromRGB(255, 255, 255),            -- Cor
    RectOffset = Vector2.new(0, 0),                   -- Offset do recorte
    RectSize = Vector2.new(0, 0),                     -- Tamanho do recorte
    ScaleType = Enum.ScaleType.Fit,                   -- Tipo de ajuste
    Transparency = 0,                                 -- 0 = visível
    Visible = true,                                   -- Visibilidade inicial
    Tooltip = "Logo principal do sistema."
})
```

#### Ícone Lucide

```lua
local Icone = Groupbox:AddImage("IconeAviso", {
    Image = "alert-triangle",                         -- Nome do ícone Lucide
    Color = Color3.fromRGB(255, 200, 0),
    Height = 60,
    ScaleType = Enum.ScaleType.Fit,
    Transparency = 0,
    Visible = true,
    Tooltip = "Ícone de aviso amarelo."
})
```

#### Imagem Externa (URL)

```lua
local Banner = Groupbox:AddImage("BannerPromo", {
    Image = "https://i.imgur.com/Example.png",        -- URL da imagem
    Height = 180,
    Color = Color3.fromRGB(255, 255, 255),
    ScaleType = Enum.ScaleType.Crop,
    Transparency = 0.1,
    Visible = true,
    Tooltip = "Banner promocional de exemplo."
})
```

---

### 🔗 DependencyBox (Caixa de Dependências)

```lua
-- Toggle principal
local ToggleESP = Groupbox:AddToggle("MostrarESP", {
    Text = "Ativar ESP",
    Default = false,
    Tooltip = "Habilita o sistema ESP.",
    Callback = function(Value)
        print("ESP:", Value)
    end
})

-- Cria o container dependente
local ESPDepBox = Groupbox:AddDependencyBox()
ESPDepBox:SetupDependencies({ { ToggleESP, true } })  -- Só aparece quando ToggleESP = true

-- Adiciona elementos dentro do DepBox
ESPDepBox:AddSlider("TransparenciaESP", {
    Text = "Transparência do ESP",
    Default = 0.5,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Tooltip = "Ajusta a opacidade do ESP.",
    Callback = function(Value)
        print("Transparência:", Value)
    end
})

ESPDepBox:AddDropdown("ModoESP", {
    Text = "Modo de Destaque",
    Values = { "Outline", "Fill", "Both" },
    Default = "Outline",
    Tooltip = "Define o estilo do ESP.",
    Callback = function(Value)
        print("Modo:", Value)
    end
})
```

---

### 🔲 Botões

```lua
-- Botão simples
Groupbox:AddButton({
    Text = 'Executar Ação',
    Tooltip = 'Clique para executar',
    Func = function()
        print('Botão pressionado!')
        Library:Notify('Ação executada com sucesso!')
    end
})

-- Botão com duplo clique
Groupbox:AddButton({
    Text = 'Ação Especial',
    DoubleClick = true,                               -- Requer duplo clique
    Func = function()
        Library:Notify('Ação especial executada!', 3)
    end
})

-- Botão desabilitado
Groupbox:AddButton({
    Text = 'Indisponível',
    Disabled = true,                                  -- Botão desabilitado
    DisabledTooltip = 'Esta função não está disponível',
    Func = function() end
})
```

---

### 📝 Labels e Divisores

```lua
-- Label simples
Groupbox:AddLabel('Status: Conectado')

-- Label com múltiplas linhas
Groupbox:AddLabel('Múltiplas linhas:\nTudo funcionando!', true)

-- Divisor
Groupbox:AddDivider()
```

---

## 🎨 Tabboxes (Abas Aninhadas)

```lua
local SubTabs = Tabs.Main:AddRightTabbox()
local Combat = SubTabs:AddTab('Combate')
local Movement = SubTabs:AddTab('Movimento')

Combat:AddToggle('Aimbot', {Text = 'Aimbot', Default = false})
Movement:AddSlider('WalkSpeed', {Text = 'Velocidade', Min = 1, Max = 100, Default = 16})
```

---

## 💾 Sistema de Salvamento e Temas

```lua
-- Configurar gerenciadores
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

-- Configurações de salvamento
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({'MenuKeybind'})         -- Ignorar certas configurações

-- Definir pastas
ThemeManager:SetFolder('MeuScript')
SaveManager:SetFolder('MeuScript/Configs')

-- Adicionar seções de configuração
SaveManager:BuildConfigSection(Tabs.Settings)
ThemeManager:ApplyToTab(Tabs.Settings)

-- Carregar configuração automática
SaveManager:LoadAutoloadConfig()
```

---

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

### Notificações

```lua
-- Notificação simples
Library:Notify('Mensagem de sucesso!')

-- Notificação com duração e som
Library:Notify('Erro detectado!', 10, 4590657391)     -- Message, Time, SOUND_ID
```

---

## 🎯 Acessando e Manipulando Valores

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

---

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

---

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

---

## 📚 Dicas e Boas Práticas

1. **Organize suas funcionalidades em groupboxes** para melhor legibilidade
2. **Use tooltips** para explicar o que cada controle faz
3. **Implemente callbacks** para todas as suas funcionalidades
4. **Configure o sistema de salvamento** para persistir configurações
5. **Use keybinds** para funcionalidades importantes
6. **Teste em dispositivos móveis** para garantir compatibilidade
7. **Use notificações** para dar feedback ao usuário
8. **Utilize DependencyBox** para organizar opções avançadas
9. **Aproveite os ColorPickers e KeyPickers** para customização

---

## ⚡ Performance

A LinoriaLib é otimizada para performance máxima:
- **Renderização eficiente** - Não impacta o FPS do jogo
- **Código limpo** - Sem vazamentos de memória
- **Mobile optimized** - Funciona perfeitamente em dispositivos móveis
- **Carregamento rápido** - Interface aparece instantaneamente

---

*Desenvolvido com ❤️ para a comunidade Roblox*
