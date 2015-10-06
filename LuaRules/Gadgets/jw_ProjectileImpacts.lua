

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
	VFS.Include("scripts/lib_UnitScript.lua"      )
	VFS.Include("scripts/lib_Build.lua" 	)
	local WeaponDefTable={}
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
		  lazarusDeviceDefID = WeaponDefNames["lazarusrocket"].id
	local slicergunDefID = WeaponDefNames["slicergun"].id
	local jvaryfoospearDefID = WeaponDefNames["varyfoospear"].id
	local cCssFlameT=WeaponDefNames["cflamethrower"].id
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
	local greenSeerWeaponDefID= WeaponDefNames["greenseer"].id
	local celetrochainWeaponDefID= WeaponDefNames["celetrochain"].id
	local ChainLightningDefID=WeaponDefNames["cchainlightning"].id
	local CEaterRocketDefID=WeaponDefNames["ceater"].id
	local cHarvestRocketDefID=WeaponDefNames["charvest"].id
	local catapultDefID=WeaponDefNames["ccatapult"].id
	ChainLightningTable={}
	local FireWeapons={ [gVolcanoWeaponID]=true,
						[glavaWeaponID]=true, 	
						[bunkerPlasmaDefID]=true,  
						[cCssFlameT]=true,   
						[cFlareGun]=true
						}
	RazorGrenadeTable={}
	
	Script.SetWatchWeapon(catapultDefID , true)
	Script.SetWatchWeapon(cHarvestRocketDefID , true)
	Script.SetWatchWeapon(CEaterRocketDefID , true)
	Script.SetWatchWeapon(lazarusDeviceDefID , true)
	Script.SetWatchWeapon(ChainLightningDefID , true)
	Script.SetWatchWeapon(celetrochainWeaponDefID , true)
	Script.SetWatchWeapon(crazorgrenadeDefID , true)
	Script.SetWatchWeapon(jvaryjumpDefID , true)
	Script.SetWatchWeapon(striderWeaponDefID , true)
	Script.SetWatchWeapon(tiglilWeaponDefID , true)
	Script.SetWatchWeapon(slicergunDefID , true)
	Script.SetWatchWeapon(weaponDefIDjmotherofmercy , true)
	Script.SetWatchWeapon(cFlareGun , true)
	Script.SetWatchWeapon(cUniverseGun , true)
	Script.SetWatchWeapon(cRestrictorThumperID , true)
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

	
	
	function gadget:Explosion(weaponDefID, px, py, pz, AttackerID)
		
		if weaponDefID == lazarusDeviceDefID then
		teamid=Spring.GetUnitTeam(AttackerID)
		 GG.ComEnders[teamID]=Spring.CreateUnit(UnitDefNames["ccomender"].id,	px,py,pz, 1, teamid)
		end
			
		--we got to spawn some chain lightning
		if weaponDefID == celetrochainWeaponDefID then
		Spring.Echo("celetrochainWeaponDefID Explosion::jw_projectileimpacts"..AttackerID)
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
						
						projID = Spring.SpawnProjectile( ChainLightningDefID ,ChaingProjParams)
						
					
					end
			   	end
			else
			 for i=1, 3 ,1  do

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
							
						projID = Spring.SpawnProjectile( ChainLightningDefID ,ChaingProjParams)
					
						
			 end
			end
		
		end
		
		if weaponDefID == jgluegunDefID then
			id=Spring.CreateUnit("ggluemine",	 px, py, pz ,1, gaiaTeamID)
			Spring.SetUnitBlocking(id,false)
		end
	
	
		if weaponDefID ==crazorgrenadeDefID then
	
			if not RazorGrenadeTable[AttackerID] then RazorGrenadeTable[AttackerID] ={} end
		
			RazorGrenadeTable[AttackerID]=validateUnitTable(RazorGrenadeTable[AttackerID])
			
			
			teamID=Spring.GetUnitTeam(AttackerID)
			ad=0
			if #RazorGrenadeTable[AttackerID] > 5 then
			it=math.floor(math.random(1,5))
				Spring.DestroyUnit(	RazorGrenadeTable[AttackerID][it],true,true)
				RazorGrenadeTable[AttackerID][it]=Spring.CreateUnit("crazordrone",px,py,pz,1,teamID)	
				ad=RazorGrenadeTable[AttackerID][it] 
			else
				RazorGrenadeTable[AttackerID][#RazorGrenadeTable[AttackerID]+1]=Spring.CreateUnit("crazordrone",px,py,pz,1,teamID)	
				ad=RazorGrenadeTable[AttackerID][#RazorGrenadeTable[AttackerID]] 
			end	
			
			
			ed= Spring.GetUnitNearestEnemy(ad)
			if ed then 
				x,y,z=Spring.GetUnitPosition(ed)
				Spring.SetUnitMoveGoal(ad,x,y,z)
			end
		end
			
		if weaponDefID == jvaryjumpDefID then
			Spring.SetUnitPosition(AttackerID,px,py+80,pz)
			Spring.MoveCtrl.Enable(AttackerID,true)
			Spring.SetUnitAlwaysVisible(AttackerID,true)
			Spring.SetUnitBlocking (AttackerID,true,true,true)
		end
		
		if weaponDefID== jvaryfoospearDefID then
			--gluteus maximus- ha that sounds funny
				if not 	GG.ProjectileOrigin then	GG.ProjectileOrigin={} end	
			--wait a second thats my ass
			GG.ProjectileOrigin[AttackerID]={boolHitGround=true}
			Spring.SetUnitPosition(AttackerID,px,py,pz)	
		end
	
		if weaponDefID== striderWeaponDefID then
			teamid=Spring.GetUnitTeam(AttackerID)
			ShockWaveRippleOutwards(px,pz, 150, 180, 90)
		end
					
			--MTW Grenade
		if weaponDefID== cmtwgrenade and Spring.ValidUnitID(AttackerID) ==true then
			if Spring.GetUnitIsDead(AttackerID)==false then
				teamid=Spring.GetUnitTeam(AttackerID)
				Spring.CreateUnit("cmtwgrenade",px,py,pz,1,teamid)	
			else
				Spring.CreateUnit("cmtwgrenade",px,py,pz,1,gaiaTeamID)	
			end
		end
			
		if weaponDefID== cUniverseGun then
			tid=Spring.CreateUnit("cawilduniverseappears",px,py,pz, 1, gaiaTeamID)
			Spring.SetUnitAlwaysVisible(tid,true)
		end
		
				--jMotherofMercy
		if weaponDefID == weaponDefIDjmotherofmercy then
			
			env = Spring.UnitScript.GetScriptEnv(AttackerID)
			if env then
				Spring.UnitScript.CallAsUnit(AttackerID, env.ripARock, px,py,pz )		
			end
			
		end
		
			if (weaponDefID == jghostDancerWeaponDefID or weaponDefID== jSwiftSpearID or weaponDefID== jHiveHoundID) and Spring.ValidUnitID(AttackerID)==true then
			Spring.SetUnitPosition(AttackerID,px,py,pz)
			end
			
			--this one creates the headcrabs
			if (weaponDefID == crabWeaponDefID) then
				ShockWaveRippleOutwards(px,pz, 150, 180, 90)
			  Spring.CreateUnit("hc",px,py,pz, 1, gaiaTeamID)  
			end
			  
			  if weaponDefID== weapondefID3 then
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

	HarvestRocketLoadTable={}

	
 WeaponDefTable[catapultDefID]= function (unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam)

				health=Spring.GetUnitHealth(unitID)
				Spring.SetUnitHealth(unitID, {paralyze =health*15})
				Spring.SetUnitArmored(unitID,3)
				x,y,z=Spring.GetUnitPosition(unitID)
				Spring.SetUnitPosition(unitID,x,y+35,z)
				Spring.AddUnitImpuls(unitID,math.random(-1,1),math.random(150,300),math.random(-1,1))
			
 
end 

 WeaponDefTable[cHarvestRocketDefID]= function (unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam)

	 if HarvestRocketLoadTable[unitID] and HarvestRocketLoadTable[unitID][attackerID] then

			Spring.SetUnitResourcing(unitID, "umm",	 HarvestRocketLoadTable[unitID][attackerID].metal)
			Spring.SetUnitResourcing(unitID, "ume",	 HarvestRocketLoadTable[unitID][attackerID].energy)
		HarvestRocketLoadTable[unitID][attackerID]=nil
		
	
	 end
	return 0
end 
 WeaponDefTable[CEaterRocketDefID]= function (unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackID, attackerDefID, attackerTeam) 			
	
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
						--v=mulVector(v,-1)
					
						local	 HarvestRocketParams={
						pos = { gx, gy+max,gz},  
						["end"] = {tx,ty,tz},
						speed={v.x,v.y,v.z},
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
						
						projID = Spring.SpawnProjectile( cHarvestRocketDefID ,HarvestRocketParams)
		
		if projID then
				if not HarvestRocketLoadTable[attackerID] then HarvestRocketLoadTable[attackerID]={} end
			HarvestRocketLoadTable[attackerID][unitID]={metal=metalRes, energy=energyRes, vicID = projID }
		end

	end
				
WeaponDefTable[greenSeerWeaponDefID]= function (unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam) 			

		hitPoints=Spring.GetUnitHealth(unitID)
			if damage/hitPoints > 0.3 then 
				x,y,z=Spring.GetUnitPosition(unitID)
				Spring.DestroyUnit(unitID)
				Spring.CreateUnit("jtree",x,y,z,1,attackerTeam)
			end
		end
		
 WeaponDefTable[jvaryfoospearDefID]= function (unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam) 	
		--You Sir, have a living spear attached to your gluteus maximus
		--gluteus maximus- ha that sounds funny
			if not 	GG.ProjectileOrigin then	GG.ProjectileOrigin={} end	
		--wait a second thats my ass
		GG.ProjectileOrigin[attackerID]={boolHitGround=false,id=unitID,lastAttackedPiece=Spring.GetUnitLastAttackedPiece(unitID)}
		--AaaahaaAaaaaAaaaahahaAAAAaaaaaaah
		end
		
		--perma speed reduction
 WeaponDefTable[glueMineWeaponDefID]= function (unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam) 			
		GG.GluedForLife[unitID]=GG.GluedForLife[unitID]*0.9
		end
 WeaponDefTable[jgluegunDefID]= function (unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam) 			
		GG.GluedForLife[unitID]=GG.GluedForLife[unitID]*0.9
		end
		
 WeaponDefTable[highExLineGunDefID]= function (unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam) 		
	
			if 	blowUpTable[unitID] then blowUpTable[unitID].number= blowUpTable[unitID].number+1 
			else 	
			blowUpTable[unitID]={number=1, time=timeTillBlowUp, timeSinceBoom=0}	
			end	
		end
		
		--poisonedDart
 WeaponDefTable[tiglilWeaponDefID]= function (unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam) 			
	
		if not GG.Poisoned then GG.Poisoned={} end
		pval=120000 
		GG.Poisoned[unitID]=pval --time till poison wears off
		end
		
		
 WeaponDefTable[slicergunDefID]= function (unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam) 			
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
		
		
	
		--restrictor			

 WeaponDefTable[cRestrictorThumperID]= function (unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam) 		
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
	
function distanceOfUnitTo(ud,x,y,z)
	if not ud then return math.huge end

px,py,pz=Spring.GetUnitPosition(ud)
ux,uy,uz=px-x,py-y,pz-z
return math.sqrt(ux^2+uy^2 +uz^2),px,py,pz
end
	
			
	function gadget:UnitDamaged(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID,projID, attackerID, attackerDefID, attackerTeam) 

	
	--chain Lightning 
	if weaponDefID == ChainLightningDefID and attackerID then
		if not  ChainLightningTable[attackerID] then  ChainLightningTable[attackerID]=30 end
	
		
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
		
	projID = Spring.SpawnProjectile( ChainLightningDefID ,ChaingProjParams) 
		
				
		
	elseif ChainLightningTable[attackerID] and  ChainLightningTable[attackerID] <= 0 then 
		ChainLightningTable[attackerID] = nil
	end

	
	if WeaponDefTable[weaponDefID]	then	
		WeaponDefTable[weaponDefID](unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam) 
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
			v=normVector(v)
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
	