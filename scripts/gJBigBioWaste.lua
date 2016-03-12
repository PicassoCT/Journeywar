boolCrawler=false
SIG_HEART= 1
SIG_BREATH=2
SIG_GALLE=4
SIG_CRAWL=8
SIG_LIVER=16
SIG_DEATH=32

function contemplateOrigin()
	boolPositionUnchanged=true
	xo,yo,zo=Spring.GetUnitPosition(unitID)
	while(boolPositionUnchanged==true) do
		x,y,z=Spring.GetUnitPosition(unitID)
		if x~=xo and z~=zo then
			boolPositionUnchanged=false
			for i=1,table.getn(Obj),1 do
				Hide(Obj[i])
			end
			Signal(SIG_DEATH)
		end
		Sleep(2000)
	end
end

function bodyBuilder()
	if boolCrawler==false then
		e=math.random(-36,36)
		Turn(kuttel,x_axis,math.rad(e),7)
		e=math.random(-12,12)
		Turn(kuttel,x_axis,math.rad(e),7)
		dice=math.random(0,1)
		if dice==1 then
			e=math.random(0,350)
			Turn(kuttel,x_axis,math.rad(e),0)
		end
	end
	for i=1,table.getn(Obj),1 do
		Dice=math.random(0,360)
		Dist=math.random(-2,2)
		Turn(Obj[i],y_axis,math.rad(Dice),0)
		Move(Obj[i],x_axis,math.rad(Dist),0)
	end
	if boolCrawler==false then
		for i=1,4,1 do
			Dice=math.random(0,360)
			DiceD=math.random(-35,36)
			Turn(behindlegs[i],y_axis,math.rad(Dice),0)
			Turn(behindlegs[i],z_axis,math.rad(DiceD),0)
			Dice=math.random(0,360)
			
			Turn(frontlegs[i],z_axis,math.rad(DiceD*-1),0)
			Turn(frontlegs[i],y_axis,math.rad(Dice),0)
		end
	end
	
	for i=1,4,1 do
		xdet=math.random(-15,15)
		Turn(GallenGang[i],x_axis,math.rad(xdet),6.8)
		zdet=math.random(-15,15)
		Turn(GallenGang[i],z_axis,math.rad(zdet),7.8)
	end	
	for i=1,4,1 do
		Hide(SpareRipps[i])
	end	
	
	dik=math.random(0,7)
	if dik== 1 or dik >4 then
		Hide(wall1)
		Hide(wall2)
		Hide(wall3)
		dice=math.random(0,1)
		if dice == 0 then
			for i=1,4,1 do
				Show(SpareRipps[i])
			end	
			throwit=math.random(0,7)
			if throwit== 3 then
				Hide(kuttel)
				for i=1,table.getn(ReizDarm),1 do
					Hide(ReizDarm[i])
				end
			end
		end
		
		
	elseif dik==2 then
		Hide(wall2)
		Hide(wall3)
	elseif dik== 3 then
		Hide(wall3)
	elseif dik== 4 then
		Hide(wall1)
	end
	
	Dicero=math.random(-39,39)
	Turn(ReizDarm[1],y_axis,math.rad(Dicero),0)
	x=math.random(0,1)
	if x==1 then
		Turn(ReizDarm[2],y_axis,math.rad(Dicero*-0.8),0)
	else
		Turn(ReizDarm[2],y_axis,math.rad(Dicero*0.8),0)
	end
	Turn(ReizDarm[3],y_axis,math.rad(Dicero*0.5),0)
	
	for i=1,8,1 do
		xdet=math.random(-15,15)
		Turn(Adder[i],x_axis,math.rad(xdet),0)
		zdet=math.random(-15,15)
		Turn(Adder[i],z_axis,math.rad(zdet),0)
	end
	
	if boolCrawler==false then
		d=math.random(-50,50)
		Turn(spine,x_axis,math.rad(d),0)
	end
	
	
	--walls
	dice=math.random(-31,59)
	Turn(wall3,x_axis,math.rad(dice),0)
	Turn(wall3,z_axis,math.rad(-9),0)
	Turn(wall3,y_axis,math.rad(-8),0)
	
	dice=math.random(-78,32)
	Turn(wall1,x_axis,math.rad(dice),0)
	
	dice=math.random(-109,59)
	Turn(wall2,x_axis,math.rad(dice),0)
	Turn(wall2,z_axis,math.rad(-2),0)
	Turn(wall2,y_axis,math.rad(-13),0)
	
	
