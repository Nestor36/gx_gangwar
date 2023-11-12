ESX = exports['es_extended']:getSharedObject()


RegisterNetEvent('gx_client:CreateGang')
AddEventHandler('gx_client:CreateGang', function(F_NameGang, shopgang_disable, stashgang_disabled)

    lib.callback('gx_server:OpenMenu', source, function(result)

        print('Result OpenMenu => ', result)

        print('Result Namegang => ', F_NameGang)

        if result == 'boss' then
            print('boss MENU')
            TriggerEvent('gx_client:main-boss', F_NameGang, false, shopgang_disable, stashgang_disabled)
            --lib.showContext('boss_menu')
        elseif result == 'member' then
            print('member MENU')
            TriggerEvent('gx_client:main-boss', F_NameGang, true, shopgang_disable, stashgang_disabled)
        elseif result == 'desconocido' then
            print('desconocido MENU')
            lib.callback('gx_server:CreateGang', source, false, {name_gang = F_NameGang, rank_label = 'boss'})
        elseif result == 'enemy' then
            print('Estás en territorio enemigo!')

        else
            print('Error OpenMenu')
        end
    
    end, {name_gang = F_NameGang})


end)


Citizen.CreateThread(function()
    for i = 1, #options.territorios_default do
        CreateProps(
            options.territorios_default[i].PropModel.prop_model,
            options.territorios_default[i].Gang.coords.x,
            options.territorios_default[i].Gang.coords.y, 
            options.territorios_default[i].Gang.coords.z, 
            options.territorios_default[i].PropModel.upordown, 
            options.territorios_default[i].PropModel.heading
        )

        CreateBlips(
            options.territorios_default[i].Blip.circle.visible, 
            options.territorios_default[i].Blip.circle.color, 
            options.territorios_default[i].Blip.circle.radius, 
            options.territorios_default[i].Blip.circle.degradado,
            options.territorios_default[i].Blip.icon.visible, 
            options.territorios_default[i].Blip.icon.icon, 
            options.territorios_default[i].Blip.icon.color, 
            options.territorios_default[i].Gang.name, 
            options.territorios_default[i].Gang.coords
        )

        --TriggerEvent('gx_client:Shop_gang')
    end 

    while true do
        Citizen.Wait(3)
        local ped = PlayerPedId()
        local sleep = true
        for i = 1, #options.territorios_default do
            local actualZone = options.territorios_default[i].Gang.coords
            local dist = #(actualZone - GetEntityCoords(ped))
                if dist <= 5 then
                    sleep = false
                    if dist <= 2 then --El radius del prop (agrege este porque)
                        Gx_Notify(options.Locales[options.Language]['menu_press']..options.territorios_default[i].Gang.name, options.territorios_default[i].Gang.coords.x, options.territorios_default[i].Gang.coords.y, options.territorios_default[i].Gang.coords.z)
                        if IsControlJustPressed(0, options.controlPress) then
                            --lastZone = options.territorios_default[i].name
                            --checktest()
                            TriggerEvent('gx_client:CreateGang', options.territorios_default[i].Gang.name, options.territorios_default[i].Gang.shopgang_disabled, options.territorios_default[i].Gang.stashgang.disabled)

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


