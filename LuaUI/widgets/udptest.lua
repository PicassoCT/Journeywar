

if not (Spring.GetConfigInt("LuaSocketEnabled", 0) == 1) then
	Spring.Echo("LuaSocketEnabled is configurationally challenged")
	return false
end

function widget:GetInfo()
	return {
		name = "UDP Test",
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

G_PORT = 8090
B_PORT = 8091
local users = {}
local udp = socket.udp()
local broadcast = socket.udp()
local winner_lock = nil


function split_ip_port(ip_port)
	local field = ip_port:split(":")
	return field[1], field[2]
end

function userByIp(ip)
	for i, user in pairs(users) do
		if user.ip == ip then
			return user
		end
	end
	return nil
end

function sendMessage(ip, port, command, ...)
	assert(type(ip) == "string")
	assert(type(port) == "string" or type(port) == "number")
	assert(type(command) == "string")
	Spring.Echo("Send message " .. command .. " to " .. ip)
	if udp then
		local success, e_msg = udp:sendto(command .. ":" .. join(arg, ","), ip, port)
		if not success then
			Spring.Echo("Failed to send message " .. command .. " to " ..ip)
			Spring.Echo(e_msg)
		end
	end
end

function broadcastUser(send_user, receivedFrom_user)
	if receivedFrom_user ~= nil then
		for i, user in pairs(users) do
			sendMessage(user.ip, user.port, "KARMA", send_user.name, send_user.karma, receivedFrom_user.name)
		end
	else
		for i, user in pairs(users) do
			sendMessage(user.ip, user.port, "KARMA", send_user.name, send_user.karma)
		end
	end
end

function broadcastLeave(send_user) 
	for i, user in pairs(users) do
		sendMessage(user.ip, user.port, "LEFT", send_user.name)
	end
end

function broadcastWinner(send_user)
	for i, user in pairs(users) do
		sendMessage(user.ip, user.port, "WINNER", send_user.name)
	end
end

function serverSetup()

	udp:settimeout(0)
	udp:setsockname('*', G_PORT)
	
	assert(broadcast:settimeout(0))
	assert(broadcast:setoption('broadcast', true))
	--assert(broadcast:setoption('dontroute', true))
	broadcast:setsockname("*", B_PORT)

	local running = true
	--local last_broadcast = os.time()
	Spring.Echo "Beginning server loop."

end

function serverLoop()

		if winner_lock and winner_lock < os.time() - WINNER_TIMEOUT then
			winner_lock = nil
			for i, user in pairs(users) do
				if 0.5 > math.random() then
					user.karma = -10
				else
					user.karma = 10
				end
				broadcastUser(user)
				sendMessage(user.ip, user.port, "RESUME")
			end
		end
		for i, user in pairs(users) do
			if user.winning_since and user.winning_since < os.time() - WINNER_TIME_IN_BOUND then
				broadcastWinner(user)
				user.winning_since = nil
				winner_lock = os.time()
			end
		end
		local b_pack, b_ip, b_port = broadcast:receivefrom()

		if b_pack and b_pack == B_CLIENT_MESSAGE then
			Spring.Echo("Broadcast recieved.")
			Spring.Echo("Send broadcast.")
			local success, e_msg = broadcast:sendto(B_SERVER_MESSAGE, B_ADDRESS, B_PORT)
			if not success then
				Spring.Echo("Broadcast failed!")
				Spring.Echo(e_msg)
			end
		end

		local data, ip, port = udp:receivefrom()

		if data then
			Spring.Echo("Recieved text " .. data .. " from " .. ip)
			local command, params = expandCommand(data)
			if not command then
				Spring.Echo("Invalid network data recieved! " .. data)
			end
			Spring.Echo("  Command is " .. command)
			Spring.Echo("  Params are " .. join(params, " "))
	
	
			-- NEW command, add user / reset user
			if command == "NEW" then
				if #params < 1 then
					Spring.Echo("Invalid NEW command recieved")
					sendMessage(ip, port, "ERROR", "10", "Not enough params for NEW command.")
				end
				local taken = false
				local name = params[1]
				if #name == 0 then
					Spring.Echo("User from ip " .. ip .. " tried to register with no name!")
					sendMessage(ip, port, "ERROR", "10", "Invalid user name!")
				end
				if #users == PLAYER_LIMIT then
					sendMessage(ip, port, "ERROR", "Sorry, server is full :(")
					taken = true
				end
				for i, user in pairs(users) do
					if user.name == name and user.ip ~= ip then
						Spring.Echo("User name " .. name .. " already taken, sry " .. ip)
						sendMessage(ip, port, "ERROR", "20", "Name already taken.")
						taken = true
					end
				end
				if not taken then
					Spring.Echo("Create new user '" .. name .. "' for ip " .. ip)
					local karma = -10
					if math.random() > 0.5 then
						karma = 10
					end
					local new_user = { name = name, karma = karma, points = 0, ip = ip, port = port, last_give = os.time(), winning_since = nil }
					local index = #users+1
					for i, user in pairs(users) do
						if user.ip == ip then
							index = i
							broadcastLeave(user)
						end
					end
					users[index] = new_user
					broadcastUser(new_user)
					for i, user in pairs(users) do
						if user.name ~= new_user.name then
							sendMessage(ip, port, "KARMA", user.name, user.karma)
						end
					end
					if not winner_lock then
						sendMessage(ip, port, "RESUME")
					end
				end
			-- GIVE command, send points to user
			elseif command == "GIVE" and not winner_lock then
				local can_give = true
				local found = false
				if #params < 2 then
					Spring.Echo("Invalid GIVE command recieved")
					sendMessage(ip, port, "ERROR", "10", "Not enough params for GIVE command.")
					can_give = false
				end
				local name, sign = params[1], params[2]
				if sign ~= "+" and sign ~= "-" then
					Spring.Echo("Invalid sign.")
					sendMessage(ip, port, "ERROR", "10", "GIVE command has invalid second parameter.")
					can_give = false
				end
				local sending_user = userByIp(ip)
				if not sending_user then
					Spring.Echo("User was not logged in when he tried to GIVE")
					sendMessage(ip, port, "ERROR", "15", "You are not logged in, stop sending shit!")
					can_give = false
				elseif sending_user.last_give > os.time() - GIVE_FREQUENCY then
					Spring.Echo("User tried to GIVE too often.")
					sendMessage(ip, port, "ERROR", "35", "You can't give more often than every " .. GIVE_FREQUENCY .. " seconds.")
					can_give = false
				end
				if can_give then
					for i,user in pairs(users) do
						if user.name == name then
							found = true
							if sign == "+" and user.karma == KARMA_BOUND or sign == "-" and - user.karma == KARMA_BOUND then
								sendMessage(ip, port, "ERROR", "37", "Karma bound of user " .. user.name .. " reached.")
							else
								if sign == "+" then
									user.karma = user.karma + 1
								elseif sign == "-" then
									user.karma = user.karma - 1
								end
								if user.karma == 0 then
									user.winning_since = os.time()
								elseif math.abs(user.karma) > WINNER_BOUND then
									user.winning_since = nil
								end
								sending_user.last_give = os.time()
								broadcastUser(user, sending_user)
							end
						end
					end
					if not found then
						Spring.Echo("GIVE used on invalid user.")
						sendMessage(ip, port, "ERROR", "30", "GIVE used on invalid user.")
					end
				end
			elseif command == "LEAVE" then
				local left = false
				for i, user in pairs(users) do
					if user.ip == ip then
						left = true
						table.remove(users, i)
						broadcastLeave(user)
					end
				end
				if not left then
					Spring.Echo("Non playing client tried to leave.")
					sendMessage(ip, port, "ERROR", "40", "You are not present in the game.")
				end
			elseif command == "PING" then
				sendMessage(ip, port, "PONG")
			elseif winner_lock then
				Spring.Echo("NOOOOOO commands during winner lock.")
			else
				sendMessage(ip, port, "ERROR", "10", "Invalid command.")
			end
	
		end

	end


function widget:Initialize()	
	

Spring.Echo("Server starting...")
serverSetup()

end


function widget:Update()

serverLoop()
end