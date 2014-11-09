function gadget:GetInfo()
        return {
                name                    = "RocketSience with projectiles",
                desc                    = "SetProjectileTarget etc",
                author          		= "knorke",
                date                    = "Mar 2014",
                license  				= "later horses dont be mean.",
                layer            		= 0,
                enabled  = true, --      loaded by default?
        }
end

if (not gadgetHandler:IsSyncedCode()) then return end

local wiggleWeapon = {}
wiggleWeapon[WeaponDefNames["staburstrocket"].id] = true

local redirectProjectiles = {}  -- [frame][projectileID] = table with .targetType .targetX .targetY .targetZ .targetID

function gadget:Initialize()
	Script.SetWatchWeapon (WeaponDefNames["staburstrocket"].id, true)
end

 
 function gadget:GameFrame (frame)
	--if frame%60==0 then Spring.Echo ("projectile_test.lua"..frame) end

	if redirectProjectiles[frame] then
		for projectileID,_ in pairs (redirectProjectiles[frame]) do
			if (Spring.GetProjectileType (projectileID)) then
				setTargetTable (projectileID, redirectProjectiles[frame][projectileID])
				Spring.SetProjectileCEG (projectileID, "custom:tpmuzzleflash_jeep")				
			end
		end
	redirectProjectiles[frame] = nil
	end
end
 



 function gadget:ProjectileCreated(proID, proOwnerID)
	if (wiggleWeapon [Spring.GetProjectileDefID (proID)]) then
		local originalTarget = getTargetTable (proID)
		local tx,ty,tz = getProjectileTargetXYZ (proID)
		local x,y,z = Spring.GetUnitPosition (proOwnerID)
		
		--Spring.SetProjectileCEG (proID, "custom:tpfiretrail")
		--local randomSpray = makeTargetTable (x+math.random(-200,200), y+100, z+math.random(-200,200))
		--addProjectileRedirect (proID, randomSpray, 30)
		--addProjectileRedirect (proID, makeTargetTable(tx,Spring.GetGroundHeight (tx,tz)+100,tz), 10)
		--addProjectileRedirect (proID, originalTarget, 45)
		--addProjectileRedirect (proID, makeTargetTable(tx+math.random(-500,500),ty,tz+math.random(-500,500)), 30)
		
		--addProjectileRedirect (proID, makeTargetTable(tx+math.random(-500,500),ty+400,tz+math.random(-500,500)), 10)
		--addProjectileRedirect (proID, makeTargetTable(tx+math.random(-500,500),ty,tz+math.random(-500,500)), 20)
		--addProjectileRedirect (proID, makeTargetTable(tx+math.random(-500,500),ty+400,tz+math.random(-500,500)), 30)
		--addProjectileRedirect (proID, makeTargetTable(tx+math.random(-500,500),ty,tz+math.random(-500,500)), 40)
		--addProjectileRedirect (proID, makeTargetTable(tx+math.random(-500,500),ty+2000,tz+math.random(-500,500)), 50)		
		--addProjectileRedirect (proID, originalTarget, 80)
		
		-- fly  away into all directions
		offsetx,offsety,offsetz=math.random(-150,150),math.random(0,75),math.random(-150,150)
			addProjectileRedirect (proID, makeTargetTable(x+offsetx,y+offsety,z+offsetz), 0)
		midx,midy,midz=(x+tx)/2+offsetx*0.25,(y+ty)/2+(offsety*0.5),(z+tz)/2+offsetz*0.25
			addProjectileRedirect (proID, makeTargetTable(midx,midy,midz),15 )
		--addProjectileRedirect (proID, makeTargetTable(x,y,z), 60)
		--addProjectileRedirect (proID, makeTargetTable(x-500,y+500,z),90 )
		--addProjectileRedirect (proID, makeTargetTable(x+500,y,z), 120)
		addProjectileRedirect (proID, originalTarget, 25)		
		return true
	end
end


function getProjectileTargetXYZ (proID)
	local targetTypeInt, target  = Spring.GetProjectileTarget (proID)
		if targetTypeInt == string.byte('g') then
			return target[1],target[2],target[3]
		end
		if targetTypeInt == string.byte('u') then
			return Spring.GetUnitPosition (target)
		end
		if targetTypeInt == string.byte('f') then
			return Spring.GetFeaturePosition (target)
		end
		if targetTypeInt == string.byte('p') then
			return Spring.GetProjectilePosition (target)
		end
end

function addProjectileRedirect (proID, targetTable, delay)
	local f = Spring.GetGameFrame() + delay
	if not redirectProjectiles[f] then redirectProjectiles[f] = {} end
	redirectProjectiles[f][proID] = targetTable
end

function makeTargetTable (x,y,z)
	return {targetType = string.byte('g'), targetX=x,targetY=y,targetZ=z}
end

function getTargetTable (proID)
	local targetTable = {}
	local targetTypeInt, target  = Spring.GetProjectileTarget (proID)
	if targetTypeInt == string.byte('g') then 	--target is position on ground
		targetTable = {targetType = targetTypeInt, targetX=target[1],targetY=target[2],targetZ=target[3],}	
	else 										--target is unit,feature or projectile
		targetTable = {targetType = targetTypeInt, targetID=target,}		
	end
	return targetTable
end

function setTargetTable (proID, targetTable)	
	if targetTable.targetType == string.byte('g') then
		Spring.SetProjectileTarget (proID, targetTable.targetX, targetTable.targetY, targetTable.targetZ)
	else
		Spring.SetProjectileTarget (proID, targetTable.targetID, targetTable.targetType)		
	end
end