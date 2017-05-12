spiess = piece "spiess"
firePlace = piece "firePlace"
emit = piece "emit"

STORYMAX = 4


function script.Killed()
    return 1
end

function anybodyNearby()
    teamid = Spring.GetUnitTeam(unitID)
    T = Spring.GetUnitsInCylinder(x, z, 300, teamid)
    table.remove(T, unitID)
    if T and #T > 2 then
        local CompTable = {
            [UnitDefNames["skinfantry"].id] = true,
            [UnitDefNames["tiglil"].id] = true,
            [UnitDefNames["vort"].id] = true
        }
        count = 0
        for i = 1, #T do
            defID = Spring.GetUnitDefID(T[i])
            if CompTable[defID] == true then count = count + 1 end
            if count > 2 then return true end
        end
    end
    return false
end

function storyTime()
    Sleep(12000)
    if math.random(1, 12) == 6 and anybodyNearby() == true then
        diceBeNice = math.ceil(math.random(1, STORYMAX))
        SoundName = "sounds/gFirePlace/Story" .. diceBeNice .. ".ogg"
        Spring.PlaySoundFile(SoundName, 0.9)
    end
end

function onFire()
    while (true) do
        EmitSfx(emit, 1024)
        Sleep(60)
    end
end

function dinnerIsReady()
    RandNomNomNom = math.random(80000, 120000)
    Sleep(RandNomNomNom)
    Spring.DestroyUnit(unitID, false, true)
end

function script.Create()
    Spin(spiess, x_axis, math.rad(17), 5)
    StartThread(onFire)
    StartThread(dinnerIsReady)
    StartThread(FireTales)
end

function FireTales()
    if math.random(0, 1) == 1 then
        Time = math.ceil(math.random(42000, 60000))
        Sleep(Time)
        -- Story One: ".. died over fifteen times, on the third star near the horizon. On a gas giants ice-covered moon.
        -- We were locked in a stalemate for 1.5 orbs. Icequakes, Glacierbridging, Shardartillery, you name it they threw it at as.
        -- And everywhere this thin film of frozzen carb,  which sends you instantly drifting if you dont hook.
        -- Some crackpot had the glorious idea to melt a hole through the ice, walk along the oceans surface, and attack them from behind.
        -- Desperate as we are, we try it, and staggering along there for some millightsecs  we were when suddenly,
        -- out of the dark depths below, something resembling a stone sky, lowers on us.
        -- Turns out the whole moons rocky core, rolled around on that icy shell like a giant marble. Everyone died,
        -- except for one guy, who found a rift,hid and went insane, still spinning to this day..

        -- Story Two   ".. this far away, you can still see it, but that star is no more. We blew it in the Tanjoran-campaign.
        -- Used it as a torch. Still ashamed when i see it go bright at nights, our Sins catching up.
        -- You younger forks wouldnt understand, but there is a going to far, in love and war.
        -- Nothing more atrocious then burning a sphere..

        -- Story Three " - there were naturally occurring speardiamond there, and the whole dimension wasn't very forthcoming to live at large, and to technophiles
        -- in particular. So we are safe, relax? Wrong.
        -- They crossed the whole breach, like ants, filling the terrain up with there fallen.
        -- A dam, made of screaming, later frozzen people, most horrific thing i ever seeen.

        -- Story Four  " - you recon, its pretty tough here? No, no, up there is where the real battle takes place.
        -- Cant see it during the day, but at night all the sparkling light. Sometimes a stray shot.
        -- If they miss up there, we down here will miss you too.
        -- But it makes for beautifull fireworks, when the wreckage enters atmo..

        -- Story Five  " - the whole planet is coverd in grassy savannah, so we make a orb-jump. We land, and find out, that that thing is not grass at all.
        -- Its moss, covering very flat treetops - and beneath it is one millightsecs dark tangled rainforrest to the floor.
        -- I survived because i wasnt first, i had some splits to prepare myself.
        -- Never be the first. Never be the fastest. Never volunteer.

        -- Story Six "   - foam everywhere. On your helmet, on your suit, in your boots, warm, stinkysticky foam. Produced by those podplants, who grew in every waterpool. They dug down till they hit heat.
        -- There pools would cook up foam, covering the landscape with it, and transporting the seeds to other ponds.
        -- And in the middle of it, we, and the others, one huge party, shooting in the tunnels beneath the white avalanch.."

        -- Story Seven "- the place is called Xen. Floating Islands, strange creatures. But not during the autumn of that dimension. Then its all hauled in one titanic shardstorm at another
        -- Everything living there, has evolved to survive this one season. The only way for sentient live to stay, if that still can be called sentient,
        -- is in a pool of patter amobeas. They will absorb you, when you get torn to shreds, and put you back together, when everything quiets down.
        -- But sometimes the amobeas make mistakes.

        -- Story Eight "- the whole scoutparty was huddled in one of the gardens of there secreted buildings. And suddenly this huge boulder of them was direclty above hanging in the sky.
        -- "-Big Announcment, Admiral Hornblow, we all are going to die, yadda, yadda, bla. Two of us, new ones, freak, and run. Wrong thing to do. Those scanners are trained on rash movements.
        -- "- Torch from the sky and we the others wait. "Look what sophisticated evasive patterns it makes" says Yazahin, cause it makes quite a dance in place."
        -- "- I look, look again, and turn to her. "No, no, whoever controlls it, is high as a Kohain, eating rotten Dalibs. And that was it.
        -- "- After another swerve, the whole cathedral in the sky, goes banking, crashing into there hive. People running, fires, soldier antitys rolling by towards the crashsite.

        -- Story Nine  "-- how a forcefield works? Its actually easy- you basically have 2 microwavelasers, and a additional laser plus some high voltage.
        -- Now the masers print something, for example a coil into midair, you connect the whole thing via the additonal laser to the power source.
        --Voila, magnetic field in midair out of nowhere. Its easy.
        -- Except that this machinery scooped from balllightning  will instantly deform like pudding- so you need to plan ahead.
        -- Another layer  structures to deform the plasma back into shape. And when you do this maschinebuilding with airpudding long enough, it looks flawless-

        --Story Ten   " yes, the Shroudshrikes are creepy. Its everything about them, the way the warp the odds. Rabbits kill foxes, Labcoats trained soldiers.
        --just keep away from them, and you will be fine. Maybe.
        --No chance winning against somebody who  distorts the chances.

        --Story Eleven "after this, im dropping out. I volunteered yes,  thought war would be inspiring. Not like this. One mad and dead friend is enough.
        -- Her name was Alia, she orbdropped on Talesan, before they shelled it. Killed, Regrown, Blown to pieces. They surrendered. Nobody cared up there.
        -- So they just continued dying. Until the planet was gone, blown into steaming bits, and they could drift away in the rubble."
        -- She could have had a memory wipe, but she wanted to keep them. Saw herself as a war memorial.
        -- Wanted to push those memorys onward, to newforked generations. Traumatized a thousand.
        -- Then got euthanized with them via vote. "

        --Story Twelfe
    end
end
