include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"
include "lib_Build.lua"

local Animations = {};

Animations['pickup'] = VFS.Include("Scripts/animations/m7couple/pickWalk.lua", scriptEnv);
Animations['walk'] = VFS.Include("Scripts/animations/m7couple/walk.lua", scriptEnv);
Animations['fightAnimation'] = VFS.Include("Scripts/animations/m7couple/fight.lua", scriptEnv);

--------------------------------------------------------------------------------
-- funcs
--------------------------------------------------------------------------------
function constructSkeleton(unit, piecen, offset)
	 if not piecen then  return {} end
    if (offset == nil) then
        offset = { 0, 0, 0 };
    end

    local bones = {};
    local info = Spring.GetUnitPieceInfo(unit, piecen);

    for i = 1, 3 do
        info.offset[i] = offset[i] + info.offset[i];
    end

    bones[piecen] = info.offset;
    local map = Spring.GetUnitPieceMap(unit);
    local children = info.children;

    if (children) then
        for i, childName in pairs(children) do
            local childId = map[childName];
            local childBones = constructSkeleton(unit, childId, info.offset);
            for cid, cinfo in pairs(childBones) do
                bones[cid] = cinfo;
            end
        end
    end
    return bones;
end



local animCmd = { ['turn'] = Turn, ['move'] = Move };
function PlayAnimation(animname, snap)
    local anim = Animations[animname];
    for i = 1, #anim do
        local commands = anim[i].commands;
        for j = 1, #commands do
            -- hack to make first keyframe snap
            local cmd = commands[j];
            local speed = cmd.s;
            if i == 1 and snap then speed = 0; end

            animCmd[cmd.c](cmd.p, cmd.a, cmd.t, speed);
        end
        if (i < #anim) then
            local t = anim[i + 1]['time'] - anim[i]['time'];
            Sleep(t * 33); -- sleep works on milliseconds
        end
    end
end


TablesOfPiecesGroups = {}
PiecesTable = {}
totalDamage = 0
function script.HitByWeapon(x, z, weaponDefID, damage)
    totalDamage = totalDamage + damage

    return damage
end

center = piece "center"

sheMap = getPiecesBelow(unitID, "Her", piece)
heMap = getPiecesBelow(unitID, "He", piece)
heMap[#heMap + 1] = piece("He")
sheMap[#heMap + 1] = piece("Her")

function script.Create()
    local map = Spring.GetUnitPieceMap(unitID);
    local offsets = constructSkeleton(unitID, map.Scene, { 0, 0, 0 });

    for a, anim in pairs(Animations) do
        for i, keyframe in pairs(anim) do
            local commands = keyframe.commands;
            for k, command in pairs(commands) do
                -- commands are described in (c)ommand,(p)iece,(a)xis,(t)arget,(s)peed format
                -- the t attribute needs to be adjusted for move commands from blender's absolute values
                if (command.c == "move") then
                    local adjusted = command.t - (offsets[command.p][command.a]);
                    Animations[a][i]['commands'][k].t = command.t - (offsets[command.p][command.a]);
                end
            end
        end
    end
    PiecesTable = generatepiecesTableAndArrayCode(unitID)
    TablesOfPiecesGroups = makePiecesTablesByNameGroups(false, true)
    StartThread(selectMoveStateMachine)
end

MoveState = "STOP"
Unit = ""
function selectMoveStateMachine()
    myDefID = Spring.GetUnitDefID(unitID)
    if myDefID == UnitdefNames["gcouplem7"].id then Unit = "Couple"; StartThread(moveStateMachineGCOUPLEM7) end
    if myDefID == UnitdefNames["gherm7"].id then Unit = "She"; StartThread(moveStateMachineGHERM7) end
    if myDefID == UnitdefNames["ghimm7"].id then Unit = "He"; StartThread(moveStateMachineGHIMM7) end
end


maxspeed = math.ceil(COB.MAX_SPEED * 65533)
function constantHealthReduction()
    while true do
        hp, maxhp = Spring.GetUnitHealth(unitID)
        Spring.SetUnitHealth(unitID, math.max(100, hp - 1))
        Sleep(100)

        if hp < maxhp / 2 then --SetSpeed to zero
            SetUnitValue(COB.MAX_SPEED, 0) --sets the speed to 5,2 *65533
            MoveState = "STOP_OVERRIDE"
        else --restore Speed
            if MoveState == "STOP_OVERRIDE" then MoveState = "STOP" end
            SetUnitValue(COB.MAX_SPEED, maxspeed) --sets the speed to 5,2 *65533
        end
    end
end

function determinateStateCouple(Oldstate)
    if boolAiming == true and Oldstate == "STOP" then return "AIM" end
    if boolMoving == true then return "MOVE" end
    if boolMoving == false then return "STOP" end
end

function coupleWalkAnimation()
    Signal(SIG_WALK)
    SetSignalMask(SIG_WALK)
    while true do
        PlayAnimation("pickup", false)
        PlayAnimation("walk", false)
    end
end

function coupleStopAnimation()

    PlayAnimation("stop", false)
end

--CoupleMovement
function moveStateMachineGCOUPLEM7()
    showT(heMap)
    showT(sheMap)
    hideT(getPiecesBelow(unitID, "harm1", piece))
    hideT(getPiecesBelow(unitID, "HArm3", piece))

    StartThread(constantHealthReduction)
    while true do
        if MoveState ~= "STOP_OVERRIDE" then
            MoveState = determinateStateCouple(MoveState)
            if MoveState == "MOVE" then
                reseT(PiecesTable, math.pi)
                StartThread(coupleWalkAnimation)
                while determinateStateCouple(MoveState) == "MOVE" do Sleep(10) end
                Signal(SIG_WALK)
                MoveState = determinateStateCouple(MoveState)

            elseif MoveState == "AIM" then
                coupleAimAnimation()

            elseif MoveState == "STOP" then
                coupleStopAnimation()
            end
        end
        Sleep(100)
    end
end

function moveStateMachineGCOUPLEM7()
    while true do



        Sleep(100)
    end
end

boolMoving = false
function moveStateMachineGCOUPLEM7()
    while true do



        Sleep(100)
    end
end

function script.Killed(recentDamage, _)

    createCorpseJUnitGeneric(recentDamage)
    return 1
end


--- -aimining & fire weapon
function script.AimFromWeapon1()
    return aimpiece
end



function script.QueryWeapon1()
    return aimpiece
end

boolRampageRuns = false
function rampage()
    boolRampageRuns = true
    StartThread(PlayAnimation, "fightAnimation", true)
    teamID = Spring.GetUnitTeam()
    T = getAllinCircle(x, z, 75, unitID, teamID)
    process(T,
        function(id) hp = Spring.GetUnitHealth(id); Spring.SetUnitHealth(id, math.max(0, hp - 122)); end)
    totalDamage = 0
    boolRampageRuns = false
end

rageDamage = 600
function script.AimWeapon1(Heading, pitch)
    MoveState = "AIM"
    if boolRampageRuns == true then return true end
    if totalDamage > rageDamage then
        StartThread(rampage)
    end

    if Unit == "He" then
        Turn(PiecesTable["CArm2"], y_axis, Heading + math.rad(90), 2)
        Turn(PiecesTable["CArm2"], x_axis, -pitch, 2)
        Turn(PiecesTable["CArm4"], y_axis, Heading - math.rad(90), 2)
        Turn(PiecesTable["CArm4"], x_axis, -pitch, 2)
        WaitForTurns(PiecesTable["CArm4"], PiecesTable["CArm2"])
        MoveState = "WALK"
        return true
    end

    if Unit == "She" then
        Turn(PiecesTable["HArm2"], y_axis, Heading + math.rad(90), 2)
        Turn(PiecesTable["HArm2"], x_axis, -pitch, 2)
        Turn(PiecesTable["HArm4"], y_axis, Heading - math.rad(90), 2)
        Turn(PiecesTable["HArm4"], x_axis, -pitch, 2)
        WaitForTurns(PiecesTable["HArm4"], PiecesTable["HArm2"])
        MoveState = "WALK"
        return true
    end

    if Unit == "Couple" and MoveState == "STOP" then
        Signal(SIG_WALK)
        Turn(center, y_axis, Heading, 2)
        MoveState = "STOP"
        return true
    end
    MoveState = "WALK"
    return false
end


function script.FireWeapon1()
    Turn(center, y_axis, math.rad(0), 0.5)
    return true
end



function script.StartMoving()
    boolMoving = true
end

function delayedStop()
    SetSignalMask(SIG_WALK)
    Sleep(350)
    boolMoving = false
end

function script.StopMoving()
    StartThread(delayedStop)
end

function script.Activate()

    return 1
end

function script.Deactivate()

    return 0
end