function Gx_Notify(text, x, y, z, heading)
	ESX.ShowFloatingHelpNotification(text, vector3(x, y, z+1.00))
end

function CreateProps(prop_model, x, y, z, upordown, heading)   
  if not HasModelLoaded(prop_model) then
	  RequestModel(prop_model)
	  Wait(100)
	  while not HasModelLoaded(prop_model) do
		  Wait(10)
	  end
  end
  local object = CreateObject(prop_model, vector3(x, y, z+upordown), false)
  SetEntityHeading(object, heading)
end

function CreateBlips(circle_visible, circle_color, circle_radius, circle_degradado, icon_visible, icon_icon, icon_color, name_gang, coords)

  if circle_visible then
	  local blip = AddBlipForRadius(coords, circle_radius*9.99)
	  SetBlipColour(blip, circle_color)
	  SetBlipAlpha(blip, circle_degradado)
	  SetBlipAsShortRange(blip, true)
	  SetBlipHighDetail(blip, true)
  end
  if icon_visible then
	  blip = AddBlipForCoord(coords)

	  SetBlipHighDetail(blip, true)
	  SetBlipSprite (blip,  icon_icon)
	  SetBlipScale  (blip, 1.0)
	  SetBlipColour (blip,  icon_color)
	  SetBlipAsShortRange(blip, true)
  
	  BeginTextCommandSetBlipName("STRING")
	  AddTextComponentSubstringPlayerName(name_gang)
	  EndTextCommandSetBlipName(blip)
  end

end

function CreateTexT2D(text, text2)
  SetTextFont(0)
  SetTextProportional(1)
  SetTextScale(0.30, 0.30)
  SetTextColour(255, 255, 255, 255)
  SetTextDropshadow(0, 0, 0, 0, 255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextRightJustify(true)
  SetTextWrap(0.0,0.58)
  SetTextEntry("STRING")
  AddTextComponentString(text..''..text2)
  DrawText(0.5, 0.90)
end

function VerifyTexT(palabra)
  local verify = "^" .. 'G' .. 'X'
  -- Verificar si la palabra coincide con el patrón
  return string.match(palabra, verify) ~= nil
end






-- 🐧