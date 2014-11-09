--<pieces>
cubes={}
outerCubes={}
totalCubes=588

for i=1,totalCubes,1 do
cubes[i]={}
outerCubes[i]={}
piecenameOne="Cube"..i
piecenameTwo="ShellC"..i
cubes[i]=piece(piecenameOne)outerCubes[i]=piece(piecenameTwo)
end

--</pieces>
------------------------------------------------
masterTable={}
--<storageOfBuildPlans>
subTable={}
--table[1]=UnitDefID
subTable[1]=UnitDefNames["citadell"].id
--table[2]=(boolArray)buildPlan
subTable[2]={
true,true,true,true,true,true,true,
true,true,true,true,true,true,true,
true,true,false,false,false,true,true,
true,true,false,false,false,true,true,
true,true,false,false,false,true,true,
true,true,false,true,true,true,true,
true,true,true,true,true,true,true,

true,true,true,false,true,true,true,
true,true,false,false,false,true,true,
true,false,false,false,false,false,true,
false,false,false,false,false,false,false,
true,false,false,false,false,false,true,
true,true,false,false,false,true,true,
true,true,true,false,true,true,true,

false,false,false,false,false,false,false,
false,true,false,false,false,true,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,true,false,false,false,true,false,
false,false,false,false,false,false,false,

}
subTable[3]=nil
subTable[4]=500
subTable[5]=true
subTable[6]=67
subTable[7]="citadell" --testmessage
masterTable[1]=subTable
-------------------------------------------------------------------------


subTable={}
--table[1]=UnitDefID
subTable[1]=UnitDefNames["buibaicity2"].id
--table[2]=(boolArray)buildPlan
subTable[2]={
true,true,true,true,true,true,true,
true,true,true,true,true,true,true,
true,true,true,true,true,true,true,
true,true,true,true,true,true,true,
true,true,true,true,true,true,true,
true,true,true,true,true,true,true,
true,true,true,true,true,true,true,

false,false,false,false,false,false,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,false,false,false,false,false,false,

false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,true,true,true,false,false,
false,false,true,true,true,false,false,
false,false,true,true,true,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,


false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,true,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
}
subTable[3]="cdecFactoryStreetBig"
subTable[4]=380
subTable[5]=true
subTable[6]=84
subTable[7]="buibait2" --testmessage
masterTable[2]=subTable
-------------------------------------------------------------------------
--table[3]=(string) DecalUnit --nil if no decal
--table[4]=rangeOfGrass 
--table[5]=grassRemove
--table[6]=totalNrOfCubes
-------------------------------------------------------------------------


subTable={}
--table[1]=UnitDefID
subTable[1]=UnitDefNames["mbuilux"].id
--table[2]=(boolArray)buildPlan
subTable[2]={
false,false,false,false,false,false,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,false,false,false,false,false,false,

false,false,false,false,false,false,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,false,false,false,false,false,false,


false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,true,true,true,false,false,
false,false,true,true,true,false,false,
false,false,true,true,true,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,


false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,true,true,true,false,false,
false,false,true,true,true,false,false,
false,false,true,true,true,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,



false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,true,true,true,false,false,
false,false,true,true,true,false,false,
false,false,true,true,true,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,

false,false,false,false,false,false,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,false,false,false,false,false,false,

false,false,false,false,false,false,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,false,false,false,false,false,false,

false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,true,true,true,false,false,
false,false,true,true,true,false,false,
false,false,true,true,true,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,

false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,true,true,true,false,false,
false,false,true,true,true,false,false,
false,false,true,true,true,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,

false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,true,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
}
subTable[3]="cdecFactoryStreetSmall"
subTable[4]=180
subTable[5]=true
subTable[6]=146
subTable[7]="mohobuilux" --testmessage
masterTable[3]=subTable
-------------------------------------------------------------------------
--table[3]=(string) DecalUnit --nil if no decal
--table[4]=rangeOfGrass 
--table[5]=grassRemove
--table[6]=totalNrOfCubes


subTable={}
--table[1]=UnitDefID
subTable[1]=UnitDefNames["builux"].id
--table[2]=(boolArray)buildPlan
subTable[2]={
false,false,false,false,false,false,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,false,false,false,false,false,false,

false,false,false,false,false,false,false,
false,false,true,true,true,false,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,false,true,true,true,false,false,
false,false,false,false,false,false,false,


false,false,false,false,false,false,false,
false,false,false,true,false,false,false,
false,false,true,true,true,false,false,
false,false,true,true,true,false,false,
false,false,true,true,true,false,false,
false,false,false,true,false,false,false,
false,false,false,false,false,false,false,


false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,true,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,


}
subTable[3]="cdecFactoryStreetSmall"
subTable[4]=180
subTable[5]=true
subTable[6]=58
subTable[7]="builux" --testmessage
masterTable[4]=subTable
-------------------------------------------------------------------------
--table[3]=(string) DecalUnit --nil if no decal
--table[4]=rangeOfGrass 
--table[5]=grassRemove
--table[6]=totalNrOfCubes

