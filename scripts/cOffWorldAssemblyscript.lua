include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"

include "lib_Build.lua"
myDefID =Spring.GetUnitDefID(unitID)
--PIECES
pieceTable_ = {}
bodyBag = piece("bodyBag")
pieceTable_[#pieceTable_ + 1] = bodyBag
emptyCapsule = piece("emptyCapsu")
pieceTable_[#pieceTable_ + 1] = emptyCapsule
fluidsack = piece("fluidsack")
pieceTable_[#pieceTable_ + 1] = fluidsack
buildSpot = piece("buildSpot")
pieceTable_[#pieceTable_ + 1] = buildSpot

center = piece("center")
pieceTable_[#pieceTable_ + 1] = center
AU2 = piece("AU2")
pieceTable_[#pieceTable_ + 1] = AU2
AU1 = piece("AU1")
pieceTable_[#pieceTable_ + 1] = AU1
Attrap1 = piece("Attrap1")
pieceTable_[#pieceTable_ + 1] = Attrap1
Window027 = piece("Window027")
pieceTable_[#pieceTable_ + 1] = Window027
Window028 = piece("Window028")
pieceTable_[#pieceTable_ + 1] = Window028
Window037 = piece("Window037")
pieceTable_[#pieceTable_ + 1] = Window037
Window038 = piece("Window038")
pieceTable_[#pieceTable_ + 1] = Window038
Window029 = piece("Window029")
pieceTable_[#pieceTable_ + 1] = Window029
Window030 = piece("Window030")
pieceTable_[#pieceTable_ + 1] = Window030
AU4 = piece("AU4")
pieceTable_[#pieceTable_ + 1] = AU4
AU5 = piece("AU5")
pieceTable_[#pieceTable_ + 1] = AU5
Attrap2 = piece("Attrap2")
pieceTable_[#pieceTable_ + 1] = Attrap2
Attrap3 = piece("Attrap3")
pieceTable_[#pieceTable_ + 1] = Attrap3
AU6 = piece("AU6")
pieceTable_[#pieceTable_ + 1] = AU6
AU7 = piece("AU7")
pieceTable_[#pieceTable_ + 1] = AU7
Attrap4 = piece("Attrap4")
pieceTable_[#pieceTable_ + 1] = Attrap4
Window045 = piece("Window045")
pieceTable_[#pieceTable_ + 1] = Window045
Window046 = piece("Window046")
pieceTable_[#pieceTable_ + 1] = Window046
Window047 = piece("Window047")
pieceTable_[#pieceTable_ + 1] = Window047
Window048 = piece("Window048")
pieceTable_[#pieceTable_ + 1] = Window048
Window049 = piece("Window049")
pieceTable_[#pieceTable_ + 1] = Window049
Window050 = piece("Window050")
pieceTable_[#pieceTable_ + 1] = Window050
Window051 = piece("Window051")
pieceTable_[#pieceTable_ + 1] = Window051
Window052 = piece("Window052")
pieceTable_[#pieceTable_ + 1] = Window052
AU8 = piece("AU8")
pieceTable_[#pieceTable_ + 1] = AU8
AU9 = piece("AU9")
pieceTable_[#pieceTable_ + 1] = AU9
Attrap5 = piece("Attrap5")
pieceTable_[#pieceTable_ + 1] = Attrap5
Window061 = piece("Window061")
pieceTable_[#pieceTable_ + 1] = Window061
Window062 = piece("Window062")
pieceTable_[#pieceTable_ + 1] = Window062
Window063 = piece("Window063")
pieceTable_[#pieceTable_ + 1] = Window063
Window064 = piece("Window064")
pieceTable_[#pieceTable_ + 1] = Window064
AU10 = piece("AU10")
pieceTable_[#pieceTable_ + 1] = AU10
AU11 = piece("AU11")
pieceTable_[#pieceTable_ + 1] = AU11
Attrap6 = piece("Attrap6")
pieceTable_[#pieceTable_ + 1] = Attrap6
Base = piece("Base")
pieceTable_[#pieceTable_ + 1] = Base
Crate3 = piece("Crate3")
pieceTable_[#pieceTable_ + 1] = Crate3
Crate2 = piece("Crate2")
pieceTable_[#pieceTable_ + 1] = Crate2
Crate1Open = piece("Crate1Open")
pieceTable_[#pieceTable_ + 1] = Crate1Open
Crate1 = piece("Crate1")
pieceTable_[#pieceTable_ + 1] = Crate1
Pump1 = piece("Pump1")
pieceTable_[#pieceTable_ + 1] = Pump1
Pump2 = piece("Pump2")
pieceTable_[#pieceTable_ + 1] = Pump2
Implant1 = piece("Implant1")
pieceTable_[#pieceTable_ + 1] = Implant1
Implant2 = piece("Implant2")
pieceTable_[#pieceTable_ + 1] = Implant2
Implant3 = piece("Implant3")
pieceTable_[#pieceTable_ + 1] = Implant3
Implant4 = piece("Implant4")
pieceTable_[#pieceTable_ + 1] = Implant4
Implant5 = piece("Implant5")
pieceTable_[#pieceTable_ + 1] = Implant5
PumpPillar1 = piece("PumpPillar1")
pieceTable_[#pieceTable_ + 1] = PumpPillar1
ader1 = piece("ader1")
pieceTable_[#pieceTable_ + 1] = ader1
pump1 = piece("pump1")
pieceTable_[#pieceTable_ + 1] = pump1
spinp1 = piece("spinp1")
pieceTable_[#pieceTable_ + 1] = spinp1
ader2 = piece("ader2")
pieceTable_[#pieceTable_ + 1] = ader2
ader3 = piece("ader3")
pieceTable_[#pieceTable_ + 1] = ader3
PumpPillar2 = piece("PumpPillar2")
pieceTable_[#pieceTable_ + 1] = PumpPillar2
ader4 = piece("ader4")
pieceTable_[#pieceTable_ + 1] = ader4
pump2 = piece("pump2")
pieceTable_[#pieceTable_ + 1] = pump2
spinp2 = piece("spinp2")
pieceTable_[#pieceTable_ + 1] = spinp2
ader6 = piece("ader6")
pieceTable_[#pieceTable_ + 1] = ader6
ader7 = piece("ader7")
pieceTable_[#pieceTable_ + 1] = ader7
Carusell = piece("Carusell")
pieceTable_[#pieceTable_ + 1] = Carusell

OPFA001 = piece("OPFA001")
pieceTable_[#pieceTable_ + 1] = OPFA001
OPSA001 = piece("OPSA001")
pieceTable_[#pieceTable_ + 1] = OPSA001
OPTA001 = piece("OPTA001")
pieceTable_[#pieceTable_ + 1] = OPTA001
OPTU001 = piece("OPTU001")
pieceTable_[#pieceTable_ + 1] = OPTU001
OPVA001 = piece("OPVA001")
pieceTable_[#pieceTable_ + 1] = OPVA001
Op1 = piece("Op1")
pieceTable_[#pieceTable_ + 1] = Op1
OPFA002 = piece("OPFA002")
pieceTable_[#pieceTable_ + 1] = OPFA002
OPSA002 = piece("OPSA002")
pieceTable_[#pieceTable_ + 1] = OPSA002
OPTA002 = piece("OPTA002")
pieceTable_[#pieceTable_ + 1] = OPTA002
OPTU002 = piece("OPTU002")
pieceTable_[#pieceTable_ + 1] = OPTU002
OPVA002 = piece("OPVA002")
pieceTable_[#pieceTable_ + 1] = OPVA002
Op2 = piece("Op2")
pieceTable_[#pieceTable_ + 1] = Op2
OPFA003 = piece("OPFA003")
pieceTable_[#pieceTable_ + 1] = OPFA003
OPSA003 = piece("OPSA003")
pieceTable_[#pieceTable_ + 1] = OPSA003
OPTA003 = piece("OPTA003")
pieceTable_[#pieceTable_ + 1] = OPTA003
OPTU003 = piece("OPTU003")
pieceTable_[#pieceTable_ + 1] = OPTU003
OPVA003 = piece("OPVA003")
pieceTable_[#pieceTable_ + 1] = OPVA003
Op3 = piece("Op3")
pieceTable_[#pieceTable_ + 1] = Op3
OPFA005 = piece("OPFA005")
pieceTable_[#pieceTable_ + 1] = OPFA005
OPSA005 = piece("OPSA005")
pieceTable_[#pieceTable_ + 1] = OPSA005
OPTA005 = piece("OPTA005")
pieceTable_[#pieceTable_ + 1] = OPTA005
OPTU005 = piece("OPTU005")
pieceTable_[#pieceTable_ + 1] = OPTU005
OPVA005 = piece("OPVA005")
pieceTable_[#pieceTable_ + 1] = OPVA005
Op5 = piece("Op5")
pieceTable_[#pieceTable_ + 1] = Op5
OPFA006 = piece("OPFA006")
pieceTable_[#pieceTable_ + 1] = OPFA006
OPSA006 = piece("OPSA006")
pieceTable_[#pieceTable_ + 1] = OPSA006
OPTA006 = piece("OPTA006")
pieceTable_[#pieceTable_ + 1] = OPTA006
OPTU006 = piece("OPTU006")
pieceTable_[#pieceTable_ + 1] = OPTU006
OPVA006 = piece("OPVA006")
pieceTable_[#pieceTable_ + 1] = OPVA006
Op6 = piece("Op6")
pieceTable_[#pieceTable_ + 1] = Op6
OPFA007 = piece("OPFA007")
pieceTable_[#pieceTable_ + 1] = OPFA007
OPSA007 = piece("OPSA007")
pieceTable_[#pieceTable_ + 1] = OPSA007
OPTA007 = piece("OPTA007")
pieceTable_[#pieceTable_ + 1] = OPTA007
OPTU007 = piece("OPTU007")
pieceTable_[#pieceTable_ + 1] = OPTU007
OPVA007 = piece("OPVA007")
pieceTable_[#pieceTable_ + 1] = OPVA007
Op7 = piece("Op7")
pieceTable_[#pieceTable_ + 1] = Op7
OPFA008 = piece("OPFA008")
pieceTable_[#pieceTable_ + 1] = OPFA008
OPSA008 = piece("OPSA008")
pieceTable_[#pieceTable_ + 1] = OPSA008
OPTA008 = piece("OPTA008")
pieceTable_[#pieceTable_ + 1] = OPTA008
OPTU008 = piece("OPTU008")
pieceTable_[#pieceTable_ + 1] = OPTU008
OPVA008 = piece("OPVA008")
pieceTable_[#pieceTable_ + 1] = OPVA008
Op8 = piece("Op8")
pieceTable_[#pieceTable_ + 1] = Op8
GrowCapsule = piece("GrowCapsule")
pieceTable_[#pieceTable_ + 1] = GrowCapsule
centerpipes = piece("centerpipes")
pieceTable_[#pieceTable_ + 1] = centerpipes
BloodCapsule = piece("BloodCapsule")
pieceTable_[#pieceTable_ + 1] = BloodCapsule
StompBase4 = piece("StompBase4")
pieceTable_[#pieceTable_ + 1] = StompBase4
Stomp4 = piece("Stomp4")
pieceTable_[#pieceTable_ + 1] = Stomp4
ToolLow3 = piece("ToolLow3")
pieceTable_[#pieceTable_ + 1] = ToolLow3
ToolMid3 = piece("ToolMid3")
pieceTable_[#pieceTable_ + 1] = ToolMid3
ToolUp3 = piece("ToolUp3")
pieceTable_[#pieceTable_ + 1] = ToolUp3
StompBase3 = piece("StompBase3")
pieceTable_[#pieceTable_ + 1] = StompBase3
Stomp3 = piece("Stomp3")
pieceTable_[#pieceTable_ + 1] = Stomp3
StompBase2 = piece("StompBase2")
pieceTable_[#pieceTable_ + 1] = StompBase2
Stomp2 = piece("Stomp2")
pieceTable_[#pieceTable_ + 1] = Stomp2
StompBase1 = piece("StompBase1")
pieceTable_[#pieceTable_ + 1] = StompBase1
Stomp1 = piece("Stomp1")
pieceTable_[#pieceTable_ + 1] = Stomp1
ToolLow1 = piece("ToolLow1")
pieceTable_[#pieceTable_ + 1] = ToolLow1
ToolMid1 = piece("ToolMid1")
pieceTable_[#pieceTable_ + 1] = ToolMid1
ToolUp1 = piece("ToolUp1")
pieceTable_[#pieceTable_ + 1] = ToolUp1
Crate4 = piece("Crate4")
pieceTable_[#pieceTable_ + 1] = Crate4
Crationism1 = piece("Crationism1")
pieceTable_[#pieceTable_ + 1] = Crationism1
Dest2 = piece("Dest2")
pieceTable_[#pieceTable_ + 1] = Dest2
Dest1 = piece("Dest1")
pieceTable_[#pieceTable_ + 1] = Dest1
Dest3 = piece("Dest3")
pieceTable_[#pieceTable_ + 1] = Dest3

Crationism2 = piece("Crationism2")
pieceTable_[#pieceTable_ + 1] = Crationism2
Crationism3 = piece("Crationism3")
pieceTable_[#pieceTable_ + 1] = Crationism3
Crationism4 = piece("Crationism4")
pieceTable_[#pieceTable_ + 1] = Crationism4
OPFA004 = piece("OPFA004")
pieceTable_[#pieceTable_ + 1] = OPFA004
OPSA004 = piece("OPSA004")
pieceTable_[#pieceTable_ + 1] = OPSA004
OPTA004 = piece("OPTA004")
pieceTable_[#pieceTable_ + 1] = OPTA004
OPTU04 = piece("OPTU004")
pieceTable_[#pieceTable_ + 1] = OPTU04
OPVA004 = piece("OPVA004")
pieceTable_[#pieceTable_ + 1] = OPVA004
Op4 = piece("Op4")
pieceTable_[#pieceTable_ + 1] = Op4
OPFA018 = piece("OPFA018")
pieceTable_[#pieceTable_ + 1] = OPFA018
OPSA018 = piece("OPSA018")
pieceTable_[#pieceTable_ + 1] = OPSA018
OPTA018 = piece("OPTA018")
pieceTable_[#pieceTable_ + 1] = OPTA018
OPTU018 = piece("OPTU018")
pieceTable_[#pieceTable_ + 1] = OPTU018
OPVA018 = piece("OPVA018")
pieceTable_[#pieceTable_ + 1] = OPVA018
Op18 = piece("Op18")
pieceTable_[#pieceTable_ + 1] = Op18
ToolLow4 = piece("ToolLow4")
pieceTable_[#pieceTable_ + 1] = ToolLow4
ToolMid4 = piece("ToolMid4")
pieceTable_[#pieceTable_ + 1] = ToolMid4
ToolUp4 = piece("ToolUp4")
pieceTable_[#pieceTable_ + 1] = ToolUp4
OPFA009 = piece("OPFA009")
pieceTable_[#pieceTable_ + 1] = OPFA009
OPSA009 = piece("OPSA009")
pieceTable_[#pieceTable_ + 1] = OPSA009
OPTA009 = piece("OPTA009")
pieceTable_[#pieceTable_ + 1] = OPTA009
OPTU009 = piece("OPTU009")
pieceTable_[#pieceTable_ + 1] = OPTU009
OPVA009 = piece("OPVA009")
pieceTable_[#pieceTable_ + 1] = OPVA009
Op9 = piece("Op9")
pieceTable_[#pieceTable_ + 1] = Op9
ToolLow2 = piece("ToolLow2")
pieceTable_[#pieceTable_ + 1] = ToolLow2
ToolMid2 = piece("ToolMid2")
pieceTable_[#pieceTable_ + 1] = ToolMid2
ToolUp2 = piece("ToolUp2")
pieceTable_[#pieceTable_ + 1] = ToolUp2
OPFA019 = piece("OPFA019")
pieceTable_[#pieceTable_ + 1] = OPFA019
OPSA019 = piece("OPSA019")
pieceTable_[#pieceTable_ + 1] = OPSA019
OPTA019 = piece("OPTA019")
pieceTable_[#pieceTable_ + 1] = OPTA019
OPTU019 = piece("OPTU019")
pieceTable_[#pieceTable_ + 1] = OPTU019
OPVA019 = piece("OPVA019")
pieceTable_[#pieceTable_ + 1] = OPVA019
Op19 = piece("Op19")
pieceTable_[#pieceTable_ + 1] = Op19
OPFA010 = piece("OPFA010")
pieceTable_[#pieceTable_ + 1] = OPFA010
OPSA010 = piece("OPSA010")
pieceTable_[#pieceTable_ + 1] = OPSA010
OPTA019 = piece("OPTA019")
pieceTable_[#pieceTable_ + 1] = OPTA019
OPTA018 = piece("OPTA018")
pieceTable_[#pieceTable_ + 1] = OPTA018
OPVA010 = piece("OPVA010")
pieceTable_[#pieceTable_ + 1] = OPVA010
Op10 = piece("Op10")
pieceTable_[#pieceTable_ + 1] = Op10
OPFA011 = piece("OPFA011")
pieceTable_[#pieceTable_ + 1] = OPFA011
OPSA011 = piece("OPSA011")
pieceTable_[#pieceTable_ + 1] = OPSA011
OPTA011 = piece("OPTA011")
pieceTable_[#pieceTable_ + 1] = OPTA011
OPTU011 = piece("OPTU011")
pieceTable_[#pieceTable_ + 1] = OPTU011
OPVA011 = piece("OPVA011")
pieceTable_[#pieceTable_ + 1] = OPVA011
Op11 = piece("Op11")
pieceTable_[#pieceTable_ + 1] = Op11
OPFA012 = piece("OPFA012")
pieceTable_[#pieceTable_ + 1] = OPFA012
OPSA012 = piece("OPSA012")
pieceTable_[#pieceTable_ + 1] = OPSA012
OPTA012 = piece("OPTA012")
pieceTable_[#pieceTable_ + 1] = OPTA012
OPTU012 = piece("OPTU012")
pieceTable_[#pieceTable_ + 1] = OPTU012
OPVA012 = piece("OPVA012")
pieceTable_[#pieceTable_ + 1] = OPVA012
Op12 = piece("Op12")
pieceTable_[#pieceTable_ + 1] = Op12
OPFA013 = piece("OPFA013")
pieceTable_[#pieceTable_ + 1] = OPFA013
OPSA013 = piece("OPSA013")
pieceTable_[#pieceTable_ + 1] = OPSA013
OPTA013 = piece("OPTA013")
pieceTable_[#pieceTable_ + 1] = OPTA013
OPTU013 = piece("OPTU013")
pieceTable_[#pieceTable_ + 1] = OPTU013
OPVA013 = piece("OPVA013")
pieceTable_[#pieceTable_ + 1] = OPVA013
Op13 = piece("Op13")
pieceTable_[#pieceTable_ + 1] = Op13
OPFA014 = piece("OPFA014")
pieceTable_[#pieceTable_ + 1] = OPFA014
OPSA014 = piece("OPSA014")
pieceTable_[#pieceTable_ + 1] = OPSA014
OPTA014 = piece("OPTA014")
pieceTable_[#pieceTable_ + 1] = OPTA014
OPTU014 = piece("OPTU014")
pieceTable_[#pieceTable_ + 1] = OPTU014
OPVA014 = piece("OPVA014")
pieceTable_[#pieceTable_ + 1] = OPVA014
Op14 = piece("Op14")
pieceTable_[#pieceTable_ + 1] = Op14
OPFA015 = piece("OPFA015")
pieceTable_[#pieceTable_ + 1] = OPFA015
OPSA015 = piece("OPSA015")
pieceTable_[#pieceTable_ + 1] = OPSA015
OPTA015 = piece("OPTA015")
pieceTable_[#pieceTable_ + 1] = OPTA015
OPTU015 = piece("OPTU015")
pieceTable_[#pieceTable_ + 1] = OPTU015
OPVA015 = piece("OPVA015")
pieceTable_[#pieceTable_ + 1] = OPVA015
Op15 = piece("Op15")
pieceTable_[#pieceTable_ + 1] = Op15
OPFA016 = piece("OPFA016")
pieceTable_[#pieceTable_ + 1] = OPFA016
OPSA016 = piece("OPSA016")
pieceTable_[#pieceTable_ + 1] = OPSA016
OPTA016 = piece("OPTA016")
pieceTable_[#pieceTable_ + 1] = OPTA016
OPTU016 = piece("OPTU016")
pieceTable_[#pieceTable_ + 1] = OPTU016
OPVA016 = piece("OPVA016")
pieceTable_[#pieceTable_ + 1] = OPVA016
Op16 = piece("Op16")
pieceTable_[#pieceTable_ + 1] = Op16
OPFA017 = piece("OPFA017")
pieceTable_[#pieceTable_ + 1] = OPFA017
OPSA017 = piece("OPSA017")
pieceTable_[#pieceTable_ + 1] = OPSA017
OPTA017 = piece("OPTA017")
pieceTable_[#pieceTable_ + 1] = OPTA017
OPTU017 = piece("OPTU017")
pieceTable_[#pieceTable_ + 1] = OPTU017
OPVA017 = piece("OPVA017")
pieceTable_[#pieceTable_ + 1] = OPVA017
Op17 = piece("Op17")
pieceTable_[#pieceTable_ + 1] = Op17
Sack = piece("Sack")
pieceTable_[#pieceTable_ + 1] = Sack
SackWIP = piece("SackWIP")
pieceTable_[#pieceTable_ + 1] = SackWIP
Stack01 = piece("Stack01")
pieceTable_[#pieceTable_ + 1] = Stack01
Window001 = piece("Window001")
pieceTable_[#pieceTable_ + 1] = Window001
Window002 = piece("Window002")
pieceTable_[#pieceTable_ + 1] = Window002
Window003 = piece("Window003")
pieceTable_[#pieceTable_ + 1] = Window003
Window004 = piece("Window004")
pieceTable_[#pieceTable_ + 1] = Window004
Window005 = piece("Window005")
pieceTable_[#pieceTable_ + 1] = Window005
Window006 = piece("Window006")
pieceTable_[#pieceTable_ + 1] = Window006
Window007 = piece("Window007")
pieceTable_[#pieceTable_ + 1] = Window007
Window008 = piece("Window008")
pieceTable_[#pieceTable_ + 1] = Window008
Window009 = piece("Window009")
pieceTable_[#pieceTable_ + 1] = Window009
Window010 = piece("Window010")
pieceTable_[#pieceTable_ + 1] = Window010
Window011 = piece("Window011")
pieceTable_[#pieceTable_ + 1] = Window011
Window012 = piece("Window012")
pieceTable_[#pieceTable_ + 1] = Window012
Window013 = piece("Window013")
pieceTable_[#pieceTable_ + 1] = Window013
Window014 = piece("Window014")
pieceTable_[#pieceTable_ + 1] = Window014
Window015 = piece("Window015")
pieceTable_[#pieceTable_ + 1] = Window015
Window016 = piece("Window016")
pieceTable_[#pieceTable_ + 1] = Window016
Window017 = piece("Window017")
pieceTable_[#pieceTable_ + 1] = Window017
Window018 = piece("Window018")
pieceTable_[#pieceTable_ + 1] = Window018
Window019 = piece("Window019")
pieceTable_[#pieceTable_ + 1] = Window019
Window020 = piece("Window020")
pieceTable_[#pieceTable_ + 1] = Window020
Window021 = piece("Window021")
pieceTable_[#pieceTable_ + 1] = Window021
Window022 = piece("Window022")
pieceTable_[#pieceTable_ + 1] = Window022
Window023 = piece("Window023")
pieceTable_[#pieceTable_ + 1] = Window023
Window024 = piece("Window024")
pieceTable_[#pieceTable_ + 1] = Window024
Window025 = piece("Window025")
pieceTable_[#pieceTable_ + 1] = Window025
Window026 = piece("Window026")
pieceTable_[#pieceTable_ + 1] = Window026
Window031 = piece("Window031")
pieceTable_[#pieceTable_ + 1] = Window031
Window032 = piece("Window032")
pieceTable_[#pieceTable_ + 1] = Window032
Window033 = piece("Window033")
pieceTable_[#pieceTable_ + 1] = Window033
Window034 = piece("Window034")
pieceTable_[#pieceTable_ + 1] = Window034
Window035 = piece("Window035")
pieceTable_[#pieceTable_ + 1] = Window035
Window036 = piece("Window036")
pieceTable_[#pieceTable_ + 1] = Window036
Window039 = piece("Window039")
pieceTable_[#pieceTable_ + 1] = Window039
Window040 = piece("Window040")
pieceTable_[#pieceTable_ + 1] = Window040
Window041 = piece("Window041")
pieceTable_[#pieceTable_ + 1] = Window041
Window042 = piece("Window042")
pieceTable_[#pieceTable_ + 1] = Window042
Window043 = piece("Window043")
pieceTable_[#pieceTable_ + 1] = Window043
Window044 = piece("Window044")
pieceTable_[#pieceTable_ + 1] = Window044
Window053 = piece("Window053")
pieceTable_[#pieceTable_ + 1] = Window053
Window054 = piece("Window054")
pieceTable_[#pieceTable_ + 1] = Window054
Window055 = piece("Window055")
pieceTable_[#pieceTable_ + 1] = Window055
Window056 = piece("Window056")
pieceTable_[#pieceTable_ + 1] = Window056
Window057 = piece("Window057")
pieceTable_[#pieceTable_ + 1] = Window057
Window058 = piece("Window058")
pieceTable_[#pieceTable_ + 1] = Window058
Window059 = piece("Window059")
pieceTable_[#pieceTable_ + 1] = Window059
Window060 = piece("Window060")
pieceTable_[#pieceTable_ + 1] = Window060
Window065 = piece("Window065")
pieceTable_[#pieceTable_ + 1] = Window065
Window066 = piece("Window066")
pieceTable_[#pieceTable_ + 1] = Window066
Window067 = piece("Window067")
pieceTable_[#pieceTable_ + 1] = Window067
Window068 = piece("Window068")
pieceTable_[#pieceTable_ + 1] = Window068
Window069 = piece("Window069")
pieceTable_[#pieceTable_ + 1] = Window069
Window070 = piece("Window070")
pieceTable_[#pieceTable_ + 1] = Window070
Window071 = piece("Window071")
pieceTable_[#pieceTable_ + 1] = Window071
Window072 = piece("Window072")
pieceTable_[#pieceTable_ + 1] = Window072
Window073 = piece("Window073")
pieceTable_[#pieceTable_ + 1] = Window073
Window074 = piece("Window074")
pieceTable_[#pieceTable_ + 1] = Window074
Window075 = piece("Window075")
pieceTable_[#pieceTable_ + 1] = Window075
Window076 = piece("Window076")
pieceTable_[#pieceTable_ + 1] = Window076
Window077 = piece("Window077")
pieceTable_[#pieceTable_ + 1] = Window077
Window078 = piece("Window078")
pieceTable_[#pieceTable_ + 1] = Window078
Window079 = piece("Window079")
pieceTable_[#pieceTable_ + 1] = Window079
Window080 = piece("Window080")
pieceTable_[#pieceTable_ + 1] = Window080
Window081 = piece("Window081")
pieceTable_[#pieceTable_ + 1] = Window081
Window082 = piece("Window082")
pieceTable_[#pieceTable_ + 1] = Window082
Window083 = piece("Window083")
pieceTable_[#pieceTable_ + 1] = Window083
Window084 = piece("Window084")
pieceTable_[#pieceTable_ + 1] = Window084
Window085 = piece("Window085")
pieceTable_[#pieceTable_ + 1] = Window085
Window086 = piece("Window086")
pieceTable_[#pieceTable_ + 1] = Window086
birthWater = piece("birthWater")
pieceTable_[#pieceTable_ + 1] = birthWater
bloodWater = piece("bloodWater")
pieceTable_[#pieceTable_ + 1] = bloodWater
ItKickedMe = piece("ItKickedMe")
pieceTable_[#pieceTable_ + 1] = ItKickedMe

GrowSpot = piece "GrowSpot"
pieceTable_[#pieceTable_ + 1] = GrowSpot
Meat = piece "Meat"
TablesOfPiecesGroups = {}
StompTable = {}
StompBaseTable = {}
WindowTable = {}

refUnitScript = Spring.UnitScript

TotalDistanceDown = -60
OrgSignal = 0
function getUniqueSignal()
    OrgSignal = OrgSignal + 1
    return OrgSignal
end

function script.HitByWeapon(x, z, weaponDefID, damage)

    return damage
end

function stompBases()
    while true do
        for i = 1, #StompBaseTable do
            Move(StompBaseTable[i], y_axis, -5, 5)
            Move(StompTable[i], y_axis, 20, 5)
        end
        WaitForMove(StompBaseTable[1], y_axis)
        WaitForMove(StompTable[1], y_axis)
        for i = 1, #StompBaseTable do
            Move(StompBaseTable[i], y_axis, 9, 5)
            Move(StompTable[i], y_axis, 0, 5)
        end
        WaitForMove(StompBaseTable[1], y_axis)

        Sleep(250)
    end
end

OperationSet = {}
ArmsTable = {}
opTable = {}

function script.Create()
		echo("StartCreate offwordlassmbly")
	Hide(bodyBag)
    Hide(emptyCapsule)
    Hide(fluidsack)
    Hide(Meat)
    Hide(Crate1)
    Hide(Crate1Open)
    Hide(ItKickedMe)

    resetT(pieceTable_)

    TablesOfPiecesGroups = getPieceTableByNameGroups(false, true)
    WindowTable = TablesOfPiecesGroups["Window"]
	  local transferTable= {}
	 for k,v in pairs( TablesOfPiecesGroups["Op"]) do
		transferTable[#transferTable+1] = v
	 end
    Spring.SetUnitNanoPieces(unitID, transferTable)

    StompBaseTable = TablesOfPiecesGroups["StompBase"]
    StompTable = TablesOfPiecesGroups["Stomp"]

    OP_T = TablesOfPiecesGroups["Op"]
    table.remove(OP_T, Op18)
    table.remove(OP_T, Op4)
    OPTA_T = TablesOfPiecesGroups["OPTA"]


    OPFA_T = TablesOfPiecesGroups["OPFA"]
    OPVA_T = TablesOfPiecesGroups["OPVA"]

    OPSA_T = TablesOfPiecesGroups["OPSA"]

    OPTU_T = TablesOfPiecesGroups["OPTU"]

    zeropad = "00"
	
    for i = 1, 19, 1 do

        if i == 10 then zeropad = "0" end

        ArmsTable[i] = {}
        name = "OPFA" .. zeropad .. i
        ArmsTable[i][1] = piece(name)
        name = "OPSA" .. zeropad .. i
        ArmsTable[i][2] = piece(name)
        name = "OPTA" .. zeropad .. i
        ArmsTable[i][3] = piece(name)
        name = "OPTU" .. zeropad .. i
        ArmsTable[i][4] = piece(name)
        name = "OPVA" .. zeropad .. i
        ArmsTable[i][5] = piece(name)
        name = "Op" .. i
        ArmsTable[i][6] = piece(name)
        opTable[#opTable + 1] = ArmsTable[i][6]

        for k = 1, 6, 1 do
            if ArmsTable[i][k] == nil then
                echo("coffworldAssembly::piece missing Arm" .. i .. " / " .. k)
            end
        end
    end

    OperationSet = TableMergeTable(OP_T, OPTA_T)
    OperationSet = TableMergeTable(OperationSet, OPFA_T)
    OperationSet = TableMergeTable(OperationSet, OPSA_T)
    OperationSet = TableMergeTable(OperationSet, OPTU_T)
    OperationSet = TableMergeTable(OperationSet, OPVA_T)

    crateT = TablesOfPiecesGroups["Crate"]
    CrationismT = TablesOfPiecesGroups["Crationism"]
    AttrapT = TablesOfPiecesGroups["Attrap"]
    AUT = TablesOfPiecesGroups["AU"]


    hideT(OperationSet)


    ToolLowT = TablesOfPiecesGroups["ToolLow"]
    ToolUpT = TablesOfPiecesGroups["ToolUp"]
    ToolMidT = TablesOfPiecesGroups["ToolMid"]
    ImplanT = TablesOfPiecesGroups["Implant"]
    DesT = TablesOfPiecesGroups["Dest"]

    setUp()

    StartThread(buildOS)

	end

function hide(name, pece)
    if not pece then Spring.Echo(name .. " is not defined") end
    Hide(pece)
end

function setUp()

    Move(GrowSpot, y_axis, totalDistanceDown, 0)
    hide("centerpipes", centerpipes)
    Hide(bloodWater)
    Hide(birthWater)
    StartThread(stompBases)
    StartThread(randomBlink)
    StartThread(LoopBirthEggs)
    hide("Sack", Sack)
    hide("GrowCapsule", GrowCapsule)
    hide("BloodCapsule", BloodCapsule)
    hide("SackWIP", SackWIP)
    hide("EggPod", Op18)
    hide("EggPod", Op19)
    --hide Support Ader

    --hide EggPods
    hideT(OperationSet, "OperationSet")
    hide("Op18", Op18)
    hide("Op4", Op4)
    hideT(crateT, "crateT")
    hideT(CrationismT, "CrationismT")
    hideT(DesT, "DesT")
    hideT(ImplanT, "ImplanT")
	
    StartThread(fold, false, 0)
			
    for i = 1, 19, 1 do
        sign = -90

        if ArmsTable[i] and i ~= 18 and i ~= 4 then

            if i > 9 then sign = 90 end
            go = {
                ArmsTable[i][1], 0, 0, 0, 0,
                ArmsTable[i][2], 0, 0, 0, 0,
                ArmsTable[i][3], 0, 0, 0, 0,
                ArmsTable[i][4], 0, 0, sign, 0,
                ArmsTable[i][5], 0, 0, 0, 0,
                ArmsTable[i][6], 0, 0, 0, 0,
            }


            TurnPieceList(refUnitScript,
                go,
                false, --TurnInOrder
                false, -- WaitForTurn
                false )  --synced
        end
    end
end

SIG_BUILD = 8
SIG_FOLD =16
function BuildingAnimation(buildID)
    SetSignalMask(SIG_BUILD)
	 Signal(SIG_FOLD)
    Spring.SetUnitAlwaysVisible(buildID, false)

    --unfold
    fold(true, 1)

    eggDeploy(1.5)
    StartThread(LooppumpUp, getUniqueSignal())
    while (buildProgress < 0.25) do Sleep(10) end
    operate(buildID)
    fold(false, 1)
    while boolBuilding == true do Sleep(10) end
end

CrationismT = {}
crateT = {}
ImplanT = {}
DesT = {}
AttrapT = {}


soundTable={
{name= "roboMove1.ogg"  ,time_ =2000 },
{name= "roboMove2.ogg"  ,time_ =1000 },
{name= "roboMove3.ogg"  ,time_ =1000 },
{name= "skalpell.ogg"  ,time_ =1000 },
{name= "water.ogg"  ,time_ =8000 },
{name= "bonesaw.ogg"  ,time_ =1000 }
}

for i=1,6 do
soundTable[#soundTable+1] ={name= "pain"..i..".ogg"  ,time_ =3000 },
end
boolStillBuilding=false
function soundTrack()
	boolStillBuilding = true
	while boolStillBuilding== true do

	index= math.random(1,#soundTable)
	 StartThread(PlaySoundByUnitDefID, myDefID, "sounds/cOffworldAssembly/"..soundTable[index].name, math.random(5,10)/10, soundTable[index].time_, 1, 0)
	 

	Sleep(500)
	end


end


function foldAttrapp(boolDirection, speed)

    if boolDirection == true then --unfold
        Turn(AU6, x_axis, math.rad(44), speed)
        Turn(AU7, x_axis, math.rad(-103), speed)
        Turn(Attrap4, x_axis, math.rad(85), speed)

        Turn(AU10, z_axis, math.rad(47), speed)
        Turn(AU11, z_axis, math.rad(-98), speed)
        Turn(Attrap6, z_axis, math.rad(51), speed)

        Turn(AU8, z_axis, math.rad(-32), speed)
        Turn(AU9, z_axis, math.rad(97), speed)
        Turn(Attrap5, z_axis, math.rad(-67), speed)

        Turn(AU2, x_axis, math.rad(90), speed)
        Turn(AU1, x_axis, math.rad(179), speed)
        WTurn(Attrap1, x_axis, math.rad(92), speed / 2)


        Turn(AU4, z_axis, math.rad(42), speed)
        Turn(AU5, z_axis, math.rad(-222), speed)
        Turn(Attrap2, x_axis, math.rad(113), speed)
        WTurn(Attrap3, x_axis, math.rad(178), speed)



        Sleep(3000)
    else

        Turn(AU2, x_axis, math.rad(0), speed)
        Turn(AU1, x_axis, math.rad(0), speed)
        WTurn(Attrap1, x_axis, math.rad(0), speed)

        WTurn(AU4, z_axis, math.rad(0), speed)
        WTurn(AU5, z_axis, math.rad(0), speed)
        Turn(Attrap2, x_axis, math.rad(0), speed)
        Turn(Attrap3, x_axis, math.rad(0), speed)

        Turn(AU6, x_axis, math.rad(0), speed)
        Turn(AU7, x_axis, math.rad(0), speed)
        Turn(Attrap4, x_axis, math.rad(0), speed)

        Turn(AU10, z_axis, math.rad(0), speed)
        Turn(AU11, z_axis, math.rad(0), speed)
        Turn(Attrap6, z_axis, math.rad(0), speed)

        Turn(AU8, z_axis, math.rad(0), speed)
        Turn(AU9, z_axis, math.rad(0), speed)
        WTurn(Attrap5, z_axis, math.rad(0), speed)
    end
end


function fold(boolDirection, lspeed)
    speed = lspeed or math.max(1, buildProgress / 15)
	  SetSignalMask(SIG_FOLD)

    if boolDirection == true then --unfold
        foldAttrapp(boolDirection, speed)

        Turn(ToolUpT[1], x_axis, math.rad(-37), speed)
        Turn(ToolUpT[3], x_axis, math.rad(37 - 115), speed)
        WTurn(ToolLowT[3], x_axis, math.rad(0), speed)
        Turn(ToolUpT[1], x_axis, math.rad(0), speed)
        Turn(ToolUpT[3], x_axis, math.rad(0), speed)

        WTurn(ToolMidT[1], x_axis, math.rad(175), speed)
        Turn(ToolMidT[1], x_axis, math.rad(0), speed)
        WTurn(ToolMidT[3], x_axis, math.rad(0), speed)


        WTurn(ToolUpT[2], z_axis, math.rad(37), speed)
        WTurn(ToolUpT[4], z_axis, math.rad(-37), speed)


        WTurn(ToolMidT[2], z_axis, math.rad(175), speed)
        WTurn(ToolMidT[4], z_axis, math.rad(-175), speed)
        Turn(ToolMidT[2], z_axis, math.rad(0), speed)
        Turn(ToolMidT[4], z_axis, math.rad(0), speed)
        --resetHead


        WTurn(ToolUpT[2], z_axis, math.rad(0), speed)
        WTurn(ToolUpT[4], z_axis, math.rad(0), speed)
        showT(OperationSet)
        Hide(Op18)
        Hide(Op4)


        return state, Instate
    else

        resetT(OperationSet, speed, true, true)
        hideT(OperationSet)


        Turn(ToolMidT[4], z_axis, math.rad(-175), speed)
        WTurn(ToolMidT[2], z_axis, math.rad(180), speed)
        WTurn(ToolMidT[4], z_axis, math.rad(-180), speed)
        WTurn(ToolMidT[1], x_axis, math.rad(180), speed)
        WTurn(ToolUpT[3], x_axis, math.rad(-65), speed)
        WTurn(ToolMidT[3], x_axis, math.rad(-115), speed)
        WTurn(ToolLowT[3], x_axis, math.rad(-90), speed)
        foldAttrapp(boolDirection, speed)
        Hide(birthWater)
        Hide(bloodWater)
        Hide(Sack)
        Hide(SackWIP)
        Hide(GrowCapsule)
        Hide(BloodCapsule)
    
      	Hide(ItKickedMe)
			StartThread(delayedHideFluidSack)
       -- resetT(pieceTable_)

        return CurrentStat, Instate
    end
end

function delayedHideFluidSack()
WMove(fluidsack,y_axis,-50,0.25)
Hide(fluidsack)
Hide(bodyBag)
Hide(emptyCapsule)
Move(fluidsack,y_axis,0,0)
end
function eggDeploy(speed)

    Arm = ArmsTable[18]
    resetT(Arm, speed, false, true)
    showT(Arm)
    Hide(Op18)

    go = {
        Arm[1], 90, 0, 0, speed,
        Arm[2], 0, 0, -127, speed,
        Arm[3], 88, 0, 0, speed,
        Arm[4], -30, 0, 0, speed,
        Arm[5], 117, 0, 0, speed,
        Arm[6], 0, 0, 0, speed,
    }
  --  echoT(go)
    TurnPieceList(refUnitScript,
        go,
        false, --TurnInOrder
        true, -- WaitForTurn
        true )--synced

    WaitForTurns(Arm)
    --echo("Station1")
    Move(Stack01, y_axis, 12, 4)
    WTurn(Stack01, y_axis, math.rad(-22), 4)
    WaitForMove(Stack01, y_axis)
    Show(Op18)
    Move(Stack01, y_axis, 0, 0)


    TurnPieceList(refUnitScript,
        {
            Arm[6], 0, 0, 0, speed,
            Arm[5], -75, 0, 0, speed,
            Arm[4], 0, 0, 0, speed,
            Arm[3], 0, 0, 0, speed,
            Arm[2], 0, 0, -127, speed,
            Arm[1], 98, 0, 0, speed,
        },
        true, --TurnInOrder
        true, -- WaitForTurn
        false )--synced

    WaitForTurns(Arm)
    Sleep(3000)



    TurnPieceList(refUnitScript,
        {
            Arm[1], 98, 0, 0, speed,
            Arm[2], 0, 0, 0, speed,
            Arm[3], 0, 0, 0, speed,
            Arm[4], 0, 0, 0, speed,
            Arm[5], -75, 0, 0, speed,
            Arm[6], 0, 0, 0, speed,
        },
        false, --TurnInOrder
        false, -- WaitForTurn
        true ) --synced
    WaitForTurns(Arm)
    echo("Station2")
    Sleep(5000)

    go = {
        Arm[1], 148, 0, 0, speed,
        Arm[2], 0, 0, 27, speed,
        Arm[3], 90, 0, 0, speed,
        Arm[4], -56, 0, 4, speed,
        Arm[5], -12, 0, 0, speed,
        Arm[6], -115, -115, -18, speed,
    }

    TurnPieceList(refUnitScript,
        go,
        true, --TurnInOrder
        true, -- WaitForTurn
        true ) --synced
    Sleep(5000)
    WaitForTurns(Arm)
    echo("Station3")
    Show(GrowCapsule)
    Hide(Op18)
    Move(GrowSpot, y_axis, totalDistanceDown, 0)
    TurnPieceList(refUnitScript,
        {
            Arm[6], 180, 0, 0, speed,
            Arm[5], 179, 0, 0, speed,
            Arm[4], 90, 0, 0, speed,
            Arm[3], 179, 0, 0, speed,
            Arm[2], 0, 0, 0, speed,
            Arm[1], 90, 0, 0, speed,
        },
        true, --TurnInOrder
        true, -- WaitForTurn
        false )--synced
    TurnPieceList(refUnitScript,
        {
            Arm[1], 90, 0, 0, speed,
            Arm[2], 0, 0, 0, speed,
            Arm[3], 0, 0, 0, speed,
            Arm[4], 0, 0, 0, speed,
            Arm[5], 0, 0, 0, speed,
            Arm[6], 0, 0, 0, speed,
        },
        false, --TurnInOrder
        true, -- WaitForTurn
        true ) --synced

    Sleep(5000)


    resetT(Arm, 5, false, true)



    return 1
end

totalDistanceDown = -60



function LoopBirthEggs()
    EggT = TablesOfPiecesGroups["Egg"]
    degToTurn = -45
    hideT(EggT)
    index = 0
    while true do
        degToTurn = degToTurn + 45
        WTurn(Carusell, y_axis, math.rad(degToTurn), 0.5)
        index = index % 8 + 1

        Move(EggT[index], y_axis, 15, 0)
        offx, offy = Rotate(0, -8, math.rad(degToTurn))
        Move(EggT[index], x_axis, offx, 0)
        Move(EggT[index], z_axis, offy, 0)
        Sleep(10)
        Show(EggT[index])
        Move(EggT[index], x_axis, 0, 9)
        Move(EggT[index], z_axis, 0, 9)


        WMove(EggT[index], y_axis, 0, 18.81)
        WaitForMove(EggT[index], y_axis)
        hideIndex = math.max(math.min(#EggT, (index - 5) + 8), 1)

        hide("EggT[hideIndex]" .. hideIndex, EggT[hideIndex])
    end
end

function sackTurn(nr)
    ecks = 0
    sign = -1
    while StableLoopSignalTable[nr] == true do
        ecks = ecks + 1
        Turn(Sack, y_axis, math.rad(ecks * 90 * sign), 0)
        Turn(Sack, y_axis, math.rad(ecks * 90 * sign), 0)
        if ecks % 16 == 0 then sign = sign * -1 end
        Sleep(200)
    end
end

function pumpBeat(speed)


    StopSpin(spinp1, y_axis, 5.5)
    StopSpin(spinp2, y_axis, 5.5)
    Sleep(550)
    Spin(spinp1, y_axis, math.rad(42), 4.5)
    Spin(spinp2, y_axis, math.rad(-42), 4.5)
    Move(Pump1, y_axis, 0, 32)
    Move(Pump2, y_axis, -48, 32)

    Turn(ader4, y_axis, math.rad(5), 0.125)
    Turn(ader1, y_axis, math.rad(5), 0.125)
    Turn(pump1, y_axis, math.rad(-5), 0.125)
    Turn(pump2, y_axis, math.rad(-5), 0.125)
    Move(ader3, x_axis, 7, 3)
    Move(ader7, x_axis, -7, 3)

    WTurn(GrowCapsule, y_axis, math.rad(5), 0.125)




    --CounterTurn
    Turn(ader4, y_axis, math.rad(-5), 0.125)
    Turn(ader1, y_axis, math.rad(-5), 0.125)
    Turn(pump1, y_axis, math.rad(5), 0.125)
    Turn(pump2, y_axis, math.rad(5), 0.125)
    Move(ader3, x_axis, 5, 3)
    Move(ader7, x_axis, -5, 3)


    Move(Pump1, y_axis, -32, 32)
    Move(Pump2, y_axis, 0, 32)
    WTurn(GrowCapsule, y_axis, math.rad(-5), 0.125)
end

boolImplantImported = false
function implantImplant(speed)

    while true do

        Sleep(100)
        if boolImplantImported == true then
            Hide(Crate1)
            Show(Crate1Open)
            Arm = ArmsTable[4]
            Hide(Op4)
            TurnPieceList(refUnitScript,
                {
                    Arm[1], 90, 0, 0, speed,
                    Arm[2], 0, 0, -225, speed,
                    Arm[3], 100, 0, 0, speed,
                    Arm[4], -15, 0, 0, speed,
                    Arm[5], 5, 0, 0, speed,
                    Arm[6], 0, -45, 0, speed,
                },
                true, --TurnInOrder
                true, -- WaitForTurn
                false )--synced
            for i = 1, #Arm do 
					WaitForTurns(Arm[i])
				end; Sleep(500)
            Hide(Crate1)
            Show(Crate1Open)
            hideT(TablesOfPiecesGroups["Implant"])

            implant = TablesOfPiecesGroups["Implant"][math.ceil(math.random(1, #TablesOfPiecesGroups["Implant"]))]
            Show(implant)
            TurnPieceList(refUnitScript,
                {
                    Arm[1], 90, 0, 87, speed / 4,
                    Arm[2], 0, 0, 0, speed / 2,
                    Arm[3], 0, 0, 0, speed / 2,
                    Arm[4], 0, 0, 0, speed / 2,
                    Arm[5], 90, 0, 0, speed / 2,
                    Arm[6], 0, 0, 0, speed / 2,
                },
                false, --TurnInOrder
                true, -- WaitForTurn
                true ) --synced

            Sleep(500)

            TurnPieceList(refUnitScript,
                {
                    Arm[1], 90, 0, -22, speed / 4,
                    Arm[2], 0, 0, 0, speed / 2,
                    Arm[3], 0, 0, 0, speed / 2,
                    Arm[4], 0, 0, 0, speed / 2,
                    Arm[5], 90, 0, 0, speed / 2,
                    Arm[6], 0, 0, 0, speed / 2,
                },
                false, --TurnInOrder
                true, -- WaitForTurn
                true ) --synced

            Sleep(500)
            TurnPieceList(refUnitScript,
                {
                    Arm[1], 90, 0, 0, speed / 2,
                    Arm[2], 0, 0, -42, speed / 2,
                    Arm[3], 50, 0, 0, speed / 2,
                    Arm[4], -15, 0, 0, speed / 2,
                    Arm[5], 45, 0, 0, speed / 2,
                    Arm[6], 0, 0, 0, speed / 2,
                },
                false, --TurnInOrder
                true, -- WaitForTurn
                false )--synced
            for i = 1, #Arm do WaitForTurns(Arm[i]) end; Sleep(500)

            hideT(TablesOfPiecesGroups["Implant"])
            TurnPieceList(refUnitScript,
                {
                    Arm[6], 180, 0, 0, speed,
                    Arm[5], 179, 0, 0, speed,
                    Arm[4], 90, 0, 0, speed,
                    Arm[3], 179, 0, 0, speed,
                    Arm[2], 0, 0, 0, speed,
                    Arm[1], 90, 0, 0, speed
                },
                true, --TurnInOrder
                true, -- WaitForTurn
                false )--synced
            Hide(Crate1Open)
            boolImplantImported = false
        end
    end
end

function importImplant(nr, speed)
    Arm = ArmsTable[4]
    while true do
        Sleep(100)

        if boolImplantImported == false then
            Hide(Crate1)
            Hide(Crate1Open)


            distanceGate = 12 * 4
            for i = 1, 4 do
                Move(CrationismT[i], z_axis, (distanceGate - i * (distanceGate / 4)) * -1, 0, true)
                Hide(CrationismT[i])
            end
            TurnPieceList(refUnitScript,
                {
                    Arm[1], 110, 0, 0, speed,
                    Arm[2], 0, 0, -130, speed,
                    Arm[3], 5, 0, 0, speed,
                    Arm[4], 25, 0, 0, speed,
                    Arm[5], 0, 0, 0, speed,
                    Arm[6], -17, -16, -43, speed,
                },
                true, --TurnInOrder
                true, -- WaitForTurn
                false )--synced

            for i = 1, 4 do
                tag = math.ceil(math.random(2, 4))
                Show(DesT[tag])
                Move(CrationismT[i], z_axis, 0, 8.5)
                Show(CrationismT[i])
                WaitForMove(CrationismT[i], z_axis)
            end

            hideT(DesT)
            for i = 1, 4 do
                Hide(CrationismT[i])
            end
            Arm = ArmsTable[4]
            Hide(Crate4)
            Show(Op4)
            Sleep(1500)
            TurnPieceList(refUnitScript,
                {
                    Arm[1], 110, 0, 0, speed,
                    Arm[2], 0, 0, -130, speed,
                    Arm[3], -25, 0, 0, speed,
                    Arm[4], 45, 0, 0, speed,
                    Arm[5], 0, 0, 0, speed,
                    Arm[6], -5, -12, -49, speed,
                },
                false, --TurnInOrder
                true, -- WaitForTurn
                true ) --synced

            TurnPieceList(refUnitScript,
                {
                    Arm[1], 110, 0, 0, speed,
                    Arm[3], -85, 0, 0, speed,
                    Arm[2], 0, 0, 0, speed,
                    Arm[4], 45, 0, 0, speed,
                    Arm[5], 0, 0, 0, speed,
                    Arm[6], -5, -12, -49, speed,
                },
                true, --TurnInOrder
                true, -- WaitForTurn
                false )--synced

            Sleep(3000)
            TurnPieceList(refUnitScript,
                {
                    Arm[1], 90, 0, 127, speed * 2,
                    Arm[2], 0, 0, 0, speed * 2,
                    Arm[3], 0, 0, 0, speed * 2,
                    Arm[4], 0, 0, 0, speed * 2,
                    Arm[5], 90, 0, 0, speed * 2,
                    Arm[6], 0, 0, 0, speed * 2,
                },
                false, --TurnInOrder
                true, -- WaitForTurn
                true ) --synced
            Sleep(3000)
            TurnPieceList(refUnitScript,
                {
                    Arm[1], 90, 0, 0, speed * 2,
                    Arm[2], 0, 0, -225, speed * 2,
                    Arm[3], 100, 0, 0, speed * 2,
                    Arm[4], -15, 0, 0, speed * 2,
                    Arm[5], 5, 0, 0, speed * 2,
                    Arm[6], 0, -45, 0, speed * 2,
                },
                false, --TurnInOrder
                true, -- WaitForTurn
                true ) --synced
            Hide(Op4)
            Show(Crate1)
            Sleep(3000)
            TurnPieceList(refUnitScript,
                {
                    Arm[6], 180, 0, 0, speed * 2,
                    Arm[5], 179, 0, 0, speed * 2,
                    Arm[4], 90, 0, 0, speed * 2,
                    Arm[3], 179, 0, 0, speed * 2,
                    Arm[2], 0, 0, 0, speed * 2,
                    Arm[1], 90, 0, 0, speed * 2,
                },
                true, --TurnInOrder
                true, -- WaitForTurn
                false )--synced

            Sleep(3000)

            TurnPieceList(refUnitScript,
                {
                    Arm[1], 0, 0, 0, speed * 2,
                    Arm[2], 0, 0, 0, speed * 2,
                    Arm[3], 0, 0, 0, speed * 2,
                    Arm[4], 0, 0, 0, speed * 2,
                    Arm[5], 0, 0, 0, speed * 2,
                    Arm[6], 0, 0, 0, speed * 2,
                },
                true, --TurnInOrder
                true, -- WaitForTurn
                false )--synced

            Sleep(3000)
            boolImplantImported = true
        end
    end
end

function birthFluidLoop()
    Signal(SIG_WATER)
    SetSignalMask(SIG_WATER)
    Hide(bloodWater)
    Show(birthWater)
    Show(Sack)
    Show(GrowCapsule)
    Hide(BloodCapsule)


    while true do
        Spin(birthWater, y_axis, math.random(-math.pi, math.pi), 0)
        WMove(birthWater, y_axis, math.random(-1, -0.25), math.random(0.5, 2))
        WMove(birthWater, y_axis, 0, math.random(0.5, 2))
    end
end

signalImportImplant = getUniqueSignal()
function LooppumpUp(nr)
    StableLoopSignalTable[nr] = true
    StartThread(birthFluidLoop)
    StartThread(sackTurn, nr + 1)
    StartThread(importImplant, signalImportImplant, 0.65)
    StartThread(implantImplant, 1.5)
    Show(Sack)
    Show(centerpipes)

    while buildProgress < 0.25 and boolBuilding == true or StableLoopSignalTable[nr] do
        speed = buildProgress * 4
        WayToGo = (1 - buildProgress)
        if WayToGo < 0.75 then
            WayToGo = 0;
            speed = 9
        end
        percentage = totalDistanceDown * WayToGo
        Move(GrowSpot, y_axis, percentage, speed)
        Sleep(60)
        pumpBeat(5)
    end

    Move(GrowSpot, y_axis, 0, 5)
    Turn(GrowCapsule, y_axis, math.rad(0), 0.125)
    Turn(ader4, y_axis, math.rad(0), 0.125)
    Turn(ader1, y_axis, math.rad(0), 0.125)
    Turn(pump1, y_axis, math.rad(0), 0.125)
    Turn(pump2, y_axis, math.rad(0), 0.125)

    while true do
        pumpBeat(5)
        Sleep(100)
    end
end


lowMin, lowMax = 33, -66

function calcArmSpecificSecY(nr)
    sign = 1
    if nr > 9 then
        nr = nr - 9
        return lowMin + lowMax * (nr / 9)
    end


    return lowMin + lowMax * (nr / 9) * sign
end


function calcArmSpecificFirstZ(nr, value)
    if nr < 10 then
        if value then return value * -1 end
        return -90
    else
        if value then return value end
        return 90
    end
end

function runArmTest(sideSign, nr, speed, predelay, postDelay)
    Hide(Meat)
    Sleep(predelay)
    TurnPieceList(refUnitScript,
        {
            ArmsTable[nr][1], 0, 0, calcArmSpecificFirstZ(nr), speed,
            ArmsTable[nr][2], calcArmSpecificSecY(nr), 0, 0, speed,
            ArmsTable[nr][3], 0, 0, 0, speed,
            ArmsTable[nr][4], 0, 0, 0, speed,
            ArmsTable[nr][5], 0, 0, 0, speed,
            ArmsTable[nr][6], 0, 0, 0, speed,
        },
        false, --TurnInOrder
        true, -- WaitForTurn
        true ) --synced
    fVal = 0
    if sideSign == 1 then
        fVal = math.random(30, 110) * sideSign
    else
        fVal = math.random(30, 110) * sideSign * -1
    end
    Sleep(5000)
    TurnPieceList(refUnitScript,
        {
            ArmsTable[nr][1], 0, 0, calcArmSpecificFirstZ(nr), speed,
            ArmsTable[nr][2], calcArmSpecificSecY(nr), 0, 0, speed,
            ArmsTable[nr][3], 0, 0, fVal * -1 * sideSign, speed,
            ArmsTable[nr][4], 0, 0, fVal * sideSign, speed,
            ArmsTable[nr][5], 0, 0, fVal * sideSign, speed,
            ArmsTable[nr][6], 0, 0, fVal * -1 * sideSign, speed,
        },
        false, --TurnInOrder
        true, -- WaitForTurn
        true ) --synced
    Sleep(3000)
    TurnPieceList(refUnitScript,
        {
            ArmsTable[nr][1], 0, 0, calcArmSpecificFirstZ(nr), speed,
            ArmsTable[nr][2], calcArmSpecificSecY(nr), 0, 0, speed,
            ArmsTable[nr][3], 0, 0, 0, speed,
            ArmsTable[nr][4], 0, 0, 0, speed,
            ArmsTable[nr][5], 0, 0, 0, speed,
            ArmsTable[nr][6], 0, 0, 0, speed,
        },
        false, --TurnInOrder
        true, -- WaitForTurn
        true ) --synced
    Sleep(postDelay)
end

OpTool = 6

function incisionWithArm(sideSign, nr, speed, predelay, postDelay, CutNumber, buildProgressLimit)

    Sleep(predelay)
	
    for i = 1, CutNumber, 1 do
        TurnPieceList(refUnitScript,
            {
                ArmsTable[nr][1], 0, 0, calcArmSpecificFirstZ(nr), speed,
                ArmsTable[nr][2], calcArmSpecificSecY(nr), 0, 0, speed,
                ArmsTable[nr][3], 0, 0, sideSign * 45, speed,
                ArmsTable[nr][4], 0, 0, sideSign * 90, speed,
                ArmsTable[nr][5], 0, 0, sideSign * 45, speed,
                ArmsTable[nr][6], 0, 0, 0, speed,
            },
            false, --TurnInOrder
            true, -- WaitForTurn
            true ) --synced
        OperationMoves = math.ceil(math.random(5, 12))


        for i = 1, OperationMoves, 1 do
            Sleep(1500)
            randoVal = math.random(85, 120)
            opVal1 = math.random(-10, 10)
            opVal2 = math.random(-45, 45)
            rSign = randSign()

            TurnPieceList(refUnitScript,
                {
                    ArmsTable[nr][1], 0, 0, calcArmSpecificFirstZ(nr, randoVal), speed,
                    ArmsTable[nr][2], calcArmSpecificSecY(nr), 0, 0, speed,
                    ArmsTable[nr][3], 0, 0, sideSign * 90 - (randoVal - 90) * sideSign, speed,
                    ArmsTable[nr][4], 0, 0, sideSign * 90, speed,
                    ArmsTable[nr][5], 0, 0, sideSign * opVal1, speed,
                    ArmsTable[nr][6], 0, 0, sideSign * opVal2, speed,
                },
                false, --TurnInOrder
                true, -- WaitForTurn
                true ) --synced

            if buildProgress > buildProgressLimit then
                if nr == 19 then Show(Meat) end
                TurnPieceList(refUnitScript,
                    {
                        ArmsTable[nr][1], 0, 0, 0, speed,
                        ArmsTable[nr][2], 0, 0, 0, speed,
                        ArmsTable[nr][3], 0, 0, 0, speed,
                        ArmsTable[nr][4], 0, 0, sideSign * 90, speed,
                        ArmsTable[nr][5], 0, 0, 0, speed,
                        ArmsTable[nr][6], 0, 0, 0, speed,
                    },
                    false, --TurnInOrder
                    true, -- WaitForTurn
                    true ) --synced
                if nr == 19 then Explode(Meat, SFX.FALL + SFX.NO_HEATCLOUD); Hide(Meat) end

                Sleep(3000)
                operationCounter = operationCounter - 1
                return
            end
        end


        if nr == 19 then Show(Meat) end
        Sleep(3000)
        TurnPieceList(refUnitScript,
            {
                ArmsTable[nr][1], 0, 0, calcArmSpecificFirstZ(nr), speed,
                ArmsTable[nr][2], calcArmSpecificSecY(nr), 0, 0, speed,
                ArmsTable[nr][3], 0, 0, sideSign * 45, speed,
                ArmsTable[nr][4], 0, 0, sideSign * 90, speed,
                ArmsTable[nr][5], 0, 0, sideSign * 45, speed,
                ArmsTable[nr][6], 0, 0, 0, speed,
            },
            false, --TurnInOrder
            true, -- WaitForTurn
            true ) --synced
    end
    Sleep(3000)


    TurnPieceList(refUnitScript,
        {
            ArmsTable[nr][1], 0, 0, 0, speed,
            ArmsTable[nr][2], 0, 0, 0, speed,
            ArmsTable[nr][3], 0, 0, 0, speed,
            ArmsTable[nr][4], 0, 0, sideSign * 90, speed,
            ArmsTable[nr][5], 0, 0, 0, speed,
            ArmsTable[nr][6], 0, 0, 0, speed,
        },
        false, --TurnInOrder
        true, -- WaitForTurn
        true ) --synced
    Sleep(3000)
    if nr == 19 then Explode(Meat, SFX.FALL + SFX.NO_HEATCLOUD); Hide(Meat) end
    Sleep(postDelay)

    operationCounter = operationCounter - 1
end

function cutDeep(buildProgressLimit)
    if buildProgress > buildProgressLimit then return end

    for i = 1, #ArmsTable, 1 do
        startval = math.random(0.45, 1)
        range = math.random(0.5, 1.5)
        sideSign = -1
        if i > 9 then sideSign = 1 end

        if ArmsTable[i] and i ~= 4 and i ~= 18 then
            if maRa() == true or operationCounter <= 0 then
                operationCounter = operationCounter + 1
                StartThread(incisionWithArm, sideSign, i, math.max(0.45, math.random(startval, startval + range)), iRand(100, 1000), iRand(1400, 3000), iRand(3, 9), buildProgressLimit)
            else
                speed = 5
                TurnPieceList(refUnitScript,
                    {
                        ArmsTable[i][1], 0, 0, 0, speed,
                        ArmsTable[i][2], 0, 0, 0, speed,
                        ArmsTable[i][3], 0, 0, 0, speed,
                        ArmsTable[i][4], 0, 0, sideSign * 90, speed,
                        ArmsTable[i][5], 0, 0, 0, speed,
                        ArmsTable[i][6], 0, 0, 0, speed,
                    },
                    false, --TurnInOrder
                    false, -- WaitForTurn
                    true ) --synced
            end
        end
    end
    while (operationCounter > 0 and buildProgress < buildProgressLimit) do
        Sleep(100)
    end
end
RandMoveKick=piece"RandMoveKick"
SIG_WATER = 4
function bloodyHell()
    Signal(SIG_WATER)
    SetSignalMask(SIG_WATER)
    Hide(Sack)
    Show(SackWIP)
    Hide(GrowCapsule)
    Show(BloodCapsule)
    Show(bloodWater)
	StartThread(soundTrack)
    Hide(birthWater)
    while true do
        Spin(bloodWater, y_axis, math.random(-math.pi, math.pi), 0)
			if math.random(0,12)==6 then
				Show(ItKickedMe)
				turnPieceRandDir(ItKickedMe, math.random(30,90))
				movePieceRandDir(RandMoveKick, math.random(30,90), 15, -15, 5, -5, 15, -15)
			end
        WMove(bloodWater, y_axis, math.random(-1, -0.25), math.random(0.5, 2))
        WMove(bloodWater, y_axis, 0, math.random(0.5, 2))
		if math.random(1,4)==2 then
			reset(RandMoveKick, 80)
			reset(ItKickedMe,80, true)
			Hide(ItKickedMe)
		end
    end
end

operationCounter = 0
function operate(buildID)


    --test tools
    for i = 1, #ArmsTable, 1 do

        startval = math.random(0.25, 1)
        range = math.random(0.5, 1.5)
        sideSign = -1
        if i > 9 then sideSign = 1 end

        if ArmsTable[i] and i ~= 4 and i ~= 18 then
            StartThread(runArmTest, sideSign, i, math.max(0.1, math.random(startval, startval + range)), iRand(100, 1000), iRand(1400, 3000))
        end
    end
    --wait for the unit to "grow"
    while buildProgress < 0.25 do Sleep(10) end
    --incision
    cutDeep(0.5)
    while buildProgress < 0.5 do Sleep(10) end
    --bloody work to be done
    StartThread(bloodyHell)

    while buildProgress < 0.6 do Sleep(10) end
    cutDeep(0.95)

    while buildProgress < 0.95 do Sleep(10) end
		boolStillBuilding
    while buildProgress < 1 do Sleep(10) end
	    showUnit(buildID)
		boolStillBuilding= false
end

function showUnit(buildID)

    Hide(Sack)

    Hide(GrowCapsule)
    Hide(birthWater)
    Hide(BloodCapsule)
    Hide(bloodWater)
    Show(emptyCapsule)
    Show(fluidsack)
    Show(bodyBug)
    Spring.SetUnitAlwaysVisible(buildID, true)
    WMove(SackWIP, y_axis, -25, 100)
    Hide(SackWIP)
    reset(SackWIP)
end


function LoopimplantInsertion(nr)
end

function LoopSewUp(nr)
end

function LoopPumpedDown(nr)
end

function LoopRelease(nr)
end

StableLoopSignalTable = {
    [1] = true,
    [2] = true,
    [3] = true,
    [4] = true,
    [5] = true,
    [6] = true,
    [7] = true,
}

boolBuilding = false

buildProgress = 0


function showOnceComplete(evtID, frame, persPack, startFrame)

				--Spring.Echo("EventStream Poisoned by active for"..persPack.victimID)
				--only apply if Unit is still alive
				if Spring.GetUnitIsDead(persPack.myID) == true or Spring.ValidUnitID(persPack.myID) == false then
					return nil, persPack
				end
				

				hp, maxHP, pd, cp, progress  = Spring.GetUnitHealth(persPack.myID)
				
				if not progress or progress >= 1 then
						if progress then
							returnToWorld(persPack.myID)
						end
					return nil, persPack
				end
				
				
				return frame + 5, persPack
			

end


function buildOS()
    oldID = nil
    while true do
        buildID = Spring.GetUnitIsBuilding(unitID)
        if buildID and buildID ~= oldID then
				removeFromWorld(buildID)
				
				persPack = { myID = buildID}
					GG.EventStream:CreateEvent(
					showOnceComplete,
					persPack,
					Spring.GetGameFrame() + 1)
				
				
            boolBuilding = true
            progress = 0
            buildProgress = 0
            Signal(SIG_BUILD)
            StartThread(BuildingAnimation, buildID, false)

            --building something
            Spring.SetUnitAlwaysVisible(buildID, false)

            while Spring.ValidUnitID(buildID) and progress < 1 do
                _, _, pd, cp, progress = Spring.GetUnitHealth(buildID)
               -- Spring.Echo("BuildProgress:" .. progress)
                buildProgress = progress or 0.01
                Sleep(100)
            end

            if Spring.ValidUnitID(buildID) == false or Spring.GetUnitIsDead(buildID) == true then
                Signal(SIG_BUILD)
                fold(false, 7)
            end

            if Spring.GetUnitIsDead(buildID) == false then
                Spring.SetUnitAlwaysVisible(buildID, true)
            end
            boolBuilding = false
            oldID = buildID
        end

        Sleep(500)
    end
end

function randomBlink()
    hideT(WindowTable)
    for i = 1, #WindowTable do
        if i % 2 == 0 then Show(WindowTable[i]) end
    end
    itterate = 0.1

    while true do
        itterate = itterate + 0.1
        changeVal = math.ceil(math.random(2, 42))
        ignoreVal = math.ceil(math.random(2, 6))

        times = math.ceil(math.abs(1 + math.ceil(1100 + math.sin(itterate) * 100)))
        Sleep(times)
        for i = 1, #WindowTable - 1, 2 do
            if i % ignoreVal == 0 or i % changeVal ~= 0 then
                Show(WindowTable[i])
                hide("WindowTable[i+1]", WindowTable[i + 1])
            elseif i % changeVal == 0 then
                hide("WindowTable[i]", WindowTable[i])
                Show(WindowTable[i + 1])
            end
        end
        Sleep(100)
    end
end

function script.Killed(recentDamage, _)
    createCorpseCBuilding(unitID, recentDamage)
    return 1
end

function script.StopBuilding()
    SetUnitValue(COB.INBUILDSTANCE, 0)
		Signal(SIG_BUILD)
		Signal(SIG_FOLD)
	   StartThread(fold,false, 1)
end

function script.StartBuilding(heading, pitch)
    SetUnitValue(COB.INBUILDSTANCE, 1)
end

function script.Activate()

    SetUnitValue(COB.YARD_OPEN, 1)

    SetUnitValue(COB.BUGGER_OFF, 1)

    SetUnitValue(COB.INBUILDSTANCE, 1)
    --Sleep(150)
    return 1
end

function script.Deactivate()

    SetUnitValue(COB.YARD_OPEN, 0)

    SetUnitValue(COB.BUGGER_OFF, 0)

    SetUnitValue(COB.INBUILDSTANCE, 0)
    --Sleep(150)
    return 0
end



function script.QueryBuildInfo()
    return GrowSpot
end
