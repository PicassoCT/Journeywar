--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

if not (Spring.GetConfigInt("LuaSocketEnabled", 0) == 1) then
	Spring.Echo("LuaSocketEnabled is disabled")
	return false
end

function widget:GetInfo()
return {
	name      = "Augmented Reality Camera",
	desc      = "",
	author    = "picasso",
	version   = "2.0",
	date      = "2018+",
	license   = "GNU GPL, v2 or later",
	layer     = math.huge,
	handler   = true,
	enabled   = false  --  loaded by default?
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

local client
local set
local headersent
local defaulthost="192.168.178.20"
local host = "192.168.178.20"
local port = 467
local screenFileName = "arTextureFile.png"
local filePath = "/ar/screentosend/"..screenFileName

local deviceData={
	deviceName = 	'Nexus',
	viewWidth = 	60,
	viewHeigth = 	70,
	seperator = 	30
}

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
    y = '80%',
    width  = '20%',
    height = '10%',	
  }	

  -- Create some text inside the window
  getIPLabel = Chili.Label:New{
    parent = getIPWindow,
    width  = '100%',
    height = '50%',
    caption = defaultWelcome,
  }
  
  	 enterIPAdress = Chili.EditBox:New{
		x = '0%',
		y = '50%',
		width  = '100%',
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
end

-->Generic to String
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

local function dumpConfig()
	-- dump all luasocket related config settings to console
	for _, conf in ipairs({"TCPAllowConnect", "TCPAllowListen", "UDPAllowConnect", "UDPAllowListen"  }) do
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

w,h=  deviceData.viewWidth,	deviceData.viewHeigth  
local tex=gl.CreateTexture(w, h, {fbo=true}); 

-- called when data was received through a connection
local function SocketDataReceived(sock, str)
	if str:find("SPRING_AR_DATA_") then
		updateARCamera(str)
	end
	Spring.Echo(str)
end

local co

-- called when data can be written to a socket
local function SocketWriteAble(sock)
---	local scr=io.open("arImageBuffer.png","rb")
--	socket:send(scr:read("*a")); 
Spring.Echo("sending http request")
	if not co or coroutine.status(co) == "dead" then
			-- socket is writeable
			
			co=		coroutine.create(function()
										sock:send( VFS.LoadFile(screenFileName))
									end
			)
			 coroutine.resume(co)
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
	
	copyFrameToBuffer()
	
	for __, output in ipairs(writeable) do

		SocketWriteAble(output)
	end
end

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

function updateARCamera(recievedData)
mat4_4 = {}
tempStr = split(recievedData, ";")
boolCompleteCamMatrix= false
	for i=1, 16 do
		mat4_4[i] = tonumber(tempStr[i])
		if i== 16 then boolCompleteCamMatrix= true ; end	
	end
	if boolCompleteCamMatrix == true then
		Spring.SetCameraTarget()
		Spring.SetCameraOffset()
	
	end
end

function copyFrameToBuffer()
	w,h=  deviceData.viewWidth,	deviceData.viewHeigth  
	gl.CopyToTexture(tex, 0, 0, 0, 0, w, h);
	gl.RenderToTexture(tex, gl.SaveImage,0,0,w,h, screenFileName); 
	  
end





--------------------------------------------------------------------------------
--------------------------------------------------------------------------------