--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  file:    gui_ally_res.lua
--  brief:   Shows your allies resources and allows quick resource transfer
--  author:  Owen Martindell
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:GetInfo()
  return {
    name      = "Ally Resource Bars",
    desc      = "Shows your allies resources and allows quick resource transfer",
    author    = "Floris (org by: TheFatController)",
    date      = "27 february 2015",
    license   = "MIT/x11",
    layer     = -9, 
    enabled   = true  --  loaded by default?
  }
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local TOOL_TIPS = true
local showSelf	= true
local selfXoffset = -3
local selfOpacity = 1
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local GetTeamResources = Spring.GetTeamResources
local GetMyTeamID = Spring.GetMyTeamID
local GetMouseState = Spring.GetMouseState
local GetSpectatingState = Spring.GetSpectatingState
local IsReplay = Spring.IsReplay
local IsGUIHidden = Spring.IsGUIHidden
local ShareResources = Spring.ShareResources
local GetGameFrame = Spring.GetGameFrame
local GetTeamList = Spring.GetTeamList
local GetMyAllyTeamID = Spring.GetMyAllyTeamID
local mathMin = math.min
local gl, GL = gl, GL
local sF = string.format
local GetPlayerInfo = Spring.GetPlayerInfo

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local imageDirectory		= ":n:"..LUAUI_DIRNAME.."images/allyres/"
local teamPic				= imageDirectory.."team.png"
local teamHighlightPic		= imageDirectory.."highlight.png"
local barBg					= imageDirectory.."barbg.png"
local bar					= imageDirectory.."bar.png"
local bgcorner				= imageDirectory.."bgcorner8.png"
local currentBg				= imageDirectory.."currentbg.png"
local bgcornerSize			= 8
local extraCrossSize		= 1

local displayList
local staticList
local viewSizeX, viewSizeY = 0,0
local BAR_HEIGHT       = 4
local BAR_SPACER       = 3
local BAR_WIDTH        = 70
local BAR_GAP          = 12
local BAR_MARGIN       = 4
local TOTAL_BAR_HEIGHT = (BAR_SPACER + BAR_HEIGHT + BAR_HEIGHT)
local TOP_HEIGHT       = (BAR_GAP)
local BAR_OFFSET       = (TOP_HEIGHT + BAR_SPACER + BAR_GAP)
local START_HEIGHT     = (TOTAL_BAR_HEIGHT + BAR_GAP + TOP_HEIGHT)
local FULL_BAR         = (BAR_WIDTH + BAR_GAP + BAR_GAP + BAR_SPACER)
local w                = (BAR_WIDTH + BAR_OFFSET + BAR_GAP)
local h                = START_HEIGHT
local x1,y1
local mx, my
local sentSomething = false
local enabled       = false
local transferring  = false
local transferTeam
local transferType
local teamList   = {}
local teamRes    = {}
local teamColors = {}
local teamIcons  = {}
local deadTeams  = {}
local sendEnergy = {}
local sendMetal  = {}
local trnsEnergy = {}
local trnsMetal  = {}
local labelText  = {}
local sentEnergy = 0
local sentMetal  = 0
local gameFrame  = 0
local lastFrame  = -1
local prevHeight = nil
local myID
local posLoaded = false

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local function getTeamNames()
  local teamNames = {}
  local playerList = Spring.GetPlayerList()
  for _,playerID in ipairs(playerList) do
    local name,_,spec,teamID = Spring.GetPlayerInfo(playerID)
    if not spec then
      if name and teamID then
        teamNames[teamID] = name
      end
    end
  end
  return teamNames
end

function widget:Initialize()
  viewSizeX, viewSizeY = gl.GetViewSizes()
  if not posLoaded then
    x1 = (viewSizeX - w)
    y1 = (viewSizeY * 0.65)
  end
  myID = GetMyTeamID()
end

function widget:Shutdown()
  gl.DeleteList(displayList)
	if (WG['guishader_api'] ~= nil) then
		WG['guishader_api'].RemoveRect('allyres')
	end
end

local function setUpTeam()
  teamList = {}
  teamRes = {}
  teamColors = {}
  myID = GetMyTeamID()
  local getTeams = GetTeamList(GetMyAllyTeamID())
  mx, my = 0,0
  local teamCount = 0
  for _,teamID in ipairs(getTeams) do
    if teamID ~= myID or showSelf then
      local eCur = GetTeamResources(teamID, "energy")
      if eCur and (not deadTeams[teamID]) then
        teamCount = teamCount + 1
        teamList[teamCount] = teamID
      end
    end
  end
  for key,teamID in ipairs(teamList) do
    local r,g,b = Spring.GetTeamColor(teamID)
    teamColors[teamID] = {r=r,g=g,b=b}
  end
  if (teamCount > 0) then
    enabled = true
    return true
  else
    enabled = false
    return false
  end
