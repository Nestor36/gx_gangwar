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





















lib.registerContext({
    id = 'a',
    title = 'Abrir el menú',
    options = {
      {
        title = 'Empty button',
      },
      {
        title = 'Disabled button',
        description = 'This button is disabled',
        icon = 'hand',
        disabled = true
      },
      {
        title = 'Example button',
        description = 'Example button description',
        icon = 'circle',
        onSelect = function()
          print("Pressed the button!")
        end,
        metadata = {
          {label = 'Value 1', value = 'Some value'},
          {label = 'Value 2', value = 300}
        },
      },
      {
        title = 'Menu button',
        description = 'Takes you to another menu!',
        menu = 'other_menu',
        icon = 'bars'
      },
      {
        title = 'Event button',
        description = 'Open a menu from the event and send event data',
        icon = 'check',
        event = 'test_event',
        arrow = true,
        args = {
          someValue = 500
        }
      }
    }
    
  })