subTable={}
--table[1]=UnitDefID
subTable[1]=UnitDefNames["scumslum"].id
--table[2]=(boolArray)buildPlan
subTable[2]={
false,false,false,false,false,false,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,false,false,false,false,false,false,

false,false,false,false,false,false,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,false,false,false,false,false,false,

false,false,false,false,false,false,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,false,false,false,false,false,false,

false,false,false,false,false,false,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,false,false,false,false,false,false,
}
subTable[3]=nil
subTable[4]=100
subTable[5]=true
subTable[6]=100
subTable[7]="scumslum" --testmessage
masterTable[5]=subTable
-------------------------------------------------------------------------
--table[3]=(string) DecalUnit --nil if no decal
--table[4]=rangeOfGrass 
--table[5]=grassRemove
--table[6]=totalNrOfCubes

subTable={}
--table[1]=UnitDefID
subTable[1]=UnitDefNames["cwaterextractor"].id
--table[2]=(boolArray)buildPlan
subTable[2]={
false,false,false,false,false,false,false,
false,false,true,false,true,false,false,
false,true,true,true,true,true,false,
false,false,true,true,true,false,false,
false,true,true,true,true,true,false,
false,false,true,false,true,false,false,
false,false,false,false,false,false,false,

false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,true,false,true,false,false,
false,false,false,true,false,false,false,
false,false,true,false,true,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,


false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,true,false,true,false,false,
false,false,false,true,false,false,false,
false,false,true,false,true,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,

false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,true,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,


false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,true,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,


}
subTable[3]=nil
subTable[4]=80
subTable[5]=true
subTable[6]=29
subTable[7]="cwaterextractor" --testmessage
masterTable[6]=subTable
-------------------------------------------------------------------------
--table[3]=(string) DecalUnit --nil if no decal
--table[4]=rangeOfGrass 
--table[5]=grassRemove
--table[6]=totalNrOfCubes
-------------------------------------------------------------------------
--table[3]=(string) DecalUnit --nil if no decal
--table[4]=rangeOfGrass 
--table[5]=grassRemove
--table[6]=totalNrOfCubes

