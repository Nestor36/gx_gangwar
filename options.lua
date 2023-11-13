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
        Gang = {
            name              = 'Los Ballas', -- Name of gang
            coords            = vector3(-2006.7417, -334.9551, 48.1063), heading = 312,
            Text2D            = true,

            
            garage            = {
                disabled = false,
                coords = vector3(0, 0, 0),

            },

            --
            shopgang_disabled = true, -- afecta a miembros y Jefe
            shopgang          = { -- No touch " type = 'number', default = 0 "
                { type  = 'number', default = 0, label = 'pistolita $50', item = 'WEAPON_PISTOL', price = 500},
                { type  = 'number', default = 0, label = 'water  $50', item = 'water', price = 500},
                { type  = 'number', default = 0, label = 'burger  $50', item = 'burger', price = 500},
                -- puedes añadir más
            },

            stashboss = {
                slots = 10,
                weight = 100000,
            },

            stashgang = { 
                disabled = false, -- afecta a miembros y Jefe
                slots = 50,
                weight = 100000,
            },


            sellgang = {
                disabled   = false,
                coords     = vector3(0,0,0),
                sell_items = {
                    { type  = a1, default = a2, label = 'Cocaine $150', item = 'cocaine',   sell = 50, money = 'money'},
                    { type  = a1, default = a2, label = 'Marihuana $150', item = 'marijuana',   sell = 50, money = 'black_money'},
                }
            }
        },

        PropModel = {
            prop_model = `p_cs_locker_01_s`, -- Prop => https://gtahash.ru
            heading = 338.6376, -- Rotación del prop
            upordown   = -1.00 -- Puedes remover el "-" para subir el prop
        },

        Blip = {
            circle = {
                visible = true,
                radius = 0.5, -- radio del área
                color = 15,
                degradado = 100,
            },
            icon = {
                visible = false,
                icon = 84, -- https://docs.fivem.net/docs/game-references/blips/
                color = 1, -- https://docs.fivem.net/docs/game-references/blips/#blip-colors
            }
        },
        
    },
    
    { 
        Gang = {
            name              = 'Los Grove', -- Nombre : )
            coords            = vector3(-430.0518, 1182.3202, 325.8266), heading = 351,
            Text2D            = false,
            --


                        
            garage            = {
                disabled = false,
                coords = vector3(-411.2984, 1173.9546, 325.6418),
                
            },

            shopgang_disabled = false,
            shopgang    = {
                
                { type  = 'number', default = 0, label = 'A PISTOL $50', item = 'weapon_pistol', price = 500},
                { type  = 'number', default = 0, label = 'water  $50', item = 'water', price = 500},
                { type  = 'number', default = 0, label = 'burger  $50', item = 'burger', price = 500},
                            -- puedes añadir más

            },

            stashboss = {
                slots = 10,
                weight = 100000,
            },

            stashgang = {
                disabled = false,
                slots = 7,
                weight = 100000,
            },
        },

        PropModel = {
            prop_model = `p_secret_weapon_02`, -- Prop => https://gtahash.ru
            heading = 338.6376, -- Rotación del prop
            upordown   = -1.00 -- Puedes remover el "-" para subir el prop
        },

        Blip = {
            circle = {
                visible = true,
                radius = 3, -- radio del área
                color = 15,
                degradado = 100,
            },
            icon = {
                visible = false,
                icon = 84, -- https://docs.fivem.net/docs/game-references/blips/
                color = 1, -- https://docs.fivem.net/docs/game-references/blips/#blip-colors
            }
        },
        

    },



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