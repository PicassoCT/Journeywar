function widget:GetInfo()
	return {
		name      = "Video Maker",
		desc      = "Plops lots of images and shit",
		author    = "ashdnazg",
		date      = "18 Nov 2016",
		license   = "GNU GPL, v2 or later",
		layer     = 5,
		enabled   = true,
	}
end

--Constants

local GAME_SPEED = 30
-------------------------------------
-------------- CHILI ----------------
-------------------------------------

local COLOR_REGULAR     = {1,1,1, 1}
local COLOR_SELECTED = {0.8, 0, 0, 1}

-----------------------
-- Control window
-----------------------
local keyFrameButton
local loadFrameButton
local newShotButton
local deleteButton
local playButton
local recordButton
local controlWindow
local shotsTree
local shotsScroll

-----------------------
-- Timeline window
-----------------------
local timeline
local timelineWindow
local prevFrameButton
local prevSecButton
local nextFrameButton
local nextSecButton
local timelineLabel

-------------------------------------
-------------- /CHILI ---------------
-------------------------------------


-----------------------
-- Timeline Vars
-----------------------
local timelineHoverFrame = -1
local timelineFrame = 0
local maxFrame = 2000
-----------------------
-- /Timeline Vars
-----------------------


-----------------------
-- Control Vars
-----------------------

local savedCam
local numShots = 0
local nodeToShot = {}
local nodeToKeyFrame = {}
local shots = {} -- {shotNum = { frame = camState }}
local shotSortedKeyFrames = {}
local playedShot
local playedFrame

-----------------------
-- /Util funcs
-----------------------

function UnlinkSafe(link)
	local link = link
	while (type(link) == "userdata") do
		link = link()
	end
	return link
end

local function ClampFrame(f)
	f = math.min(maxFrame, f)
	f = math.max(0, f)
	return f
end

local function FrameToTime(f)
	f = ClampFrame(f)
	local seconds, frame = math.modf(f/GAME_SPEED)
	local minute, second = math.modf(seconds/60)
	frame = frame * GAME_SPEED
	second = 60 * second
	return string.format ("%d:%02d::%02d" , minute, second, frame)
end

local function InterpRotation(ratio, ratio2, rot1, rot2)
	local larger = math.max(rot1, rot2)
	local smaller = math.min(rot1, rot2)
	if larger - smaller > math.pi then
		local pi2 = 2 * math.pi
		local res = (rot1 + pi2) * ratio + (rot2 + pi2) * ratio2
		while ret > math.pi do
			ret = res - pi2
		end
		return ret
	end
	return rot1 * ratio + rot2 * ratio2
end

local function GetInterpolatedCameraState(ratio, state1, state2)
	local interpState = {}
	for k,v in pairs(state1) do
		interpState[k] = v
	end
	local ratio2 = 1 - ratio
	interpState.px  = state1.px  * ratio2 + state2.px  * ratio
	interpState.py  = state1.py  * ratio2 + state2.py  * ratio
	interpState.pz  = state1.pz  * ratio2 + state2.pz  * ratio
	interpState.fov = state1.fov * ratio2 + state2.fov * ratio

	interpState.dx  = InterpRotation(ratio2, ratio, state1.dx, state2.dx)
	interpState.dy  = InterpRotation(ratio2, ratio, state1.dy, state2.dy)
	interpState.dz  = InterpRotation(ratio2, ratio, state1.dz, state2.dz)
	return interpState
end

-----------------------
-- /Util Funcs
-----------------------

-----------------------
-- Timeline Funcs
-----------------------

local function ChangeTimelineFrame(newFrame)
	newFrame = ClampFrame(newFrame)
	timelineFrame = newFrame
	timeline:SetValue(newFrame)
	local t = FrameToTime(newFrame)
	timeline:SetCaption(t)
end

-----------------------
-- /Timeline Funcs
-----------------------

-----------------------
-- Control Funcs
-----------------------

local function GetSelectedNode()
	local selected = shotsTree.selected
	if not selected then
		return nil
	end
	local node = UnlinkSafe(selected)
	if not node then
		return nil
	end
	return node
end

local function NewShot()
	numShots = numShots + 1
	local newNode = shotsTree.root:Add("Shot " .. numShots)
	newNode = UnlinkSafe(newNode)
	nodeToShot[newNode] = numShots
	shots[numShots] = {}
	shotSortedKeyFrames[numShots] = {}
	shotsTree.selected = false
	shotsTree:Select(newNode)
end

local function DeleteShot(shot)
	shots[shot] = nil
end

local function RegenerateSortedKeyFrames(shot)
	local tempTable = {}
	for frame, _ in pairs(shots[shot]) do
		table.insert(tempTable, frame)
	end

	table.sort(tempTable)
	shotSortedKeyFrames[shot] = tempTable
end


local function DeleteKeyFrame(shot, keyFrame)
	shots[shot][keyFrame] = nil
	RegenerateSortedKeyFrames(shot)
end

