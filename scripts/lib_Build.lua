

function mirrorMapCenter(x,y,z)
mx,mz=Game.mapSizeX,Game.mapSizeZ
mx,mz= mx/2,mz/2

return x-1*(x-mx), y, z-1*(z-mz)
end