subTable={}
--table[1]=UnitDefID
subTable[1]=UnitDefNames["buibaicity1"].id
--table[2]=(boolArray)buildPlan
subTable[2]={
false,false,false,false,false,false,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,false,false,false,false,false,false,

false,false,false,false,false,false,false,
false,true,true,true,true,true,false,
false,true,false,false,false,true,false,
false,true,false,false,false,true,false,
false,true,false,false,false,true,false,
false,true,true,true,true,true,false,
false,false,false,false,false,false,false,

false,false,false,false,false,false,false,
false,true,false,true,false,true,false,
false,false,false,false,false,false,false,
false,true,false,false,false,false,false,
false,false,false,false,false,false,false,
false,true,false,true,false,true,false,
false,false,false,false,false,false,false,

false,false,false,false,false,false,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,false,false,false,false,false,false,

false,false,false,false,false,false,false,
false,true,false,true,false,true,false,
false,false,false,false,false,false,false,
false,true,false,false,false,false,false,
false,false,false,false,false,false,false,
false,true,false,true,false,true,false,
false,false,false,false,false,false,false,





false,false,false,false,false,false,false,
false,true,false,true,false,true,false,
false,false,false,false,false,false,false,
false,true,false,false,false,false,false,
false,false,false,false,false,false,false,
false,true,false,true,false,true,false,
false,false,false,false,false,false,false,



false,false,false,false,false,false,false,
false,true,false,true,false,true,false,
false,false,false,false,false,false,false,
false,true,false,false,false,false,false,
false,false,false,false,false,false,false,
false,true,false,true,false,true,false,
false,false,false,false,false,false,false,

false,false,false,false,false,false,false,
false,true,false,true,false,true,false,
false,false,false,false,false,false,false,
false,true,false,false,false,false,false,
false,false,false,false,false,false,false,
false,true,false,true,false,true,false,
false,false,false,false,false,false,false,



false,false,false,false,false,false,false,
false,true,false,true,false,true,false,
false,false,false,false,false,false,false,
false,true,false,false,false,false,false,
false,false,false,false,false,false,false,
false,true,false,true,false,true,false,
false,false,false,false,false,false,false,

false,false,false,false,false,false,false,
false,true,false,true,false,true,false,
false,false,false,false,false,false,false,
false,true,false,false,false,false,false,
false,false,false,false,false,false,false,
false,true,false,true,false,true,false,
false,false,false,false,false,false,false,

false,false,false,false,false,false,false,
false,true,false,true,false,true,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,true,false,true,false,true,false,
false,false,false,false,false,false,false,


false,false,false,false,false,false,false,
false,true,false,true,false,true,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,true,false,true,false,true,false,
false,false,false,false,false,false,false,

}
subTable[3]="cdecFactoryStreetSmall"
subTable[4]=40
subTable[5]=true
subTable[6]=127
subTable[7]="buibaicity1" --testmessage
masterTable[7]=subTable
-------------------------------------------------------------------------
subTable={}
--table[1]=UnitDefID
subTable[1]=UnitDefNames["campole"].id
--table[2]=(boolArray)buildPlan
subTable[2]={
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,true,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,

false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,true,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,

false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,true,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,

}
subTable[3]=nil
subTable[4]=50
subTable[5]=true
subTable[6]=3
subTable[7]="campole" --testmessage
masterTable[8]=subTable
-------------------------------------------------------------------------
-------------------------------------------------------------------------
subTable={}
--table[1]=UnitDefID
subTable[1]=UnitDefNames["condepot"].id
--table[2]=(boolArray)buildPlan
subTable[2]={
false,false,false,false,false,false,false,
false,true,false,true,false,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,false,true,false,true,false,
false,false,false,false,false,false,false,

false,false,false,false,false,false,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,false,false,false,false,false,false,

false,false,false,false,false,false,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,false,false,false,false,false,false,

true,true,false,false,false,true,true,
true,true,true,true,true,true,true,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
true,true,true,true,true,true,true,
true,true,false,false,false,true,true,

false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,true,true,true,false,false,
false,false,true,true,true,false,false,
false,false,true,true,true,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,

false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,true,true,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,




}
subTable[3]=nil
subTable[4]=50
subTable[5]=true
subTable[6]=119
subTable[7]="condepot" --testmessage
masterTable[9]=subTable
-------------------------------------------------------------------------
subTable={}
--table[1]=UnitDefID
subTable[1]=UnitDefNames["fclvlone"].id
--table[2]=(boolArray)buildPlan
subTable[2]={
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,



false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,true,true,true,false,false,
false,false,true,false,true,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,



false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,true,false,true,false,false,
false,false,true,false,true,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,

false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,true,false,true,false,false,
false,false,true,false,true,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,

false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,true,false,false,false,false,
false,false,true,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,

false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,true,false,false,false,false,
false,false,true,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
}
subTable[3]=nil
subTable[4]=50
subTable[5]=true
subTable[6]=52
subTable[7]="fclvlone" --testmessage
masterTable[10]=subTable
-------------------------------------------------------------------------
-------------------------------------------------------------------------
subTable={}
--table[1]=UnitDefID
subTable[1]=UnitDefNames["fclvl2"].id
--table[2]=(boolArray)buildPlan
subTable[2]={
true,true,true,false,true,true,true,
false,true,true,false,true,true,false,
false,true,true,false,true,true,true,
true,true,true,false,true,true,false,
false,true,true,true,true,true,true,
true,true,true,true,true,true,true,
true,true,true,true,true,true,true,



false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,true,true,false,true,false,false,
false,false,true,true,true,false,false,
false,false,false,false,false,false,false,



false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,true,false,true,false,false,
false,false,true,true,true,false,false,
false,false,false,false,false,false,false,

false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,true,false,true,false,false,
false,false,true,false,true,false,false,
false,false,false,false,false,false,false,

false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,true,false,true,false,false,
false,false,true,false,true,false,false,
false,false,false,false,false,false,false,

false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,true,false,true,false,false,
false,false,true,false,true,false,false,
false,false,false,false,false,false,false,

false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,true,false,true,false,false,
false,false,true,false,true,false,false,
false,false,false,false,false,false,false,

false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,true,false,true,false,false,
false,false,true,false,true,false,false,
false,false,false,false,false,false,false,

false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,true,false,true,false,false,
false,false,true,false,true,false,false,
false,false,false,false,false,false,false,

false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,true,false,true,false,false,
false,false,true,false,true,false,false,
false,false,false,false,false,false,false,

false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,true,false,true,false,false,
false,false,true,false,true,false,false,
false,false,false,false,false,false,false,



}
subTable[3]=nil
subTable[4]=500
subTable[5]=true
subTable[6]=83
subTable[7]="fclvl2" --testmessage
masterTable[11]=subTable
-------------------------------------------------------------------------
-------------------------------------------------------------------------
subTable={}
--table[1]=UnitDefID
subTable[1]=UnitDefNames["efence"].id
--table[2]=(boolArray)buildPlan
subTable[2]={



false,false,false,true,false,false,false,
false,false,false,true,false,false,false,
false,false,false,true,false,false,false,
true,true,true,true,true,true,true,
false,false,false,true,false,false,false,
false,false,false,true,false,false,false,
false,false,false,true,false,false,false,

false,false,false,true,false,false,false,
false,false,false,true,false,false,false,
false,false,false,true,false,false,false,
true,true,true,true,true,true,true,
false,false,false,true,false,false,false,
false,false,false,true,false,false,false,
false,false,false,true,false,false,false,




}
subTable[3]=nil
subTable[4]=1
subTable[5]=false
subTable[6]=26
subTable[7]="efence" --testmessage
masterTable[12]=subTable
-------------------------------------------------------------------------
-------------------------------------------------------------------------
subTable={}
--table[1]=UnitDefID
subTable[1]=UnitDefNames["crailgun"].id
--table[2]=(boolArray)buildPlan
subTable[2]={



false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,true,false,false,false,
false,false,true,true,true,false,false,
false,false,false,true,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,

false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,true,true,true,false,false,
false,false,true,true,true,false,false,
false,false,true,true,true,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,




}
subTable[3]=nil
subTable[4]=1
subTable[5]=false
subTable[6]=14
subTable[7]="efence" --testmessage
masterTable[13]=subTable
-------------------------------------------------------------------------
-------------------------------------------------------------------------
subTable={}
--table[1]=UnitDefID
subTable[1]=UnitDefNames["bbind"].id
--table[2]=(boolArray)buildPlan
subTable[2]={

true,true,true,true,true,true,true,
true,true,true,true,true,true,true,
true,true,true,true,true,true,true,
true,true,true,true,true,true,true,
true,true,true,true,true,true,true,
true,true,true,true,true,true,true,
true,true,true,true,true,true,true,

true,true,true,true,true,true,true,
true,true,true,true,true,true,true,
true,true,true,true,true,true,true,
true,true,true,true,true,true,true,
true,true,true,true,true,true,true,
true,true,true,true,true,true,true,
true,true,true,true,true,true,true,

true,true,true,true,true,true,true,
true,true,true,true,true,true,true,
true,true,true,true,true,true,true,
true,true,true,true,true,true,true,
true,true,true,true,true,true,true,
true,true,true,true,true,true,true,
true,true,true,true,true,true,true,

true,true,true,true,true,true,true,
true,true,true,true,true,true,true,
true,true,true,true,true,true,true,
true,true,true,true,true,true,true,
true,true,true,true,true,true,true,
true,true,true,true,true,true,true,
true,true,true,true,true,true,true,

true,true,true,true,true,true,true,
true,true,true,true,true,true,true,
true,true,true,true,true,true,true,
true,true,true,true,true,true,true,
true,true,true,true,true,true,true,
true,true,true,true,true,true,true,
true,true,true,true,true,true,true,




}
subTable[3]="bbinddecalfactory"
subTable[4]=1
subTable[5]=false
subTable[6]=245
subTable[7]="bbind" --testmessage
masterTable[14]=subTable
-------------------------------------------------------------------------
-------------------------------------------------------------------------
--table[3]=(string) DecalUnit --nil if no decal
--table[4]=rangeOfGrass 
--table[5]=grassRemove
--table[6]=totalNrOfCubes