local function SetKeyFrame()
	local node = GetSelectedNode()
	if not node then
		return
	end
	if nodeToKeyFrame[node] then
		node = UnlinkSafe(node.parent)
	end
	if nodeToShot[node] then
		local parentShot = nodeToShot[node]
		if not shots[parentShot][timelineFrame] then
			shots[parentShot][timelineFrame] = Spring.GetCameraState()

			node:ClearChildren()
			RegenerateSortedKeyFrames(parentShot)

			local addedNode

			for _, frame in pairs(shotSortedKeyFrames[parentShot]) do
				local newNode = node:Add(FrameToTime(frame))
				newNode = UnlinkSafe(newNode)
				nodeToKeyFrame[newNode] = frame
				if frame == timelineFrame then
					addedNode = newNode
				end
			end
			shotsTree.selected = false
			shotsTree:Select(addedNode)
		else
			shots[parentShot][timelineFrame] = Spring.GetCameraState()
		end
	end
end

local function GetFrame()
	local node = GetSelectedNode()
	if not node then
		return
	end
	if not nodeToKeyFrame[node] then
		return
	end
	local keyFrame = nodeToKeyFrame[node]
	local parentShot = nodeToShot[UnlinkSafe(node.parent)]
	Spring.SetCameraState(shots[parentShot][keyFrame])
end


local function DeleteNode()
	local node = GetSelectedNode()
	if not node then
		return
	end
	if nodeToShot[node] then
		local deletedShot = nodeToShot[node]
		node:Dispose()
		shotsTree.selected = false
		nodeToShot[node] = nil
		DeleteShot(deletedShot)
	end
	if nodeToKeyFrame[node] then
		local deletedKeyFrame = nodeToKeyFrame[node]
		local parentShot = nodeToShot[UnlinkSafe(node.parent)]
		node:Dispose()
		shotsTree.selected = false
		shotsTree:Select(parentShot)
		nodeToKeyFrame[node] = nil
		DeleteKeyFrame(parentShot, deletedKeyFrame)
	end
end


local function PlayShot()
	local node = GetSelectedNode()
	if not node then
		return
	end
	local keyFrame = nodeToKeyFrame[node]
	if keyFrame then
		node = UnlinkSafe(node.parent)
	end
	local shot = nodeToShot[node]
	if not shot then
		return
	end
	if #shotSortedKeyFrames[shot] < 2 then
		Spring.Echo("A shot must have a start and an end")
		return
	end
	playedShot = shot
	playedFrame = shotSortedKeyFrames[shot][1]
end


-----------------------
-- /Control Funcs
-----------------------


-----------------------
-- Callins && Crap
-----------------------

