

function gadget:GetInfo()
  return {
    name      = "Projectiles",
    desc      = "This gadget handles projectileimpacts",
    author    = "jK - always jk is there anyhting lua, that he didnt do long before you, making you look like a idiot in his fathers shoes. Oh, yeah, there it is, inferiority_complex.lua, author.. jk. of course. :(",
    date      = "Sep. 2008",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true,
  }
end

--this gadget controlls the transmutation of several units - and spawns headcrabs upon crabshell impacts




if (gadgetHandler:IsSyncedCode()) then

	local  StunnedUnitsTable={}
	nrOfUnits=0
	--1 unitid
	--2 counter
	--3 orgBuildSpeed
    local stunTime=9
    local selectRange=300
	local totalTime=9000
	local HARDCODED_RETREATDISTANCE=420
	
	local cRestrictorThumperID= WeaponDefNames["crestrictorthumper"].id
	local crabWeaponDefID = WeaponDefNames["crabshell"].id
	local bunkerPlasmaDefID = WeaponDefNames["cbonkerfire"].id
	local jHiveHoundID= WeaponDefNames["jhivehoundrocket"].id
	local jSwiftSpearID= WeaponDefNames["swiftprojectile"].id
	local weapondatID= WeaponDefNames["jgdjump"].id
	local glavaWeaponID= WeaponDefNames["glavaweapon"].id
	local gVolcanoWeaponID= WeaponDefNames["lavabomb"].id
	local cFlareGun = WeaponDefNames["flaregun"].id
	local slicergun = WeaponDefNames["slicergun"].id

	local cCssFlameT=WeaponDefNames["cflamethrower"].id
	local jDrugIncectorID=WeaponDefNames["jdruginjector"].id
	local cUniverseGun=WeaponDefNames["cuniversegun"].id
	local weapondefID3 = WeaponDefNames["cnukegrenadelvl3"].id
	local weaponDefIDjmotherofmercy = WeaponDefNames["jmomtractor"].id
	local tiglilWeaponDefID= WeaponDefNames["tiglilclosecombat"].id
	local FireWeapons={ [gVolcanoWeaponID]=true,
						[glavaWeaponID]=true, 	
						[bunkerPlasmaDefID]=true,  
						[cCssFlameT]=true,   
						[cFlareGun]=true,
	
						}
	Script.SetWatchWeapon(tiglilWeaponDefID , true)

	Script.SetWatchWeapon(slicergun , true)
	Script.SetWatchWeapon(weaponDefIDjmotherofmercy , true)
	Script.SetWatchWeapon(cFlareGun , true)
	Script.SetWatchWeapon(cUniverseGun , true)
	Script.SetWatchWeapon(cRestrictorThumperID , true)
	Script.SetWatchWeapon(jDrugIncectorID , true)

	Script.SetWatchWeapon(jHiveHoundID , true)
	Script.SetWatchWeapon(jSwiftSpearID , true)
	Script.SetWatchWeapon(weapondatID , true)
	Script.SetWatchWeapon(crabWeaponDefID,true)
	Script.SetWatchWeapon(bunkerPlasmaDefID,true)
	Script.SetWatchWeapon(cCssFlameT,true)
	Script.SetWatchWeapon(glavaWeaponID,true)
	Script.SetWatchWeapon(gVolcanoWeaponID,true)
	Script.SetWatchWeapon(weapondefID3 , true)
	
		gaiaTeamID=Spring.GetGaiaTeamID()
