function gadget:GetInfo()
    return {
        name = "Spawn A Unit API",
        desc = "Its not easy to Workaround ",
        author = "jk - cause everyone else was either to lazy, to dumb or busy bitching",
        date = "3rd of May 2010",
        license = "Free",
        layer = 0,
        version = 1,
        enabled = true
    }
end

--GG.UnitsToSpawn:PushCreateUnit(name,x,y,z,dir,teamID)

if (not gadgetHandler:IsSyncedCode()) then
    return
end

local function PushKillUnit(self, ...)
    self[#self + 1] = { ... }
end

local function PushCreateUnit(self, ...)
    self[#self + 1] = { ... }
end

if GG.UnitsToSpawn == nil then GG.UnitsToSpawn = { PushCreateUnit = PushCreateUnit } end
if GG.UnitsToKill == nil then GG.UnitsToKill = { PushKillUnit = PushKillUnit } end


function gadget:GameFrame(frame)
    if (frame % 10 == 0) then
        if GG.UnitsToSpawn and GG.UnitsToSpawn[1] then
            local cur = GG.UnitsToSpawn
            GG.UnitsToSpawn = { PushCreateUnit = PushCreateUnit }
            for i = 1, #cur, 1 do
                --	Spring.Echo(unpack(cur[i]))
						assert(cur[i][4], "Z Missing "..cur[i][1])
                Spring.CreateUnit(unpack(cur[i]))
            end
        end

        if GG.UnitsToKill and GG.UnitsToKill[1] then
            local cur = GG.UnitsToKill
            GG.UnitsToKill = { PushKillUnit = PushKillUnit }
            for i = 1, #cur, 1 do
                Spring.DestroyUnit(unpack(cur[i]))
            end
        end
    end
end

