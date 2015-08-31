	include "suddenDeath.lua"
	include "lib_OS.lua"
 include "lib_UnitScript.lua"
 include "lib_Build.lua" 

	
	--TODOs
	-- Ammonitionfactory
	-- Razordronefactory
	-- Jumpjets
	-- LazarusDevice
	-- Radar
	-- Jammer
	-- Shotgun
	-- TangleGun
	-- StarburstRockets
	-- AA-Rockets
	-- 10 Slicer
	-- Flaregun
	-- Eaters
	
	
	--<Localised Functions>
	local echo= Spring.Echo
	local spSetUnitExperience=	Spring.SetUnitExperience
	local spPlaySoundFile=Spring.PlaySoundFile
	local spGetUnitPiecePosDir=Spring.GetUnitPiecePosDir
	local spGetUnitHeading=Spring.GetUnitHeading
	--</Localised Functions>	
	
	--<PIECES>
	overArmour={}
	overArmour[1]={}

	overArmour[2]={}

	overArmour[3]={}

	
 Legg4={}
 
 ForwardHIP = piece"ForwardHIP"
 Legg4[#Legg4+1]={}
 Legg4[#Legg4]= ForwardHIP
 TR42 = piece"TR42"
 Legg4[#Legg4+1]={}
 Legg4[#Legg4]= TR42
 TR45 = piece"TR45"
 Legg4[#Legg4+1]={}
 Legg4[#Legg4]= TR45
 TR48 = piece"TR48"
 Legg4[#Legg4+1]={}
 Legg4[#Legg4]= TR48
 LS10 = piece"LS10"
 Legg4[#Legg4+1]={}
 Legg4[#Legg4]= LS10
 L49 = piece"L49"
 Legg4[#Legg4+1]={}
 Legg4[#Legg4]= L49
 LK09 = piece"LK09"
 Legg4[#Legg4+1]={}
 Legg4[#Legg4]= LK09
 LL51 = piece"LL51"
 Legg4[#Legg4+1]={}
 Legg4[#Legg4]= LL51
 LSK10 = piece"LSK10"
 Legg4[#Legg4+1]={}
 Legg4[#Legg4]= LSK10
 LLL50 = piece"LLL50"
 Legg4[#Legg4+1]={}
 Legg4[#Legg4]= LLL50
 LF3 = piece"LF3"
 Legg4[#Legg4+1]={}
 Legg4[#Legg4]= LF3
 cleanFoot3 = piece"cleanFoot3"
 Legg4[#Legg4+1]={}
 Legg4[#Legg4]= cleanFoot3

 
 
Legg3={}
 ForwardHIP = piece"ForwardHIP"
 Legg3[#Legg3+1]={}
 Legg3[#Legg3]= ForwardHIP
 LS09 = piece"LS09"
 Legg3[#Legg3+1]={}
 Legg3[#Legg3]= LS09
 L56 = piece"L56"
 Legg3[#Legg3+1]={}
 Legg3[#Legg3]= L56
 LK10 = piece"LK10"
 Legg3[#Legg3+1]={}
 Legg3[#Legg3]= LK10
 LL55 = piece"LL55"
 Legg3[#Legg3+1]={}
 Legg3[#Legg3]= LL55
 LSK09 = piece"LSK09"
 Legg3[#Legg3+1]={}
 Legg3[#Legg3]= LSK09
 LLL55 = piece"LLL55"
 Legg3[#Legg3+1]={}
 Legg3[#Legg3]= LLL55

 LF09 = piece"LF09"
 Legg3[#Legg3+1]={}
 Legg3[#Legg3]= LF09
 cleanFoot2 = piece"cleanFoot2"
 Legg3[#Legg3+1]={}
 Legg3[#Legg3]= cleanFoot2


 
 Legg5={}

 TRBACK = piece"TRBACK"
 Legg5[#Legg5+1]={}
 Legg5[#Legg5]= TRBACK
 TR52 = piece"TR52"
 Legg5[#Legg5+1]={}
 Legg5[#Legg5]= TR52
 TR55 = piece"TR55"
 Legg5[#Legg5+1]={}
 Legg5[#Legg5]= TR55
 TR56 = piece"TR56"
 Legg5[#Legg5+1]={}
 Legg5[#Legg5]= TR56
 TR57 = piece"TR57"
 Legg5[#Legg5+1]={}
 Legg5[#Legg5]= TR57
 TR58 = piece"TR58"
 Legg5[#Legg5+1]={}
 Legg5[#Legg5]= TR58
 LS11 = piece"LS11"
 Legg5[#Legg5+1]={}
 Legg5[#Legg5]= LS11
 L64 = piece"L64"
 Legg5[#Legg5+1]={}
 Legg5[#Legg5]= L64
 LK11 = piece"LK11"
 Legg5[#Legg5+1]={}
 Legg5[#Legg5]= LK11
 LL60 = piece"LL60"
 Legg5[#Legg5+1]={}
 Legg5[#Legg5]= LL60
 LSK11 = piece"LSK11"
 Legg5[#Legg5+1]={}
 Legg5[#Legg5]= LSK11
 LLL63 = piece"LLL63"
 Legg5[#Legg5+1]={}
 Legg5[#Legg5]= LLL63

 LF11 = piece"LF11"
 Legg5[#Legg5+1]={}
 Legg5[#Legg5]= LF11
 cleanFoot4 = piece"cleanFoot4"
 Legg5[#Legg5+1]={}
 Legg5[#Legg5]= cleanFoot4

 
 Legg6={}
 LS12 = piece"LS12"
 Legg6[#Legg6+1]={}
 Legg6[#Legg6]= LS12
 L57 = piece"L57"
 Legg6[#Legg6+1]={}
 Legg6[#Legg6]= L57
 LK12 = piece"LK12"
 Legg6[#Legg6+1]={}
 Legg6[#Legg6]= LK12
 LL64 = piece"LL64"
 Legg6[#Legg6+1]={}
 Legg6[#Legg6]= LL64
 LSK12 = piece"LSK12"
 Legg6[#Legg6+1]={}
 Legg6[#Legg6]= LSK12
 LLL58 = piece"LLL58"
 Legg6[#Legg6+1]={}
 Legg6[#Legg6]= LLL58
 LF12 = piece"LF12"
 Legg6[#Legg6+1]={}
 Legg6[#Legg6]= LF12
 cleanFoot5 = piece"cleanFoot5"
 Legg6[#Legg6+1]={}
 Legg6[#Legg6]= cleanFoot5

 ------------------------------------------------------------------------------
 
Leg1={}
L44 = piece"L44"
Leg1[#Leg1+1]={}
Leg1[#Leg1]= L44
LL40 = piece"LL40"
Leg1[#Leg1+1]={}
Leg1[#Leg1]= LL40
LLL41 = piece"LLL41"
Leg1[#Leg1+1]={}
Leg1[#Leg1]= LLL41

Leg2={}
LLL45 = piece"LLL45"
Leg2[#Leg2+1]={}
Leg2[#Leg2]= LLL45
LL44 = piece"LL44"
Leg2[#Leg2+1]={}
Leg2[#Leg2]= LL44
L48 = piece"L48"
Leg2[#Leg2+1]={}
Leg2[#Leg2]= L48
Leg3={}

L53 = piece"L53"
Leg3[#Leg3+1]={}
Leg3[#Leg3]= L53
LL52 = piece"LL52"
Leg3[#Leg3+1]={}
Leg3[#Leg3]= LL52
LLL49 = piece"LLL49"
Leg3[#Leg3+1]={}
Leg3[#Leg3]= LLL49

Leg4={}

LLL56 = piece"LLL56"
Leg4[#Leg4+1]={}
Leg4[#Leg4]= LLL56
LL48 = piece"LL48"
Leg4[#Leg4+1]={}
Leg4[#Leg4]= LL48
L52 = piece"L52"
Leg4[#Leg4+1]={}
Leg4[#Leg4]= L52
Leg5={}

L60 = piece"L60"
Leg5[#Leg5+1]={}
Leg5[#Leg5]= L60
LL57 = piece"LL57"
Leg5[#Leg5+1]={}
Leg5[#Leg5]= LL57
LLL64 = piece"LLL64"
Leg5[#Leg5+1]={}
Leg5[#Leg5]= LLL64
Leg6={}


LLL61 = piece"LLL61"
Leg6[#Leg6+1]={}
Leg6[#Leg6]= LLL61
LL61 = piece"LL61"
Leg6[#Leg6+1]={}
Leg6[#Leg6]= LL61
L61 = piece"L61"
Leg6[#Leg6+1]={}
Leg6[#Leg6]= L61

Arms={}
AL29 = piece"AL29"
Arms[#Arms+1]={}
Arms[#Arms]= AL29
A29 = piece"A29"
Arms[#Arms+1]={}
Arms[#Arms]= A29
AL25 = piece"AL25"
Arms[#Arms+1]={}
Arms[#Arms]= AL25
A26 = piece"A26"
Arms[#Arms+1]={}
Arms[#Arms]= A26


overArmour[1]={arms=Arms, leg1=Leg1,leg2=Leg2,leg3=Leg3,leg4=Leg4,leg5=Leg5,leg6=Leg6}

Leg1={}

L43 = piece"L43"
Leg1[#Leg1+1]={}
Leg1[#Leg1]= L43

LL41 = piece"LL41"
Leg1[#Leg1+1]={}
Leg1[#Leg1]= LL41
LLL42 = piece"LLL42"
Leg1[#Leg1+1]={}
Leg1[#Leg1]= LLL42


Leg2={}
LLL46 = piece"LLL46"
Leg2[#Leg2+1]={}
Leg2[#Leg2]= LLL46
L47 = piece"L47"
Leg2[#Leg2+1]={}
Leg2[#Leg2]= L47
LL45 = piece"LL45"
Leg2[#Leg2+1]={}
Leg2[#Leg2]= LL45

Leg3={}

L54 = piece"L54"
Leg3[#Leg3+1]={}
Leg3[#Leg3]= L54
LL53 = piece"LL53"
Leg3[#Leg3+1]={}
Leg3[#Leg3]= LL53
LLL53 = piece"LLL53"
Leg3[#Leg3+1]={}
Leg3[#Leg3]= LLL53

Leg4={}

L51 = piece"L51"
Leg4[#Leg4+1]={}
Leg4[#Leg4]= L51

LL49 = piece"LL49"
Leg4[#Leg4+1]={}
Leg4[#Leg4]= LL49

LLL52 = piece"LLL52"
Leg4[#Leg4+1]={}
Leg4[#Leg4]= LLL52

Leg5={}
L62 = piece"L62"
Leg5[#Leg5+1]={}
Leg5[#Leg5]= L62
LL58 = piece"LL58"
Leg5[#Leg5+1]={}
Leg5[#Leg5]= LL58
LLL65 = piece"LLL65"
Leg5[#Leg5+1]={}
Leg5[#Leg5]= LLL65

Leg6={}
L59 = piece"L59"
Leg6[#Leg6+1]={}
Leg6[#Leg6]= L59
LL62 = piece"LL62"
Leg6[#Leg6+1]={}
Leg6[#Leg6]= LL62
LLL60 = piece"LLL60"
Leg6[#Leg6+1]={}
Leg6[#Leg6]= LLL60

Arms={}
AL30 = piece"AL30"
Arms[#Arms+1]={}
Arms[#Arms]= AL30
A30 = piece"A30"
Arms[#Arms+1]={}
Arms[#Arms]= A30
AL26 = piece"AL26"
Arms[#Arms+1]={}
Arms[#Arms]= AL26
A27 = piece"A27"
Arms[#Arms+1]={}
Arms[#Arms]= A27


overArmour[2]={arms=Arms, leg1=Leg1,leg2=Leg2,leg3=Leg3,leg4=Leg4,leg5=Leg5,leg6=Leg6}


Leg1={}
L42 = piece"L42"
Leg1[#Leg1+1]={}
Leg1[#Leg1]= L42
LLL43 = piece"LLL43"
Leg1[#Leg1+1]={}
Leg1[#Leg1]= LLL43
LL42 = piece"LL42"
Leg1[#Leg1+1]={}
Leg1[#Leg1]= LL42


Leg2={}


LLL47 = piece"LLL47"
Leg2[#Leg2+1]={}
Leg2[#Leg2]= LLL47
LL46 = piece"LL46"
Leg2[#Leg2+1]={}
Leg2[#Leg2]= LL46
L46 = piece"L46"
Leg2[#Leg2+1]={}
Leg2[#Leg2]= L46

Leg3={}

L55 = piece"L55"
Leg3[#Leg3+1]={}
Leg3[#Leg3]= L55
LLL54 = piece"LLL54"
Leg3[#Leg3+1]={}
Leg3[#Leg3]= LLL54
LL54 = piece"LL54"
Leg3[#Leg3+1]={}
Leg3[#Leg3]= LL54

Leg4={}


LLL51 = piece"LLL51"
Leg4[#Leg4+1]={}
Leg4[#Leg4]= LLL51
LL50 = piece"LL50"
Leg4[#Leg4+1]={}
Leg4[#Leg4]= LL50
L50 = piece"L50"
Leg4[#Leg4+1]={}
Leg4[#Leg4]= L50

Leg5={}

L63 = piece"L63"
Leg5[#Leg5+1]={}
Leg5[#Leg5]= L63
LLL62 = piece"LLL62"
Leg5[#Leg5+1]={}
Leg5[#Leg5]= LLL62
LL59 = piece"LL59"
Leg5[#Leg5+1]={}
Leg5[#Leg5]= LL59
Leg6={}
LLL59 = piece"LLL59"
Leg6[#Leg6+1]={}
Leg6[#Leg6]= LLL59
LL63 = piece"LL63"
Leg6[#Leg6+1]={}
Leg6[#Leg6]= LL63
L58 = piece"L58"
Leg6[#Leg6+1]={}
Leg6[#Leg6]= L58

Arms={}

AL31 = piece"AL31"
Arms[#Arms+1]={}
Arms[#Arms]= AL31
A31 = piece"A31"
Arms[#Arms+1]={}
Arms[#Arms]= A31
AL27 = piece"AL27"
Arms[#Arms+1]={}
Arms[#Arms]= AL27
A28 = piece"A28"
Arms[#Arms+1]={}
Arms[#Arms]= A28


overArmour[3]={arms=Arms, leg1=Leg1,leg2=Leg2,leg3=Leg3,leg4=Leg4,leg5=Leg5,leg6=Leg6}

 Leg4={}
 

 shieldb22 = piece"shieldb22"
 Leg4[#Leg4+1]={}
 Leg4[#Leg4]= shieldb22
 shieldb25 = piece"shieldb25"
 Leg4[#Leg4+1]={}
 Leg4[#Leg4]= shieldb25
 
 
Leg3={}


 shieldb23 = piece"shieldb23"
 Leg3[#Leg3+1]={}
 Leg3[#Leg3]= shieldb23
 
 shieldb24 = piece"shieldb24"
 Leg3[#Leg3+1]={}
 Leg3[#Leg3]= shieldb24
 
 Leg5={}

 
 shieldb27 = piece"shieldb27"
 Leg5[#Leg5+1]={}
 Leg5[#Leg5]= shieldb27
 
 shieldb28 = piece"shieldb28"
 Leg5[#Leg5+1]={}
 Leg5[#Leg5]= shieldb28
 
 Leg6={}
 
 shieldb26 = piece"shieldb26"
 Leg6[#Leg6+1]={}
 Leg6[#Leg6]= shieldb26
 shieldb29 = piece"shieldb29"
 Leg6[#Leg6+1]={}
 Leg6[#Leg6]= shieldb29
	
Leg1={}
 shieldb26 = piece"shieldb26"
 Leg1[#Leg1+1]={}
 Leg1[#Leg1]= shieldb26
 shieldb29 = piece"shieldb29"
 Leg1[#Leg1+1]={}
 Leg1[#Leg1]= shieldb29

Leg2={}
 shieldb18 = piece"shieldb18"
 Leg2[#Leg2+1]={}
 Leg2[#Leg2]= shieldb18

 Leg2[#Leg2+1]={}
 Leg2[#Leg2]=  piece"shieldb17"

Arms={}



overArmour[4]={arms=Arms, leg1=Leg1,leg2=Leg2,leg3=Leg3,leg4=Leg4,leg5=Leg5,leg6=Leg6}


	
	
	local piecesTable={}

	center = piece"center"
	piecesTable[#piecesTable+1]= center
	testComEnder3DS = piece"testComEnder.3DS"
	piecesTable[#piecesTable+1]= testComEnder3DS
	CenterHip = piece"CenterHip"
	piecesTable[#piecesTable+1]= CenterHip
	LS08 = piece"LS08"
	piecesTable[#piecesTable+1]= LS08
	L45 = piece"L45"
	piecesTable[#piecesTable+1]= L45
	LK08 = piece"LK08"
	piecesTable[#piecesTable+1]= LK08
	LL46 = piece"LL46"
	piecesTable[#piecesTable+1]= LL46
	LSK08 = piece"LSK08"
	piecesTable[#piecesTable+1]= LSK08
	LLL48 = piece"LLL48"
	piecesTable[#piecesTable+1]= LLL48
	LF1 = piece"LF1"
	piecesTable[#piecesTable+1]= LF1
	cleanFoot1 = piece"cleanFoot1"
	piecesTable[#piecesTable+1]= cleanFoot1
	dirtyShoe1 = piece"dirtyShoe1"
	piecesTable[#piecesTable+1]= dirtyShoe1
	shieldb21 = piece"shieldb21"
	piecesTable[#piecesTable+1]= shieldb21
	shield20 = piece"shield20"
	piecesTable[#piecesTable+1]= shield20
	shieldb20 = piece"shieldb20"
	piecesTable[#piecesTable+1]= shieldb20
	shield19 = piece"shield19"
	piecesTable[#piecesTable+1]= shield19
	LLL47 = piece"LLL47"
	piecesTable[#piecesTable+1]= LLL47
	LLL46 = piece"LLL46"
	piecesTable[#piecesTable+1]= LLL46
	LLL45 = piece"LLL45"
	piecesTable[#piecesTable+1]= LLL45
	LL45 = piece"LL45"
	piecesTable[#piecesTable+1]= LL45
	LL47 = piece"LL47"
	piecesTable[#piecesTable+1]= LL47
	L46 = piece"L46"
	piecesTable[#piecesTable+1]= L46
	L47 = piece"L47"
	piecesTable[#piecesTable+1]= L47
	L48 = piece"L48"
	piecesTable[#piecesTable+1]= L48
	TR32 = piece"TR32"
	piecesTable[#piecesTable+1]= TR32
	TR33 = piece"TR33"
	piecesTable[#piecesTable+1]= TR33
	TR35 = piece"TR35"
	piecesTable[#piecesTable+1]= TR35
	TR36 = piece"TR36"
	piecesTable[#piecesTable+1]= TR36
	TR38 = piece"TR38"
	piecesTable[#piecesTable+1]= TR38
	LS07 = piece"LS07"
	piecesTable[#piecesTable+1]= LS07
	L44 = piece"L44"
	piecesTable[#piecesTable+1]= L44
	L43 = piece"L43"
	piecesTable[#piecesTable+1]= L43
	L42 = piece"L42"
	piecesTable[#piecesTable+1]= L42
	L41 = piece"L41"
	piecesTable[#piecesTable+1]= L41
	LK07 = piece"LK07"
	piecesTable[#piecesTable+1]= LK07
	LL41 = piece"LL41"
	piecesTable[#piecesTable+1]= LL41
	LL44 = piece"LL44"
	piecesTable[#piecesTable+1]= LL44
	LSK07 = piece"LSK07"
	piecesTable[#piecesTable+1]= LSK07
	LLL41 = piece"LLL41"
	piecesTable[#piecesTable+1]= LLL41
	LLL42 = piece"LLL42"
	piecesTable[#piecesTable+1]= LLL42
	LLL43 = piece"LLL43"
	piecesTable[#piecesTable+1]= LLL43
	LLL44 = piece"LLL44"
	piecesTable[#piecesTable+1]= LLL44
	shieldb17 = piece"shieldb17"
	piecesTable[#piecesTable+1]= shieldb17
	shield16 = piece"shield16"
	piecesTable[#piecesTable+1]= shield16
	LF07 = piece"LF07"
	piecesTable[#piecesTable+1]= LF07
	cleanFoot0 = piece"cleanFoot0"
	piecesTable[#piecesTable+1]= cleanFoot0
	dirtyShoe0 = piece"dirtyShoe0"
	piecesTable[#piecesTable+1]= dirtyShoe0
	shieldb18 = piece"shieldb18"
	piecesTable[#piecesTable+1]= shieldb18
	shield17 = piece"shield17"
	piecesTable[#piecesTable+1]= shield17
	LL42 = piece"LL42"
	piecesTable[#piecesTable+1]= LL42
	LL43 = piece"LL43"
	piecesTable[#piecesTable+1]= LL43
	ForwardHIP = piece"ForwardHIP"
	piecesTable[#piecesTable+1]= ForwardHIP
	TR42 = piece"TR42"
	piecesTable[#piecesTable+1]= TR42
	TR45 = piece"TR45"
	piecesTable[#piecesTable+1]= TR45
	TR48 = piece"TR48"
	piecesTable[#piecesTable+1]= TR48
	LS09 = piece"LS09"
	piecesTable[#piecesTable+1]= LS09
	L53 = piece"L53"
	piecesTable[#piecesTable+1]= L53
	L54 = piece"L54"
	piecesTable[#piecesTable+1]= L54
	L55 = piece"L55"
	piecesTable[#piecesTable+1]= L55
	L56 = piece"L56"
	piecesTable[#piecesTable+1]= L56
	LK10 = piece"LK10"
	piecesTable[#piecesTable+1]= LK10
	LL52 = piece"LL52"
	piecesTable[#piecesTable+1]= LL52
	LL55 = piece"LL55"
	piecesTable[#piecesTable+1]= LL55
	LSK09 = piece"LSK09"
	piecesTable[#piecesTable+1]= LSK09
	LLL49 = piece"LLL49"
	piecesTable[#piecesTable+1]= LLL49
	LLL53 = piece"LLL53"
	piecesTable[#piecesTable+1]= LLL53
	LLL54 = piece"LLL54"
	piecesTable[#piecesTable+1]= LLL54
	LLL55 = piece"LLL55"
	piecesTable[#piecesTable+1]= LLL55
	shieldb23 = piece"shieldb23"
	piecesTable[#piecesTable+1]= shieldb23
	shield21 = piece"shield21"
	piecesTable[#piecesTable+1]= shield21
	LF09 = piece"LF09"
	piecesTable[#piecesTable+1]= LF09
	cleanFoot2 = piece"cleanFoot2"
	piecesTable[#piecesTable+1]= cleanFoot2
	dirtyShoe2 = piece"dirtyShoe2"
	piecesTable[#piecesTable+1]= dirtyShoe2
	shieldb24 = piece"shieldb24"
	piecesTable[#piecesTable+1]= shieldb24
	shield22 = piece"shield22"
	piecesTable[#piecesTable+1]= shield22
	LL53 = piece"LL53"
	piecesTable[#piecesTable+1]= LL53
	LL54 = piece"LL54"
	piecesTable[#piecesTable+1]= LL54
	LS10 = piece"LS10"
	piecesTable[#piecesTable+1]= LS10
	L49 = piece"L49"
	piecesTable[#piecesTable+1]= L49
	LK09 = piece"LK09"
	piecesTable[#piecesTable+1]= LK09
	LL49 = piece"LL49"
	piecesTable[#piecesTable+1]= LL49
	LL51 = piece"LL51"
	piecesTable[#piecesTable+1]= LL51
	LSK10 = piece"LSK10"
	piecesTable[#piecesTable+1]= LSK10
	LLL50 = piece"LLL50"
	piecesTable[#piecesTable+1]= LLL50
	LF3 = piece"LF3"
	piecesTable[#piecesTable+1]= LF3
	cleanFoot3 = piece"cleanFoot3"
	piecesTable[#piecesTable+1]= cleanFoot3
	dirtyShoe3 = piece"dirtyShoe3"
	piecesTable[#piecesTable+1]= dirtyShoe3
	shieldb22 = piece"shieldb22"
	piecesTable[#piecesTable+1]= shieldb22
	shield23 = piece"shield23"
	piecesTable[#piecesTable+1]= shield23
	shieldb25 = piece"shieldb25"
	piecesTable[#piecesTable+1]= shieldb25
	shield24 = piece"shield24"
	piecesTable[#piecesTable+1]= shield24
	LLL51 = piece"LLL51"
	piecesTable[#piecesTable+1]= LLL51
	LLL52 = piece"LLL52"
	piecesTable[#piecesTable+1]= LLL52
	LLL56 = piece"LLL56"
	piecesTable[#piecesTable+1]= LLL56
	LL48 = piece"LL48"
	piecesTable[#piecesTable+1]= LL48
	LL50 = piece"LL50"
	piecesTable[#piecesTable+1]= LL50
	L50 = piece"L50"
	piecesTable[#piecesTable+1]= L50
	L51 = piece"L51"
	piecesTable[#piecesTable+1]= L51
	L52 = piece"L52"
	piecesTable[#piecesTable+1]= L52
	TRBACK = piece"TRBACK"
	piecesTable[#piecesTable+1]= TRBACK
	fspine03 = piece"fspine03"
	piecesTable[#piecesTable+1]= fspine03
	bpine02 = piece"bpine02"
	piecesTable[#piecesTable+1]= bpine02
	TR52 = piece"TR52"
	piecesTable[#piecesTable+1]= TR52
	TR55 = piece"TR55"
	piecesTable[#piecesTable+1]= TR55
	TR56 = piece"TR56"
	piecesTable[#piecesTable+1]= TR56
	TR57 = piece"TR57"
	piecesTable[#piecesTable+1]= TR57
	TR58 = piece"TR58"
	piecesTable[#piecesTable+1]= TR58
	LS11 = piece"LS11"
	piecesTable[#piecesTable+1]= LS11
	L61 = piece"L61"
	piecesTable[#piecesTable+1]= L61
	L62 = piece"L62"
	piecesTable[#piecesTable+1]= L62
	L63 = piece"L63"
	piecesTable[#piecesTable+1]= L63
	L64 = piece"L64"
	piecesTable[#piecesTable+1]= L64
	LK11 = piece"LK11"
	piecesTable[#piecesTable+1]= LK11
	LL57 = piece"LL57"
	piecesTable[#piecesTable+1]= LL57
	LL60 = piece"LL60"
	piecesTable[#piecesTable+1]= LL60
	LSK11 = piece"LSK11"
	piecesTable[#piecesTable+1]= LSK11
	LLL64 = piece"LLL64"
	piecesTable[#piecesTable+1]= LLL64
	LLL65 = piece"LLL65"
	piecesTable[#piecesTable+1]= LLL65
	LLL62 = piece"LLL62"
	piecesTable[#piecesTable+1]= LLL62
	LLL63 = piece"LLL63"
	piecesTable[#piecesTable+1]= LLL63
	shieldb27 = piece"shieldb27"
	piecesTable[#piecesTable+1]= shieldb27
	shield25 = piece"shield25"
	piecesTable[#piecesTable+1]= shield25
	LF11 = piece"LF11"
	piecesTable[#piecesTable+1]= LF11
	cleanFoot4 = piece"cleanFoot4"
	piecesTable[#piecesTable+1]= cleanFoot4
	dirtyShoe4 = piece"dirtyShoe4"
	piecesTable[#piecesTable+1]= dirtyShoe4
	shieldb28 = piece"shieldb28"
	piecesTable[#piecesTable+1]= shieldb28
	shield26 = piece"shield26"
	piecesTable[#piecesTable+1]= shield26
	LL58 = piece"LL58"
	piecesTable[#piecesTable+1]= LL58
	LL59 = piece"LL59"
	piecesTable[#piecesTable+1]= LL59
	LS12 = piece"LS12"
	piecesTable[#piecesTable+1]= LS12
	L57 = piece"L57"
	piecesTable[#piecesTable+1]= L57
	LK12 = piece"LK12"
	piecesTable[#piecesTable+1]= LK12
	LL62 = piece"LL62"
	piecesTable[#piecesTable+1]= LL62
	LL64 = piece"LL64"
	piecesTable[#piecesTable+1]= LL64
	LSK12 = piece"LSK12"
	piecesTable[#piecesTable+1]= LSK12
	LLL58 = piece"LLL58"
	piecesTable[#piecesTable+1]= LLL58
	LF12 = piece"LF12"
	piecesTable[#piecesTable+1]= LF12
	cleanFoot5 = piece"cleanFoot5"
	piecesTable[#piecesTable+1]= cleanFoot5
	dirtyShoe5 = piece"dirtyShoe5"
	piecesTable[#piecesTable+1]= dirtyShoe5
	shieldb26 = piece"shieldb26"
	piecesTable[#piecesTable+1]= shieldb26
	shield27 = piece"shield27"
	piecesTable[#piecesTable+1]= shield27
	shieldb29 = piece"shieldb29"
	piecesTable[#piecesTable+1]= shieldb29
	shield28 = piece"shield28"
	piecesTable[#piecesTable+1]= shield28
	LLL59 = piece"LLL59"
	piecesTable[#piecesTable+1]= LLL59
	LLL60 = piece"LLL60"
	piecesTable[#piecesTable+1]= LLL60
	LLL61 = piece"LLL61"
	piecesTable[#piecesTable+1]= LLL61
	LL61 = piece"LL61"
	piecesTable[#piecesTable+1]= LL61
	LL63 = piece"LL63"
	piecesTable[#piecesTable+1]= LL63
	L58 = piece"L58"
	piecesTable[#piecesTable+1]= L58
	L59 = piece"L59"
	piecesTable[#piecesTable+1]= L59
	L60 = piece"L60"
	piecesTable[#piecesTable+1]= L60
	spinMe = piece"spinMe"
	piecesTable[#piecesTable+1]= spinMe
	glaunch = piece"glaunch"
	piecesTable[#piecesTable+1]= glaunch
	mag1 = piece"mag1"
	piecesTable[#piecesTable+1]= mag1
	gr1 = piece"gr1"
	piecesTable[#piecesTable+1]= gr1
	gr2 = piece"gr2"
	piecesTable[#piecesTable+1]= gr2
	gr3 = piece"gr3"
	piecesTable[#piecesTable+1]= gr3
	gr4 = piece"gr4"
	piecesTable[#piecesTable+1]= gr4
	mag2 = piece"mag2"
	piecesTable[#piecesTable+1]= mag2
	mag3 = piece"mag3"
	piecesTable[#piecesTable+1]= mag3
	gGrenade = piece"gGrenade"
	piecesTable[#piecesTable+1]= gGrenade
	bb05 = piece"bb05"
	piecesTable[#piecesTable+1]= bb05
	bb06 = piece"bb06"
	piecesTable[#piecesTable+1]= bb06
	bb07 = piece"bb07"
	piecesTable[#piecesTable+1]= bb07
	bb08 = piece"bb08"
	piecesTable[#piecesTable+1]= bb08
	HA08 = piece"HA08"
	piecesTable[#piecesTable+1]= HA08
	AmmoFlareGunTurret = piece"AmmoFlareGunTurret"
	piecesTable[#piecesTable+1]= AmmoFlareGunTurret
	EYE01 = piece"EYE01"
	piecesTable[#piecesTable+1]= EYE01
	HA05 = piece"HA05"
	piecesTable[#piecesTable+1]= HA05
	HA06 = piece"HA06"
	piecesTable[#piecesTable+1]= HA06
	HA07 = piece"HA07"
	piecesTable[#piecesTable+1]= HA07
	HA09 = piece"HA09"
	piecesTable[#piecesTable+1]= HA09
	sniper = piece"sniper"
	piecesTable[#piecesTable+1]= sniper
	ARML = piece"ARML"
	piecesTable[#piecesTable+1]= ARML
	A32 = piece"A32"
	piecesTable[#piecesTable+1]= A32
	AS04 = piece"AS04"
	piecesTable[#piecesTable+1]= AS04
	AL29 = piece"AL29"
	piecesTable[#piecesTable+1]= AL29
	AL30 = piece"AL30"
	piecesTable[#piecesTable+1]= AL30
	AL31 = piece"AL31"
	piecesTable[#piecesTable+1]= AL31
	AL32 = piece"AL32"
	piecesTable[#piecesTable+1]= AL32
	SMG04 = piece"SMG04"
	piecesTable[#piecesTable+1]= SMG04
	SMG1B03 = piece"SMG1B03"
	piecesTable[#piecesTable+1]= SMG1B03
	SMG_EMIT1 = piece"SMG_EMIT1"
	piecesTable[#piecesTable+1]= SMG_EMIT1
	SMG1B04 = piece"SMG1B04"
	piecesTable[#piecesTable+1]= SMG1B04
	SMG_EMIT2 = piece"SMG_EMIT2"
	piecesTable[#piecesTable+1]= SMG_EMIT2
	A29 = piece"A29"
	piecesTable[#piecesTable+1]= A29
	A30 = piece"A30"
	piecesTable[#piecesTable+1]= A30
	A31 = piece"A31"
	piecesTable[#piecesTable+1]= A31
	ARMR = piece"ARMR"
	piecesTable[#piecesTable+1]= ARMR
	A25 = piece"A25"
	piecesTable[#piecesTable+1]= A25
	AS03 = piece"AS03"
	piecesTable[#piecesTable+1]= AS03
	AL25 = piece"AL25"
	piecesTable[#piecesTable+1]= AL25
	AL26 = piece"AL26"
	piecesTable[#piecesTable+1]= AL26
	AL27 = piece"AL27"
	piecesTable[#piecesTable+1]= AL27
	AL28 = piece"AL28"
	piecesTable[#piecesTable+1]= AL28
	SMG03 = piece"SMG03"
	piecesTable[#piecesTable+1]= SMG03
	SMG2B03 = piece"SMG2B03"
	piecesTable[#piecesTable+1]= SMG2B03
	SMG_EMIT4 = piece"SMG_EMIT4"
	piecesTable[#piecesTable+1]= SMG_EMIT4
	SMG2B04 = piece"SMG2B04"
	piecesTable[#piecesTable+1]= SMG2B04
	SMG_EMIT3 = piece"SMG_EMIT3"
	piecesTable[#piecesTable+1]= SMG_EMIT3
	SunBurst2 = piece"SunBurst2"
	piecesTable[#piecesTable+1]= SunBurst2
	SunBurst3 = piece"SunBurst3"
	piecesTable[#piecesTable+1]= SunBurst3
	


	
	MagneticSh = piece"MagneticSh"
	piecesTable[#piecesTable+1]= MagneticSh
	spear = piece"spear"
	piecesTable[#piecesTable+1]= spear
	ShotArm02 = piece"ShotArm02"
	piecesTable[#piecesTable+1]= ShotArm02
	ShotArm03 = piece"ShotArm03"
	piecesTable[#piecesTable+1]= ShotArm03
	ShotArm05 = piece"ShotArm05"
	piecesTable[#piecesTable+1]= ShotArm05
	ShotArm07 = piece"ShotArm07"
	piecesTable[#piecesTable+1]= ShotArm07
	ShotArm09 = piece"ShotArm09"
	piecesTable[#piecesTable+1]= ShotArm09
	shotgunEmit2 = piece"shotgunEmit2"
	piecesTable[#piecesTable+1]= shotgunEmit2
	shotgunEmit1 = piece"shotgunEmit1"
	piecesTable[#piecesTable+1]= shotgunEmit1
	shotgunEmit3 = piece"shotgunEmit3"
	piecesTable[#piecesTable+1]= shotgunEmit3
	bullets = piece"bullets"
	piecesTable[#piecesTable+1]= bullets
	
	
	cMagneto={}
	
	cMagneto[#cMagneto+1]= MagneticSh

	cMagneto[#cMagneto+1]= spear

	cMagneto[#cMagneto+1]= ShotArm02

	cMagneto[#cMagneto+1]= ShotArm03
	
	cMagneto[#cMagneto+1]= ShotArm05

	cMagneto[#cMagneto+1]= ShotArm07

	cMagneto[#cMagneto+1]= ShotArm09

	cMagneto[#cMagneto+1]= shotgunEmit2

	cMagneto[#cMagneto+1]= shotgunEmit1

	cMagneto[#cMagneto+1]= shotgunEmit3

	SunBurstTable={}
	
	
	SunBurst1 = piece"SunBurst1"
	piecesTable[#piecesTable+1]= SunBurst1
	table.insert(SunBurstTable,SunBurst1)
	table.insert(SunBurstTable,SunBurst2)
	table.insert(SunBurstTable,SunBurst3)
	
	A26 = piece"A26"
	piecesTable[#piecesTable+1]= A26
	A27 = piece"A27"
	piecesTable[#piecesTable+1]= A27
	A28 = piece"A28"
	piecesTable[#piecesTable+1]= A28
	You = piece"You"
	piecesTable[#piecesTable+1]= You
	
	bpine02 = piece"bpine02"
	piecesTable[#piecesTable+1]= bpine02	
	fspine03 = piece"fspine03"
	piecesTable[#piecesTable+1]= fspine03
	shieldb19 = piece"shieldb19"
	piecesTable[#piecesTable+1]= shieldb19
	shield18 = piece"shield18"
	piecesTable[#piecesTable+1]= shield18
	shieldb16 = piece"shieldb16"
	piecesTable[#piecesTable+1]= shieldb16
	shield15 = piece"shield15"
	piecesTable[#piecesTable+1]= shield15
	fspine04 = piece"fspine04"
	piecesTable[#piecesTable+1]= fspine04
	fspine05 = piece"fspine05"
	piecesTable[#piecesTable+1]= fspine05
	ArmourTable={}
	ArmourTable[#ArmourTable+1]=HA07
	ArmourTable[#ArmourTable+1]=HA06
	ArmourTable[#ArmourTable+1]=HA09
	ArmourTable[#ArmourTable+1]=HA05
	
	
	
	Bolt = piece"Bolt"
	piecesTable[#piecesTable+1]= Bolt	
	Case = piece"Case"
	piecesTable[#piecesTable+1]= Case
	pin = piece"pin"
	piecesTable[#piecesTable+1]= pin
	drum = piece"drum"
	piecesTable[#piecesTable+1]= drum
	

	
	guidedMissile=makeTableOfPieceNames("guided",3,1)
	for i=1,#guidedMissile do guidedMissile[i]=piece(guidedMissile[i])end
	
	unguidedMissile=makeTableOfPieceNames("unguided",3,1)
	for i=1,#unguidedMissile do unguidedMissile[i]=piece(unguidedMissile[i])end
	
	TangleGun=piece"TangleGun"
	TangleRota=piece"TangleRota"
	TangleBase=piece"TangleBase"
	tangleGun={}

	tangleGun[#tangleGun+1]=TangleGun
	tangleGun[#tangleGun+1]=TangleBase
	tangleGun[#tangleGun+1]=TangleRota


	
	cSniper={}
	cSniper[#cSniper+1]={}
	cSniper[#cSniper]=sniper
	cSniper[#cSniper+1]={}
	cSniper[#cSniper]=drum
	cSniper[#cSniper+1]={}
	cSniper[#cSniper]=Bolt
	cSniper[#cSniper+1]={}
	cSniper[#cSniper]=pin
	cSniper[#cSniper+1]={}
	cSniper[#cSniper]=Case
	
	
	sniperAmmoTable={}
	sniperAmmoIterator=1
	for i=1,12, 1 do
	name="Ammo0"..i
	x = piece(name)
	piecesTable[#piecesTable+1]= x
	cSniper[#cSniper+1]=x
	sniperAmmoTable[#sniperAmmoTable+1]=x
	end
	
	FlareGun={}
	
	fieldscooper = piece"fieldscooper"
	piecesTable[#piecesTable+1]= fieldscooper
	
	cFieldScooper={} 
	cFieldScooper[#cFieldScooper+1]=fieldscooper
	projector1=piece"projector1"
	projector2=piece"projector2"
	projector3=piece"projector3"
	cFieldScooper[#cFieldScooper+1]=projector1
	cFieldScooper[#cFieldScooper+1]=projector2
	cFieldScooper[#cFieldScooper+1]=projector3
	
	LegsTable={}
	for i=8,12, 1 do
	x=i
	if x < 10 then x="0"..x end
	name= "LS"..x
	temp_O_Rary = piece(name)	
		LegsTable[#LegsTable+1]={}
		LegsTable[#LegsTable]=temp_O_Rary
	end

 BaseArmor = {}
 BaseArmor[1] = piece"HA07"
 BaseArmor[2] = piece"HA06"
 BaseArmor[3] = piece"HA09"
 BaseArmor[4] = piece"HA05"


	--</PIECES>


	basics={}
	----[[
	basics[#basics+1]=HA08
	basics[#basics+1]=bb05
	basics[#basics+1]=bb06
	basics[#basics+1]=bb07
	basics[#basics+1]=bb08

	basics[#basics+1]=ARML
	basics[#basics+1]=A32
	basics[#basics+1]=A28
	basics[#basics+1]=You
	basics[#basics+1]=AS04
	basics[#basics+1]=AS03
	basics[#basics+1]=AL32
	basics[#basics+1]=AL28
	basics[#basics+1]=SMG04
	basics[#basics+1]=SMG03


	basics[#basics+1]=ARMR

	basics[#basics+1]=SMG2B03
	basics[#basics+1]=SMG2B04
	basics[#basics+1]=SMG1B03
	basics[#basics+1]=SMG1B04
	basics[#basics+1]=EYE01
	basics[#basics+1]=LS08
	--TODOx
	basics[#basics+1]=CenterHip
	basics[#basics+1]=LS07

	basics[#basics+1]=LSK08
	basics[#basics+1]=LSK07

	basics[#basics+1]=L41
	basics[#basics+1]=L45



	basics[#basics+1]=LK07
	basics[#basics+1]=LK08

	basics[#basics+1]=LLL46
	basics[#basics+1]=LLL44


	basics[#basics+1]=LL44
	basics[#basics+1]=LF1
	basics[#basics+1]=LF07
	basics[#basics+1]=cleanFoot0
	basics[#basics+1]=cleanFoot1
	basicsStart=#basics
	basics[#basics+1]=TR32
	basics[#basics+1]=TR33
	basics[#basics+1]=TR34
	basics[#basics+1]=TR35
	basics[#basics+1]=TR36
	basics[#basics+1]=TR38
	for i=basicsStart, #basics,1 do
	Spin(basics[i],x_axis,math.rad(42*-1^i),0.01)
	end
	
	SliceGun={}

	gLauncher={}
	gLauncher[#gLauncher+1]=bpine02
	gLauncher[#gLauncher+1]=fspine03
	gLauncher[#gLauncher+1]=TRBACK
	gLauncher[#gLauncher+1]=spinMe
	gLauncher[#gLauncher+1]=glaunch
	gLauncher[#gLauncher+1]=gr1
	gLauncher[#gLauncher+1]=gr2
	gLauncher[#gLauncher+1]=gr3
	gLauncher[#gLauncher+1]=gr4
	gLauncher[#gLauncher+1]=mag1
	gLauncher[#gLauncher+1]=mag2
	gLauncher[#gLauncher+1]=mag3

	smg={}
	smg[#smg+1]=SMG04
	smg[#smg+1]=SMG03
	smg[#smg+1]=SMG2B03
	smg[#smg+1]=SMG2B04
	smg[#smg+1]=SMG1B03
	smg[#smg+1]=SMG1B04

	starburst={}
	starburst[#starburst+1]=SunBurst1
	starburst[#starburst+1]=SunBurst2
	starburst[#starburst+1]=SunBurst3

	--/changed

	--]]
	--<STATS>
	boolCanFire=true
	Experience=0.0
	Armoure=0
	Stats={}
	--Speed can sin below 1.0 resulting in a stationary comender
	walkSpeed=1.0 --final result
	currSpeed=1.0 --speed the whole unit got upgraded to
	walkSpeedLimit=3.0 --maximum

	Stats[1]={}
	Stats[1][1]=walkSpeed
	Stats[1][2]=walkSpeedLimit
	Stats[1][3]=Armoure
	Stats[1][4]=4		--ArmourMax



	-- stability is mainly reduced by weapons.. comender can topple over if firing with to low stability
	Stats[1][5]=2.0		--stability   --the CalcedValue

	Stats[1][6]=0.05	--stabilityRegenerationRate
	Stats[1][7]=6		--stabilityMax
	Stats[2]={}
	Stats[2][5]=2
	
	Stats[1][8]=1.0--SensorRadiusLVL
	Stats[1][9]=Spring.GetUnitSensorRadius(unitID,"los")--sensorRadius
	Stats[1][10]=5
	

	
	
	shieldsToShowWrap={}

	for i=16, 28, 1 do
		shieldsToShowWrap[#shieldsToShowWrap+1]={}
		piecename="shield"..i
		shieldsToShowWrap[#shieldsToShowWrap]=piece(piecename)

	end


	--ammonition -is refilled at the citadell
	ammonition=100
	ammonitionMax=100

	local teamID=Spring.GetUnitTeam(unitID)
	--</STATS>
	--<ONUPGRADESHOW>
	function showShotgun()
		for i=1,table.getn(cMagneto),1 do
		Show(cMagneto[i])
		end
	Spin(bullets,y_axis,math.rad(-42),0.01)
	Spin(bullets,x_axis,math.rad(42),0.01)
	Spin(bullets,z_axis,math.rad(24),0.01)
	end
	
	function showSunburst()
		if 	Weapons[8][1]== 1 then Show(SunBurst1) end
		if 	Weapons[8][1]== 2 then Show(SunBurst2) end
		if 	Weapons[8][1]== 3 then Show(SunBurst3) end
	end
	function showGLauncher()
		 for i=1,#gLauncher,1 do 
			Show(gLauncher[i])
		 end 
	 end  
	function showStarBurst()
	Show(starburst[1])
	end
	function showTangleGun()
	showT(tangleGun)
	Spin(TangleRota,y_axis,math.rad(-512),0.5)
	Spin(TangleRota,x_axis,math.rad(-12),0.5)
	end
	function showSliceGun()
		showT(cFieldScooper) 
	end
	
	function showSniper()
		for i=1,#cSniper,1 do
		Show(cSniper[i])
		end	
	end
	
	function showFlareGun()
	
		Show(AmmoFlareGunTurret)
		
	end
	 
	function showSMG() 
		 for i=1,#smg,1 do
		 Show(smg[i]) 
		 end 
	 end 
	previous=nil
	function showT(able)
		for i=1, table.getn(able), 1 do
	
	
		Show(able[i])
		end
	end
	
	function showArmor()

	for i=1, Stats[1][3], 1 do
		showT(overArmour[i].arms)
		Show(BaseArmor[i])
	end
	
	Nr=Stats[2][5]

	if Nr < 3 then
	for i=1, Stats[1][3], 1 do
		showT(overArmour[i].leg1)
		showT(overArmour[i].leg2)
	end
	elseif Nr < 4 and Nr > 3 then 
		for i=1, Stats[1][3], 1 do
		showT(overArmour[i].leg1)
		showT(overArmour[i].leg2)
		showT(overArmour[i].leg3)
		end
	
	elseif Nr < 5 then
		for i=1, Stats[1][3], 1 do
		showT(overArmour[i].leg1)
		showT(overArmour[i].leg2)
		showT(overArmour[i].leg3)
		showT(overArmour[i].leg4)
		end
	
	elseif Nr < 6 then
	Show(fspine03)
	Show(bpine02)
		for i=1, Stats[1][3], 1 do
		showT(overArmour[i].leg1)
		showT(overArmour[i].leg2)
		showT(overArmour[i].leg3)
		showT(overArmour[i].leg4)
		showT(overArmour[i].leg5)
		end
	elseif Nr < 7 then
		for i=1, Stats[1][3], 1 do
		showT(overArmour[i].leg1)
		showT(overArmour[i].leg2)
		showT(overArmour[i].leg3)
		showT(overArmour[i].leg4)
		showT(overArmour[i].leg5)
		showT(overArmour[i].leg6)
		end
	
	end

	end
	 
	function showLegs()--The Basic Legs - No Armor
	Nr=Stats[2][5]

	--echo(Nr)
	
	
	if Nr > 2 then 
	Show(fspine04)
	Show(fspine05)
	showT(Legg3)
	
	end
	
	
	if Nr > 3 then
		showT(Legg3)
		showT(Legg4)
		
	end
	
	if Nr > 4 then
			Show(fspine03)
			Show(bpine02)
			showT(Legg3)
			showT(Legg4)
			showT(Legg5)
	end	
	
	if Nr > 5 then
				showT(Legg3)
				showT(Legg4)
				showT(Legg5)
				showT(Legg6)
				
	end
	showArmor()
	
	end
	
	function showTime()
		while true do
		Sleep(250)
		showLegs()
		showArmor()
			for i=1, #Weapons, 1 do
				if Weapons[i][1] > 0 then
				d=Weapons[i][4]()
				end
			end
		end
	
	end
	--</ONUPGRADESHOW>
	--<WEAPONS>
	Weapons={}
	--MaschineGun

	Weapons[1]={}  
	Weapons[1][1]=1   				     --WeaponLevel        
	Weapons[1][2]=3        				 --WeaponMax       
	Weapons[1][3]=smg       
	Weapons[1][4]=  showSMG             
	Weapons[1][5]=  0.1        		  --AmmoCost	 	        
	Weapons[1][6]=  0.1        		  --StabilityCost	        
	Weapons[1][7]=  1        		  --PriorityLevel the bigger the more Priority it Got	 --Priority 0 equals can fire at all times
   
	--Sniper
	Weapons[2]={}    
	Weapons[2][1]=0   				     --WeaponLevel         
	Weapons[2][2]=3        				 --WeaponMax
	Weapons[2][3]=cSniper     
	Weapons[2][4]=  showSniper         
	Weapons[2][5]=  0.5        		  	--AmmoCost	        
	Weapons[2][6]=  0.5        		  	--StabilityCost	     
	Weapons[2][7]=  9        		  	--PriorityLevel the bigger the more Priority it Got       
	Weapons[2][8]=  19000        		--Downtime  
	Weapons[2][9]= 3   		 	 	--RecoilMax         
	--GrenadeLauncher
	Weapons[3]={}
	Weapons[3][1]=0   				     --WeaponLevel 
	Weapons[3][2]=3        				 --WeaponMax
	Weapons[3][3]={}         
	Weapons[3][3]=gLauncher
	Weapons[3][4]={}         
	Weapons[3][4]=showGLauncher                    		 
	Weapons[3][5]=1                  	--AmmoCost    
	Weapons[3][6]=  0.35        		--StabilityCost	
	Weapons[3][7]=  3        		  	--PriorityLevel the bigger the more Priority it Got
	Weapons[3][8]=  1000        		--Downtime
	Weapons[3][9]=  0.35  				--RecoilMax         
	--StarburstRocket
	Weapons[4]={}
	Weapons[4][1]=0   				     --WeaponLevel   
	Weapons[4][2]=3        				 --WeaponMax    
	Weapons[4][3]=starburst       
	Weapons[4][4]=showStarBurst                    		       
	Weapons[4][5]=1                  	  --AmmoCost           
	Weapons[4][6]=  0.25        		  --StabilityCost	 
	Weapons[4][7]=  9        		  	  --PriorityLevel the bigger the more Priority it Got
	Weapons[4][8]=  2000        		  --Downtime
	Weapons[4][9]=  0.1        		  	  --RecoilMax	
	--SliceGun
	Weapons[5]={}
	Weapons[5][1]={}       
	Weapons[5][1]=0   					--	WeaponLevel   
	Weapons[5][2]=3						--  WeaponMax    
	Weapons[5][3]= cFieldScooper[1]					--  CurrentPiece   
	Weapons[5][4]=showSliceGun				    
	Weapons[5][5]= true					--  fireReady
	Weapons[5][6]= 6000					--  CurrentCoolDownTime
	Weapons[5][7]= 5					--  Priority
	Weapons[5][8]= 1					--  AmmoCost

	--FlareGun
	Weapons[6]={}
	Weapons[6][1]={}       
	Weapons[6][1]=0   					--	WeaponLevel   
	Weapons[6][2]=3						--  WeaponMax    
	Weapons[6][3]= FlareGun					--  CurrentAmmo    
	Weapons[6][4]=showFlareGun				    
	Weapons[6][5]= 3					--  CurrentAmmo    
	Weapons[6][6]= 3					--  CurrentMaxAmmo    
	Weapons[6][7]= 5					--  Priority
	

	--ShotGun
	Weapons[7]={}
	Weapons[7][1]=0   				     --WeaponLevel   
	Weapons[7][2]=3        				 --WeaponMax    
	Weapons[7][3]=cMagneto       
	Weapons[7][4]=showShotgun                    		       
	Weapons[7][5]=  1                  	  --AmmoCost           
	Weapons[7][6]=  0.35        		  --StabilityCost	 
	Weapons[7][7]=  4        		  	  --PriorityLevel the bigger the more Priority it Got
	Weapons[7][8]=  2000        		  --Downtime
	Weapons[7][9]=  0.2        		  	  --RecoilMax	
	Weapons[7][10]=  0     		  	      --ScrapAmmonition 	

	--<ShotTractorGun>--Markerweapon
	boolTractorWeaponActivated=false
	Weapons[8]={}
	Weapons[8][1]=1   				     --WeaponLevel   
	Weapons[8][2]=1        				 --WeaponMax    
	Weapons[8][3]=cMagneto       
	Weapons[8][4]=showShotgun                    		       
	Weapons[8][5]=  0.1                	  --AmmoCost           
	Weapons[8][6]=  0.25        		  --StabilityCost	 
	Weapons[8][7]=  6        		  	  --PriorityLevel the bigger the more Priority it Got
	Weapons[8][8]=  2000        		  --Downtime
	Weapons[8][9]=  0.2        		  	  --RecoilMax	
	--</ShotTractorGun>
	
	--TangleGun
	Weapons[9]={}
	Weapons[9][1]=1   				     --WeaponLevel   
	Weapons[9][2]=3        				 --WeaponMax    
	Weapons[9][3]=tangleGun       
	Weapons[9][4]=showTangleGun                    		       
	Weapons[9][5]=  0.1                	  --AmmoCost           
	Weapons[9][6]=  0.05        		  --StabilityCost	 
	Weapons[9][7]=  3        		  	  --PriorityLevel the bigger the more Priority it Got
	Weapons[9][8]=  500        		  --Downtime
	Weapons[9][9]=  0       		  	  --RecoilMax	
	
	function showARocket()
		for i=1,Weapons[13][1], 1 do
		Show(guidedMissile[i])
		end
	end
	--Anti Air Rockets
	Weapons[13]={}
	Weapons[13][1]=1   				     --WeaponLevel   
	Weapons[13][2]=3        				 --WeaponMax    
	Weapons[13][3]=guidedMissile       
	Weapons[13][4]=showARocket                    		       
	Weapons[13][5]=  0.1                	  --AmmoCost           
	Weapons[13][6]=  0.05        		  --StabilityCost	 
	Weapons[13][7]=  3        		  	  --PriorityLevel the bigger the more Priority it Got
	Weapons[13][8]=  700        		  --Downtime
	Weapons[13][9]=  0       		  	  --RecoilMax	
	
	
	function showGroundRocket()
		for i=1,Weapons[14][1], 1 do
			Show(unguidedMissile[i])
		end
	end
	-- Ground Rocket 
	Weapons[14]={}
	Weapons[14][1]=1   				     --WeaponLevel   
	Weapons[14][2]=3        				 --WeaponMax    
	Weapons[14][3]=unguidedMissile     
	Weapons[14][4]=showGroundRocket                   		       
	Weapons[14][5]=  0.1                	  --AmmoCost           
	Weapons[14][6]=  0.05        		  --StabilityCost	 
	Weapons[14][7]=  3        		  	  --PriorityLevel the bigger the more Priority it Got
	Weapons[14][8]=  700        		  --Downtime
	Weapons[14][9]=  0       		  	  --RecoilMax	
	
	--</WEAPONS>
	--<TOOLS>
	--EscapePod
	--AmmoFactory
	--Repairdrone
	--AnomalyMincefactory
	--Reconisancedronefactory
	--Razordronefactory
	--Sensorics+Radar
	--Stealth
	--Jam
	--
	--</TOOLS>
	local currPriority=0
	
	function gotPriority(number)	
	assert(number)
	if number >= currPriority then 
	currPriority=number
	return true
	end
	return false
	end
	
	function releasePriority(number)
	if currPriority== number then currPriority =0 end
	--In every other case somebody more powerfull has allready grabed priority
	end
	boolOutOfAmmo=false
	local boolIsActive=true
	local boolWalking=false
	--superportal+magnetic sucker
	--local cifireclo2=piece"cifireclo2"

	--define other pieces
	--<SIGNALS>
	
	local SIG_WALK = 1	--signal for the walk animation thread
	local SIG_AIM = 2	
	local SIG_IDLE=4
	local SIG_LEG=8
	local SIG_RESET=16
	local SIG_SMG=32
	--</SIGNALS>
	
	function alwaysWatching()
	local lrand=math.random
			while true do
			x=lrand(-80,-60)
			Turn(EYE01,y_axis,math.rad(x),2.8)
			WaitForTurn(EYE01,y_axis)
			focus=lrand(0,2)
				if focus==1 then 
					for i=1, math.ceil(lrand(4,10)), 1 do
					xadd=lrand(5,10)
					Turn(EYE01,y_axis,math.rad(x+xadd/i),2.8/(i+i))
					Turn(EYE01,x_axis,math.rad(5/i),0.8)

					WaitForTurn(EYE01,y_axis)
					Turn(EYE01,y_axis,math.rad(x-xadd/i),2.8/(i+i))
					Turn(EYE01,x_axis,math.rad(-5/i),0.8)
					WaitForTurn(EYE01,y_axis)
					end
				end
				if lrand(0,2)==1 then
					rest=math.ceil(lrand(500,1500))
					Sleep(rest)
				end
			if math.random(0,3)== 1 then
			Turn(EYE01,x_axis,gSniperHeading,0.8)
			Turn(EYE01,y_axis,-gSniperPitch,0.8)
			Sleep(3000)
			end
			x=lrand(60,80)
			Turn(EYE01,y_axis,math.rad(x),2.8)
			WaitForTurn(EYE01,y_axis)
			focus=lrand(0,3)
				if focus==1 then 
					for i=1, math.ceil(lrand(4,10)), 1 do
					xadd=lrand(5,10)
					Turn(EYE01,y_axis,math.rad(x+xadd/i),2.8/(i+i))
					Turn(EYE01,x_axis,math.rad(5/i),0.8)

					WaitForTurn(EYE01,y_axis)
					Turn(EYE01,y_axis,math.rad(x-xadd/i),2.8/(i+i))
					Turn(EYE01,x_axis,math.rad(-5/i),0.8)
					WaitForTurn(EYE01,y_axis)
					end
				end

				if lrand(0,2)==1 then
					rest=math.ceil(lrand(500,1500))
					Sleep(rest)
				end

			end

	end
	local	x_Turn_Shields={
	[22]=true,
	[17]=true,
	[26]=true,
	[23]=true,
	[20]=true,
	[27]=true,
	[24]=false,
	[19]=false,
	[28]=false,
	[21]=false,
	[16]=false,
	[25]=false
	}
	
	function animateShieldTexture(j,start,showThemAll)
			for h=1,4 do
					for j=start,j < NumberOfLegs, 1+showThemAll do
						if x_Turn_Shields[j+15] then
							if x_Turn_Shields[j+15]==true then
								Turn(shieldsToShowWrap[j],x_axis,math.rad(180),0)
							else
								Turn(shieldsToShowWrap[j],z_axis,math.rad(180),0)	
							end
						end
					end
				 
				
						rest=math.ceil((damage/i)*0.25)
						Sleep(rest)
						
				end	
	
	end
	
	--Function shows Shields if the ComEnder is hit
	function shieldFlicker(degreeInRads,damage)
	showThemAll=0
	addx=0

	if damage > 1000 then showThemAll=1 end

	if degreeInRads > 180 and degreeInRads   < 0    then addx=1 end

		--if Leg exists, and amourlevel is over 3 then for a short moment flicker the shields
			for i=1,9,1 do
			
			start=addx+1
				for j=start,j < NumberOfLegs, 1+showThemAll do
					Show(shieldsToShowWrap[j])
				end
				
					--gif Animation of Texture
					animateShieldTexture(j,start,showThemAll)
						
				for j=1+addx,j < NumberOfLegs, 1+showThemAll do
				Hide(shieldsToShowWrap[j])
				end
						rest=math.ceil(damage/i*2)
						Sleep(rest)

			end
		end
		
	shielddegree=0
	shielddamage=0
	function reset(t_able)
	for i=1,#t_able,1 do
	Turn(t_able[i],x_axis,math.rad(0),12)
	Turn(t_able[i],y_axis,math.rad(0),12)
	Turn(t_able[i],z_axis,math.rad(0),12)
	end
	
	end
	
	function threadStarter()
		while true do
			if boolFlickerThreadStart==true  then 
			StartThread(shieldFlicker,shielddegree,shielddamage) 
			boolFlickerThreadStart=false 
			end
		Sleep(150)
		end
	end
		
	function script.HitByWeapon ( x, z, weaponDefID, damage )
	
		
			if damage > 40 and math.random(0,6)== 1 then
			loud=math.random(0.8,1)
				if math.random(0,1)==1 then
				spPlaySoundFile("sounds/cComEnder/comanderHit.wav",loud)	
			
					else
					spPlaySoundFile("sounds/cComEnder/comanderHitScratch.wav",loud)	
					end
			end
	shielddegree=math.atan2(x,z)
	shielddamage=damage
	if Stats[1][3]== Stats[1][4]then
	boolFlickerThreadStart=true
	end
	
	Weapons[7][10]=  	Weapons[7][10]+damage
	if Weapons[7][1] ~= 0 and 	Weapons[7][10] > 50 then Show(bullets) else Hide(bullets) end
	return damage
	end
	
	function delayedSound(soundname,delay)
	Sleep(delay)
	spPlaySoundFile(soundname,1.0)
	
	end
	
	function script.Create()
	--delMe
	if GG.BoolDebug==true then
		spSetUnitExperience(unitID,12)		
	end
	--delMe
	sd=math.floor(math.random(1,5))
	strings="sounds/cComEnder/comEnder"..sd..".wav"
	StartThread(delayedSound,strings,7000)
	--generatepiecesTableAndArrayCode(unitID)
	hideT(guidedMissile)
	hideT(unguidedMissile)
	
		
		reseT(piecesTable)
		hideT(piecesTable)
		hideT(cFieldScooper)
	
		showT(basics)
		hideT(cMagneto)
		hideT(tangleGun)
	
	

	
	Spin(bullets,y_axis,math.rad(182),0.5)
	Spin(bullets,x_axis,math.rad(-220),0.5)
	StartThread(alwaysWatching)

	StartThread(walkTheDog)
	StartThread(updateProgressBar)
	StartThread(sniperKneeDown)
	StartThread(threadStarter)
	StartThread(showTime)
	StartThread(ammoFacLoop)

	end

	function script.StopBuilding()
		SetUnitValue(COB.INBUILDSTANCE, 0)
	end

	
--[[ 	
	Stats[1][5]=stability=1.0
	Stats[1][6]=stabilityRegenerationRate=0.05
	Stats[1][7]=stabilityMax=6.0 
	]]
	
	function theActualUpgrade(upgradeType)
	echo("ComEnder::",upgradeType)
	XP=Spring.GetUnitExperience(unitID) 
	if XP >= 1 then
		if upgradeType == "SPEED" and  Stats[1][1] <= Stats[1][2]then
		Stats[1][1]=Stats[1][1]+1
		SetUnitValue(COB.MAX_SPEED,math.floor(2.5*Stats[1][1])*2184.53)
		spSetUnitExperience(unitID,XP -1)	
		end
		
		if upgradeType ==	"ARMOR" and 	Stats[1][3] < 	Stats[1][4] then
		Stats[1][3]=Stats[1][3]+1
		Stats[1][1]=math.max(Stats[1][1]-0.5,1)
		SetUnitValue(COB.MAX_SPEED,math.floor(2.5*Stats[1][1]*2184.53))
		
		health,  maxHealth,  paralyzeDamage,  captureProgress,  buildProgress=Spring.GetUnitHealth(unitID)
		ratio=health/maxHealth
		Spring.SetUnitMaxHealth(unitID,maxHealth*Stats[1][3])
		Spring.SetUnitHealth(unitID,math.ceil(maxHealth*Stats[1][3]*ratio))		
		spSetUnitExperience(unitID,XP -1)	
		end
		
		if upgradeType =="STABILITY" and Stats[2][5] < Stats[1][7] then
		echo("STable")
		Stats[2][5]=Stats[2][5]+1
		echo(Stats[2][5])
		Stats[1][6]=0.05*Stats[2][5]
		spSetUnitExperience(unitID,XP -1)	
		end
		
		if upgradeType =="AMMO"then
		ammonitionMax=ammonitionMax+50
		spSetUnitExperience(unitID,XP -1)	
		end
		
		if upgradeType =="SENSORS" and Stats[1][8] < Stats[1][10] then
		Stats[1][8]=		Stats[1][8]+0.5
		Spring.SetUnitSensorRadius(unitID,"los",math.ceil(Stats[1][8]*Stats[1][9]))
		spSetUnitExperience(unitID,XP -1)
		end
		

		--SMG
		if upgradeType =="SMG" and Weapons[1][1] ~= Weapons[1][2] then
		--identify  Cost
		Weapons[1][1]=math.min(Weapons[1][1]+1,Weapons[1][2])
		spSetUnitExperience(unitID,XP -1)
		end
		
		--GRENADE
		if upgradeType =="GRENADE" and 	Weapons[3][1] ~= Weapons[3][2] then
		Weapons[3][1]=math.min(Weapons[3][1]+1,Weapons[3][2])
		spSetUnitExperience(unitID,XP -1)
		end
		
		--SNIPER
		if upgradeType =="SNIPER" and Weapons[2][1] ~= Weapons[2][2] then
		Weapons[2][1]=math.min(Weapons[2][1]+1,Weapons[2][2])
		spSetUnitExperience(unitID,XP -1)
		end
		--"SHOTGUN"
		if upgradeType =="SHOTGUN" and Weapons[8][1] ~= Weapons[8][2] then
		Weapons[8][1]=math.min(Weapons[8][1]+1,Weapons[8][2])
		spSetUnitExperience(unitID,XP -1)
		end
		
		--"STARBURST"
		if upgradeType =="SUNBURST" and Weapons[4][1] ~= Weapons[4][2] then
		Weapons[4][1]=math.min(Weapons[4][1]+1,Weapons[4][2])
		for i=1,Weapons[4][1],1 do
		Show(starburst[i])
		end		
		spSetUnitExperience(unitID,XP -1)
		end
		
		--"FLAREGUN"
		if upgradeType =="FLARE" and Weapons[6][1] ~= Weapons[6][2] then
		Weapons[6][1]=math.min(Weapons[6][1]+1,Weapons[6][2])
		Weapons[6][4]()	
		spSetUnitExperience(unitID,XP -1)
		end
		
		if upgradeType == "SLICER" and Weapons[5][1] ~= Weapons[5][2] then
		Weapons[5][1]=math.min(Weapons[5][1]+1,Weapons[5][2])
		Weapons[5][4]()	
		spSetUnitExperience(unitID,XP -1)
		end	
		
		if upgradeType == "TANGLE" and Weapons[9][1] ~= Weapons[9][2] then
		Weapons[9][1]=math.min(Weapons[9][1]+1,Weapons[9][2])
		Weapons[9][4]()	
		spSetUnitExperience(unitID,XP -1)
		end
		
		if upgradeType == "AROCKET" and Weapons[10][1] ~= Weapons[10][2] then
		Weapons[10][1]=math.min(Weapons[10][1]+1,Weapons[10][2])
		Weapons[10][4]()	
		spSetUnitExperience(unitID,XP -1)
		end
		
		if upgradeType == "GROCKET" and Weapons[9][1] ~= Weapons[9][2] then
		
		end
		
		if upgradeType == "EJECTPOD" and LazarusDevice ~= LazarusDeviceMax then
		LazarusDevice=math.min(LazarusDevice+1,LazarusDeviceMax)
		spSetUnitExperience(unitID,XP -1)
		end
		
		if upgradeType == "AMMOFAC"  and AmmoFacEffectiveness ~= AmmoFacEffectivenessMax then
			AmmoFacEffectiveness=math.min(AmmoFacEffectiveness+1,AmmoFacEffectivenessMax)
			spSetUnitExperience(unitID,XP -1)
		end
		
		if upgradeType == "RADAR"  and RadarEffectiveness ~= RadarEffectivenessMax then
			RadarEffectiveness=math.min(RadarEffectiveness+1,RadarEffectivenessMax)
			Spring.SetUnitSensorRadius(unitID,"radar",RadarRadius*RadarEffectiveness)
			spSetUnitExperience(unitID,XP -1)
		end
		--identify Upgrade Possible
			
		
		--[[
	


		 "STEALTH"

		--upgrade
		]]
		 
	end
		
end

	--UPGRADECONST
	LazarusDevice=0
	LazarusDeviceMax=3
	
	RadarRadius= 250
	RadarEffectivenessMax=5
	RadarEffectiveness=0


	AmmoFacEffectivenessMax=5
	AmmoFacEffectiveness=0
	AmmoFac=piece"AmmoFac"
	piecesTable[#piecesTable+1]=AmmoFac
	function ammoFacLoop()
	
		while AmmoFacEffectiveness <=0 do
			
			Sleep(5000)
		end
	
		Show(AmmoFac)
		
		while true do
			
			ammonition=math.min(ammonition+AmmoFacEffectivenessMax,ammonitionMax)
			Sleep(1000)
		end
	
	end
	
	function topplingOver(stability, boolImpulse,heading)
	boolCanFire=false
	--fold to a ball
	Move(testComEnder3DS,y_axis,-43,39)
	
	for i=1, #LegsTable, 1 do
	val=math.random(-140,-90)
	Turn(LegsTable[i],x_axis,math.rad(val),math.abs(val)*0.3)
	end
	time=math.ceil(math.abs(Stats[1][5]*900))
		if boolImpulse == true then
		
	    tx,tz=0,0
		tx,tz=Spring.GetVectorFromHeading(heading)
		Spring.AddUnitImpulse(unitID,tx*-4,0,tz*-4)
		Sleep(time)

			else
				TX=math.ceil(time/7)
				boolMilWalky=false
				for i=1, 7, 1 do
				boolMilWalky= not boolMilWalky
				boolWalking=boolMilWalky
				--Shake Back and Forth
					for i=1, #LegsTable, 1 do
					val=math.random(-140+i*10,-90+i*10)
					Turn(LegsTable[i],x_axis,math.rad(val),math.abs(val)*0.3)
					end
					Turn(bb05,x_axis,math.rad(i*-8.14),17)
					WaitForTurn(LegsTable[2],x_axis)
					WaitForTurn(LegsTable[1],x_axis)
					
					for i=1, #LegsTable, 1 do
					val=math.random(-50+i*10,-30+i*10)
					Turn(LegsTable[i],x_axis,math.rad(val),35)
					end
					
					
					
					Turn(bb05,x_axis,math.rad(i*4),17)
					WaitForTurn(bb05,x_axis)
					WaitForTurn(LegsTable[2],x_axis)
					WaitForTurn(LegsTable[1],x_axis)
									end
			end
			
	--Aufrappeln 
	boolWalking=true
	boolCanFire=true
	boolCanFallOnce=true
	totalReset(false,0)
	end
	
	
	boolCanFallOnce=true
	function StabiliZer()
		while true do
			--stable
			if Stats[1][5] >= 1 then boolCanFire=true end
			
			--unstable	
			if boolCanFallOnce ==true and Stats[1][5] < 1 and Stats[1][5] > 0 then  
				boolCanFallOnce=false
				StartThread(topplingOver,1-Stats[1][5],false,spGetUnitHeading(UnitID))	
			end
			
			if boolCanFallOnce ==true and Stats[1][5] <= 0 then
				boolCanFallOnce=false
				StartThread(topplingOver,1-Stats[1][5],true,spGetUnitHeading(UnitID))	
			end
			
			Stats[1][5]=math.min(Stats[1][5]+Stats[1][6],Stats[1][7])
			Sleep(150)
		end

	end

	function script.StartBuilding(heading, pitch)
		 
			--identify Unit
			SetUnitValue(COB.INBUILDSTANCE, 1)
	end

	function script.QueryNanoPiece()
		 return center
	end

	function T(piecename,radx,spx,rady,spy,radz,spz)

		if radx ~= nil then
		Turn(piecename,x_axis,math.rad(radx),spx)
		end
			if rady ~= nil then
			Turn(piecename,y_axis,math.rad(rady),spy)
			end
				if radz ~= nil then
				Turn(piecename,z_axis,math.rad(radz),spz)
				end


	end

	--variance has to be a positive value at all times 
	function DT(piecename,piecename2,radx,spx,rady,spy,variance)

		if radx ~= nil then
		var=math.random(-1*variance,variance)
		Turn(piecename,x_axis,math.rad(radx+var),spx)
		var=math.random(-1*variance,variance)
		Turn(piecename2,x_axis,math.rad(radx+var),spx)
		end
			if rady ~= nil then
			Turn(piecename,y_axis,math.rad(rady),spy)
			
			Turn(piecename2,y_axis,math.rad(rady*-1),spy)
			end
			
			

	end
	--http://answers.springlobby.info/questions/427/howto-spinning-wheels-on-moving-units

	function walkTheDog()
	
	local lT = T
	local lDT=DT
	local llegs_down=legs_down
	local lLegBoolean=false
	spPlaySoundFile("sounds/cComEnder/startup.wav")
		while(true)do 
		Sleep(70)
				while boolWalking==true do
				local lwalkSpeed=Stats[1][1]
				
				Turn(testComEnder3DS,y_axis,math.rad(0),0.05)
			--	spPlaySoundFile("sounds/cComEnder/comEnderStep.wav")
						--<!LEG>
						Turn(bb05,x_axis,math.rad(3),0.15)
						--Turn(ARML,x_axis,math.rad(-3),0.16)
						--Turn(ARMR,x_axis,math.rad(-3),0.16)
						--<!LEG>
					Move(LS10,z_axis,0,walkSpeed)
					Move(LS09,z_axis,0,walkSpeed)
					lDT(LS10,LS09,15,1.7*lwalkSpeed,0,walkspeed,12)			------------------------------------------
					lDT(LSK10,LSK09,-15,1.7*lwalkSpeed,nil,nil,5)			------------------------------------------
					lDT(LK10,LK09,0,1.7*lwalkSpeed,nil,nil,2)			------------------------------------------
					lDT(LF3,LF09,0,1.7*lwalkSpeed,nil,nil,0)			------------------------------------------
					
					--<BHLEG>
					if lLegBoolean==false then	
					
					lT(LS12,-15,1.7*lwalkSpeed,nil,nil,nil,nil)-- added -
					lT(LSK12,-15,1.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LF12,0,1.7*lwalkSpeed,0,lwalkSpeed,0,lwalkSpeed)
					lT(LK12,0,1.7*lwalkSpeed,0,lwalkSpeed,0,walkSpeed)
					
					lT(LK11,-10,1.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LSK11,0,1.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LF11,0,1.7*lwalkSpeed,0,lwalkSpeed,0,lwalkSpeed)
					lT(LS11,35,2.7*lwalkSpeed,nil,nil,nil,nil)
					else
					lT(LS11,-15,1.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LSK11,-15,1.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LF11,0,1.7*lwalkSpeed,0,lwalkSpeed,0,lwalkSpeed)
					lT(LK11,0,1.7*lwalkSpeed,0,lwalkSpeed,0,walkSpeed)
					
					lT(LK12,-10,1.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LSK12,0,1.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LF12,0,1.7*lwalkSpeed,0,lwalkSpeed,0,lwalkSpeed)
					lT(LS12,35,2.7*lwalkSpeed,nil,nil,nil,nil)
					end
					--</BHLEG>		

					------echo("Ccomender::1")
				lT(LS08,-27,1.7*lwalkSpeed,nil,nil,nil,nil)
				lT(LK08,-2,lwalkSpeed,nil,nil,nil,nil)
				lT(LSK08,-21,1.3*lwalkSpeed,nil,nil,nil,nil)
				lT(LF1,49,2.1*walkSpeed,nil,nil,nil,nil)
				------echo("Ccomender::2")
					
				lT(LS07,26,1.4*lwalkSpeed,nil,nil,nil,nil)
				lT(LK07,-9,1.7*lwalkSpeed,nil,nil,nil,nil)
					------echo("Ccomender::2a")
				lT(LSK07,-49,2.2*lwalkSpeed,nil,nil,nil,nil)
				lT(LF07,29,2.1*lwalkSpeed,nil,nil,nil,nil)
				------echo("Ccomender::2b")
				--<WAIT>
				Sleep(500)
				EmitSfx(LF1,1025)
				spPlaySoundFile("sounds/cComEnder/comEnderStep.wav",0.9)	
				lT(LS08,-5,2*lwalkSpeed,nil,nil,nil,nil)
				lT(LK08,-27,3.6*lwalkSpeed,nil,nil,nil,nil)
				------echo("Ccomender::2c")
				lT(LSK08,-19,4*lwalkSpeed,nil,nil,nil,nil)
				lT(LF1,49,8.2*lwalkSpeed,nil,nil,nil,nil)
				------echo("Ccomender::2d")
				lT(LS07,60, 2.1*lwalkSpeed,nil,nil,nil,nil)
				lT(LK07,-9, 1.7*lwalkSpeed,nil,nil,nil,nil)
				------echo("Ccomender::2e")
				lT(LSK07,-49, 2.1* lwalkSpeed,nil,nil,nil,nil)
				lT(LF07,-5, 2.1*lwalkSpeed,nil,nil,nil,nil)
				 
					
					lDT(LS10,LS09,45,1.7*lwalkSpeed,nil,nil,6)			------------------------------------------
					lDT(LSK10,LSK09,-65,1.7*lwalkSpeed,nil,nil,5)			------------------------------------------
					lDT(LK10,LK09,-15,1.7*lwalkSpeed,nil,nil,2)			------------------------------------------
					lDT(LF3,LF09,35,1.7*lwalkSpeed,nil,nil,2)			------------------------------------------
						
					--<BHLEG>
					if lLegBoolean== false then	
					lT(LS12,-45,1.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LSK12,5,1.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LF12,35,1.7*lwalkSpeed,0,lwalkSpeed,0,lwalkSpeed)
					lT(LK12,15,1.7*lwalkSpeed,0,lwalkSpeed,0,walkSpeed)
					
					lT(LS11,55,2.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LK11,-10,1.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LSK11,-28,1.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LF11,-15,1.7*lwalkSpeed,0,lwalkSpeed,0,lwalkSpeed)
					else
					lT(LS11,-45,1.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LSK11,5,1.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LF11,35,1.7*lwalkSpeed,0,lwalkSpeed,0,lwalkSpeed)
					lT(LK11,15,1.7*lwalkSpeed,0,lwalkSpeed,0,walkSpeed)
					
					lT(LS12,55,2.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LK12,-10,1.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LSK12,-28,1.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LF12,-15,1.7*lwalkSpeed,0,lwalkSpeed,0,lwalkSpeed)
					end
					
					--</BHLEG>		
				 --<WAIT>
						------echo("Ccomender::3")
				Sleep(300)
				lT(LS08,26,1.7*lwalkSpeed,nil,nil,nil,nil)
				lT(LK08,-9,1.7*lwalkSpeed,nil,nil,nil,nil)
				lT(LSK08,-49,2.2* lwalkSpeed,nil,nil,nil,nil)
				lT(LF1,29,2.1*lwalkSpeed,nil,nil,nil,nil)
				
				lT(LS07,-2,3.2*lwalkSpeed,nil,nil,nil,nil)
				lT(LK07,4,1.7*lwalkSpeed,nil,nil,nil,nil)
				lT(LSK07,-58,2.2*lwalkSpeed,nil,nil,nil,nil)
				lT(LF07,59,3.2*lwalkSpeed,nil,nil,nil,nil)
				 --<WAIT>
				 --<BHLEG>
					if lLegBoolean==false  then
					lT(LS12,-25,1.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LSK12,35,1.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LF12,25,1.7*lwalkSpeed,0,lwalkSpeed,0,lwalkSpeed)
					lT(LK12,-35,1.7*lwalkSpeed,0,lwalkSpeed,0,walkSpeed)
					
					lT(LS11,110,2.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LK11,-90,2.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LSK11,30,1.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LF11,-45,1.7*lwalkSpeed,0,lwalkSpeed,0,lwalkSpeed)
					else
					lT(LS11,-25,1.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LSK11,35,1.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LF11,25,1.7*lwalkSpeed,0,lwalkSpeed,0,lwalkSpeed)
					lT(LK11,-35,1.7*lwalkSpeed,0,lwalkSpeed,0,walkSpeed)
					
					lT(LS12,110,2.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LK12,-90,2.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LSK12,30,1.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LF12,-45,1.7*lwalkSpeed,0,lwalkSpeed,0,lwalkSpeed)
					end
				--</BHLEG>		
				
					lDT(LS10,LS09,65,2.7*lwalkSpeed,nil,nil,6)			------------------------------------------
					lDT(LSK10,LSK09,-71,1.7*lwalkSpeed,nil,nil,5)			------------------------------------------
					lDT(LK10,LK09,-25,1.7*lwalkSpeed,nil,nil,2)			------------------------------------------
					lDT(LF3,LF09,29,2.7*lwalkSpeed,nil,nil,1)			------------------------------------------
						
						------echo("Ccomender::4")
				Sleep(400)
						--<!LEG>		
						Turn(bb05,x_axis,math.rad(-1),0.15)
						--Turn(ARMR,x_axis,math.rad(1),0.16)
						--Turn(ARML,x_axis,math.rad(1),0.16)
			
						
						--<!LEG>
				lT(LS08,60, 2.1*lwalkSpeed,nil,nil,nil,nil)
				lT(LK08,-9, 1.7*lwalkSpeed,nil,nil,nil,nil)
				lT(LSK08,-49, 2.2*lwalkSpeed,nil,nil,nil,nil)
				lT(LF1,-5,2.1*lwalkSpeed,nil,nil,nil,nil)
				
				lT(LS07,-27,2.2*lwalkSpeed,nil,nil,nil,nil)
				lT(LK07,-2,lwalkSpeed,nil,nil,nil,nil)
				lT(LSK07,-21,2.2*lwalkSpeed,nil,nil,nil,nil)
				lT(LF07,49,4.2*lwalkSpeed,nil,nil,nil,nil)
				 
				  --<BHLEG>
					if lLegBoolean==false then
					lT(LS12,-15,1.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LSK12,0,1.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LF12,35,1.7*lwalkSpeed,0,lwalkSpeed,0,lwalkSpeed)
					lT(LK12,-15,1.7*lwalkSpeed,0,lwalkSpeed,0,walkSpeed)
					
					lT(LS11,35,2.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LK11,15,2.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LSK11,35,1.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LF11,-36,1.7*lwalkSpeed,0,lwalkSpeed,0,lwalkSpeed)
					else
					lT(LS11,-15,1.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LSK11,0,1.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LF11,35,1.7*lwalkSpeed,0,lwalkSpeed,0,lwalkSpeed)
					lT(LK11,-15,1.7*lwalkSpeed,0,lwalkSpeed,0,walkSpeed)
					
					lT(LS12,35,2.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LK12,15,2.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LSK12,35,1.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LF12,-36,1.7*lwalkSpeed,0,lwalkSpeed,0,lwalkSpeed)
					end
					--</BHLEG>		
					
					lDT(LS10,LS09,115,2.7*lwalkSpeed,-18,walkSpeed,6)	
					Move(LS10,z_axis,-1,walkSpeed)
					Move(LS09,z_axis,-1,walkSpeed)
					
					lDT(LSK10,LSK09,-12,1.7*lwalkSpeed,nil,nil,5)			------------------------------------------
					lDT(LK10,LK09,-80,1.7*lwalkSpeed,nil,nil,2)			------------------------------------------
					lDT(LF3,LF09,-38,2.7*lwalkSpeed,nil,nil,1)			------------------------------------------
					
					
				 --<WAIT>
						------echo("Ccomender::5")
			
				Sleep(500)
						EmitSfx(LF09,1025)
						spPlaySoundFile("sounds/cComEnder/comEnderStep.wav",0.9)	
				lT(LS08,-2,3.2*lwalkSpeed,nil,nil,nil,nil)
				lT(LK08,4,1.7*lwalkSpeed,nil,nil,nil,nil)
				lT(LSK08,-58,2.2*lwalkSpeed,nil,nil,nil,nil)
				lT(LF1,59,3.2*lwalkSpeed,nil,nil,nil,nil)
				
				lT(LS07,-5,2.2*lwalkSpeed,nil,nil,nil,nil)
				lT(LK07,-27,lwalkSpeed,nil,nil,nil,nil)
				lT(LSK07,-19,2.0*lwalkSpeed,nil,nil,nil,nil)
				lT(LF07,49,4.2*lwalkSpeed,nil,nil,nil,nil)
				 --<WAIT>
						------echo("Ccomender::6")
				 --<BHLEG>
				 if lLegBoolean==false then
					lT(LS12,0,1.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LSK12,0,1.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LF12,0,1.7*lwalkSpeed,0,lwalkSpeed,0,lwalkSpeed)
					lT(LK12,0,1.7*lwalkSpeed,0,lwalkSpeed,0,walkSpeed)
					
					lT(LS11,0,2.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LK11,-15,2.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LSK11,86,2.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LF11,16,1.7*lwalkSpeed,0,lwalkSpeed,0,lwalkSpeed)
					lLegBoolean=true
				else
					lT(LS11,0,1.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LSK11,0,1.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LF11,0,1.7*lwalkSpeed,0,lwalkSpeed,0,lwalkSpeed)
					lT(LK11,0,1.7*lwalkSpeed,0,lwalkSpeed,0,lwalkSpeed)
					
					lT(LS12,0,2.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LK12,-15,2.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LSK12,86,2.7*lwalkSpeed,nil,nil,nil,nil)
					lT(LF12,16,1.7*lwalkSpeed,0,lwalkSpeed,0,lwalkSpeed)
					lLegBoolean=false		
				end
				--</BHLEG>				
					lDT(LS10,LS09,15,3.7*lwalkSpeed,-9,walkSpeed,12)	
					lDT(LSK10,LSK09,-78,3.7*lwalkSpeed,nil,nil,5)			------------------------------------------
					lDT(LK10,LK09,13,4.7*lwalkSpeed,nil,nil,2)			------------------------------------------
					lDT(LF3,LF09,27,3.7*lwalkSpeed,nil,nil,1)
					
				Sleep(500)
					if boolWalking ==false then 
						lT(LS08,-5,2*lwalkSpeed,nil,nil,nil,nil)
						lT(LK08,-27,3.6*lwalkSpeed,nil,nil,nil,nil)
						------echo("Ccomender::2c")
						lT(LSK08,-19,4*lwalkSpeed,nil,nil,nil,nil)
						lT(LF1,49,8.2*lwalkSpeed,nil,nil,nil,nil)
						
					end
				end
			
				
			spPlaySoundFile("sounds/cComEnder/comEnderStep.wav",0.6)
			spPlaySoundFile("sounds/cComEnder/comEnderStep.wav",0.7)
			spPlaySoundFile("sounds/cComEnder/comEnderStep.wav",0.9)		
		llegs_down(false,0)
		if boolWalking== false then
		reset(Legg4)
		reset(Legg3)
		reset(Legg5)
		reset(Legg6)
		end
			while boolWalking== false do
			Sleep(50)
			end
		end

	end

	function script.Killed(recentDamage, maxHealth)

		if LazarusDevice > 0 then
			if not 	GG.LazarusDeviceActive then 	GG.LazarusDeviceActive= {} end
			
			GG.LazarusDeviceActive[unitID]=LazarusDevice-1
			x,y,z=Spring.GetUnitPosition(unitID)
			teamid=Spring.GetUnitTeam(attackerID)
			gx,gy,gz=Spring.GetTeamStartPosition(teamid)
				
					local	 EjectProject={
							pos = { x, y+max+10, z},  
							speed={0,math.random(1,3),0},
							["end"] = {gx,gy,gz},
							owner = unitID,
							team = teamid,	
							spread={math.random(-5,5),math.random(-5,5),math.random(-5,5)},
							ttl=1520,
							maxRange = 3600,
							gravity = Game.gravity,
							startAlpha = 1,
							tracking =true,
							endAlpha = 1,						
							model = "lazarusrocket.s3o",
							cegTag = "cchainlightning"
							}
			
		projID = Spring.SpawnProjectile( WeaponDefNames["lazarusrocket"].id ,EjectProject) 
			
			
		end
	
	explodeT(piecesTable,SFX.FALL+SFX.FIRE,math.ceil(math.random(1,3)))
	
	suddenDeathV(recentDamage)

	return 1
	end

	function totalReset(boolDelayed,time)
	SetSignalMask(SIG_RESET)
	if boolDelayed==true then Sleep(time) end
		Move(testComEnder3DS,y_axis,0,39)
		for i=1, #piecesTable, 1 do 
		Turn(piecesTable[i],x_axis,math.rad(0),12)
		Turn(piecesTable[i],y_axis,math.rad(0),12)
		Turn(piecesTable[i],z_axis,math.rad(0),12)
		end


	end

	function legs_down(boolDelayed,time)
	if boolDelayed==true then Sleep(time) end
			------echo("Ccomender::8")
			T(LS08,0,7,0,7,0,7)
			T(LK08,0,7,0,7,0,7)
					------echo("Ccomender::8b")
			T(LSK08,0,7,0,7,0,7)
			T(LF1,0,7,0,7,0,7)
			------echo("Ccomender::8c")
				
			T(LS07,0,7,0,7,0,7)
			T(LK07,0,7,0,7,0,7)
			------echo("Ccomender::8d")
			T(LSK07,0,7,0,7,0,7)
			T(LF07,0,7,0,7,0,7)
		
	

		
	end

	function script.StartMoving()
	boolWalking=true

	end



	function script.StopMoving()
	boolWalking=false
			
		
			
			
	end

	x,y,z=Spring.GetUnitPosition(unitID)
	--<TEMP>
	function updateProgressBar()
	local lspGetUnitsInCylinder=Spring.GetUnitsInCylinder
	local lGetUnitDefID=Spring.GetUnitDefID
	local lspGetUnitPosition=Spring.GetUnitPosition
	local lcitadellDefID=UnitDefNames["citadell"].id
	local lcomendbonkerDefID=UnitDefNames["comendbonker"].id
		while true do
			if ammonition <= 0 then
			boolOutOfAmmo=true
			else
			boolOutOfAmmo=false
			end
		
			if ammonition < ammonitionMax then
				x,y,z=lspGetUnitPosition(unitID)
				unitsInResupplyCircle={}
				unitsInResupplyCircle=lspGetUnitsInCylinder(x,z, 150)
				table.remove(unitsInResupplyCircle,unitID)
				if unitsInResupplyCircle ~= nil then
					for i=1,#unitsInResupplyCircle,1 do
					defID=lGetUnitDefID(unitsInResupplyCircle[i])
						if (defID== lcitadellDefID or defID== lcomendbonkerDefID ) and teamID == Spring.GetUnitTeam(unitsInResupplyCircle[i]) then 	
							if defID== lcitadellDefID then
							ammonition=ammonitionMax
								else
								h=Spring.GetUnitHealth(unitID)	
								Spring.SetUnitHealth(unitID,h+50)
								end
						break
						end
					end
				end
			end
		orgString="Ammonition:"
		passengerString= ""
		for i=1, ammonition,2 do
				passengerString=passengerString.."¦"
		end



		orgString=orgString..passengerString


		Spring.SetUnitTooltip (unitID, orgString)
		Sleep(350)
		end

	end
	--<TEMP>

	-- The copypastated towers of the citadell
	--<WEAPON>

	function script.AimFromWeapon1() 
		return glaunch 
	end

	function script.QueryWeapon1() 
	return glaunch

	end
	 pitchBlease = 0
	 gheadPlus=35

	function script.AimWeapon1( heading ,pitch)	
		if Weapons[3][1] ==1  then
		--echo("CComEnderScript:: Heading:"..math.deg(heading),"  Pitch: "..math.deg(pitch))
				if pitch < pitchBlease then return false end
				if math.deg(heading) < gheadPlus and math.deg(heading) > gheadPlus*-1 then return false end 

				if  gotPriority(Weapons[3][7])==true then
					Signal(SIG_AIM)
					SetSignalMask(SIG_AIM)
					canFire=false
					
								Turn(glaunch,y_axis,heading,3)
								Turn(glaunch, x_axis, math.rad(math.deg(pitch)*-1), 3)
								WaitForTurn(glaunch,y_axis)
								WaitForTurn(glaunch,x_axis)	
										
						--return canFire
						
				releasePriority(Weapons[3][7])
				return true and not boolOutOfAmmo
				end
		end
	return false 
	end




	function script.FireWeapon1()
	
	ammonition=ammonition-Weapons[3][5]     
    Stats[1][5]=Stats[1][5]-Weapons[3][6]      		  --StabilityCost	
	secondShot=secondShot+1
	if secondShot==2 then
	 StartThread(loader)
	 secondShot=0
	 end
		Move(gGrenade,z_axis,55,175)
		WaitForMove(gGrenade,z_axis)
		Hide(gGrenade)
		Move(gGrenade,z_axis,-5,0)
		Show(gGrenade)
		Move(gGrenade,z_axis,0,0.75)
		WaitForMove(gGrenade,z_axis)

		return true
	end
	----------------


	function script.AimFromWeapon2() 
		return glaunch 
	end




	function script.QueryWeapon2() 
	return glaunch
	end


	function script.AimWeapon2( heading ,pitch)	
		if Weapons[3][1]==2 and gotPriority(Weapons[3][7])==true then 
		--echo("CComEnderScript:: Heading:"..math.deg(heading),"  Pitch: "..math.deg(pitch))
		if pitch < pitchBlease then return false end
			if math.deg(heading) < gheadPlus and math.deg(heading) > gheadPlus*-1 then return false end 


			Signal(SIG_AIM)
				SetSignalMask(SIG_AIM)
				canFire=false
			
				-- the unit turns and meanwhile looses priority  - resulting in  phail 
					Turn(glaunch,y_axis,heading,3)
					Turn(glaunch, x_axis, math.rad(math.deg(pitch)*-1), 3)
					WaitForTurn(glaunch,y_axis)
					WaitForTurn(glaunch,x_axis)	
					
					--return canFire
					releasePriority(Weapons[3][7])	
					return true and not boolOutOfAmmo
		else 
		releasePriority(Weapons[3][7])			
		return false 
		end
	end

	function script.FireWeapon2()	
	releasePriority(Weapons[3][7])
	Stats[1][5]=Stats[1][5]-Weapons[3][6] 
	ammonition=ammonition-Weapons[3][5]  
	secondShot=secondShot+1
	if secondShot == 2 then
	 StartThread(loader)
	 secondShot=0
	 end
		Move(gGrenade,z_axis,55,175)
		WaitForMove(gGrenade,z_axis)
		Hide(gGrenade)
		Move(gGrenade,z_axis,-5,0)
		Show(gGrenade)
		Move(gGrenade,z_axis,0,0.75)
		WaitForMove(gGrenade,z_axis)

		return true
	end
	----------------
	function script.AimFromWeapon3() 
		return glaunch 
	end

	function script.QueryWeapon3() 
	return glaunch
	end

	function script.AimWeapon3( heading ,pitch)	

	if Weapons[3][1]==3 and gotPriority(Weapons[3][7])==true then
	--echo("CComEnderScript:: Heading:"..math.deg(heading),"  Pitch: "..math.deg(pitch))
	if pitch < pitchBlease then return false end
		if math.deg(heading) < gheadPlus and math.deg(heading) > gheadPlus*-1 then return false end 




		Signal(SIG_AIM)
			SetSignalMask(SIG_AIM)
			canFire=false

			
			
			
				Turn(glaunch,y_axis,heading,3)
						Turn(glaunch, x_axis, math.rad(math.deg(pitch)*-1), 3)
				WaitForTurn(glaunch,y_axis)
				WaitForTurn(glaunch,x_axis)	
				
			
				--return canFire
				releasePriority(Weapons[3][7])	
				return true and not boolOutOfAmmo
		else 
		releasePriority(Weapons[3][7])	
		return false 
		end
	end

	loadervar=1
	row=1
	function loader()
		if loadervar==1 then
		Move(gr1,y_axis,-3.6,5)
		Move(gr1,z_axis,-3.3,4.6)
		WaitForMove(gr1,y_axis)
		WaitForMove(gr1,z_axis)
		Hide(gr1)
		loadervar=loadervar+1
			elseif loadervar==2 then
			Move(gr1,y_axis,-3.6*loadervar,5)
			Move(gr1,z_axis,-3.3*loadervar,4.6)
			WaitForMove(gr1,y_axis)
			WaitForMove(gr1,x_axis)
			Hide(gr2)
			loadervar=loadervar+1
				elseif loadervar==3 then
				Move(gr1,y_axis,-3.6*loadervar,5)
				Move(gr1,z_axis,-3.3*loadervar,4.6)
				WaitForMove(gr1,y_axis)
				WaitForMove(gr1,x_axis)
				Hide(gr3)
				loadervar=loadervar+1

					else
					Move(gr1,y_axis,-3.6*loadervar,5)
					Move(gr1,z_axis,-3.3*loadervar,4.6)
					WaitForMove(gr1,y_axis)
					WaitForMove(gr1,x_axis)
					Hide(gr4)
					loadervar=0
						if row==1 then
						row=2
						Explode(mag1,SFX.FALL+SFX.NO_HEATCLOUD)
						Hide(mag1)
						Move(mag2,x_axis,3.7,1.2)
						WaitForMove(mag2,x_axis)
						Move(gr1,x_axis,0,0)
						Move(gr1,z_axis,0,0)
						Hide(mag2)
						Show(mag1)
						Show(gr1)
						Show(gr2)
						Show(gr3)
						Show(gr4)
							elseif row == 2 then
							row=3
							Explode(mag2,SFX.FALL+SFX.NO_HEATCLOUD)
							Hide(mag1)
							Move(mag2,x_axis,7.4,1.2)
							WaitForMove(mag2,x_axis)
							Move(gr1,x_axis,0,0)
							Move(gr1,z_axis,0,0)
							Hide(mag3)
							Show(mag1)
							Show(gr1)
							Show(gr2)
							Show(gr3)
							Show(gr4)
								else
								Move(mag2,x_axis,0,0)
								Move(mag1,x_axis,0,0)
								Move(mag3,x_axis,0,0)
								Move(gr1,x_axis,0,0)
								Move(gr1,z_axis,0,0)
								Show(mag2)
								Show(mag3)
								Show(mag1)
								Show(gr1)
								Show(gr2)
								Show(gr3)
								Show(gr4)
								row=1
								end



					end


	end

	secondShot=1
	function script.FireWeapon3()	
	releasePriority(Weapons[3][7])
	Stats[1][5]=Stats[1][5]-Weapons[3][6] 
	ammonition=ammonition-Weapons[3][5]  
	secondShot=secondShot+1
	if secondShot==2 then
	 StartThread(loader)
	 secondShot=0
	 end
		Move(gGrenade,z_axis,55,175)
		WaitForMove(gGrenade,z_axis)
		Hide(gGrenade)
		Move(gGrenade,z_axis,-5,0)
		Show(gGrenade)
		Move(gGrenade,z_axis,0,0.75)
		WaitForMove(gGrenade,z_axis)

		return true
	end


	--<SNIPER>
	function script.AimFromWeapon4() 
		return sniper 
	end




	function script.QueryWeapon4() 
	return sniper

	end
	
	function sniperKneeDown()
		while true do
				
			  if boolSniperGetIntoPosition==true then
			  		echo("JW_COMENDERSCRIPT::GetIntoPosition")
				Turn(bb05,x_axis,-gSniperPitch,5)
				Turn(testComEnder3DS,y_axis,gSniperHeading,Stats[1][1])
		
				SetUnitValue(COB.MAX_SPEED,01)
					while (true==Spring.UnitScript.IsInTurn (testComEnder3DS, y_axis)) do
					echo("JW_COMENDERSCRIPT::Aligning to fire")
					boolWalking=true
					Sleep(500)
					end
				boolWalking=false
				legs_down()
				boolWalking=false
				
								DT(LSK10,LSK09,6,1.7*Stats[1][1],nil,nil,5)			------------------------------------------
								DT(LK10,LK09,-130,1.7*Stats[1][1],nil,nil,2)			------------------------------------------
								DT(LSK10,LSK09,-82,2.7*Stats[1][1],nil,nil,1)	
								DT(LF3,LF09,32,2.7*Stats[1][1],nil,nil,1)	
				
								T(LS11,110,2.7*Stats[1][1],nil,nil,nil,nil)
								T(LK11,-90,2.7*Stats[1][1],nil,nil,nil,nil)
								T(LSK11,30,1.7*Stats[1][1],nil,nil,nil,nil)
								T(LF11,-45,1.7*Stats[1][1],0,Stats[1][1],0,Stats[1][1])
								
								T(LS12,110,2.7*Stats[1][1],nil,nil,nil,nil)
								T(LK12,-90,2.7*Stats[1][1],nil,nil,nil,nil)
								T(LSK12,30,1.7*Stats[1][1],nil,nil,nil,nil)
								T(LF12,-45,1.7*Stats[1][1],0,Stats[1][1],0,Stats[1][1])
				boolWalking=false
				boolSniperPermit=true
					while boolSniperPermit== true do
					echo("JW_COMENDERSCRIPT::Sniper Allowance To Fire")
					Sleep(50)
					end
					Turn(testComEnder3DS,y_axis,math.rad(0),0.05)

				boolSniperGetIntoPosition=false
				end
		
		Sleep(300)
		end
	end
	
    function countDownSniperTimer()
		Weapons[2][9]=19000/Weapons[2][1]
	Move(Bolt,z_axis,-40,68)
	Move(pin,z_axis,-4.3,19)
	Show(Case)
	WaitForMove(Bolt,z_axis)
	Explode(Case,SFX.FALL +SFX.NO_HEATCLOUD)
	Hide(Case)
	spPlaySoundFile("sounds/cComEnder/Sniper/comEndSniperEject.wav",0.7)
	Turn(drum,z_axis,math.rad(sniperAmmoIterator*-13),15)	
	Move(Bolt,z_axis,0,68)			
	Sleep(	Weapons[2][9])
	Weapons[2][9]=0
	end

	boolSniperOnce=false
	boolSniperGetIntoPosition=false
	boolSniperPermit=false
	gSniperHeading=0
	gSniperPitch=0

	function script.AimWeapon4( heading ,pitch)
		gSniperHeading=heading
		gSniperPitch=pitch
		if Weapons[2][1] > 0 and Weapons[2][9]== 0 and gotPriority(Weapons[2][7])==true then
	
			--Sniper Kneel Animation
				echo("ComEnder::Sniper::2")
		Stats[1][5]=Stats[1][5]-Weapons[2][6] 
		ammonition=ammonition-Weapons[2][5] 
			if Weapons[2][1]> 0 then
			echo("ComEnder::Sniper::3")
					if boolSniperOnce== false then 
					boolSniperGetIntoPosition=true
					boolSniperOnce=true
					end
			releasePriority(Weapons[2][7])	
			return 	boolSniperPermit and not boolOutOfAmmo
			end
		end 
	
	return false
	end



	function script.FireWeapon4()
boolSniperOnce=false
	boolSniperPermit=false
		Move(pin,z_axis,3,190)
		WaitForMove(pin,z_axis)
		
	if math.random(0,1)==1 then	spPlaySoundFile("sounds/cComEnder/Sniper/comEndSniper.wav",0.7) else spPlaySoundFile("sounds/cComEnder/Sniper/comEndSniperV2.wav",0.9) end
	sniperAmmoIterator=(sniperAmmoIterator)%12+1
	if sniperAmmoIterator == 12 then 
		for i=1,#sniperAmmoTable,1 do
		Show(sniperAmmoTable[i])
		end
	end
	Hide(sniperAmmoTable[sniperAmmoIterator])
	_,_,_,recoilX,recoilY,recoilZ=spGetUnitPiecePosDir(unitID,sniper)
	norm=math.sqrt(recoilX^2+recoilY^2+recoilZ^2)
	
	recoilX=math.min(math.min(math.abs(recoilX/norm),	Weapons[2][9]*Weapons[2][2]),0)
	recoilZ=math.min(math.min(math.abs(recoilZ/norm),	Weapons[2][9]*Weapons[2][2]),0)
	

	Spring.AddUnitImpulse(unitID,recoilX*-1*	Weapons[2][1],0,recoilZ*-1*	Weapons[2][1],0.7)
	StartThread(countDownSniperTimer)
	ammonition=ammonition-Weapons[2][5]  
	SetUnitValue(COB.MAX_SPEED,math.floor(2.5*Stats[1][1])*2184.53)	
	return true
	end


	--</SNIPER>



	--<SMG>

	function script.AimFromWeapon5() 
		return You 
	end

	SMGflipFlop=1

	function script.QueryWeapon5() 
	SMGflipFlop=(SMGflipFlop+1)%4
	if SMGflipFlop==0 then return SMG1B03 end
	if SMGflipFlop==1 then return SMG1B04 end
	if SMGflipFlop==2 then return SMG2B03 end
	if SMGflipFlop==3 then return SMG2B04 end
	return SMG03
	end

	boolCanSMGFire=false
	boolSMGOnlyOnce=false

	function smWaitForIt()
	time=math.floor(200/Weapons[1][1])  
	Sleep(time)
	boolCanSMGFire=true
	boolSMGOnlyOnce=false
	end

	function smgFireAnimation(pitch)        --Aproximated Time of Execution: 0.9333 Seconds. TODO: Tailor it so that Animationspeed autoadapts to weapontime
	SetSignalMask(SIG_SMG)

		
		for i=1, 7,1 do
		Turn(ARML, x_axis, math.rad(2.4*i), 39)
		Turn(ARMR, x_axis,  math.rad(2.4*i), 39)
		Turn(AS04,x_axis,math.rad(-2.4*i)-pitch,39)
		Turn(AS03,x_axis,math.rad(-2.4*i)-pitch,39)
		
		
		Move(SMG2B03,z_axis,0,45)
		Move(SMG1B04,z_axis,0,45)
		Move(SMG2B04,z_axis,-6,90)
		Move(SMG1B03,z_axis,-6,90)
		EmitSfx(SMG_EMIT3,1030)
		EmitSfx(SMG_EMIT3,1027)
		EmitSfx(SMG_EMIT1,1027)
		WaitForMove(SMG1B04,z_axis)

		Move(SMG2B04,z_axis,0,45)
		Move(SMG1B03,z_axis,0,45)
		Move(SMG2B03,z_axis,-6,90)
		Move(SMG1B04,z_axis,-6,90)
		EmitSfx(SMG_EMIT1,1030)
		EmitSfx(SMG_EMIT4,1027)
		EmitSfx(SMG_EMIT2,1027)
		WaitForMove(SMG1B03,z_axis)
		end

		
		
		Sleep(350)
		Move(SMG2B04,z_axis,0,45)
		Move(SMG1B03,z_axis,0,45)
		Move(SMG2B03,z_axis,0,45)
		Move(SMG1B04,z_axis,0,45)

		
		
	end

	function script.AimWeapon5( heading ,pitch)	
	if gotPriority(Weapons[1][7])==true then
		if boolSMGOnlyOnce== false then 
		boolSMGOnlyOnce=true
		StartThread(smWaitForIt)
		Signal(SIG_RESET)
		StartThread(totalReset,true,2500)
		end

		--/spinlock
			if boolCanSMGFire == true then
			Turn(bb05, y_axis, heading, 7)
			WaitForTurn(A32,x_axis)
			Turn(ARML, x_axis, math.rad(-5), 7)
			Turn(ARMR, x_axis, math.rad(-5), 7)
			Turn(A25,x_axis,math.rad(-7),9)
			Turn(A32,x_axis,math.rad(-7),9)
			Turn(AS04,x_axis,math.rad(7)-pitch,9)
			Turn(AS03,x_axis,math.rad(7)-pitch,9)
			

			WaitForTurn(bb05,y_axis)
			WaitForTurn(ARMR,y_axis)
			WaitForTurn(ARML,y_axis)
			if boolCanSMGFire==true then 
			Signal(SIG_SMG)
			StartThread(smgFireAnimation,pitch) end
			releasePriority(Weapons[1][7])
			return boolCanSMGFire 
				else
				return false
				end
			releasePriority(Weapons[1][7])
			else 
			return false 
			end
		end



	function script.FireWeapon5()	
		releasePriority(Weapons[1][7])
		Stats[1][5]=Stats[1][5]-Weapons[1][6] 
		ammonition=ammonition-Weapons[1][5]        

		boolCanSMGFire=false
		return true
	end
	--</SMG>
	--<STARBURST>
	boolStarBurstLoaded=true
	StarburstflipFlop=0
	SalvoMax=Weapons[4][1]
	FiredSalvos=0
	function script.AimFromWeapon6() 
		return You 
	end

	

	function script.QueryWeapon6() 
	StarburstflipFlop=(StarburstflipFlop+1)%(math.max(1,Weapons[4][1]))
	if StarburstflipFlop==0 then return starburst[1] end
	if StarburstflipFlop==1 then return starburst[2] end
	if StarburstflipFlop==2 then return starburst[3] end
	end

	function script.AimWeapon6( heading ,pitch)	
	
			if Weapons[4][1] > 0 and boolStarBurstLoaded== true and gotPriority(Weapons[4][7])==true  then 
			Spring.Echo("JW_COMENDERSCRIPT::Weapon6 got priority")
			SalvoMax=Weapons[4][1]
			Turn(starburst[1],x_axis,math.rad(-59),24)
			WaitForTurn(starburst[1],x_axis)
			return true and not boolOutOfAmmo
			end

			--/spinlock
	return false  	
	end

	function reloadWeapon6()
	Turn(starburst[1],x_axis,math.rad(0),7)
	Sleep(Weapons[4][8])
	FiredSalvos=0
	SalvoMax=Weapons[4][1]
	boolStarBurstLoaded=true
	end

	function script.FireWeapon6()	
	FiredSalvos=FiredSalvos+1
	Stats[1][5]=Stats[1][5]-Weapons[4][6] 
	ammonition=ammonition-Weapons[4][5]   
		if FiredSalvos==SalvoMax then
		releasePriority(Weapons[4][7])     
		boolStarBurstLoaded=false
		end
	
	return true
	end

	--</STARBURST>
	--<SHOTGUN>
	--DODO
	function script.AimFromWeapon7() 
		return You 
	end


	function script.QueryWeapon7() 
	
	end

	function script.AimWeapon7( heading ,pitch)	
	--Turn(piecename,y_axis,heading,0.42)
	--Turn(piecename,x_axis,-pitch,0.42)
		if Weapons[7][1]>0 and Weapons[7][10] > 0 then
		return true
			else
			return false
			end
	end
	function reloadWeapon7()

	end

	function script.FireWeapon7()	
	Weapons[7][10]=0
	Hide(bullets)
	return true
	end
	
	-- script.BlockShot8= function BlockShot8()
 			-- return
		-- end
	
	function script.AimFromWeapon8() 
		return You 
	end



	function script.QueryWeapon8() 
	
	end

	function script.AimWeapon8( heading ,pitch)	
	
	
	return  GG.NotifyBlockShot(unitID, 8) 
	end

	function reloadWeapon8()

	end

	function script.FireWeapon8()	

	return true
	end


	
	--</SHOTGUN>
	--<FlareGun>
	
	function script.AimFromWeapon9() 
		return You 
	end



	function script.QueryWeapon9() 
	return You
	end

	boolFlareGunReloadInProgress=false
	function reloadFlareGun()
	if boolFlareGunReloadInProgress==false then boolFlareGunReloadInProgress=true return end
	Sleep(7000)
		if boolOutOfAmmo== false then
		Weapons[6][5]=Weapons[6][6]
		end
	boolFlareGunReloadInProgress=false
	end
	
	-- Weapons[6][1]=0   				--	WeaponLevel   
	-- Weapons[6][2]=3					--  WeaponMax    
	-- Weapons[6][5]= 3					--  CurrentAmmo    
	-- Weapons[6][6]= 3					--  CurrentMaxAmmo    
	-- Weapons[6][7]= 5					--  Priority
	function script.AimWeapon9( heading ,pitch)	
		if Weapons[6][1] > 0  and gotPriority(Weapons[6][7])==true  then 
			if Weapons[6][5] <= 0 then 
			return false
			end
		return true and not boolOutOfAmmo
		end
		
	return false
	end


	function script.FireWeapon9()	
		Weapons[6][5]=math.max(Weapons[6][5]-1,0)
		Spring.PlaySoundFile("sounds/cComEnder/flare.wav",1.0)
		if Weapons[6][5] <= 0 then 
			StartThread(reloadFlareGun)
		end
	return true
	end

	--</FlareGun>
	

	--<SliceGun>
	
	function script.AimFromWeapon10() 
		return You 
	end



	function script.QueryWeapon10() 
	return Weapons[5][3]
	end

	boolSliceGunReloadInProgress=false
	function reloadSliceGun()
	if boolSliceGunReloadInProgress==false then boolSliceGunReloadInProgress=true return end
	Sleep(Weapons[5][6]/Weapons[5][1])
		Weapons[5][5]= true	
		boolSliceGunReloadInProgress=false
	end
		      
	-- Weapons[5][1]=0   					--	WeaponLevel   
	-- Weapons[5][2]=3						--  WeaponMax    
	-- Weapons[5][3]= SliceGun					--  CurrentAmmo    
	-- Weapons[5][4]=showSliceGun				    
	-- Weapons[5][5]= true					--  fireReady
	-- Weapons[5][6]= 6000					--  CurrentCoolDownTime
	-- Weapons[5][7]= 5					--  Priority
	-- Weapons[5][8]= 5					--  AmmoCost

	function script.AimWeapon10( heading ,pitch)	
	return true 
	end


	function sliceGunSFX()
				EmitSfx( Weapons[5][3],1028)
				Sleep(1300)
				EmitSfx(Weapons[5][3],1029 )
	end
	

	function script.FireWeapon10()	
		ammonition=ammonition-Weapons[5][8]  
			StartThread(reloadSliceGun)
			StartThread(sliceGunSFX)
			
	return true
	end

	--</SliceGun>
	
	--<RazorGrenade>

	function script.AimFromWeapon11() 
		return You 
	end


	function script.QueryWeapon11() 
	return Weapons[5][3]
	end



	function script.AimWeapon11( heading ,pitch)	
	return true 
	end



	function script.FireWeapon11()	
		ammonition=ammonition-Weapons[5][8]  		
	return true
	end

	
	
	
	--</RazorGrenade>
	--<TangleGun>
	
	function script.AimFromWeapon12() 
		return You 
	end



	function script.QueryWeapon12() 
	return Weapons[9][3]
	end


	function reloadTangleGun()
	Spin(TangleRota,y_axis,math.rad(-512),0.5)
	Spin(TangleRota,x_axis,math.rad(-12),0.5)
		Sleep(Weapons[9][6]/Weapons[9][1]) 
		boolTangleGunLoaded=true
	end
	
	function script.AimWeapon12( heading ,pitch)	
	return boolTangleGunLoaded 
	end

	TangleCounter=0
	function script.FireWeapon12()	
	StopSpin(TangleRota,y_axis,0.5)
	StopSpin(TangleRota,x_axis,0.5)
	
	TangleCounter= 	TangleCounter+1
		ammonition=ammonition-Weapons[9][8]  
		if TangleCounter > 3* Weapons[9][1]  then --tangling ended
			boolTangleGunLoaded=false
			StartThread(reloadTangleGun)
			TangleCounter=0
		end
	
		
			
	return true
	end

	
	
	--</TangleGun>
	--<AAROCKET>
		
	function script.AimFromWeapon13() 
		return You 
	end



	function script.QueryWeapon13() 
	return Weapons[13][3]
	end

	boolAARocketLoaded=true
	function reloadAARockets()

		Sleep(Weapons[13][6]/Weapons[13][1]) 
		boolAARocketLoaded=true
	end
	
	function script.AimWeapon13( heading ,pitch)	
	return boolTangleGunLoaded 
	end


	function script.FireWeapon13()	

		ammonition=ammonition-Weapons[13][8]  
			StartThread(reloadAARockets)
	
		
			
	return true
	end

	
	
	
	--</AAROCKET>
	--<GROCKET>
		
	function script.AimFromWeapon14() 
		return You 
	end



	function script.QueryWeapon14() 
	return Weapons[14][3]
	end


	function reloadTangleGun()

		Sleep(Weapons[14][6]/Weapons[14][1]) 
		boolTangleGunLoaded=true
	end
	
	function script.AimWeapon14( heading ,pitch)	
	return boolTangleGunLoaded 
	end

	TangleCounter=0
	function script.FireWeapon14()	
	TangleCounter= 	TangleCounter+1
		ammonition=ammonition-Weapons[14][8]  
		if TangleCounter > 3* Weapons[14][1]  then --tangling ended
			boolTangleGunLoaded=false
			StartThread(reloadTangleGun)
			TangleCounter=0
		end
	
		
			
	return true
	end

	
	
	--</GROCKET>
	
	
	--</WEAPON>

function script.Activate()

	return 1
end

function script.Deactivate()

	return 0
end
