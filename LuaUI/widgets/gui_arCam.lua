--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

if not (Spring.GetConfigInt("LuaSocketEnabled", 0) == 1) then
	Spring.Echo("LuaSocketEnabled is configurationally challenged")
	return false
end

function widget:GetInfo()
	return {
		name = "Spring Augmented Reality Plugin",
		desc = "Allows to view the Spring-Engine via Cardbord AR on your phone",
		author = "PicassoCT",
		version = "2.0",
		date = "YearOfTheGNU on a to hot morning between Dubai and Shanghai",
		license = "GNU GPL, v2 or later",
		layer = math.huge,
		hidden = false,
		handler = true,
		enabled = true -- loaded by default?
	}
end
-- ARDevice --> Broadcast 
-- Host --> Broadcast his IP
-- ARDevice --> Send CFG to HostIP
-- HostWaits for Matrice DATA

local Chili, Screen0
local socket = socket
local message =""

local recieveBroadcastHeader = "SPRINGAR;BROADCAST;ARDEVICE"	
local recieveResetHeader = "SPRINGAR;RESET;"	
local recievedCFGHeader = "SPRINGAR;CFG;"						
local recievedMSGHeader = "SPRINGAR;DATA;MATRICE="	
local nextStateToGo = recieveBroadcastHeader		
local sendMSGHeader 	= "SPRINGAR;DATA;"					
local sendHostmessage = "SPRINGAR;REPLY;HOSTIP="

local broadcast
local udp
local BroadcastIpAddress = '*'
local BroadcastSendFromAdress = "255.255.255.255"
local ARDeviceIpAddress = ""
local hostIPAddress = "192.168.178.20"
local TIME_FRAME_IN_MS = 30 
local BR_port = 9000 
local UDP_port = 8090 -- ASCII for SP

local watchdogGameFrame= Spring.GetGameFrame()
local TIMEOUT_WATCHDOG = 30 * 20 --seconds

local boolInitialisationComplete = false
local fileBufferDesc = {} 
fileName= "ARBuffer"
fileBufferDesc[1] = {
	filePathName = "luaui/ar/"..fileName.."1"..".png",
	boolActive = false,	-- is currently a socket writing from this buffer?
	boolNotValid = false	-- is currently a write Process activ on this buffer?
	
}
fileBufferDesc[2] = {
	filePathName = "luaui/ar/"..fileName.."2"..".png",
	boolActive = false,	-- is currently a socket writing from this buffer?
	boolNotValid = false	-- is currently a write Process activ on this buffer?
	
}

------------------------------ String Tools ------------------------------------

