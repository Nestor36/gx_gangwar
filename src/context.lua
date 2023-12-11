ESX = exports['es_extended']:getSharedObject()

RegisterNetEvent('gx_client:main-boss', function(name_gang, rank_disable, shopgang_disable, stashgang_disabled)
  --[[
    Teniendo en cuenta que args, puede ser admitido con diferentes data,
    podría intentar poner el texto del territorio, en caso contrario para
    ahorrarse mls, podrías simplemente evitarlo.
  ]]
  lib.registerContext({
    id = 'boss_menu',
    title = name_gang,
    options = {
      {
        title = 'Abrir Inventario de Jefe',
        description = 'Ver Almacén del Jefe',
        icon = 'chess-king',
        iconColor = 'yellow',
        disabled = rank_disable,
        onSelect = function()

          for i = 1, #options.territorios_default do
            if name_gang == options.territorios_default[i].Gang.name then
              lib.callback('gx_server:StashBoss', source, false, {name_gang = name_gang, slots = options.territorios_default[i].Gang.stashboss.slots, weight = options.territorios_default[i].Gang.stashboss.weight})
              Wait(100)
              exports['ox_inventory']:openInventory('stash', {id='Boss - '..name_gang})
            end -- guxboss
          end

        end
      },
      {
        title = 'Invitar a un usuario',
        description = 'Debes colocar el ID del usuario',
        icon = 'user-plus',
        iconColor = 'white',
        disabled = rank_disable,
        onSelect = function()
        -- Queda en mantenimiento esto.
          local input = lib.inputDialog('Invitar nuevo miembro', {{ type = "number", label = "ID del Jugador", default = 0 }})
            if not input then return end
            local IdPlayer = tonumber(input[1])
            lib.callback('gx_server:invitePlayer', source, function(result)
            if result == 'desconectado' then
              print('el Jugador está desconectado')
            elseif result == 'AlreadyMember' then
              print('el jugador ya pertenece a esta banda')
            elseif result == 'Enemy' then
              print('el Jugador ya está en una banda!')
            elseif result == 'Invited' then
              print('El jugador fue invitado')
            else
              print('Ocurrio un error')
            end
          end, {name_gang = name_gang, PlayerId = IdPlayer })
        
        end
      },
      {
        title = 'Eliminar a un usuario',
        description = 'Debes colocar el ID del usuario',
        icon = 'person-circle-check',
        iconColor = 'red',
        disabled = rank_disable,
        onSelect = function()
          local input = lib.inputDialog('Eliminar miembro', {{ type = "number", label = "ID del miembro", default = 0 }})
          if not input then return end

          local IdPlayer = tonumber(input[1])

          lib.callback('gx_server:removePlayer', source, function(result)
            if result == 'desconectado' then
              lib.alertDialog({
                header = name_gang,
                content = 'El jugador está desconectado',
                centered = true,
                size = 'sm',
                labels = {confirm = 'confirmar'}
              })
              print('el jugador está desconectado')
            elseif result == 'Enemy' then
              lib.alertDialog({
                header = name_gang,
                content = 'El jugador no pertenece a esta banda',
                centered = true,
                size = 'sm',
                labels = {confirm = 'confirmar'}
              })
              print('el usuario no pertenece a esta banda')
            elseif result == 'Imposible' then
              lib.alertDialog({
                header = name_gang,
                content = 'Eres el Jefe de la banda, no puedes echarte!',
                centered = true,
                size = 'sm',
                labels = {confirm = 'confirmar'}
              })
              print('Eres el Jefe de la banda, no puedes echarte!')
            else
              local alert = lib.alertDialog({
                header = name_gang,
                content = 'Estás a punto de echar a '..result,
                centered = true,
                cancel = true,
                size = 'sm',
                labels = {cancel = 'cancelar', confirm = 'confirmar'}
              })
              print(alert)
              if alert ~= 'confirm' then return end
                lib.callback('gx_server:ConfirmRemovePlayer', source, false, {PlayerId = IdPlayer})
            end

          end, {searchInf = 'FirstLastName', PlayerId = IdPlayer, name_gang = name_gang})

        end
      },
      {
        title = 'Abrir Almacén',
        description = 'Almacén de la Banda',
        icon = 'suitcase',
        iconColor = 'Brown',
        disabled = stashgang_disabled,
        onSelect = function()
          for i = 1, #options.territorios_default do
            if name_gang == options.territorios_default[i].Gang.name then
              lib.callback('gx_server:StashGang', source, false, {name_gang = name_gang, slots = options.territorios_default[i].Gang.stashgang.slots, weight = options.territorios_default[i].Gang.stashgang.weight})
              Wait(100)
              exports['ox_inventory']:openInventory('stash', {id=name_gang})
            end
          end
        end
      },
      {
        title = 'Abrir Tienda',
        description = 'Tienda de la Banda',
        icon = 'shop',
        iconColor = 'blue',
        disabled = shopgang_disable,
        onSelect = function()
          for i = 1, #options.territorios_default do
            if name_gang == options.territorios_default[i].Gang.name then
            
              local input = lib.inputDialog('Tienda de '..name_gang, options.territorios_default[i].Gang.shopgang)
              Wait(100)
              if not input then return end

              for e = 1, #options.territorios_default[i].Gang.shopgang do
                local cantidad = input[e]
                print('cantidad =>', cantidad)
                if cantidad then else cantidad = 0 end

                print(options.territorios_default[i].Gang.shopgang[e].price)

                item = options.territorios_default[i].Gang.shopgang[e].item
                precio = options.territorios_default[i].Gang.shopgang[e].price

                lib.callback('gx_server:ShopGang', source, false, {item = item, cantidad = cantidad, precio = precio})
                Wait(100)
              end
            end
          end
        end
      },
    }
  })
 
  lib.showContext('boss_menu')
end)



