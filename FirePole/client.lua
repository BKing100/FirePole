local usingPole = false
local nearestPole = nil

Citizen.CreateThread(function()
	print()
	print("Created by BKing Development")
	print("shop.bradleyking.xyz")
	print()
	while true do
		if not HasAnimDictLoaded("missrappel") then
			RequestAnimDict("missrappel")
		end

		if not usingPole then
			for name, poleEntry in pairs(Config.PoleLocations) do
				for _, coord in ipairs(poleEntry["Start Locations"]) do
					if Config.Debug then
						DrawMarker(0, coord.x, coord.y, coord.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 180, false, false, 2, false, nil, nil, false)
					end
					if #(coord - GetEntityCoords(PlayerPedId())) < Config.DistanceToPole then
						ShowHelpText(Config.Language.UsePole)
						if IsControlJustReleased(0, Config.UsePoleControl) then
							SetEntityCoords(PlayerPedId(), coord.x, coord.y, coord.z, true, true, true, false)
							SetEntityHeading(PlayerPedId(), poleEntry.Heading)
							FreezeEntityPosition(PlayerPedId(), true)
							TaskPlayAnim(PlayerPedId(), "missrappel", "rope_idle", 8.0, 8.0, -1, 2, 1.0, false, false, false)
							nearestPole = poleEntry
							Citizen.Wait(200)
							PoleSlide()
						end
						break
					end
				end
			end
		end
		Citizen.Wait(1)
	end
end)

function PoleSlide()
	Citizen.CreateThread(function()
		usingPole = true
		while usingPole do
			if not IsEntityPlayingAnim(PlayerPedId(), "missrappel", "rope_idle", 3) then
				TaskPlayAnim(PlayerPedId(), "missrappel", "rope_idle", 8.0, 8.0, -1, 2, 1.0, false, false, false)
			end
			local pCoords = GetEntityCoords(PlayerPedId())

			if math.abs(pCoords.z - nearestPole["End Z Coordinate"]) < 0.3 then
				ClearPedTasksImmediately(PlayerPedId())
				usingPole = false
				nearestPole = nil
				FreezeEntityPosition(PlayerPedId(), false)
				SetEntityCollision(PlayerPedId(), true, true)
			else
				local currPos = GetEntityCoords(PlayerPedId())
				FreezeEntityPosition(PlayerPedId(), false)
				SetEntityCollision(PlayerPedId(), false, true)
				SetEntityCoordsNoOffset(PlayerPedId(), currPos.x, currPos.y, currPos.z - Config.PoleSpeed, true, true, true)
			end
			Citizen.Wait(1)
		end
	end)
end

function ShowHelpText(text)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, false, false, 100)
end