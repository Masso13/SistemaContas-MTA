function string.count (text, search)
	if ( not text or not search ) then return false end
	
	return select ( 2, text:gsub ( search, "" ) );
end

function string.replace(s, str, r)
    local nums = string.count(s, str)
    local s = s

    if nums > 0 then
        for n=1,nums do
            local pos = string.find(s, str)
            if pos then
                s = string.format("%s%s%s", string.sub(s, 1, pos-1), r, string.sub(s, pos+1))
            end
        end
        return s
    else
        return false
    end
end


addEvent("createAccount", true)
addEventHandler("createAccount", root, 
    function(name, data, sex)
        if getAccount(name) then
            outputChatBox("Existe")
        else
            local name2 = string.replace(name, " ", "_") or name
            local age = (getRealTime().year + 1900) - tonumber(string.sub(data, 7))
            local ac = addAccount(name2, "auto")
            if ac then
                setAccountData(ac, "Nome", name)
                setAccountData(ac, "Idade", age)
                setAccountData(ac, "Sexo", sex)
                logIn(client, ac, "auto")
                clearChatBox(client)
                triggerClientEvent(client, "ShowHUDLogin", root, ac)
                triggerClientEvent(client, "add:notification", root, "Registro feito com sucesso", "success", true)
            else
                triggerClientEvent(client, "add:notification", root, "Houve algum problema com essa conta", "error", true)
            end
        end
    end, true, "low")

addEvent("loginAccount", true)
addEventHandler("loginAccount", root, 
    function(id)
        local ac = getAccountByID(id)
        if ac then
            if logIn(client, ac, "auto") then
                clearChatBox(client)
                triggerClientEvent(client, "ShowHUDLogin", root, ac)
                triggerClientEvent(client, "add:notification", root, "Escolha feita com sucesso", "success", true)
            else
                triggerClientEvent(client, "add:notification", root, "Houve algum problema com essa conta", "error", true)
            end
        end
    end, true, "low")