ESX = exports['es_extended']:getSharedObject()

lib.callback.register('gx_server:getgang', function(source, SQL)
    Player = ESX.GetPlayerFromId(source)
	   -- ESX
	local result = MySQL.query.await('SELECT * FROM gx_gangwar WHERE identifier = ?', {Player.identifier})
    --print("Sline:7 => ", json.encode(result[1].identifier))

    print("a")

	if result[1] and SQL.getColumn == "identifier" then
		--print(result[1])
        print("b")
        if SQL.NameGang == result[1].name_gang then
            
            print('efectivamente es tu territorio')

            if SQL.RankGang == result[1].rank_label then
                print('Efectivamente eres un member')
                return 'member'
            else
                print('Efectivamente eres un Boss')
                return 'boss'
            end
            
        else
            print('no es tu territorio')
            return 'enemy'
        end
		--return(result[1])
	--elseif result[1] and SQL.getColumn == "name_gang" then
        
        
    else
        -- el identifier no está en la base de datos de gx_gangwar
        local result = MySQL.query.await('SELECT * FROM gx_gangowner WHERE name_gang = ? ', {SQL.NameGang})
        print(result[1].active)
        if result[1].active == 0 then
            print('active = 0')
        elseif result[1].active == 1 then
            print('active = 1')
        else
            return false
        end
    end
end)


lib.callback.register('gx_server:Fcreategang', function(source, data)
    Player = ESX.GetPlayerFromId(source)

    --MySQL.insert('INSERT INTO gx_gangwar (identifier, name_gang, rank_label) VALUES (?, ?, ?) ', {Player.identifier, data.NameGang, 'boss'})
    

    local getInf = MySQL.query.await('SELECT * FROM gx_gangwar WHERE identifier = ?', {Player.identifier})

    if getInf[1] then
        if getInf[1].rank_label == ('boss' or 'member') then
           print('ya perteneces a la banda => ', getInf[1].name_gang)

            --if getInf[]


            --MySQL.insert('INSERT INTO gx_gangowner (name_gang) SELECT "'..data.NameGang..'" WHERE NOT EXISTS (SELECT 1 FROM gx_gangowner WHERE name_gang = ? AND active = ?) ', {data.NameGang, data.active})

            --MySQL.insert('INSERT INTO gx_gangowner (name_gang, active) VALUES (?, ?) ', {data.NameGang, data.active})
        
            --MySQL.insert('INSERT INTO gx_gangwar (identifier, name_gang, rank_label) VALUES (?, ?, ?) ', {Player.identifier, data.NameGang, 'boss'})
        else
            print('no existe el gang')
        end
    else
        print('no existe el usuario en la tabla/ No está registrado en ninguna banda')
    end

   

end)

lib.callback.register('gx_server:verifygang', function(source, data)
    Player = ESX.GetPlayerFromId(source)

	local result = MySQL.query.await('SELECT * FROM gx_gangowner WHERE name_gang = ?', {data.NameGang})

    print("asies => ", json.encode(result[1]))

    if result[1] then
        if result[1].active == 1 then
            print("active w => ", result[1].active)
            return 'create'
        elseif result[1].active == 0 then
            MySQL.insert('INSERT INTO gx_gangowner (active) VALUES (?) ', {1})
            MySQL.insert('UPDATE gx_gangowner SET active=1 WHERE name_gang=@name_gang', {['@name_gang'] = data.NameGang})
            return 'dntcreate'
        end
    else
        MySQL.Async.execute([[
            INSERT INTO gx_gangowner (name_gang)
            SELECT ']]..data.NameGang..[['
            WHERE NOT EXISTS (
                SELECT 1
                FROM gx_gangowner
                WHERE name_gang = ']]..data.NameGang..[[' AND active = ]].. 0 ..[[
            );
        ]], {}, function(rowsChanged)
            --print("[CITYHALL] - Database initialized")
        end)
        return false
    end
end)











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
        --print('No existe tablas')
    end

    --[[
    Player = ESX.GetPlayerFromId(source)
    MySQL.insert('INSERT INTO gx_gangowner (name_gang, active) VALUES (?, ?) ', {data.name_gang, 1})

    MySQL.insert('UPDATE users SET name_gang=@name_gang, rank_label=@rank_label WHERE identifier=@identifier', {['@name_gang'] = data.name_gang, ['@rank_label'] = data.rank_label, ['@identifier'] = Player.identifier})
]]
end)








