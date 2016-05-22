	---[[
	-- TODO: fix parting Code for 16 pieces -- also distribute maploading over same period --integrate mapparts created



	---- file: Land_Lord.lua
	-- brief: spawns start unit and sets storage levels
	-- author: Andrea Piras
	--
	-- Copyright (C) 2010,2011.
	-- Licensed under the terms of the GNU GPL, v2 or later.
	--
	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------

	function gadget:GetInfo()
		return {
			name = "LandLord ",
			desc = "Recives the terraFormInformation. applies the actuall terraforming, informs Units about the currentWaterLevelOffset",
			author = "PicassoCT",
			date = "7 b.Creation",
			license = "GNU GPL, v2 its goes in all fields",
			layer = 0,
			enabled = true -- loaded by default?
		}
	end

	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------

	-- synced only
	if (gadgetHandler:IsSyncedCode()) then
		GG.boolForceLandLordUpdate=false
		--------------------------------------------------------------------------------
		--------------------------------------------------------------------------------
		--TODO Function that allows the insertion of various terraindeformations
		
		
		
		
		--various Tools
		function isWithinCircle(squareSideDimension,circleRange,xCoord,zCoord)
			
			local LifeHalf=(squareSideDimension/2)
			
			local newCubic= 0.7071067811865475*(circleRange-LifeHalf)
			
			negCircleRange=(-1*circleRange)+ LifeHalf
			
			--checking the most comon cases |Coords Outside the Circlebox
			if xCoord > circleRange+LifeHalf or xCoord < negCircleRange then
				return false
			end
			
			if zCoord >circleRange+LifeHalf or zCoord <negCircleRange then
				return false
			end
			
			negNewCubic=-1* newCubic + LifeHalf
			
			
			--checking everything within the circle box
			if (xCoord < newCubic and xCoord > negNewCubic) and (zCoord < newCubic and zCoord > negNewCubic) then
				return true
			end
			
			
			-- very few cases make it here.. to the classic, bad old range compare
			distDance=math.sqrt((xCoord-LifeHalf)^2 +(zCoord-LifeHalf)^2)
			
			if distDance < circleRange-LifeHalf then 
				return true 
				
			else 
				return false
			end
			
		end
		
		--gets the sum of all values surrounding the center
		function getNine(valTab,i,j)
			comonVal=0
			for k=-1,1,1 do
				if valTab[i+k] and valTab[i+k][j-1] then comonVal=comonVal+ valTab[i+k][j-1] end
				if k~=0 and valTab[i+k] and valTab[i+k][j] then comonVal=comonVal+ valTab[i+k][j] end
				if valTab[i+k] and valTab[i+k][j+1] then comonVal=comonVal+ valTab[i+k][j+1] end
				return (valTab[i][j]+comonVal)/9	
			end
		end
		
		--Nevar forget to add a boundary Check- gruesome death awaits those who dare fate
		function getFilterFunction(FilterName)
			
			if FilterName== "none" then
				Spring.Echo("JW:FilterFunc:None")
				return function (boolinBounds,anyVal)
					assert(anyVal,"JW:FilterFunc:TableEmpty")
				return anyVal end 
			end
			
			if FilterName=="borderblur" then 
				Spring.Echo("JW:FilterFunc:borderblur")
				return function(boolinBounds,anyVal, rateOfBlur)	
					local lgetNine=getNine
					for rB=1,rateOfBlur, 1 do
						for i=1,#anyVal,1 do
							for j=1,#anyVal,1 do
								if anyVal[i][j]==0 then anyVal[i][j]= lgetNine(anyVal,i,j) end
							end
						end
					end
					return anyVal
				end end
				--default case	
				Spring.Echo("JW:FilterFunc:undefined")
				return function (boolinBounds,anyVal) return anyVal end
			end
			
			function getBlendFunction(BlendName)
				--blindly adds or subs the value
				if BlendName== "melt" then return function(anyTable) return anyTable end end	
				--adds subs the value to 
				if BlendName== "sub" or BlendName== "add" then 
					hub=true
					if BlendName=="sub" then hub=false end
					if hub == true then
						return 
						---------add--------------------------
						function (anyTable,vi,vj)
							
							
							h1=Spring.GetGroundHeight(vi*8,vj*8)
							h2=Spring.GetGroundHeight(vi*8+100,vj*8)
							h3=Spring.GetGroundHeight(vi*8-100,vj*8)
							h4=Spring.GetGroundHeight(vi*8,vj*8+100)
							h5=Spring.GetGroundHeight(vi*8,vj*8-100)
							h6=Spring.GetGroundHeight(vi*8-100,vj*8+100)
							h7=Spring.GetGroundHeight(vi*8-100,vj*8-100)
							h8=Spring.GetGroundHeight(vi*8+100,vj*8+100)
							h9=Spring.GetGroundHeight(vi*8+100,vj*8-100)
							local bcheck=boundCheck
							h=(h1+h2+h3+h4+h5+h6+h7+h8+h9)/9
							for i=1,#anyTable,1 do
								if bcheck("x",i) ==true then
									for j=1,#anyTable,1 do
										if bcheck("z",j) ==true then
											
											if orgTerrainMap[i][j] and orgTerrainMap[i][j] > h + anyTable[i][j] then 
												anyTable[i][j]=0
											else
												anyTable[i][j]= ((h + anyTable[i][j]) - orgTerrainMap[i][j] + (h-orgTerrainMap[i][j]))
											end
											
										end
									end
								end
							end
							--Spring.Echo("JW_LANDLORD:ADD-----------------------")
							--printOUT(anyTable)	
							return anyTable
						end 	
						-----------------------------------
					else
						return
						-------------sub----------------------
						function (anyTable,vi,vj)
							
							
							h1=Spring.GetGroundHeight(vi*8,vj*8)
							h2=Spring.GetGroundHeight(vi*8+100,vj*8)
							h3=Spring.GetGroundHeight(vi*8-100,vj*8)
							h4=Spring.GetGroundHeight(vi*8,vj*8+100)
							h5=Spring.GetGroundHeight(vi*8,vj*8-100)
							h6=Spring.GetGroundHeight(vi*8-100,vj*8+100)
							h7=Spring.GetGroundHeight(vi*8-100,vj*8-100)
							h8=Spring.GetGroundHeight(vi*8+100,vj*8+100)
							h9=Spring.GetGroundHeight(vi*8+100,vj*8-100)
							local bcheck=boundCheck
							h=(h1+h2+h3+h4+h5+h6+h7+h8+h9)/9
							for i=1,#anyTable,1 do
								if bcheck("x",i) ==true then
									for j=1,#anyTable,1 do
										if bcheck("z",j) ==true then			
											if orgTerrainMap[i][j] then
												if orgTerrainMap[i][j] < h + anyTable[i][j] then 
													anyTable[i][j]=0
												else
													
													anyTable[i][j]=(orgTerrainMap[i][j] - (h + anyTable[i][j]) - math.max(orgTerrainMap[i][j] - h,0))*-1
												end
											end
										end
									end
								end
							end
							--Spring.Echo("JW_LANDLORD:SUB-----------------------")
							--printOUT(anyTable)		
							return anyTable	
						end 
						-----------------------------------	
					end
					--defaults the save lifes
					return 
					-----------------------------------
					function(anyTable)
						return anyTable
					end 
					-----------------------------------
				end
			end
			
			--by Convention a dynamic Deformation Map is a Piece of HeightmapOffsets, pushed to 
			--GG.DynDefMap and it contains {x,z, Size, Table,blendType,filterType}
			--blendTypes
			--melt
			--subtotal
			--addtotal
			
			--filterTypes::
			
			MSX=Game.mapSizeX/8
			MSZ=Game.mapSizeZ/8
			function insertDynamicDeformationMaps()
				--Spring.Echo("JW::LandLord::insertDynamicDeformationMaps")
				if GG.DynDefMap == nil then GG.DynDefMap={} end
				if GG.DynRefMap == nil then GG.DynRefMap={} end
				
				--Spring.Echo("JW::LandLord::insertDynamicDeformationMaps::GG.DynDefMap".. table.getn(GG.DynDefMap))
				--Spring.Echo("JW::LandLord::insertDynamicDeformationMaps-1")
				
				
				for i=1,table.getn(GG.DynDefMap), 1 do
					--Spring.Echo(GG.DynDefMap[i])
					--printOUT(GG.DynRefMap[i])
					local x,z=math.ceil(GG.DynDefMap[i].x),math.ceil(GG.DynDefMap[i].z)
					halfSize= GG.DynDefMap[i].Size/2
					--<Blend&FilterFunc>
					blendType="melt"
					filterType="none"
					
					if GG.DynDefMap[i].blendType then
						blendType=GG.DynDefMap[i].blendType
					end
					
					filterFunction=getFilterFunction(filterType)
					assert(filterFunction,"JW_LANDLORD::WithinBOunds::filterFunctionInit")
					
					blendFunction=getBlendFunction(blendType)
					assert(blendFunction,"JW_LANDLORD::WithinBOunds::blendFunctionInit")
					if GG.DynDefMap[i].filterType then
						filterType=GG.DynDefMap[i].filterType		
					end
					
					--</Blend&FilterFunc>
					y=Spring.GetGroundHeight(x*8,z*8)
					
					--if the value is within bounds, we can avoid expensive nilChecking
					
					if x-halfSize > 0 and x+halfSize < MSX and z-halfSize > 0 and z+halfSize < MSZ then
						--	Spring.Echo("JW::LandLord::insertDynamicDeformationMaps-2")
						withinBounds(x,z,i,halfSize,blendFunction,filterFunction)
					else
						--Spring.Echo("JW::LandLord::insertDynamicDeformationMaps-3")
						debugVAL= withoutBounds(x,z,i,halfSize,blendFunction,filterFunction)
						if debugVAL and debugVAL==false then Spring.Echo("Error>LandLord>>insertDynamicDeformationMaps"..x.." | "..z.." | "..i) end
					end	
				end
				GG.DynDefMap={} 		
				GG.DynRefMap={} 		
			end
			
			function withinBounds(x,z,Nr,halfSize,blendFunction,filterFunction)
				--Spring.Echo("JW_LANDLORD:",filterFunction)
				--Spring.Echo("JW_LANDLORD:",blendFunction)
				startx,endx=x-halfSize,x+halfSize 
				startz,endz=z-halfSize,z+halfSize
				--assert(GG.DynRefMap[Nr],"JW:WhatTheHell"..Nr)
				tempTable=filterFunction(true,GG.DynRefMap[Nr])
				--assert(tempTable,"JW_LANDLORD::WithinBOunds::filterFunction")
				tempTable=blendFunction(tempTable,x,z)
				--assert(tempTable,"JW_LANDLORD::WithinBOunds::blendFunction")
				for o=startx,endx,1 do
					for i=startz,endz,1 do
						orgTerrainMap[o][i]=orgTerrainMap[o][i]+ tempTable[math.max(1,o-startx)][math.max(1,i-startz)]
					end
				end
			end
			
			function withoutBounds(x,z,Nr,halfSize,blendFunction,filterFunction)
				--Spring.Echo("JW_LANDLORD:",filterFunction)
				--Spring.Echo("JW_LANDLORD:",blendFunction)
				--	Spring.Echo("JW::LandLord::insertDynamicDeformationMaps"..Table)
				local bcheck= boundCheck
				startx,endx=x-halfSize,x+halfSize
				startz,endz=z-halfSize,z+halfSize
				--boundCheck
				tempTable=filterFunction(false,GG.DynRefMap[Nr])
				--	assert(tempTable,"JW_LANDLORD::WithinBOunds::filterFunction")
				tempTable=blendFunction(tempTable,x,z)
				--	assert(tempTable,"JW_LANDLORD::WithinBOunds::blendFunction")
				
				for o=startx,endx,1 do
					if bcheck("x",o) ==true then
						for i=startz,endz,1 do
							if bcheck("z",i)==true then
								--DEBUG
								if not orgTerrainMap[o][i] or not tempTable[math.max(1,o-startx)][math.max(1,i-startz)] then return false end
								
								orgTerrainMap[o][i]= orgTerrainMap[o][i]+ tempTable[math.max(1,o-startx)][math.max(1,i-startz)]
							end
						end
					end
				end
				
			end
			
			function boundCheck(T, val)
				if T== "z" then
					if val < 1 then
						return false 
					elseif val > MSZ then 
						return false 
					else 
						return true
					end 
				end
				
				if T== "x" then
				if val < 1 then return false elseif val > MSX then return false else return true end 
			end
		end	
		
		
		--function:returns the HeightGradientSample
		function divNonZero(value)
			if value == 0 then
				return 1
			else
				return value
			end
		end
		
		
		function getHeightGradient(inRange,outRange, xCoord, zCoord, StartHeight,EndHeight,squareSideDimension)
			halfLife=squareSideDimension/2
			totalRange=outRange-inRange
			
			--HeightDifferencePerElement=(EndHeight-StartHeight)/outRange-inRange
			--range=math.floor(math.sqrt((xCoord-halfLife)^2+ (zCoord-halfLife)^2))
			
			--nrOfChoice=math.floor(math.sqrt((xCoord-halfLife)^2+ (zCoord-halfLife)^2))-inRange
			--Spring.Echo("JWL__-----------------------------------------------------")
			--Spring.Echo("JWL__Range:",(math.ceil(math.sqrt((xCoord-halfLife)^2+ (zCoord-halfLife)^2))-inRange))
			--Spring.Echo("JWL_Results ",unNeg((math.ceil(math.sqrt((xCoord-halfLife)^2+ (zCoord-halfLife)^2))-inRange)*((EndHeight-StartHeight)/divNonZero(outRange-inRange)))+StartHeight)	
			--Spring.Echo("JWL__-----------------------------------------------------")
			return unNeg(((((math.ceil(math.sqrt((xCoord-halfLife)^2+ (zCoord-halfLife)^2))-(inRange-halfLife))*-1)+totalRange)*((EndHeight-StartHeight)/totalRange)))+ StartHeight
			
			
		end
		
		function modULater(val)
			if val <= 100 then
				return val 
			end
			
			if val > 100 then
				return val - (val%100)
			end
			
		end
		
		--creates the Future Terrainmap
		function createFutureMap(squareSideDimension)
			
			heightDifference=100
			sixFeetUnder=33
			fourTeenParts=(squareSideDimension/18)
			aPart=fourTeenParts*2
			local lisWithinCircle=isWithinCircle
			-----------------------------------------------
			terrainMap={}
			--create outerZone 7 with zero.. the original terrain goes here
			for x=1,squareSideDimension+1,1 do
				terrainMap[x]={}
				for z=1,squareSideDimension+1,1 do
					terrainMap[x][z]={}
					terrainMap[x][z]=0
				end	
			end
			--ToDOHERE
			local lgetHeightGradient=getHeightGradient
			
			--create the first inner zone, heightgradient 6
			for x=1,squareSideDimension+1,1 do
				for z=1,squareSideDimension+1,1 do
					if lisWithinCircle(squareSideDimension,squareSideDimension,x,z)==true and lisWithinCircle(squareSideDimension,squareSideDimension-fourTeenParts,x,z)==false then 
						--(inRange,outRange, xCoord, zCoord, StartHeight,EndHeight,squareSideDimension)
						--getHeightGradient( inRange ,outRange ,xCoord, zCoord, StartHeight,EndHeight,squareSideDimension)
						terrainMap[x][z]=lgetHeightGradient(squareSideDimension-fourTeenParts,squareSideDimension,x,z,0,sixFeetUnder,squareSideDimension)
					end	
				end	
			end
			--create the first inner zone, heightgradient 5
			--assert(terrainMap)
			----Spring.Echo("JWL_--create the first inner zone, heightgradient 6",terrainMap[35][35])
			for x=1,squareSideDimension+1,1 do
				for z=1,squareSideDimension+1,1 do
					if lisWithinCircle(squareSideDimension,squareSideDimension-fourTeenParts,x,z)==true and lisWithinCircle(squareSideDimension,squareSideDimension-(fourTeenParts+aPart),x,z)==false then 
						terrainMap[x][z]=33
					end	
				end	
			end
			
			--create the first inner zone, heightgradient 4
			for x=1,squareSideDimension+1,1 do
				
				for z=1,squareSideDimension+1,1 do
					if lisWithinCircle(squareSideDimension,squareSideDimension-(fourTeenParts+aPart),x,z)==true and lisWithinCircle(squareSideDimension,squareSideDimension-(2*aPart),x,z)==false then 
						
						terrainMap[x][z]=lgetHeightGradient(squareSideDimension-(2*aPart),squareSideDimension-(fourTeenParts+aPart),x,z,sixFeetUnder,sixFeetUnder*2,squareSideDimension)
					end	
				end	
			end
			
			--create the first inner zone, heightgradient 3
			
			for x=1,squareSideDimension,1 do
				for z=1,squareSideDimension,1 do
					if lisWithinCircle(squareSideDimension,squareSideDimension-(2*aPart),x,z)==true and lisWithinCircle(squareSideDimension,squareSideDimension-(4*aPart),x,z)==false then 
						
						terrainMap[x][z]=66
					end	
				end	
			end
			
			--create the first inner zone, heightgradient 2
			for x=1,squareSideDimension+1,1 do
				for z=1,squareSideDimension+1,1 do
					--	if lisWithinCircle(squareSideDimension,squareSideDimension-(4*aPart),x,z)==true and lisWithinCircle(squareSideDimension,squareSideDimension-((4*aPart)+fourTeenParts),x,z)==false then 
					if lisWithinCircle(squareSideDimension,squareSideDimension-(3*aPart),x,z)==true and lisWithinCircle(squareSideDimension,squareSideDimension-((4*aPart)),x,z)==false then 
						
						terrainMap[x][z]= modULater(lgetHeightGradient(squareSideDimension-((3*aPart)+fourTeenParts),squareSideDimension-(3*aPart),x,z,2*sixFeetUnder,3*sixFeetUnder,squareSideDimension))
					end	
				end	
			end
			
			
			--center And done
			for x=1,squareSideDimension+1,1 do
				
				for z=1,squareSideDimension+1,1 do
					if lisWithinCircle(squareSideDimension,squareSideDimension-(4*aPart),x,z)==true then 
						
						terrainMap[x][z]=99
					end	
				end	
			end
			
			--printOUT(terrainMap,squareSideDimension)
			return terrainMap
		end
		
		
		
		function printOUT(tmap,squareSideDimension)
			map={}
			local map=tmap
			step=8
			if squareSideDimension~= nil and squareSideDimension <128 then step=1 end
			for x=2,#map,step do
				StringToConcat=""
				for z=2,#map,step do
					
					--Spring.Echo(map[x][z])
					
					if map[x][z] == nil then 
						StringToConcat=StringToConcat.." X "
					elseif map[x][z] == 0 then
						StringToConcat=StringToConcat.." 0 "
					elseif map[x][z] == false or map[x][z] == true then
						StringToConcat=StringToConcat.." € "
					else
						val=math.ceil(map[x][z])		
						if val < 10 and val >=0 then
							
							StringToConcat=StringToConcat.." "..val.." "
						elseif val >9 and val < 100 then
							StringToConcat=StringToConcat.." "..val
						elseif val > 99 then
							StringToConcat=StringToConcat..val
						end
					end		
					
					
				end	
				Spring.Echo(StringToConcat)
			end
			
		end
		
		
		--function validates Unit Table
		function validateUnitTable(tableToValidate)
			local spUnitIsDead=Spring.GetUnitIsDead
			x=table.getn(tableToValidate)
			for i=1,x,1 do
				
				if spUnitIsDead((tableToValidate[i][1])) == true then
					
					table.remove(tableToValidate,i)
					x=x-1
					if i~=1 then i=i-1 end
				end
			end
			return tableToValidate	
		end
		
		--------------------------------------------------------------------------------
		--------------------------------------------------------------------------------
		
		
		local gWaterOffSet=0 --global WaterOffset
		local UPDATE_FREQUNECY=4200
		local increaseRate=0.01 --reSetMe to 0.001
		--------------------------------------------------------------------------------
		--------------------------------------------------------------------------------
		boolFirst=true
		
		--Table contains all the WaterLevelChanging Units
		local WaterLevelChangingUnitsTable={}
		--Table contains all Units who perform Terraforming - and thus need to be informed of rising waterLevels
		local LandLordTable={}
		
		orgTerrainMap={}
		GroundDeformation={}
		futureMapSize=54
		
		
		GG.addWaterLevel = 0
		GG.subWaterLevel = 0
		if GG.Extrema== nil then
			GG.Extrema= {}
			min,max=Spring.GetGroundExtremes()
			GG.Extrema=max+math.abs(min)+math.ceil(math.random(10,100))
		end
		--function collects the stored changedate from the WaterLevelingUnits
		function getGlobalOffset()
			returnVal=(GG.addWaterLevel*-1) + GG.subWaterLevel
			GG.addWaterLevel=0
			GG.subWaterLevel=0
			return returnVal
		end
		
		function unNeg(val)
			if val< 0 then
				return val*-1
			else 
				return val
			end
		end
		
		
		extremataGlobal=1
		boolFirstBlood=true
		function updateMaxima()
			
			extremataDown,extremataUp=Spring.GetGroundExtremes()
			--assert(extremataDown)
			--assert(extremataUp)
			extremataDown=math.abs(extremataDown)
			
			if boolFirstBlood== true and (extremataDown ~= nil and extremataUp ~= nil) then
				boolFirstBlood=false
				
				extremataGlobal=math.max(extremataDown,extremataUp)
				
				
				
				GG.Extrema=extremataGlobal
				--delMe
			else
				
				
				--/delMe
			end
			
		end
		local jdrilltreeDef=UnitDefNames["jdrilltree"].id
		local mdiggmexDef=UnitDefNames["mdiggmex"].id
		function gadget:UnitDestroyed(Unit, UnitDef, Team)
			if UnitDef== jdrilltreeDef or UnitDef== mdiggmexDef then
				if UnitDef== jdrilltreeDef then
					for i=1,table.getn(LandLordTable),1 do
						if LandLordTable[i][1]==	Unit then
							table.remove(LandLordTable,i)
							break
						end
					end
				else
					x,y,z=Spring.GetUnitPosition(Unit)
					y=Spring.GetGroundHeight(x,z)
					if y < 0 then
						for i=1,table.getn(LandLordTable),1 do
							if LandLordTable[i][1]==	Unit then
								table.remove(LandLordTable,i)
								break
							end
						end
						
					end
					
					
				end
				
			end
			
			
			
		end
		
		--Every unit signs up, is checked for its UnitdefId beeing that of a WaterAdder or a WaterSubstractor
		local cwaterexttractorDefID=UnitDefNames["cwaterextractor"].id
		local jwatergateDefID = UnitDefNames["jwatergate"].id
		local jHarbourDefID = UnitDefNames["jharbour"].id
		
		function gadget:UnitCreated(unitID, unitDefID, unitTeam)
			
			if unitDefID==cwaterexttractorDefID or unitDefID ==jwatergateDefID or unitDefID==jHarbourDefID then
				--Spring.Echo("JWL_Registrated WaterUnit")
				hubTable={}
				hubTable[1]=unitID
				hubTable[2]=unitDefID
				hubTable[3]=unitTeam
				index=(table.getn(WaterLevelChangingUnitsTable))+1
				WaterLevelChangingUnitsTable[index]={}
				WaterLevelChangingUnitsTable[index]=hubTable
			end
			
			if unitDefID==UnitDefNames["mdiggmex"].id or unitDefID == UnitDefNames["jdrilltree"].id then
				--Spring.Echo("JWL_Registrated DigUnit")
				
				hubTable={}
				hubTable[1]=unitID
				hubTable[2]=unitDefID
				hubTable[3]=unitTeam
				
				--determinate start value
				x,y,z=Spring.GetUnitPosition(unitID)
				y=Spring.GetGroundHeight(x,z)
				hubTable[4]=unNeg(y) 			--the StartHeight Value
				hubTable[5]=0.001 --0.001				--scalar stores how much 
				hubTable[6]=math.ceil(x/8)
				hubTable[7]=math.ceil(z/8)
				
				index=(table.getn(LandLordTable))+1
				LandLordTable[index]={}
				LandLordTable[index]=hubTable
			end
			--Every Unit who changes the landscape has to recive its own function its not nice, not beautifull, but functional	
			
			
		end
		
		
		function caselessAmmonition(sizeMattersZ)
			--All the ugly cases
			
			
			--first out =1 
			
			local spGetGroundHeight=Spring.GetGroundHeight
			
			--second
			
			
			
			
			RetTable={}
			
			
			for i=1,sizeMattersZ,1 do
				--startCaseExtra
				if i==1 then 
					RetTable[i]={}
					RetTable[i]=spGetGroundHeight(2,i) 
				end
				RetTable[i+1]={}	
				RetTable[i+1]=spGetGroundHeight(16,i*8) 
				
				
			end
			
			
			return RetTable		
			
			
			
			
			
		end
		
		--Creates the original TerrainTable
		local MapSizeX=Game.mapSizeX/8
		local MapSizeZ=Game.mapSizeZ/8
		sizeMattersX=(Game.mapSizeX)/8
		sizeMattersZ=(Game.mapSizeZ)/8
		
		function forgeFirstTerrainMap() --rewritten
			
			local spGetGroundHeight=Spring.GetGroundHeight
			
			
			
			--Spring.Echo(Game.mapSizeX)
			--Spring.Echo(MapSizeX)
			--Spring.Echo(Game.mapSizeZ)
			--Spring.Echo(MapSizeZ)
			
			
			
			for out=1,sizeMattersX,1 do
				SubTable={}
				
				
				for i=1,sizeMattersZ,1 do
					--startCaseExtra
					if i~=1 and out ~= 1 then
						SubTable[i+1]=spGetGroundHeight(out*8,i*8)
					elseif i==1 and out ~= 1 then
						SubTable[1]=spGetGroundHeight(out*8,1)
						SubTable[2]=spGetGroundHeight(out*8,8)
					elseif out==1 and i~=1 then
						SubTable[i+1]=spGetGroundHeight(1,i*8)
					else	
						SubTable[i]=spGetGroundHeight(1,1)
					end
					
				end
				
				if out~=1 then
					orgTerrainMap[out+1]=SubTable
				else
					orgTerrainMap[1]=SubTable
					orgTerrainMap[2]=caselessAmmonition(sizeMattersZ)
				end
				
			end
			
			
			
			--Spring.Echo("JWL_------------LANDLORD--------------------------Printing Out orgTerrainMap")
			--	printOUT(orgTerrainMap)
		end
		
		
		
		
		
		function determinateTileNrZ(tileNr) --rewritten
			if tileNr >0 and tileNr < 9 then
				return 1
			elseif tileNr>8 and tileNr < 17 then
				return 2
			elseif tileNr > 16 and tileNr < 25 then
				return 3
			elseif tileNr > 24 and tileNr < 33 then
				return 4
			elseif tileNr > 32 and tileNr < 41 then
				return 5
			elseif tileNr > 40 and tileNr < 49 then
				return 6
			elseif tileNr > 48 and tileNr < 57 then
				return 7
			else
				return 8
			end
		end -- function round
		
		tileSizeX=(MapSizeX)/8
		tileSizeZ=(MapSizeZ)/8
		
		function throwTantrum(message, value)
			--Spring.Echo(message.."at: "..value)
		end
		
		MapSizeXDiv8=math.floor(MapSizeX)/8
		MapSizeZDiv8=math.floor(MapSizeZ)/8
		
		
		
		function clamp(Value,boolIsX) --rewritten
			
			--Spring.Echo("JWL_MapSizeXDiv8",MapSizeXDiv8)
			--Spring.Echo("JWL_MapSizeZDiv8",MapSizeZDiv8)
			if Value < 0 then return 1 	end
			
			if boolIsX==true then
				if Value <= MapSizeX then return Value
				else
					return MapSizeX
				end
			else
				if Value <= MapSizeZ then return Value
				else
					return MapSizeZ
				end
			end		
		end
		
		
		-- subTable[1]=unitID
		-- subTable[2]=unitDefID
		-- subTable[3]=unitTeam
		-- subTable[4]=unNeg(y) 			--the StartHeight Value
		-- subTable[5]=0.001 				--scalar stores how much 
		-- subTable[6]=x
		-- subTable[7]=z
		--This function adds the GroundDeformation Table at the position of the Unit into the 
		function TerraInFormTable()
			if LandLordTable~=nil and table.getn(LandLordTable)~= 0 then
				
				local ME={}
				
				local FMS=futureMapSize
				local incRate=increaseRate 
				local getGroundHeight=Spring.GetGroundHeight
				
				for i=1,#LandLordTable,1 do
					--increment the Percentage
					LandLordTable[i][5]= LandLordTable[i][5]+ incRate
					
					--determinate coordinates
					
					startx=LandLordTable[i][6]-FMS/2
					endx=startx+FMS
					startz=LandLordTable[i][7]-FMS/2
					endz=startz+FMS
					--Spring.Echo("JWL_startz",startz)
					--Spring.Echo("JWL_startx",startx)
					--Spring.Echo("JWL_Endz",endz)
					--Spring.Echo("JWL_Endx",endx)
					--clamp said coordinates
					oldstartx=startx
					startx=clamp(startx,true)
					offsetstartx=math.abs(startx-oldstartx) --the distance 
					
					--oldendx=endx
					endx=clamp(endx,true)
					
					--Spring.Echo("JWL_startz",startz)
					--Spring.Echo("JWL_startx",startx)
					--Spring.Echo("JWL_Endz",endz)
					--Spring.Echo("JWL_Endx",endx)
					--offsetendx=math.abs(oldendx-endx)
					
					oldstartz=startz
					startz=clamp(startz,false)
					offsetstartz=math.abs(startz-oldstartz)
					--oldendz=endz
					endz=clamp(endz,false)
					--offsetendz=math.abs(oldendz-endz)
					
					--Spring.Echo("JWL_------------LANDLORD--------------------------")
					--Spring.Echo(FMS)
					--Spring.Echo("JWL_JWLandLord_startx:",startx.." | endx",endx)
					--Spring.Echo("JWL_JWLandLord_startz:",startz.." | endz",endz)
					--Spring.Echo("JWL_JWLandLord_offsetstartx:",offsetstartx.." | offsetstartz",offsetstartz)
					
					--Spring.Echo("JWL_JWLandLord_TableDance",table.getn(GroundDeformation))
					--printOUT(GroundDeformation,56)
					
					
					--determinate
					upDown=1 
					
					if LandLordTable[i][2] == UnitDefNames["mdiggmex"].id then upDown = -1 	end
					--Spring.Echo("UpDown", upDown)
					--by UnitType 
					
					for z=startz,endz, 1 do
						for x=startx,endx, 1 do
							--going Up or Down | GroundDeformation/100 *Maxima |
							--	value1=((x-startx)+1+offsetstartx)
							--	value2=((z-startz)+1+offsetstartz)
							--Spring.Echo("JWL_JWLandLord:: Line 586:: Zeile:",value1.. " Spalte:",value2)
							-- Zeile:, 3178 Spalte, 1891
							
							if GroundDeformation[((x-startx)+1+offsetstartx)][((z-startz)+1+offsetstartz)] ~= 0 then 
								
								
								
								--	if the mining unit is new, equalize the terrain, til 0.15 percent is reached
								if LandLordTable[i][5] <= 0.15 then
									y=getGroundHeight(LandLordTable[i][6]*8,LandLordTable[i][7]*8)
									if 	orgTerrainMap[x][z]== nil then 
										--Spring.Echo("JWL_JWLandLord_X Nil:",x.." and z:",z) 
									end
									
									orgTerrainMap[x][z]= 	(((orgTerrainMap[x][z] *2) + y)/3) + upDown
									--then start to dig down/up 
								elseif LandLordTable[i][5] > 0.15 and LandLordTable[i][5] < 0.5 then
									orgTerrainMap[x][z]= orgTerrainMap[x][z] + (((GroundDeformation[(x-startx+offsetstartx)+1][(z-startz+offsetstartz)+1])/((0.5-0.15)/incRate))*upDown)
								else --finally go into overdrive and dig 
									orgTerrainMap[x][z]= orgTerrainMap[x][z] + ((upDown*((GroundDeformation[(x-startx+offsetstartx)+1][(z-startz+offsetstartz)+1])/100)*extremataGlobal)/(0.5/incRate))
								end
								
							end 
						end
					end
					
				end
				--Spring.Echo("JWL_-----------/LANDLORD--------------------------")
			end
		end
		
		function middleMan(valOne,valTwo,weightOne,weightTwo)
			return valOne*weightOne + valTwo*weightTwo/weigtOne+weightTwo
		end
		
		--rewritten
		LDtileSizeX=(MapSizeX)
		LDtileSizeZ=(MapSizeZ)
		function loadDistributor(tileNr, WaterOffset)
			--1
			--preparations
			tileCoordX=tileNr%8 --from 1 to 64 
			if tileCoordX==0 then tileCoordX=8 end
			
			--tileCoordX=1
			
			tileCoordZ=determinateTileNrZ(tileNr)
			--tileCoordZ=1
			--Spring.Echo("JWL_X-Coord Number"..tileCoordX .."of Tile Nr:"..tileNr)
			--Spring.Echo("JWL_rounded Number"..tileCoordZ .."of Tile Nr:"..tileNr)
			--Spring.Echo("JWL_sizeOfOrgTerrainMap",table.getn(orgTerrainMap))
			--secondstage
			startVarX=((tileCoordX-1)*LDtileSizeX)+1
			endVarX=startVarX+LDtileSizeX-1
			--endVarX=127
			startVarZ=((tileCoordZ-1)*LDtileSizeZ)+1
			endVarZ=startVarZ+LDtileSizeZ-1
			--endVarZ=127
			------------------------------------TestEchos---------------------
			local cceil=math.ceil
			if (endVarZ >= MapSizeZ*8) then
				throwTantrum("Index Out of bounds Exception", endVarZ)
				endVarZ=MapSizeZ*8-1
			end
			if (endVarX >= MapSizeX*8) then
				throwTantrum("Index Out of bounds Exception", endVarX)
				endVarX=MapSizeX*8-1
			end
			--Echos the Start And EndVariables
			--Spring.Echo("StarVarX:"..startVarX .."EndVarX:"..endVarX)
			--Spring.Echo("StarVarZ:"..startVarZ .."EndVarZ:"..endVarZ)
			--Testing by spawing a ceg in every square
			--Effect
			
			-- pointY=Spring.GetGroundHeight(startVarX,startVarZ)
			-- teamID = Spring.GetGaiaTeamID ()
			--		mexID= Spring.CreateUnit("zombie", startVarX, pointY, startVarZ, 0, teamID) 
			--
			local spSetHeightMapFunc=Spring.SetHeightMapFunc
			------------------------------------/TestEchos---------------------
			-- the actuall loop
			
			
			spSetHeightMapFunc(function()
				local spSetHeightMap=	Spring.SetHeightMap
				local wOffset=WaterOffset
				--1, 127
				for z=startVarZ,endVarZ, 8 do
					boolPulledOff=false
					for x=startVarX,endVarX, 8 do--changed to 8 as the wizzard zwzsg said i should ;)
						--
						--Spring.Echo("all TheVars:x:",x.."| z:",z)
						--Spring.Echo("Table:",table.getn(orgTerrainMap[cceil(x/8)]))
						--						
						if not orgTerrainMap[cceil(x/8)] or not orgTerrainMap[cceil(x/8)][cceil(z/8)] then Spring.Echo("JW::LANDLORD:: No orgTerrainMap @".. cceil(x/8) .. " / "..cceil(z/8))
							--Spring.Echo(endVarZ)
							--Spring.Echo(endVarX)
							--Spring.Echo("JWL_orgTerrainMapUndefied at x",cceil(x/8).." and z: ",cceil(z/8))
						end
						
						if orgTerrainMap[cceil(x/8)] and orgTerrainMap[cceil(x/8)][cceil(z/8)] then 
							spSetHeightMap( x, z, orgTerrainMap[cceil(x/8)][cceil(z/8)] + wOffset)
							boolPulledOff=true
						end
						--Spring.Echo("JWL_LandLord::LoadDistributor: X ",(cceil(x/8)).." | Z ",(cceil(z/8)))
					end
					--Spring.Echo("Stripe Terraformed Succesfull:",boolPulledOff)
				end
			end)
			
			
			
		end
		
		
		local boolForceUpdateFlag=false
		local WaterOffsetMain=0
		local boolOneAndOnly=true
		function gadget:GameFrame(f)
			
			--Check wether this one Enforces a Update or not
			if f%15 == 0 and GG.boolForceLandLordUpdate==true then
				GG.boolForceLandLordUpdate=false
				boolForceUpdateFlag=true
			end
			
			
			if f%UPDATE_FREQUNECY == 0 or boolForceUpdateFlag==true or boolOneAndOnly==true then
				boolForceUpdateFlag=false
				--update the MapExtremas
				updateMaxima()
				if boolOneAndOnly ==true then
					boolOneAndOnly=false
					
					forgeFirstTerrainMap()
					
					GroundDeformation=createFutureMap(futureMapSize)
				end
				--add the Dynamic Deformations 
				insertDynamicDeformationMaps()				
				
				--validate the units
				validateUnitTable(LandLordTable)
				--increment the depletion Percentage
				--applyChanges to Map
				
				TerraInFormTable()
				
				WaterOffsetMain= getGlobalOffset()
				--	printOUT(orgTerrainMap)
			end
			
			--by now we have the global HeightMap stored in the TerrainMapWorkingCopy
			if f%UPDATE_FREQUNECY > 0 and f%UPDATE_FREQUNECY < 66 then
				
				--Spring.Echo("JWL_LoadDistributor working on PieceNr:".. (f%UPDATE_FREQUNECY) .."of 64")
				--this function distributes the terraforming workload into 64 equal parts - each frame taking one part
				loadDistributor(((f%UPDATE_FREQUNECY)), WaterOffsetMain)
				
				
			end
			
			
			
		end
		
	end	