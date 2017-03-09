-- main.lua

-- Spam main file

include ("LuaRules/Configs/spam_config.lua")

local ai_list = {}
local lifetime = {}
local unit_lifetime = 300

local function instance_ai (team)
	local instance = {}
	instance.team = team
	instance.ally = 0
	instance.unitCount = 0
	instance.hq = 0
	instance.build_list = {}
	instance.health_coeff = 1.0
	instance.enemies = {}
	for _, team in ipairs (Spring.GetTeamList ()) do
		if not Spring.AreTeamsAllied (team, instance.team) and team ~= Spring.GetGaiaTeamID () then
			table.insert (instance.enemies, team)
		end
	end
	instance.current_enemy = instance.enemies[math.random (#instance.enemies)]
	instance.current_target = nil
	local x, y, z = Spring.GetTeamStartPosition (instance.current_enemy)
	instance.vector1 = {x, y ,z}
	instance.vector2 = {x, y ,z}
	instance.lastVector = false
	instance.current_squad = {}
	instance.current_squad_size = 0
	return instance
end

local function get_ai_instance (team)
	local i = 1
	while i < #ai_list do
		if ai_list[i].team == team then
			return ai_list[i]
		end
		i = i + 1
	end
	return nil
end

local function issue_build_order (instance, unitId, builder, x, y, z)
	Spring.GiveOrderToUnit (builder, -unitId, {x, y, z}, {CMD.OPT_SHIFT})
	table.insert (instance.build_list, {unitId, builder})
end

local function build_order_completed (team, unit, unitDef)
	--local build_list = get_ai_instance(unit).build_list
	
end

local function apply_unit_bonus (unit)
	
end

local function make_random_build_order (build_list)
	local new_list = {}
	for _, i in ipairs (build_list) do
		for j = 0, i[2] do
			table.insert (new_list, i[1])
		end
	end
	for i = 0, #new_list do
		new_list[math.random (#new_list) + 1] = new_list[math.random ( #new_list) + 1]
	end
	return new_list
end

local function spawn_spam ()
	for _, instance in ipairs (ai_list) do
		local team = instance.team
		local x, y, z = Spring.GetTeamStartPosition (instance.team)
		local rot = 0
		local hq = Spring.CreateUnit ("spam_hq", x, y, z, rot, instance.team) -- Create hq first and then remove all other units to not kill the team
		lifetime[hq] = 99999 -- If this ever gets exceeded then i don't know
		--if select (Spring.GetTeamStartPosition (instance.team), 1) <= )
		instance.hq = hq
		for _, unit in ipairs (Spring.GetTeamUnits (instance.team)) do -- Spawn hq first so game ending doesnt trigger
			if unit ~= hq then
				Spring.DestroyUnit (unit, false, true)
			end
		end
		local commander = "{{" .. "-1, " .. tostring (hq) .. "}}"
		Spring.SetTeamRulesParam (team, "commander", commander) -- Galactic conquest specific needed setting
		if metal_income ~= nil then
			Spring.SetUnitResourcing (hq, "umm", metal_income)
		end
		if energy_income ~= nil then
			Spring.SetUnitResourcing (hq, "ume", energy_income)
		end
		if hq_build_speed ~= nil then
			Spring.SetUnitBuildSpeed (hq, hq_build_speed)
		end
		if hq_los ~= nil then
			Spring.SetUnitSensorRadius (hq, "los", hq_los)
		end
		if hq_hp ~= nil then
			Spring.SetUnitMaxHealth (hq, hq_hp)
			Spring.SetUnitHealth (hq, hq_hp)
		end
		x, y, z = Spring.GetTeamStartPosition (instance.current_enemy)
		Spring.GiveOrderToUnit (hq, CMD.WAIT, {}, {})
		--Spring.GiveOrderToUnit (hq, CMD.REPEAT, {1}, {})
		Spring.GiveOrderToUnit (hq, CMD.FIGHT, {x, y, z}, {})
		--Spring.GiveOrderToUnit (hq, CMD.MOVE, {x, y, z}, {CMD.OPT_SHIFT}) -- For units that cannot fight
		for _, unit in ipairs (make_random_build_order (build_order)) do
			Spring.GiveOrderToUnit (hq, -(UnitDefNames[unit].id), {}, {CMD.OPT_SHIFT})
		end
	end
end

function gadget:Initialize ()
	for _, t in ipairs (Spring.GetTeamList ()) do
		local teamID, _, _, isAI = Spring.GetTeamInfo (t)
		if isAI and Spring.GetTeamLuaAI (teamID) == gadget:GetInfo ().name then
			table.insert (ai_list, instance_ai (teamID))
		end
	end
	if #ai_list == 0 then
		gadgetHandler:RemoveGadget ()
	end
	for index, unit in ipairs (build_order) do
		if UnitDefNames[unit[1]] == nil then
			Spring.Echo ("Invalid unitdef name " .. unit[1] .. " specified in spam build order")
			for i = index, #build_order do
				build_order[i] = build_order[i + 1]
			end
			unit[#build_order] = nil
		end 
	end
end

function gadget:GameStart ()
end

function gadget:GameFrame (n)
	if n == 1 then
		spawn_spam ()
	end
	if Spring.GetGameSeconds () == wait then
		for _, instance in ipairs (ai_list) do
			Spring.GiveOrderToUnit (instance.hq, CMD.WAIT, {}, {})
		end
		for _, i in ipairs (Spring.GetPlayerList ()) do
			Spring.SendMessageToPlayer (i, "Prepare to die puny human!")
		end
	end
	for index, _ in pairs (lifetime) do
		if Spring.GetGameSeconds () == lifetime[index] then -- Needs == or it will be triggered on an off
			Spring.GiveOrderToUnit (index, CMD.SELFD, {}, {})
			lifetime[index] = nil
		end
	end
end

function gadget:UnitCreated (unitID, unitDefID, unitTeam, builderID)
	local instance = get_ai_instance (unitTeam)
	if instance ~= nil then
		local maxHealth = select (2, Spring.GetUnitHealth (unitID))
		Spring.GiveOrderToUnit (unitID, CMD.FIRE_STATE, {2}, {})
		Spring.GiveOrderToUnit (unitID, CMD.MOVE_STATE, {2}, {})
		--Spring.SetUnitMaxHealth (unitID, maxHealth + instance.health_coeff)
		if instance.unitCount < max_units and instance.unitCount + 1 == max_units then
			Spring.GiveOrderToUnit (instance.hq, CMD.WAIT, {}, {})
			for _, player in ipairs (Spring.GetPlayerList ()) do
				Spring.SendMessageToPlayer (player, "Go forth my minions!")
			end
		end
		instance.unitCount = instance.unitCount + 1
		lifetime[unitID] = Spring.GetGameSeconds () + unit_lifetime
	end
end

function gadget:UnitFromFactory (unitID, unitDefID, unitTeam, factID, factDefID, userOrders)
	local instance = get_ai_instance (unitTeam)
	if instance ~= nil then
		--Spring.GiveOrderToUnit (unitID, CMD.WAIT, {}, {})
		table.insert (instance.current_squad, unitID)
		instance.current_squad_size = instance.current_squad_size + UnitDefs[unitDefID].metalCost
		if instance.current_squad_size >= 5000 then
			for _, i in ipairs (instance.current_squad) do
				--Spring.GiveOrderToUnit (i, CMD.WAIT, {}, {})
			end
			instance.current_squad = {}
			instance.current_squad_size = 0
		end
	end
end

function gadget:UnitDestroyed (unitID, unitDefID, unitTeam, attackerID, attackerDefID, attackerTeam) 
	local instance = get_ai_instance (unitTeam)
	if instance ~= nil then
		if unitID == instance.hq then
			for _, p in ipairs (Spring.GetPlayerList ()) do
				Spring.SendMessageToPlayer (p, "I'll see you in hell!")
			end
			Spring.KillTeam (unitTeam)
		else
			instance.health_coeff = instance.health_coeff + 0.1
			if instance.unitCount == max_units and instance.unitCount - 1 < max_units then
				Spring.GiveOrderToUnit (instance.hq, CMD.WAIT, {}, {})
			end
			instance.unitCount = instance.unitCount - 1
		end
		lifetime[unitID] = nil
	else
		if math.random (10) == 0 then
			for _, p in ipairs (Spring.GetPlayerList ()) do
				Spring.SendMessageToPlayer (p, "Die!")
			end
		end
	end
end

function gadget:UnitEnteredLos (unitID, unitTeam, allyTeam, unitDefID)
	for _, team in pairs (Spring.GetTeamList (allyTeam)) do
		local instance = get_ai_instance (team)
		if instance ~= nil then
			if unitTeam == instance.current_enemy then
				local x, y, z = Spring.GetUnitPosition (unitID)
			end
		end
	end
end

function gadget:UnitIdle (unitID, unitDefID, unitTeam)
	if get_ai_instance (unitTeam) ~= nil then
		if unitID == get_ai_instance (unitTeam).hq then
			local maxHealth = select (2, Spring.GetUnitHealth (unitID))
			local metal, _, energy, _ = Spring.GetUnitResources (unitID)
			Spring.SetUnitResourcing (unitID, "umm", metal * hq_bonus_multiplier)
			Spring.SetUnitResourcing (unitID, "ume", energy * hq_bonus_multiplier)
			Spring.SetUnitBuildSpeed (unitID, Spring.GetUnitCurrentBuildPower (unitID) * hq_bonus_multiplier)
			Spring.SetUnitMaxHealth (unitID, maxHealth * hq_bonus_multiplier)
			Spring.SetUnitSensorRadius (unitID, "los", Spring.GetUnitSensorRadius (unitID, "los") * hq_bonus_multiplier)
			Spring.SetUnitSensorRadius (unitID, "radar", Spring.GetUnitSensorRadius (unitID, "radar") * hq_bonus_multiplier)
			Spring.SetUnitSensorRadius (unitID, "radarJammer", Spring.GetUnitSensorRadius (unitID, "radarJammer") * hq_bonus_multiplier)
			--for i = 1, 4 do
			Spring.SetUnitWeaponState (unitID, 1, "range", Spring.GetUnitMaxRange (unitID) * hq_bonus_multiplier)
			--end
			Spring.SetUnitMaxRange (unitID, Spring.GetUnitMaxRange (unitID) * hq_bonus_multiplier)
			if #build_order == 0 then
				for _, instance in ipairs (ai_list) do
					Spring.KillTeam (instance.team)
				end
				Spring.Echo ("Empty spam build list, quitting please check LuaRules/config/spam_config.lua.")
				gadgetHandler:RemoveGadget ()
			end
			for _, unit in ipairs (make_random_build_order (build_order)) do
				Spring.GiveOrderToUnit (unitID, -(UnitDefNames[unit].id), {}, {CMD.OPT_SHIFT})
			end
			for _, p in ipairs (Spring.GetPlayerList ()) do
				Spring.SendMessageToPlayer (p, "Huahahhahahahhaaaa! Try and take me now!")
			end
		else
			Spring.GiveOrderToUnit (unitID, CMD.ATTACK, {Spring.GetUnitNearestEnemy (unitID)}, {})
		end
	end
end

function gadget:TeamDied (team)
	local newlist = {}
	for _, instance in ipairs (ai_list) do
		if instance.team ~= team then
			table.insert (newlist, instance)
		end
	end
	ai_list = newlist
	for _, instance in ipairs (ai_list) do
		instance.enemies = {}
		for _, teamX in ipairs (Spring.GetTeamList ()) do
			local dead = select (3, Spring.GetTeamInfo (teamX))
			if not Spring.AreTeamsAllied (teamX, instance.team) and teamX ~= Spring.GetGaiaTeamID () and not dead and teamX ~= team then
				table.insert (instance.enemies, teamX)
			end
		end
		if #instance.enemies == 0 then -- Let the bots kill one another after game is over :p
			Spring.SetAlly (instance.team, team, false)
			instance.current_enemy = instance.team
		else
			instance.current_enemy = instance.enemies[math.random (#instance.enemies)]
		end
		local x, y, z = Spring.GetTeamStartPosition (instance.current_enemy)
		for _, unit in ipairs (Spring.GetTeamUnits (instance.team)) do
			Spring.GiveOrderToUnit (unit, CMD.FIGHT, {x, y, z}, {})
		end
	end
end