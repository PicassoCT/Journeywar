function gadget:GetInfo()
    return {
        name = "Trample Tree Gadget ",
        desc = "Sampling and Trampling the Trees",
        author = "PicassoCT",
        date = "Oh, you wish, you had it with this file - but she got class and style",
        license = "GNU GPL, v2 its goes in all fields",
        layer = 0,
        enabled = true -- loaded by default?
    }
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------



if (gadgetHandler:IsSyncedCode()) then
    -- synced only
    VFS.Include("scripts/lib_OS.lua", nil, VFSMODE)
    VFS.Include("scripts/lib_UnitScript.lua", nil, VFSMODE)
    VFS.Include("scripts/lib_Build.lua", nil, VFSMODE)
    VFS.Include("scripts/lib_jw.lua", nil, VFSMODE)



    trampleDefTable = getTypeTable(UnitDefNames, {
        "cmdigg",
        "jbeherith",
        "ccomender"
    })

    local UnitsToCheck = {}


    function gadget:UnitCreated(unitid, unitdefid, unitTeam, father)
        if trampleDefTable[unitdefid] then
            Spring.Echo("Trample Tree Gadget unit registrated")
            UnitsToCheck[#UnitsToCheck + 1] = unitid
        end
    end

    local spGetUnitIsDead = Spring.GetUnitIsDead

    function gadget:GameFrame(f)
        if f % 43 == 0 then

            TrampeledTrees = {}
            if GG.TreesTrampled and GG.TreesTrampled == true then

                GG.TreesTrampled = false


                for id, v in pairs(GG.TableTreesTrampled) do
                    if spGetUnitIsDead(id) == false then
                        env = Spring.UnitScript.GetScriptEnv(id)

                        if env then

                            Spring.UnitScript.CallAsUnit(id, env.TreeTrample, true)
                        else
                        end
                    end
                end
                GG.TableTreesTrampled = {}
            end
        end
    end
end
	