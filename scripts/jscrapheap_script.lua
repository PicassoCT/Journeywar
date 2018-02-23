include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"

include "lib_Build.lua"
include "lib_jw.lua"

apend = {}
spin = {}
Leg = {}
Husk = {}
Shield = {}
PillP = {}
Pillar = {}
Balls = {}
Pipe = {}
Drip = {}
Shell = {}
Fluid = {}
Contain = {}
Ring = {}
Transport = {}
center = piece(center)
Transport3 = piece "Transport3"
Transport[3] = Transport3
Drip3 = piece "Drip3"
Drip[3] = Drip3
Root = piece(Root)
Pipe8 = piece "Pipe8"
Pipe[8] = Pipe8
Pipe7 = piece "Pipe7"
Pipe[7] = Pipe7
Pipe6 = piece "Pipe6"
Pipe[6] = Pipe6
Pipe5 = piece "Pipe5"
Pipe[5] = Pipe5
Pipe4 = piece "Pipe4"
Pipe[4] = Pipe4
Pipe3 = piece "Pipe3"
Pipe[3] = Pipe3
Pipe2 = piece "Pipe2"
Pipe[2] = Pipe2
Pipe1 = piece "Pipe1"
Pipe[1] = Pipe1
Shell1 = piece "Shell1"
Shell[1] = Shell1
Shell2 = piece "Shell2"
Shell[2] = Shell2
Shell3 = piece "Shell3"
Shell[3] = Shell3
Shield2 = piece "Shield2"
Shield[2] = Shield2
Shield1 = piece "Shield1"
Shield[1] = Shield1
Shield4 = piece "Shield4"
Shield[4] = Shield4
Shield5 = piece "Shield5"
Shield[5] = Shield5
Drip1 = piece "Drip1"
Drip[1] = Drip1
Soup = piece(Soup)
Flood = piece(Flood)
FloodRing = piece(FloodRing)
Balls6 = piece "Balls6"
Balls[6] = Balls6
Contain2 = piece "Contain2"
Contain[2] = Contain2
Fluid2 = piece "Fluid2"
Fluid[2] = Fluid2
Contain1 = piece "Contain1"
Contain[1] = Contain1
Fluid1 = piece "Fluid1"
Fluid[1] = Fluid1
Husk1 = piece "Husk1"
Husk[1] = Husk1
Husk2 = piece "Husk2"
Husk[2] = Husk2
Husk3 = piece "Husk3"
Husk[3] = Husk3
Balls5 = piece "Balls5"
Balls[5] = Balls5
Balls4 = piece "Balls4"
Balls[4] = Balls4
Balls3 = piece "Balls3"
Balls[3] = Balls3
Balls2 = piece "Balls2"
Balls[2] = Balls2
Balls1 = piece "Balls1"
Balls[1] = Balls1
Drip2 = piece "Drip2"
Drip[2] = Drip2
ldrop = piece(ldrop)
sdrop = piece(sdrop)
Transport1 = piece "Transport1"
Transport[1] = Transport1
Transport2 = piece "Transport2"
Transport[2] = Transport2
Shield3 = piece "Shield3"
Shield[3] = Shield3
Balls7 = piece "Balls7"
Balls[7] = Balls7
Balls8 = piece "Balls8"
Balls[8] = Balls8
Balls9 = piece "Balls9"
Balls[9] = Balls9
Balls10 = piece "Balls10"
Balls[10] = Balls10
Ring1 = piece "Ring1"
Ring[1] = Ring1
Ring2 = piece "Ring2"
Ring[2] = Ring2
Ring3 = piece "Ring3"
Ring[3] = Ring3
Ring4 = piece "Ring4"
Ring[4] = Ring4
Ring5 = piece "Ring5"
Ring[5] = Ring5
Ring6 = piece "Ring6"
Ring[6] = Ring6
spin1 = piece "spin1"
spin[1] = spin1