subTable={}
--table[1]=UnitDefID
subTable[1]=UnitDefNames["mestorage"].id
--table[2]=(boolArray)buildPlan
subTable[2]={
false,false,false,true,false,false,false,
false,false,false,true,false,false,false,
false,false,true,true,true,false,false,
false,false,true,true,true,false,false,
false,false,true,true,true,false,false,
false,false,true,true,true,false,false,
false,false,false,true,false,false,false,


false,false,false,true,false,false,false,
false,false,false,true,false,false,false,
false,false,true,true,true,false,false,
false,false,true,true,true,false,false,
false,false,true,true,true,false,false,
false,false,true,true,true,false,false,
false,false,false,true,false,false,false,


false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,true,true,true,false,false,
false,false,true,true,true,false,false,
false,false,true,true,true,false,false,
false,false,true,true,true,false,false,
false,false,false,false,false,false,false,


false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,true,false,false,false,
false,false,false,true,false,false,false,
false,false,false,true,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,


false,false,false,false,false,false,false,
false,true,false,false,false,true,false,
false,false,false,true,false,false,false,
false,false,false,true,false,false,false,
false,true,false,true,false,true,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,

false,false,false,false,false,false,false,
false,true,false,false,false,true,false,
false,false,false,true,false,false,false,
false,false,false,true,false,false,false,
false,true,false,true,false,true,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,


false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,

false,false,false,false,false,false,false,
false,true,false,false,false,true,false,
false,false,false,true,false,false,false,
false,false,false,true,false,false,false,
false,true,false,true,false,true,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,

false,false,false,false,false,false,false,
false,true,false,false,false,true,false,
false,false,false,true,false,false,false,
false,false,false,true,false,false,false,
false,true,false,true,false,true,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,


false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,true,false,false,false,
false,false,false,true,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,


false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,true,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
}
subTable[3]="cdecFactoryStreetSmall"
subTable[4]=160
subTable[5]=true
subTable[6]=111
subTable[7]="mestorage" --testmessage
masterTable[15]=subTable
-------------------------------------------------------------------------
-------------------------------------------------------------------------


