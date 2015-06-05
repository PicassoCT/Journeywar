

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
	 VFS.Include("scripts/lib_OS.lua"      )
 VFS.Include("scripts/lib_TableOp.lua"      )
  VFS.Include("scripts/lib_Build.lua" 	)

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
	local jghostDancerWeaponDefID= WeaponDefNames["jgdjump"].id
	local glavaWeaponID= WeaponDefNames["glavaweapon"].id
	local gVolcanoWeaponID= WeaponDefNames["lavabomb"].id
	local cFlareGun = WeaponDefNames["flaregun"].id
	local cmtwgrenade = WeaponDefNames["cmtwgrenade"].id
	local slicergun = WeaponDefNames["slicergun"].id
	local jvaryfoospearDefID = WeaponDefNames["varyfoospear"].id

	local cCssFlameT=WeaponDefNames["cflamethrower"].id
	local jDrugIncectorID=WeaponDefNames["jdruginjector"].id
	local cUniverseGun=WeaponDefNames["cuniversegun"].id
	local weapondefID3 = WeaponDefNames["cnukegrenadelvl3"].id
	local weaponDefIDjmotherofmercy = WeaponDefNames["jmomtractor"].id
	local tiglilWeaponDefID= WeaponDefNames["tiglilclosecombat"].id
	local striderWeaponDefID= WeaponDefNames["warpcannon"].id
	local highExLineGunDefID= WeaponDefNames["cexplochaingun"].id
	local jvaryjumpDefID= WeaponDefNames["jvaryjump"].id
	local crazorgrenadeDefID= WeaponDefNames["crazorgrenade"].id
	local jgluegunDefID= WeaponDefNames["jgluegun"].id
	local glueMineWeaponDefID= WeaponDefNames["gluemineweapon"].id
	
	local FireWeapons={ [gVolcanoWeaponID]=true,
						[glavaWeaponID]=true, 	
						[bunkerPlasmaDefID]=true,  
						[cCssFlameT]=true,   
						[cFlareGun]=true,
	
						}
	Script.SetWatchWeapon(crazorgrenadeDefID , true)
	Script.SetWatchWeapon(jvaryjumpDefID , true)
	Script.SetWatchWeapon(striderWeaponDefID , true)
	Script.SetWatchWeapon(tiglilWeaponDefID , true)

	Script.SetWatchWeapon(slicergun , true)
	Script.SetWatchWeapon(weaponDefIDjmotherofmercy , true)
	Script.SetWatchWeapon(cFlareGun , true)
	Script.SetWatchWeapon(cUniverseGun , true)
	Script.SetWatchWeapon(cRestrictorThumperID , true)
	Script.SetWatchWeapon(jDrugIncectorID , true)

	Script.SetWatchWeapon(cmtwgrenade , true)
	Script.SetWatchWeapon(jHiveHoundID , true)
	Script.SetWatchWeapon(jSwiftSpearID , true)
	Script.SetWatchWeapon(jghostDancerWeaponDefID , true)
	Script.SetWatchWeapon(crabWeaponDefID,true)
	Script.SetWatchWeapon(bunkerPlasmaDefID,true)
	Script.SetWatchWeapon(cCssFlameT,true)
	Script.SetWatchWeapon(glavaWeaponID,true)
	Script.SetWatchWeapon(gVolcanoWeaponID,true)
	Script.SetWatchWeapon(weapondefID3 , true)
	Script.SetWatchWeapon(highExLineGunDefID , true)
	Script.SetWatchWeapon(jvaryfoospearDefID , true)
	Script.SetWatchWeapon(jgluegunDefID , true)
	
local	gaiaTeamID=Spring.GetGaiaTeamID()
local	skySraperDefID=UnitDefNames["buibaicity1"].id
local	cssDefID=UnitDefNames["css"].id
local	gvolcanoDefID=UnitDefNames["gvolcano"].id
	
function impulseAfterDelay(id, x,y,z)
	if Spring.GetUnitIsDead(id)==false then
	Spring.AddUnitImpulse(id,x,y,z)
	end
end

function ShockWaveRippleOutwards(x,z, force, speed, range)
-- get all units in range
if not GG.ShockWaves then GG.ShockWaves ={} end
local OtherWaves= GG.ShockWaves

T=grabEveryone(x,y,range)

	for i=1,#T do
	ex,ey,ez=Spring.GetUnitPosition(T[i])

	dist=distance(x,z,ex,ez)
	const=  force/dist 

	if not OtherWaves[math.ceil(dist/speed)] then OtherWaves[math.ceil(dist/speed)]={} end
	myT={id=T[i], impulse={x=0, y= const,z=0} }
	table.insert(OtherWaves[math.ceil(dist/speed)],myT)
	end