end

local function updateStatics()
  if (staticList) then gl.DeleteList(staticList) end
  staticList = gl.CreateList( function()
	gl.PushMatrix()
    gl.Color(0.0, 0.0, 0.0, 0.5)
    
    gl.Rect(x1-BAR_MARGIN-bgcornerSize+BAR_GAP, y1-BAR_MARGIN+BAR_GAP, x1+w+BAR_MARGIN+bgcornerSize-BAR_GAP, y1+h+BAR_MARGIN-BAR_GAP)
    gl.Rect(x1-BAR_MARGIN+BAR_GAP, y1-BAR_MARGIN-bgcornerSize+BAR_GAP, x1+w+BAR_MARGIN-BAR_GAP, y1-BAR_MARGIN+BAR_GAP)
    gl.Rect(x1-BAR_MARGIN+BAR_GAP, y1+h+BAR_MARGIN+bgcornerSize-BAR_GAP, x1+w+BAR_MARGIN-BAR_GAP, y1+h+BAR_MARGIN-BAR_GAP)
    
    gl.Color(0.0, 0.0, 0.0, 0.5)
    --gl.Shape(GL.LINE_LOOP, {
    --  { v = { x1 + 0.5 - BAR_MARGIN, y1 + 0.5 - BAR_MARGIN }, t = { 0, 1 } },
    --  { v = { x1+w + 0.5 + BAR_MARGIN, y1 + 0.5 - BAR_MARGIN }, t = { 1, 1 } },
    --  { v = { x1+w + 0.5 + BAR_MARGIN, y1+h + 0.5 + BAR_MARGIN }, t = { 1, 0 } },
    --  { v = { x1 + 0.5 - BAR_MARGIN, y1+h + 0.5 + BAR_MARGIN }, t = { 0, 0 } },
    --})
    
	gl.Texture(bgcorner)
	gl.TexRect(x1-BAR_MARGIN+BAR_GAP-bgcornerSize, y1+h+BAR_MARGIN-BAR_GAP, x1-BAR_MARGIN+BAR_GAP, y1+h+BAR_MARGIN-BAR_GAP+bgcornerSize)		-- top left
	gl.TexRect(x1+w+BAR_MARGIN-BAR_GAP+bgcornerSize, y1+h+BAR_MARGIN-BAR_GAP, x1+w+BAR_MARGIN-BAR_GAP, y1+h+BAR_MARGIN-BAR_GAP+bgcornerSize)	-- top right
	gl.TexRect(x1-BAR_MARGIN+BAR_GAP-bgcornerSize, y1-BAR_MARGIN+BAR_GAP, x1-BAR_MARGIN+BAR_GAP, y1-BAR_MARGIN+BAR_GAP-bgcornerSize)			-- bottom left
	gl.TexRect(x1+w+BAR_MARGIN-BAR_GAP+bgcornerSize, y1-BAR_MARGIN+BAR_GAP, x1+w+BAR_MARGIN-BAR_GAP, y1-BAR_MARGIN+BAR_GAP-bgcornerSize)		-- bottom right
	gl.Texture(false)
    
    local height = h - TOP_HEIGHT
    local teamNames = getTeamNames()
    teamIcons = {}
    
    for key,teamID in ipairs(teamList) do
      if (teamID ~= myID or showSelf) then
		local _,active = GetPlayerInfo(teamID) 
		local xOffset = 0
		local opacityMultiplier = 1
		if showSelf then
			if (teamID == myID ) then 
				xOffset = xOffset + selfXoffset
				opacityMultiplier = selfOpacity
				gl.Color(1,1,1,0.12)
				gl.Texture(currentBg)
				gl.TexRect(x1-BAR_MARGIN-(bgcornerSize/2)+BAR_GAP,y1+height+(TOTAL_BAR_HEIGHT/1.66), x1+w+BAR_MARGIN+(bgcornerSize/2)-BAR_GAP, y1+height-(TOTAL_BAR_HEIGHT*1.7))
				gl.Texture(false)
			else
				xOffset = xOffset - selfXoffset
			end
		end
		local extraSize = 0
		if not active and gameFrame > 0 then
			opacityMultiplier = 0.33
			extraSize = -3
		end
        gl.Color(teamColors[teamID].r,teamColors[teamID].g,teamColors[teamID].b,1*opacityMultiplier)
		--gl.Rect(x1+BAR_GAP,y1+height,x1+TOP_HEIGHT+BAR_GAP,y1+height-TOTAL_BAR_HEIGHT)
		gl.Texture(teamPic)
		gl.TexRect(x1+BAR_GAP+xOffset-extraSize, y1+height+extraSize, x1+TOP_HEIGHT+BAR_GAP+xOffset+extraSize, y1+height-TOTAL_BAR_HEIGHT-extraSize)
		gl.Texture(false)
        gl.Color(1,1,1,0.4*opacityMultiplier)
		gl.Texture(teamHighlightPic)
		gl.TexRect(x1+BAR_GAP+xOffset-extraSize, y1+height+extraSize, x1+TOP_HEIGHT+BAR_GAP+xOffset+extraSize, y1+height-TOTAL_BAR_HEIGHT-extraSize)
		gl.Texture(false)
		
		
        teamIcons[teamID] = 
        {
         name = teamNames[teamID] or "No Player",
         iy1 = y1+height,
         iy2 = y1+height-TOTAL_BAR_HEIGHT,
        }
        height = (height - TOTAL_BAR_HEIGHT - BAR_GAP)
      end
    end
    gl.PopMatrix()
  end)
