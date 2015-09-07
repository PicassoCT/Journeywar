
function widget:GetInfo()
return {
    name      = "Debug Auto Reload",
    desc      = "Reloads the game in set intervalls",
    author    = "Floris, yes it was him",
    date      = "22 february 2015",
    license   = "GNU GPL, v2 or later",
    layer     = -10000,
    enabled   = true
}
end
INTERVAL=15000
-------------------------------

function widget:Initialize()


end

function widget:GameFrame(gameFrame)
	if  gameFrame+1 % INTERVAL == 0 then Spring.SendCommands("luarules reload")end
	
end