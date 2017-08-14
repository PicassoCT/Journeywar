function gadget:GetInfo()
	return {
		name = "piling up wreckage",
		desc = "Creates a bump under every destroyed Unit",
		author = "Picasso",
		date = "7.7.2017",
		version = "v0.1",
		license = "GPL v3.0",
		layer = math.huge,
		handler = true,
		enabled = false --Todo activate it as a mod-option
	}
end

if gadgetHandler:IsSyncedCode() then	
	-------------------------------------
	-- Includes
	VFS.Include('scripts/lib_UnitScript.lua')	
	---------------- SYNCED---------------
	
	-- Returns the Volume as HeightOffsetMap
	function renderVolumeToHeightoffset(unitID)
		scaleX, scaleY, scaleZ, offsetX, offsetY, offsetZ, volumeType, testType, primaryAxis, disabled =	Spring.GetUnitCollisionVolumeData(unitID)
		sizeX, sizeZ = toDO
		degreeUnit = toDO
		
		tracedHeightMap = makeTable(0, sizeX, sizeY, nil, true )
		for x= -sizeX, sizeX do
			for z=-sizeZ, sizeZ do
			if z => -sizeZ + scaleZ and  z =< scaleZ then
			if x => -sizeX + scaleX and  x =< scaleX then
				tracedHeightMap[x][y] = scaleY
			end		
			end		
		end
		tracedHeightMap = rotateMap(tracedHeightMap, sizeX,sizeZ, degreeUnit)
		tracedHeightMap = shiftMap()
	end
	
	WreckageTypeDefID = getWreckageType()
	
	function gadget:UnitDestroyed(unitID, unitDefID, teamID)
		--Determinate Unit of WreckageType
		if WreckageTypeDefID[unitDefID] then
		
		-- Get Volume
		
		-- Set Terrain Volume Up

		-- Deform Terrain
		
		end
	end

	function gadget:Initialize()
	end
end