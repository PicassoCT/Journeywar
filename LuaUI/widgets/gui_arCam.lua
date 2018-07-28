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

local Chili, Screen0
local socket = socket
local message =""

local recieveBroadcastHeader = "SPRINGAR;BROADCAST;IPADDRRESS="	
local recieveResetHeader = "SPRINGAR;RESET;"	
local recievedCFGHeader = "SPRINGAR;CFG;"						
local recievedMSGHeader = "SPRINGAR;DATA;MATRICE="	
local nextStateToGo = recieveBroadcastHeader		
local sendMSGHeader 	= "SPRINGAR;DATA;"					

local broadcast
local udp
local BroadcastIpAddress = '*'
local ARDeviceIpAddress = ""
local hostIPAddress = "192.168.178.179"
local TIME_FRAME_IN_MS = 30 
local BR_port = 8090 
local UDP_port = 8090 -- ASCII for SP
local SP_port = 8090
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

-->Generic to String Serialization/ Tools
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

function trim(s)
	return s:match'^()%s*$' and '' or s:match'^%s*(.*%S)'
end

function tableToString(tab)
	PostFix = "}"
	PreFix = "{"
	conCat=""..PreFix
	for key, value in pairs(tab) do
		conCat= conCat.."["..toString(key).."] ="..toString(value)..","
	end
	
	return conCat..PostFix
end

-- Debugfunctions
local function dumpConfig()
	-- dump all luasocket related config settings to console
	for _, conf in ipairs({"TCPAllowConnect", "TCPAllowListen", "UDPAllowConnect", "UDPAllowListen" }) do
		Spring.Echo(conf .. " = " .. Spring.GetConfigString(conf, ""))
	end
end




--------------------- Data Transfer Logic for Buffer---------------------------

function getActiveBuffer()
	if fileBufferDesc[1].boolActive == true then return fileBufferDesc[1], 1 end
	
	return fileBufferDesc[2], 2
end

function getWriteableBuffer()
	if fileBufferDesc[1].boolNotValid == true then return fileBufferDesc[1], 1 end
	
	return fileBufferDesc[2], 2
end

--------------------------------------------------------------------------------

local deviceData={
	deviceName = 	'S8',
	viewWidth = 	60,
	viewHeigth = 	70,
	seperator = 	30
}
local tex = gl.CreateTexture(deviceData.viewWidth, deviceData.viewHeigth, {fbo=true}); 

--Handled by writing function once done- waiting for the sendeSemaphore to drop
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


function widget:Initialize()	
	Spring.Echo("function widget:Initialize()")
	
	-- load Logo into Buffer and set first Buffer active
	--TODO
	fileBufferDesc[1].boolNotValid = false
	fileBufferDesc[1].Active = true
	nextStateToGo = recieveBroadcastHeader
	BroadcastConnect(BroadcastIpAddress)
	
end


-- initiates a connection to host:port, returns true on success

function BroadcastConnect(ip)
			Spring.Echo("local function SocketConnect("..ip..",".. BR_port..")")

			broadcast=socket.udp()
			broadcast:settimeout(0)
			broadcast:setsockname(ip, BR_port)
			assert(broadcast:setoption('broadcast', true))
end
function BroadcastClose()
	broadcast:close()
end
function UDPClose()
	udp:close()

end
function UDPConnect(ip)
			Spring.Echo("local function UDPSocketConnect("..ip..",".. UDP_port..")")
				
			udp=socket.udp()
			udp:settimeout(0)
			udp:setsockname(ip, UDP_port)

end

