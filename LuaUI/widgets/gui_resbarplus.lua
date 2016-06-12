function widget:GetInfo()
	return {
		name = "Resource Bar Plus v1.1",
		desc = "Replaces default resource bar with nicer version",
		author = "Wisse and Beherith",
		date = "October 2008",
		license = "ask me if you want it",
		layer = 22,
		enabled = true -- loaded by default?
	}
end

local pngx=512
local pngy=512
local mglow=0
local gameframe=0
local cooldownglowtime=30
local eshare=.999
local mshare=.999
local components = {}
local vsx, vsy = widgetHandler:GetViewSizes()
local offsetx=0
local offsety=0
local esurge=4
local esurge2=4
local seperation=100
local opSignum= 1



local gl_Blending = gl.Blending
local gl_Color = gl.Color
local gl_Texture = gl.Texture
local gl_TexRect= gl.TexRect
local gl_Text= gl.Text
local Spring_GetTeamResources = Spring.GetTeamResources
local Spring_GetGameFrame = Spring.GetGameFrame
local Spring_GetGameSeconds = Spring.GetGameSeconds
local math_floor = math.floor
teamid=Spring.GetLocalTeamID()
combine="centrail"

sideCombine=true
pathEnergy="luaui/images/cres_energy.png"
pathMetall="luaui/images/cres_metal.png"

function setTeam()

	if teamid then
		teamID, leader, isDead, isAiTeam, side, allyTeam, customTeamKeys, incomeMultiplier= Spring.GetTeamInfo(teamid)
		if side and side ~= "" and type(side)== "string" then
			if string.lower(side)==combine then
				sideCombine = true
			elseif string.lower(side)== 'journeyman' then
				sideCombine= false
			end			
		end
		
		
		if sideCombine==false then
			pathEnergy= 'luaui/images/jres_energy.png' 
			pathMetall= 'luaui/images/jres_metal.png' 
		end

	end
end



components[1] = { --"Energy bar, yellow"--
	name= 'energy' ,
	
	left = 81,
	top = 59,
	
	tx1 = 81 ,--TL
	ty1 = 393 ,
	
	tx2 = 437, --BR
	ty2 = 377,
	
	alpha = 1
}


components[2] = { --"Warning bar, dark red, should start to fade in sync with falling energy, starts from 10 percent. Or maybe make it blink faster and faster with glow on stall"--
	name='warning' ,
	
	left = 81,
	top = 59,
	
	tx1 = 81 ,--TL
	ty1 = 373 ,
	
	tx2 = 437 ,--BR
	ty2 = 357,
	
	alpha = 1
}


components[3] = { --"Share, postioned over first column"--
	name='share' ,
	
	left = 81,
	top = 59,
	
	tx1 = 71 ,--TL
	ty1 = 393 ,
	
	tx2 = 76, --BR
	ty2 = 377,
	
	alpha = 1
}


components[4] = { --"Surge 1"--
	name='surge_1' ,
	
	left = 0,
	top = 47,
	
	tx1 = 0 ,--TL
	ty1 = 345, 
	
	tx2 = 35 ,--BR
	ty2 = 295,
	
	alpha = 1
}


components[5] = { --"Surge 2"--
	name='surge_2' ,
	
	left = 0,
	top = 47,
	
	tx1 = 50 ,--TL
	ty1 = 345,
	
	tx2 = 85 ,--BR
	ty2 = 295,
	
	alpha = 1
}


components[6] = { --"Surge 3"--
	name='surge_3' ,
	
	left = 0,
	top = 47,
	
	tx1 = 100, --TL
	ty1 = 345 ,
	
	tx2 = 135 ,--BR
	ty2 = 295,
	
	alpha = 1
}


components[7] = { --"Surge 4"--
	name='surge_4' ,
	
	left = 0,
	top = 47,
	
	tx1 = 150, --TL
	ty1 = 345 ,
	
	tx2 = 185 ,--BR
	ty2 = 295,
	
	alpha = 1
}

eGuiBase = 8
components[eGuiBase] = { --"base"--
	name='base' ,
	
	left = 0,
	top = 47,
	
	tx1 = 0, --TL
	ty1 = 465 ,
	
	tx2 = 465 ,--BR
	ty2 = 405 ,
	
	alpha = 1
}
eMetallBar = 10
components[eMetallBar] = { --"Metal penis"--
	name= 'metal' ,
	
	left = 80,
	top = 58, --11 for E bar
	
	tx1 = 0, --TL
	atx1 = 0, --TL
	ty1 = 400 ,
	aty1 = 400 ,
	
	tx2 = 360 ,--BR
	atx2 = 360 ,--BR
	ty2 = 377,
	aty2 = 377,
	
	alpha = 1
}


