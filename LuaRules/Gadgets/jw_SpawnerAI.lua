-- In-game, type /luarules kpai in the console to toggle the ai debug messages
 
function gadget:GetInfo()
local modOptions = Spring.GetModOptions()
        return {
                name = "Spawner AI",
                desc = "Spawns Units",
                author = "Your Moma",
                date = "around since last tuesday",
                license = "GPOCNL - Gajop Pissed Off Cause Nonsense License ",
                layer = 82,
              enabled = (modOptions.SpawnerAI and modOptions.SpawnerAI== true) or false
        }
end

if (gadgetHandler:IsSyncedCode()) then


end