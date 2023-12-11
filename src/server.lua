ESX = exports['es_extended']:getSharedObject()

lib.callback.register('gx_server:OpenMenu', function(source, data)
    Player = ESX.GetPlayerFromId(source)

    local getInf = MySQL.query.await('SELECT * FROM users WHERE identifier = ?', {Player.identifier})

    print('1 => ', getInf[1].name_gang)
    print('2 => ', data.name_gang)

    if getInf[1] then

        if getInf[1].name_gang == data.name_gang and getInf[1].rank_label == 'boss' then 
            return 'boss'
        end
        if getInf[1].name_gang == data.name_gang and getInf[1].rank_label == 'member' then
            return 'member'
        end
        if getInf[1].name_gang == 'desconocido' then 
            --print("No pertenece a ninguna banda")
            return 'desconocido' -- Es posible crear una banda
        end
        if getInf[1].name_gang ~= data.name_gang then
        
            return 'enemy'

        end
        
        print('No es ["member", "boss", "desconocido"]')
        print('Verifique la tabla de rank_label')
        
    else 
        print('No se pudo encontrar la identificación del usuario')
    end

end)





lib.callback.register('gx_server:CreateGang', function(source, data)
    Player = ESX.GetPlayerFromId(source)
    local getInf = MySQL.query.await('SELECT * FROM users WHERE identifier = ?', {Player.identifier})
    local result = MySQL.query.await('SELECT * FROM gx_gangowner WHERE name_gang = ?', {data.name_gang})

    if result[1] then

        print("aea => ", result[1].name_gang)

        if result[1].name_gang == getInf[1].name_gang then
            print("tu territorio")
        else
            print("no es tu territorio")
        end

        if result[1].active == 1 then

        end

    else
        MySQL.insert('INSERT INTO gx_gangowner (name_gang, active) VALUES (?, ?) ', {data.name_gang, 1})

        MySQL.insert('UPDATE users SET name_gang=@name_gang, rank_label=@rank_label WHERE identifier=@identifier', {['@name_gang'] = data.name_gang, ['@rank_label'] = data.rank_label, ['@identifier'] = Player.identifier})
    end

end)




lib.callback.register('gx_server:ShopGang', function(source, data) 

    print(data.precio, data.item, data.cantidad)

    Player = ESX.GetPlayerFromId(source)

    local item = exports.ox_inventory:GetItem(source, 'money', nil, false)
    
    print('cantidad de item =>', item.count)
    --print('item =>',data.item,'precio =>',data.precio )

    print('cantidad =>', data.cantidad)

    if data.cantidad == 0 then 
         
    elseif item.count >= data.precio then
        exports.ox_inventory:RemoveItem(source, 'money', data.precio*data.cantidad)
        exports.ox_inventory:AddItem(source, data.item, data.cantidad)
    else
        print('no hay dinero xd')
    end



end)

lib.callback.register('gx_server:StashBoss', function(source, data)

    exports['ox_inventory']:RegisterStash('Boss - '..data.name_gang, 'Boss - '..data.name_gang, data.slots, data.weight, false)

end)

lib.callback.register('gx_server:StashGang', function(source, data)

    exports['ox_inventory']:RegisterStash(data.name_gang, 'Inventario de '..data.name_gang, data.slots, data.weight, false)

end)

--[[ INVITE PLAYER]]

lib.callback.register('gx_server:invitePlayer', function(source, data)
    Player = ESX.GetPlayerFromId(data.PlayerId)
    if not Player then return 'desconectado' end
    local getInf = MySQL.query.await('SELECT * FROM users WHERE identifier = ?', {Player.identifier})

    if getInf[1].name_gang == data.name_gang then
        return 'AlreadyMember'
    end
    if getInf[1].name_gang ~= 'desconocido' then
        return 'Enemy'
    end
    if getInf[1].name_gang == 'desconocido' then
        MySQL.query.await(MySQL.insert('UPDATE users SET name_gang=@name_gang, rank_label=@rank_label WHERE identifier=@identifier', {['@name_gang'] = data.name_gang, ['@rank_label'] = 'member', ['@identifier'] = Player.identifier}))
        return 'Invited'
    end

end)



