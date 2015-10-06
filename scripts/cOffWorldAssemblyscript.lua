include "suddenDeath.lua"
include "lib_OS.lua"
 include "lib_UnitScript.lua"
 include "lib_Build.lua" 
piecesTable={}
piecesTable=makePieceTable(unitID)


 piecesTable={}
 deathpivot = piece("deathpivot")
 piecesTable[#piecesTable+1]= deathpivot
 center = piece("center")
 piecesTable[#piecesTable+1]= center
 AU2 = piece("AU2")
 piecesTable[#piecesTable+1]= AU2
 AU1 = piece("AU1")
 piecesTable[#piecesTable+1]= AU1
 Attrap1 = piece("Attrap1")
 piecesTable[#piecesTable+1]= Attrap1
 Window027 = piece("Window027")
 piecesTable[#piecesTable+1]= Window027
 Window028 = piece("Window028")
 piecesTable[#piecesTable+1]= Window028
 Window037 = piece("Window037")
 piecesTable[#piecesTable+1]= Window037
 Window038 = piece("Window038")
 piecesTable[#piecesTable+1]= Window038
 Window029 = piece("Window029")
 piecesTable[#piecesTable+1]= Window029
 Window030 = piece("Window030")
 piecesTable[#piecesTable+1]= Window030
 AU4 = piece("AU4")
 piecesTable[#piecesTable+1]= AU4
 AU5 = piece("AU5")
 piecesTable[#piecesTable+1]= AU5
 Attrap2 = piece("Attrap2")
 piecesTable[#piecesTable+1]= Attrap2
 Attrap3 = piece("Attrap3")
 piecesTable[#piecesTable+1]= Attrap3
 AU6 = piece("AU6")
 piecesTable[#piecesTable+1]= AU6
 AU7 = piece("AU7")
 piecesTable[#piecesTable+1]= AU7
 Attrap4 = piece("Attrap4")
 piecesTable[#piecesTable+1]= Attrap4
 Window045 = piece("Window045")
 piecesTable[#piecesTable+1]= Window045
 Window046 = piece("Window046")
 piecesTable[#piecesTable+1]= Window046
 Window047 = piece("Window047")
 piecesTable[#piecesTable+1]= Window047
 Window048 = piece("Window048")
 piecesTable[#piecesTable+1]= Window048
 Window049 = piece("Window049")
 piecesTable[#piecesTable+1]= Window049
 Window050 = piece("Window050")
 piecesTable[#piecesTable+1]= Window050
 Window051 = piece("Window051")
 piecesTable[#piecesTable+1]= Window051
 Window052 = piece("Window052")
 piecesTable[#piecesTable+1]= Window052
 AU8 = piece("AU8")
 piecesTable[#piecesTable+1]= AU8
 AU9 = piece("AU9")
 piecesTable[#piecesTable+1]= AU9
 Attrap5 = piece("Attrap5")
 piecesTable[#piecesTable+1]= Attrap5
 Window061 = piece("Window061")
 piecesTable[#piecesTable+1]= Window061
 Window062 = piece("Window062")
 piecesTable[#piecesTable+1]= Window062
 Window063 = piece("Window063")
 piecesTable[#piecesTable+1]= Window063
 Window064 = piece("Window064")
 piecesTable[#piecesTable+1]= Window064
 AU10 = piece("AU10")
 piecesTable[#piecesTable+1]= AU10
 AU11 = piece("AU11")
 piecesTable[#piecesTable+1]= AU11
 Attrap6 = piece("Attrap6")
 piecesTable[#piecesTable+1]= Attrap6
 Base = piece("Base")
 piecesTable[#piecesTable+1]= Base
 Crate3 = piece("Crate3")
 piecesTable[#piecesTable+1]= Crate3
 Crate2 = piece("Crate2")
 piecesTable[#piecesTable+1]= Crate2
 Crate1Open = piece("Crate1Open")
 piecesTable[#piecesTable+1]= Crate1Open
 Crate1 = piece("Crate1")
 piecesTable[#piecesTable+1]= Crate1
 Pump1 = piece("Pump1")
 piecesTable[#piecesTable+1]= Pump1
 Pump2 = piece("Pump2")
 piecesTable[#piecesTable+1]= Pump2
 Implant1 = piece("Implant1")
 piecesTable[#piecesTable+1]= Implant1
 Implant2 = piece("Implant2")
 piecesTable[#piecesTable+1]= Implant2
 Implant3 = piece("Implant3")
 piecesTable[#piecesTable+1]= Implant3
 Implant4 = piece("Implant4")
 piecesTable[#piecesTable+1]= Implant4
 Implant5 = piece("Implant5")
 piecesTable[#piecesTable+1]= Implant5
 centerpipes = piece("centerpipes")
 piecesTable[#piecesTable+1]= centerpipes
 PumpPillar1 = piece("PumpPillar1")
 piecesTable[#piecesTable+1]= PumpPillar1
 ader1 = piece("ader1")
 piecesTable[#piecesTable+1]= ader1
 pump1 = piece("pump1")
 piecesTable[#piecesTable+1]= pump1
 spinp1 = piece("spinp1")
 piecesTable[#piecesTable+1]= spinp1
 ader2 = piece("ader2")
 piecesTable[#piecesTable+1]= ader2
 ader3 = piece("ader3")
 piecesTable[#piecesTable+1]= ader3
 Line18 = piece("Line18")
 piecesTable[#piecesTable+1]= Line18
 Line19 = piece("Line19")
 piecesTable[#piecesTable+1]= Line19
 PumpPillar2 = piece("PumpPillar2")
 piecesTable[#piecesTable+1]= PumpPillar2
 ader2 = piece("ader2")
 piecesTable[#piecesTable+1]= ader2
 pump2 = piece("pump2")
 piecesTable[#piecesTable+1]= pump2
 spinp2 = piece("spinp2")
 piecesTable[#piecesTable+1]= spinp2
 Linie20 = piece("Linie20")
 piecesTable[#piecesTable+1]= Linie20
 Linie40 = piece("Linie40")
 piecesTable[#piecesTable+1]= Linie40
 Linie41 = piece("Linie41")
 piecesTable[#piecesTable+1]= Linie41
 Linie42 = piece("Linie42")
 piecesTable[#piecesTable+1]= Linie42
 Linie43 = piece("Linie43")
 piecesTable[#piecesTable+1]= Linie43
 Carusell = piece("Carusell")
 piecesTable[#piecesTable+1]= Carusell
 Egg = piece("Egg")
 piecesTable[#piecesTable+1]= Egg
 OPFA001 = piece("OPFA001")
 piecesTable[#piecesTable+1]= OPFA001
 OPSA001 = piece("OPSA001")
 piecesTable[#piecesTable+1]= OPSA001
 OPTA001 = piece("OPTA001")
 piecesTable[#piecesTable+1]= OPTA001
 OPTA0010 = piece("OPTA0010")
 piecesTable[#piecesTable+1]= OPTA0010
 OPVA001 = piece("OPVA001")
 piecesTable[#piecesTable+1]= OPVA001
 Op1 = piece("Op1")
 piecesTable[#piecesTable+1]= Op1
 OPFA002 = piece("OPFA002")
 piecesTable[#piecesTable+1]= OPFA002
 OPSA002 = piece("OPSA002")
 piecesTable[#piecesTable+1]= OPSA002
 OPTA003 = piece("OPTA003")
 piecesTable[#piecesTable+1]= OPTA003
 OPTA002 = piece("OPTA002")
 piecesTable[#piecesTable+1]= OPTA002
 OPVA002 = piece("OPVA002")
 piecesTable[#piecesTable+1]= OPVA002
 Op2 = piece("Op2")
 piecesTable[#piecesTable+1]= Op2
 OPFA003 = piece("OPFA003")
 piecesTable[#piecesTable+1]= OPFA003
 OPSA003 = piece("OPSA003")
 piecesTable[#piecesTable+1]= OPSA003
 OPTA005 = piece("OPTA005")
 piecesTable[#piecesTable+1]= OPTA005
 OPTA004 = piece("OPTA004")
 piecesTable[#piecesTable+1]= OPTA004
 OPVA003 = piece("OPVA003")
 piecesTable[#piecesTable+1]= OPVA003
 Op3 = piece("Op3")
 piecesTable[#piecesTable+1]= Op3
 OPFA005 = piece("OPFA005")
 piecesTable[#piecesTable+1]= OPFA005
 OPSA005 = piece("OPSA005")
 piecesTable[#piecesTable+1]= OPSA005
 OPTA009 = piece("OPTA009")
 piecesTable[#piecesTable+1]= OPTA009
 OPTA008 = piece("OPTA008")
 piecesTable[#piecesTable+1]= OPTA008
 OPVA005 = piece("OPVA005")
 piecesTable[#piecesTable+1]= OPVA005
 Op5 = piece("Op5")
 piecesTable[#piecesTable+1]= Op5
 OPFA006 = piece("OPFA006")
 piecesTable[#piecesTable+1]= OPFA006
 OPSA006 = piece("OPSA006")
 piecesTable[#piecesTable+1]= OPSA006
 OPTA011 = piece("OPTA011")
 piecesTable[#piecesTable+1]= OPTA011
 OPTA010 = piece("OPTA010")
 piecesTable[#piecesTable+1]= OPTA010
 OPVA006 = piece("OPVA006")
 piecesTable[#piecesTable+1]= OPVA006
 Op6 = piece("Op6")
 piecesTable[#piecesTable+1]= Op6
 OPFA007 = piece("OPFA007")
 piecesTable[#piecesTable+1]= OPFA007
 OPSA007 = piece("OPSA007")
 piecesTable[#piecesTable+1]= OPSA007
 OPTA013 = piece("OPTA013")
 piecesTable[#piecesTable+1]= OPTA013
 OPTA012 = piece("OPTA012")
 piecesTable[#piecesTable+1]= OPTA012
 OPVA007 = piece("OPVA007")
 piecesTable[#piecesTable+1]= OPVA007
 Op7 = piece("Op7")
 piecesTable[#piecesTable+1]= Op7
 OPFA008 = piece("OPFA008")
 piecesTable[#piecesTable+1]= OPFA008
 OPSA008 = piece("OPSA008")
 piecesTable[#piecesTable+1]= OPSA008
 OPTA015 = piece("OPTA015")
 piecesTable[#piecesTable+1]= OPTA015
 OPTA014 = piece("OPTA014")
 piecesTable[#piecesTable+1]= OPTA014
 OPVA008 = piece("OPVA008")
 piecesTable[#piecesTable+1]= OPVA008
 Op8 = piece("Op8")
 piecesTable[#piecesTable+1]= Op8
 GrowCapsule = piece("GrowCapsule")
 piecesTable[#piecesTable+1]= GrowCapsule
 BloodCapsule = piece("BloodCapsule")
 piecesTable[#piecesTable+1]= BloodCapsule
 StompBase4 = piece("StompBase4")
 piecesTable[#piecesTable+1]= StompBase4
 Stomp4 = piece("Stomp4")
 piecesTable[#piecesTable+1]= Stomp4
 ToolLow3 = piece("ToolLow3")
 piecesTable[#piecesTable+1]= ToolLow3
 ToolMid3 = piece("ToolMid3")
 piecesTable[#piecesTable+1]= ToolMid3
 ToolUp3 = piece("ToolUp3")
 piecesTable[#piecesTable+1]= ToolUp3
 StompBase3 = piece("StompBase3")
 piecesTable[#piecesTable+1]= StompBase3
 Stomp3 = piece("Stomp3")
 piecesTable[#piecesTable+1]= Stomp3
 StompBase2 = piece("StompBase2")
 piecesTable[#piecesTable+1]= StompBase2
 Stomp2 = piece("Stomp2")
 piecesTable[#piecesTable+1]= Stomp2
 StompBase1 = piece("StompBase1")
 piecesTable[#piecesTable+1]= StompBase1
 Stomp1 = piece("Stomp1")
 piecesTable[#piecesTable+1]= Stomp1
 ToolLow1 = piece("ToolLow1")
 piecesTable[#piecesTable+1]= ToolLow1
 ToolMid1 = piece("ToolMid1")
 piecesTable[#piecesTable+1]= ToolMid1
 ToolUp1 = piece("ToolUp1")
 piecesTable[#piecesTable+1]= ToolUp1
 Crate4 = piece("Crate4")
 piecesTable[#piecesTable+1]= Crate4
 CratePart = piece("CratePart")
 piecesTable[#piecesTable+1]= CratePart
 Dest2 = piece("Dest2")
 piecesTable[#piecesTable+1]= Dest2
 Dest1 = piece("Dest1")
 piecesTable[#piecesTable+1]= Dest1
 Dest3 = piece("Dest3")
 piecesTable[#piecesTable+1]= Dest3
 Rectangle3 = piece("Rectangle3")
 piecesTable[#piecesTable+1]= Rectangle3
 OPFA019 = piece("OPFA019")
 piecesTable[#piecesTable+1]= OPFA019
 OPSA019 = piece("OPSA019")
 piecesTable[#piecesTable+1]= OPSA019
 OPTA037 = piece("OPTA037")
 piecesTable[#piecesTable+1]= OPTA037
 OPTA036 = piece("OPTA036")
 piecesTable[#piecesTable+1]= OPTA036
 OPVA019 = piece("OPVA019")
 piecesTable[#piecesTable+1]= OPVA019
 OPFA018 = piece("OPFA018")
 piecesTable[#piecesTable+1]= OPFA018
 OPSA018 = piece("OPSA018")
 piecesTable[#piecesTable+1]= OPSA018
 OPTA035 = piece("OPTA035")
 piecesTable[#piecesTable+1]= OPTA035
 OPTA034 = piece("OPTA034")
 piecesTable[#piecesTable+1]= OPTA034
 OPVA018 = piece("OPVA018")
 piecesTable[#piecesTable+1]= OPVA018
 EggPod = piece("EggPod")
 piecesTable[#piecesTable+1]= EggPod
 ToolLow4 = piece("ToolLow4")
 piecesTable[#piecesTable+1]= ToolLow4
 ToolMid4 = piece("ToolMid4")
 piecesTable[#piecesTable+1]= ToolMid4
 ToolUp4 = piece("ToolUp4")
 piecesTable[#piecesTable+1]= ToolUp4
 OPFA003 = piece("OPFA003")
 piecesTable[#piecesTable+1]= OPFA003
 OPSA004 = piece("OPSA004")
 piecesTable[#piecesTable+1]= OPSA004
 OPTA007 = piece("OPTA007")
 piecesTable[#piecesTable+1]= OPTA007
 OPTA006 = piece("OPTA006")
 piecesTable[#piecesTable+1]= OPTA006
 OPVA004 = piece("OPVA004")
 piecesTable[#piecesTable+1]= OPVA004
 Op4 = piece("Op4")
 piecesTable[#piecesTable+1]= Op4
 ToolLow2 = piece("ToolLow2")
 piecesTable[#piecesTable+1]= ToolLow2
 ToolMid2 = piece("ToolMid2")
 piecesTable[#piecesTable+1]= ToolMid2
 ToolUp2 = piece("ToolUp2")
 piecesTable[#piecesTable+1]= ToolUp2
 OPFA009 = piece("OPFA009")
 piecesTable[#piecesTable+1]= OPFA009
 OPSA009 = piece("OPSA009")
 piecesTable[#piecesTable+1]= OPSA009
 OPTA017 = piece("OPTA017")
 piecesTable[#piecesTable+1]= OPTA017
 OPTA016 = piece("OPTA016")
 piecesTable[#piecesTable+1]= OPTA016
 OPVA009 = piece("OPVA009")
 piecesTable[#piecesTable+1]= OPVA009
 Op9 = piece("Op9")
 piecesTable[#piecesTable+1]= Op9
 OPFA010 = piece("OPFA010")
 piecesTable[#piecesTable+1]= OPFA010
 OPSA010 = piece("OPSA010")
 piecesTable[#piecesTable+1]= OPSA010
 OPTA019 = piece("OPTA019")
 piecesTable[#piecesTable+1]= OPTA019
 OPTA018 = piece("OPTA018")
 piecesTable[#piecesTable+1]= OPTA018
 OPVA010 = piece("OPVA010")
 piecesTable[#piecesTable+1]= OPVA010
 Op010 = piece("Op010")
 piecesTable[#piecesTable+1]= Op010
 OPFA011 = piece("OPFA011")
 piecesTable[#piecesTable+1]= OPFA011
 OPSA011 = piece("OPSA011")
 piecesTable[#piecesTable+1]= OPSA011
 OPTA021 = piece("OPTA021")
 piecesTable[#piecesTable+1]= OPTA021
 OPTA020 = piece("OPTA020")
 piecesTable[#piecesTable+1]= OPTA020
 OPVA011 = piece("OPVA011")
 piecesTable[#piecesTable+1]= OPVA011
 Op10 = piece("Op10")
 piecesTable[#piecesTable+1]= Op10
 OPFA012 = piece("OPFA012")
 piecesTable[#piecesTable+1]= OPFA012
 OPSA012 = piece("OPSA012")
 piecesTable[#piecesTable+1]= OPSA012
 OPTA023 = piece("OPTA023")
 piecesTable[#piecesTable+1]= OPTA023
 OPTA022 = piece("OPTA022")
 piecesTable[#piecesTable+1]= OPTA022
 OPVA012 = piece("OPVA012")
 piecesTable[#piecesTable+1]= OPVA012
 Op11 = piece("Op11")
 piecesTable[#piecesTable+1]= Op11
 OPFA013 = piece("OPFA013")
 piecesTable[#piecesTable+1]= OPFA013
 OPSA013 = piece("OPSA013")
 piecesTable[#piecesTable+1]= OPSA013
 OPTA025 = piece("OPTA025")
 piecesTable[#piecesTable+1]= OPTA025
 OPTA024 = piece("OPTA024")
 piecesTable[#piecesTable+1]= OPTA024
 OPVA013 = piece("OPVA013")
 piecesTable[#piecesTable+1]= OPVA013
 Op12 = piece("Op12")
 piecesTable[#piecesTable+1]= Op12
 OPFA014 = piece("OPFA014")
 piecesTable[#piecesTable+1]= OPFA014
 OPSA014 = piece("OPSA014")
 piecesTable[#piecesTable+1]= OPSA014
 OPTA027 = piece("OPTA027")
 piecesTable[#piecesTable+1]= OPTA027
 OPTA026 = piece("OPTA026")
 piecesTable[#piecesTable+1]= OPTA026
 OPVA014 = piece("OPVA014")
 piecesTable[#piecesTable+1]= OPVA014
 Op13 = piece("Op13")
 piecesTable[#piecesTable+1]= Op13
 OPFA015 = piece("OPFA015")
 piecesTable[#piecesTable+1]= OPFA015
 OPSA015 = piece("OPSA015")
 piecesTable[#piecesTable+1]= OPSA015
 OPTA029 = piece("OPTA029")
 piecesTable[#piecesTable+1]= OPTA029
 OPTA028 = piece("OPTA028")
 piecesTable[#piecesTable+1]= OPTA028
 OPVA015 = piece("OPVA015")
 piecesTable[#piecesTable+1]= OPVA015
 Op14 = piece("Op14")
 piecesTable[#piecesTable+1]= Op14
 OPFA016 = piece("OPFA016")
 piecesTable[#piecesTable+1]= OPFA016
 OPSA016 = piece("OPSA016")
 piecesTable[#piecesTable+1]= OPSA016
 OPTA031 = piece("OPTA031")
 piecesTable[#piecesTable+1]= OPTA031
 OPTA030 = piece("OPTA030")
 piecesTable[#piecesTable+1]= OPTA030
 OPVA016 = piece("OPVA016")
 piecesTable[#piecesTable+1]= OPVA016
 Op15 = piece("Op15")
 piecesTable[#piecesTable+1]= Op15
 OPFA017 = piece("OPFA017")
 piecesTable[#piecesTable+1]= OPFA017
 OPSA017 = piece("OPSA017")
 piecesTable[#piecesTable+1]= OPSA017
 OPTA033 = piece("OPTA033")
 piecesTable[#piecesTable+1]= OPTA033
 OPTA032 = piece("OPTA032")
 piecesTable[#piecesTable+1]= OPTA032
 OPVA017 = piece("OPVA017")
 piecesTable[#piecesTable+1]= OPVA017
 Op016 = piece("Op016")
 piecesTable[#piecesTable+1]= Op016
 Sack = piece("Sack")
 piecesTable[#piecesTable+1]= Sack
 Sack01 = piece("Sack01")
 piecesTable[#piecesTable+1]= Sack01
 Stack01 = piece("Stack01")
 piecesTable[#piecesTable+1]= Stack01
 Window001 = piece("Window001")
 piecesTable[#piecesTable+1]= Window001
 Window002 = piece("Window002")
 piecesTable[#piecesTable+1]= Window002
 Window003 = piece("Window003")
 piecesTable[#piecesTable+1]= Window003
 Window004 = piece("Window004")
 piecesTable[#piecesTable+1]= Window004
 Window005 = piece("Window005")
 piecesTable[#piecesTable+1]= Window005
 Window006 = piece("Window006")
 piecesTable[#piecesTable+1]= Window006
 Window007 = piece("Window007")
 piecesTable[#piecesTable+1]= Window007
 Window008 = piece("Window008")
 piecesTable[#piecesTable+1]= Window008
 Window009 = piece("Window009")
 piecesTable[#piecesTable+1]= Window009
 Window010 = piece("Window010")
 piecesTable[#piecesTable+1]= Window010
 Window011 = piece("Window011")
 piecesTable[#piecesTable+1]= Window011
 Window012 = piece("Window012")
 piecesTable[#piecesTable+1]= Window012
 Window013 = piece("Window013")
 piecesTable[#piecesTable+1]= Window013
 Window014 = piece("Window014")
 piecesTable[#piecesTable+1]= Window014
 Window015 = piece("Window015")
 piecesTable[#piecesTable+1]= Window015
 Window016 = piece("Window016")
 piecesTable[#piecesTable+1]= Window016
 Window017 = piece("Window017")
 piecesTable[#piecesTable+1]= Window017
 Window018 = piece("Window018")
 piecesTable[#piecesTable+1]= Window018
 Window019 = piece("Window019")
 piecesTable[#piecesTable+1]= Window019
 Window020 = piece("Window020")
 piecesTable[#piecesTable+1]= Window020
 Window021 = piece("Window021")
 piecesTable[#piecesTable+1]= Window021
 Window022 = piece("Window022")
 piecesTable[#piecesTable+1]= Window022
 Window023 = piece("Window023")
 piecesTable[#piecesTable+1]= Window023
 Window024 = piece("Window024")
 piecesTable[#piecesTable+1]= Window024
 Window025 = piece("Window025")
 piecesTable[#piecesTable+1]= Window025
 Window026 = piece("Window026")
 piecesTable[#piecesTable+1]= Window026
 Window031 = piece("Window031")
 piecesTable[#piecesTable+1]= Window031
 Window032 = piece("Window032")
 piecesTable[#piecesTable+1]= Window032
 Window033 = piece("Window033")
 piecesTable[#piecesTable+1]= Window033
 Window034 = piece("Window034")
 piecesTable[#piecesTable+1]= Window034
 Window035 = piece("Window035")
 piecesTable[#piecesTable+1]= Window035
 Window036 = piece("Window036")
 piecesTable[#piecesTable+1]= Window036
 Window039 = piece("Window039")
 piecesTable[#piecesTable+1]= Window039
 Window040 = piece("Window040")
 piecesTable[#piecesTable+1]= Window040
 Window041 = piece("Window041")
 piecesTable[#piecesTable+1]= Window041
 Window042 = piece("Window042")
 piecesTable[#piecesTable+1]= Window042
 Window043 = piece("Window043")
 piecesTable[#piecesTable+1]= Window043
 Window044 = piece("Window044")
 piecesTable[#piecesTable+1]= Window044
 Window053 = piece("Window053")
 piecesTable[#piecesTable+1]= Window053
 Window054 = piece("Window054")
 piecesTable[#piecesTable+1]= Window054
 Window055 = piece("Window055")
 piecesTable[#piecesTable+1]= Window055
 Window056 = piece("Window056")
 piecesTable[#piecesTable+1]= Window056
 Window057 = piece("Window057")
 piecesTable[#piecesTable+1]= Window057
 Window058 = piece("Window058")
 piecesTable[#piecesTable+1]= Window058
 Window059 = piece("Window059")
 piecesTable[#piecesTable+1]= Window059
 Window060 = piece("Window060")
 piecesTable[#piecesTable+1]= Window060
 Window065 = piece("Window065")
 piecesTable[#piecesTable+1]= Window065
 Window066 = piece("Window066")
 piecesTable[#piecesTable+1]= Window066
 Window067 = piece("Window067")
 piecesTable[#piecesTable+1]= Window067
 Window068 = piece("Window068")
 piecesTable[#piecesTable+1]= Window068
 Window069 = piece("Window069")
 piecesTable[#piecesTable+1]= Window069
 Window070 = piece("Window070")
 piecesTable[#piecesTable+1]= Window070
 Window071 = piece("Window071")
 piecesTable[#piecesTable+1]= Window071
 Window072 = piece("Window072")
 piecesTable[#piecesTable+1]= Window072
 Window073 = piece("Window073")
 piecesTable[#piecesTable+1]= Window073
 Window074 = piece("Window074")
 piecesTable[#piecesTable+1]= Window074
 Window075 = piece("Window075")
 piecesTable[#piecesTable+1]= Window075
 Window076 = piece("Window076")
 piecesTable[#piecesTable+1]= Window076
 Window077 = piece("Window077")
 piecesTable[#piecesTable+1]= Window077
 Window078 = piece("Window078")
 piecesTable[#piecesTable+1]= Window078
 Window079 = piece("Window079")
 piecesTable[#piecesTable+1]= Window079
 Window080 = piece("Window080")
 piecesTable[#piecesTable+1]= Window080
 Window081 = piece("Window081")
 piecesTable[#piecesTable+1]= Window081
 Window082 = piece("Window082")
 piecesTable[#piecesTable+1]= Window082
 Window083 = piece("Window083")
 piecesTable[#piecesTable+1]= Window083
 Window084 = piece("Window084")
 piecesTable[#piecesTable+1]= Window084
 Window085 = piece("Window085")
 piecesTable[#piecesTable+1]= Window085
 Window086 = piece("Window086")
 piecesTable[#piecesTable+1]= Window086



TablesOfPiecesGroups={}
StompTable={}
StompBaseTable={}
WindowTable={}
function script.HitByWeapon ( x, z, weaponDefID, damage ) 

center=piece"center"

end

function stompBases()
	while true do 
			for i=1,#StompBaseTable do
			Move(StompBaseTable[i],y_axis,-5,5)
			Move(StompTable[i],y_axis,20,5)
			end
		WaitForMove(StompBaseTable[1],y_axis)
		WaitForMove(StompTable[1],y_axis)
			for i=1,#StompBaseTable do
			Move(StompBaseTable[i],y_axis,9,5)
			Move(StompTable[i],y_axis,0,5)
			end
		WaitForMove(StompBaseTable[1],y_axis)

		Sleep(250)
	end

end

function script.Create()
	generatepiecesTableAndArrayCode(unitID)
	TablesOfPiecesGroups=makePiecesTablesByNameGroups(false,true)
	WindowTable=TablesOfPiecesGroups["Window"]
	StompBaseTable=TablesOfPiecesGroups["StompBase"]
	StompTable=TablesOfPiecesGroups["Stomp"]
	StartThread(randomBlink)
	--StartThread(buildOS)
	StartThread(stompBases)
end

function unfold	(buildProgress)			  
speed= 50 *buildProgress/15
	if boolDirection== true then --unfold

		return CurrentStat,Instate, boolLoop 
	 else 
	 
	  return CurrentStat,Instate, boolLoop 
	  end
end	 
 
 
function eggDeploy(buildProgress)			 
 return CurrentStat,Instate, boolLoop 
end 


function pumpUp		(buildProgress)		  
 return CurrentStat,Instate, boolLoop 
 end
function implantInsertion(buildProgress)	  
 return CurrentStat,Instate, boolLoop 
 end
function SewUp			(buildProgress)	 
 return CurrentStat,Instate, boolLoop 
 end
function PumpedDown			(buildProgress)  
 return CurrentStat,Instate, boolLoop 
 end
function Release		(buildProgress)	  
 return CurrentStat,Instate, boolLoop 
 end

function Loopunfold(buildProgress)				 
 end
function LoopeggDeploy			 (buildProgress)
 end
function LooppumpUp				 (buildProgress)
 end
function LoopimplantInsertion	 (buildProgress)
 end
function LoopSewUp				 (buildProgress)
 end
function LoopPumpedDown			 (buildProgress)	
 end
function LoopRelease			 (buildProgress)
 end

StableLoopTable={
[1]=  Loopunfold				 ,
[2]=  LoopeggDeploy			 ,
[3]=  LooppumpUp				 ,
[4]=  LoopimplantInsertion	 ,
[5]=  LoopSewUp				 ,
[6]=  LoopPumpedDown			 ,
[7]=  LoopRelease			 ,


}

UnfoldAnimationTable={
[1]=  unfold				  ,
[2]=  eggDeploy			 ,
[3]=  pumpUp				  ,
[4]=  implantInsertion	  ,
[5]=  SewUp				 ,
[6]=  PumpedDown			  ,
[7]=  Release			   
}


boolBuilding=false
progress=0



function BuildingAnimation(buildID,boolDirection)
	if buildID then
		Spring.SetUnitAlwaysVisible(buildID,false)
	end
	
CurrentStat=1
Instate=1
	while boolBuilding==true do
	roGress=math.ceil(100*progress)
	
	CurrentStat,Instate, boolLoop=UnfoldAnimationTable[CurrentStat](roGress,boolDirection,Instate)
		if boolLoop and boolDirection == true then 
			StableLoopTable[CurrentStat](roGress)
		
		end
		
	if buildID then
		Spring.SetUnitAlwaysVisible(buildID,true)
	end
	
	Sleep(10)
	end


 end 
 
 
 function buildOS()
--TestLoop
	StartThrad(BuildingAnimation, buildID,false)
	while true do 
	progress=0
	StartThrad(BuildingAnimation, buildID,true)
	
		for i=1,100 do
		progress=i/100
		Sleep(2000)
		end
	Sleep(5000)
		StartThrad(BuildingAnimation, buildID,false)
	end

			while true do
			buildID=Spring.GetUnitIsBuilding(unitID)
				if buildID  then 
				boolBuilding=true
				progress=0
				StartThrad(BuildingAnimation, buildID,false)
				
				--building something
					while  Spring.ValidUnitID(buildID)==true and progress < 1 do
						hp,progress=Spring.GetUnitHealth(buildID)
						
					Sleep(100)
					end
				boolBuilding=false
				end
			Sleep(500)
			end
			



 end 
 
 function randomBlink()
	hideT(WindowTable)
		for i=1,#WindowTable do
			if i%2==0 then Show(WindowTable[i]) end
		end
		itterate=0.1

			while true do
			itterate=itterate+0.1
			changeVal=math.ceil(math.random(2,42))
			ignoreVal=math.ceil(math.random(2,6))
			
			time=math.ceil(math.abs(1+math.ceil(1100+math.sin(itterate)*100)))
			Sleep(time)
				for i=1,#WindowTable-1,1 do
					if i% ignoreVal==0 or  i% changeVal ~= 0 then
						Show(WindowTable[i]) 
						Hide(WindowTable[i+1]) 
					elseif i% changeVal == 0 then
						Hide(WindowTable[i]) 
						Show(WindowTable[i+1]) 
					else
					
					end
				end
			end

 end 
 
 function script.Killed(recentDamage,_)

suddenDeathV(recentDamage)
return 1
end


----aimining & fire weapon

 
 function script.AimFromWeapon1() 
	return center 
end




 
 function script.QueryWeapon1() 
	return center
end


 
 function script.AimWeapon1( Heading ,pitch)	
	--aiming animation: instantly turn the gun towards the enemy

	return true
end

 


 
 function script.FireWeapon1()	

	return true
end




 




 function script.Activate()

return 1
end


 
 function script.Deactivate()

return 0
end


 
 function script.QueryBuildInfo() 
  return center 
end

Spring.SetUnitNanoPieces(unitID,{ center})