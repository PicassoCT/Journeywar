

center=piece"center"

function script.Create()

end


function script.Killed()

end
	
	function actualTrample()
	Sleep(500)
		Turn(center,z_axis,math.rad(30),0.3)
	WaitForTurn(center,z_axis)
	Turn(center,z_axis,math.rad(60),1)
	WaitForTurn(center,z_axis)
	Turn(center,z_axis,math.rad(65),2.2)
	WaitForTurn(center,z_axis)
	Turn(center,z_axis,math.rad(89),6)
	Spring.DestroyUnit(unitID,false,true)
	end

	function TreeTrample()
		StartThread(actualTrample)
	end