GG.ShockWaves=OtherWaves
end

	
	
	function gadget:Explosion(weaponID, px, py, pz, AttackerID)
		
		if weaponID == jgluegunDefID then
		Spring.CreateUnit("ggluemine",	 px, py, pz ,1, gaiaTeamID)
		end
	
	
		if weaponID ==crazorgrenadeDefID then
		Spring.CreateUnit("crazordrone",px,py,pz,1,gaiaTeamID)			
		end
			
		if weaponID == jvaryjumpDefID then
		Spring.SetUnitPosition(AttackerID,px,py+80,pz)
		Spring.MoveCtrl.Enable(AttackerID,true)
		Spring.SetUnitAlwaysVisible(AttackerID,true)
		Spring.SetUnitBlocking (AttackerID,true,true,true)
		end
		
		if weaponID== jvaryfoospearDefID then
		--gluteus maximus- ha that sounds funny
			if not 	GG.ProjectileOrigin then	GG.ProjectileOrigin={} end	
		--wait a second thats my ass
		GG.ProjectileOrigin[AttackerID]={boolHitGround=true}
		Spring.SetUnitPosition(AttackerID,px,py,pz)	
		end
	
			
			
			if weaponID== striderWeaponDefID then
			teamid=Spring.GetUnitTeam(AttackerID)
			ShockWaveRippleOutwards(px,pz, 150, 180, 90)
		
			end
			
			
			--MTW Grenade
			if weaponID== cmtwgrenade then
			if Spring.UnitIsDead(AttackerID)==false then
			teamid=Spring.GetUnitTeam(AttackerID)
			Spring.CreateUnit("cmtwgrenade",px,py,pz,1,teamid)	
			else
			Spring.CreateUnit("cmtwgrenade",px,py,pz,1,gaiaTeamID)	
			end
			end
			
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
		
			if (weaponID == jghostDancerWeaponDefID or weaponID== jSwiftSpearID or weaponID== jHiveHoundID) and Spring.ValidUnitID(AttackerID)==true then
		--	----Spring.Echo("Mighty BadaBooom!")
			Spring.SetUnitPosition(AttackerID,px,py,pz)
			end
			--this one creates the headcrabs
			if (weaponID == crabWeaponDefID) then
			ShockWaveRippleOutwards(px,pz, 150, 180, 90)
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
	--1 	unitID
	--2 	counter
	--3 	speed
	function switchUnits(aID,bID)
	ax,ay,az=Spring.GetUnitPosition(aID)
	bx,by,bz=Spring.GetUnitPosition(bID)
	Spring.SetUnitPosition(aID,bx,bz)
	Spring.SetUnitPosition(bID,ax,az)
	end

	blowUpTable={}
	local timeTillBlowUp=3500
	
	local 	jShadowDefID=UnitDefNames["jshadow"].id
	
	
	function gadget:UnitDamaged(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam) 
	

	
		--You Sir, have a living spear attached to your gluteus maximus
		if weaponDefID== jvaryfoospearDefID then
		--gluteus maximus- ha that sounds funny
			if not 	GG.ProjectileOrigin then	GG.ProjectileOrigin={} end	
		--wait a second thats my ass
		GG.ProjectileOrigin[attackerID]={boolHitGround=false,id=unitID,lastAttackedPiece=Spring.GetUnitLastAttackedPiece(unitID)}
		--AaaahaaAaaaaAaaaahahaAAAAaaaaaaah
		end
		
		--perma speed reduction
		if weaponDefID == glueMineWeaponDefID or weaponDefID==jgluegunDefID	then
		GG.GluedForLife[unitID]=GG.GluedForLife[unitID]*0.9
		end
		
		if weaponDefID ==highExLineGunDefID then
			if 	blowUpTable[unitID] then blowUpTable[unitID].number= blowUpTable[unitID].number+1 
			else 	
			blowUpTable[unitID]={number=1, time=timeTillBlowUp, timeSinceBoom=0}	
			end	
		end
		
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
		
		if frame % 5 == 0 and GG.ShockWaves then
		local ShockW= GG.ShockWaves 
		for i=1,#ShockW do
			if i-5 < 0 and ShockW[i] then
				for k,v in pairs(ShockW[i]) do
				impulseAfterDelay(v.id, v.impulse.x,v.impulse.y,v.impulse.z)
				end
				ShockW[i]=nil
			else
			ShockW[i-5]=ShockW[i]
			end
		
		GG.ShockWaves=ShockW
		end
		end
	
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
				-- handling explosive Ammo
				--{number=1, time=timeTillBlowUp, timeSinceBoom=0}	
					for unit, values in pairs(blowUpTable) do
						values.time=values.time-30
						values.timeSinceBoom=values.timeSinceBoom+30
						
						if values.timeSinceBoom > values.time/values.number then
						blowItUp(unit)
						values.number=values.number-1
						end
								
						if values.number==0 then blowUpTable[unit]= nil end
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
	
	function blowItUp(unit,piece,vectordamage)
	stillAlive= Spring.ValidUnitID(unit)
	if stillAlive and stillAlive == true then
	--explosion
	ux,uy,uz=Spring.GetUnitPosition(unit,true)
	_,_,_,x,y,z=Spring.GetUnitPiecePosDir(unit,piece)
	Spring.SpawnCEG("chiexploammo",x+math.random(-5,5),y+10,z+math.random(-5,5),0,1,0,50)
	Spring.PlaySoundFile("sounds/cweapons/HiEx.ogg",1)
	--directionalShove
	v={}
	r={}
	v.x,v.y,v.z=x-ux,y-uy,z-uz
	v=normalizeVector(v)
	v=vMul(v, 900) --power
	
	-- crossproduct = (vectordamage x v  ) -> Transfer to local coordsystem hitpiece origin vector 
	r.x,r.y,r.z= 0,math.rad(math.random(-5,5)),0
	Spring.SetUnitRotation(unit,r.x,r.y,r.z)
	Spring.AddUnitImpulse(unit,v.x,v.y,v.z) 
	T=grabEveryone(unit,ux,uz,120)
	--SplashDamage
	foreach(
		T, 
		function (id) if math.random(0,1)==1 then Spring.AddUnitDamage(id,75) end end) 
	Spring.AddUnitDamage(unit,10)
	
	else
	return false
	end
	return true 
	end
	
	
end
	