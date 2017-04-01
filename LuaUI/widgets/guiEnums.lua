
WG.uniqueCommandID= 0
function getUniqueCommandID()
	WG.uniqueCommandID=WG.uniqueCommandID+1
	return WG.uniqueCommandID
end

eAttac		=	getUniqueCommandID()-- Can the unit be issued Attack orders? 
eStop		=	getUniqueCommandID()--
eFight		=	getUniqueCommandID()
eMove		=	getUniqueCommandID()--  Can the unit be issued Move orders? 
ePatrol		=	getUniqueCommandID()
eCloak		=	getUniqueCommandID()
eGuard		=	getUniqueCommandID()
eSelfDestruct=  getUniqueCommandID()	
eRestore	=	getUniqueCommandID()	
eFireState	=	getUniqueCommandID()--
eMoveState  =  getUniqueCommandID()
eRepeat		=	getUniqueCommandID()--
ePatrol		=	getUniqueCommandID()--
eReclaim	=  getUniqueCommandID()

eRepair		=	getUniqueCommandID()--
eResurrect  = getUniqueCommandID()
eCapture	= getUniqueCommandID()

