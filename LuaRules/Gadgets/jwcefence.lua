

function gadget:GetInfo()
  return {
    name      = "Making the Efence deadly",
    desc      = "",
    author    = "jK - always jk is there anyhting lua, that he didnt do long before you, making you look like a idiot in his fathers shoes. Oh, yeah, there it is, inferiority_complex.lua, author.. jk. of course. :(",
    date      = "Sep. 2008",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true,
  }
end



if (gadgetHandler:IsSyncedCode()) then



local	weapondefID1 = WeaponDefNames["cwefence1"].id
local	weapondefID2 = WeaponDefNames["lightningrocket"].id
	
	Script.SetWatchWeapon(weapondefID1 , true)
	Script.SetWatchWeapon(weapondefID2 , true)




local spSpawnCEG= Spring.SpawnCEG
local spGetUnitPiecePosDir=Spring.GetUnitPiecePosDir
local spGetUnitPieceMap=Spring.GetUnitPieceMap

  function gadget:UnitDamaged(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam) 
	if weaponDefID==weapondefID1 or weaponDefID == weapondefID2 then
	pieceMap=spGetUnitPieceMap(unitID)
		if pieceMap then
			for k,v in ipairs(pieceMap) do
			x,y,z=spGetUnitPiecePosDir(unitID,v)
				if x then 
				spSpawnCEG("factorysparks",x,y+17,z,0,1,0,50,0)
				end 
			end
		end
		Spring.DestroyUnit(unitID,false,false)
	end
   
  end

 
end