components[11] = { --"Furnace shadow, bottom most layer"--
	name='furnace_shadow' ,
	
	left = 0,
	top = 47,
	
	tx1 = 0 ,--TL
	ty1 = 375, 
	
	tx2 = 100 ,--BR
	ty2 = 320,
	
	alpha = 1
}


components[12] = { --"Share mark, position at 10 percent, put this behind bars and base"--
	name='share' ,
	
	left = 72,
	top = 56,
	
	tx1 = 108, --TL
	ty1 = 366 ,
	
	tx2 = 122 ,--BR
	ty2 = 335,
	
	alpha = 1
}


components[13] = { --"Warning bars, glowing, fade them over bars"--
	name='bars_glow' ,
	
	left = 78,
	top = 47,
	
	tx1 = 128, --TL
	ty1 = 365 ,
	
	tx2 = 171 ,--BR
	ty2 = 327,
	
	alpha = 1
}


components[14] = { --"Warning bars, fade away when bars_glow are completely on"--
	name='bars' ,
	
	left = 78,
	top = 47,
	
	tx1 = 178, --TL
	ty1 = 365 ,
	
	tx2 = 221 ,--BR
	ty2 = 327,
	
	alpha = 1
}


eGuiBaseMetal =15
components[eGuiBaseMetal] = { --"base"--
	name='base' ,
	
	left = 0,
	top = 47,
	
	tx1 = 0 ,--TL
	ty1 = 465, 
	
	tx2 = 465 ,--BR
	ty2 = 405,
	
	alpha = 1
}

eJourneyFlyingGhosts=16
components[eJourneyFlyingGhosts] = {
	name='ghost' ,
	
	left = 172,
	top = 56,
	
	tx1 = 158, --TL
	ty1 = 366 ,
	
	tx2 = 172 ,--BR
	ty2 = 335,
	
	alpha = 1
}


function DrawTexRect(x1,y1,x2,y2,s1,t1,s2,t2)
	gl_TexRect(x1-offsetx+47,y1-offsety+47,x2-offsetx+47,y2-offsety+47,s1,t1,s2,t2)
end

function DrawText(a,b,c,d,e)
	gl_Text(a,b-offsetx,c-offsety,d,e)
end


function DrawComponent(number)
	gl_Color(1,1,1,components[number].alpha)
	local x1,y1,x2,y2
	if number <9 then
		gl_Texture(pathEnergy)	
		
		x1= vsx +components[number].left -pngx --bottom left of placing
		y1= vsy -components[number].top -math.abs(components[number].ty1-components[number].ty2) 
		x2= x1 +(components[number].tx2-components[number].tx1)	--top right of placing
		y2= y1 +(components[number].ty1-components[number].ty2 )
	else
		gl_Texture(pathMetall)	
		
		x1= vsx +components[number].left -pngx -465 -seperation --bottom left of placing
		y1= vsy -components[number].top -math.abs(components[number].ty1-components[number].ty2) 
		x2= x1 +(components[number].tx2-components[number].tx1) 	--top right of placing
		y2= y1 +(components[number].ty1-components[number].ty2 )
	end
	local s1=components[number].tx1 /pngx--top left bounding
	local t1=(512-components[number].ty2) /pngy
	local s2=components[number].tx2/pngx--bottom right bounding
	local t2=(512-components[number].ty1) /pngy
	
	DrawTexRect(x1,y1,x2,y2,s1,t1,s2,t2)
	
	gl_Texture(false)
	
end


