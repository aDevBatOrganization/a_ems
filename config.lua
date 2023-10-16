Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerColor                = { r = 200, g = 255, b = 122 }
Config.MarkerSize                 = { x = 2.5, y = 2.5, z = 1.0 }
Config.ReviveReward               = 800  -- revive reward, set to 0 if you don't want it enabled
Config.AntiCombatLog              = true -- enable anti-combat logging?
Config.LoadIpl                    = true -- disable if you're using fivem-ipl or other IPL loaders
Config.Locale                     = 'fr'

local second = 1000
local minute = 60 * second

-- How much time before auto respawn at hospital
Config.RespawnDelayAfterRPDeath   = 10 * minute

Config.EnablePlayerManagement       = true
Config.EnableSocietyOwnedVehicles   = false

Config.RemoveWeaponsAfterRPDeath    = false
Config.RemoveCashAfterRPDeath       = false
Config.RemoveItemsAfterRPDeath      = false

-- Will display a timer that shows RespawnDelayAfterRPDeath as a countdown
Config.ShowDeathTimer               = true

-- Will allow respawn after half of RespawnDelayAfterRPDeath has elapsed.
Config.EarlyRespawn                 = false
-- The player will be fined for respawning early (on bank account)
Config.EarlyRespawnFine                  = true
Config.EarlyRespawnFineAmount            = 1000

Config.Blip = {
	Pos     = { x = 339.180, y = -584.019, z = 27.898 },
	Sprite  = 61,
	Display = 4,
	Scale   = 0.75,
	Colour  = 2,
}

Config.HelicopterSpawner = {
	SpawnPoint = { x = 352.414, y = -587.745, z = 73.97 },
	Heading    = 0.0
}

-- https://wiki.fivem.net/wiki/Vehicles
Config.AuthorizedVehicles = {

	{
		model = 'ambulance',
		label = 'Ambulance'
	},
	{
		model = 'emscar2',
		label = 'Voiture EMS'
	},
	{
		model = 'emssuv',
		label = 'Voiture SUV'
	},
	{
		model = 'dodgeems',
		label = 'Dodge EMS'
	},
	
}

Config.Zones = {

	HospitalInteriorEntering1 = { -- Main entrance
		Pos	= { x = 335.77, y = -580.4, z = 27.9 },
		Type = 1
	},

	HospitalInteriorInside1 = {
		Pos	= { x = 317.13, y = -582.76, z = 43.28 },
		Type = -1
	},

	HospitalInteriorOutside1 = {
		Pos	= {  x = 335.77, y = -580.4, z = 28.9 },
		Type = -1
	},

	HospitalInteriorExit1 = {
		Pos	= { x = 331.42, y = -592.35, z = -43.28 },
		Type = 1
	},

	HospitalInteriorEntering2 = { -- Lift go to the roof
		Pos	= { x = 247.1, y = -1371.4, z = 23.5 },
		Type = 1
	},

	HospitalInteriorInside2 = { -- Roof outlet
		Pos	= { x = 333.1,	y = -1434.9, z = 45.5 },
		Type = -1
	},

	HospitalInteriorOutside2 = { -- Lift back from roof
		Pos	= { x = 249.1,	y = -1369.6, z = 23.5 },
		Type = -1
	},

	HospitalInteriorExit2 = { -- Roof entrance
		Pos	= { x = 335.5, y = -1432.0, z = 45.5 },
		Type = 1
	},

	AmbulanceActions = { -- Cloakroom
		Pos	= { x = 301.65, y = -598.27, z = 41.50 },
		Type = 1
	},

	VehicleSpawner = {
		Pos	= { x = 306.26, y = -598.14, z = 41.50 },
		Type = 1
	},

	VehicleSpawnPoint = {
		Pos	= { x = 347.73, y = -546.42, z = 28.72 },
		Type = -1
	},

	VehicleDeleter = {
		Pos	= { x = 291.72, y = -593.72, z = 41.50 },
		Type = 1
	},

	Pharmacy = {
		Pos	= { x = 310.97, y = -565.67, z = 41.50 },
		Type = 1
	},

	ParkingDoorGoOutInside = {
		Pos	= { x = 234.56, y = -1373.77, z = 20.97 },
		Type = 1
	},

	ParkingDoorGoOutOutside = {
		Pos	= { x = 320.98, y = -1478.62, z = 28.81 },
		Type = -1
	},

	ParkingDoorGoInInside = {
		Pos	= { x = 238.64, y = -1368.48, z = 23.53 },
		Type = -1
	},

	ParkingDoorGoInOutside = {
		Pos	= { x = 317.97, y = -1476.13, z = 28.97 },
		Type = 1
	},

	StairsGoTopTop = {
		Pos	= { x = 251.91, y = -1363.3, z = 38.53 },
		Type = -1
	},

	StairsGoTopBottom = {
		Pos	= { x = 237.45, y = -1373.89, z = 26.30 },
		Type = -1
	},

	StairsGoBottomTop = {
		Pos	= { x = 256.58, y = -1357.7, z = 37.30 },
		Type = -1
	},

	StairsGoBottomBottom = {
		Pos	= { x = 235.45, y = -1372.89, z = 26.30 },
		Type = -1
	}

}
