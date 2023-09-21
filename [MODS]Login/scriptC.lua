loadstring(exports.dgs:dgsImportFunction())()

--[[ Configurações do Timer ]]--
local diviser = 100
local seconds = 5000
local images = 9
--[[ -=-=-=-=-=-=-=-=-=-=-=- ]]--

local font_age = dgsCreateFont(":include/src/fonts/font.ttf", 15)
local cooldown = 0
local is_visible = false
local accounts = {}

addEvent("ShowHUDLogin", true)
addEventHandler("ShowHUDLogin", root,
    function(ac)
        accounts = ac
        closeAll()
    end
)

local LoginHud = {}

function renderLife() -- Renderiza o painel de registro
    --[[ Cria as categorias ]]--
    LoginHud["Life"] = {}
    LoginHud["Life"]["radioButtons"] = {}
    LoginHud["Life"]["Buttons"] = {}
    --[[ -=-=-=-=-=-=-=-=-=- ]]--

    LoginHud["Life"]["frame"] = dgsCreateImage(0.2279, 0.1354, 0.5441, 0.7305, "frames/frameLife.png", true, LoginHud.FundoPreto)

    --[[ Cria as caixas de edição de texto ]]--
    LoginHud["Life"]["nome"] = dgsCreateEdit(0.31, 0.18, 0.40, 0.07, "NOME", true, LoginHud.Life.frame, tocolor(0, 0, 0), _, _, _, tocolor(255, 255, 255))
    dgsSetProperty(LoginHud.Life.nome, "caretColor", tocolor(0, 0, 0))
    dgsSetProperty(LoginHud.Life.nome, "font", font_age)
    dgsSetProperty(LoginHud.Life.nome, "alignment", {"center", "center"})
    LoginHud["Life"]["data"] = dgsCreateEdit(0.31, 0.31, 0.40, 0.07, "00/00/0000", true, LoginHud.Life.frame, tocolor(0, 0, 0), _, _, _, tocolor(255, 255, 255))
    dgsSetProperty(LoginHud.Life.data, "caretColor", tocolor(0, 0, 0))
    dgsSetProperty(LoginHud.Life.data, "font", font_age)
    dgsSetProperty(LoginHud.Life.data, "alignment", {"center", "center"})
    --[[ -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- ]]--

    --[[ Cria os botões de radio ]]--
    LoginHud["Life"]["radioButtons"]["masculino"] = dgsCreateRadioButton(0.31, 0.42, 0.15, 0.09, "MASCULINO", true, LoginHud.Life.frame, tocolor(0, 0, 0), _, _, _, _, _, _, _, _, _, _, _, tocolor(181, 2, 2), tocolor(181, 2, 2), tocolor(181, 2, 2, 70.))
    dgsSetProperty(LoginHud.Life.radioButtons.masculino, "font", font_age)
    LoginHud["Life"]["radioButtons"]["feminino"] = dgsCreateRadioButton(0.55, 0.42, 0.15, 0.09, "FEMININO", true, LoginHud.Life.frame, tocolor(0, 0, 0), _, _, _, _, _, _, _, _, _, _, _, tocolor(181, 2, 2), tocolor(181, 2, 2), tocolor(181, 2, 2, 70.))
    dgsSetProperty(LoginHud.Life.radioButtons.feminino, "font", font_age)
    --[[ -=-=-=-=-=-=-=-=-=-=-=-=- ]]--

    --[[ Cria os botões de ações ]]--
    LoginHud["Life"]["Buttons"]["voltar"] = dgsCreateButton(0.31, 0.6, 0.15, 0.1, "VOLTAR", true, LoginHud.Life.frame, _, _, _, _, _, _, tocolor(181, 2, 2), tocolor(181, 2, 2, 70.), tocolor(181, 2, 2, 70.))
    dgsSetProperty(LoginHud.Life.Buttons.voltar, "font", font_age)
    LoginHud["Life"]["Buttons"]["vida"] = dgsCreateButton(0.56, 0.6, 0.15, 0.1, "NASCER", true, LoginHud.Life.frame, _, _, _, _, _, _, tocolor(181, 2, 2), tocolor(181, 2, 2, 70.), tocolor(181, 2, 2, 70.))
    dgsSetProperty(LoginHud.Life.Buttons.vida, "font", font_age)
    --[[ -=-=-=-=-=-=-=-=-=-=-=- ]]--

    addEventHandler("onDgsTextChange", LoginHud.Life.data, dataChange)