local	skySraperDefID=UnitDefNames["buibaicity1"].id
local	cssDefID=UnitDefNames["css"].id
local	gvolcanoDefID=UnitDefNames["gvolcano"].id
	

	
	
	function gadget:Explosion(weaponID, px, py, pz, AttackerID)

			if weaponID== cUniverseGun then
			tid=Spring.CreateUnit("cawilduniverseappears",px,py,pz, 1, gaiaTeamID)
			Spring.SetUnitAlwaysVisible(tid,true)
			end
		
				--jMotherofMercy
				if weaponID == weaponDefIDjmotherofmercy then
			
											  env = Spring.UnitScript.GetScriptEnv(AttackerID)
											  if env then
											  Spring.UnitScript.CallAsUnit(AttackerID, env.ripARock, px,py,pz )		
											  end
			
			    end
		
			if (weaponID == weapondatID or weaponID== jSwiftSpearID or weaponID== jHiveHoundID) and Spring.ValidUnitID(AttackerID)==true then
		--	----Spring.Echo("Mighty BadaBooom!")
			Spring.SetUnitPosition(AttackerID,px,py,pz)
			end
			--this one creates the headcrabs
			if (weaponID == crabWeaponDefID) then
			  Spring.CreateUnit("hc",px,py,pz, 1, gaiaTeamID)  
			end
			  
			  if weaponID== weapondefID3 then
			  Spring.CreateUnit("nukedecalfactory",px,py,pz,0,gaiaTeamID)
			  grenadeID=Spring.CreateUnit("ccomendernuke",px,py,pz,0,gaiaTeamID)
			  Spring.SetUnitNoSelect(grenadeID,true)
			  end
			
		return true
	end
	
