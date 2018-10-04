-- spam_config.lua

-- galactic conquest spam configuration file

max_units = 100 -- Maximum amount of units a ai instance will have at once
wait = 300 -- Time before the ai begins its attack
metal_income = 20 -- Its nominal metal income
energy_income = 20 -- Its nominal energy income
hq_build_speed = 5.0 --
hq_hp = 1000000 -- Initial health of the spam hq
hq_bonus_multiplier = 2 --
hq_los = 512
hq_range = 1024 -- Range of all 4 lasers
hq_damage = 100 -- Damage for each of the 4 lasers with beamtime 0.25 and reload time 1.0
unit_bonus_multiplier = 0.25

build_order = {{"trooper", 100}, -- First entry is the unit name to be produced and the later is the likelyhood of it spawning
               {"mortar", 95},
               {"trooper_missile_launcher", 90},
               {"trooper_sniper", 80},
               {"allterrain_utility_car_scout", 85},
               {"frontline_support_vehicle", 80},
               {"frontline_support_vehicle_laser", 45},
               {"leonidas_combat_tank", 75},
               {"leonidas_combat_tank_flame", 55},
               {"leonidas_micro_missiles", 35},
               {"artemis_firesupport_tank_anti_air", 60},
               {"artemis_firesupport_tank_howitzer", 45},
               {"artemis_firesupport_tank_electro_missiles", 15},
               {"herkules_assualt_tank", 50},
               {"herkules_assualt_tank_laser", 25},
               {"herkules_assualt_tank_command", 20},
               {"achilles_siege_tank", 30},
               {"achilles_siege_tank_command", 10},
               {"heavy_transport_truck_sensor", 40},
               {"heavy_transport_truck_emp", 20},
               {"gunship", 50},
               {"hunter", 20},
               {"enforcer", 10},
               {"heavy_weapons_platform", 2},
}