local coSendData 
boolSendDataSemaphore = false
-- called when data can be written to a socket
local function SocketWriteAble(ip)
	
	-- load image
	udp:sendto( "Testdatatransfer ", ARDeviceIpAddress, SP_port)
	if nextStateToGo == recievedMSGHeader then
		Spring.Echo("sending ar image to cellphone")
		
		if not coSendData or coroutine.status(coSendData) == "dead" then
			-- socket is writeable
			
			coSendData=		coroutine.create(function()
				boolSendDataSemaphore = true
				local success, e_msg = udp:sendto(VFS.LoadFile(getActiveBuffer().filePathName), ARDeviceIpAddress, SP_port)
				if not success then
					Spring.Echo("SocketWriteAble"..e_msg)
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

function widget:Update()
	Spring.Echo("Update Waits for:"..nextStateToGo)
	

	--local s, status, partial = input:receive('*a') --try to read all data
	local data, ip, port 
	
	if nextStateToGo == recieveBroadcastHeader then 
		data, ip, port = broadcast:receivefrom()
	else
		data, ip, port = udp:receivefrom()
	end	
	
	
	if data then
		whoWatchesTheWatchdog(true)
		Spring.Echo("Recieved text " .. data .. " from " .. ip)
		if data:find(recieveResetHeader) then
			nextStateToGo = recieveResetHeader
		end	
		communicationStateMachine[nextStateToGo](data,ip,port)
	else
		whoWatchesTheWatchdog(false)
	end
	
	if nextStateToGo == recievedMSGHeader then
		--upate only on completed transfer
		if boolSendDataSemaphore == false then
			copyFrameToBuffer()
		end
		SocketWriteAble(ARDeviceIpAddress)
	end
end


function RecieveConfigureARCameraMessage(configStr)
	Spring.Echo("RecieveConfigureARCameraMessage:"..configStr)
	configStr= configStr:gsub(recievedCFGHeader,"")
	arrayOfTokens = split(configStr,";")
	Spring.Echo(arrayOfTokens)
	if arrayOfTokens[4] then
		deviceData.deviceName = arrayOfTokens[1]:gsub("MODEL","") or "No model Name recieved"
		displayWidth= arrayOfTokens[2]:gsub("DISPLAYWIDTH=","")
		deviceData.viewWidth = tonumber(displayWidth)
		displayHeigth = arrayOfTokens[3]:gsub("DISPLAYHEIGTH=","")
		deviceData.viewHeigth = tonumber(displayHeigth)
		displayRatio = arrayOfTokens[4]:gsub("DISPLAYDIVIDE=","") 
		deviceData.seperator = math.min(100,math.max(1,tonumber(displayRatio) or 50))
		
		Spring.Echo(deviceData.viewWidth,deviceData.viewHeigth)
		tex = gl.CreateTexture(deviceData.viewWidth, deviceData.viewHeigth, {fbo=true}); 
		return true
	end
	return false
end

old_mat4_4 ={}

function setCamMatriceFromMessage(recievedData)
	Spring.Echo("function setCamMatriceFromMessage(recievedData)")
	if recievedData:find(recievedMSGHeader) then
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


boolDataInBufferValid = false
local coWriteBuffer

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

function limitIncIP(ip)
	if ip +1 == 255 then return ip -1 end
	
	return ip +1
end

communicationStateMachine= 
{
	[recieveBroadcastHeader] = function (data, ip, port)
		if data and data:find(recieveBroadcastHeader) then
			
			ARDeviceIpAddress = data:gsub(recieveBroadcastHeader,"")
			Spring.Echo("recieveBroadcastHeader:"..ARDeviceIpAddress)
			hostIPAddressT	= split(ARDeviceIpAddress,".")
			hostIPAddress=""
			for i=1,3 do
				hostIPAddress=hostIPAddress..hostIPAddressT[i].."."
			end
			hostIPAddress=hostIPAddress..limitIncIP(tonumber(hostIPAddressT[4]))
			BroadcastClose()
			UDPConnect(hostIPAddress, SP_port)
			
			
			nextStateToGo = recievedCFGHeader 
		end
	end,
	[recievedCFGHeader]= function (data, ip, port)
		if data and data:find(recievedCFGHeader) then
			if RecieveConfigureARCameraMessage(data) == true then		
				nextStateToGo = recievedMSGHeader 
			end
		end							
	end,							
	
	
	[recieveResetHeader] = function (data, ip, port)
		local success, e_msg = udp:sendto(GetResetARCameraMessage(), ARDeviceIpAddress, SP_port)
		if success then
			UDPClose()
			BroadcastConnect(BroadcastIpAddress)
			
			nextStateToGo = recieveBroadcastHeader 
		else
			Spring.Echo("Failed to send message " .. command .. " to " ..ip)
		end		
	end,
	
	[recievedMSGHeader] = function (data, ip, port)
		whoWatchesTheWatchdog(data ~= nil)
		
		if data then
			setCamMatriceFromMessage(data:gsub(recievedMSGHeader,""))
		end
	end
}