end

function breath()
	SetSignalMask(SIG_BREATH)
	while(true)do
		randspeed=0.2
		Move(Lf2,y_axis,-1,randspeed)
		Move(Lf1,y_axis,-1,randspeed)
		
		WaitForMove(Lf1,y_axis)
		Sleep(100)
		Move(Lf2,y_axis,0,randspeed)
		Move(Lf1,y_axis,0,randspeed)
		WaitForMove(Lf1,y_axis)
		Sleep(100)
	end
end
function heartBeat()
	SetSignalMask(SIG_HEART)
	xi=0
	while(true)do 
		Move(leHrtChamb,y_axis,-2,4)
		Move(riHrtChamb,y_axis,0,4)
		xi=xi+15
		xi=xi%180
		for i=1,8,1 do
			xdet=math.random(-15,15)
			Turn(Adder[i],x_axis,math.rad(xdet),0.3)
			zdet=math.random(-15,15)
			Turn(Adder[i],z_axis,math.rad(zdet),0.3)
		end
		Turn(Adder[5],x_axis,math.rad(-46),0.4)
		Turn(Adder[1],x_axis,math.rad(-62),0.4)
		Turn(Adder[1],y_axis,math.rad(34),0.4)
		Turn(Adder[1],z_axis,math.rad(22),0.4)
		xTurn=math.random(-4,0)	
		zTurn=math.random(-8,-3)
		Turn(Heart,x_axis,math.rad(xTurn),0.2)	
		Turn(Heart,z_axis,math.rad(zTurn),0.2)	
		EmitSfx(Adder[4],1025)
		EmitSfx(Adder[4],1025)
		Sleep(50)
		EmitSfx(Adder[4],1025)
		EmitSfx(Adder[4],1025)
		rest=xi+700
		Sleep(rest)
		Move(leHrtChamb,y_axis,0,4)
		Move(riHrtChamb,y_axis,-2,4)
		Sleep(390)
		EmitSfx(Adder[8],1025)	
		EmitSfx(Adder[8],1025)
		Sleep(50)
		EmitSfx(Adder[8],1025)
		EmitSfx(Adder[8],1025)
		Sleep(390)
		
		Sleep(70)
		x,y,z=0
		dolan=math.random(1,4)
		if dolan==1 then
			x,y,z,_,_,_=Spring.GetUnitPiecePosDir(unitID, Adder[4])
		elseif dolan==2 then
			x,y,z,_,_,_=Spring.GetUnitPiecePosDir(unitID, Adder[8])
		elseif dolan==3 then
			x,y,z,_,_,_=Spring.GetUnitPiecePosDir(unitID, kuttel)
		else
			x,y,z,_,_,_=Spring.GetUnitPiecePosDir(unitID, Fetz[4])
		end
		teamID=Spring.GetGaiaTeamID()
		
		Spring.CreateUnit("blooddecalfactory",x,y,z,0,teamID)
		xTurn=math.random(4,7)	
		zTurn=math.random(3,7)
		Turn(Heart,x_axis,math.rad(xTurn),8)	
		Turn(Heart,z_axis,math.rad(zTurn),8)	
	end
	
	
	
end

function gallenstein()
	SetSignalMask(SIG_GALLE)
	while(true) do
		xRad=math.random(-5,5)
		yRad=math.random(-5,5)
		zRad=math.random(-5,5)
		Turn(Galle,x_axis,math.rad(xRad),0.2)
		Turn(Galle,y_axis,math.rad(yRad),0.2)
		Turn(Galle,z_axis,math.rad(zRad),0.2)
		for i=1,4,1 do
			xdet=math.random(-15,15)
			Turn(GallenGang[i],x_axis,math.rad(xdet),0.2)
			zdet=math.random(-15,15)
			Turn(GallenGang[i],z_axis,math.rad(zdet),0.2)
		end
		Sleep(1000)
		EmitSfx(GallenGang[4],1026)
		Sleep(100)
		EmitSfx(GallenGang[4],1026)
		Sleep(100)
		EmitSfx(GallenGang[4],1026)
		Sleep(100)
		
	end
