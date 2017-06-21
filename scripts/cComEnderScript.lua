include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"

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
-- EaterRockets
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
Leg2[#Leg2]= piece"shieldb17"

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
tangleGunT={}

tangleGunT[#tangleGunT+1]=TangleGun
tangleGunT[#tangleGunT+1]=TangleBase
tangleGunT[#tangleGunT+1]=TangleRota



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

Eater={}
Eater[#Eater+1]=SunBurst1
Eater[#Eater+1]=SunBurst2
Eater[#Eater+1]=SunBurst3

--/changed

--]]
--<STATS>
boolCanFire=true

--Enumeration of attributes
eProperty=1

eWalkSpeed=1
eWalkSpeedLimit=2
eAmor=3
eAmorMax=4
eStabilityinternal=5
eStabilityRegeneratRate=6
eStabilityMax=7
eSensorRadiusLvl=8
eSensorRadius=9
eSensorLvlMax=10
eAmmonition=11
eAmmonitionMax=12
eStability=13

Stats={}
--Speed can sin below 1.0 resulting in a stationary comender
walkSpeed=1.0 --final result
currSpeed=1.0 --speed the whole unit got upgraded to
walkSpeedLimit=3.0 --maximum

Stats[eProperty]={}
Stats[eProperty][eWalkSpeed]=walkSpeed
Stats[eProperty][eWalkSpeedLimit]=walkSpeedLimit
Stats[eProperty][eAmor]=0
Stats[eProperty][eAmorMax]=4		--ArmourMax

-- stability is mainly reduced by weapons.. comender can topple over if firing with to low stability
Stats[eProperty][eStabilityinternal]=2.0		--stability --the CalcedValue

Stats[eProperty][eStabilityRegeneratRate]=0.05	--stabilityRegenerationRate
Stats[eProperty][eStabilityMax]=6		--stabilityMax

Stats[eProperty][eSensorRadiusLvl]=1.0--SensorRadiusLVL
Stats[eProperty][eSensorRadius]=Spring.GetUnitSensorRadius(unitID,"los")--sensorRadius
Stats[eProperty][eSensorLvlMax]=5

Stats[eProperty][eAmmonition]= 100	
Stats[eProperty][eAmmonitionMax] = 100

Stats[eProperty][eStability]=2 --stability Level


shieldsToShowWrap={}

for i=16, 28, 1 do
	shieldsToShowWrap[#shieldsToShowWrap+1]={}
	piecename="shield"..i
	shieldsToShowWrap[#shieldsToShowWrap]=piece(piecename)
	
end


--Stats[eProperty][eAmmonition] -is refilled at the citadell
Stats[eProperty][eAmmonition]=100
Stats[eProperty][eAmmonitionMax]=100

teamID=Spring.GetUnitTeam(unitID)
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
	if 	Weapons[eTractorGun][1]== 1 then Show(SunBurst1) end
	if 	Weapons[eTractorGun][1]== 2 then Show(SunBurst2) end
	if 	Weapons[eTractorGun][1]== 3 then Show(SunBurst3) end
end
function showGLauncher()
	for i=1,#gLauncher,1 do 
		Show(gLauncher[i])
	end 
end 
function showEater()
	Show(Eater[1])
end
function showTangleGun()
	showT(tangleGunT)
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
	
	for i=1,12 -sniperAmmoIterator, 1 do
		Show(sniperAmmoTable[i])
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
	
	for i=1, Stats[eProperty][eAmor], 1 do
		showT(overArmour[i].arms)
		Show(BaseArmor[i])
	end
	
	Nr=Stats[eProperty][eStability]
	
	if Nr < 3 then
		for i=1, Stats[eProperty][eAmor], 1 do
			showT(overArmour[i].leg1)
			showT(overArmour[i].leg2)
		end
	elseif Nr < 4 and Nr > 3 then 
		for i=1, Stats[eProperty][eAmor], 1 do
			showT(overArmour[i].leg1)
			showT(overArmour[i].leg2)
			showT(overArmour[i].leg3)
		end
		
	elseif Nr < 5 then
		for i=1, Stats[eProperty][eAmor], 1 do
			showT(overArmour[i].leg1)
			showT(overArmour[i].leg2)
			showT(overArmour[i].leg3)
			showT(overArmour[i].leg4)
		end
		
	elseif Nr < 6 then
		Show(fspine03)
		Show(bpine02)
		for i=1, Stats[eProperty][eAmor], 1 do
			showT(overArmour[i].leg1)
			showT(overArmour[i].leg2)
			showT(overArmour[i].leg3)
			showT(overArmour[i].leg4)
			showT(overArmour[i].leg5)
		end
	elseif Nr < 7 then
		for i=1, Stats[eProperty][eAmor], 1 do
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
	local Nr=Stats[eProperty][eStability]
	
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
--reason to commit
function showTime()
	while true do
		Sleep(250)
		showLegs()
	for i=1, #WeaponsTable do
		Weapons[i][eShowFunc]()
	end
	end
end

--</ONUPGRADESHOW>
eWeapnLvl=1
eWeapnMax=2
eAimPiece=3
eShowFunc=4
eAmmoCost=5
eStabCost=6
ePrioLevl=7
eCoolDown=8
eRecoilMx=9
eCurrCool=10

--<WEAPONS>
Weapons={}
--MaschineGun
eSubMG=1
Weapons[eSubMG]={} 
Weapons[eSubMG][eWeapnLvl]=1 				 --WeaponLevel 
Weapons[eSubMG][eWeapnMax]=3 				 --WeaponMax 
Weapons[eSubMG][eAimPiece]=smg 
Weapons[eSubMG][eShowFunc]= showSMG 
Weapons[eSubMG][eAmmoCost]= 0.1 		 --AmmoCost	 	 
Weapons[eSubMG][eStabCost]= 0.1 		 --StabilityCost	 
Weapons[eSubMG][ePrioLevl]= 1 		 --PriorityLevel the bigger the more Priority it Got	 --Priority 0 equals can fire at all times

--Sniper
eSniper=2
Weapons[eSniper]={} 
Weapons[eSniper][eWeapnLvl]=0 				 --WeaponLevel 
Weapons[eSniper][eWeapnMax]=3 				 --WeaponMax
Weapons[eSniper][eAimPiece]=cSniper 
Weapons[eSniper][eShowFunc]= showSniper 
Weapons[eSniper][eAmmoCost]= 0.5 		 	--AmmoCost	 
Weapons[eSniper][eStabCost]= 0.5 		 	--StabilityCost	 
Weapons[eSniper][ePrioLevl]= 9 		 	--PriorityLevel the bigger the more Priority it Got 
Weapons[eSniper][eCoolDown]= 8000 		--Downtime 
Weapons[eSniper][eRecoilMx]= 3 		 	 	--RecoilMax 
Weapons[eSniper][eCurrCool]= 0
--GrenadeLauncher
eGLauncher=3
Weapons[eGLauncher]={}
Weapons[eGLauncher][eWeapnLvl]=0 				 --WeaponLevel 
Weapons[eGLauncher][eWeapnMax]=3 				 --WeaponMax
Weapons[eGLauncher][eAimPiece]=gLauncher
Weapons[eGLauncher][eShowFunc]=showGLauncher 		 
Weapons[eGLauncher][eAmmoCost]=1 	--AmmoCost 
Weapons[eGLauncher][eStabCost]= 0.35 		--StabilityCost	
Weapons[eGLauncher][ePrioLevl]= 3 		 	--PriorityLevel the bigger the more Priority it Got
Weapons[eGLauncher][eCoolDown]= 1000 		--Downtime
Weapons[eGLauncher][eRecoilMx]= 0.35 				--RecoilMax 
--EaterRocket
eEater=4
Weapons[eEater]={}
Weapons[eEater][eWeapnLvl]=0 				 --WeaponLevel 
Weapons[eEater][eWeapnMax]=3 				 --WeaponMax 
Weapons[eEater][eAimPiece]=Eater 
Weapons[eEater][eShowFunc]=showEater 		 
Weapons[eEater][eAmmoCost]=1 	 --AmmoCost 
Weapons[eEater][eStabCost]= 0.25 		 --StabilityCost	 
Weapons[eEater][ePrioLevl]= 9 		 	 --PriorityLevel the bigger the more Priority it Got
Weapons[eEater][eCoolDown]= 2000 		 --Downtime
Weapons[eEater][eRecoilMx]= 0.1 		 	 --RecoilMax	
--SliceGun
eSlicer=5
Weapons[eSlicer]={}
Weapons[eSlicer][eWeapnLvl]=0 					--	WeaponLevel 
Weapons[eSlicer][eWeapnMax]=3						-- WeaponMax 
Weapons[eSlicer][eAimPiece]= cFieldScooper[1]					-- CurrentPiece 
Weapons[eSlicer][eShowFunc]=showSliceGun				 
Weapons[eSlicer][eAmmoCost]= 1					-- AmmoCos
Weapons[eSlicer][eStabCost]=0.0 				-- StabilityCost
Weapons[eSlicer][ePrioLevl]= 5 				--PriorityLevel 
Weapons[eSlicer][eCoolDown]= 6000				-- Downtime
Weapons[eSlicer][eRecoilMx]= 0.1 		 		 --RecoilMax
Weapons[eSlicer][eCurrCool]= 0			-- fireReady






--FlareGun
eFlareGun=6
Weapons[eFlareGun]={}
Weapons[eFlareGun][eWeapnLvl]=0 					--	WeaponLevel 
Weapons[eFlareGun][eWeapnMax]=3						-- WeaponMax 
Weapons[eFlareGun][eAimPiece]= FlareGun					-- CurrentAmmo 
Weapons[eFlareGun][eShowFunc]=showFlareGun				 
Weapons[eFlareGun][eAmmoCost]= 3					-- CurrentAmmo 
Weapons[eFlareGun][eStabCost]= 0.1					-- Stability 
Weapons[eFlareGun][ePrioLevl]= 5					-- Priority

--ShotGun
eShotGun=7
Weapons[eShotGun]={}
Weapons[eShotGun][eWeapnLvl]=0 				 --WeaponLevel 
Weapons[eShotGun][eWeapnMax]=3 				 --WeaponMax 
Weapons[eShotGun][eAimPiece]=cMagneto 
Weapons[eShotGun][eShowFunc]=showShotgun 		 
Weapons[eShotGun][eAmmoCost]= 1 	 			--AmmoCost 
Weapons[eShotGun][eStabCost]= 0.35 		 --StabilityCost	 
Weapons[eShotGun][ePrioLevl]= 4 		 	 --PriorityLevel the bigger the more Priority it Got
Weapons[eShotGun][eCoolDown]= 2000 		 --Downtime
Weapons[eShotGun][eRecoilMx]= 0.2 		 	 --RecoilMax	
Weapons[eShotGun][10]= 0 		 	 --ScrapAmmonition 	

--<ShotTractorGun>--Markerweapon
boolTractorWeaponActivated=false
eTractorGun=8
Weapons[eTractorGun]={}
Weapons[eTractorGun][eWeapnLvl]=0 				 --WeaponLevel 
Weapons[eTractorGun][eWeapnMax]=1 				 --WeaponMax 
Weapons[eTractorGun][eAimPiece]=cMagneto 
Weapons[eTractorGun][eShowFunc]=showShotgun 		 
Weapons[eTractorGun][eAmmoCost]= 0.1 	 --AmmoCost 
Weapons[eTractorGun][eStabCost]= 0.25 		 --StabilityCost	 
Weapons[eTractorGun][ePrioLevl]= 6 		 	 --PriorityLevel the bigger the more Priority it Got
Weapons[eTractorGun][eCoolDown]= 2000 		 --Downtime
Weapons[eTractorGun][eRecoilMx]= 0.2 		 	 --RecoilMax	
--</ShotTractorGun>

--TangleGun
eTangleGun=9
Weapons[eTangleGun]={}
Weapons[eTangleGun][eWeapnLvl]=0 				 --WeaponLevel 
Weapons[eTangleGun][eWeapnMax]=3 				 --WeaponMax 
Weapons[eTangleGun][eAimPiece]=TangleGun 
Weapons[eTangleGun][eShowFunc]=showTangleGun 		 
Weapons[eTangleGun][eAmmoCost]= 0.1 	 --AmmoCost 
Weapons[eTangleGun][eStabCost]= 0.05 		 --StabilityCost	 
Weapons[eTangleGun][ePrioLevl]= 3 		 	 --PriorityLevel the bigger the more Priority it Got
Weapons[eTangleGun][eCoolDown]= 500 		 --Downtime
Weapons[eTangleGun][eRecoilMx]= 0 		 	 --RecoilMax	
Weapons[eTangleGun][eCurrCool]= 0 		 	 --eCurrCool	

--RazorGrenade
function showRazorGrenade()
	
end
eRazorGrenade=11
Weapons[eRazorGrenade]={}
Weapons[eRazorGrenade][eWeapnLvl]=0 				 --WeaponLevel 
Weapons[eRazorGrenade][eWeapnMax]=3 				 --WeaponMax 
Weapons[eRazorGrenade][eAimPiece]=You 
Weapons[eRazorGrenade][eShowFunc]=showRazorGrenade 		 
Weapons[eRazorGrenade][eAmmoCost]= 0.1 	 		--AmmoCost 
Weapons[eRazorGrenade][eStabCost]= 0.05 		 --StabilityCost	 
Weapons[eRazorGrenade][ePrioLevl]= 3 		 	 --PriorityLevel the bigger the more Priority it Got
Weapons[eRazorGrenade][eCoolDown]= 700 		 	--Downtime
Weapons[eRazorGrenade][eRecoilMx]= 0 		 	 --RecoilMax	


--Anti Air Rockets
function showARocket()
	for i=1,Weapons[eAARocket][1], 1 do
		Show(guidedMissile[i])
	end
end

eAARocket=13
Weapons[eAARocket]={}
Weapons[eAARocket][eWeapnLvl]=0 				 --WeaponLevel 
Weapons[eAARocket][eWeapnMax]=3 				 --WeaponMax 
Weapons[eAARocket][eAimPiece]=guidedMissile 
Weapons[eAARocket][eShowFunc]=showARocket 		 
Weapons[eAARocket][eAmmoCost]= 0.1 	 --AmmoCost 
Weapons[eAARocket][eStabCost]= 0.05 		 --StabilityCost	 
Weapons[eAARocket][ePrioLevl]= 3 		 	 --PriorityLevel the bigger the more Priority it Got
Weapons[eAARocket][eCoolDown]= 700 		 --Downtime
Weapons[eAARocket][eRecoilMx]= 0 		 	 --RecoilMax	
Weapons[eAARocket][eCurrCool]= 0 		 	 --RecoilMax	



function showGroundRocket()
	for i=1,Weapons[eGRocket][1], 1 do
		Show(unguidedMissile[i])
	end
end
eGRocket=14
-- Ground Rocket 
Weapons[eGRocket]={}
Weapons[eGRocket][eWeapnLvl]=0 				 --WeaponLevel 
Weapons[eGRocket][eWeapnMax]=3 				 --WeaponMax 
Weapons[eGRocket][eAimPiece]=unguidedMissile 
Weapons[eGRocket][eShowFunc]=showGroundRocket 		 
Weapons[eGRocket][eAmmoCost]= 0.1 	 --AmmoCost 
Weapons[eGRocket][eStabCost]= 0.05 		 --StabilityCost	 
Weapons[eGRocket][ePrioLevl]= 3 		 	 --PriorityLevel the bigger the more Priority it Got
Weapons[eGRocket][eCoolDown]= 700 		 --Downtime
Weapons[eGRocket][eRecoilMx]= 0 		 	 --RecoilMax	
Weapons[eGRocket][eCurrCool] = 0

--</WEAPONS>
--<TOOLS>
--EscapePod
--AmmoFactory
--Repairdrone
--AnomalyMincefactory
--Reconisancedronefactory

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

maxSpeed= COB.MAX_SPEED 
WACKY_CONVERSION_FACTOR_1=2184.53
function setSpeedComEnder(percent)
	limitedpercdent=math.max(0,math.min(percent,100))
	limitedpercdent= 100/limitedpercdent
	speed = math.ceil(limitedpercdent*maxSpeed* WACKY_CONVERSION_FACTOR_1)
	SetUnitValue(COB.MAX_SPEED,speed)
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
	
	if degreeInRads > 180 and degreeInRads < 0 then addx=1 end
	
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


function threadStarter()
	while true do
		if boolFlickerThreadStart==true then 
			StartThread(shieldFlicker,shielddegree,shielddamage) 
			boolFlickerThreadStart=false 
		end
		Sleep(150)
	end
end

SIG_RECENTD=256
function idleReset()
	boolDoNotIdle=true
	Signal(SIG_RECENTD)
	SetSignalMask(SIG_RECENTD)
	Sleep(15000)
	boolDoNotIdle=false
end

function script.HitByWeapon ( x, z, weaponDefID, damage )
	
	
	StartThread(idleReset)
	
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
	if Stats[eProperty][eAmor]== Stats[eProperty][eAmorMax]then
		boolFlickerThreadStart=true
	end
	
	Weapons[eShotGun][10]= 	Weapons[eShotGun][10]+damage
	if Weapons[eShotGun][eWeapnLvl] ~= 0 and 	Weapons[eShotGun][10] > 50 then Show(bullets) else Hide(bullets) end
	return damage
end

function delayedSound(soundname,delay)
	Sleep(delay)
	spPlaySoundFile(soundname,1.0)
	
end

function echoDebugInfo()
while true do
Sleep(5500)
Spring.Echo("CommenderAmmo:"..Stats[eProperty][eAmmonition])

end
end

function script.Create()
	Spring.SetUnitExperience(unitID,12)
	--	Spring.Echo("cComEnder::Startspeed -> "..(100- (50/Stats[eProperty][eWalkSpeedLimit])*Stats[eProperty][eWalkSpeed]))
	setSpeedComEnder(100- (50/Stats[eProperty][eWalkSpeedLimit])*Stats[eProperty][eWalkSpeed])
	sd=math.floor(math.random(1,5))
	strings="sounds/cComEnder/comEnder"..sd..".wav"
	StartThread(delayedSound,strings,7000)
	StartThread(echoDebugInfo)
	--generatepiecesTableAndArrayCode(unitID)
	
	
	resetT(piecesTable)
	hideT(piecesTable)
	
	showT(basics)
	hideT(cMagneto)
	hideT(tangleGunT)
	hideT(cFieldScooper)
	hideT(guidedMissile)
	hideT(unguidedMissile)
	
	
	Spin(bullets,y_axis,math.rad(182),0.5)
	Spin(bullets,x_axis,math.rad(-220),0.5)
	StartThread(alwaysWatching)
	
	StartThread(walkTheDog)
	StartThread(updateProgressBar)
	StartThread(sniperKneeDown)
	StartThread(threadStarter)
	StartThread(showTime)
	StartThread(ammoFacLoop)
	StartThread(reactorThread)
	StartThread(idleLoop)

	
end


function script.StopBuilding()
	SetUnitValue(COB.INBUILDSTANCE, 0)
end
boolDoNotIdle=false

function idleLoop()
	while true do
		if boolWalking == false then
			Sleep(10)
			if boolWalking == false and boolDoNotIdle== false then
				idle(0.15)
				Turn(bb05,y_axis,math.rad(0),0.25)
			end
			
		end
		
		Sleep(1000)
	end
	
end

--[[ 	
Stats[eProperty][eStabilityinternal]=stability=1.0
Stats[eProperty][eStabilityRegeneratRate]=stabilityRegenerationRate=0.05
Stats[eProperty][eStabilityMax]=stabilityMax=6.0 
]]

--> Energy produced by the comender
function reactorThread()
	local cloakCost = UnitDefNames["ccomender"].cloakCost
	
	while true do
		boolUnitCloaked=Spring.GetUnitIsCloaked(unitID)
		if boolUnitCloaked == true then
			addValueEnergy= math.ceil(math.abs((cloakCost*1.5)/3 * StealthEffectiveness))
			Spring.AddUnitResource(unitID,"e",addValueEnergy)
		end
		Sleep(1000)
	end
end


function theActualUpgrade(upgradeType)
	echo("ComEnder::",upgradeType)
	XP=Spring.GetUnitExperience(unitID) 
	
	if XP >= 1 then
		if upgradeType == "SPEED" and Stats[eProperty][eWalkSpeed] <= Stats[eProperty][eWalkSpeedLimit]then
			Stats[eProperty][eWalkSpeed]=Stats[eProperty][eWalkSpeed]+1
			setSpeedComEnder(100- (50/Stats[eProperty][eWalkSpeedLimit])*Stats[eProperty][eWalkSpeed])
			spSetUnitExperience(unitID,XP -1)	
		end
		
		if upgradeType ==	"ARMOR" and 	Stats[eProperty][eAmor] < 	Stats[eProperty][eAmorMax] then
			Stats[eProperty][eAmor]=Stats[eProperty][eAmor]+1
			Stats[eProperty][eWalkSpeed]=math.max(Stats[eProperty][eWalkSpeed]-0.5,1)
			setSpeedComEnder(100- (50/Stats[eProperty][eWalkSpeedLimit])*Stats[eProperty][eWalkSpeed])
			
			health, maxHealth, paralyzeDamage, captureProgress, buildProgress=Spring.GetUnitHealth(unitID)
			ratio=health/maxHealth
			Spring.SetUnitMaxHealth(unitID,maxHealth*Stats[eProperty][eAmor])
			Spring.SetUnitHealth(unitID,math.ceil(maxHealth*Stats[eProperty][eAmor]*ratio))		
			spSetUnitExperience(unitID,XP -1)	
		end
		
		if upgradeType =="STABILITY" and Stats[eProperty][eStability] < Stats[eProperty][eStabilityMax] then
			echo("STable")
			Stats[eProperty][eStability]=Stats[eProperty][eStability]+1
			echo(Stats[eProperty][eStability])
			Stats[eProperty][eStabilityRegeneratRate]=0.05*Stats[eProperty][eStability]
			spSetUnitExperience(unitID,XP -1)	
		end
		
		if upgradeType =="AMMO"then
			Stats[eProperty][eAmmonitionMax]=Stats[eProperty][eAmmonitionMax]+50
			spSetUnitExperience(unitID,XP -1)	
		end
		
		if upgradeType =="SENSORS" and Stats[eProperty][eSensorRadiusLvl] < Stats[eProperty][eSensorLvlMax] then
			Stats[eProperty][eSensorRadiusLvl]=		Stats[eProperty][eSensorRadiusLvl]+0.5
			Spring.SetUnitSensorRadius(unitID,"los",math.ceil(Stats[eProperty][eSensorRadiusLvl]*Stats[eProperty][eSensorRadius]))
			spSetUnitExperience(unitID,XP -1)
		end
		
		
		--SMG
		if upgradeType =="SMG" and Weapons[eSubMG][1] ~= Weapons[eSubMG][2] then
			--identify Cost
			Weapons[eSubMG][1]=math.min(Weapons[eSubMG][1]+1,Weapons[eSubMG][2])
			spSetUnitExperience(unitID,XP -1)
		end
		
		--GRENADE
		if upgradeType =="GRENADE" and 	Weapons[eGLauncher][1] ~= Weapons[eGLauncher][2] then
			Weapons[eGLauncher][1]=math.min(Weapons[eGLauncher][1]+1,Weapons[eGLauncher][2])
			spSetUnitExperience(unitID,XP -1)
		end
		
		--SNIPER
		if upgradeType =="SNIPER" and Weapons[eSniper][1] ~= Weapons[eSniper][2] then
			Weapons[eSniper][1]=math.min(Weapons[eSniper][1]+1,Weapons[eSniper][2])
			spSetUnitExperience(unitID,XP -1)
		end
		--"SHOTGUN"
		if upgradeType =="SHOTGUN" and Weapons[eTractorGun][1] ~= Weapons[eTractorGun][2] then
			Weapons[eTractorGun][1]=math.min(Weapons[eTractorGun][1]+1,Weapons[eTractorGun][2])
			spSetUnitExperience(unitID,XP -1)
		end
		
		--"Eater"
		if upgradeType =="EATER" and Weapons[eEater][1] ~= Weapons[eEater][2] then
			Weapons[eEater][1]=math.min(Weapons[eEater][1]+1,Weapons[eEater][2])
			for i=1,Weapons[eEater][1],1 do
				Show(Eater[i])
			end		
			spSetUnitExperience(unitID,XP -1)
		end
		
		--"FLAREGUN"
		if upgradeType =="FLARE" and Weapons[eFlareGun][1] ~= Weapons[eFlareGun][2] then
			Weapons[eFlareGun][1]=math.min(Weapons[eFlareGun][1]+1,Weapons[eFlareGun][2])
			Weapons[eFlareGun][4]()	
			spSetUnitExperience(unitID,XP -1)
		end
		
		if upgradeType == "SLICER" and Weapons[eSlicer][1] ~= Weapons[eSlicer][2] then
			Weapons[eSlicer][1]=math.min(Weapons[eSlicer][1]+1,Weapons[eSlicer][2])
			Weapons[eSlicer][4]()	
			spSetUnitExperience(unitID,XP -1)
		end		
		
		if upgradeType == "RAZOR" and Weapons[eRazorGrenade][1] ~= Weapons[eRazorGrenade][2] then
			Weapons[eRazorGrenade][1]=math.min(Weapons[eRazorGrenade][1]+1,Weapons[eRazorGrenade][2])
			Weapons[eRazorGrenade][4]()	
			spSetUnitExperience(unitID,XP -1)
		end	
		
		if upgradeType == "TANGLE" and Weapons[eTangleGun][1] ~= Weapons[eTangleGun][2] then
			Weapons[eTangleGun][1]=math.min(Weapons[eTangleGun][1]+1,Weapons[eTangleGun][2])
			Weapons[eTangleGun][4]()	
			spSetUnitExperience(unitID,XP -1)
		end
		
		if upgradeType == "AROCKET" and Weapons[eAARocket][1] ~= Weapons[eAARocket][2] then
			Weapons[eAARocket][1]=math.min(Weapons[eAARocket][1]+1,Weapons[eAARocket][2])
			Weapons[eAARocket][4]()	
			spSetUnitExperience(unitID,XP -1)
		end
		
		if upgradeType == "GROCKET" and Weapons[eGRocket][1] ~= Weapons[eGRocket][2] then
			Weapons[eGRocket][1]=math.min(Weapons[eGRocket][1]+1,Weapons[eGRocket][2])
			Weapons[eGRocket][4]()	
			spSetUnitExperience(unitID,XP -1)
		end
		
		if upgradeType == "EJECTPOD" and LazarusDevice ~= LazarusDeviceMax then
			LazarusDevice=math.min(LazarusDevice+1,LazarusDeviceMax)
			spSetUnitExperience(unitID,XP -1)
		end
		
		if upgradeType == "AMMOFAC" and AmmoFacEffectiveness ~= AmmoFacEffectivenessMax then
			AmmoFacEffectiveness=math.min(AmmoFacEffectiveness+1,AmmoFacEffectivenessMax)
			spSetUnitExperience(unitID,XP -1)
		end
		
		if upgradeType == "RADAR" and RadarEffectiveness ~= RadarEffectivenessMax then
			RadarEffectiveness=math.min(RadarEffectiveness+1,RadarEffectivenessMax)
			Spring.SetUnitSensorRadius(unitID,"radar",RadarRadius*RadarEffectiveness)
			spSetUnitExperience(unitID,XP -1)
		end
		
		if upgradeType == "STEALTH" and StealthEffectiveness ~= StealthEffectivenessMax then
			StealthEffectiveness=math.min(StealthEffectiveness+1,StealthEffectivenessMax)
			
			spSetUnitExperience(unitID,XP -1)
		end
		--identify Upgrade Possible
		
		
	end
	
end

function fireWeaponCost(typeW)
	StartThread(idleReset)
	
	Stats[eProperty][eStabilityinternal]=Stats[eProperty][eStabilityinternal]-Weapons[typeW][eStabCost] 
	Stats[eProperty][eAmmonition] =math.max(Stats[eProperty][eAmmonition]-Weapons[typeW][eAmmoCost],0)
end

--UPGRADECONST
LazarusDevice=0
LazarusDeviceMax=3

RadarRadius= 250
RadarEffectivenessMax=5
RadarEffectiveness=0

StealthEffectiveness=0
StealthEffectivenessMax=4

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
		
		Stats[eProperty][eAmmonition]=math.min(Stats[eProperty][eAmmonition]+AmmoFacEffectiveness/10,Stats[eProperty][eAmmonitionMax])
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
	Time=math.ceil(math.abs(Stats[eProperty][eStabilityinternal]*900))
	if boolImpulse == true then
		
		tx,tz=0,0
		tx,tz=Spring.GetVectorFromHeading(heading)
		Spring.AddUnitImpulse(unitID,tx*-4,0,tz*-4)
		Sleep(Time)
		
	else
		TX=math.ceil(Time/7)
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
		if Stats[eProperty][eStabilityinternal] >= 1 then boolCanFire=true end
		
		--unstable	
		if boolCanFallOnce ==true and Stats[eProperty][eStabilityinternal] < 1 and Stats[eProperty][eStabilityinternal] > 0 then 
			boolCanFallOnce=false
			StartThread(topplingOver,1-Stats[eProperty][eStabilityinternal],false,spGetUnitHeading(UnitID))	
		end
		
		if boolCanFallOnce ==true and Stats[eProperty][eStabilityinternal] <= 0 then
			boolCanFallOnce=false
			StartThread(topplingOver,1-Stats[eProperty][eStabilityinternal],true,spGetUnitHeading(UnitID))	
		end
		
		Stats[eProperty][eStabilityinternal]=math.min(Stats[eProperty][eStabilityinternal]+Stats[eProperty][eStabilityRegeneratRate],Stats[eProperty][eStabilityMax])
		Sleep(150)
	end
	
end

function script.StartBuilding(heading, pitch)
	
	--identify Unit
	SetUnitValue(COB.INBUILDSTANCE, 1)
end

Spring.SetUnitNanoPieces(unitID,{ center})

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
	globalHipTurn=0
	while(true)do 
		Sleep(70)
		while boolWalking==true do
			local lwalkSpeed=Stats[eProperty][eWalkSpeed]
			
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
			if lLegBoolean==false then
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
			resetT(Legg4)
			resetT(Legg3)
			resetT(Legg5)
			resetT(Legg6)
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
	
	createCorpseCUnitGeneric(recentDamage)
	
	return 1
end

function totalReset(boolDelayed,Time)
	SetSignalMask(SIG_RESET)
	if boolDelayed==true then Sleep(Time) end
	Move(testComEnder3DS,y_axis,0,39)
	resetT(piecesTable,12)
	
	
end

function legs_down(boolDelayed,Time)
	if boolDelayed==true then Sleep(Time) end
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
		if Stats[eProperty][eAmmonition] <= 0 then
			boolOutOfAmmo=true
		else
			boolOutOfAmmo=false
		end
		
		if Stats[eProperty][eAmmonition] < Stats[eProperty][eAmmonitionMax] then
			x,y,z=lspGetUnitPosition(unitID)
			
			unitsInResupplyCircle=lspGetUnitsInCylinder(x,z, 125)
			table.remove(unitsInResupplyCircle,unitID)
			if unitsInResupplyCircle ~= nil then
				
				for i=1,#unitsInResupplyCircle,1 do
					
					defID=lGetUnitDefID(unitsInResupplyCircle[i])
					tid= Spring.GetUnitTeam(unitsInResupplyCircle[i])
					if (defID == lcitadellDefID or defID== lcomendbonkerDefID ) and teamID == tid then 	
						
						if defID== lcitadellDefID then
							Stats[eProperty][eAmmonition]=Stats[eProperty][eAmmonitionMax]
						else
							Stats[eProperty][eAmmonition]=Stats[eProperty][eAmmonitionMax]
							h=Spring.GetUnitHealth(unitID)	
							Spring.SetUnitHealth(unitID,h+50)
						end
						
						
					end
				end
			end
		end
		Spring.SetUnitRulesParam(unitID,"Ammonition",Stats[eProperty][eAmmonition] or 0)

		
		
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
	if Weapons[eGLauncher][1] ==1 then
		--echo("CComEnderScript:: Heading:"..math.deg(heading)," Pitch: "..math.deg(pitch))
		if pitch < pitchBlease then return false end
		if math.deg(heading) < gheadPlus and math.deg(heading) > gheadPlus*-1 then return false end 
		
		if gotPriority(Weapons[eGLauncher][7])==true then
			Signal(SIG_AIM)
			SetSignalMask(SIG_AIM)
			canFire=false
			
			Turn(glaunch,y_axis,heading,3)
			Turn(glaunch, x_axis, math.rad(math.deg(pitch)*-1), 3)
			WaitForTurn(glaunch,y_axis)
			WaitForTurn(glaunch,x_axis)	
			
			--return canFire
			
			releasePriority(Weapons[eGLauncher][7])
			return boolOutOfAmmo ==false
		end
	end
	return false 
end

function script.FireWeapon1()
	fireWeaponCost(eGLauncher)
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
	if Weapons[eGLauncher][1]==2 and gotPriority(Weapons[eGLauncher][7])==true then 
		--echo("CComEnderScript:: Heading:"..math.deg(heading)," Pitch: "..math.deg(pitch))
		if pitch < pitchBlease then return false end
		if math.deg(heading) < gheadPlus and math.deg(heading) > gheadPlus*-1 then return false end 
		
		
		Signal(SIG_AIM)
		SetSignalMask(SIG_AIM)
		canFire=false
		
		-- the unit turns and meanwhile looses priority - resulting in phail 
		Turn(glaunch,y_axis,heading,3)
		Turn(glaunch, x_axis, math.rad(math.deg(pitch)*-1), 3)
		WaitForTurn(glaunch,y_axis)
		WaitForTurn(glaunch,x_axis)	
		
		--return canFire
		releasePriority(Weapons[eGLauncher][7])	
		return boolOutOfAmmo ==false
	else 
		releasePriority(Weapons[eGLauncher][7])			
		return false 
	end
end

function script.FireWeapon2()	
	releasePriority(Weapons[eGLauncher][7])
	fireWeaponCost(eGLauncher)
	
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
	
	if Weapons[eGLauncher][1]==3 and gotPriority(Weapons[eGLauncher][7])==true then
		--echo("CComEnderScript:: Heading:"..math.deg(heading)," Pitch: "..math.deg(pitch))
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
		releasePriority(Weapons[eGLauncher][7])	
		return boolOutOfAmmo ==false
	else 
		releasePriority(Weapons[eGLauncher][7])	
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
	releasePriority(Weapons[eGLauncher][7])
	fireWeaponCost(eGLauncher)
	
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

function idle(speed)
	Move(center,y_axis,-10,3.6)
	times=5/3
	rval=iRand(10,44)
	equiTurn(ARML,AS04,x_axis,rval,speed)
	rval=iRand(10,44)
	equiTurn(ARMR,AS03,x_axis,rval,speed)
	
	equiTurn(LS08,LK08,x_axis,-20,speed)
	equiTurn(LS07,LK07,x_axis,-20,speed)
	rSign=randSign()
	Turn(bb05,y_axis,math.rad(math.random(12,22)*rSign),speed)
	WaitForTurns(LS07,LK07,LS08,LK08,ARML,ARMR)
	WMove(center,y_axis,-10,3.6)
	
	equiTurn(LS08,LK08,x_axis,0,speed)
	equiTurn(LS07,LK07,x_axis,0,speed)
	equiTurn(ARML,AS04,x_axis,0,speed)
	equiTurn(ARMR,AS03,x_axis,0,speed)
	Turn(bb05,y_axis,math.rad(math.random(12,22)*rSign*-1),speed)
	WMove(center,y_axis,0,3.6)
	WaitForTurns(LS07,LK07,LS08,LK08,ARML,ARMR)
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
			Turn(testComEnder3DS,y_axis,gSniperHeading,Stats[eProperty][eWalkSpeed])
			
			
			while (true==Spring.UnitScript.IsInTurn (testComEnder3DS, y_axis)) do
				echo("JW_COMENDERSCRIPT::Aligning to fire")
				boolWalking=true
				Sleep(500)
			end
			boolWalking=false
			legs_down()
			--setSpeedComEnder(0)
			boolWalking=false
			
			DT(LSK10,LSK09,6,1.7*Stats[eProperty][eWalkSpeed],nil,nil,5)			------------------------------------------
			DT(LK10,LK09,-130,1.7*Stats[eProperty][eWalkSpeed],nil,nil,2)			------------------------------------------
			DT(LSK10,LSK09,-82,2.7*Stats[eProperty][eWalkSpeed],nil,nil,1)	
			DT(LF3,LF09,32,2.7*Stats[eProperty][eWalkSpeed],nil,nil,1)	
			
			T(LS11,110,2.7*Stats[eProperty][eWalkSpeed],nil,nil,nil,nil)
			T(LK11,-90,2.7*Stats[eProperty][eWalkSpeed],nil,nil,nil,nil)
			T(LSK11,30,1.7*Stats[eProperty][eWalkSpeed],nil,nil,nil,nil)
			T(LF11,-45,1.7*Stats[eProperty][eWalkSpeed],0,Stats[eProperty][eWalkSpeed],0,Stats[eProperty][eWalkSpeed])
			
			T(LS12,110,2.7*Stats[eProperty][eWalkSpeed],nil,nil,nil,nil)
			T(LK12,-90,2.7*Stats[eProperty][eWalkSpeed],nil,nil,nil,nil)
			T(LSK12,30,1.7*Stats[eProperty][eWalkSpeed],nil,nil,nil,nil)
			T(LF12,-45,1.7*Stats[eProperty][eWalkSpeed],0,Stats[eProperty][eWalkSpeed],0,Stats[eProperty][eWalkSpeed])
			boolWalking=false
			boolSniperPermit=true
			while boolSniperPermit== true do
				Sleep(50)
			end
			Turn(testComEnder3DS,y_axis,math.rad(0),0.05)
			
			boolSniperGetIntoPosition=false
		end
		
		Sleep(300)
	end
end

function countDownSniperTimer()
	Weapons[eSniper][eCurrCool]=Weapons[eSniper][eCoolDown]/Weapons[eSniper][1]
	Move(Bolt,z_axis,-40,68)
	Move(pin,z_axis,-4.3,19)
	Show(Case)
	WaitForMove(Bolt,z_axis)
	Explode(Case,SFX.FALL +SFX.NO_HEATCLOUD)
	Hide(Case)
	spPlaySoundFile("sounds/cComEnder/Sniper/comEndSniperEject.wav",0.7)
	Turn(drum,z_axis,math.rad(sniperAmmoIterator*-13),15)	
	Move(Bolt,z_axis,0,68)			
	Sleep(	Weapons[eSniper][eCurrCool])
	Weapons[eSniper][eCurrCool]=0
end

boolSniperOnce=false
boolSniperGetIntoPosition=false
boolSniperPermit=false
gSniperHeading=0
gSniperPitch=0

function script.AimWeapon4( heading ,pitch)
	gSniperHeading=heading
	gSniperPitch=pitch
	echo("CComEnderScript:SniperAiming:1")
	if Weapons[eSniper][1] > 0 and Weapons[eSniper][eCurrCool] <= 0 and gotPriority(Weapons[eSniper][ePrioLevl])==true then
		--Sniper Kneel Animation
		
		echo("CComEnderScript:SniperAiming:2")
		
		if Weapons[eSniper][1]> 0 then
			
			if boolSniperOnce== false then 
				boolSniperGetIntoPosition=true
				boolSniperOnce=true
			end
			releasePriority(Weapons[eSniper][7])	
			echo("CComEnderScript:SniperAiming:3")
			return 	boolSniperPermit == true and boolOutOfAmmo ==false
		end
	end 
	echo("CComEnderScript:SniperAiming:4")
	return false
end

function script.FireWeapon4()
	boolSniperOnce=false
	boolSniperPermit=false
	Move(pin,z_axis,3,190)
	WaitForMove(pin,z_axis)
	
	if math.random(0,1)==1 then	spPlaySoundFile("sounds/cComEnder/Sniper/comEndSniper.wav",0.7) else spPlaySoundFile("sounds/cComEnder/Sniper/comEndSniperV2.wav",0.9) end
	sniperAmmoIterator=((sniperAmmoIterator)%12)+1
	if sniperAmmoIterator == 11 then 
		for i=1,#sniperAmmoTable,1 do
			Show(sniperAmmoTable[i])
		end
	end
	Hide(sniperAmmoTable[sniperAmmoIterator])
	_,_,_,recoilX,recoilY,recoilZ=spGetUnitPiecePosDir(unitID,sniper)
	norm=math.sqrt(recoilX^2+recoilY^2+recoilZ^2)
	
	recoilX=math.min(math.min(math.abs(recoilX/norm),	Weapons[eSniper][9]*Weapons[eSniper][2]),0)
	recoilZ=math.min(math.min(math.abs(recoilZ/norm),	Weapons[eSniper][9]*Weapons[eSniper][2]),0)
	
	
	Spring.AddUnitImpulse(unitID,recoilX*-1*	Weapons[eSniper][1],0,recoilZ*-1*	Weapons[eSniper][1],0.7)
	StartThread(countDownSniperTimer)
	fireWeaponCost(eSniper)
	
	setSpeedComEnder(100- (50/Stats[eProperty][eWalkSpeedLimit])*Stats[eProperty][eWalkSpeed])
	return true
end

--</SNIPER>
--<SMG>

function script.AimFromWeapon5() 
	SMGflipFlop=(SMGflipFlop+1)%4
	if SMGflipFlop==0 then return SMG1B03 end
	if SMGflipFlop==1 then return SMG1B04 end
	if SMGflipFlop==2 then return SMG2B03 end
	if SMGflipFlop==3 then return SMG2B04 end
	return bb05
end

SMGflipFlop=1

function script.QueryWeapon5() 
	return bb05
	-- SMGflipFlop=(SMGflipFlop+1)%4
	-- if SMGflipFlop==0 then return SMG1B03 end
	-- if SMGflipFlop==1 then return SMG1B04 end
	-- if SMGflipFlop==2 then return SMG2B03 end
	-- if SMGflipFlop==3 then return SMG2B04 end
	-- return SMG1B03
end

boolCanSMGFire=false
boolSMGOnlyOnce=false

function smWaitForIt()
	Time=math.floor(200/Weapons[eSubMG][1]) 
	Sleep(Time)
	boolCanSMGFire=true
	boolSMGOnlyOnce=false
end

function smgFireAnimation(pitch) --Aproximated Time of Execution: 0.9333 Seconds. TODO: Tailor it so that Animationspeed autoadapts to weapontime
	SetSignalMask(SIG_SMG)
	
	
	for i=1, 7,1 do
		Turn(ARML, x_axis, math.rad(2.4*i), 39)
		Turn(ARMR, x_axis, math.rad(2.4*i), 39)
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
globalHipTurn=0

function script.AimWeapon5( heading ,pitch)	
	
	if gotPriority(Weapons[eSubMG][7])==true then
		
		if boolSMGOnlyOnce== false then 
			boolSMGOnlyOnce=true
			StartThread(smWaitForIt)
			Signal(SIG_RESET)
			StartThread(totalReset,true,2500)
		end
		
		--/spinlock
		if boolCanSMGFire == true then
			globalHipTurn=heading
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
			releasePriority(Weapons[eSubMG][7])
			return boolCanSMGFire 
		else
			return false
		end
		releasePriority(Weapons[eSubMG][7])
	else 
		return false 
	end
end

function script.FireWeapon5()	
	releasePriority(Weapons[eSubMG][7])
	fireWeaponCost(eSubMG)
	
	boolCanSMGFire=false
	return true
end
--</SMG>
--<Eater>
boolEaterLoaded=true
EaterflipFlop=0
SalvoMax=Weapons[eEater][1]
FiredSalvos=0
function script.AimFromWeapon6() 
	return You 
end



function script.QueryWeapon6() 
	EaterflipFlop=(EaterflipFlop+1)%(math.max(1,Weapons[eEater][1]))
	if EaterflipFlop==0 then return Eater[1] end
	if EaterflipFlop==1 then return Eater[2] end
	if EaterflipFlop==2 then return Eater[3] end
end

function script.AimWeapon6( heading ,pitch)	
	
	if Weapons[eEater][1] > 0 and boolEaterLoaded== true and gotPriority(Weapons[eEater][7])==true then 
		Spring.Echo("JW_COMENDERSCRIPT::Weapon6 got priority")
		SalvoMax=Weapons[eEater][1]
		Turn(Eater[1],x_axis,math.rad(-59),24)
		WaitForTurn(Eater[1],x_axis)
		
		return boolOutOfAmmo ==false
	end
	
	--/spinlock
	return false 	
end

function reloadWeapon6()
	Turn(Eater[1],x_axis,math.rad(0),7)
	Sleep(Weapons[eEater][8])
	FiredSalvos=0
	SalvoMax=Weapons[eEater][1]
	boolEaterLoaded=true
end

function script.FireWeapon6()	
	FiredSalvos=FiredSalvos+1
	fireWeaponCost(eEater)
	
	if FiredSalvos==SalvoMax then
		releasePriority(Weapons[eEater][7]) 
		boolEaterLoaded=false
	end
	
	return true
end

--</Eater>
--<SHOTGUN>
--DODO
function script.AimFromWeapon7() 
	return You
end


function script.QueryWeapon7() 
	return MagneticSh
end

function script.AimWeapon7( heading ,pitch)	
	
	if Weapons[eShotGun][1]>0 and Weapons[eShotGun][10] > 0 and gotPriority(Weapons[eShotGun][7])==true then
		releasePriority(Weapons[eShotGun][7])
		return true
	else
		return false
	end
end
function reloadWeapon7()
	
end

function script.FireWeapon7()	
	fireWeaponCost(eShotGun)
	Weapons[eShotGun][10]=0
	Hide(bullets)
	return true
end

-- script.BlockShot8= function BlockShot8()
-- return
-- end
--<Weapon Workaround tractor beam>
function script.AimFromWeapon8() 
	return You 
end

function script.QueryWeapon8() 
	
end

function script.AimWeapon8( heading ,pitch)	
	
	
	return GG.NotifyBlockShot(unitID, 8) 
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
		Weapons[eFlareGun][5]=Weapons[eFlareGun][6]
	end
	boolFlareGunReloadInProgress=false
end

-- Weapons[eFlareGun][1]=0 				--	WeaponLevel 
-- Weapons[eFlareGun][2]=3					-- WeaponMax 
-- Weapons[eFlareGun][5]= 3					-- CurrentAmmo 
-- Weapons[eFlareGun][6]= 3					-- CurrentMaxAmmo 
-- Weapons[eFlareGun][7]= 5					-- Priority
function script.AimWeapon9( heading ,pitch)	
	if Weapons[eFlareGun][1] > 0 and gotPriority(Weapons[eFlareGun][7])==true then 
		if Weapons[eFlareGun][5] <= 0 then 
			return false
		end
		return boolOutOfAmmo ==false
	end
	
	return false
end

function script.FireWeapon9()	
	fireWeaponCost(eFlareGun)
	releasePriority(Weapons[eFlareGun][7])
	Spring.PlaySoundFile("sounds/cComEnder/flare.wav",1.0)
	if Weapons[eFlareGun][5] <= 0 then 
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
	return Weapons[eSlicer][eAimPiece]
end

boolSliceGunReloadInProgress=false
function reloadSliceGun()
	if boolSliceGunReloadInProgress==true then return end
	if boolSliceGunReloadInProgress==false then boolSliceGunReloadInProgress=true end
	Weapons[eSlicer][eCurrCool]=math.abs( Weapons[eSlicer][eCoolDown]/Weapons[eSlicer][eWeapnLvl])
	
	Sleep(Weapons[eSlicer][eCurrCool])
	Weapons[eSlicer][eCurrCool]= 0
	boolSliceGunReloadInProgress=false
end

function script.AimWeapon10( heading ,pitch)	
	echo("CComEnderScript::10:1")
	
	if Weapons[eSlicer][eCurrCool] > 0 then 
		echo("CComEnderScript::10:2")	
		return false
	end
	echo("CComEnderScript::10:3")
	if Weapons[eSlicer][1] > 0 and gotPriority(Weapons[eSlicer][ePrioLevl]) == true then 		
		echo("CComEnderScript::10:4")
		releasePriority(Weapons[eSlicer][7])
		return boolOutOfAmmo == false
	end	
	return false
end

function sliceGunSFX()
	EmitSfx( Weapons[eSlicer][3],1028)
	Sleep(1300)
	EmitSfx(Weapons[eSlicer][3],1029 )
end

function script.FireWeapon10()	
	fireWeaponCost(eSlicer)
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
	return Weapons[eSlicer][3]
end


function script.AimWeapon11( heading ,pitch)	
	if Weapons[eRazorGrenade][eWeapnLvl] > 0 and gotPriority(Weapons[eRazorGrenade][7])==true then 
		return boolOutOfAmmo ==false
	end	
	return false	
end

function script.FireWeapon11()	
	fireWeaponCost(eRazorGrenade)
	return true
end

--</RazorGrenade>
--<TangleGun>
function script.AimFromWeapon12() 
	return You 
end

function script.QueryWeapon12() 
	return Weapons[eTangleGun][eAimPiece]
end

function reloadTangleGun()
	Weapons[eTangleGun][eCurrCool]=Weapons[eTangleGun][eCoolDown]
	StopSpin(TangleRota,y_axis)
	StopSpin(TangleRota,x_axis)
	fireWeaponCost(eTangleGun)
	WTurn(TangleGun,y_axis,math.rad(-15), 5)
	WTurn(TangleGun,y_axis,math.rad(15), 5)
	WTurn(TangleGun,y_axis,math.rad(0), 5)

	Sleep(Weapons[eTangleGun][eCurrCool])
	Spin(TangleRota,y_axis,math.rad(-512),0.5)
	Spin(TangleRota,x_axis,math.rad(-12),0.5)
	Weapons[eTangleGun][eCurrCool] = 0
end

function script.AimWeapon12( heading ,pitch)	
	if Weapons[eTangleGun][eWeapnLvl] > 0 then
		diff= math.abs(65533 +globalHipTurn)-math.abs(65533+heading)
		diff= (diff % 65533)
		WTurn(TangleGun,y_axis, diff, 5)
		
		return Weapons[eTangleGun][eCurrCool] <= 0 and boolOutOfAmmo == false
	else
		return false
	end
end

TangleCounter=0
function script.FireWeapon12()	
	EmitSfx(TangleGun,2031)
	EmitSfx(TangleGun,2031)
	EmitSfx(TangleGun,2031)
	StopSpin(TangleRota,y_axis,0.5)
	StopSpin(TangleRota,x_axis,0.5)
	
	TangleCounter= 	TangleCounter+1
		
	if TangleCounter > 3* Weapons[eTangleGun][1] then --tangling ended
		Weapons[eTangleGun][eCurrCool] = Weapons[eTangleGun][eCoolDown]
		
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
	return Weapons[eAARocket][3]
end

boolAARocketLoaded=true
function reloadAARockets()
	Weapons[eAARocket][eCurrCool]=Weapons[eAARocket][eCoolDown]
	Sleep(	Weapons[eAARocket][eCurrCool]) 
	Weapons[eAARocket][eCurrCool]=0
end

function script.AimWeapon13( heading ,pitch)	
	if Weapons[eAARocket][eWeapnLvl] <= 0 then return false end
	
	return 	Weapons[eAARocket][eCurrCool] <= 0 and boolOutOfAmmo == false
end


function script.FireWeapon13()	
	fireWeaponCost(eTangleGun)
	StartThread(reloadAARockets)	
	return true
end

--</AAROCKET>
--<GROCKET>

function script.AimFromWeapon14() 
	return You 
end



function script.QueryWeapon14() 
	return Weapons[eGRocket][3]
end


function reloadGRockets()
	Weapons[eGRocket][eCurrCool]=Weapons[eGRocket][eCoolDown]
	
	Sleep(	Weapons[eGRocket][eCurrCool]) 
	Weapons[eGRocket][eCurrCool]=0
end

function script.AimWeapon14( heading ,pitch)	
	if Weapons[eGRocket][eWeapnLvl] <= 0 then return false end
	return Weapons[eGRocket][eCurrCool] <= 0 and boolOutOfAmmo == false
end

TangleCounter=0
function script.FireWeapon14()	
	fireWeaponCost(eGRocket)
	
	StartThread(reloadGRockets)
	
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