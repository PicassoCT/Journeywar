	

	function killYourself()
	Sleep(5*120000)
	Spring.DestroyUnit(unitID,true,true)
	
	end

	function script.Create()
	Spring.SetUnitNeutral(unitID,true)
	Spring.SetUnitNoSelect(unitID,true)
	Spring.SetUnitNoDraw(unitID,true)
	Spring.SetUnitNoMinimap(unitID,true)
	Spring.SetUnitBlocking (unitID,false,false,false)
	StartThread(killYourself)
	end
	
	
	function script.Killed()
	
	
	end