
include "lib_UnitScript.lua" 
include "lib_Animation.lua"
include "createCorpse.lua" 
include "lib_jw.lua" 
OilMatrix={}
Oildrum={}

function script.HitByWeapon(damage)


	StartThread(timer)
	return damage
end
range= 1
boolOnce=false
function timer()
if boolOnce==true then return end
boolOnce=true
	x,y,z=Spring.GetUnitPosition(unitID)

for i=1,10 do
	Spring.SpawnCEG("cssfirejet",x,y+math.random(0,10),z,0,1,0, 0,0)	
	Sleep(500)
end
Spring.DestroyUnit(unitID,true,false)	
end

function script.Create()
	for x=-1,1 do
	OilMatrix[x]={}
		for y=-1,1 do
		OilMatrix[x][y]={}

			for z=0,1 do
			OilMatrix[x][y][z]=false
			end
		end
	end
		OilMatrix[0][0][0]=true
	for i=1,5,1 do
		name="Oildrum"..i
		Oildrum[i]=piece(name)
	end
	
	for i=2,5 do
		if maRa()==true then
			Show(Oildrum[i])
			
			boolPlaced=false
			fiveAttempts=0
				while boolPlaced== false and fiveAttempts < 5 do
				fiveAttempts= fiveAttempts+1
				x,y,z= math.ceil(math.random(-1,1)),math.ceil(math.random(-1,1)),math.ceil(math.random(0,1))
					if z== 0 and OilMatrix[x][y][z]== false then
						OilMatrix[x][y][z]= true
						Move(Oildrum[i],x_axis, x*math.random(7,7.5),0)
						Move(Oildrum[i],z_axis, y*math.random(7,7.5),0)
						Move(Oildrum[i],y_axis, z*12,0)
						Turn(Oildrum[i],y_axis,math.rad(math.random(0,360)),0)
						range=range+1
						boolPlaced=true
					elseif OilMatrix[x][y][z]== false and  OilMatrix[x][y][z-1]== true then
						OilMatrix[x][y][z]= true
						Move(Oildrum[i],x_axis, x*math.random(7,7.5),0)
						Move(Oildrum[i],z_axis, y*math.random(7,7.5),0)
						Turn(Oildrum[i],y_axis,math.rad(math.random(0,360)),0)
						Move(Oildrum[i],y_axis, z*12,0)
						range=range+1
						boolPlaced=true
					end
				end
			else
			Hide(Oildrum[i])
		end
	end

end

function setUnitOnFire(id)
if GG.OnFire == nil then GG.OnFire={} end
			--	Spring.Echo("jw_projectileimpacts: Fire WeaponfDetected")
			boolInsertIt=true
			--very bad sollution n-times
			for i=1, table.getn(GG.OnFire), 1 do
				if 	GG.OnFire[i][1]	~= nil and	GG.OnFire[i][1]	== id then
					GG.OnFire[i][2]=math.ceil(math.random(190,1500)) 
					boolInsertIt=false
				end
			end
			
			if boolInsertIt==true then
				----Spring.Echo("jw_projectileimpacts:InsertIt")
				GG.OnFire[#GG.OnFire+1]={}
				GG.OnFire[#GG.OnFire][1]={}
				GG.OnFire[#GG.OnFire][1]=id
				GG.OnFire[#GG.OnFire][2]={}
				GG.OnFire[#GG.OnFire][2]=math.ceil(math.random(3000,12000)) 
			end
return id

end

center = piece"center"
function script.Killed()
	x,y,z=Spring.GetUnitPosition(unitID)
	Explode (Oildrum[1], SFX.FIRE + SFX.FALL)
	EmitSfx(center,1025)	
	EmitSfx(center,1026)	
		for i=1,32 do
			xc,yc,zc=math.random(-1,1),math.random(0.1,0.2),math.random(-1,1)
			norm=math.sqrt(xc^2+yc^2+zc^2)
			xc,yc,zc=xc/norm ,yc/norm ,zc/norm
			Spring.SpawnCEG("firefive",x,y+10,z,xc,yc,zc, 50,0)	
		end
		Sleep(100)
	
		for i=1,10 do

			EmitSfx(center,1024)	
			Sleep(50)
		end
	EmitSfx(center,1025)	
	
		if math.random(0,1)==1 then
			if not GG.AddFire then 
				GG.AddFire={} 
			end
			
		GG.AddFire[#GG.AddFire+1]=	{	x=x, 
										y=y, 
										z=z
									}
		end
	pyroProofTable=getPyroProofTable(UnitDefNames)

	T= getAllInCircle(x,z,range*33,unitID)
	process(	T,
				function (id) if not pyroProofTable[Spring.GetUnitDefID(id)] then return id end end,
				setUnitOnFire
			)
			
	if T and #T> 0 then
	
		for i=1,table.getn(T) do
		id=T[i]
		
		end
	end
	
	index=math.ceil(math.random(1,3))
	StartThread(PlaySoundByUnitDefID,Spring.GetUnitDefID(unitID), "sounds/goildrum/oilexplo"..index..".ogg",1, 5000, 1)
	
	
	

	return 1
end

unitDefID=Spring.GetUnitDefID(unitID)





