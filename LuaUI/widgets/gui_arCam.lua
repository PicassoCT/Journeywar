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
	enabled   = true  --  loaded by default?
}
end

local Chili, Screen0
local socket = socket
local message =""
local defaultWelcome=	"Welcome to Spring-AR!\n Please enter the IP displayed in the Spring AR-App:"
local client
local set
local headersent
local defaulthost="192.168.178.20"
local host = "192.168.178.20"
local port = 467
local file = "/ar/screentosend/screen.png"

local screencopy
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
    x = '5%',
    y = '20%',
    width  = '20%',
    height = '20%',	
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
--[[
 decode_uint8 = function(str, ofs)
        ofs = ofs or 0
        return string.byte(str, ofs + 1)
    end

    decode_uint16 = function(str, ofs)
        ofs = ofs or 0
        local a, b = string.byte(str, ofs + 1, ofs + 2)
        return a + b * 0x100
    end

    decode_uint32 = function(str, ofs)
        ofs = ofs or 0
        local a, b, c, d = string.byte(str, ofs + 1, ofs + 4)
        return a + b * 0x100 + c * 0x10000 + d * 0x1000000
    end

    encode_uint8 = function(int)
        return string.char(int)
    end

    encode_uint16 = function(int)
        local a, b = int % 0x100, int / 0x100
        return string.char(a, b)
    end

    encode_uint32 = function(int)
        local a, b, c, d = 
            int % 0x100, 
            int / 0x100 % 0x100, 
            int / 0x10000 % 0x100, 
            int / 0x1000000
        return string.char(a, b, c, d)
	end
]]
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
--	updateARCamera(str)
	Spring.Echo(str)
end

function textureToString(texture)
	return texture
end

local headersent
-- called when data can be written to a socket
local function SocketWriteAble(sock)
---	local scr=io.open("arImageBuffer.png","rb")
--	socket:send(scr:read("*a")); 
Spring.Echo("sending http request")
if headersent==nil then
		-- socket is writeable
		headersent=1
		sock:send("GET " .. file .. " HTTP/1.0\r\nHost: " .. host ..  " \r\n\r\n")
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
	
	--copyFrameToBuffer()
	
	for __, output in ipairs(writeable) do

		SocketWriteAble(output)
	end
end

function updateARCamera(recievedData)
end

function copyFrameToBuffer()
	w,h=  deviceData.viewWidth,	deviceData.viewHeigth  
	gl.CopyToTexture(tex, 0, 0, 0, 0, w, h);
	gl.RenderToTexture(tex, gl.SaveImage,0,0,w,h, "arImageBuffer.png"); 
	  
end





--------------------------------------------------------------------------------
--------------------------------------------------------------------------------