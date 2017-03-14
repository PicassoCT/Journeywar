

function gadget:GetInfo()
	return {
		name = "Projectiles",
		desc = "This gadget handles projectileimpacts",
		author = "jK - always jk is there anyhting lua, that he didnt do long before you, making you look like a idiot in his fathers shoes. Oh, yeah, there it is, inferiority_complex.lua, author.. jk. of course. :(",
		date = "Sep. 2008",
		license = "GNU GPL, v2 or later",
		layer = 0,
		enabled = true,
	}
end

--this gadget controlls the transmutation of several units - and spawns headcrabs upon crabshell impacts

if (gadgetHandler:IsSyncedCode()) then
	VFS.Include("scripts/lib_OS.lua" )
	VFS.Include("scripts/lib_UnitScript.lua" )
	VFS.Include("scripts/lib_Build.lua" 	)
	local UnitDamageFuncT={}
	local StunnedUnitsTable={}
	nrOfUnits=0
	--1 unitid
	--2 counter
	--3 orgBuildSpeed
	--local stunTime=9
	--local selectRange=300
	--local totalTime=9000
	JPLANKTONER_AA_STUNTIME= 15000
	GHOSTLIFETIME= 450
	jEthiefStealingQuota=5
	local HARDCODED_RETREATDISTANCE=420
	
	cRestrictorThumperID= WeaponDefNames["crestrictorthumper"].id
	crabShelWDefID = WeaponDefNames["crabshell"].id
	cArtDarkMaterWDefID = WeaponDefNames["cartdarkmat"].id
	bunkerPlasmaDefID = WeaponDefNames["cbonkerfire"].id
	jHiveHoundID= WeaponDefNames["jhivehoundrocket"].id
	jSwiftSpearID= WeaponDefNames["swiftprojectile"].id
	jghostDancerWeaponDefID= WeaponDefNames["jgdjump"].id
	glavaWeaponID= WeaponDefNames["glavaweapon"].id
	gVolcanoWeaponID= WeaponDefNames["lavabomb"].id
	cFlareGun = WeaponDefNames["flaregun"].id
	cmtwgrenade = WeaponDefNames["cmtwgrenade"].id
	jhunterDartDefID = WeaponDefNames["jdartgun"].id
	lazarusDeviceDefID = WeaponDefNames["lazarusrocket"].id
	slicergunDefID = WeaponDefNames["slicergun"].id
	jvaryfoospearDefID = WeaponDefNames["varyfoospear"].id
	cCssFlameT=WeaponDefNames["cflamethrower"].id
	cUniverseGun=WeaponDefNames["cuniversegun"].id
	nukeLvl2WeaponDefID = WeaponDefNames["cnukegrenadelvl2"].id
	nukeLvl3WeaponDefID = WeaponDefNames["cnukegrenadelvl3"].id
	weaponDefIDjmotherofmercy = WeaponDefNames["jmomtractor"].id
	tiglilWeaponDefID= WeaponDefNames["tiglilclosecombat"].id
	striderWeaponDefID= WeaponDefNames["warpcannon"].id
	highExLineGunDefID= WeaponDefNames["cexplochaingun"].id
	jvaryjumpDefID= WeaponDefNames["jvaryjump"].id
	crazorgrenadeDefID= WeaponDefNames["crazorgrenade"].id
	jgluegunDefID= WeaponDefNames["jgluegun"].id
	glueMineWeaponDefID= WeaponDefNames["gluemineweapon"].id
	greenSeerWeaponDefID= WeaponDefNames["greenseer"].id
	celetrochainWeaponDefID= WeaponDefNames["celetrochain"].id
	ChainLightningDefID=WeaponDefNames["cchainlightning"].id
	jplanktoneraaDefID=WeaponDefNames["jplanktoneraa"].id
	chcprojectileDefID=WeaponDefNames["hcprojectile"].id
	cAllyGatorMarkerDefID= WeaponDefNames["callygatormarker"].id
	CEaterRocketDefID=WeaponDefNames["ceater"].id
	jethiefweaponDefID=WeaponDefNames["jethiefweapon"].id
	jethiefretweaponDefID=WeaponDefNames["jethiefretweapon"].id
	cHarvestRocketDefID=WeaponDefNames["charvest"].id
	cAntiMatterDefID=WeaponDefNames["cantimatter"].id
	catapultDefID=WeaponDefNames["ccatapult"].id
	jeliahbeamDefID=WeaponDefNames["jeliahbeam"].id
	cgaterailgunDefID =WeaponDefNames["cgaterailgun"].id
	cEfenceWeapondDefID =WeaponDefNames["cwefence1"].id
	poisonRaceDartDef =WeaponDefNames["jpoisonracedart"].id
	
	ChainLightningTable={}
	local FireWeapons={ [gVolcanoWeaponID]=true,
		[glavaWeaponID]=true, 	
		[bunkerPlasmaDefID]=true, 
		[cCssFlameT]=true, 
		[cFlareGun]=true
	}
	RazorGrenadeTable={}
	
	Script.SetWatchWeapon(cEfenceWeapondDefID , true)
	Script.SetWatchWeapon(cgaterailgunDefID , true)
	Script.SetWatchWeapon(jeliahbeamDefID , true)
	Script.SetWatchWeapon(chcprojectileDefID , true)
	Script.SetWatchWeapon(cAntiMatterDefID , true)
	Script.SetWatchWeapon(catapultDefID , true)
	Script.SetWatchWeapon(cHarvestRocketDefID , true)
	Script.SetWatchWeapon(CEaterRocketDefID , true)
	Script.SetWatchWeapon(lazarusDeviceDefID , true)
	Script.SetWatchWeapon(ChainLightningDefID , true)
	Script.SetWatchWeapon(celetrochainWeaponDefID , true)
	Script.SetWatchWeapon(crazorgrenadeDefID , true)
	Script.SetWatchWeapon(jvaryjumpDefID , true)
	Script.SetWatchWeapon(striderWeaponDefID , true)
	Script.SetWatchWeapon(jethiefweaponDefID , true)
	Script.SetWatchWeapon(jethiefretweaponDefID , true)
	Script.SetWatchWeapon(tiglilWeaponDefID , true)
	Script.SetWatchWeapon(slicergunDefID , true)
	Script.SetWatchWeapon(weaponDefIDjmotherofmercy , true)
	Script.SetWatchWeapon(cFlareGun , true)
	Script.SetWatchWeapon(cUniverseGun , true)
	Script.SetWatchWeapon(cRestrictorThumperID , true)
	Script.SetWatchWeapon(cmtwgrenade , true)
	Script.SetWatchWeapon(jhunterDartDefID , true)
	Script.SetWatchWeapon(jHiveHoundID , true)
	Script.SetWatchWeapon(jSwiftSpearID , true)
	Script.SetWatchWeapon(jghostDancerWeaponDefID , true)
	Script.SetWatchWeapon(crabShelWDefID,true)
	Script.SetWatchWeapon( cArtDarkMaterWDefID, true)
	Script.SetWatchWeapon(bunkerPlasmaDefID,true)
	Script.SetWatchWeapon(cCssFlameT,true)
	Script.SetWatchWeapon(glavaWeaponID,true)
	Script.SetWatchWeapon(gVolcanoWeaponID,true)
	Script.SetWatchWeapon(nukeLvl2WeaponDefID , true)
	Script.SetWatchWeapon(nukeLvl3WeaponDefID , true)
	Script.SetWatchWeapon(highExLineGunDefID , true)
	Script.SetWatchWeapon(jvaryfoospearDefID , true)
	Script.SetWatchWeapon(jgluegunDefID , true)
	Script.SetWatchWeapon(cAllyGatorMarkerDefID , true)
	
	--units To be exempted from instantly lethal force
	local fuckingSpecial ={
		[UnitDefNames["ccomender"].id]=true,
		[UnitDefNames["beanstalk"].id]=true,
		[UnitDefNames["citadell"].id]=true,
		[UnitDefNames["gvolcano"].id]=true,
		[UnitDefNames["gproceduralfeature"].id]=true,
	}
	
	local	gaiaTeamID=Spring.GetGaiaTeamID()
	local	skySraperDefID=UnitDefNames["buibaicity1"].id
	local	cssDefID=UnitDefNames["css"].id
	local	gvolcanoDefID=UnitDefNames["gvolcano"].id
	
	function unitVannishAntimatterSFX(id)
		
		Spring.SetUnitNoSelect(id,true)
		boolIsBuilding=UnitDefs[Spring.GetUnitDefID(id)].id
		tpiecesTable=getPieceMap(id)		
		
		for i=1,table.getn(tpiecesTable) do	
			spawnCegAtPiece(id,tpiecesTable[i].pid,"antimatter",10)
			spawnCegAtPiece(id,tpiecesTable[i].pid,"bgantimatter",10)		
		end	
		GG.UnitsToKill:PushKillUnit(id,true,true)
		
		size=8
		if GG.DynDefMap == nil then GG.DynDefMap={} end
		if GG.DynRefMap == nil then GG.DynRefMap={} end
		GG.DynDefMap[#GG.DynDefMap+1]=	{x=x/8, z=z/8,Size=size,blendType ="melt", filterType="borderblur"}
		GG.DynRefMap[#GG.DynRefMap+1]=	prepareHalfSphereTable(size,-0.25)		
	end
	
	
	function impulseAfterDelay(id, x,y,z)
		if Spring.GetUnitIsDead(id)==false then
			Spring.AddUnitImpulse(id,x,y,z)
		end
	end
	
	function ShockWaveRippleOutwards(x,z, force, speed, range)
		-- get all units in range
		if not GG.ShockWaves then GG.ShockWaves ={} end
		local OtherWaves= GG.ShockWaves
		assert(range)
		T=getAllInCircle(x,z,range)
		
		for i=1,#T do
			ex,ey,ez=Spring.GetUnitPosition(T[i])
			
			dist=distance(x,z,ex,ez)
			const= force/dist 
			
			if not OtherWaves[math.ceil(dist/speed)] then OtherWaves[math.ceil(dist/speed)]={} end
			myT={id=T[i], impulse={x=0, y= const,z=0} }
			table.insert(OtherWaves[math.ceil(dist/speed)],myT)
		end
		GG.ShockWaves=OtherWaves
	end
	
	local	explosionFunc={
		[catapultDefID]= function(weaponDefID, px, py, pz, AttackerID)
			Spring.SpawnCEG("ccatapultexpl",px,py+5,pz,0,1,0,10)	
		end,	
		[cArtDarkMaterWDefID]= function(weaponDefID, px, py, pz, AttackerID)
			if not GG.AddFire then 	GG.AddFire={} end		
		end,
		[lazarusDeviceDefID]= function(weaponDefID, px, py, pz, AttackerID)
			teamid=Spring.GetUnitTeam(AttackerID)
			GG.ComEnders[teamID]=Spring.CreateUnit(UnitDefNames["ccomender"].id,	px,py,pz, 1, teamid)
		end,	
		[celetrochainWeaponDefID]= function(weaponDefID, px, py, pz, AttackerID)
			teamid=Spring.GetUnitTeam(AttackerID)
			T=Spring.GetUnitsInCylinder(px,pz,350)
			ChainLightningTable[AttackerID]= 30
			
			for i= 1,5 do
				Spring.SpawnCEG("cchainlightning",px,py+25,pz,math.random(-1,1),math.random(0.1,1),math.random(-1,1),40)
			end
			
			if T then
				
				for i=1, #T do
					if Spring.ValidUnitID(T[i])==true then
						gx,gy,gz=Spring.GetUnitPosition(T[i])
						v=makeVector(px-gx,py-gy,pz-gz)
						v=normVector(v)
						v=mulVector(v,-1)
						
						
						
						local	 ChaingProjParams={
							pos = { px, py+20, pz}, 
							["end"] = {gx,gy,gz},
							speed={v.x,v.y,v.z},
							owner = AttackerID,
							team = teamid,	
							spread={math.random(-5,5),math.random(-5,5),math.random(-5,5)},
							ttl=420,
							error = {0,0,0},
							maxRange = 600,
							gravity = Game.gravity,
							startAlpha = 1,
							endAlpha = 1,						
							model = "emptyObjectIsEmpty.s3o",
							cegTag = "cchainlightning"
						}					
						
						projectileID = Spring.SpawnProjectile( ChainLightningDefID ,ChaingProjParams)
						
						
					end
				end
			else
				for i=1, 3 ,1 do
					
					local	 ChaingProjParams={
						pos = { px, py+20, pz}, 
						["end"] = {math.random(-150,150),math.random( 0,150),math.random(-150,150)},
						speed={v.x,v.y,v.z},
						owner = AttackerID,
						team = teamid,	
						spread={math.random(-50,50),math.random(-50,50),math.random(-50,50)},
						ttl=420,
						tracking=true,
						error = {0,0,0},
						maxRange = 600,
						gravity = Game.gravity,
						startAlpha = 1,
						endAlpha = 1,						
						model = "emptyObjectIsEmpty.s3o",
						cegTag = "cchainlightning"
					}
					
					projectileID = Spring.SpawnProjectile( ChainLightningDefID ,ChaingProjParams)
					
					
				end
			end
		end,
		[jgluegunDefID]=function(weaponDefID, px, py, pz, AttackerID)
			id=Spring.CreateUnit("ggluemine",	 px, py, pz ,1, gaiaTeamID)
			Spring.SetUnitBlocking(id,false)
		end,
		[crazorgrenadeDefID]=function(weaponDefID, px, py, pz, AttackerID)
			
			if not RazorGrenadeTable[AttackerID] then RazorGrenadeTable[AttackerID] ={} end
			
			RazorGrenadeTable[AttackerID]=validateUnitTable(RazorGrenadeTable[AttackerID])
			
			
			teamID=Spring.GetUnitTeam(AttackerID)
			ad=math.huge
			if #RazorGrenadeTable[AttackerID] > 5 then
				it=math.floor(math.random(1,5))
				Spring.DestroyUnit(	RazorGrenadeTable[AttackerID][it],true,true)
				RazorGrenadeTable[AttackerID][it]=Spring.CreateUnit("crazordrone",px,py,pz,1,teamID)	
				ad=RazorGrenadeTable[AttackerID][it] 
			else
				RazorGrenadeTable[AttackerID][#RazorGrenadeTable[AttackerID]+1]=Spring.CreateUnit("crazordrone",px,py,pz,1,teamID)	
				ad=RazorGrenadeTable[AttackerID][#RazorGrenadeTable[AttackerID]] 
			end	
			if ad and Spring.ValidUnitID(ad) == true then
			
			ed= Spring.GetUnitNearestEnemy(ad)
			if ed then 
				x,y,z=Spring.GetUnitPosition(ed)
				Spring.SetUnitMoveGoal(ad,x,y,z)
			end
			end
			
		end,
		[jvaryjumpDefID]=function(weaponDefID, px, py, pz, AttackerID)
			if AttackerID then
				Spring.SetUnitPosition(AttackerID,px,py+35,pz)
				env=Spring.UnitScriptEnv(AttackerID)
				if env then
					Spring.UnitScript.CallAsUnit(AttackerID,env.setInTransit,false )		
				end				
			end
			
		end,
		[jvaryjumpDefID]=function(weaponDefID, px, py, pz, AttackerID)
			--gluteus maximus- ha that sounds funny
			if not 	GG.ProjectileOrigin then	GG.ProjectileOrigin={} end	
			--wait a second thats my ass
			GG.ProjectileOrigin[AttackerID]={boolHitGround=true}
			Spring.SetUnitPosition(AttackerID,px,py,pz)	
			
		end,
		[striderWeaponDefID]=function(weaponDefID, px, py, pz, AttackerID)
			teamid=Spring.GetUnitTeam(AttackerID)
			ShockWaveRippleOutwards(px,pz, 150, 180, 90)
			Spring.SpawnCEG("factory_explosion",px,py+10,pz,0,1,0,50)		
		end,
		[jhunterDartDefID]=function(weaponDefID, px, py, pz, AttackerID)
			udefID= Spring.GetUnitDefID(AttackerID)
			unitChoice= "jhunterdart"
			if udefID == UnitDefNames["chunter"].id then
				unitChoice = "chunterdart"
			end
			
			dartID= ""
			if Spring.GetUnitIsDead(AttackerID)==false then
				teamid=Spring.GetUnitTeam(AttackerID)
				dartID= Spring.CreateUnit(unitChoice,px,py,pz,1,teamid)	
				hx,hy,hz = Spring.GetUnitDirection(AttackerID)
				Spring.SetUnitDirection (dartID, hx,hy,hz)
			else
				dartID= Spring.CreateUnit(unitChoice,px,py,pz,1,gaiaTeamID)	
			end		
		
		AttachUnitToPieceNearImpact(dartID, AttackerID,px,py,pz, 10)		
		end,
		[cmtwgrenade]=function(weaponDefID, px, py, pz, AttackerID)
			if Spring.ValidUnitID(AttackerID) ==true then
				if Spring.GetUnitIsDead(AttackerID)==false then
					teamid=Spring.GetUnitTeam(AttackerID)
					Spring.CreateUnit("cmtwgrenade",px,py,pz,1,teamid)	
				else
					Spring.CreateUnit("cmtwgrenade",px,py,pz,1,gaiaTeamID)	
				end
			end		
		end,
		[cUniverseGun]=function(weaponDefID, px, py, pz, AttackerID)
			tid=Spring.CreateUnit("cawilduniverseappears",px,py,pz, 1, gaiaTeamID)
			Spring.SetUnitAlwaysVisible(tid,true)
			
		end,
		[weaponDefIDjmotherofmercy]=function(weaponDefID, px, py, pz, AttackerID)
			env = Spring.UnitScript.GetScriptEnv(AttackerID)
			if env then
				Spring.UnitScript.CallAsUnit(AttackerID, env.ripARock, px,py,pz )		
			end					
		end,
		[jSwiftSpearID]=function(weaponDefID, px, py, pz, AttackerID)
			if Spring.ValidUnitID(AttackerID)==true then Spring.SetUnitPosition(AttackerID, px, py, pz)	end					
		end,
		[jHiveHoundID]=function(weaponDefID, px, py, pz, AttackerID)
			if Spring.ValidUnitID(AttackerID)==true then Spring.SetUnitPosition(AttackerID, px, py, pz)	end
		end,	
		[jghostDancerWeaponDefID]=function(weaponDefID, px, py, pz, AttackerID)
			if Spring.ValidUnitID(AttackerID)==true then Spring.SetUnitPosition(AttackerID, px, py, pz)	end
		end,
		[crabShelWDefID]=function(weaponDefID, px, py, pz, AttackerID)
			ShockWaveRippleOutwards( px, pz, 150, 180, 90)			
			Spring.CreateUnit("hc",px,py,pz, 1, gaiaTeamID) 
		end,
		[nukeLvl2WeaponDefID]=function(weaponDefID, px, py, pz, AttackerID)
			Spring.CreateUnit("nukedecalfactory",px,py,pz,0,gaiaTeamID)
			grenadeID=Spring.CreateUnit("ccomendernuke",px,py,pz,0,gaiaTeamID)
			Spring.SetUnitNoSelect(grenadeID,true)
			end,		[nukeLvl3WeaponDefID]=function(weaponDefID, px, py, pz, AttackerID)
			Spring.CreateUnit("nukedecalfactory",px,py,pz,0,gaiaTeamID)
			grenadeID=Spring.CreateUnit("ccomendernukelvl3",px,py,pz,0,gaiaTeamID)
			Spring.SetUnitNoSelect(grenadeID,true)
		end,
		[cgaterailgunDefID]=function(weaponDefID, px, py, pz, AttackerID)

			ateam=Spring.GetUnitTeam(AttackerID)
			id= Spring.CreateUnit("cgatefort",px,py,pz,0,ateam)
			if not GG.FiringGateFotressTable then GG.FiringGateFotressTable ={} end 
			if not GG.FiringGateFotressTable[ateam] then GG.FiringGateFotressTable[ateam] ={} end
			if not GG.FiringGateFotressTable[ateam][AttackerID] then GG.FiringGateFotressTable[ateam][AttackerID]=false end
			GG.FiringGateFotressTable[ateam][AttackerID]=false 
			

			transferUnitStatusToUnit(AttackerID, id)

		end		


		}	
	
	function gadget:Explosion(weaponDefID, px, py, pz, AttackerID)
		if 	explosionFunc[weaponDefID] then explosionFunc[weaponDefID](weaponDefID, px, py, pz, AttackerID) end		
		return true
	end
	
	ghostShadowEffectedUnits={}	
	
	blowUpTable={}
	local timeTillBlowUp=3500	
	local 	jShadowDefID=UnitDefNames["jshadow"].id
	
	HarvestRocketLoadTable={}	
	JeliahBeamAccu={}
	 JELIAHBEAMDAMAGEMULTIPLIERMAX=24
	UnitDamageFuncT[jeliahbeamDefID]= function (unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam)
		if not JeliahBeamAccu[attackerID] or JeliahBeamAccu[attackerID].targetID ~= unitID  then 
		newTarget={ targetID=unitID, accu=1.0}
		JeliahBeamAccu[attackerID]=newTarget
		end
	
			JeliahBeamAccu[attackerID].accu=math.min((JeliahBeamAccu[attackerID].accu * 1.02), JELIAHBEAMDAMAGEMULTIPLIERMAX)
			Spring.AddUnitDamage(unitID, math.ceil( JeliahBeamAccu[attackerID].accu))
		end	
	
	UnitDamageFuncT[cAntiMatterDefID]= function (unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam)
		if not fuckingSpecial[unitDefID] then
			unitVannishAntimatterSFX(unitID) 
		end
	end
	
	UnitDamageFuncT[catapultDefID]= function (unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam)
		
		health=Spring.GetUnitHealth(unitID)
		Spring.SetUnitHealth(unitID, {paralyze =health*1.5 })
		Spring.SetUnitArmored(unitID,3)
		Spring.AddUnitImpulse(unitID,math.random(-1,1)/10,0,math.random(-1,1)/10)
		
		
	end 
	
	UnitDamageFuncT[cHarvestRocketDefID]= function (unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam)
		
		if HarvestRocketLoadTable[unitID] and HarvestRocketLoadTable[unitID][attackerID] then
			
			Spring.SetUnitResourcing(unitID, "umm",	 HarvestRocketLoadTable[unitID][attackerID].metal)
			Spring.SetUnitResourcing(unitID, "ume",	 HarvestRocketLoadTable[unitID][attackerID].energy)
			HarvestRocketLoadTable[unitID][attackerID]=nil
			
			
		end
		return 0
	end 
	
	UnitDamageFuncT[cEfenceWeapondDefID]= function (unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam)
		spawnCegAtUnit(unitID,"cefencesplash",0,10,0)
		spawnCegAtUnit(attackerID,"cefencesplash",0,10,0)
	
		return damage
	end 
	
	UnitDamageFuncT[cAllyGatorMarkerDefID]= function (unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam)
		
		env = Spring.UnitScript.GetScriptEnv(attackerID)
		if env then
			
			Spring.UnitScript.CallAsUnit(attackerID, env.tagYourIt, unitID )		
		end	
		
		return 0
	end 
	
	UnitDamageFuncT[CEaterRocketDefID]= function (unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackID, attackerDefID, attackerTeam) 			
		
		attackerID= attackID 
		valid=Spring.ValidUnitID(attackerID)
		if not attackerID or (not valid) or valid==false then
			attackID=	Spring.GetUnitLastAttacker(unitID)
		end
		metalRes,energyRes= UnitDefs[unitDefID].metalCost,UnitDefs[unitDefID].energyCost
		
		gx,gy,gz=Spring.GetUnitPosition(unitID)
		tx,ty,tz=Spring.GetUnitPosition(attackerID)
		ateamid=Spring.GetUnitTeam(attackerID)
		vx,vy,vz=Spring.GetUnitCollisionVolumeData(unitID)
		max=math.max(vx,math.max(vy,vz))
		
		v=makeVector(tx-gx,ty-gy,tz-gz)
		v=normVector(v)
		
		
		local	 HarvestRocketParams={
			pos = { gx, gy+max,gz}, 
			["end"] = {tx,ty+10,tz},
			speed={v.x,v.y+2,v.z},
			owner = unitID,
			team = ateamid,	
			spread={math.random(-5,5),math.random(-5,5),math.random(-5,5)},
			ttl=420,
			error = {0,0,0},
			maxRange = 1200,
			gravity = Game.gravity,
			startAlpha = 1,
			endAlpha = 1,						
			model = "cHarvestProj.s3o",
		}					
		
		projectileID = Spring.SpawnProjectile( cHarvestRocketDefID ,HarvestRocketParams)
		
		if projectileID then
			if not HarvestRocketLoadTable[attackerID] then HarvestRocketLoadTable[attackerID]={} end
			HarvestRocketLoadTable[attackerID][unitID]={metal=metalRes, energy=energyRes, vicID = projectileID }
		end
		
	end
	
	UnitDamageFuncT[greenSeerWeaponDefID]= function (unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam) 			
		
		hitPoints=Spring.GetUnitHealth(unitID)
		if damage/hitPoints > 0.3 then 
			x,y,z=Spring.GetUnitPosition(unitID)
			Spring.DestroyUnit(unitID)
			Spring.CreateUnit("jtree",x,y,z,1,attackerTeam)
		end
	end
	
	UnitDamageFuncT[jvaryfoospearDefID]= function (unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam) 	
		--You Sir, have a living spear attached to your gluteus maximus
		--gluteus maximus- ha that sounds funny
		if not 	GG.ProjectileOrigin then	GG.ProjectileOrigin={} end	
		--wait a second thats my ass
		GG.ProjectileOrigin[attackerID]={boolHitGround=false,id=unitID,lastAttackedPiece=Spring.GetUnitLastAttackedPiece(unitID)}
		--AaaahaaAaaaaAaaaahahaAAAAaaaaaaah
	end
	
	--perma speed reduction - glued to ground with lots of sucction, lacking any possible seduction
	UnitDamageFuncT[glueMineWeaponDefID]= function (unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam)
		if not GG.GluedForLife[unitID] then GG.GluedForLife[unitID] = 1000 end
		GG.GluedForLife[unitID]=GG.GluedForLife[unitID]*0.9
	end
	UnitDamageFuncT[jgluegunDefID]= function (unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam) 	
		if not GG.GluedForLife[unitID] then GG.GluedForLife[unitID] = 1000 end
		GG.GluedForLife[unitID]=GG.GluedForLife[unitID]*0.9
	end
	
	UnitDamageFuncT[highExLineGunDefID]= function (unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam) 			
		if 	blowUpTable[unitID] then blowUpTable[unitID].number= blowUpTable[unitID].number+1 
		else 	
			blowUpTable[unitID]={number=1, time=timeTillBlowUp, timeSinceBoom=0}	
		end	
	end
	
	--poisonedDart
	UnitDamageFuncT[tiglilWeaponDefID]= function (unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam) 			
		
		if not GG.Poisoned then GG.Poisoned={} end
		pval=120000 
		GG.Poisoned[unitID]=pval --time till poison wears off
	end
	
	--set the Unit
	UnitDamageFuncT[jplanktoneraaDefID]= function (unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam) 			
		--stun this unit
		hp = Spring.GetUnitHealth(unitID)		
		if hp then 
			Spring.SetUnitHealth(unitID,{paralyze = hp * JPLANKTONER_AA_STUNTIME})
			
			--moveControll
			Spring.MoveCtrl.Enable(unitID)
			
			eventFunction = function (id,frame, persPack)
				nextFrame=frame+1
				if persPack then
					if persPack.unitID then
						--check 
						boolDead= Spring.GetUnitIsDead(persPack.unitID )
						
						if boolDead and boolDead == true then
							Spring.MoveCtrl.Disable(persPack.unitID)
						end						
						
						if not persPack.startFrame then
							persPack.startFrame=frame
						end
						
						if persPack.startFrame then
							nextFrame= persPack.startFrame + JPLANKTONER_AA_STUNTIME
						end
						
						if frame >= nextFrame then
							Spring.MoveCtrl.Disable(persPack.unitID)
							return 
						end
					end
				end	 
				return nextFrame, persPack
			end		
			persPack={unitID= unitID, totalTime=JPLANKTONER_AA_STUNTIME}
			GG.EventStream:CreateEvent( eventFunction, persPack,Spring.GetGameFrame()+1)
			
		end
		return damage
	end
	
	--headcrab function - sets the headcrab where its victim was
	UnitDamageFuncT[chcprojectileDefID]= function (unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam) 			
		px,py,pz=Spring.GetUnitPosition(unitID)
		if px and attackerID and Spring.ValidUnitID(attackID)==true then
			Spring.SetUnitPosition(attackerID, px+5, py, pz)
			Spring.SetUnitNoDraw(attackerID,true)
		end
		return damage
	end
	
	UnitDamageFuncT[slicergunDefID]= function (unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam) 			
		Spring.Echo("jw_projectileimpacts:: FieldScoooper HIt found")
		--only if the unit is hitsphere wise big enough 
		hp,maxhp=Spring.GetUnitHealth(unitID)
		if hp/maxhp < 0.5 and hp < 300 then
			sx,sy,sz=Spring.GetUnitCollisionVolumeData(unitID)
			if math.sqrt(sx ^2 +sy ^2 + sz^2) >35 then				
				x,y,z=Spring.GetUnitPosition(unitID)
				slicerColum=Spring.CreateUnit("cmeatcolumn",	x,y,z, 1, unitTeam) 
				Spring.SetUnitNoSelect(slicerColum,true)
				env = Spring.UnitScript.GetScriptEnv(slicerColum)
				if env then
					Spring.UnitScript.CallAsUnit(unitID, env.youAreFuckingDead, unitID )		
				end				
			end
		end
	end
	
	UnitDamageFuncT[poisonRaceDartDef]= function (unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam) 			
		--Poison a Unit to 1 Health and recovers it
		poison = function (evtID, frame, persPack,startFrame)
				--only apply if Unit is still alive
				if Spring.GetUnitIsDead(persPack.victimID)==true then
					return nil, persPack
				end

				--filter out imune Units
				if persPack.ImuneUnits then
					defID= Spring.GetUnitDefID(persPack.victimID)
					if persPack.ImuneUnits[defID] then
						return nil, persPack
					end
				end
				healthOffSet=0
				hp,maxHP= Spring.GetUnitHealth(persPack.victimID)
				
				if persPack.lastSetHp and hp ~= persPack.lastSetHp then
				healthOffSet= hp-persPack.lastSetHp
				end
				
			if not persPack.boolNotFirstCall then   
				persPack.boolNotFirstCall = true 
				persPack.factor = 1.01
				persPack.orgHp = hp
				persPack.lastSetHp=1
				Spring.SetUnitHealth(persPack.victimID,1)
			else
				toSetFactor= math.max(math.min(1,math.abs(persPack.factor)),0.1)
				toSetHp = persPack.orgHp * toSetFactor
				persPack.lastSetHp=toSetHp
				Spring.SetUnitHealth(persPack.victimID,toSetHp + healthOffSet)
			end
			
			timeExpired=math.abs(frame-startFrame)/50
			persPack.factor = math.max(0.05, math.min(1,math.log(1+timeExpired)))
			
			--Exit Clause
			if Spring.GetUnitHealth(persPack.victimID) >= persPack.orgHp then
				return nil, persPack
			end

			return frame + 50, persPack
		end
		
	GG.EventStream:CreateEvent(poison, frame, {victimID=unitID, ImuneUnits= fuckingSpecial})
	
	end
	UnitDamageFuncT[jethiefweaponDefID]= function (unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam) 			
		--only if the unit is hitsphere wise big enough 
		if unitID and attackerTeam then
			energy= Spring.GetTeamResources(attackerTeam,"energy")
			if energy and energy > jEthiefStealingQuota then
				Spring.UseUnitResource(unitID,"e",jEthiefStealingQuota)
				
				
				gx,gy,gz=Spring.GetUnitPosition(unitID)
				tx,ty,tz=Spring.GetUnitPosition(attackerID)
				ateamid=Spring.GetUnitTeam(attackerID)
				vx,vy,vz=Spring.GetUnitCollisionVolumeData(unitID)
				max=math.max(vx,math.max(vy,vz))
				
				v=makeVector(tx-gx,ty-gy,tz-gz)
				v=normVector(v)
				
				
				local HarvestRocketParams={
					pos = { gx, gy+max,gz}, 
					["end"] = {tx,ty+10,tz},
					speed={v.x,v.y+2,v.z},
					owner = unitID,
					team = ateamid,	
					target= attackerID,
					spread={math.random(-5,5),math.random(-5,5),math.random(-5,5)},
					ttl=420,
					error = {0,0,0},
					maxRange = 1200,
					gravity = Game.gravity,
					startAlpha = 1,
					endAlpha = 1,						
					model = "jGlowProj.s3o",
					cegTag = "jglowstrip",
				}						
				projectileID = Spring.SpawnProjectile( jethiefretweaponDefID ,HarvestRocketParams)
				if projectileID then
					Spring.SetProjectileTarget(attackerID,"u")
				end
			end
		end
		
	end
	
	UnitDamageFuncT[jethiefretweaponDefID]= function (unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam) 			
		--only if the unit is hitsphere wise big enough 
		if unitID and attackerTeam then
			energy= Spring.GetTeamResources(attackerTeam,"energy")
			if energy and energy > jEthiefStealingQuota then
				Spring.AddUnitResource(unitID,"e",jEthiefStealingQuota)
			end
		end
		
	end
	
	--restrictor			
	
	UnitDamageFuncT[cRestrictorThumperID]= function (unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam) 		
		if weaponDefID == cRestrictorThumperID and Spring.ValidUnitID(attackerID)==true then
			
			if UnitDefs[unitDefID].isBuilding == true then
				health=Spring.GetUnitHealth(unitID)
				Spring.SetUnitHealth(unitID, {paralyze =health*15})
			elseif UnitDefNames["jbugcreeper"].id == unitDefID or UnitDefNames["jcrabcreeper"].id==unitDefID or UnitDefNames["jhoneypot"].id== unitDefID then
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
	
	function distanceOfUnitTo(ud,x,y,z)
		if not ud then return math.huge end
		
		px,py,pz=Spring.GetUnitPosition(ud)
		ux,uy,uz=px-x,py-y,pz-z
		return math.sqrt(ux^2+uy^2 +uz^2),px,py,pz
	end
	
	
	function gadget:UnitDamaged(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, projectileID, attackerID, attackerDefID, attackerTeam) 
		
		
		--chain Lightning 
		if weaponDefID == ChainLightningDefID and attackerID then
			if not ChainLightningTable[attackerID] then ChainLightningTable[attackerID]=30 end
			
			
			ChainLightningTable[attackerID]=ChainLightningTable[attackerID]-1
			x,y,z=Spring.GetUnitPosition(unitID)
			ed,ad=Spring.GetUnitNearestEnemy(unitID),Spring.GetUnitNearestAlly(unitID)
			
			distEnemy,ex,ey,ez=distanceOfUnitTo(ed,x,y,z)
			distAlly,ax,ay,az=distanceOfUnitTo(ad,x,y,z)
			
			targetID=0
			if distEnemy > distAlly then 
				targetID=ad 
				gx,gy,gz=ax,ay,az
			else 
				targetID=ed 
				gx,gy,gz=ex,ey,ez
			end
			
			vx,vy,vz=Spring.GetUnitCollisionVolumeData(unitID)
			max=math.max(vx,math.max(vy,vz))
			
			
			teamid=Spring.GetUnitTeam(attackerID)
			local	 ChaingProjParams={
				pos = { x, y+max+10, z}, 
				speed={0,math.random(1,3),0},
				["end"] = {gx,gy,gz},
				owner = attackerID,
				team = teamid,	
				spread={math.random(-5,5),math.random(-5,5),math.random(-5,5)},
				ttl=420,
				maxRange = 600,
				gravity = Game.gravity,
				startAlpha = 1,
				tracking =true,
				endAlpha = 1,						
				model = "emptyObjectIsEmpty.s3o",
				cegTag = "cchainlightning"
			}
			
			projectileID = Spring.SpawnProjectile( ChainLightningDefID ,ChaingProjParams) 
			
			
			
		elseif ChainLightningTable[attackerID] and ChainLightningTable[attackerID] <= 0 then 
			ChainLightningTable[attackerID] = nil
		end
		
		
		if UnitDamageFuncT[weaponDefID]	then	
		resultDamage=	UnitDamageFuncT[weaponDefID](unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam) 
		if resultDamage then return resultDamage end
		end
		
		--cBonkerPlasmaWeapon + FireWeapons
		if FireWeapons[weaponDefID] and unitDefID ~= cssDefID then
			if GG.OnFire == nil then GG.OnFire={} end
			--	Spring.Echo("jw_projectileimpacts: Fire WeaponfDetected")
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
		
		--skySraper is damagedCase
		if skySraperDefID== unitDefID then
			env = Spring.UnitScript.GetScriptEnv(unitID)
			if env then
				Spring.UnitScript.CallAsUnit(unitID, env.nothingEverHappend, attackerTeam )		
			end			
		end
		--jShadow is hit	
		if unitDefID == jShadowDefID and not fuckingSpecial[attackerDefID] and  attackerTeam ~= unitTeam and type(attackerID)== "number" then	
			
			boolUnitIsDead=Spring.GetUnitIsDead(attackerID)
			if boolUnitIsDead == false then		
				
				--now we displace it and set its speed to zero#
				ghostShadowEffectedUnits[attackerID]=

				
				offx,offz=math.random(-25,25),math.random(-25,25)
				px,py,pz=Spring.GetUnitPosition(attackerID)
				Spring.SetUnitMoveGoal(attackerID, px +offx, py, pz +offz)

				rotateUnitAroundUnit(unitID,attackerID, 180)

				setSpeedEnv(attackerID,0.05)	

				action= function(evtID, frame, persPack)
					if frame >= persPack.startFrame  then
						if Spring.GetUnitIsDead(persPack.unitID)==false then
							setSpeedEnv(persPack.unitID,1)	
						end
						return nil, persPack
					else
						return persPack.startFrame,persPack
					end
				end
				
				persPack={unitID= attackerID, startFrame=Spring.GetGameFrame()+ GHOSTLIFETIME}
				
				GG.EventStream:CreateEvent(action,
											persPack,
											Spring.GetGameFrame()+1
											)
				
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

		end	
	end
	
	function setSpeedEnv(k, val)
		env=Spring.UnitScript.GetScriptEnv(k)
		
		if env then
			udef=Spring.GetUnitDefID(k)	
			Spring.UnitScript.CallAsUnit(k, Spring.UnitScript.SetUnitValue, COB.MAX_SPEED, math.ceil(UnitDefs[udef].speed*val* 2184.53))		
		end
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
	
	function blowItUp(unitID,piece,vectordamage)
		stillAlive= Spring.ValidUnitID(unitID)
		if stillAlive and stillAlive == true then
			--explosion
			ux,uy,uz=Spring.GetUnitPosition(unitID,true)
			if ux then
				_,_,_,x,y,z=Spring.GetUnitPiecePosDir(unitID,piece)
				Spring.SpawnCEG("chiexploammo",x+math.random(-5,5),y+10,z+math.random(-5,5),0,1,0,50)
				Spring.PlaySoundFile("sounds/cweapons/HiEx.ogg",1)
				--directionalShove
				v={}
				r={}
				v.x,v.y,v.z=x-ux,y-uy,z-uz
				v=normVector(v)
				v=vMul(v, 900) --power
				
				-- crossproduct = (vectordamage x v ) -> Transfer to local coordsystem hitpiece origin vector 
				r.x,r.y,r.z= 0,math.rad(math.random(-5,5)),0
				Spring.SetUnitRotation(unitID,r.x,r.y,r.z)
				Spring.AddUnitImpulse(unitID,v.x,v.y,v.z) 
				
				T=getAllInCircle(ux,uz,120,unitID)
				--SplashDamage
				foreach(
				T, 
				function (id) if math.random(0,1)==1 then Spring.AddUnitDamage(id,75) end end) 
				Spring.AddUnitDamage(unitID,10)
				
			else
				return false
			end
			return true 
		end
	end
	
	
end