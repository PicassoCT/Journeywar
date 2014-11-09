

function script.Create()
 Spring.DestroyUnit (unitID,true,false)
end

function script.Killed()
x,y,z=Spring.GetUnitPosition(unitID)
teamID=Spring.GetUnitTeam(unitID)
GG.UnitsToSpawn:PushCreateUnit("bbind",x,y,z, 0, teamID)  
end




