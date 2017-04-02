function getCommandTable()
	returnT={}
	local alt, ctrl, shift, right = Spring.GetModKeyState()
	
	if alt then table.insert(returnT,"alt")end
	if ctrl then table.insert(returnT,"ctrl")end
	if shift then table.insert(returnT,"shift")end
	if right then table.insert(returnT,"right")end
	return returnT
end


function upByRow(str,num)
	for i=1,num do
		str=str.."\n"
	end
	return str
end
