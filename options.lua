--[[
 _____              ______  _      
|  __ \             |  ___|(_)     
| |  \/ _   _ __  __| |_    _  ____
| | __ | | | |\ \/ /|  _|  | ||_  /
| |_\ \| |_| | >  < | |    | | / / 
 \____/ \__,_|/_/\_\\_|    |_|/___|
]]


options = {
    controlPress = 38, -- Puedes modificar con qué control abrir el menú => https://docs.fivem.net/docs/game-references/controls/

    territorios_default = { -- puedes aumentar los territorios que gustes : ) -- No juntar las áreas ni acercarlos, tener un espacio recomendado. (evite sobreposiciones innecesarias
    { 
        coords      = vector3(-2008.9847, -330.9001, 48.1063),
        blipsCircle = { visible = true, color = 15, degradado = 100}, -- Color => https://docs.fivem.net/docs/game-references/blips/
        blipcenter  = { visible = true, color = 1, blip = 84}, -- Blip => https://docs.fivem.net/docs/game-references/blips/
        radius      = 0.5,--0.5, -- Radio del área
        name        = 'Los Ballas', -- Nombre : )
        prop_model  = `p_cs_locker_01_s`,   -- Prop => https://gtahash.ru
        upordown    = -1.00, -- Puedes remover el "-" para subir el prop
        stash       = { slots = 30, weight = 1000000 }, -- Slots => Cuántos recuadros tendrá disponible? / weight => Cuánto peso tendrá disponible el inventario?
        time_01s    = 5, -- Tiempo en segundos en la toma de un territorio nuevo
        anim        = { movement_disabled = false, active_anim = false, dict = 'missheistfbisetup1', clip = 'hassle_intro_loop_f', }, -- movement_disabled => Sí quieres que no haya algún movimiento de parte del usuario cámbie a true, en caso contrario deje en false. active_anim => Para activar alguna animación al momento de capturar.. 
        bossInv     = {
            active = true,
            stash  = {slots = 4, weight = 100000}

        },
        bossShop_Active = true,
        bossShop    =  {
            { type  = a1, default = a2, label = 'pistolita $50', weapon = 'weapon_pistol',   price = 50},
            { type  = a1, default = a2, label = 'batesote  $50',  weapon = 'weapon_bat',      price = 50},
            { type  = a1, default = a2, label = 'aguita  $50',  weapon = 'water',      price = 50},
                        -- puedes añadir más
        },
        drugsell    = { 
            active  = true, 
            ped     = 'u_f_o_prolhost_01',
            coords  = vector3(-383.4044, 1170.9150, 325.8664),
            sell    = { -- Cualquier item que no sea armas puede usar, sí quiere usar armas como modo de venta, por favor utilice mayúsculas o no funcionará correctamente :)
                { type  = a1, default = a2, label = 'Cocaine $150', item = 'cocaine',   sell = 50, money = 'money'},
                { type  = a1, default = a2, label = 'Marihuana $150', item = 'marijuana',   sell = 50, money = 'black_money'},
                            -- puedes añadir más
            }
        }
    },
    
    { 
        coords      = vector3(-2005.3000, -326.3560, 48.1063),
        blipsCircle = { visible = true, color = 5, degradado = 100},
        blipcenter  = { visible = true, color = 1, blip = 84},
        radius      = 30, 
        name        = 'Los Grove',
        prop_model  = `p_cs_locker_01_s`,
        stash       = { slots = 30, weight = 10000 },
        upordown    = -1.00,
        time_01s    = 5, -- 5
        anim        = { movement_disabled = false, active_anim = false, dict = 'missheistfbisetup1', clip = 'hassle_intro_loop_f', }, -- la animación al querer conseguir el territorio
        bossInv     = {
            active = true,
            stash  = {slots = 4, weight = 100000}
            
        },
        bossShop_Active = true,
        bossShop    =  {
            { type = a1, default = a2, label = 'SMG $1500', weapon = 'weapon_smg',   price = 1500, money = 'money'},
            { type = a1, default = a2, label = 'Pistola  $5000',  weapon = 'weapon_pistol',      price = 5000, money = 'money' },
        },
        drugsell    = { 
            active  = true, 
            ped     = 'g_f_y_vagos_01',
            coords  = vector3(-1037.0405, -1081.6139, 3.3197),
            sell    = { -- Cualquier item que no sea armas puede usar, sí quiere usar armas como modo de venta, por favor utilice mayúsculas o no funcionará correctamente :)
                { type  = a1, default = a2, label = 'Cocaine $150', item = 'cocaine',   sell = 50, money = 'money'},
                { type  = a1, default = a2, label = 'Marihuana $150', item = 'marijuana',   sell = 50, money = 'black_money'},
                            -- puedes añadir más
            }

        }
    },