function DrawEbar(pct)
	local number=1
	local ebarwidth=components[number].tx2-components[number].tx1--1
	local drawwidth=math_floor(pct*ebarwidth/5)*5
	--	Spring.Echo(pct)
	if pct >0.15 then
		gl_Color(1,1,1,components[number].alpha)
		gl_Texture(pathEnergy)	
		local x1= vsx +components[number].left -pngx --bottom left of placing
		local y1= vsy -components[number].top -math.abs(components[number].ty1-components[number].ty2) 
		
		local x2= x1 +drawwidth--+1	--top right of placing
		
		local y2= y1 +(components[number].ty1-components[number].ty2)
		local s1=components[number].tx1 /pngx--top left bounding
		local t1=(pngy-components[number].ty2) /pngy
		local s2=(components[number].tx1 +drawwidth) /pngx--bottom right bounding
		local t2=(pngy-components[number].ty1) /pngy
		DrawTexRect(x1,y1,x2,y2,s1,t1,s2,t2)
		
		gl_Texture(false)
	else
		gl_Color(1,1,1,1-pct/0.15)
		gl_Texture(pathEnergy)			
		local x1,x2,y1,y2,s1,s2,t1,t2
		number=2
		
		x1= vsx +components[number].left -pngx --bottom left of placing
		y1= vsy -components[number].top -math.abs(components[number].ty1-components[number].ty2) 
		
		x2= x1 +(components[number].tx2-components[number].tx1)	--top right of placing
		
		y2= y1 +(components[number].ty1-components[number].ty2)
		s1=components[number].tx1 /pngx--top left bounding
		t1=(pngy-components[number].ty2) /pngy
		s2=(components[number].tx2) /pngx--bottom right bounding
		t2=(pngy-components[number].ty1) /pngy
		
		
		DrawTexRect(x1,y1,x2,y2,s1,t1,s2,t2)
		
		
		number=1
		
		gl_Color(1,1,1,components[number].alpha)
		x1= vsx +components[number].left -pngx --bottom left of placing
		y1= vsy -components[number].top -math.abs(components[number].ty1-components[number].ty2) 
		
		x2= x1 +drawwidth	--top right of placing
		
		y2= y1 +(components[number].ty1-components[number].ty2)
		
		s1=components[number].tx1 /pngx--top left bounding
		t1=(pngy-components[number].ty2) /pngy
		s2=(components[number].tx1 +drawwidth) /pngx--bottom right bounding
		t2=(pngy-components[number].ty1) /pngy
		
		DrawTexRect(x1,y1,x2,y2,s1,t1,s2,t2)
		gl_Texture(false)
	end
end

function DrawMbar(pct)

	local now=Spring.GetGameFrame()
	
	--now = (now % 3000)/3000 
	--components[eMetallBar].tx2= math.ceil(components[eMetallBar].atx2*now)
	--components[eMetallBar].tx1= math.ceil(components[eMetallBar].atx2*now)

	local mbarwidth=components[eMetallBar].tx2-components[eMetallBar].tx1
	local drawwidth=pct*mbarwidth
	--	Spring.Echo(pct)
	
	gl_Color(1,1,1,components[eMetallBar].alpha)
	gl_Texture(pathMetall)	
	local x1= vsx +components[eMetallBar].left -pngx -465 -seperation --bottom left of placing
	local y1= vsy -components[eMetallBar].top -math.abs(components[eMetallBar].ty1-components[eMetallBar].ty2) 
	local x2= x1 +drawwidth+1	--top right of placing
	
	local y2= y1 +(components[eMetallBar].ty1-components[eMetallBar].ty2)
	local s1=(components[eMetallBar].tx2 -drawwidth )/pngx--top left bounding
	local t1=(pngy-components[eMetallBar].ty2) /pngy
	local s2=(components[eMetallBar].tx2 ) /pngx--bottom right bounding
	local t2=(pngy-components[eMetallBar].ty1) /pngy
	DrawTexRect(x1,y1,x2,y2,s1,t1	,s2,t2)
	
	gl_Texture(false)
	
		
	--	Spring.Echo(mglow)
	DrawMShare(mshare)
	
	
	local default=35+47
	if pct>.98 then-- SPLURGE
		
		
		
	
		if mglow >0 then
			mglow=mglow -norm(now-gameframe)
		end
		gameframe=now
		
		
	else 
		
		if mglow <cooldownglowtime then
			mglow=mglow + norm(now-gameframe)
		end
		gameframe=now
		

	end	
	
	
end


function DrawEShare(es)
	local number=3
	gl_Color(1,1,1,components[number].alpha)
	local x1,y1,x2,y2
	local s1,t1,s2,t2
	gl_Texture(pathEnergy)	
	local pos= math_floor((components[1].tx2-components[1].tx1-2)*es/5)*5
	
	x1= vsx +components[number].left -pngx +pos --bottom left of placing
	y1= vsy -components[number].top -math.abs(components[number].ty1-components[number].ty2)
	x2= x1 +(components[number].tx2-components[number].tx1)	 --top right of placing
	y2= y1 +(components[number].ty1-components[number].ty2 )
	
	s1=components[number].tx1 /pngx--top left bounding
	t1=(pngy-components[number].ty2) /pngy
	s2=components[number].tx2/pngx--bottom right bounding
	t2=(pngy-components[number].ty1) /pngy
	
	DrawTexRect(x1,y1,x2,y2,s1,t1,s2,t2)
	
	gl_Texture(false)