local 	affectedUnits={}
	--1 unitID
	--2  counter
	--3 speed
	function switchUnits(aID,bID)
	ax,ay,az=Spring.GetUnitPosition(aID)
	bx,by,bz=Spring.GetUnitPosition(bID)
	Spring.SetUnitPosition(aID,bx,bz)
	Spring.SetUnitPosition(bID,ax,az)
	end


	
	local 	jShadowDefID=UnitDefNames["jshadow"].id
	function gadget:UnitDamaged(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam) 
		
		--poisonedDart
		if  weaponDefID == tiglilWeaponDefID then
		if not GG.Poisoned then GG.Poisoned={} end
		pval=120000 
		GG.Poisoned[unitID]=pval --time till poison wears off
		end
		
		--cBonkerPlasmaWeapon + FireWeapons
		if FireWeapons[weaponDefID]  and unitDefID ~= cssDefID then
					if GG.OnFire == nil then  GG.OnFire={} end
					----Spring.Echo("jw_projectileimpacts: BonkerFireDetected")
			boolInsertIt=true
			--very bad sollution n-times
					for i=1, table.getn(GG.OnFire), 1 do
						if 	GG.OnFire[i][1]	~= nil and	GG.OnFire[i][1]	== unitID then
							GG.OnFire[i][2]=math.ceil(math.random(190,1500)) 
							boolInsertIt=false
						end
					end
		
						if boolInsertIt==true then
						----Spring.Echo("jw_projectileimpacts:InsertIt")
						GG.OnFire[#GG.OnFire+1]={}
						GG.OnFire[#GG.OnFire][1]={}
						GG.OnFire[#GG.OnFire][1]=unitID
						GG.OnFire[#GG.OnFire][2]={}
						GG.OnFire[#GG.OnFire][2]=math.ceil(math.random(150,1000)) 
						end
						
		end
		
		if weaponDefID == slicergun then
		--only if the unit is hitsphere wise big enough 
		hp,maxhp=Spring.GetUnitHealth(unitID)
			if hp < 500 then
			sx,sy,sz=Spring.GetUnitCollisionVolumeData(unitID)
				if sx > 70 and sy > 70 and sz > 70 then
				

													  x,y,z=Spring.GetUnitPosition(unitID)
													  slicerColum=Spring.CreateUnit("cmeatcolumn",	x,y,z, 1, gaiaTeamID)  
													  env = Spring.UnitScript.GetScriptEnv(slicerColum)
													  if env then
													  Spring.UnitScript.CallAsUnit(unitID, env.youAreFuckingDead, unitID )		
													  end

				
				end
			end
		end
		
		--skySraper is damagedCase
			if skySraperDefID== unitDefID then
											  env = Spring.UnitScript.GetScriptEnv(unitID)
											  if env then
											  Spring.UnitScript.CallAsUnit(unitID, env.nothingEverHappend, attackerTeam )		
											  end
							
			end
		--jShadow is hit	
		if unitDefID== jShadowDefID then
		--unit attacked a jshadow lets store it for this foolishness
		if attackerID and Spring.ValidUnitID(attackerID)==true then
		tax=(#affectedUnits)+1
		affectedUnits[tax]={}
		affectedUnits[tax][1]=attackerID
		affectedUnits[tax][2]=100
		affectedUnits[tax][3]=Spring.GetUnitVelocity(attackerID)  
		--now we displace it and set its speed to zero
		Spring.SetUnitSensorRadius(attackerID,"los",5)
		end

		local lswitchUnits=switchUnits
			if #affectedUnits > 3 then
			--switch position
			
				for i=1,#affectedUnits-2, 2 do
					if affectedUnits[i][1] and Spring.ValidUnitID(affectedUnits[i][1]) ==true and affectedUnits[i+1] and Spring.ValidUnitID(affectedUnits[i+1][1]) == true then
					lswitchUnits(affectedUnits[i][1],affectedUnits[i+1][1])
					end	
				
				end
			
			end
		end
		
		--restrictor				
		if weaponDefID == cRestrictorThumperID and Spring.ValidUnitID(attackerID)==true then

							if     UnitDefs[unitDefID].isBuilding == true     then
							health=Spring.GetUnitHealth(unitID)
							Spring.SetUnitHealth(unitID, {paralyze =health*15})
							elseif  UnitDefNames["jbugcreeper"].id == unitDefID or UnitDefNames["jCrabCreeper"].id==unitDefID or UnitDefNames["jhoneypot"].id== unitDefID  then
							--Send To Distance
							ax,ay,az=Spring.GetUnitPosition(attackerID)
							ux,uy,uz=Spring.GetUnitPosition(unitID)
							ux,uz=ax-ux,az-uz
							max=math.max(math.abs(ux),math.abs(uz))
							ux,uz=ux/max,uz/max
							ux,uz=((ux+uz)/ux)*HARDCODED_RETREATDISTANCE,((ux+uz)/uz)*HARDCODED_RETREATDISTANCE
							Spring.SetUnitMoveGoal(unitID,ux+ax,uy,uz+az)							
							elseif attackerDefID== unitDefID then
							Spring.SetUnitHealth(unitID, {paralyze =0})
							end
		
		end
	
		
	
	end
	local everyNthFrame=30
	local poisonDamage=15
	function gadget:GameFrame(frame)
	    if frame % 31415 == 0 then
			for i=1,table.getn(affectedUnits),1 do
				if affectedUnits[i]== nil then table.remove(affectedUnits,i) end
			end
		
		end
		
			if frame % everyNthFrame == 0 then
				--handling the Poison Darted
				if GG.Poisoned then
					for k,v in pairs(GG.Poisoned) do
					GG.Poisoned[k]=GG.Poisoned[k]-everyNthFrame
					uh=Spring.GetUnitHealth(k)
						if uh then
						Spring.SetUnitHealth(k,uh-poisonDamage)
						end
					end
					
					for k,v in pairs(GG.Poisoned) do
						if v < 0 then
						table.remove(GG.Poisoned,k)
						table.remove(GG.Poisoned,k)
						end
					end
										
				
				end
		
				--affectedUnits
				if affectedUnits ~=  nil and table.getn(affectedUnits) ~= 0 then
					  for i=1,#affectedUnits,1 do
								  if affectedUnits[i]~=nil then
								  affectedUnits[i][2]= affectedUnits[i][2]-1 
									  if affectedUnits[i][2] <= 0 then
										  if Spring.ValidUnitID(affectedUnits[i][1])==true then
										  Spring.SetUnitSpeed(affectedUnits[1],affectedUnits[i][3])
										  end
									  affectedUnits[i]=nil	  
								  end	  
						  end
					  
					  end
									
				end
			end	
			--/affectedUnits
	 
	end
	local TableOfAllreadySearchedComender={}
	function GetWeaponDirection(attackerID)
		if TableOfAllreadySearchedComender[attackerID] then
		return 	Spring.GetUnitPieceDirection (attackerID,TableOfAllreadySearchedComender[attackerID])
		else
		PieceMap=Spring.GetUnitPieceList(attackerID)
		TableOfAllreadySearchedComender[attackerID]=PieceMap["sniper"]
		return getWeaponDirection(attackerID)
		end
	end
	

	
end
	