end
boolOnOff=true
boolOnTheMove=false
local Dicero=0
local DiceroPercentage=0
local DiLeft=0
function darmwiggle()
	while(true) do
		
		while(boolOnTheMove==true) do
			Dicero=math.random(-39,39)
			DiceroPercentage=0
			DiLeft=math.random(0,1)
			
			while (DiceroPercentage < 100 and boolOnTheMove==true) do
				DiceroPercentage=DiceroPercentage+1
				for i=1,table.getn(ReizDarm),1 do
					if DiLeft==1 then
						if i== 1 then
							for i=1,table.getn(Fetz), 1 do
								Turn(Fetz[i],y_axis,math.rad((Dicero/100)*DiceroPercentage),1.2)
							end
							
							Turn(ReizDarm[1],y_axis,math.rad((Dicero/100)*DiceroPercentage),0.9)
						elseif i==2 then
							Turn(ReizDarm[2],y_axis,math.rad(((Dicero/100)*DiceroPercentage)*-0.8),0.9)
						else
							Turn(ReizDarm[3],y_axis,math.rad(((Dicero/100)*DiceroPercentage)*0.5),0.9)
						end
					else
						if i== 1 then
							for i=1,table.getn(Fetz), 1 do
								Turn(Fetz[i],y_axis,math.rad((Dicero/-100)*DiceroPercentage),1.2)
							end
							
							Turn(ReizDarm[1],y_axis,math.rad((Dicero/100)*DiceroPercentage*-1),0.9)
						elseif i==2 then
							Turn(ReizDarm[2],y_axis,math.rad(((Dicero/100)*DiceroPercentage)*0.8),0.9)
						else
							Turn(ReizDarm[3],y_axis,math.rad(((Dicero/100)*DiceroPercentage)*-0.5),0.9)
						end
					end
				end
				WaitForTurn(ReizDarm[1],y_axis)
				Sleep(10)
				
			end
			Sleep(100)
		end
		if DiLeft == 1 then
			Turn(ReizDarm[1],y_axis,math.rad((Dicero/100)*DiceroPercentage),0.9)
			Turn(ReizDarm[2],y_axis,math.rad(((Dicero/100)*DiceroPercentage)*-0.8),0.9)
			Turn(ReizDarm[3],y_axis,math.rad(((Dicero/100)*DiceroPercentage)*0.5),0.9)
			for i=1,table.getn(Fetz), 1 do
				Turn(Fetz[i],y_axis,math.rad((Dicero/100)*DiceroPercentage),1.2)
			end
			
		else
			Turn(ReizDarm[1],y_axis,math.rad((Dicero/100)*DiceroPercentage*-1),0.9)
			Turn(ReizDarm[2],y_axis,math.rad(((Dicero/100)*DiceroPercentage)*0.8),0.9)
			Turn(ReizDarm[3],y_axis,math.rad(((Dicero/100)*DiceroPercentage)*-0.5),0.9)
			for i=1,table.getn(Fetz), 1 do
				Turn(Fetz[i],y_axis,math.rad((Dicero/-100)*DiceroPercentage),1.2)
			end
		end
		Sleep(100)
	end
end
center= piece"center"
kuttel= piece"kuttel"
behindlegs={}
frontlegs={}

for i=1,4,1 do
	behindlegs[i]={}
	frontlegs[i]={}
	Emiters="bhleg"..i
	Demiters="foleg"..i
	behindlegs[i]=piece(Emiters)
	frontlegs[i]=piece(Demiters)
end

thehand=piece "thehand"
wall1=piece "wall1"
wall2=piece "wall2"
wall3=piece "wall3"
Heart=piece "Heart"
Liver=piece "Liver"
Galle=piece "Galle"
leHrtChamb=piece "leHrtChamb"
riHrtChamb=piece "riHrtChamb"

Lunge2= piece"Lunge2"
Lf1= piece"Lf1"
Lf2= piece"Lf2"
Lunge1= piece"Lunge1"
eye= piece"eye"
jaw= piece"jaw"
head= piece"head"
spine= piece"spine"
Mover= piece"Mover"

Obj={}
for i=1,10,1 do
	Obj[i]={}
	Emiters="obj"..i
	Obj[i]=piece(Emiters)
end

SpareRipps={}
for i=1,4,1 do
	SpareRipps[i]={}
	Emiters="rippe0"..i
	SpareRipps[i]=piece(Emiters)