end

function DrawMShare(ms)
	local number=12
	gl_Color(1,1,1,components[number].alpha)
	gl_Texture(pathMetall)	
	
	local pos= math_floor((components[eMetallBar].tx2-components[eMetallBar].tx1)*ms)
	
	x1= vsx +components[number].left -pngx -465-seperation +pos --bottom left of placing
	y1= vsy -components[number].top -math.abs(components[number].ty1-components[number].ty2) 
	x2= x1 +(components[number].tx2-components[number].tx1)	--top right of placing
	y2= y1 +(components[number].ty1-components[number].ty2 )
	
	s1=components[number].tx1 /pngx--top left bounding
	t1=(pngy-components[number].ty2) /pngy
	s2=components[number].tx2/pngx--bottom right bounding
	t2=(pngy-components[number].ty1) /pngy
	
	DrawTexRect(x1,y1,x2,y2,s1,t1,s2,t2)
	--	Spring.Echo(pos..' '..x1..' '..y1..' '..x2..' '..y2..' '..s1..' '..t1..' '..s2..' '..t2)
	
	gl_Texture(false)
	
	
end

function norm(n)
	if n<0 then
		return 0
	end
	if n >1 then 
		return 1
	else
		return n
	end
end


function widget:ViewResize(viewSizeX, viewSizeY)
	vsx = viewSizeX
	vsy = viewSizeY
end

function widget:Initialize()
	local vsx, vsy = widgetHandler:GetViewSizes()
	widget:ViewResize(vsx, vsy)
	Spring.SendCommands({"resbar 0"})
	setTeam()
	
	Spring.SetShareLevel("metal",mshare)
	Spring.SetShareLevel("energy",eshare)
	--offsetx =Spring.GetConfigInt("ResourcebarPlusOffsetx", 0)
	--offsety = Spring.GetConfigInt("ResourcebarPlusOffsety", 0)
end

function widget:Shutdown()
	Spring.SendCommands({"resbar 1"})
	
end


function widget:MousePress(x, y, button)
	local x1,y1,x2,y2
	local number=1
	x1= 47+vsx +components[number].left -pngx -offsetx --bottom left of placing
	y1= 47+vsy -components[number].top -math.abs(components[number].ty1-components[number].ty2) -offsety
	x2= x1 +(components[number].tx2-components[number].tx1)	 --top right of placing
	y2= y1 +(components[number].ty1-components[number].ty2 ) 
	
	if x>x1 and x <x2 and y>y1 and y<y2 then
		eshare=(x-x1)/(x2-x1)
		Spring.SetShareLevel("energy", (x-x1)/(x2-x1))
	end
	
	local number=10
	x1= 47+vsx +components[number].left -pngx -465-seperation -offsetx --bottom left of placing
	y1= 47+vsy -components[number].top -math.abs(components[number].ty1-components[number].ty2) -offsety
	x2= x1 +(components[number].tx2-components[number].tx1)	--top right of placing
	y2= y1 +(components[number].ty1-components[number].ty2 )
	
	if x>x1 and x <x2 and y>y1 and y<y2 then
		mshare=(x-x1)/(x2-x1)
		Spring.SetShareLevel("metal", (x-x1)/(x2-x1))
	end
	return false
end



function widget:MouseMove(x, y, dx, dy, button)
	local x1,y1,x2,y2
	
	x1=vsx-920-offsetx
	x2=vsx-980-offsetx
	y1=vsy-5-offsety
	y2=vsy-45-offsety
	
	if button==1 and x>x1 and x <x2 and y> y1 and y< y1 then
		offsetx = offsetx - dx
		offsety = offsety - dy
	end
	return false
end