RegisterNetEvent('gx_client:OpenMainGarage', function(data)
  local playerPed = PlayerPedId()


  if IsPedInAnyVehicle(playerPed, false) then
      
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    local vehiclePlateA = ESX.Game.GetVehicleProperties(vehicle).plate
    if not VerifyTexT(vehiclePlateA) then
      ESX.Game.SetVehicleProperties(vehicle, {plate = 'GX'..vehiclePlateA,})
    end
    local vehiclePlateB = ESX.Game.GetVehicleProperties(vehicle).plate
    --ESX.Game.SetVehicleProperties(vehicle, {plate = 'GX'..vehiclePlate,})
    local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
    local vehicleName = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
   -- local vehiclePlate = ESX.Game.GetVehicleProperties(vehicle).plate



    
    print('Estás en un vehículo.')
    print('Placa del vehículo: ' .. vehiclePlateB)
    print('Nombre del vehículo: ' .. vehicleName)
    print('Propiedades del vehículo: ' .. json.encode(vehicleProps))

    local result = lib.callback('gx_server:garage', source, false, {condicion = 'guardar', plate = vehiclePlateB, name = vehicleName, property = json.encode(vehicleProps), name_gang = data.Gang.name})
    
    if result == 'YaExiste' then
        print('ya existe un auto!')
        lib.notify({
          title = 'Garage Gang',
          description = 'Guardaste el vehículo',
          position = 'top',
          type = 'warning',
      })
    else
        Citizen.InvokeNative(0xAE3CBE5BF394C9C9, Citizen.PointerValueIntInitialized(vehicle))
        print('Guardaste el vehículo')
        lib.notify({
          title = 'Garage Gang',
          description = 'Guardaste el vehículo',
          position = 'top',
          type = 'inform',
      })
    end

  else


    local result = lib.callback('gx_server:garage', source, false, {condicion = 'sacar', plate = vehiclePlate, name = vehicleName, property = json.encode(vehicleProps), name_gang = data.Gang.name})

    --  print(result.plate)
    
    if result and #result > 0 then
      local options = {}

      -- Iterar sobre la tabla para construir opciones de menú
      for _, date in ipairs(result) do

          print(json.encode(date), _)
          local option = {
              title = date['vehicleName'],
              description = 'Plate: ' .. date['vehiclePlate'],
              icon = 'car',
              onSelect = function()

                lib.notify({
                  title = 'Garage Gang',
                  description = 'Sacaste un vehículo',
                  position = 'top',
                  type = 'success',
              })
                --local coordsGarage = vector4(data.Gang.garage.coords.x, data.Gang.garage.coords.y, data.Gang.garage.coords.z, data.Gang.garage.coords.heading)
                  print('Seleccionado: ' .. date['vehiclePlate'])
                  print(data.Gang.garage.coords, data.Gang.garage.heading)
                  lib.callback('gx_server:garage', source, false, {condicion = 'spawnvehicle', plate = date['vehiclePlate'], name = date['vehicleName'], property = date['vehicleProperty'], coords = data.Gang.garage.coords, heading = data.Gang.garage.heading})
              end
          }
          table.insert(options, option)
      end

      -- Crear el menú con las opciones
      lib.registerContext({
          id = 'Garage_car',
          title = 'Menu de Vehículos',
          options = options
      })
      lib.showContext('Garage_car')
    else
        print('La tabla está vacía o no es válida.')
        lib.notify({
          title = 'Garage Gang',
          description = 'No hay vehículos',
          position = 'top',
          style = {
              backgroundColor = '#141517',
              color = '#C1C2C5',
              ['.description'] = {
                color = '#909296'
              }
          },
          icon = 'ban',
          iconColor = '#C53030'
      })
    end

  end
  
end)


  -- 🐧