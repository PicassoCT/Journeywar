wood={}
for i=1,13,1 do
wood[i]=piece(("Wood"..i))
end

function script.Create()
	for i=1,#wood,1 do
	Hide(wood[i])
	rot=math.random(0,360)
	Turn(wood[i],y_axis,math.rad(rot),0)
	
	multiplicator=1
	if i>11 then multiplicator = 5 end
	val=math.random(-4,4)*multiplicator
	Turn(wood[i],x_axis,math.rad(val),0)
	val=math.random(-4,4)
	Turn(wood[i],z_axis,math.rad(val),0)
	end
Move(wood[1],y_axis,-120,0)

val=math.ceil(math.random(1,#wood))
Show(wood[val])
	if math.random(0,1)==1 then 
	val=math.ceil(math.random(1,#wood))
	Show(wood[val])
	end
Move(wood[1],y_axis,-10,	2.9)
end

function script.Killed(recentDamage,_)
return 1
end