subTable={}
--table[1]=UnitDefID
subTable[1]=UnitDefNames["cairbase"].id
--table[2]=(boolArray)buildPlan
subTable[2]={
false,false,false,false,false,false,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,false,false,false,false,false,false,

false,false,false,false,false,false,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,true,true,true,true,true,false,
false,false,false,false,false,false,false,

false,false,false,false,false,false,false,
false,true,true,true,true,true,false,
false,true,false,false,false,true,false,
false,true,false,false,false,true,false,
false,true,false,false,false,true,false,
false,true,true,true,true,true,false,
false,false,false,false,false,false,false,


false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
false,false,false,false,false,false,false,
}
subTable[3]="cdecFactoryStreetSmall"
subTable[4]=22
subTable[5]=true
subTable[6]=66
subTable[7]="cairbase" --testmessage
masterTable[16]=subTable
-------------------------------------------------------------------------
--</storageOfBuildPlans>

comonBuildSpeed=0.1

maxBuildSpeed=25
boolUnitIsUnidentified=true
boolBuildAnimationStarted=false
boolDecalSpawned=false

masterTableKey=0
local buildID=0

buildprogress=nil
allreadyStarted=0
currentlyWorkedOn=0

function allDoneCheckIn()
currentlyWorkedOn=currentlyWorkedOn+1
end
function allDoneCheckOut()
currentlyWorkedOn=currentlyWorkedOn-1
end
function alldone()
	if currentlyWorkedOn== 0 then
	return true
		else
		return false
		end
end

function moveInStepCrap(nr,boolAxisY,distanceX,distanceY,distanceZ)

