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
            local dist = #(options.territorios_default[i].Gang.coords - GetEntityCoords(ped))
            local distG = #(options.territorios_default[i].Gang.garage.coords - GetEntityCoords(ped))
            
            if dist <= 5*(options.territorios_default[i].Blip.circle.radius*2) then
                if options.territorios_default[i].Gang.Text2D then
                    CreateTexT2D('Estás en el territorio de ~r~', options.territorios_default[i].Gang.name)
                end
                sleep = false
                if dist <= 2 then
                    Gx_Notify(options.Locales[options.Language]['menu_press']..options.territorios_default[i].Gang.name, options.territorios_default[i].Gang.coords.x, options.territorios_default[i].Gang.coords.y, options.territorios_default[i].Gang.coords.z)
                    if IsControlJustPressed(0, options.controlPress) then
                        TriggerEvent('gx_client:CreateGang', options.territorios_default[i].Gang.name, options.territorios_default[i].Gang.shopgang_disabled, options.territorios_default[i].Gang.stashgang.disabled)
                        Wait(500)
                    end
                end
            end

            if distG <= 2 and not options.territorios_default[i].Gang.garage.disabled then
                Gx_Notify(options.territorios_default[i].Gang.name, options.territorios_default[i].Gang.garage.coords.x, options.territorios_default[i].Gang.garage.coords.y, options.territorios_default[i].Gang.garage.coords.z)
                if IsControlJustPressed(0, options.controlPress) then
                --sleep = false
                    TriggerEvent('gx_client:OpenGarage', options.territorios_default[i])
                --TriggerEvent('gx_client:garage', options.territorios_default[i])
                --if IsControlJustPressed(0, options.controlPress) then
                --    print('yes')
                --end
                Wait(500)
                end
            end
            --if dist <= 5 then
        end
        if sleep then
            Wait(100)
        end
    end

end)

RegisterNetEvent('gx_client:OpenGarage', function(data)

    lib.callback('gx_server:OpenMenu', source, function(result)
  
      print('Result OpenMenu => ', result)
  
      print('Result Namegang => ', data.Gang.name)
  
      if result == 'boss' then
          print('boss MENU')
          --TriggerEvent('gx_client:main-boss', F_NameGang, false, shopgang_disable, stashgang_disabled)
          --lib.showContext('boss_menu')
          TriggerEvent('gx_client:OpenMainGarage', data)
      elseif result == 'member' then
          print('member MENU')
          --TriggerEvent('gx_client:main-boss', F_NameGang, true, shopgang_disable, stashgang_disabled)
      elseif result == 'desconocido' then
          print('desconocido MENU')
          --lib.callback('gx_server:CreateGang', source, false, {name_gang = F_NameGang, rank_label = 'boss'})
      elseif result == 'enemy' then
          print('Estás en territorio enemigo!')
  
      else
          print('Error OpenMenu')
      end
  
    end, {name_gang = data.Gang.name})
end)  




RegisterNetEvent('gx_client:garage')
AddEventHandler('gx_client:garage', function(data)
    local playerPed = PlayerPedId()
    Gx_Notify(data.Gang.name, data.Gang.garage.coords.x, data.Gang.garage.coords.y, data.Gang.garage.coords.z)

    if IsPedInAnyVehicle(playerPed, false) and IsControlJustPressed(0, options.controlPress) then
      
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
        local vehicleName = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
        local vehiclePlate = ESX.Game.GetVehicleProperties(vehicle).plate
        
        print('Estás en un vehículo.')
        print('Placa del vehículo: ' .. vehiclePlate)
        print('Nombre del vehículo: ' .. vehicleName)
        print('Propiedades del vehículo: ' .. json.encode(vehicleProps))

        local result = lib.callback('gx_server:garage', source, false, {condicion = 'guardar', plate = vehiclePlate, name = vehicleName, property = json.encode(vehicleProps), name_gang = data.Gang.name})
        
        if result == 'YaExiste' then
            print('ya existe un auto!')
        else
            Citizen.InvokeNative(0xAE3CBE5BF394C9C9, Citizen.PointerValueIntInitialized(vehicle))
            print('Guardaste el vehículo')
        end
    
    else


    end

    
end)    


-- 🐧