end

function renderFrames() -- Renderiza o painel de login
    LoginHud["Frames"] = {}
    local x, x2 = 0.0662, 0.1169

    for i=1,3 do
        --[[ Cria as categorias ]]--
        LoginHud.Frames["frame"..i] = {}
        LoginHud.Frames["frame"..i]["Labels"] = {}
        LoginHud.Frames["frame"..i]["Buttons"] = {}
        --[[ -=-=-=-=-=-=-=-=-=- ]]--

        LoginHud.Frames["frame"..i]["frame"] = dgsCreateImage(x, 0.1354, 0.2382, 0.7305, "frames/framePerson.png", true, LoginHud.Efeito)
        
        --[[ Cria os elementos do frame ]]--
        if i <= table_length(accounts) and table_length(accounts) > 0 then
            local lenght_name = string.len(accounts["frame"..i].name)
            local font_name = dgsCreateFont(":include/src/fonts/font.ttf", mapRange(lenght_name, 2, 12, 48, 20))

            --[[ Cria as labels ]]--
            LoginHud.Frames["frame"..i].Labels["name"] = dgsCreateLabel(0.4, 0.1, 0.2596, 0.2708, accounts["frame"..i].name, true, LoginHud.Frames["frame"..i].frame, tocolor(0, 0, 0), _, _, _, _, _, "center", "center")
            dgsSetProperty(LoginHud.Frames["frame"..i].Labels.name, "font", font_name)
            LoginHud.Frames["frame"..i].Labels["age"] = dgsCreateLabel(0.35, 0.3, 0.2868, 0.3359, "IDADE: "..accounts["frame"..i].age, true, LoginHud.Frames["frame"..i].frame, tocolor(0, 0, 0), _, _, _, _, _, "center", "center")
            dgsSetProperty(LoginHud.Frames["frame"..i].Labels.age, "font", font_age)
            LoginHud.Frames["frame"..i].Labels["work"] = dgsCreateLabel(0.35, 0.35, 0.2868, 0.4115, "EMPREGO: "..accounts["frame"..i].work, true, LoginHud.Frames["frame"..i].frame, tocolor(0, 0, 0), _, _, _, _, _, "center", "center")
            dgsSetProperty(LoginHud.Frames["frame"..i].Labels.work, "font", font_age)
            --[[ -=-=-=-=-=-=-=- ]]--

            LoginHud.Frames["frame"..i].Buttons["choice"] = dgsCreateButton(0.3, 0.7, 0.4, 0.1, "ESCOLHER", true, LoginHud.Frames["frame"..i].frame, _, _, _, _, _, _, tocolor(181, 2, 2, 170), tocolor(181, 2, 2, 70.), tocolor(181, 2, 2, 70.))
            dgsSetProperty(LoginHud.Frames["frame"..i].Buttons.choice, "font", font_age)
        else
            LoginHud.Frames["frame"..i].Buttons["vida"] = dgsCreateButton(0.3, 0.4, 0.4, 0.1, "DAR A VIDA", true, LoginHud.Frames["frame"..i].frame, _, _, _, _, _, _, tocolor(181, 2, 2, 170), tocolor(181, 2, 2, 70.), tocolor(181, 2, 2, 70.))
            dgsSetProperty(LoginHud.Frames["frame"..i].Buttons.vida, "font", font_age)
        end
        --[[ -=-=-=-=-=-=-=-=-=-=-=-=-=- ]]--
        
        x = x + 0.3147
    end
end


