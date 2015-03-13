

function script.HitByWeapon ( x, z, weaponDefID, damage ) 
end

function DelayedSelfKill()
Spring.MoveCtrl.Enable(unitID,true)
Spring.SetUnitAlwaysVisible(unitID,false)
Sleep(2000)
Spring.DestroyUnit(unitID,true,true)


end
function script.Create()
StartThread(DelayedSelfKill)
end

function script.Killed(recentDamage,_)

return 1
end

 
function script.StartMoving()

end

function script.StopMoving()
		
		
end

function script.Activate()

return 1
end

function script.Deactivate()

return 0
end
