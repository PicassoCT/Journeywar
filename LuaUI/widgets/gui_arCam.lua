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
local defaultWelcome=	"Welcome to Spring Augmented Reality!\n "..
"Setup: \n "..
"0. Start the Spring-AR App \n"..
"1. Please position the projectionposition on your mobile device. \n"..
"2. Please Enter the IP displayed\n"

recievedCFGHeader = "SPRINGARREC;CFG="						
recievedMSGHeader = "SPRINGARCAM;DATA="						
sendMSGHeader 	= "SPRINGARSND;DATA="					
recieveResetHeader = "SPRINGAR;RESET;"	

local client
local set
local headersent
local defaulthost="192.168.178.20"
local host = "192.168.178.20"
local port = 8090 
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

--Handled by writing function once done- waiting for the sendeSemaphore to drop
function switchWriteBuffer()
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

local getIPWindow
local getIPLabel

function widget:Initialize()	
	if (not WG.Chili) then
		-- don't run if we can't find Chili
		widgetHandler:RemoveWidget()
		return
	end
	
	-- Get ready to use Chili
	Chili = WG.Chili
	Screen0 = Chili.Screen0
	
	-- Create the window
	getIPWindow = Chili.Window:New{
		parent = Screen0,
		x = '0%',
		y = '50%',
		width = '30%',
		height = '25%',	
	}	
	
	-- Create some text inside the window
	getIPLabel = Chili.Label:New{
		parent = getIPWindow,
		x = '0%',
		y = '0%',
		width = '100%',
		height = '50%',
		caption = defaultWelcome,
	}
	
	enterIPAdress = Chili.EditBox:New{
		x = '0%',
		y = '50%',
		width = '100%',
		height = '50%',
		parent = getIPWindow,
		OnKeyPress = {
			function(obj, key, mods, isRepeat, label, unicode, ...)
				
				if key == 13 then
					if obj.text ~= ""then
						host = obj.text
					else
						host = defaulthost
					end
					InitalizeSocket()
				end
			end,
		}
	} 
	
	-- load Logo into Buffer and set first Buffer active
	--TODO
	fileBufferDesc[1].boolNotValid = false
	fileBufferDesc[1].Active = true
end

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

local function newset()
	local reverse = {}
	local set = {}
		return setmetatable(set, {__index = {
			insert = function(set, value)
				if not reverse[value] then
					table.insert(set, value)
					reverse[value] = table.getn(set)
				end
			end,
			remove = function(set, value)
				local index = reverse[value]
				if index then
					reverse[value] = nil
					local top = table.remove(set)
					if top ~= value then
						reverse[top] = index
						set[index] = top
					end
				end
			end
	}})
end



-- initiates a connection to host:port, returns true on success
local function SocketConnect(host, port)
	client=socket.tcp()
	client:settimeout(0)
	res, err = client:connect(host, port)
	if not res and not res=="timeout" then
		Spring.Echo("Error in connect: "..err)
		return false
	end
	set = newset()
	set:insert(client)
	getIPWindow:Hide()
	return true
end

function InitalizeSocket()
	dumpConfig()
	--Spring.Echo(socket.dns.toip("localhost"))
	--FIXME dns-request seems to block
	SocketConnect(host, port)
end

-- called when data was received through a connection
local function SocketDataReceived(sock, str)
	-- Cellphoneconfiguration recieved
	if str:find(recievedCFGHeader) then
		configureARCamera(str)
	end
	-- Cameramatrice recieved
	if str:find(recievedMSGHeader) then
		updateARCamera(str)
	end
end

local coSendData 
boolSendDataSemaphore = false
-- called when data can be written to a socket
local function SocketWriteAble(sock)
	-- load image
	Spring.Echo("sending ar image to cellphone")
	if not coSendData or coroutine.status(coSendData) == "dead" then
		-- socket is writeable
		
		coSendData=		coroutine.create(function()
			boolSendDataSemaphore = true
			sock:send( VFS.LoadFile(getActiveBuffer().filePathName))
			boolSendDataSemaphore = false
		end
		)
		if not boolSendDataSemaphore then
			coroutine.resume(coSendData)
		end
	end
end

-- called when a connection is closed
local function SocketClosed(sock)
	Spring.Echo("closed connection")
end

function widget:Update()
	if set==nil or #set<=0 then
		return
	end
	
	-- get sockets ready for read
	local readable, writeable, err = socket.select(set, set, 0)
	if err~=nil then
		-- some error happened in select
		if err=="timeout" then
			-- nothing to do, return
			return
		end
		Spring.Echo("Error in select: " .. error)
	end
	
	for _, input in ipairs(readable) do
		local s, status, partial = input:receive('*a') --try to read all data
		Spring.Echo(s)
		if status == "timeout" or status == nil then
			SocketDataReceived(input, s or partial)
			
		elseif status == "closed" then
			getIPWindow:Show()
			getIPLabel.caption= "Connection closed. \n".. defaultWelcome
			
			SocketClosed(input)
			input:close()
			set:remove(input)
		end
	end
	--upate only on completed transfer
	if boolSendDataSemaphore == false then
		copyFrameToBuffer()
	end
	
	for __, output in ipairs(writeable) do
		SocketWriteAble(output)
	end
end

function configureARCamera(configStr)
	configStr= configStr:replace(recievedCFGHeader,'')
	arrayOfTokens = split(configStr,";")
	
	deviceData.deviceName = arrayOfTokens[1] or ""
	deviceData.viewWidth = tonumber(arrayOfTokens[2])
	deviceData.viewHeigth = tonumber(arrayOfTokens[3])
	deviceData.seperator = min(100,max(1,tonumber(arrayOfTokens[4])))
	
	tex = gl.CreateTexture(deviceData.viewWidth, deviceData.viewHeigth, {fbo=true}); 
	
end

old_mat4_4 ={}
function updateARCamera(recievedData)
	recievedData=recievedData:replace(recievedMSGHeader,'')
	mat4_4 = split(recievedData, ";")
	boolCompleteCamMatrix= false
	for i=1, 16 do
		mat4_4[i] = tonumber(mat4_4[i])
		if i== 16 then boolCompleteCamMatrix= true ; end	
	end
	
	if boolCompleteCamMatrix == true then
		old_mat4_4=mat4_4
	end
	Spring.SetCameraTarget(old_mat4_4)
	Spring.SetCameraOffset(old_mat4_4)
	
end

boolDataInBufferValid = false
local coWriteBuffer

function copyFrameToBuffer()
	if not coWriteBuffer or coroutine.status(coWriteBuffer) == "dead" then
		-- socket is writeable
		
		coWriteBuffer=		coroutine.create(function()
			gl.CopyToTexture(tex, 0, 0, 0, 0, deviceData.viewWidth, deviceData.viewHeigth);
			gl.RenderToTexture(tex, gl.SaveImage,0,0,deviceData.viewWidth,deviceData.viewHeigth, getWriteableBuffer().filePathName);
			switchWriteBuffer()										
		end
		)
		coroutine.resume(coWriteBuffer)
		
		
	end
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------