local spIsInMove=Spring.UnitScript.IsInMove
	 if boolAxisY== false then
	 comonBuildSpeedtemp=comonBuildSpeed
		Move(cubes[nr],x_axis,0,comonBuildSpeed)
		Move(outerCubes[nr],x_axis,0,comonBuildSpeed)
		Move(cubes[nr],z_axis,0,comonBuildSpeed)
		Move(outerCubes[nr],z_axis,0,comonBuildSpeed)
		while (((true==spIsInMove(cubes[nr], x_axis)) or (true==spIsInMove(cubes[nr], z_axis)))and booleanThreadKiller[nr]==true) do
			 while (comonBuildSpeed == comonBuildSpeedtemp and booleanThreadKiller[nr]==true)do
			 --Sleep(while buildspeed remains unchanged
			 rando=math.ceil(math.random(200,900))
			 Sleep(rando)
			 end
		--else update comonBuildSpeedtemp and issue new comand
		comonBuildSpeedtemp=comonBuildSpeed
			Move(cubes[nr],x_axis,0,comonBuildSpeed)
			Move(outerCubes[nr],x_axis,0,comonBuildSpeed)
			Move(cubes[nr],z_axis,0,comonBuildSpeed)
			Move(outerCubes[nr],z_axis,0,comonBuildSpeed)
		
		 end
		 	WaitForMove(cubes[nr],x_axis)
			WaitForMove(outerCubes[nr],x_axis)
			WaitForMove(cubes[nr],z_axis)
			WaitForMove(outerCubes[nr],z_axis)
		 
		elseif boolAxisY== true then
			Move(cubes[nr],y_axis,0,comonBuildSpeed)
			while (true==spIsInMove(cubes[nr], y_axis))  do
					 while comonBuildSpeed== comonBuildSpeedtemp do
					 --Sleep(while buildspeed remains unchanged
						 rando=math.ceil(math.random(200,900))
						 Sleep(rando)
					 end
				--else update comonBuildSpeedtemp and issue new comand
				comonBuildSpeedtemp=comonBuildSpeed
					Move(cubes[nr],y_axis,0,comonBuildSpeed)
					Move(outerCubes[nr],y_axis,0,comonBuildSpeed)
					
				 end
				 --MODIEFIED
					WaitForMove(cubes[nr],y_axis)
					WaitForMove(outerCubes[nr],y_axis)
				
	
	
		end



end
booleanThreadKiller={}
function moveCubeThread(nr, masterTableKey)
allDoneCheckIn()
--assert(nr)
howDeepY,howFarOutX,howFarOutZ=0
currentMoveTargetX,currentMoveTargetY,currentMoveTargetZ=0
howDeepY=((nr/49)+1)*-33

howFarOutX=math.random(-350,350)
howFarOutZ=math.random(-350,350)

--MoveDownAndOut --33
Move(cubes[nr],y_axis,howDeepY,0)
Move(outerCubes[nr],y_axis,howDeepY,0)

Move(cubes[nr],x_axis,howFarOutX,0)
Move(outerCubes[nr],x_axis,howFarOutX,0)

Move(cubes[nr],z_axis,howFarOutZ,0)
Move(outerCubes[nr],z_axis,howFarOutZ,0)
--circle the Movement in smallSteps, updating the MoveSpeed
Show(cubes[nr])
showCubes=math.random(0,2)
Move(cubes[nr],y_axis,howDeepY+33,comonBuildSpeed)
WaitForMove(cubes[nr],y_axis)
	if showCubes== 1 then
	Show(outerCubes[nr])
	end
booleanThreadKiller[nr]={}	
booleanThreadKiller[nr]=true	
StartThread(moveInStepCrap,nr,false,howFarOutX,howDeepY,howFarOutZ)
ranDistrib=math.ceil(math.random(11000,19000))
Sleep(ranDistrib)
booleanThreadKiller[nr]=false	
moveInStepCrap(nr,true,howFarOutX,howDeepY,howFarOutZ)
allDoneCheckOut()
end

function timeDelayedSelfDestruction()
Sleep(180000)
Spring.DestroyUnit(unitID,false,true)

end

boolOnlyOnceSelfD=true
function updateBuildProgress(buildID)
while buildID == nil do
_,_,buildID=identifyUnit()
Sleep(200)
end
 _,_,_,_,bP= Spring.GetUnitHealth(buildID)

	 if bP== nil then
		it=0
		while( it < 4 ) do
		 _,_,_,_,bP=Spring.GetUnitHealth(buildID)
		 Sleep(100)
		it=it+1
		end
		
		if bP== nil then bP=0.9 end
	end
--Ch-cha-changes- DelMe if nonworking


 buildprogress=bP
 
	 if bP== 1.0 and boolOnlyOnceSelfD== true then --recentIndecent Change
	 boolOnlyOnceSelfD=false
	 StartThread( timeDelayedSelfDestruction) 
	 end 											--/recentIndecent Change
end

function getUpdatedProgress()
if buildprogress == nil and Spring.ValidUnitID(buildID) == false then
Spring.DestroyUnit(unitID,false,true)	
	else
	
	return buildprogress
	end
end

function parseTableForNext(nRofCube,masterTableKey)
local countBool=0

	for i=1,totalCubes,1 do
			if masterTable[masterTableKey][2][i]==true then
			countBool=countBool+1
				if countBool==nRofCube then
				return i
				end

			end
	end
	return totalCubes
end


function buildAnimation(buildID,masterTableKey)
--assert(buildID)
--assert(masterTableKey)
--buildprogress=0
--allreadyStarted=0
local lidentifyUnit=identifyUnit
local lupdateBuildProgress=updateBuildProgress
local lparseTableForNext=parseTableForNext
while(masterTableKey==nil or buildprogress== nil ) do --modifyID
------Spring.Echo("HangOverHere1")

Sleep(30)
masterTableKey,_,buildID=lidentifyUnit()
	if buildID~=nil then
		lupdateBuildProgress(buildID)
	end
end

cubeMax=masterTable[masterTableKey][6]
cubeCost=1/588
atLeastThreeCircles=0


	while buildprogress ~= nil and buildprogress < 1 or buildID~=nil and atLeastThreeCircles < 29 do
	------Spring.Echo("HangOverHere2")
	lupdateBuildProgress(buildID)

		cubeShall=math.ceil(buildprogress*588)
		cubeIsm=cubeCost*allreadyStarted
				if (cubeShall-cubeIsm) > cubeCost then
				howMany=math.floor((cubeShall-cubeIsm)+0.5)
				tempTarg=allreadyStarted+howMany
				if tempTarg > 588 then tempTarg=588 end
				--assert(tempTarg)
				--assert(howMany)
				--assert(allreadyStarted)
					for i=allreadyStarted,tempTarg, 1 do
					itterator= lparseTableForNext(i,masterTableKey)
					----Spring.Echo("CbuildAnim::Starting Cube Nr  "..i)
					StartThread(moveCubeThread,itterator,masterTableKey)
					allreadyStarted=allreadyStarted+1
					end
				
			
				end
				
			if buildprogress== 1 then
			--------Spring.Echo(atLeastThreeCircles)
			atLeastThreeCircles=atLeastThreeCircles+1
			end
		

	
	Sleep(300)
	end
Sleep(12000)
foollHouse=0
tit_O_Rator=1
local lEmitSfx= EmitSfx
local lExplode=Explode

while(foollHouse < (masterTable[masterTableKey][6])-1) do 
	if masterTable[masterTableKey][2][tit_O_Rator] == true  then
		oneInThree=math.random(0,6)
		if oneInThree~= 1 then
		lEmitSfx((cubes[tit_O_Rator]),1024)
		else
		lExplode((cubes[tit_O_Rator]),SFX.NO_HEATCLOUD+SFX.SHATTER)
		end
		
			if foollHouse % 5 == 0 then
			Sleep(500)
			end
	Hide(cubes[tit_O_Rator])
	Hide(outerCubes[tit_O_Rator])
	foollHouse=foollHouse+1
	tit_O_Rator=tit_O_Rator+1
		else
		tit_O_Rator=tit_O_Rator+1
		end
		Sleep(50)
end
--destroy the cubes, kill the unit
--TODO Moar Advanced Murdering Effects
Spring.DestroyUnit(unitID,false,false)


end

function updateComonBuildSpeed()
	if buildprogress~=nil and buildprogress ~= 0 and buildprogress ~= 1 then 
	comonBuildSpeed=(buildprogress+0.4)*maxBuildSpeed
	else
	comonBuildSpeed=(1.4)*maxBuildSpeed
	end
end

function spawnDecal(unitname)
x,y,z=Spring.GetUnitPosition(unitID)
teamID=Spring.GetUnitTeam(unitID)

if GG.UnitsToSpawn== nil then GG.UnitsToSpawn ={} end
GG.UnitsToSpawn:PushCreateUnit(masterTable[masterTableKey][3],x,y,z,0,teamID)

--Spring.CreateUnit((masterTable[masterTableKey][3]),x,y,z,0,teamID)
end

function identifyUnit()
searchRange=15
x,y,z=Spring.GetUnitPosition(unitID)
TableTop={}
TableTop=Spring.GetUnitsInCylinder(x,z,searchRange)
table.remove(TableTop,unitID)
--itterate throught table, searching a familiar building
if TableTop == nil then
return _,true,_
end

boolFoundNothing=true
nrOfInterest=nil
tableKey=nil
	for i=1,table.getn(TableTop),1 do
	tempDefID=Spring.GetUnitDefID(TableTop[i])
		for a=1,table.getn(masterTable),1 do
			if masterTable[a][1]==tempDefID then
			boolFoundNothing=false
			nrOfInterest=i
			tableKey=a
			end
		end
	end
if boolFoundNothing== true then
return _,true,_
else
--------Spring.Echo(masterTable[tableKey][7])
return tableKey,false, TableTop[nrOfInterest]
end

end

function isUnitValid()
--Destroys the BuildAnimation Unit should the building cease to exist
		if Spring.ValidUnitID(buildID) == false then
		Spring.DestroyUnit (unitID,false,false)
		end
end

function timeDelayedSound()
Sleep(10000)
	for i=1,5,1 do
	rando=math.random(0,1)
		if rando==1 then
		Spring.PlaySoundFile("sounds/cbuiblox/cbuild1.wav")
		end

	Sleep(10000)
	rando=math.random(0,1)
		if rando==1 then
		Spring.PlaySoundFile("sounds/cbuiblox/cbuild2.wav")
		end
	end
end
everyThird=0
geigercounter=0
function wizzardryOfOSLoop ()
StartThread(timeDelayedSelfDestruction)
local lidentifyUnit=identifyUnit
local spRemoveGrass=Spring.RemoveGrass
local lupdateBuildProgress=updateBuildProgress
local lupdateComonBuildSpeed=updateComonBuildSpeed
local spGetUnitPosition=Spring.GetUnitPosition

	while(true) do
	------Spring.Echo("HangOverHere3")
	--identify Unit
	
	-------------------------------------------------------------------------------------------------------- INIT
		if boolBuildAnimationStarted== false then
		------Spring.Echo("HangOverHere4")
			if boolUnitIsUnidentified== true then
			  masterTableKey,boolUnitIsUnidentified,buildID=identifyUnit()
			  geigercounter=geigercounter+1
			  if geigercounter== 10 then
			  Spring.DestroyUnit (unitID,true,true)	
			  end
			  
			else
				  --------Spring.Echo("We found us something")
				  if  masterTable[masterTableKey][3] ~= nil then
				  spawnDecal(masterTableKey)
				  --spawned a decal --TODO --DODO is extinct
				  end	
				  --mow the grass--TODO --DODO is extinct
				  if masterTable[masterTableKey][5]== true then
				   --------Spring.Echo("Manchmal muss einer ins Grass beissen")
					x,y,z=spGetUnitPosition(unitID)
					startX=x-masterTable[masterTableKey][4]
					endX=x+masterTable[masterTableKey][4]
					startZ=z-masterTable[masterTableKey][4]
					endZ=z+masterTable[masterTableKey][4]
						for i=startX,endX,1 do
							for o=startZ,endZ,1 do
							spRemoveGrass( i,  y, o )
							
							end
						end


				
					end
					--and now we start the buildAnimation depending on 
					if boolBuildAnimationStarted == false then
					------Spring.Echo("HangOverHere5")
					boolBuildAnimationStarted=true
					StartThread(timeDelayedSound)
					StartThread(buildAnimation,buildID,masterTableKey)
					--------Spring.Echo("We build it up, and now its solid, solid like a block!")
					end
			 end
		end		
		-------------------------------------------------------------------------------------------------------- /INIT
		--everynow and then update buildprogress 
			--update comonbuildspeed
			
		if boolBuildAnimationStarted==true then
		------Spring.Echo("HangOverHere6")
		------Spring.Echo(buildID)
		------Spring.Echo(buildprogress)
		------Spring.Echo(masterTableKey)
		
		lupdateBuildProgress(buildID)
		lupdateComonBuildSpeed(buildID)
		everyThird=(everyThird+1)%3
		if everyThird== 2 then
		isUnitValid()
		end
		end	
	Sleep(600)
	end
end

function pumpItUp(i)
decider=math.random(0,3)
limit=math.random(2,6)
axis={}

	if decider== 0 then
		while(true)do
		Move(cubes[i],x_axis,limit,0.3)
		WaitForMove(cubes[i],x_axis)
		randSleep=math.random(100,400)
		Sleep(randSleep)
		Move(cubes[i],x_axis,limit*-1,0.3)
		WaitForMove(cubes[i],x_axis)
		randSleep=math.random(100,400)
		Sleep(randSleep)
		end
	elseif decider==1 then
		while(true)do
		Move(cubes[i],y_axis,limit,0.3)
		WaitForMove(cubes[i],y_axis)
		randSleep=math.random(100,400)
		Sleep(randSleep)
		Move(cubes[i],y_axis,limit*-1,0.3)
		WaitForMove(cubes[i],y_axis)
		randSleep=math.random(100,400)
		Sleep(randSleep)
		end
	else 
		while(true)do
		Move(cubes[i],z_axis,limit,0.3)
		WaitForMove(cubes[i],z_axis)
		randSleep=math.random(100,400)
		Sleep(randSleep)
		Move(cubes[i],z_axis,limit*-1,0.3)
		WaitForMove(cubes[i],z_axis)
		randSleep=math.random(100,400)
		Sleep(randSleep)
		end
	end
	

	while(true)do
	Move(cubes[i],axis,limit,0.3)
	WaitForMove(cubes[i],axis)
	randSleep=math.random(100,400)
	Sleep(randSleep)
	Move(cubes[i],axis,limit*-1,0.3)
	WaitForMove(cubes[i],axis)
	randSleep=math.random(100,400)
	Sleep(randSleep)
	end
end

function script.Create()
Spring.SetUnitAlwaysVisible(unitID,true)
--identify unit 
--modULater=math.random(1,4)
	for i=1,totalCubes,1  do
	x=math.random(0,2)

		Hide(outerCubes[i])
		Hide(cubes[i])
		
		if i%49 < 7 or i%42 < 7 or i%7== 0 or i%8== 0 then
		StartThread(pumpItUp,i)
		end

	xturn=math.random(0,3)	
	yturn=math.random(0,3)	
	zturn=math.random(0,3)	
	Turn(cubes[i],x_axis,math.rad(90*xturn),0)
	Turn(cubes[i],y_axis,math.rad(90*yturn),0)
	Turn(cubes[i],z_axis,math.rad(90*zturn),0)
		
		
	end

--------Spring.Echo("I link therefore i spam!")     
StartThread(wizzardryOfOSLoop)


end






function script.Killed()

--------Spring.Echo("You too bruteUs?... stickying it up the emperor? ")
return 0
end