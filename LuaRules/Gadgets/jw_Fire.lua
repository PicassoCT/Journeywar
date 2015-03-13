
function gadget:GetInfo()
	return {
		name = "on Fire",
		desc = "Kills the infected ",
		author = "zwzsg",
		date = "3rd of May 2010",
		license = "Free",
		layer = 0,
		version = 1,
		enabled = true
	}
end

-- modified the script: only corpses with the customParam "featuredecaytime" will disappear

if (gadgetHandler:IsSyncedCode()) then
	local spSpawnCEG= Spring.SpawnCEG
	local spGetPosition=Spring.GetUnitPosition
	local spIsUnitDead=Spring.GetUnitIsDead
	local spAddUnitDamage=Spring.AddUnitDamage
	disDance=7
		VFS.Include('scripts/toolKit.lua', nil, VFSMODE)
local	isPanicAble=	getTypeTable(UnitDefNames,{"hc","bg","bg2","gcivillian","skinfantry","jconroach","tiglil","jbugcreeper","jcrabcreeper","jghostdancer","jhivehound"})
		function gadget:GameFrame(frame)
			
				if frame % disDance == 0 and GG.OnFire ~= nil  then
				
				local onFireUpInHere=GG.OnFire
				----Spring.Echo("Gfire:Test")
				--disDance=math.ceil(math.random(60,170))
								for i=1,table.getn(GG.OnFire),1 do
								--check if not nil
									if GG.OnFire[i]  ~=nil then 
										if GG.OnFire[i][1]  then 
										 ----Spring.Echo("gFire: UnitToBurnFound")
											if GG.OnFire[i][2]>= 0 then 
											 GG.OnFire[i][2]= GG.OnFire[i][2]-disDance
											 
											if not  GG.OnFire[i].DontPanic then GG.OnFire[i].DontPanic= (isPanicAble[Spring.GetUnitDefID(GG.OnFire[i][1])]~=nil) end
													if spIsUnitDead(GG.OnFire[i][1])== false then 
													
													
													
													x,y,z=spGetPosition(GG.OnFire[i][1])
														if GG.OnFire[i].DontPanic ==true then
														Spring.SetUnitNoSelect(GG.OnFire[i][1],true)
														Spring.SetUnitMoveGoal(GG.OnFire[i][1],x+math.random(-20,20),y,z+math.random(-20,20))
														end
													additional=math.random(3,9)
													addx=math.random(0,4)
													addz=math.random(0,4)
													xd=math.random(-1,1)
													zd=math.random(-1,1)
													spSpawnCEG("flames",x+addx*xd,y+additional,z+addz*zd,0,1,0,50,0)
															if frame % 3 == 0 then
															spSpawnCEG("vortflames",x+addx*xd,y+additional,z+addz*zd,0,1,0,50,0)
															end
													spAddUnitDamage(GG.OnFire[i][1],1)
													end
											
											else
												Spring.SetUnitNoSelect(GG.OnFire[i][1],false)
												GG.OnFire[i][1]= nil 
											end
									
									
										end
									
									end
								end
				end
			--	if GG.OnFire ~= nil then	----Spring.Echo("Gfire..",table.getn(GG.OnFire)) end
			
			if frame % 5000 ==0 and GG.OnFire ~= nil then
			y=table.getn(GG.OnFire) 
			countTen=0
				for i=1,y,1 do
					if GG.OnFire[i]  ~= nil and GG.OnFire[i][1]  ~= nil and i~= 1 and y ~= 1 then
					table.remove(GG.OnFire,i)
					i=i-1
					y=y-1			
					countTen=countTen+1
					end
				if countTen == 10 then break end	
				end
			end
		end	
end