function widget:DrawScreen()
	
	-- Teams can change, so we need to update out team ID incase this happens
	local myTeam = Spring.GetLocalTeamID()
	
	-- Only draw if the game has started
	if Spring.GetGameFrame() > 1 then
		--save glsstate
		gl.PushMatrix() 
		
		local curElevel,curEstore,curEpull,curEinc,curEexpense,curEshare,curEsent,curErecieved = Spring.GetTeamResources(myTeam, 'energy')
		local curMlevel,curMstore,curMpull,curMinc,curMexpense,curMshare,curMsent,curMrecieved = Spring.GetTeamResources(myTeam, 'metal')
				
		curElevel = math_floor(curElevel)
		curMlevel = math_floor(curMlevel)
				
		local curEpct = curElevel / curEstore
		local curMpct = curMlevel / curMstore
		
		gl_Blending(true)
		gl_Color(1, 1, 1, 1)
		
		--draw the main bar thingy

		DrawComponent(eGuiBase)
		local t= Spring.GetGameSeconds()
		
		
		if curEpct>0.99 then 
			if math.fmod(10*t,2)==0	then
				--Spring.Echo(esurge)
				
				esurge=esurge2
				esurge2 = (esurge2 +1) % 8
				if esurge2 < 4 then  esurge2 = 4 end			
				
			end
		
			DrawComponent(esurge)
			DrawComponent(esurge2)
			
		end
		
		DrawEbar(curEpct)
		
		local curEsharepct=curEstore/curEshare
		
		DrawEShare(eshare)
		
		--OK metal bar time now:
		DrawComponent(eGuiBaseMetal) --base
		DrawComponent(11) --furnace shadow		
		
		components[14].alpha=norm((curMpct-0.10) *20)--normal bars
		--DrawComponent(14)
		components[13].alpha=norm((0.15 -curMpct) *20)--glowy bars
		DrawComponent(13)
		DrawMbar(curMpct)
		--drawcomponent
		if sideCombine == false then
		DrawComponent(eJourneyFlyingGhosts)
		end
		--TIME FOR TEXT
		
		
		gl_Color(0,0,0,1)
		if curElevel<10000 then
			DrawText(math_floor(curElevel), vsx-465+260, vsy-47,10,'cn')
		else
			DrawText(math_floor(curElevel/1000)..'K', vsx-465+260, vsy-47,10,"cn")
		end
		
		if curEstore<10000 then
			DrawText(math_floor(curEstore), vsx-465+432, vsy-47,10,'cn')
		else
			DrawText(math_floor(curEstore/1000)..'K', vsx-465+432, vsy-47,10,"cn")
		end
		
		
		gl_Color(0,0.6,0,1)
		if curEinc<10000 then
			DrawText('+'..math_floor(curEinc), vsx-465+53, vsy-22,10,'cn')
		else
			DrawText('+'..math_floor(curEinc/1000)..'K', vsx-465+53, vsy-22,10,"cn")
		end
		
		
		gl_Color(0.7,0,0,1)
		if curEpull<10000 then
			DrawText('-'..math_floor(curEpull), vsx-465+53, vsy-38,10,'cn')
		else
			DrawText('-'..math_floor(curEpull/1000)..'K', vsx-465+53, vsy-38,10,"cn")
		end
		
		
		gl_Color(0,0,0,1)
		if curMlevel<10000 then
			DrawText(math_floor(curMlevel), vsx-930+259-seperation, vsy-49,10,'cn')
		else
			DrawText(math_floor(curMlevel/1000)..'K', vsx-930+259-seperation, vsy-49,10,"cn")
		end
		
		if curMstore<10000 then
			DrawText(math_floor(curMstore), vsx-930+434-seperation, vsy-49,10,'cn')
		else
			DrawText(math_floor(curMstore/1000)..'K', vsx-930+434-seperation, vsy-49,10,"cn")
		end
		
		
		gl_Color(0,0.6,0,1)
		if curMinc<1000 then
			DrawText('+'..math_floor(curMinc)..'.'..math_floor((curMinc-math_floor(curMinc))*10), vsx-930+56-seperation, vsy-23,10,'cn')
		else
			DrawText('+'..math_floor(curMinc/1000)..'.'..math_floor((curMinc/1000-math_floor(curMinc/1000))*10) ..'K', vsx-930+56-seperation, vsy-23,10,"cn")
		end
		
		
		gl_Color(0.7,0,0,1)
		if curMpull<1000 then
			DrawText('-'..math_floor(curMpull)..'.'..math_floor((curMpull-math_floor(curMpull))*10), vsx-930+56-seperation, vsy-39,10,'cn')
		else
			DrawText('-'..math_floor(curMpull/1000) ..'.'.. math_floor((curMpull/1000-math_floor(curMpull/1000))*10)..'K', vsx-930+56-seperation, vsy-39,10,"cn")
		end
		--restore gl state
		gl.PopMatrix()		
	end
end


--drag bar
--double anim