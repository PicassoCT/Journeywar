	include "suddenDeath.lua"
	include "lib_OS.lua"
	include "lib_UnitScript.lua" 
 include "lib_Animation.lua"

	include "lib_jw.lua" 
	include "lib_Build.lua" 

	--include "spring_lua_dsl.lua"
	flats={}
	for i=1,21 do
	temp="flat"..i
	flats[i]=piece(temp)
	end
	center=piece"center"
	
	function script.Create()
	reseT(flats)
	dice=math.random(0,4)
	
	if dice==0 then
	val=math.random(-1,15)
	interVal=math.random(5,21)
	Turn(center,y_axis,math.rad(math.random(0,360)),0)
		for i=1,21 do
		deg=math.cos(i/interVal)*val
		Turn(flats[i],x_axis,math.rad(deg),0)
		end	
	elseif dice==4 then

		val=math.random(-1,15)
	interVal=math.random(5,21)
	Turn(center,y_axis,math.rad(math.random(0,360)),0)
		for i=1,21 do
		deg=math.cos(i/interVal)*val
		Turn(flats[i],x_axis,math.rad(deg),0)
		end	
		
	elseif dice==3 then	
		for i=1,21 do
		deg=math.cos(i/i^2)
		Turn(flats[i],z_axis,math.rad(deg),0)
		Move(flats[i],z_axis,math.random(-15,15),0)
		Move(flats[i],x_axis,math.random(-15,15),0)
		end	
	
	else
		for i=1,21 do
		deg=math.cos(i/i^2)
		Turn(flats[i],z_axis,math.rad(deg),0)
		Move(flats[i],z_axis,math.random(-15,15),0)
		Move(flats[i],x_axis,math.random(-15,15),0)
		end	
	end
	StartThread(deactivateAndReturnCosts,unitID,UnitDefs,0.25)
	end
	
	
	function script.Killed(recentDamage,_)

	return 1
	end


	function script.Activate()
		setDenial(unitID)
		return 1
	end

	function script.Deactivate()
		

		return 0
	end