end


Fetz={}
for i=1,4,1 do
	Fetz[i]={}
	Emiters="Fetz"..i
	Fetz[i]=piece(Emiters)
end

Adder={}
for i=1,8,1 do
	Adder[i]={}
	Emiters="add"..i
	Adder[i]=piece(Emiters)
end

ReizDarm={}
for i=1,3,1 do
	ReizDarm[i]={}
	Emiters="Darm"..i
	ReizDarm[i]=piece(Emiters)
end

GallenGang={}
for i=1,4,1 do
	GallenGang[i]={}
	Emiters="gal"..i
	GallenGang[i]=piece(Emiters)
end

undefinierbareKnubbel={}
for i=1,6,1 do
	undefinierbareKnubbel[i]={}
	Emiters="Kugel0"..i
	undefinierbareKnubbel[i]=piece(Emiters)
end

--[[

scrapH={}
for i=1,7,1 do
	scrapH[i]={}
	Emiters="scrapHeap"..i
	scrapH[i]=piece(Emiters)
end]]




function script.Killed()
	
end

function eyeOpen()
	Turn(eye,z_axis,math.rad(0),9)
	y_axed=math.rad(-25,25)
	Turn(eye,y_axis,math.rad(y_axed),4)
end

function eyeClose()
	Turn(eye,z_axis,math.rad(79),4)
	y_axed=math.rad(-25,25)
	Turn(eye,y_axis,math.rad(y_axed),4)
end

function crawlinInMySkin()
	SetSignalMask(SIG_CRAWL)
	while(true)do
		for i=1,table.getn(undefinierbareKnubbel),1 do
			randDel=math.random(-0.5,-0.3)
			Move(undefinierbareKnubbel[1],y_axis,-2,0.5)
			Move(undefinierbareKnubbel[1],x_axis,randDel,0.5)
			
		end
		
		WaitForMove(undefinierbareKnubbel[1],y_axis)
		for i=1,table.getn(undefinierbareKnubbel),1 do
			Move(undefinierbareKnubbel[1],y_axis,0,0.3)
			Move(undefinierbareKnubbel[1],x_axis,0,0.3)
		end
		WaitForMove(undefinierbareKnubbel[1],y_axis)
		Sleep(900)
	end
end
function canWeHaveYourLiverThen()
	SetSignalMask(SIG_LIVER)
	while(true) do
		if boolOnTheMove==true then
			MadreDiosEx=math.random(-68,20)
			Turn(Liver,y_axis,math.rad(MadreDiosEx),0.05)
			WaitForTurn(Liver,y_axis)
		end
		Sleep(100)
	end
end
-- function script.StartMoving()
-- boolOnTheMove=true

-- end

