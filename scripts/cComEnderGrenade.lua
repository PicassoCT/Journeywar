

function script.AimFromWeapon1() 
	return glaunch 
end




function script.QueryWeapon1() 
return glaunch

end


function script.AimWeapon1( heading ,pitch)	
Signal(SIG_AIM)
	SetSignalMask(SIG_AIM)
	canFire=false
	if Weapons[3][1]==1 then  canFire= true end
	
	
	
	
		Turn(glaunch, y_axis, heading, 3)
		Turn(glaunch, x_axis, -pitch, 3)
		WaitForTurn(glaunch,y_axis)
		WaitForTurn(glaunch,x_axis)	
		
	
		--return canFire
		return canFire
end




function script.FireWeapon1()	
secondShot=secondShot+1
if secondShot==2 then
 StartThread(loader)
 secondShot=0
 end
	Move(gGrenade,z_axis,55,175)
	WaitForMove(gGrenade,z_axis)
	Hide(gGrenade)
	Move(gGrenade,z_axis,-5,0)
	Show(gGrenade)
	Move(gGrenade,z_axis,0,0.75)
	WaitForMove(gGrenade,z_axis)

	return true
end
----------------


function script.AimFromWeapon2() 
	return glaunch 
end




function script.QueryWeapon2() 
return glaunch

end


function script.AimWeapon2( heading ,pitch)	
Signal(SIG_AIM)
	SetSignalMask(SIG_AIM)
	canFire=false
	if Weapons[3][1]==2 then  canFire= true end
	
	
	
	
		Turn(glaunch, y_axis, heading, 3)
		Turn(glaunch, x_axis, -pitch, 3)
		WaitForTurn(glaunch,y_axis)
		WaitForTurn(glaunch,x_axis)	
		
	
		--return canFire
		return canFire
end




function script.FireWeapon2()	
secondShot=secondShot+1
if secondShot==2 then
 StartThread(loader)
 secondShot=0
 end
	Move(gGrenade,z_axis,55,175)
	WaitForMove(gGrenade,z_axis)
	Hide(gGrenade)
	Move(gGrenade,z_axis,-5,0)
	Show(gGrenade)
	Move(gGrenade,z_axis,0,0.75)
	WaitForMove(gGrenade,z_axis)

	return true
end
----------------
function script.AimFromWeapon3() 
	return glaunch 
end




function script.QueryWeapon3() 
return glaunch

end


function script.AimWeapon3( heading ,pitch)	
Signal(SIG_AIM)
	SetSignalMask(SIG_AIM)
	canFire=false
	if Weapons[3][1]==3 then  canFire= true end
	
	
	
	
		Turn(glaunch, y_axis, heading, 3)
		Turn(glaunch, x_axis, -pitch, 3)
		WaitForTurn(glaunch,y_axis)
		WaitForTurn(glaunch,x_axis)	
		
	
		--return canFire
		return canFire
end

gr3loadervar=1
row=1
function loader()
	if loadervar=1 then
	Move(gr1,y_axis,-3.6,5)
	Move(gr1,z_axis,-3.3,4.6)
	WaitForMove(gr1,y_axis)
	WaitForMove(gr1,z_axis)
	Hide(gr1)
	loadervar=loadervar+1
		elseif
		Move(gr1,y_axis,-3.6*gr3loadervar,5)
		Move(gr1,z_axis,-3.3*gr3loadervar,4.6)
		WaitForMove(gr1,y_axis)
		WaitForMove(gr1,x_axis)
		Hide(gr2)
		loadervar=loadervar+1
			elseif
			Move(gr1,y_axis,-3.6*gr3loadervar,5)
			Move(gr1,z_axis,-3.3*gr3loadervar,4.6)
			WaitForMove(gr1,y_axis)
			WaitForMove(gr1,x_axis)
			Hide(gr3)
			loadervar=loadervar+1

				else
				Move(gr1,y_axis,-3.6*gr3loadervar,5)
				Move(gr1,z_axis,-3.3*gr3loadervar,4.6)
				WaitForMove(gr1,y_axis)
				WaitForMove(gr1,x_axis)
				Hide(gr4)
				loadervar=0
					if row==1 then
					row=2
					Explode(mag1,SFX.FALL+SFX.NO_HEATCLOUD)
					Hide(mag1)
					Move(mag2,x_axis,-3.7,1.2)
					WaitForMove(mag2,x_axis)
					Move(gr1,x_axis,0,0)
					Move(gr1,z_axis,0,0)
					Hide(mag2)
					Show(mag1)
					Show(gr1)
					Show(gr2)
					Show(gr3)
					Show(gr4)
						elseif row == 2 then
						row=3
						Explode(mag2,SFX.FALL+SFX.NO_HEATCLOUD)
						Hide(mag1)
						Move(mag2,x_axis,-7.4,1.2)
						WaitForMove(mag2,x_axis)
						Move(gr1,x_axis,0,0)
						Move(gr1,z_axis,0,0)
						Hide(mag3)
						Show(mag1)
						Show(gr1)
						Show(gr2)
						Show(gr3)
						Show(gr4)
							else
							Move(mag2,x_axis,0,0)
							Move(gr1,x_axis,0,0)
							Move(gr1,z_axis,0,0)
							Show(mag2)
							Show(mag3)
							Show(mag1)
							Show(gr1)
							Show(gr2)
							Show(gr3)
							Show(gr4)
							row=1
							end



				end


end

secondShot=1
function script.FireWeapon3()	
secondShot=secondShot+1
if secondShot==2 then
 StartThread(loader)
 secondShot=0
 end
	Move(gGrenade,z_axis,55,175)
	WaitForMove(gGrenade,z_axis)
	Hide(gGrenade)
	Move(gGrenade,z_axis,-5,0)
	Show(gGrenade)
	Move(gGrenade,z_axis,0,0.75)
	WaitForMove(gGrenade,z_axis)

	return true
end