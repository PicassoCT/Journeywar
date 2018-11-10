include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"

include "lib_Build.lua"




SIG_MOVE = 2
function moveAnimation(speed)
	SetSignalMask(SIG_MOVE)
	signum = -1
	while (true) do
	Spring.Echo("Walk loop")
	signum= signum*-1
		for i=1,8 do
			outlier= math.random(20,35)

			if TableOfPieceGroups["Axis"][i] and TableOfPieceGroups["Pillar"][i+1] then
				equiTurn(TableOfPieceGroups["Axis"][i],TableOfPieceGroups["Pillar"][i+1],x_axis,outlier *signum,speed)
			end

			
			if TableOfPieceGroups["Axis"][i+1] and TableOfPieceGroups["Pillar"][i+2] then
				equiTurn(TableOfPieceGroups["Pillar"][i+2],TableOfPieceGroups["Axis"][i+1],x_axis,-outlier*signum,speed)
			end
		end
		-- process(TableOfPieceGroups["Axis"],
				-- function (piecename)
				-- turnPieceRandDir(piecename, 1)
				-- end)
		-- process(TableOfPieceGroups["Pillar"],
				-- function (piecename)
				-- turnPieceRandDir(piecename, 1)
				-- end)
		WaitForTurnT(TableOfPieceGroups["Pillar"])
		WaitForTurnT(TableOfPieceGroups["Axis"])
		resetT(TableOfPieceGroups["Pillar"],speed)
		resetT(TableOfPieceGroups["Axis"],speed)
		WaitForTurnT(TableOfPieceGroups["Pillar"])
		WaitForTurnT(TableOfPieceGroups["Axis"])
		Sleep(50)
	end
end

function script.StartMoving()
	StartThread(moveAnimation, 0.14)
end

function script.StopMoving()
	Signal(SIG_MOVE)
	resetT(TableOfPieceGroups["Pillar"],7)
	resetT(TableOfPieceGroups["Axis"],7)
end

TableOfPieceGroups = {}

function script.Create()
	TableOfPieceGroups = getPieceTableByNameGroups(false, true)
	
	
	--</buildanimationscript>
	--StartThread(checkCharged)
	StartThread(moveAnimation, 4)
	
end
function script.Activate()
	transformUnitInto(unitID, "efence" )	
    --Sleep(50)
    return 1
end

function script.Deactivate()
   
    return 0
end






--------------------------------------------------------------------------------
function script.Killed(recentDamage, maxHealth)
	
	
	return 1
end