local function InitGUI()
	local Chili = WG.Chili

	keyFrameButton = Chili.Button:New{
		x = 0,
		y = 10,
		width = 100,
		caption = "Set KeyFrame",
		OnClick = {
			function(self)
				SetKeyFrame()
			end
		}
	}

	loadFrameButton = Chili.Button:New{
		y = 10,
		x = 110,
		width = 100,
		caption = "Get Frame",
		OnClick = {
			function(self)
				GetFrame()
			end
		}
	}

	newShotButton = Chili.Button:New{
		y = 30,
		x = 0,
		width = 100,
		caption = "New Shot",
		OnClick = {
			function(self)
				NewShot()
			end
		}
	}

	deleteButton = Chili.Button:New{
		y = 30,
		x = 110,
		width = 100,
		caption = "Delete",
		OnClick = {
			function(self)
				DeleteNode()
			end
		}
	}

	playButton = Chili.Button:New{
		y = 50,
		x = 0,
		width = 100,
		caption = "Play Shot",
		OnClick = {
			function(self)
				PlayShot()
			end
		}
	}

	recordButton = Chili.Button:New{
		y = 50,
		x = 110,
		width = 100,
		caption = "Record Shot",
		OnClick = {
			function(self)
				record = true
				PlayShot()
			end
		}
	}

	shotsTree = Chili.TreeView:New{
		y = 0,
		x = 0,
		right = 0,
		bottom = 0,
		defaultExpanded = true,
		nodes = {
		},
	}

	shotsScroll = Chili.ScrollPanel:New{
		x = 0,
		y = 70,
		right = 0,
		bottom = 0,
		children = {
			shotsTree
		},
	}

	controlWindow = Chili.Window:New{
		caption = "Controls",
		y = "50%",
		right = 10,
		width  = 240,
		height = "40%",
		parent = Chili.Screen0,
		--autosize = true,
		--savespace = true,
		children = {
			keyFrameButton,
			loadFrameButton,
			newShotButton,
			deleteButton,
			playButton,
			recordButton,
			shotsScroll,
		},
	}


	prevSecButton = Chili.Button:New{
		caption = "<<",
		y = 20,
		x = 0,
		width = 15,
		OnMouseOver = {
			function(self)
				timelineLabel:SetCaption("-1 Second")
			end
		},
		OnMouseOut = {
			function(self)
				timelineLabel:SetCaption("")
			end
		},
		OnClick = {
			function(self)
				ChangeTimelineFrame(timelineFrame - GAME_SPEED)
			end
		}
	}

	prevFrameButton = Chili.Button:New{
		caption = "<",
		y = 20,
		x = 20,
		width = 15,
		OnMouseOver = {
			function(self)
				timelineLabel:SetCaption("-1 Frame")
			end
		},
		OnMouseOut = {
			function(self)
				timelineLabel:SetCaption("")
			end
		},
		OnClick = {
			function(self)
				ChangeTimelineFrame(timelineFrame - 1)
			end
		}
	}

	nextFrameButton = Chili.Button:New{
		caption = ">",
		y = 20,
		width = 15,
		right = 20,
		OnMouseOver = {
			function(self)
				timelineLabel:SetCaption("+1 Frame")
			end
		},
		OnMouseOut = {
			function(self)
				timelineLabel:SetCaption("")
			end
		},
		OnClick = {
			function(self)
				ChangeTimelineFrame(timelineFrame + 1)
			end
		}
	}

	nextSecButton = Chili.Button:New{
		caption = ">>",
		y = 20,
		width = 15,
		right = 0,
		OnMouseOver = {
			function(self)
				timelineLabel:SetCaption("+1 Second")
			end
		},
		OnMouseOut = {
			function(self)
				timelineLabel:SetCaption("")
			end
		},
		OnClick = {
			function(self)
				ChangeTimelineFrame(timelineFrame + GAME_SPEED)
			end
		}
	}
	timelineLabel = Chili.Label:New{
		caption = "",
		y = 40,
		x = "45%",
	}

	timeline = Chili.Progressbar:New{
		x = 40,
		y = 20,
		height = 20,
		--width = "90%",
		right = 40,
		value = 0,
		max = 2000,
		OnMouseDown = {
			function(self)
				ChangeTimelineFrame(timelineHoverFrame)
				return true
			end
		},
		-- OnMouseOver = {
			-- function(self)
				-- timelineLabel:SetCaption("bla")
			-- end
		-- },
		OnMouseOut = {
			function(self)
				timelineLabel:SetCaption("")
			end
		},
		OnMouseMove = {
			function(self, x, y, dx, dy, button)
				local target = x / (self.width - 12)
				timelineHoverFrame = math.floor(target * self.max)
				local t = FrameToTime(timelineHoverFrame)
				timelineLabel:SetCaption("Goto: " .. t)
				if (button == 1) then
					ChangeTimelineFrame(timelineHoverFrame)
				end
			end
		},
		HitTest = function(self,x,y)
			return self
		end
	}
	timelineWindow = Chili.Window:New{
		caption = "TimeLine",
		y = "90%",
		right = 10,
		width  = "50%",
		height = 100,
		parent = Chili.Screen0,
		children = {
			prevSecButton,
			prevFrameButton,
			nextFrameButton,
			nextSecButton,
			timelineLabel,
			timeline,
		},
	}
	NewShot()
end

--------------
--  CALLINS --
--------------

local saveImage
local vsx, vsy

function widget:GameFrame(n)
	if saveImage then
		if record then
			gl.SaveImage(0,0,vsx,vsy,string.format("capture_%06d.png", saveImage));
		end
		saveImage = false
		if not playedShot or not playedFrame then
			Spring.SetVideoCapturingMode(false)
			Spring.SendCommands("hideinterface 0")
			record = false
		end
	end
	if not playedShot or not playedFrame then
		playedShot = nil
		playedFrame = nil
		return
	end

	local keyFrames = shots[playedShot]
	local sortedKeyFrames = shotSortedKeyFrames[playedShot]
	if playedFrame == sortedKeyFrames[1] then
		Spring.SetVideoCapturingMode(true)
		Spring.SendCommands("hideinterface 1")
		vsx, vsy = widgetHandler:GetViewSizes()
	end

	saveImage = playedFrame
	for i, keyFrame in pairs(sortedKeyFrames) do
		if keyFrame == playedFrame then
			Spring.SetCameraState(keyFrames[keyFrame])
		elseif playedFrame < keyFrame then
			local prevKeyFrame = sortedKeyFrames[i - 1]
			local ratio = (playedFrame - prevKeyFrame) / (keyFrame - prevKeyFrame)
			Spring.SetCameraState(GetInterpolatedCameraState(ratio, keyFrames[prevKeyFrame], keyFrames[keyFrame]))
			break
		end
	end
	ChangeTimelineFrame(playedFrame)
	if playedFrame ~= sortedKeyFrames[#sortedKeyFrames] then
		playedFrame = playedFrame + 1
	else
		playedFrame = nil
		playedShot = nil
	end
end

function widget:Update()
	if nextCamState then
		Spring.SetCameraState(nextCamState)
		nextCamState = nil
	end
end

function widget:Initialize()
	InitGUI()
	ChangeTimelineFrame(0)
end

-----------------------
-- /Callins && Crap
-----------------------