MortalFlesh = piece(MortalFlesh)
Leg01 = piece "Leg01"
Leg[1] = Leg01
Leg02 = piece "Leg02"
Leg[2] = Leg02
Leg03 = piece "Leg03"
Leg[3] = Leg03
Leg04 = piece "Leg04"
Leg[4] = Leg04
apend1 = piece "apend1"
apend[1] = apend1
apend2 = piece "apend2"
apend[2] = apend2
BabyWalk = piece(BabyWalk)
Baby = piece(Baby)
Navel = piece(Navel)
--PIECESLIST::BEGIN |>----------------------------
--PIECES
piecesTable = {}
center = piece "center"
piecesTable[#piecesTable + 1] = center
Transport3 = piece "Transport3"
piecesTable[#piecesTable + 1] = Transport3
Drip3 = piece "Drip3"
piecesTable[#piecesTable + 1] = Drip3
Root = piece "Root"
piecesTable[#piecesTable + 1] = Root
Pipe8 = piece "Pipe8"
piecesTable[#piecesTable + 1] = Pipe8
Pipe7 = piece "Pipe7"
piecesTable[#piecesTable + 1] = Pipe7
Pipe6 = piece "Pipe6"
piecesTable[#piecesTable + 1] = Pipe6
Pipe5 = piece "Pipe5"
piecesTable[#piecesTable + 1] = Pipe5
Pipe4 = piece "Pipe4"
piecesTable[#piecesTable + 1] = Pipe4
Pipe3 = piece "Pipe3"
piecesTable[#piecesTable + 1] = Pipe3
Pipe2 = piece "Pipe2"
piecesTable[#piecesTable + 1] = Pipe2
Pipe1 = piece "Pipe1"
piecesTable[#piecesTable + 1] = Pipe1
Shell1 = piece "Shell1"
piecesTable[#piecesTable + 1] = Shell1
Shell2 = piece "Shell2"
piecesTable[#piecesTable + 1] = Shell2
Shell3 = piece "Shell3"
piecesTable[#piecesTable + 1] = Shell3
Shield2 = piece "Shield2"
piecesTable[#piecesTable + 1] = Shield2
Shield1 = piece "Shield1"
piecesTable[#piecesTable + 1] = Shield1
Shield4 = piece "Shield4"
piecesTable[#piecesTable + 1] = Shield4
Shield5 = piece "Shield5"
piecesTable[#piecesTable + 1] = Shield5
Drip1 = piece "Drip1"
piecesTable[#piecesTable + 1] = Drip1
Soup = piece "Soup"
piecesTable[#piecesTable + 1] = Soup
Flood = piece "Flood"
piecesTable[#piecesTable + 1] = Flood
FloodRing = piece "FloodRing"
piecesTable[#piecesTable + 1] = FloodRing
Balls6 = piece "Balls6"
piecesTable[#piecesTable + 1] = Balls6
Contain2 = piece "Contain2"
piecesTable[#piecesTable + 1] = Contain2
Fluid2 = piece "Fluid2"
piecesTable[#piecesTable + 1] = Fluid2
Contain1 = piece "Contain1"
piecesTable[#piecesTable + 1] = Contain1
Fluid1 = piece "Fluid1"
piecesTable[#piecesTable + 1] = Fluid1
Husk1 = piece "Husk1"
piecesTable[#piecesTable + 1] = Husk1
Husk2 = piece "Husk2"
piecesTable[#piecesTable + 1] = Husk2
Husk3 = piece "Husk3"
piecesTable[#piecesTable + 1] = Husk3
Balls5 = piece "Balls5"
piecesTable[#piecesTable + 1] = Balls5
Balls4 = piece "Balls4"
piecesTable[#piecesTable + 1] = Balls4
Balls3 = piece "Balls3"
piecesTable[#piecesTable + 1] = Balls3
Balls2 = piece "Balls2"
piecesTable[#piecesTable + 1] = Balls2
Balls1 = piece "Balls1"
piecesTable[#piecesTable + 1] = Balls1
Drip2 = piece "Drip2"
piecesTable[#piecesTable + 1] = Drip2
ldrop = piece "ldrop"
piecesTable[#piecesTable + 1] = ldrop
sdrop = piece "sdrop"
piecesTable[#piecesTable + 1] = sdrop
Transport1 = piece "Transport1"
piecesTable[#piecesTable + 1] = Transport1
Transport2 = piece "Transport2"
piecesTable[#piecesTable + 1] = Transport2
Shield3 = piece "Shield3"
piecesTable[#piecesTable + 1] = Shield3
Balls7 = piece "Balls7"
piecesTable[#piecesTable + 1] = Balls7
Balls8 = piece "Balls8"
piecesTable[#piecesTable + 1] = Balls8
Balls9 = piece "Balls9"
piecesTable[#piecesTable + 1] = Balls9
Balls10 = piece "Balls10"
piecesTable[#piecesTable + 1] = Balls10
Ring1 = piece "Ring1"
piecesTable[#piecesTable + 1] = Ring1
Ring2 = piece "Ring2"
piecesTable[#piecesTable + 1] = Ring2
Ring3 = piece "Ring3"
piecesTable[#piecesTable + 1] = Ring3
Ring4 = piece "Ring4"
piecesTable[#piecesTable + 1] = Ring4
Ring5 = piece "Ring5"
piecesTable[#piecesTable + 1] = Ring5
Ring6 = piece "Ring6"
piecesTable[#piecesTable + 1] = Ring6
spin1 = piece "spin1"
piecesTable[#piecesTable + 1] = spin1

MortalFlesh = piece "MortalFlesh"
piecesTable[#piecesTable + 1] = MortalFlesh
Leg01 = piece "Leg01"
piecesTable[#piecesTable + 1] = Leg01
Leg02 = piece "Leg02"
piecesTable[#piecesTable + 1] = Leg02
Leg03 = piece "Leg03"
piecesTable[#piecesTable + 1] = Leg03
Leg04 = piece "Leg04"
piecesTable[#piecesTable + 1] = Leg04
apend1 = piece "apend1"

apend[#apend + 1] = apend1
piecesTable[#piecesTable + 1] = apend1
apend2 = piece "apend2"
piecesTable[#piecesTable + 1] = apend2
apend[#apend + 1] = apend2
BabyWalk = piece "BabyWalk"
piecesTable[#piecesTable + 1] = BabyWalk
Baby = piece "Baby"
piecesTable[#piecesTable + 1] = Baby
Navel = piece "Navel"
piecesTable[#piecesTable + 1] = Navel

WeeImATree = Spring.GetUnitDefID(unitID)
Trees = getTreeTypeTable(UnitDefNames)
boolWeeImATree = Trees[WeeImATree] or false

SIG_DEATH = 32

function contemplateOrigin()

    boolPositionUnchanged = true
    xo, yo, zo = Spring.GetUnitPosition(unitID)
    while (boolPositionUnchanged == true) do
        x, y, z = Spring.GetUnitPosition(unitID)
        if math.abs(x - xo) > 10 and math.abs(z - zo) > 10 then
            boolPositionUnchanged = false
            hideT(piecesTable)

            if boolWeeImATree == true then
                Show(Transport3)
            else
                pieceOfChoice = Transport[irand(1, 2)]
                Show(pieceOfChoice)
            end

            Signal(SIG_DEATH)
        end
        Sleep(2000)
    end
end



--scrapMain=piece "scrapMain"
function diceHide(piecename)
    i = math.random(0, 1)
    if i == 1 then
        Hide(piecename)
    else
        Show(piecename)
    end
end


function init()
		Hide(FloodRing)
    if boolWeeImATree == true then
        hideT(piecesTable)
        Show(Transport[3])
        Show(Root)

    else
        turnTableRand(Ring)
        turnTableRand(Shell)
        turnTableRand(Husk)

        Hide(Root)
        Hide(Transport[3])
        hideT(Drip)
        Hide(Soup)
        Hide(Flood)
        hideT(Fluid)
        Hide(ldrop)
        Hide(sdrop)

        if maRa() == true then
            StartThread(maMa)
        end

        StartThread(flailingFlesh)

        --Shells
        for i = 1, #Shield, 1 do
            StartThread(shieldset, i)
        end

        for i = 1, #Balls, 1 do
            StartThread(Ballsset, i)
        end
        --	process(Shell, 	function(id,axis) Move(id,axis,math.random(-10,42),0)end,y_axis)
        for i = 1, #Pipe do
            StartThread(pipes, i)
        end

        for i = 1, #Husk do
            StartThread(Huskset, i)
        end

        if maRa() == true then
            StartThread(Pump1)
        end

        if maRa() == true then
            StartThread(Pump2)
        end

       
       

        for i = 1, #Ring do
				d = math.random(10, 45)*randSign()
				dis = math.random(25, 45)*randSign()
				das = math.random(25, 45)*randSign()
            --echo("Ring"..i)
            tP(Ring[i], math.random(-45,45), math.rad(d),0, 0)
            x, z = Rotate(dis, das,  i * (290 / #Ring))
            moveUnitPieceToGroundPos(unitID, Ring[i], x, z, 1.8, 3)
            Show(Ring[i])
        end

        StartThread(pillarHandling)
    end
end
empty= piece"empty"
function pillarHandling()
    --echo("pillarHandling")
	    boolPillarbreath = maRa()
		 boolGap=maRa()
	 if boolGap == true then
	   gapVal=math.random(-20,30)
	   for i=1, #Pillar do
	 	 if i % 2 == 0 then
	 		Move(Pillar[i],z_axis,gapVal,0)
	 	end
	   end
	 end

    val = 360 - math.random(10, 150)
    for i=1, #spin do
		Turn(spin[i],y_axis,math.rad(val/#spin)*i,0)		
		if maRa()==true then
			Hide(Pillar[i]) 
		else 
			Show(Pillar[i])
		end
	 end

    if boolPillarbreath == false then
			x,y,z=math.random(-70,70),math.random(-360,360),0
        for i = 1, #Pillar, 1 do
			tP(Pillar[i],x,y,z,0)
        end
	else
        --breath it
		rand = math.random(-60,60)
       for i = 1, #Pillar, 1 do
          StartThread(breath, empty, Pillar[i], x_axis, rand, 0.5, 5, 0.1 )        
       end
    end

end

function Ballsset(i)
    Show(Balls[i])
	 local x,y,z=math.random(30, 70)*randSign(), math.random(25, 35) , math.random(30, 70)*randSign()
    mSyncIn(Balls[i],x,y,z,1000)
	 WaitForMoves(Balls[i])

	 mSyncIn(Balls[i],
		 x ,
		 groundHugDay(Balls[i]),
		 z ,
		 700)
		EmitSfx(Balls[i],1025)
	  wiggle(Balls[i], 70 ,30,70,15000, 900,1200, 0.005)
	  EmitSfx(Balls[i],1025)
end

function groundHugDay(name)
    sx, sy, sz = Spring.GetUnitPosition(unitID)
    globalHeightUnit = Spring.GetGroundHeight(sx, sz)
    x, y, z, _, _, _ = Spring.GetUnitPiecePosDir(unitID, name)
    myHeight = Spring.GetGroundHeight(x, z)
    heightdifference = math.abs(globalHeightUnit - myHeight)
    if myHeight < globalHeightUnit then heightdifference = -1*heightdifference end
	 return heightdifference
end

function Huskset(i)

    Move(Husk[i], z_axis, math.random(-40, 40), 0)
    Move(Husk[i], x_axis, math.random(-40, 40), 0, true)

    Show(Husk[i])
    --PseudoPhysix(Husk[i],Husk[i], 6)
    DropPieceToGround(unitID, Husk[i], 5, true, false)
    turnPieceRandDir(Husk[i], 0)
end

function shieldset(i)

    Show(Shield[i])
	 spinRand(Shield[i], 10,42,5)
	 local tx,ty,tz= math.random(-60, 60), math.random(40, 90) , math.random(-60, 60)
    mSyncIn(Shield[i],tx,ty,tz,1000)
	 WaitForMoves(Shield[i])
	 local reducefactor= 1
	 local t=700
	 EmitSfx(Shield[i],1025)
	 
	 while reducefactor > 0.001 and t > 5 do
		 mSyncIn(Shield[i],
		 tx + tx*reducefactor,
		 groundHugDay(Shield[i]),
		 tz + tz*reducefactor,
		 t)
		 
		 t= math.ceil((ty*reducefactor))*10
	
		 tx,tz=tx + tx*reducefactor,tz + tz*reducefactor
		 reducefactor=reducefactor/math.pi
		 WaitForMoves(Shield[i])
		 spawnCegAtPiece(unitID,Shield[i],"dirt",5)
		 
		 mSyncIn(Shield[i],
		 tx + tx*reducefactor,
		 ty*reducefactor ,
		 tz + tz*reducefactor,
		 t)	
		 
		 tx,tz=tx + tx*reducefactor,tz + tz*reducefactor
		 WaitForMoves(Shield[i])
		 Sleep(1)
	end
	mSyncIn(Shield[i],
		 tx + tx*reducefactor,
		 groundHugDay(Shield[i]),
		 tz + tz*reducefactor,
		 t)
	stopSpins(Shield[i])


end

function Pump1()
	Show(FloodRing)
    Turn(Flood, y_axis, 0, 0)
    Show(Drip1)
    moveUnitPieceToGroundPos(unitID, Drip1, math.random(-72, 72), math.random(-72, 72), 0,-10)
     
	Spin(Flood, z_axis, math.rad(-42), 1)
	rVal=math.random(-360,360)
	Turn(Drip1,y_axis,math.rad(rVal),0)
    Show(Flood)
    Show(Soup)
end

function Pump2()

    moveUnitPieceToGroundPos(unitID, Drip2, math.random(-72, 72), math.random(-72, 72), 0)
    Show(Drip2)

    while true do
        Turn(Drip2, y_axis, math.rad(math.random(-180, 180)), 0.002)
        xval = math.random(-18, 18)
        Turn(Drip2, z_axis, math.rad(xval), 0.02)
        Turn(ldrop, z_axis, math.rad(-xval), 0.2)
        WaitForTurn(Drip2, x_axis)
        Move(ldrop, y_axis, -5, 25)
        Show(ldrop)
        WaitForMove(ldrop, y_axis)
        Show(sdrop)
        Hide(ldrop)
        X, Y, Z = Spring.GetUnitPiecePosition(unitID, ldrop)
        Move(ldrop, y_axis, -35, 32)
        WaitForMove(ldrop, y_axis)
        EmitSfx(ldrop, 1025)
        Hide(sdrop)
        reset(sdrop)
        reset(ldrop)
        Sleep(300)
    end
end

targetPos = piece "targetPos"

function flailingFlesh()
    Show(MortalFlesh)
    showT(apend)
    val = math.random(0, 360)
    Turn(MortalFlesh, y_axis, math.rad(val), 0)
    showT(Leg)
    signum = -1
    live = math.ceil(math.random(20, 60) * 1000)

    speed = math.max(math.sqrt(speed), 0.001)
    while live > 0 do
        --echo("flailingFlesh")
        signum = signum * -1


        for i = 1, #Leg do
				if i % 2 == 0 then
					tSyncIn(Leg[i],math.random(10,60)*-1,math.random(-10,10),30,3000)
				else
					tSyncIn(Leg[i],math.random(10,60),math.random(-10,10),30,2000)
				end
        end
        val = iRand(-12, 12)
        valor = iRand(-12, 12)
        Turn(apend[1], y_axis, math.rad(signum * val), 0.13, false)
        Turn(apend[2], x_axis, math.rad(signum * val), 0.13, false)
        Turn(apend[1], x_axis, math.rad(signum * valor), 0.13, false)
        Turn(apend[2], x_axis, math.rad(signum * valor), 0.13, false)



        if live > 15000 then
            if maRa() == maRa() then
                pName = Leg[iRand(1, #Leg)]
                spawnCegAtPiece(unitID, pName, "greenbloodspray", 0)
            else
                pName = Balls[iRand(1, #Balls)]
                spawnCegAtPiece(unitID, pName, "bloodspray", 0)
            end
        end

        Sleep(2000)
        live = live - 2000
    end

    resetT(Leg, 0.1)
end

speed = 50
function maMa()

    linenumber = 1
    distx, disty = math.random(35, 60) * randSign(), math.random(35, 60) * randSign()
    Move(BabyWalk, x_axis, distx, 0)
    Move(BabyWalk, z_axis, disty, 0)


    Show(Baby)
    Show(Navel)
    BabyDir = 0

    signum = -1

    live = math.ceil(math.random(20, 60) * 1000)
    --echo("ljscrapheap:"..linenumber);linenumber=linenumber+1--2

    while live > 0 do
        distx, disty = math.random(35, 60) * randSign(), math.random(35, 60) * randSign()
        Move(Baby, y_axis, -4, 0)
        Move(Baby, x_axis, distx, 4.5)
        Move(Baby, z_axis, disty, 4.5)
        WaitForMoves(Baby)

        signum = signum * -1
        --Move Baby
        valLueSpin = iRand(15, 90) * signum
        Turn(Baby, y_axis, math.rad(valLueSpin), 0.3)
        valLueSpin = valLueSpin * -1
        Turn(Navel, y_axis, math.rad(valLueSpin), 0.3)
        WaitForTurn(Baby, y_axis)

        if maRa() == true then
            --echo("This kills it")
            bx, by, bz = Spring.GetUnitPiecePosition(unitID, targetPos)
            --echo("No This kills it")
            --	moveUnitPieceToGroundPos(unitID,Baby,bx,bz,0.2,-2)
            --echo("None of those kills it")
            Sleep(1000)
            WaitForTurns(Baby, Navel)
        end
        --echo("ljscrapheap:"..linenumber);linenumber=linenumber+1 --5
        Sleep(1000)
        live = live - 2000
    end

    --echo("Did you kill my mama")

    Hide(Baby)
    Hide(Navel)
end

function pipes(i)

    if maRa() == true then
        xval = math.random(-35, 35)
        zval = math.random(-35, 35)
        val = math.random(-42, 42)
        Spin(Pipe[i], y_axis, math.rad(val), 0.3)
        Move(Pipe[i], x_axis, xval, 0)
        Move(Pipe[i], y_axis, 50, 0)
        Move(Pipe[i], z_axis, zval, 0)
        if maRa() == true then
            dice = math.random(3, 9)
            for j = 1, dice, 1 do
                Turn(Pipe[i], x_axis, math.rad(10 * -1 ^ j), math.random(0.72, 0.75))
                Turn(Pipe[i], z_axis, math.rad(math.random(-30, 30)), 0.5)
                if math.random(0, 1) == 1 then
                    WaitForTurn(Pipe[i], x_axis)
                else
                    WaitForTurn(Pipe[i], z_axis)
                end
                Sleep(200)
            end
        else
            turnPieceRandDir(Pipe[i], 0, 30, -30, 360, -360, 30, -30)
        end


        Sleep(100)

        Show(Pipe[i])
        reset(Pipe[i], math.random(9, 22))
        Spin(Pipe[i], y_axis, math.rad(math.random(-42, 42)))
        WaitForTurn(Pipe[i], x_axis)
        WaitForTurn(Pipe[i], z_axis)
        WaitForMove(Pipe[i], y_axis)
        StopSpin(Pipe[i], y_axis)
        Turn(Pipe[i], y_axis, math.rad(0), 6)
        WaitForMove(Pipe[i], x_axis)
        WaitForMove(Pipe[i], z_axis)
    end
end


function TimeOfMyLife()

    SetSignalMask(SIG_DEATH)

    foo = function(pieces)
        dice = math.random(-1, 1)
        dice = (dice / math.abs(dice)) * -20
        Turn(pieces, x_axis, math.rad(dice), 0)
    end

    process(Shell, foo)

    Sleep(240000)
    Move(center, y_axis, -30, 1)
    WaitForMove(center, y_axis)
    Spring.DestroyUnit(unitID, false, false)
end

function script.Killed()
    return 1
end
TableOfPieceGroups= {}
function script.Create()

	TableOfPieceGroups = getPieceTableByNameGroups(false, true)
		Pillar=TableOfPieceGroups["Pillar"]
		spin=TableOfPieceGroups["spin"]

    init()
    if boolWeeImATree == false then
        x, y, z = Spring.GetUnitPosition(unitID)
        teamID = Spring.GetUnitTeam(unitID)
        GG.UnitsToSpawn:PushCreateUnit("gdecjscrapheap", x, y, z, 0, teamID)
    end

    StartThread(TimeOfMyLife)
    StartThread(contemplateOrigin)
end