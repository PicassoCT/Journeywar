
function widget:GetInfo()
	return {
		name      = 'Quick peek',
		desc      = 'have a quick look at most recent screen message',
		version   = "1.0",
		author    = 'Jools',
		date      = 'Jan, 2014',
		license   = 'GNU GPL v2',
		layer     = 1,
		enabled   = true,
	}
end

local markFrame = 0
local mapMark
local cx,cy,cz
local TIMEOUT = 150 -- frames
local CAMTIME = 0.2

function widget:MapDrawCmd(playerID, cmdType, px, py, pz, labeltext)

	markFrame = Spring.GetGameFrame()
	mapMark = {px,py,px}
end

function widget:KeyPress(key, mods, isRepeat)
	if key == 0x020 and mapMark then
		cx,cy,cz = Spring.GetCameraPosition()
		Spring.SetCameraTarget(mapMark[1],mapMark[2],mapMark[3],CAMTIME)
		return true
	end
	return false
end

function widget:KeyRelease(key) 
	if key  == 0x020 and cx then
		Spring.SetCameraTarget(cx,cy,cz,CAMTIME)
		return true
	end
	
	return false
end

function widget:GameFrame(frame)
	if frame > markFrame +TIMEOUT then
		mapMark = nil
		cx,cy,cz = nil,nil,nil
	end
end

	
	