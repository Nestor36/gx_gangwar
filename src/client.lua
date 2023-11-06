ESX = exports['es_extended']:getSharedObject()


RegisterNetEvent('ggx_client:CreateGang')
AddEventHandler('gx_client:CreateGang', function(F_NameGang)

    lib.callback('gx_server:OpenMenu', source, function(result)

        print('Result OpenMenu => ', result)

        print('Result Namegang => ', F_NameGang)

        if result == 'boss' then -- Creando gang
            print('boss MENU')
        elseif result == 'member' then
            print('member MENU')
        elseif result == 'desconocido' then
            print('desconocido MENU')
            lib.callback('gx_server:CreateGang', source, false, {name_gang = F_NameGang, rank_label = 'boss'})
        elseif result == 'enemy' then
            print('Estás en territorio enemigo!')

        else
            print('Error OpenMenu')
        end
            
        
    
    end, {name_gang = F_NameGang})



--[[
    lib.callback('gx_server:GangCreate', source, function(result)
    
        print('verifygang => ', result)

        if result == 'create' then
            print('gang ya creado')
            --VerifyGang(F_NameGang)
            TriggerEvent('gx_client:VerifyGang', F_NameGang)
        elseif result == 'dntcreate' then
            print('Aún no fue creado este gang')
            TriggerEvent('gx_client:CreateGang', F_NameGang)
            --CreateGang(F_NameGang)
        else
            print('Error OpenMenu => Contactarse con el Developer')
        end

    
    end, {NameGang = F_NameGang, active = 1})
]]


end)





RegisterNetEvent('gx_client:VerifyGang')
AddEventHandler('gx_client:VerifyGang', function(F_NameGang) 
    
    print('line:45 => ', F_NameGang)

    lib.callback('gx_server:getgang', source, function(result)

        print("first => ", result)
        if result == 'boss' then

            --lib.showContext('some_menu')
            
            print('eres un boss xd')
        elseif result == 'member' then

            print('eres un member xd')
        elseif result == 'enemy' then

           print('eres un enemy xd')
        elseif result == false then

            print('Usuario sin Banda xd')
        else
            print('Error CreateGang => Contactarse con el Developer')
        
        end
    

    end, {getColumn = 'identifier', NameGang = F_NameGang, RankGang = 'member'})



end)




Citizen.CreateThread(function()
    while true do
        Citizen.Wait(3)
        local ped = PlayerPedId()
        local sleep = true
        for i = 1, #options.territorios_default do
            local actualZone = options.territorios_default[i].coords
            local dist = #(actualZone - GetEntityCoords(ped))
                if dist <= 5 then
                    sleep = false
                    if dist <= 2 then --El radius del prop (agrege este porque)
                        Gx_Notify(options.Locales[options.Language]['menu_press']..options.territorios_default[i].name, options.territorios_default[i].coords.x, options.territorios_default[i].coords.y, options.territorios_default[i].coords.z)
                        if IsControlJustPressed(0, options.controlPress) then
                            --lastZone = options.territorios_default[i].name
                            --checktest()
                            TriggerEvent('gx_client:CreateGang', options.territorios_default[i].name)

                            --TriggerEvent('gx_client:CreateGang', options.territorios_default[i].name)

                            --OpenMenu(options.territorios_default[i].name)
                            Wait(500)
                            --lib.showContext('gx_factions_main')
                        end
                    end
                end
            end
        if sleep then
            Wait(100)
        end
    end
end)


