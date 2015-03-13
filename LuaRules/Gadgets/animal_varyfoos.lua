	VFS.Include("scripts/toolKit.lua")
	
	
	function BuildAvatara (units, allreadyExistingAvatara)
	
	x,y,z=Spring.GetUnitPosition(units[math.floor(math.random(1,#units))])
		if not allreadyExistingAvatara or Spring.ValidUnitID(allreadyExistingAvatara)==false then 
		teamid=Spring.GetUnitTeam(units[1])
		avataraID=Spring.CreateUnit("jvaryavatara",x,y,z,0,teamid) --TODO BECONTINUED)
		allreadyExistingAvatara=avataraID
		end

	tx,ty,tz=Spring.GetUnitPosition(allreadyExistingAvatara)
	
		for i=1,#units do
		Spring.SetUnitMoveGoal(units[i],tx+math.random(-50,50),ty,tz+math.random(-50,50))	
		end
	end	


	
	function handleVaryFoos(frame)
		if frame > 0 and frame % 300== 0 then
			for team,unittable in pairs (VariousFoos) do
				if #unittable > 50 then
				preExisting=VaryFooAvatara[team] or {}
				VaryFooAvatara[team]=BuildAvatara(unittable,preExisting)	
				end
			end
		end
	end
	
	
	