end


local function updateBars()
  if (myID ~= GetMyTeamID()) then
    if setUpTeam() then
      updateStatics()
      updateBars()
    end
    return false 
  end
  local eCur, eMax, mCur, mMax
  local height = h - TOP_HEIGHT
  for key,teamID in ipairs(teamList) do
    if (teamID ~= myID or showSelf) then
      eCur, eMax = GetTeamResources(teamID, "energy")
      mCur, mMax = GetTeamResources(teamID, "metal")
      eCur = eCur + (sendEnergy[teamID] or 0)
      mCur = mCur + (sendMetal[teamID] or 0)
      
		
      local xoffset = (x1+BAR_OFFSET)
	  local opacityMultiplier = 1
      if showSelf then
		if (teamID == myID ) then 
			xoffset = xoffset + selfXoffset
			opacityMultiplier = selfOpacity
		else
			xoffset = xoffset - selfXoffset
		end
	  end
      teamRes[teamID] = 
      {
        ex1  = xoffset,       
        ey1  = y1+height,
        ex2  = xoffset+BAR_WIDTH,
        ex2b = xoffset+(BAR_WIDTH * (eCur / eMax)),
        ey2  = y1+height-BAR_HEIGHT,
        mx1  = xoffset,
        my1  = y1+height-BAR_HEIGHT-BAR_SPACER,
        mx2  = xoffset+BAR_WIDTH,
        mx2b = xoffset+(BAR_WIDTH * (mCur / mMax)),
        my2  = y1+height-TOTAL_BAR_HEIGHT,
        om   = opacityMultiplier,
      }
      if (teamID == transferTeam) then
        if (transferType == "energy") then
          teamRes[teamID].eRec = true
        else
          teamRes[teamID].mRec = true
        end
      end
      height = (height - TOTAL_BAR_HEIGHT - BAR_GAP)
    end
  end
  if (height ~= 0) then
    h = (h - height)
    if prevHeight then
      y1 = y1 - (h-prevHeight)
      prevHeight = nil
    else
      y1 = (y1 + height)
    end
    updateStatics()
  end
  if (displayList) then gl.DeleteList(displayList) end
  displayList = gl.CreateList( function()
	gl.PushMatrix()
    for _,d in pairs(teamRes) do
      if d.eRec then
        gl.Color(0.8, 0, 0, 0.8*d.om)
      else
        gl.Color(0.8, 0.8, 0, 0.2*d.om)
      end
		--gl.Rect(d.ex1,d.ey1,d.ex2,d.ey2)
		gl.Texture(barBg)
		gl.TexRect(d.ex1,d.ey1,d.ex2,d.ey2)
		gl.Texture(false)
      gl.Color(1, 1, 0, 1*d.om)
      --gl.Rect(d.ex1,d.ey1,d.ex2b,d.ey2) 
		gl.Texture(bar)
		gl.TexRect(d.ex1,d.ey1,d.ex2b,d.ey2)
		gl.Texture(false)
      if d.mRec then
        gl.Color(0.8, 0, 0, 0.8*d.om)
      else
        gl.Color(0.8, 0.8, 0.8, 0.2*d.om)
      end
      --gl.Rect(d.mx1,d.my1,d.mx2,d.my2)
		gl.Texture(barBg)
		gl.TexRect(d.mx1,d.my1,d.mx2,d.my2)
		gl.Texture(false)
      gl.Color(1, 1, 1, 1*d.om)
      --gl.Rect(d.mx1,d.my1,d.mx2b,d.my2)
		gl.Texture(bar)
		gl.TexRect(d.mx1,d.my1,d.mx2b,d.my2)
		gl.Texture(false)
    end
    gl.PopMatrix()
  end)
  if (WG['guishader_api'] ~= nil) then
	WG['guishader_api'].InsertRect(x1+BAR_GAP-BAR_MARGIN-(bgcornerSize*0.75),y1+BAR_GAP-BAR_MARGIN-(bgcornerSize*0.75),x1+w-BAR_GAP+BAR_MARGIN+(bgcornerSize*0.75),y1+h-BAR_GAP+BAR_MARGIN+(bgcornerSize*0.75),'allyres')
  end
