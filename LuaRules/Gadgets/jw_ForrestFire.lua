function gadget:GetInfo()
    function isPlanetFlammeable()
        if Game.mapHardness > 0 and Game.windMin > 0 and Game.gravity > 30 then
            badwordsTable = { "cold", "ice", "frost", "dust","dessert", "sand", "dune", "moon", "comet", "red", "planet", "space","tundra"}
            for i = 1, #badwordsTable, 1 do
                if string.find(Game.mapName, badwordsTable[i]) then
                    return false;
                end
            end
            Spring.Echo("ForrestFire:Gadget is activated")
            return true
        end
        Spring.Echo("ForrestFire:Gadget is deactivated")
        return false
    end

    return {
        name = "Gadget:Weltenbrand",
        desc = "Revenge of the Chilis",
        author = "..you, your family, your descendants and everyone you love, what do you mean not the letter to the Bonaccio-family?",
        date = "Sep. 2015",
        license = "GNA PPL ASM MOV EAX 3ST LOG BLA BLU B42",
        layer = 0,
        enabled = isPlanetFlammeable()
    }
end

if (gadgetHandler:IsSyncedCode()) then
    VFS.Include("scripts/lib_OS.lua")
    VFS.Include("scripts/lib_UnitScript.lua")
    VFS.Include("scripts/lib_jw.lua")
    VFS.Include("scripts/lib_Build.lua")
    local spGetGroundHeight = Spring.GetGroundHeight
    local spGetGroundNormal = Spring.GetGroundNormal
    local spSpawnCEG = Spring.SpawnCEG
    local spGetUnitIsDead = Spring.GetUnitIsDead
    MetaMapResDivider = 48
    lMapX = Game.mapSizeX / MetaMapResDivider
    lMapZ = Game.mapSizeZ / MetaMapResDivider

    function initLandScapeTable()

        local localLandScapeTable = {}
        localLandScapeTable.ResX = lMapX
        localLandScapeTable.ResZ = lMapZ
        localLandScapeTable.ResolutionFactor = MetaMapResDivider

        for x = 1, math.ceil(lMapX), 1 do
            localLandScapeTable[x] = {}

            for z = 1, math.ceil(lMapZ), 1 do

                xValue = x * MetaMapResDivider
                zValue = z * MetaMapResDivider
                groundHeigth = Spring.GetGroundHeight(zValue, xValue)

                localLandScapeTable[x][z] = {}
                localLandScapeTable[x][z].boolBurning = false
                localLandScapeTable[x][z].Food = getAmountFlamableMaterial(zValue, xValue)
                localLandScapeTable[x][z].y = groundHeigth
                localLandScapeTable[x][z].AccumulatedHeat = 0
                localLandScapeTable[x][z].boolShielded = false
            end
        end
        --plotLanscapeTable(localLandScapeTable)
        GG.LandScapeT = localLandScapeTable
        GG.LandScapeT.setAreaEffect = setAreaEffect
    end

    function getAmountFlamableMaterial(x, z)
        nx, ny, nz = spGetGroundNormal(x, z)
        nx, ny, nz = math.abs(nx), math.abs(ny), math.abs(nz)
        norm = math.sqrt(nx * nx + ny * ny + nz * nz)
        nx, ny, nz = nx / norm, ny / norm, nz / norm
        terrainflatFactor = ny / (math.max(math.abs(nx) + math.abs(nz), 0.1))

        if ny < 0.5 then terrainflatFactor = 0 end
        T = Spring.GetFeaturesInCylinder(x, z, MetaMapResDivider)
        T = #T
        featureFactor = T + 1 or 1
        h = spGetGroundHeight(x, z)
        Groundfactor = 0
        if h - 15 > 0 then Groundfactor = (1 - (math.log(h) / math.log(extrema))) end
        if Groundfactor > 0.7 then Groundfactor = 0 else Groundfactor = Groundfactor * 15 end

        return math.min(150 * terrainflatFactor * featureFactor * Groundfactor, MaxFood)
    end

    function setAreaEffect(px, pz, Range, sfxFunction)
        if not GG.LandScapeT then initLandScapeTable() end
        if not px then Sping.Echo("jw_forrestfirst:setAreaEffect:Coordinates are nil and void"); return false end

        local areaEffectFunction = sfxFunction
        local RangeX = Range / lMapX
        local RangeZ = Range / lMapZ
        local mapResX = GG.LandScapeT.ResX
        local mapResZ = GG.LandScapeT.ResZ
        --midpoint
        midX = px / mapResX
        midZ = pz / mapResZ

        limx = math.min(math.max(1, math.ceil(px / mapResX)), mapResX)
        limz = math.min(math.max(1, math.ceil(pz / mapResZ)), mapResZ)

        for x = math.max(1, limx - RangeX), math.min(lMapX, math.ceil(limx + RangeX)), 1 do
            for z = math.max(1, limz - RangeZ), math.min(lMapZ, math.ceil(limz + RangeZ)), 1 do

                dist = math.sqrt((x - midX) * (x - midX) + (z - midZ) * (z - midZ))
                if dist < Range then
                    if not GG.LandScapeT[x] then GG.LandScapeT[x] = {} end
                    if not GG.LandScapeT[x][z] then
                        GG.LandScapeT[x][z] = {}
                        GG.LandScapeT[x][z].boolBurning = false
                        GG.LandScapeT[x][z].Food = getAmountFlamableMaterial(x, z)
                        GG.LandScapeT[x][z].y = groundHeigth
                        GG.LandScapeT[x][z].AccumulatedHeat = 0
                        GG.LandScapeT[x][z].boolShielded = false
                    end

                    GG.LandScapeT[x][z] = areaEffectFunction(GG.LandScapeT[x][z])
                    GG.LandScapeT[x][z].y = spGetGroundHeight(x * mapResX, z * mapResZ)
                end
            end
        end
    end

    --Food
    --AccumulatedHeat

    windVector = { x = 5, z = 10 }
    InHeat = 25
    costPerFrame = 10
    --x --z
    local fireT = {}
    --TestData DelMe

    --TestData DelMe
    local fireCounter = 1

    local PointOfIgnition = 120

    local counter = 1
    local delayMap = {}
    local bigdelayMap = {}


    _, extrema = Spring.GetGroundExtremes()
    MaxFood = 150
    --SETUP
    function addRareSFX()
        --adds sfx that are expensive eyecatchers to ordinary fire extremas
    end


    function gadget:UnitDamaged(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, projectileID, attackerID, attackerDefID, attackerTeam)
    end

    local bigFireTable = {}

    function mergeSmallFiresToPermaFire()
        if not GG.LandScapeT then initLandScapeTable() end
        local LT = GG.LandScapeT

        for x = 2, #LT - 1, 3 do
            for z = 2, #LT[x] - 1, 3 do
                if LT[x - 1][z - 1].boolBurning == true and LT[x - 1][z].boolBurning == true and LT[x - 1][z + 1].boolBurning == true and
                        LT[x][z - 1].boolBurning == true and LT[x][z].boolBurning == true and LT[x][z + 1].boolBurning == true and
                        LT[x + 1][z - 1].boolBurning == true and LT[x + 1][z].boolBurning == true and LT[x + 1][z + 1].boolBurning == true then
                    bigFireTable[#bigFireTable + 1] = { x = x * MetaMapResDivider, y = spGetGroundHeight(x * MetaMapResDivider, z * MetaMapResDivider), z = z * MetaMapResDivider }
                    removeFromFireTable({ { x - 1, z - 1 }, { x - 1, z }, { x - 1, z + 1 }, { x, z - 1 }, { x, z }, { x, z + 1 }, { x + 1, z - 1 }, { x + 1, z }, { x + 1, z + 1 } })
                end
            end
        end

        fireCounter = fireCounter - 8
    end

    function removeFromFireTable(T)
        KeyX = {}
        KeyZ = {}
        for i = 1, #T do KeyX[T[i][1] * MetaMapResDivider] = true; KeyZ[T[i][2] * MetaMapResDivider] = true end

        for i = #fireT, 1, -1 do
            if KeyX[fireT[i].x] and KeyZ[fireT[i].z] then
                table.remove(fireT, i)
            end
        end
    end

    function addFiresFromGG()
        if not GG.LandScapeT then initLandScapeTable() end
        local LandScapeT = GG.LandScapeT
        if not GG.AddFire then GG.AddFire = {} end

        for i = 1, #GG.AddFire, 1 do
            groundHeigth = spGetGroundHeight(GG.AddFire[i].x, GG.AddFire[i].z)
            if groundHeigth >= 0 then
                xClamped = clamp(math.ceil(GG.AddFire[i].x / MetaMapResDivider), 1, LandScapeT.ResX)
                zClamped = clamp(math.ceil(GG.AddFire[i].z / MetaMapResDivider), 1, LandScapeT.ResZ)

                if GG.AddFire[i].Food and LandScapeT[xClamped] and LandScapeT[xClamped][zClamped] then
                    if not LandScapeT[xClamped][zClamped].Food then LandScapeT[xClamped][zClamped].Food = GG.AddFire[i].Food end
                    LandScapeT[xClamped][zClamped].Food = GG.AddFire[i].Food
                end

                if LandScapeT[xClamped] and LandScapeT[xClamped][zClamped] and LandScapeT[xClamped][zClamped].Food > 0 then
                    fireT[#fireT + 1] = { x = GG.AddFire[i].x, y = groundHeigth + 15, z = GG.AddFire[i].z }
                end
            end
        end
        local emptyTable = {}
        GG.AddFire = emptyTable
        GG.LandScapeT = LandScapeT
    end

    ProofTypes = getPyroProofUnitTypeTable(UnitDefNames)
    AirTypes = getAirUnitTypeTable(UnitDefNames)
	AbstractTypes = getAbstractTypes(UnitDefNames)
	
    function drawFlames_AddDamage(delayMap, nr)
        boolOnce = false
        local dMap = delayMap
        for i = 1, #fireT, 1 do
            if dMap[i] and dMap[i] % nr == 0 then

                if math.random(0, 3) ~= 1 then
                    boolOnce = true

                    spSpawnCEG("foorestfire", fireT[i].x + math.random(-16, 16), fireT[i].y + math.random(1, 5), fireT[i].z + math.random(-16, 16), math.random(0, 0.1), math.random(0.8, 1), math.random(0, 0.1), MetaMapResDivider, 20)
                end
                FT = Spring.GetFeaturesInCylinder(fireT[i].x, fireT[i].z, MetaMapResDivider)
                if FT and #FT > 0 then
                    for k = 1, #FT do
                        Spring.DestroyFeature(FT[k])
                    end
                end

              --  assert(MetaMapResDivider)
                T = getAllInCircle(fireT[i].x, fireT[i].z, MetaMapResDivider)
					
                T, ShitWasSoCache = removeUnitsOfTypeInT(T, AbstractTypes, ShitWasSoCache)
                T, ShitWasSoCache = removeUnitsOfTypeInT(T, ProofTypes, ShitWasSoCache)
                T, ShitWasSoCache = removeUnitsOfTypeInT(T, AirTypes, ShitWasSoCache)
				
				-- echo("Units found in fire:",#T)
                if T and #T > 0 then
                    for k = 1, #T do
								if spGetUnitIsDead(T[k]) == false then
								Spring.AddUnitDamage(T[k], 10) 
								end
                    end
                end
            end
        end

        return boolOnce
    end

    ShitWasSoCache = {}
    function drawPermaFlames_AddDamage(delayMap, frame)
        local dMap = delayMap
        for i = 1, #bigFireTable, 1 do
            if dMap[i] and dMap[i] % frame == 0 then
                dx,dy,dz= spGetGroundNormal( bigFireTable[i].x + math.random(-16, 16), bigFireTable[i].z + math.random(-16, 16), true)
                spSpawnCEG("bigfoorestfire", bigFireTable[i].x + math.random(-16, 16), bigFireTable[i].y + math.random(1, 15), bigFireTable[i].z + math.random(-16, 16),dx, dy, dz)
                T = getAllInCircle(bigFireTable[i].x, bigFireTable[i].z, 52)
					 T, ShitWasSoCache = removeUnitsOfTypeInT(T, AbstractTypes, ShitWasSoCache)
                T, ShitWasSoCache = removeUnitsOfTypeInT(T, ProofTypes, ShitWasSoCache)
                T, ShitWasSoCache = removeUnitsOfTypeInT(T, AirTypes, ShitWasSoCache)
					
                if T and #T > 0 then
					--	Spring.Echo("Units found to burn", T)
                    for k = 1, #T do
                       if spGetUnitIsDead(T[k]) == false then
									Spring.AddUnitDamage(T[k], 10) 
								end
                    end
                else
				
					end
            end
        end
    end

    function updateWind()
        windVector.x, windVector.y, windVector.z = Spring.GetWind()
        windVector.x, windVector.y, windVector.z = windVector.x * 0.09, windVector.y * 0.09, windVector.z * 0.09
    end

    function addHeatToSurroundingArea(nr, heat)
        local LandScapeT = GG.LandScapeT
        wX = math.floor(windVector.x / math.max(math.abs(windVector.x), math.abs(windVector.z)))
        wZ = math.floor(windVector.z / math.max(math.abs(windVector.x), math.abs(windVector.z)))
        X = math.floor(fireT[nr].x / MetaMapResDivider)
        Z = math.floor(fireT[nr].z / MetaMapResDivider)
        X, Z = math.floor(X + wX), math.floor(Z + wZ)


        startX, endX = math.max(1, X - 1), math.min(X + 1, lMapX)
        startZ, endZ = math.max(1, Z - 1), math.min(Z + 1, lMapZ)
        for x = startX, endX, 1 do
            for z = startZ, endZ, 1 do
                if LandScapeT[x][z].boolShielded == false and math.abs(fireT[nr].y - LandScapeT[x][z].y) < 60 then
                    LandScapeT[x][z].AccumulatedHeat = LandScapeT[x][z].AccumulatedHeat + 20
                    --Spring.Echo("JW:foorestfire.."..LandScapeT[x][z].AccumulatedHeat)
                    if LandScapeT[x][z].AccumulatedHeat > PointOfIgnition * math.random(1, 2) and math.random(0, 1) and
                            LandScapeT[x][z].boolBurning == false and
                            LandScapeT[x][z].Food > 0 and
                            spGetGroundHeight(x * MetaMapResDivider, z * MetaMapResDivider) > 0 then
                        fireT[#fireT + 1] = { x = x * MetaMapResDivider, y = 15 + spGetGroundHeight(x * MetaMapResDivider, z * MetaMapResDivider), z = z * MetaMapResDivider }
                        spSpawnCEG("baarestfire", fireT[#fireT].x, fireT[#fireT].y, fireT[#fireT].z, math.random(0, 0.1), math.random(0.8, 1), math.random(0, 0.1))
                        LandScapeT[x][z].boolBurning = true
                        fireCounter = fireCounter + 1
                    end
                end
            end
        end
        GG.LandScapeT = LandScapeT
    end

    local teamGaia = Spring.GetGaiaTeamID()
	
	if not GG.getLandscapeOnFire then 
		GG.getLandscapeOnFire = 	function (x,z) 
			x,z = math.ceil(x/MetaMapResDivider),math.ceil(z/MetaMapResDivider)
			return GG.LandScapeT[x][z].boolBurning	
		end
	end

    function updateFire()
        local LandScapeT = GG.LandScapeT
        --Spring.Echo("Jw:Foorestfire3")
        for i = table.getn(fireT), 1, -1 do
            x, z = math.ceil(fireT[i].x / MetaMapResDivider), math.ceil(fireT[i].z / MetaMapResDivider)
            --if not initialized initialize as zero food for the fire
            if not LandScapeT[x] then LandScapeT[x] = {} end
            if not LandScapeT[x][z] then LandScapeT[x][z] = {} end
            if not LandScapeT[x][z].Food then
                LandScapeT[x][z].Food = 0
            end
            if not LandScapeT[x][z].AccumulatedHeat then
                LandScapeT[x][z].AccumulatedHeat = 0
            end

            LandScapeT[x][z].Food = LandScapeT[x][z].Food - costPerFrame

            LandScapeT[x][z].AccumulatedHeat = LandScapeT[x][z].AccumulatedHeat + InHeat
            addHeatToSurroundingArea(i, LandScapeT[x][z].AccumulatedHeat)

            if LandScapeT[x][z].boolShielded == true or LandScapeT[x][z].Food < 0 then

                LandScapeT[x][z].boolBurning = false
                table.remove(fireT, i);
                fireCounter = fireCounter - 1
            end
        end

        for i = table.getn(bigFireTable), 1, -1 do
            x, z = math.ceil(bigFireTable[i].x / MetaMapResDivider), math.ceil(bigFireTable[i].z / MetaMapResDivider)
            theHeatIsOn(x, z, 10)
            if LandScapeT[x][z].Food < 0 and math.random(0, 3) == 2 then
                table.remove(bigFireTable, i);
                fireCounter = fireCounter - 1
                GG.UnitsToSpawn:PushCreateUnit("gforrestfiredecalfactory", x * MetaMapResDivider, 0, z * MetaMapResDivider, 0, teamGaia)
            end
        end

        GG.LandScapeT = LandScapeT
    end

    function theHeatIsOn(x, z, amount)
        local LandScapeT = GG.LandScapeT
        for i = x - 1, x + 1 do
            for j = z - 1, z + 1 do
                LandScapeT[i][j].Food = LandScapeT[i][j].Food - amount
                LandScapeT[i][j].AccumulatedHeat = LandScapeT[i][j].AccumulatedHeat + 10
                if LandScapeT[i][j].Food == 0 then
                    LandScapeT[i][j].boolBurning = false
                end
            end
        end
        GG.LandScapeT = LandScapeT
    end

    function generateRandomDelayMap(map, val)
        T = {}
        for i = 1, #map do
            T[i] = math.ceil(math.random(1, val))
        end
        return T
    end

    function regrowFlameableMaterial()
        local LandScapeT = GG.LandScapeT
        for i = 1, GG.LandScapeT.ResX, 1 do
            for j = 1, GG.LandScapeT.ResZ, 1 do
                LandScapeT[i][j].Food = math.min(MaxFood, LandScapeT[i][j].Food + math.ceil(getAmountFlamableMaterial(i * MetaMapResDivider, j * MetaMapResDivider) / 100))
            end
        end
        GG.LandScapeT = LandScapeT
    end

    Boolfire = false
    function gadget:GameFrame(frame)

        if frame % 50 == 0 then
            updateWind()
            bigdelayMap = generateRandomDelayMap(bigFireTable, 5)
            delayMap = generateRandomDelayMap(fireT, 9)
        end

        if frame % 15 > 0 and frame % 15 < 5 then
            drawPermaFlames_AddDamage(bigdelayMap, math.max(1, frame % 5))
        end


        if frame % 12 > 0 and frame % 12 < 9 then
            Boolfire = drawFlames_AddDamage(delayMap, math.max(1, frame % 12))
        end

        if frame % 100 == 0 then
            addFiresFromGG()
            updateFire()
        end

        if frame % 333 == 0 then
            addRareSFX()

            if fireCounter > 0 and Boolfire == true then
                Spring.PlaySoundFile("sounds/gadgetsound/wildfire1.ogg", 1.0)
            end

            if fireCounter > MetaMapResDivider then mergeSmallFiresToPermaFire() end
        end

        if fireCounter == 0 and frame % 400 == 0 then
            regrowFlameableMaterial()
        end
    end
end