-->splits a string with seperators into a table of substrings
function split(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end
--> serializes a whole table to string
function tableToString(tab)
	PostFix = "}"
	PreFix = "{"
	conCat=""..PreFix
	for key, value in pairs(tab) do
		conCat= conCat.."["..toString(key).."] ="..toString(value)..","
	end
	
	return conCat..PostFix
end

--> converts a non-stringElement to String
function toString(element)
	typeE = type(element)
	
	if typeE == "boolean" then
		if element == true then 
			return "true"
		else 
			return "false"
		end 
	end
	if typeE == "number" then return ""..element end
	if typeE == "string" then return element end
	if typeE == "table" then return tableToString(element) end
end

-->removes whitespacecharacters from a string
function trim(s)
	return s:match'^()%s*$' and '' or s:match'^%s*(.*%S)'
end

--> Echos the spring connection related settings out
local function dumpConfig()
	-- dump all luasocket related config settings to console
	for _, conf in ipairs({"TCPAllowConnect", "TCPAllowListen", "UDPAllowConnect", "UDPAllowListen" }) do
		Spring.Echo(conf .. " = " .. Spring.GetConfigString(conf, ""))
	end
end

--------------------- Data Transfer Logic for Buffer---------------------------

local deviceData={
	deviceName = 	'S8',
	viewWidth = 	60,
	viewHeigth = 	70,
	seperator = 	30
}

local tex = gl.CreateTexture(deviceData.viewWidth, deviceData.viewHeigth, {fbo=true}); 

function getActiveBuffer()
	if fileBufferDesc[1].boolActive == true then return fileBufferDesc[1], 1 end
	
	return fileBufferDesc[2], 2
end

function getWriteableBuffer()
	if fileBufferDesc[1].boolNotValid == true then return fileBufferDesc[1], 1 end
	
	return fileBufferDesc[2], 2
end

--> Handled by writing function once done- waiting for the sendeSemaphore to drop
function switchWriteBuffer()
	Spring.Echo("function switchWriteBuffer()")
	_, activeBufferNr = getActiveBuffer()
	_, writeBufferNr = getWriteableBuffer()
	while boolSendDataSemaphore == true do
		Sleep(1)
	end
	fileBufferDesc[activeBufferNr].boolActive = false
	fileBufferDesc[activeBufferNr].boolNotValid = true
	
	fileBufferDesc[writeBufferNr].boolActive = true
	fileBufferDesc[writeBufferNr].boolNotValid = false
end

boolDataInBufferValid = false
local coWriteBuffer

--> Drops a screenshot to file in a coroutine
function copyFrameToBuffer()
	Spring.Echo("function copyFrameToBuffer()")
	if not coWriteBuffer or coroutine.status(coWriteBuffer) == "dead" then
		-- socket is writeable
		
		coWriteBuffer=		coroutine.create(function()
			gl.CopyToTexture(tex, 0, 0, 0, 0, deviceData.viewWidth, deviceData.viewHeigth);
			gl.RenderToTexture(	tex, 
			gl.SaveImage,
			0,
			0,
			deviceData.viewWidth,
			deviceData.viewHeigth, 
			getWriteableBuffer().filePathName);
			
			switchWriteBuffer()										
		end
		)
		coroutine.resume(coWriteBuffer)
		
		
	end
end
--------------------------------------------------------------------------------

-->Creates and returns an unconnected UDP object. Unconnected objects support the sendto, 
-- receive, receivefrom, getsockname, setoption, settimeout, setpeername, setsockname, and close. 
-- The setpeername is used to connect the object.
function BroadcastConnect()
			Spring.Echo(" Broadcast SocketConnect("..BroadcastIpAddress..",".. BR_port..")")
			
			broadcast=socket.udp()
			assert(broadcast:settimeout(0))
			assert(broadcast:setoption('broadcast', true))
			--assert(broadcast:setoption('dontroute', true))
			success, errmsg =	broadcast:setsockname(BroadcastIpAddress, BR_port)
			if not success then Spring.Echo(errmsg) end
			
end

--> opens a udpsocket
function UDPConnect(ip, peername, peerport)
			Spring.Echo(" UDPSocketConnect("..ip..",".. UDP_port..")")
			if not udp then
				udp=socket.udp()
				assert(udp:settimeout(0))
				success, errmsg = udp:setsockname(ip, UDP_port)
				assert(success, errmsg)
				
				if peername then -- changes a unconnected udp port into a connected udp-port
					assert(udp:setpeername(peername, UDP_port))
				end
			end

end

function sendMessage(socket, ip, port, data)
	assert(type(ip) == "string")
	assert(type(port) == "string" or type(port) == "number")
	assert(type(data) == "string")
	Spring.Echo("Send message " .. data .. " to " .. ip)
	if socket then
		local success, e_msg = socket:sendto(data, ip, port)
		if not success then
			Spring.Echo("Failed to send message " .. data .. " to " ..ip.." with error "..e_msg)
		end
	end
	return success, e_msg
end

function widget:Shutdown()
	if udp then udp:close() end
	if broadcast then broadcast:close() end
end
function widget:Initialize()	
	Spring.Echo("function widget:Initialize()")

	fileBufferDesc[1].boolNotValid = false
	fileBufferDesc[1].Active = true
	
	BroadcastConnect()	
	nextStateToGo = recieveResetHeader

end


local coSendData 
boolSendDataSemaphore = false
-- called when data can be written to a socket
local function transferDataToARDevice(ip)
	
	-- load image
	Spring.Echo("Sending test data to "..ARDeviceIpAddress)
	--sendMessage(udp, ARDeviceIpAddress, UDP_port, "Test")
	 
	if nextStateToGo == recievedMSGHeader then		
		
		if not coSendData or coroutine.status(coSendData) == "dead" then
			-- socket is writeable
			
			coSendData=		coroutine.create(function()
				--TODO Split into 8192 byte sized packages
				boolSendDataSemaphore = true
				local success, e_msg = udp:sendto(VFS.LoadFile(getActiveBuffer().filePathName), ARDeviceIpAddress, UDP_port)
				if not success then
					Spring.Echo("transferDataToARDevice"..e_msg)
				end
				boolSendDataSemaphore = false
			end
			)
			if  boolSendDataSemaphore == false then
				coroutine.resume(coSendData)
			end
		end
	end
end

function whoWatchesTheWatchdog(boolNewData)
	if nextStateToGo == recievedMSGHeader then
		if watchdogGameFrame - Spring.GetGameFrame() > TIMEOUT_WATCHDOG then
			nextStateToGo =recieveResetHeader
			watchdogGameFrame = Spring.GetGameFrame()
		end
		
		if boolNewData == true then 
			watchdogGameFrame = Spring.GetGameFrame()
		end
	end
end

function RecieveConfigureARCameraMessage(configStr)
	Spring.Echo("RecieveConfigureARCameraMessage:"..configStr)
	configStr= configStr:gsub(recievedCFGHeader,"")
	arrayOfTokens = split(configStr,";")
	Spring.Echo(arrayOfTokens)
	if arrayOfTokens[5] then
		deviceData.deviceName = arrayOfTokens[1]:gsub("MODEL","") or "No model Name recieved"
		displayWidth= arrayOfTokens[2]:gsub("DISPLAYWIDTH=","")
		
		deviceData.viewWidth = tonumber(displayWidth)
		displayHeigth = arrayOfTokens[3]:gsub("DISPLAYHEIGTH=","")
		
		deviceData.viewHeigth = tonumber(displayHeigth)
		displayRatio = arrayOfTokens[4]:gsub("DISPLAYDIVIDE=","") 
		
		deviceData.seperator = math.min(100,math.max(1,tonumber(displayRatio)		or 50))
		ARDeviceIpAddress = arrayOfTokens[5]:gsub("IPADDRESS=","") 
		
		Spring.Echo(deviceData.viewWidth,deviceData.viewHeigth)
		tex = gl.CreateTexture(deviceData.viewWidth, deviceData.viewHeigth, {fbo=true}); 
		return true
	end
	return false
end

old_mat4_4 ={}

function setCamMatriceFromMessage(recievedData)
	Spring.Echo("function setCamMatriceFromMessage("..recievedData..")")
	if recievedData then
		recievedData=recievedData:gsub(recievedMSGHeader,'')
		mat4_4 = split(recievedData, ";")
		boolCompleteCamMatrix= false
		for i=1, 16 do
			mat4_4[i] = tonumber(mat4_4[i])
			if i== 16 then boolCompleteCamMatrix= true ; end	
		end
		
		if boolCompleteCamMatrix == true then
			old_mat4_4=mat4_4
		end
		Spring.SetCameraTarget(old_mat4_4[1],old_mat4_4[2],old_mat4_4[3])
		Spring.SetCameraOffset(old_mat4_4[4],old_mat4_4[5],old_mat4_4[6])
	end
end



function GetResetARCameraMessage()
	return "SPRINGAR;RESET_COMPLETE;"
end
function limitIncIP(ip)
	if ip +1 == 255 then return ip -1 end
	
	return ip +1
end

function widget:Update()
	Spring.Echo("Current state:"..nextStateToGo)

		data, ip, port = broadcast:receivefrom()
		
		if data and ip then Spring.Echo("Recieved text " .. data .. " from " ..ip) end
		if data and data:find(recieveResetHeader) then
			nextStateToGo = recieveResetHeader
		end	
		
		communicationStateMachine[nextStateToGo](data,ip,port)

		whoWatchesTheWatchdog( data ~= nil)
	
	
	if nextStateToGo == recievedMSGHeader then
		--upate only on completed transfer
		if boolSendDataSemaphore == false then
			copyFrameToBuffer()
		end
		transferDataToARDevice(ARDeviceIpAddress)
	end
end

timeOutInFrame= 0
--> Simple Statemachine in Table
communicationStateMachine= 
{
	[recieveBroadcastHeader] = function (data, ip, port)
		if data and data:find(recieveBroadcastHeader) then
			Spring.Echo("recieveBroadcastHeader:"..data.." from "..ip)
			ARDeviceIpAddress = ip
			
			Spring.Echo("sendHostmessage "..sendHostmessage..hostIPAddress.." -> "..ARDeviceIpAddress..":"..BR_port)
			sendMessage(broadcast, ARDeviceIpAddress, BR_port, sendHostmessage..hostIPAddress)					
			UDPConnect("192.168.178.20") --hostIPAddress
			nextStateToGo = recievedCFGHeader 
		end
	end,				
	[recievedCFGHeader]= function (data, ip, port)
		timeOutInFrame= timeOutInFrame-1
		if data and data:find(recievedCFGHeader) then
			if RecieveConfigureARCameraMessage(data) == true then		
				nextStateToGo = recievedMSGHeader 
			end
		end		
	end,	
	[recievedMSGHeader] = function (data, ip, port)
	
		if data then
			setCamMatriceFromMessage(data)
		end
	end,
	[recieveResetHeader] = function (data, ip, port)
		
		local success, e_msg = sendMessage(broadcast, BroadcastSendFromAdress, BR_port, GetResetARCameraMessage())
		if success then
			nextStateToGo = recieveBroadcastHeader 	
		end		
	end,
}