end

function widget:TeamDied(teamID)
  deadTeams[teamID] = true
  if setUpTeam() then
    updateStatics()
    updateBars()
  end
end

function widget:UnitCreated(unitID, unitDefID, unitTeam)
  if deadTeams[unitTeam] then
    deadTeams[unitTeam] = nil
    if setUpTeam() then
      updateStatics()
      updateBars()
    end
  end
end

local function transferResources(n)
  local sCur, sMax = GetTeamResources(transferTeam, transferType)
  local lCur, _, _, lInc, _, _, _, lRec = GetTeamResources(myID, transferType)
  if (transferType == "metal") then 
    lCur = (lCur - sentMetal)
    sCur = sCur + (sendMetal[transferTeam] or 0)
  else
    lCur = (lCur - sentEnergy)
    sCur = sCur + (sendEnergy[transferTeam] or 0)
  end
  local send = mathMin(mathMin((sMax-sCur),((lInc+lRec)*0.2)),lCur)
  if (send > 0) then
    if (transferType == "energy") then
      if sendEnergy[transferTeam] then
        sendEnergy[transferTeam] = (sendEnergy[transferTeam] + send)
      else
        sendEnergy[transferTeam] = send
        sentSomething = true
      end
      sentEnergy = (sentEnergy + send)
      trnsEnergy[transferTeam] = (send * 30)
    else
      if sendMetal[transferTeam] then
        sendMetal[transferTeam] = (sendMetal[transferTeam] + send)
      else
        sendMetal[transferTeam] = send
        sentSomething = true
      end
      sentMetal = (sentMetal + send)
      trnsMetal[transferTeam] = (send * 30)
    end
  end
end

function widget:GameFrame(n)
	gameFrame = n
end

