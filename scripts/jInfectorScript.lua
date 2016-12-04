include "lib_OS.lua"
 include "lib_UnitScript.lua" 
include "lib_Animation.lua"

 include "lib_jw.lua"
 include "lib_Build.lua" 



	center=piece"center"


	
	
	RANGEOFINFLUENCA=900
function isFactory(typed)
T=getFactoryTypeTable(UnitDefNames,"IwantItAll")
return (T[typed] ~= nil and T[typed])
end

	function grabFactorys(previousFactorys)

	x,y,z=Spring.GetUnitPosition(unitID)
	proChoice={}
	proChoice=Spring.GetUnitsInCylinder(x,z,900)
	--proChoice if 
	table.remove(proChoice,unitID)
	
	if proChoice then
		for i=1,#proChoice,1 do
		dype=Spring.GetUnitDefID(proChoice[i])
			if UnitDefs[dype].isBuilding ==true and isFactory(dype)==true then
			previousFactorys[proChoice[i]]=true
			end
		end
	return previousFactorys
	end
	

return  previousFactorys
end

function GetUnitsInTheMaking(FactoryTable,UnitsQuestioned)
	T={}
	for i=1,#FactoryTable,1 do
		buildID=Spring.GetUnitIsBuilding(FactoryTable[i])
		if UnitsQuestioned[buildID]== nil then table.insert(T,buildID) end
	end
	return T
end

	boolFullGrown=0
	function delayedAppearance()
	Move(center,y_axis,375,1)
	while true do
										--should be fullgrown by then..
	boolFullGrown=math.min(boolFullGrown+0.0002666666666666666,100)
	Sleep(1000)
	end
	
	end
	
	function DiceRoll()
	dice=math.random(0,100)
	return dice < boolFullGrown
	end
	
	
	function isUnitAGangsta(BigAndBlack)
	sirMayISeeYourIdPlease=nil
	sirMayISeeYourIdPlease=Spring.GetUnitDefID(BigAndBlack)		

		if sirMayISeeYourIdPlease== nil then --your coming with me
		return false
			else
				if sirMayISeeYourIdPlease== UnitDefNames["cdistrictnone"].id or sirMayISeeYourIdPlease == UnitDefNames["scumslum"].id then
				return true -- dat guy is a gansta
					else
					return false -- not a gangsta after all, just jaywalkin hillbilly
					end
			end
	end
	
	function Loop()
	teamID=Spring.GetUnitTeam(unitID)
	
	FactoryTable={}
	UnitsQuestioned={}
	while true do
	--updateFactorys
	FactoryTable=grabFactorys(FactoryTable)
	--GetTheUnitsTheyAreCurrentlyBuilding
	NewUnitsToRollTheDice=GetUnitsInTheMaking(FactoryTable,UnitsQuestioned)
	if NewUnitsToRollTheDice then
		for i=1, #NewUnitsToRollTheDice, 1 do
			UnitsQuestioned[NewUnitsToRollTheDice[i]]=DiceRoll()
			if UnitsQuestioned[NewUnitsToRollTheDice[i]]==true then
				if GG.Traitors== nil then GG.Traitors={} end
			TurnHimToTheDorkSide=Spring.CreateUnit("jtyrion",0,0,0, 0, teamID)  
			GG.Traitors[TurnHimToTheDorkSide]=NewUnitsToRollTheDice[i]
			end
		end
	end
	Sleep(400)
	end
	end

		function script.Create()
		StartThread(Loop)
		StartThread(delayedAppearance)
		end

		function script.Killed()
			
		return 0
		end



			