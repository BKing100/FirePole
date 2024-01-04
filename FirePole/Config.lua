Config = {}
Config.Language = {}

Config.Debug = false -- Enable this to show a marker at your pole locations in game


Config.DistanceToPole = 1.2 -- Distance to the pole that the use prompt will show
Config.UsePoleControl = 51 -- The control to use the pole, default E
Config.PoleSpeed = 0.037 -- This is speed the player goes down the pole
Config.PoleLocations = {
    -- Start of entry
    ["Example Pole"] = {
        ["Start Locations"] = { -- Inside this table is the coordinates for
            vector3(0.0, 0.0, 85.0),   -- where you can get onto the pole.
            vector3(0.0, 0.0, 80.0),   -- You can add as many lines as you wish.
            vector3(0.0, 0.0, 75.0),
        },
        ["End Z Coordinate"] = 71.5, -- This is the Z coordinate for where the pole ends.
        ["Heading"] = 180.0, -- This is the heading to set the player to when they get on the pole.
    },
    --End of entry. Copy between the "Start of entry" and this line to make another entry if you wish.
}

Config.Language.UsePole = "Press ~INPUT_CONTEXT~ to slide down the pole."