--[[    
    [4] = { 
            coords     = vector3(x, y, z),    -- Coords
            color      = 15,                  -- Color --> https://docs.fivem.net/docs/game-references/blips/
            degradado  = 100,                 -- Hacer transparente o más fuerte el color
            radius     = 5,                   -- El rango del área del territorio
            name       = 'Los pikachus',      -- Nombre del territorio
            prop_model = `p_cs_locker_01_s`,  -- Prop --> https://gtahash.ru
            ipordown   = -1.00,               -- puedes remover el "-" para subir el prop
            time_01s   = 5,                   -- Tiempo en segundos de la toma de un territorio nuevo
            anim       = { dict = 'missheistfbisetup1', clip = 'hassle_intro_loop_f', movement_disabled = true} -- la animación al querer conseguir el territorio

        },                          
]]    
},

    
-- Language and Locales
    Language = 'es',
    Locales = {
        ['en'] = { -- English
            --Menu
            ['label'] = 'Territorio - Main',
            ['claim'] = 'Reclamar territorio',
            ['no_claimed'] = 'Este territorio aún no fue conquistado',
            ['open_inv'] = 'Abrir inventario',
            ['member'] = 'Eres miembro de este territorio',
            --Idk
            ['tittle_area'] = 'Estás en una área peligrosa, este territorio pertenece a ~r~',
            ['area_member'] = 'Eres miembro y conquistador del territorio de ~b~',
            ['menu_press'] = 'Presiona ~r~[E]~s~ para abrir el menu de ~b~',
            ['claim_new_a'] = 'Presiona ~r~[E]~s~ para reclamar el territorio de ~b~',
            ['owner_text'] = '~o~Jefe~s~ - Presiona ~b~[E]~s~ para abrir el Menú central de ~y~',
            ['member_text'] = '~g~Miembro~s~ - Presiona ~b~[E]~s~ para abrir el Menú de ~y~'
        },
        ['es'] = { -- Spanish 🇪🇸
            --Menu
            ['label'] = 'Territorio - Main',
            ['claim'] = 'Reclamar territorio',
            ['no_claimed'] = 'Este territorio aún no fue conquistado',
            ['open_inv'] = 'Abrir inventario',
            ['member'] = 'Eres miembro de este territorio',
            --Idk
            ['tittle_area'] = 'Estás en una área peligrosa, este territorio pertenece a ~r~',
            ['area_member'] = 'Eres miembro y conquistador del territorio de ~b~',
            ['menu_press'] = 'Presiona ~r~[E]~s~ para abrir el menu de ~b~',
            ['claim_new_a'] = 'Presiona ~r~[E]~s~ para reclamar el territorio de ~b~',
            ['owner_text'] = '~o~Jefe~s~ - Presiona ~b~[E]~s~ para abrir el Menú central de ~y~',
            ['member_text'] = '~g~Miembro~s~ - Presiona ~b~[E]~s~ para abrir el Menú de ~y~'
        },
    }
}


-- 🐧