--[[ REMOVE PLAYER ]]

lib.callback.register('gx_server:removePlayer', function(source, data)
    Player = ESX.GetPlayerFromId(data.PlayerId)
    if not Player then return 'desconectado' end
    local getInf = MySQL.query.await('SELECT * FROM users WHERE identifier = ?', {Player.identifier})

    --if getInf[1].name_gang == 
    -- Identificar sí el usuario no tiene Banda
    --print("invite => ", data.name_gang.." ~= ".. getInf[1].name_gang)
    if getInf[1].name_gang ~= data.name_gang then 
        return 'Enemy'
    end
    if getInf[1].rank_label == 'boss' then
        return 'Imposible'
    end
    if getInf and data.searchInf == 'FirstLastName' then
        return getInf[1].firstname..' '..getInf[1].lastname
    end

    -- intentar poner la función q falta para echar al miembro, agregando un parametro más para ahorrar
    -- líneas de código
end)

lib.callback.register('gx_server:ConfirmRemovePlayer', function(source, data)
    Player = ESX.GetPlayerFromId(data.PlayerId)
    if not Player then return 'desconectado' end
    MySQL.insert('UPDATE users SET name_gang=@name_gang, rank_label=@rank_label WHERE identifier=@identifier', {['@name_gang'] = 'desconocido', ['@rank_label'] = 'desconocido', ['@identifier'] = Player.identifier})
    print('usuario eliminado')

end)



--[[ GARAGE GANG ]]

lib.callback.register('gx_server:garage', function(source, data)

    if data.condicion == 'guardar' then
    
        local result = MySQL.query.await('SELECT * FROM gx_gangcar WHERE name_gang = ?', {data.name_gang})

        for i = 1, #result do
            if result[i].plate == data.plate then
                return 'YaExiste'
            end
        end
        
        MySQL.insert('INSERT INTO gx_gangcar (plate, name_gang, name, properties) VALUES (?, ?, ?, ?) ', {
            data.plate, data.name_gang, data.name, data.property})

    end

    if data.condicion == 'sacar' then
        -- Usando FIVEM SQL
        local result = MySQL.query.await('SELECT * FROM gx_gangcar WHERE name_gang = ?', {data.name_gang})

        --return result[1]
        garageData = {}
        
        if json.encode(result) ~= "[]" then

            for i, v in ipairs(result) do
               
                garageData[#garageData+1] = {
                    ["vehicleProperty"] = json.decode(result[i].properties),
                    ["vehicleName"] = result[i].name,
                    ["vehiclePlate"] = result[i].plate
                }
            end

        else
            return nil
        end

        return garageData

    end

    if data.condicion == 'spawnvehicle' then
        
        local playerPed = GetPlayerPed(-1)

        -- Aquí define la posición donde quieres que aparezca el vehículo
        --local spawnCoords = vector4(data.coords.x, data.coords.y, data.coords.z, data.heading)
    
        -- Crea el vehículo en la posición especificada

        -- Coloca al jugador dentro del vehículo
        


        local SpawnPoint = vector3(data.coords.x, data.coords.y, data.coords.z)
        ESX.OneSync.SpawnVehicle(joaat(data.name), SpawnPoint, data.heading, data.property, function()
            --putPlayerInVehicle(data.name)
           -- TaskWarpPedIntoVehicle(playerPed, data.property.plate, -1)
            --TaskWarpPedIntoVehicle(GetPlayerPed(source), vehicle, -1)
        end)
        
        --
        --TaskWarpPedIntoVehicle()

        --ESX.Game.SetVehicleProperties(data.name, data.property)
        Wait(100)
        
        MySQL.query('DELETE FROM gx_gangcar WHERE plate = @plate', { ['@plate'] = data.plate })
    end

    

    



end)







-- 🐧