function renderBackground() -- Renderiza o fundo com a animação
    LoginHud["FundoPreto"] = dgsCreateImage(0.0000, 0.0000, 1.0000, 1.0000, "frames/background.png", true)
    LoginHud["Fundo"] = dgsCreateImage(0.0000, 0.0000, 1.0000, 1.0000, "frames/fundo1.png", true, LoginHud.FundoPreto)

    local point = 1/diviser
    local delay = seconds/diviser

    local mode = 0
    local alpha = 1
    local sec = 0
    local npoint = -point
    local image_back = 1
    local image_next = 1
    LoginHud["timer"] = setTimer(
        function()
            if sec < seconds then
                alpha = alpha + npoint
                sec = sec + delay
            else
                sec = 0
                npoint = npoint * (-1)
                if alpha < 1 then
                    image_next = IfElse(image_next >= images, 1, image_next + 1)
                end
            end
            dgsSetAlpha(LoginHud.Fundo, alpha)
            if image_next ~= image_back then
                dgsImageSetImage(LoginHud.Fundo, "frames/fundo"..image_next..".png")
                image_back = image_next
            end
        end
    , delay, 0)
end

function LoginDgs()
    renderBackground()
    LoginHud["Efeito"] = dgsCreateImage(0.0000, 0.0000, 1.0000, 1.0000, _, true, LoginHud.FundoPreto, tocolor(0, 0, 0, 0))
    renderFrames()
end

function dataChange()
    local data = dgsGetText(source)
    if data == "00/00/000" then data = "" end
    local process = processData(data)
    dgsSetText(source, process)
end

function closeAll()
    if LoginHud.Fundo then
        if isElement(LoginHud.Fundo) then
            destroyElement(LoginHud.Fundo)
            destroyElement(LoginHud.FundoPreto)
            killTimer(LoginHud.timer)
            LoginHud = {}
            is_visible = false
            showCursor(false)
        end
    else
        LoginDgs()
        is_visible = true
        showCursor(true)
    end
end

function closeTab(tab)
    if tab == "Frames" then
        for frame in pairs(LoginHud.Frames) do
            destroyElement(LoginHud.Frames[frame].frame)
        end
    else
        destroyElement(LoginHud.Life.frame)
    end
    LoginHud[tab] = nil
end

function sendLogin(frame)
    if createCooldown(cooldown) then
        local id = accounts[frame].id
        triggerServerEvent("loginAccount", localPlayer, id)
        cooldown = getTickCount()
    end
end

function verifyDefault(name, data, sex)
    if name ~= "Nome" and data ~= "00/00/0000" and sex then return false else return true end
end

function sendRegistry()
    if createCooldown(cooldown) then
        local nome = dgsGetText(LoginHud.Life.nome)
        local data = dgsGetText(LoginHud.Life.data)
        local sexo = false
        for b in pairs(LoginHud.Life.radioButtons) do
            if dgsRadioButtonGetSelected(LoginHud.Life.radioButtons[b]) then
                sexo = b
            end
        end

        if not verifyDefault(nome, data, sexo) then
            triggerServerEvent("createAccount", localPlayer, string.lower(nome), data, sexo)
        else
            triggerEvent("add:notification", root, "Você precisa alterar o padrão para registrar", "error", true)
        end
        cooldown = getTickCount()
    end
end


addEventHandler("onDgsMouseDown", getRootElement(),
    function(button, x, y)
        if button == "left" and is_visible then
            if LoginHud.Frames then
                local check = false
                for frame in pairs(LoginHud.Frames) do if LoginHud.Frames[frame].Buttons.vida and source == LoginHud.Frames[frame].Buttons.vida then closeTab("Frames") renderLife() break elseif LoginHud.Frames[frame].Buttons.choice and source == LoginHud.Frames[frame].Buttons.choice then sendLogin(frame) end end

            elseif LoginHud.Life then
                if source == LoginHud.Life.Buttons.vida then
                    sendRegistry()
                elseif source == LoginHud.Life.Buttons.voltar then
                    closeTab("Life")
                    renderFrames()
                end
            end
       end
    end, true, "low"
)

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
    function()
        triggerServerEvent("requestAccounts", localPlayer)
    end
)

addCommandHandler("hud",  
    function()
        closeAll()
    end
)