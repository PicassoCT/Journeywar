



--hide all pieces at start
function hideAllNonVitalPieces(TablesOfPiecesGroups)
	hideT(TablesOfPiecesGroups["Sun"])
	hideT(TablesOfPiecesGroups["water"])
	hideT(TablesOfPiecesGroups["forceLoop"])
	hideT(TablesOfPiecesGroups["gate"])
	hideT(TablesOfPiecesGroups["outRot"])
end

--Show suns one after one another
function sunCycle(liveTime,TablesOfPiecesGroups)
	spinT(TablesOfPiecesGroups["Sun"],y_axis,12, math.random(-22,22))
	hideT(TablesOfPiecesGroups["Sun"])
	for i=1,MAXFORCELOOP do
		Show(TablesOfPiecesGroups["Sun"][i])
		Sleep(math.ceil(liveTime/#TablesOfPiecesGroups["Sun"]))
		if TablesOfPiecesGroups["Sun"][i-1] then
			Hide(TablesOfPiecesGroups["Sun"][i-1])
		end
	end
	
end