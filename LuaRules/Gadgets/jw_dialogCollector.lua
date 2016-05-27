
function gadget:GetInfo()
	return {
		name = "Dialog",
		desc = "Draws DialogLines of Units ",
		author = "PicassoCT",
		date = "3rd of May 2010",
		
		license = "Free",
		layer = 0,
		version = 1,
		enabled = true
	}
end

----------------------------------------------------------


-- modified the script: only corpses with the customParam "featuredecaytime" will disappear

if (gadgetHandler:IsSyncedCode()) then
	
	function gadget:GameFrame(frame)
		if GG.Dialog then		
			units= Spring.GetAllUnits()
			local Dialog={}
			
			for _,id in ipairs(units) do
				if GG.Dialog[id] then 
					
					Dialog[id]={}
					for k,unitlines in pairs(GG.Dialog) do				
						for i=1, #unitlines, 1 do						
							if unitlines[i].frames <= 0 then 
								GG.Dialog[k]= nil 
							end
							
							Dialog[id][#Dialog[id]+ 1]={
								unitheigth= unitlines[i].unitheigth or 20,
								lifetime=unitlines[i].lifetime-unitlines[i].frames ,
								line=unitlines[i].line,													
							}	
							
							unitlines[i].frames= unitlines[i].frames -1			
						end
					end
				end	
			end	
			--	Send to Unsynced
			_G.Dialog = Dialog
			
			
			
		end
	end
else --UNSYNCED
	
	local glText = gl.Text
	
	
	function gadget:DrawScreenEffects()	
		if SYNCED.Dialog then
			fontsize=16
			--cx,cy,cz=Spring.GetCameraPosition()
			
			for _,id in ipairs(Spring.GetAllUnits()) do	
				if SYNCED.Dialog[id] then 
					local dialog = SYNCED.Dialog[id]			
					x,y,z =Spring.GetUnitPosition(id)
					
					for i =1, #dialog do		
						offset =dialog[i].unitheigth + dialog[i].lifetime +(#dialog* (fontsize)) - (i*( fontsize))
						sy=y+offset
						sx,sy=Spring.WorldToScreenCoords(x,sy,z)		
						glText(dialog[i].line,sx,sy,fontsize,"laos")
						
					end
				end
			end
		end
	end		
end