-- function script.StopMoving()
-- boolOnTheMove=false
-- end
function crawlAnim()
	boolOnTheMove=true
	eyeOpen()
	Turn(kuttel,y_axis,math.rad(-5),2.5)
	Turn(kuttel,z_axis,math.rad(-2),0.3)
	Turn(behindlegs[4],x_axis,math.rad(0),1.5)
	Turn(behindlegs[4],y_axis,math.rad(-7),1.5)
	Turn(behindlegs[4],z_axis,math.rad(26),1.5)
	Turn(frontlegs[4],y_axis,math.rad(7),1.5)
	Turn(frontlegs[4],z_axis,math.rad(-22),1.5)
	Turn(thehand,y_axis,math.rad(11),1.5)
	Turn(thehand,z_axis,math.rad(26),1.5)
	
	Turn(behindlegs[3],x_axis,math.rad(-4),1.5)
	Turn(behindlegs[3],y_axis,math.rad(101),5.5)
	Turn(behindlegs[3],z_axis,math.rad(1),1.5)
	
	Turn(frontlegs[3],y_axis,math.rad(47),1.5)
	Turn(frontlegs[3],x_axis,math.rad(0),1.5)
	Turn(frontlegs[3],z_axis,math.rad(0),1.5)
	
	Turn(behindlegs[2],x_axis,math.rad(0),5.5)
	Turn(behindlegs[2],y_axis,math.rad(130),2.5)
	Turn(behindlegs[2],z_axis,math.rad(22),1.5)
	
	Turn(frontlegs[2],x_axis,math.rad(0),1.5)
	Turn(frontlegs[2],y_axis,math.rad(68),3.5)
	Turn(frontlegs[2],z_axis,math.rad(-18),1.5)
	
	Turn(behindlegs[1],x_axis,math.rad(-48),5.5)
	Turn(behindlegs[1],y_axis,math.rad(-54),2.5)
	Turn(behindlegs[1],z_axis,math.rad(-38),1.5)
	
	Turn(frontlegs[1],x_axis,math.rad(81),1.5)
	Turn(frontlegs[1],y_axis,math.rad(0),3.5)
	Turn(frontlegs[1],z_axis,math.rad(79),1.5)
	
	Turn(spine,x_axis,math.rad(15),1.5)
	Turn(spine,z_axis,math.rad(7),1.5)
	
	Turn(head,x_axis,math.rad(15),1.5)
	Turn(head,y_axis,math.rad(-10),3.5)
	Turn(head,z_axis,math.rad(4),1.5)
	
	Turn(jaw,x_axis,math.rad(25),0.75)
	Sleep(500)
	eyeClose()
	Sleep(500)
	--
	Turn(kuttel,z_axis,math.rad(-1),0.3)
	eyeOpen()
	
	Turn(behindlegs[4],y_axis,math.rad(-82),1.5)
	Turn(behindlegs[4],z_axis,math.rad(5),1.5)
	
	Turn(frontlegs[4],x_axis,math.rad(7),1.5)
	Turn(frontlegs[4],y_axis,math.rad(97),1.5)
	Turn(frontlegs[4],z_axis,math.rad(-1),1.5)
	
	Turn(thehand,y_axis,math.rad(0),1.5)
	Turn(thehand,z_axis,math.rad(0),1.5)
	--x
	Turn(behindlegs[3],x_axis,math.rad(-36),1.5)
	Turn(behindlegs[3],y_axis,math.rad(26),5.5)
	Turn(behindlegs[3],z_axis,math.rad(-36),1.5)
	
	Turn(frontlegs[3],y_axis,math.rad(0),1.5)
	Turn(frontlegs[3],x_axis,math.rad(0),1.5)
	Turn(frontlegs[3],z_axis,math.rad(130),1.5)
	--x
	Turn(behindlegs[2],x_axis,math.rad(-16),5.5)
	Turn(behindlegs[2],y_axis,math.rad(153),2.5)
	Turn(behindlegs[2],z_axis,math.rad(0),1.5)
	
	Turn(frontlegs[2],x_axis,math.rad(0),1.5)
	Turn(frontlegs[2],y_axis,math.rad(0),3.5)
	Turn(frontlegs[2],z_axis,math.rad(0),1.5)
	
	Turn(behindlegs[1],x_axis,math.rad(-12),5.5)
	Turn(behindlegs[1],y_axis,math.rad(-121),2.5)
	Turn(behindlegs[1],z_axis,math.rad(-15),1.5)
	
	Turn(frontlegs[1],x_axis,math.rad(81),1.5)
	Turn(frontlegs[1],y_axis,math.rad(0),3.5)
	Turn(frontlegs[1],z_axis,math.rad(79),1.5)
	
	Turn(spine,x_axis,math.rad(-23),1.5)
	Turn(spine,z_axis,math.rad(-17),1.5)
	
	Turn(head,x_axis,math.rad(46),1.5)
	Turn(head,y_axis,math.rad(-10),3.5)
	Turn(head,z_axis,math.rad(6),1.5)
	
	Turn(jaw,x_axis,math.rad(32),0.75)
	Turn(jaw,y_axis,math.rad(12),0.75)
	Turn(jaw,z_axis,math.rad(-12),0.75)
	Turn(kuttel,y_axis,math.rad(5),2.5)
	Sleep(500)
	eyeClose()
	Sleep(500)
	eyeOpen()
	--
	Turn(kuttel,z_axis,math.rad(1),0.3)
	Turn(kuttel,y_axis,math.rad(0),2.5)
	--
	eyeOpen()
	
	Turn(behindlegs[4],x_axis,math.rad(19),1.5)
	Turn(behindlegs[4],y_axis,math.rad(-122),1.5)
	Turn(behindlegs[4],z_axis,math.rad(-13),1.5)
	
	Turn(frontlegs[4],x_axis,math.rad(-6),1.5)
	Turn(frontlegs[4],y_axis,math.rad(23),1.5)
	Turn(frontlegs[4],z_axis,math.rad(41),1.5)
	
	Turn(thehand,y_axis,math.rad(0),1.5)
	Turn(thehand,z_axis,math.rad(-37),1.5)
	--x
	Turn(behindlegs[3],x_axis,math.rad(-62),1.5)
	Turn(behindlegs[3],y_axis,math.rad(146),5.5)
	Turn(behindlegs[3],z_axis,math.rad(-32),1.5)
	
	Turn(frontlegs[3],y_axis,math.rad(0),1.5)
	Turn(frontlegs[3],x_axis,math.rad(0),1.5)
	Turn(frontlegs[3],z_axis,math.rad(71),1.5)
	--x
	Turn(behindlegs[2],x_axis,math.rad(-51),5.5)
	Turn(behindlegs[2],y_axis,math.rad(63),2.5)
	Turn(behindlegs[2],z_axis,math.rad(-34),1.5)
	
	Turn(frontlegs[2],x_axis,math.rad(0),1.5)
	Turn(frontlegs[2],y_axis,math.rad(0),3.5)
	Turn(frontlegs[2],z_axis,math.rad(90),1.5)
	
	Turn(behindlegs[1],x_axis,math.rad(0),5.5)
	Turn(behindlegs[1],y_axis,math.rad(-151),2.5)
	Turn(behindlegs[1],z_axis,math.rad(-13),1.5)
	
	Turn(frontlegs[1],x_axis,math.rad(81),1.5)
	Turn(frontlegs[1],y_axis,math.rad(49),3.5)
	Turn(frontlegs[1],z_axis,math.rad(79),1.5)
	
	Turn(spine,x_axis,math.rad(-23),1.5)
	Turn(spine,z_axis,math.rad(-1),1.5)
	
	Turn(head,x_axis,math.rad(0),1.5)
	Turn(head,y_axis,math.rad(17),3.5)
	Turn(head,z_axis,math.rad(-3),1.5)
	
	Turn(jaw,x_axis,math.rad(32),0.75)
	Turn(jaw,y_axis,math.rad(12),0.75)
	Turn(jaw,z_axis,math.rad(0),0.75)
	
	Turn(kuttel,y_axis,math.rad(5),2.5)
	Sleep(500)
	eyeClose()
	Sleep(500)
	eyeOpen()
	
	
	boolOnTheMove=false
	Turn(jaw,x_axis,math.rad(0),0.75)
	Turn(jaw,y_axis,math.rad(0),0.75)
	Turn(jaw,z_axis,math.rad(0),0.75)
