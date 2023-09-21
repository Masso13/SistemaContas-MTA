addEvent("requestAccounts", true)
addEventHandler("requestAccounts", root, 
    function()
        local serial = getPlayerSerial(client)
        local accounts = getAccountsBySerial(serial) or {}
        if #accounts <= 3 then
            local process = {}
            for i, ac in ipairs(accounts) do
                process["frame"..i] = {}
                process["frame"..i]["name"] = string.upper(string.sub(getAccountData(ac, "Nome") or "ALGUEM", 1, 11))
                process["frame"..i]["age"] = getAccountData(ac, "Idade") or 18
                process["frame"..i]["work"] = getAccountData(ac, "Emprego") or "Nenhum"
                process["frame"..i]["id"] = getAccountID(ac)
            end
            triggerClientEvent(client, "ShowHUDLogin", root, process)
        end
    end, true)