function widget:Update()
  if (gameFrame ~= lastFrame) then
    if enabled then
	  lastFrame = gameFrame
	  updateBars()
	  if transferTeam then
	    transferResources(gameFrame)
	  end
	  if sentSomething and ((gameFrame % 16) == 0) then
	    for teamID,send in pairs(sendEnergy) do
		  ShareResources(teamID,"energy",send)
	    end
	    for teamID,send in pairs(sendMetal) do
	      ShareResources(teamID,"metal",send)
	    end
	    sendEnergy = {}
	    sendMetal = {}
	    trnsEnergy = {}
	    trnsMetal = {}
	    sentEnergy = 0
	    sentMetal = 0 
	    sentSomething = false
	  end
	  if TOOL_TIPS then
	    local x, y = GetMouseState()
	    if (mx ~= x) or (my ~= y) or transferring or ((gameFrame % 15) == 0) then
		  mx = x
		  my = y
		  if (x > x1 + BAR_GAP) and (y > y1 + BAR_GAP) and (x < (x1 + FULL_BAR)) and (y < (y1 + h - TOP_HEIGHT)) then
		    for teamID,defs in pairs(teamIcons) do
			  if (y < defs.iy1) and (y >= defs.iy2) then
			    local _, _, _, eInc, _, _, _, eRec = GetTeamResources(teamID, "energy")
			    local _, _, _, mInc, _, _, _, mRec = GetTeamResources(teamID, "metal")   
			    eRec = eRec + (trnsEnergy[teamID] or 0)
			    mRec = mRec + (trnsMetal[teamID] or 0)      
			    labelText[1] = 
			    {
				  label=defs.name,
				  x=x1-BAR_SPACER-BAR_MARGIN,
				  y=defs.iy1-BAR_SPACER,
				  size=TOTAL_BAR_HEIGHT*1.4,
				  config="orn",
			    }
			    labelText[2] = 
			    {
				  label="(E: +"..sF("%.1f",eInc+eRec) ..", M: +"..sF("%.2f",mInc+mRec)..")", 
				  x=x1-BAR_SPACER-BAR_MARGIN, 
				  y=defs.iy1-BAR_SPACER-(TOTAL_BAR_HEIGHT*1.5), 
				  size=TOTAL_BAR_HEIGHT*1.2, 
				  config="orn",
			    }
			    return
			  end
		    end
		    if (labelText) then labelText = {} end
		  elseif (labelText) then labelText = {} end
	    end
	  end
    elseif (#GetTeamList(GetMyAllyTeamID()) > 1) then
	  setUpTeam()
	  updateStatics()
	  updateBars()
    end
  end
end

function widget:GameStart()
  enabled = true
  setUpTeam()
  updateStatics()
end 

function widget:DrawScreen()
  if enabled and (not IsGUIHidden()) then
      gl.CallList(staticList)
      gl.CallList(displayList)
      if (labelText[1]) then
        gl.PushMatrix()
        gl.Color(1, 1, 1, 0.8)
        gl.Text(labelText[1].label,labelText[1].x,labelText[1].y,labelText[1].size,labelText[1].config)
        gl.Color(0.8, 0.8, 0.8, 0.8)
        gl.Text(labelText[2].label,labelText[2].x,labelText[2].y,labelText[2].size,labelText[2].config)
        
        gl.PopMatrix()
      end
  end
end

function widget:MouseMove(x, y, dx, dy, button)
  if (enabled) then
    if moving then
      x1 = x1 + dx
      y1 = y1 + dy
      if (x1 < BAR_MARGIN) then x1 = BAR_MARGIN elseif ((x1+w+BAR_MARGIN) > viewSizeX) then x1 = (viewSizeX-w-BAR_MARGIN) end
      if (y1 < BAR_MARGIN) then y1 = BAR_MARGIN elseif ((y1+h+BAR_MARGIN) > viewSizeY) then y1 = (viewSizeY-h-BAR_MARGIN) end
      updateBars()
      updateStatics()
    elseif transferring then
      transferTeam = nil
      if (x > (x1+BAR_OFFSET)) and (x < (x1+BAR_OFFSET+BAR_WIDTH)) then
        if (transferType == "energy") then
          for teamID,defs in pairs(teamRes) do
            if (y < defs.ey1) and (y > defs.ey2) then
              transferTeam = teamID
              return
            end
          end
        else
          for teamID,defs in pairs(teamRes) do
            if (y < defs.my1) and (y > defs.my2) then
              transferTeam = teamID
              return
            end
          end
        end
      end      
    end
  end
end

function widget:MousePress(x, y, button)
  if (enabled) and ((x > x1 - BAR_MARGIN-bgcornerSize+BAR_GAP) and (y > y1 - BAR_MARGIN-bgcornerSize+BAR_GAP) and (x < (x1 + w + BAR_MARGIN+bgcornerSize-BAR_GAP)) and (y < (y1 + h + BAR_MARGIN+bgcornerSize-BAR_GAP))) then
    if (button == 2) or (y > (y1 + h - TOP_HEIGHT)) then
      capture = true
      moving  = true
      return capture
    end
    if GetSpectatingState() or IsReplay() then
      return false
    end
    if (x > (x1+BAR_OFFSET)) and (x < (x1+BAR_OFFSET+BAR_WIDTH)) then
      for teamID,defs in pairs(teamRes) do
        if (y < defs.ey1) and (y >= defs.ey2) then
          transferTeam = teamID
          transferType = "energy"
          transferring = true
          return true
        elseif (y < defs.my1) and (y >= defs.my2) then
          transferTeam = teamID
          transferType = "metal"
          transferring = true
          return true
        end
      end
    end
  end
  return false
end

function widget:MouseRelease(x, y, button)
  capture = nil
  moving  = nil
  transferring = false
  transferTeam = nil
  return capture
end

function widget:ViewResize(vsx, vsy)
  viewSizeX, viewSizeY = vsx, vsy
  if (x1 < 0) then x1 = 0 elseif ((x1+w) > viewSizeX) then x1 = (viewSizeX-w) end
  if (y1 < 0) then y1 = 0 elseif ((y1+h) > viewSizeY) then y1 = (viewSizeY-h) end
  updateBars()
  updateStatics()
end

function widget:GetConfigData() --save config
  return {x1=x1, y1=y1, h=h}
end

function widget:SetConfigData(data) --load config
  if (data.x1) and (data.y1) and (data.h) then
    x1 = data.x1
    y1 = data.y1
    prevHeight = data.h
    posLoaded = true
  end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