end
function deadAnimation()
	Signal(SIG_HEART)
	Signal(SIG_BREATH)
	Signal(SIG_CRAWL)
	Signal(SIG_GALLE)
	Signal(SIG_LIVER)
	
	
end

function moveIt()
	Move(Mover,x_axis,85,0)
	Move(Mover,x_axis,44,1.5)
	while (true==Spring.UnitScript.IsInMove (Mover,x_axis)) do
		crawlAnim()
		Sleep(10)
	end
	Move(Mover,x_axis,0,1.5)
	while (true==Spring.UnitScript.IsInMove (Mover,x_axis)) do
		crawlAnim()
		Sleep(10)
	end
	Move(Mover,x_axis,-22,1.5)
	while (true==Spring.UnitScript.IsInMove (Mover,x_axis)) do
		crawlAnim()
		Sleep(10)
	end	
	deadAnimation()
end

function tillDeathDoAsPart()
	SetSignalMask(SIG_DEATH)
	Sleep(300000)
	Move(center,y_axis,-100,0.25)
	WaitForMove(center,y_axis)
	Spring.DestroyUnit(unitID,true,true)
end




function script.Create()
	dx=math.random(0,1)
	if dx== 1 then
		boolCrawler=true
		StartThread(breath)
		StartThread(gallenstein)
		StartThread(darmwiggle)
		StartThread(heartBeat)
		StartThread(crawlinInMySkin)
		StartThread(canWeHaveYourLiverThen)
		StartThread(moveIt)
	end
	
	bodyBuilder()
	StartThread(tillDeathDoAsPart)
	StartThread(contemplateOrigin)
end