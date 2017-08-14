VFS.Include("scripts/lib_type.lua", nil, VFS.DEF_MODE)

--[[
This library is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this library; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
MA 02110-1301, USA.

]] --
-------------- DEBUG HEADER
-- Central Debug Header Controlled in UnitScript
lib_boolDebug = false --GG.BoolDebug or false
-------------- DEBUG HEADER

--======================================================================================
--Chapter: Tableoperations
--======================================================================================
--merges two Dictionary Tables with the first having precedence
function mergeDict(dA, xdB)
if dA and not xdB then return dA end
if xdB and not dA then return xdB end
local dB = xdB
	for k,v in pairs(dA) do
		dB[k] = v
	end
return dB
end

function selectUnitDefs(names)
local retT={}

	for num, uDefID in pairs(names) do

		retT[uDefID]= UnitDefs[uDefID]	
	end
return retT
end

function UnitDefToUnitDefNames(UnitDef)
local retT = UnitDef
	for defID, T in pairs(UnitDef) do
		retT[T.name] = T
	end
return retT
end


function echoUnitDefT(defT)

	for k,v in pairs(defT) do 
		echo(UnitDefs[v].name)
	end
end
--> Hides a PiecesTable, 
function hideT(tablename, lowLimit, upLimit, delay)
    if not tablename then return end
    boolDebugActive = (lib_boolDebug == true and lowLimit and type(lowLimit) ~= "string")

    if lowLimit and upLimit then
        for i = upLimit, lowLimit, -1 do
            if tablename[i] then
                Hide(tablename[i])
            elseif boolDebugActive == true then
                echo("In HideT, table " .. lowLimit .. " contains a empty entry")
            end

            if delay and delay > 0 then Sleep(delay) end
        end

    else
        for i = 1, table.getn(tablename), 1 do
            if tablename[i] then
                Hide(tablename[i])
            elseif boolDebugActive == true then
                echo("In HideT, table " .. lowLimit .. " contains a empty entry")
            end
        end
    end
end
-->Shows a Pieces Table
function showT(tablename, lowLimit, upLimit, delay)
    if not tablename then Spring.Echo("No table given as argument for showT") return end

    if lowLimit and upLimit then
        for i = lowLimit, upLimit, 1 do
            if tablename[i] then
                Show(tablename[i])
            end
            if delay and delay > 0 then Sleep(delay) end
        end

    else
        for i = 1, table.getn(tablename), 1 do
            if tablename[i] then
                Show(tablename[i])
            end
        end
    end
end

--> accessTable a table three layers deep on any key/index
function accessTable(T, a, b, c)
    if a and not T[a] then T[a] = {} end
    if b and not T[a][b] then T[a][b] = {} end
    if c and not T[a][b][c] then T[a][b][c] = {} end
    return T
end

-->make a GlobalTableHierarchy From a Set of Arguments - String= Tables, Numbers= Params
-->Example: "TableContaining[key].TableReamining[key].valueName" or [nr] , value
function split(div, str)
    if (div == '') then return false end
    local pos, arr = 0, {}
    -- for each divider found
    for st, sp in function() return string.find(str, div, pos, true) end do
        table.insert(arr, string.sub(str, pos, st - 1)) -- Attach chars left of current divider
        pos = sp + 1 -- Jump past current divider
    end
    table.insert(arr, string.sub(str, pos)) -- Attach chars right of last divider
    return arr
end

function makeTableFromString(FormatString, assignedValue, ...)
    local arg = arg; if (not arg) then arg = { ... }; arg.n = #arg end
    if loadstring(FormatString) ~= nil then FormatString = FormatString .. "=" .. assignedValue; loadstring(FormatString) return end
    --SplitByDot
    SubTables = {}
    --split that string
    SubT = string.split(FormatString, ".")
    Appendix = "GG."
    boolAvoidFutureChecks = false
    for i = 1, #SubT do
        if not SubT[i] == "GG" then
            SubT = string.gsub(SubT, ".")
            ExtracedIndex = string.match(SubT, "[", "]")
            ExtractedTable = string.gsub(SubT, ExtracedIndex, "")
            Terminator = "."
            if ExtractedTable then
                if boolAvoidFutureChecks == true or not loadstring(Appendix .. ExtractedTable) then
                    loadstring(Appendix .. ExtractedTable .. "= {}")
                    boolAvoidFutureChecks = true
                end
            else ExtractedTable = ""; Terminator = ""
            end
            if boolAvoidFutureChecks == true or ExtracedIndex and not loadstring(Appendix .. ExtractedTable .. ExtracedIndex) then
                loadstring(Appendix .. ExtractedTable .. ExtracedIndex .. "={}")
            end

            Appendix = Appendix .. ExtractedTable .. ExtracedIndex .. Terminator
        end
    end
    loadstring(Appendix .. "=" .. assignedValue)
    return loadstring(Appendix .. "==" .. asignedValue)
end

--> Creates a Table and initalizazes it with default value
function makeTable(default, xDimension, yDimension, zDimension, boolNegativeMirror)
	boolNegativeMirror= boolNegativeMirror or false	

	xStartIndex = 1
	yStartIndex = 1
	zStartIndex = 1
	
	if boolNegativeMirror == true then
		xStartIndex = -xDimension
		yStartIndex = -yDimension
		zStartIndex = -zDimension
	end
	
    local RetTable = {}
    if not xDimension then return default end

    for x = xStartIndex, xDimension, 1 do
        if yDimension then
            RetTable[x] = {}
        elseif xDimension then
            RetTable[x] = default
        else
            return default
        end

        if yDimension then
            for y = yStartIndex, yDimension, 1 do
                if zDimension then
                    RetTable[x][y] = {}
                else
                    RetTable[x][y] = default
                end

                if zDimension then
                    for z = zStartIndex, zDimension, 1 do
                        RetTable[x][y][z] = default
                    end
                end
            end
        end
    end
    return RetTable
end

--> rotate zero Centric Table
function rotateMap(Map, sizeX,sizeZ, degreeRotation, default)
local rotateCopy= makeTable(default, sizeX, sizeZ, nil, true )
	for x=-sizeX,sizeX do
		for z=-sizeZ,sizeZ do
			if Map[x][z] ~= default then
			rx, rz= Rotate(x, z, math.rad(degreeRotation))
			rotateCopy[rx][rz]= Map[x][z]
			end
		end
	end
return rotateCopy
end
 
--> shifts a 2d Map by a vector, replaces empty values with default
function shiftMap(Map, sizeX,sizeZ, offX, offZ, default)
local shiftedMap = makeTable(default, sizeX, sizeZ, nil, true )
for x=-sizeX, sizeX do
		for z=-sizeZ, sizeZ do
			if Map[x][z] ~= default and shiftedMap[x+offX] and shiftedMap[x+offX][z+offZ] then
			shiftedMap[x+offX][z+offZ]= Map[x][z]
			end
		end
	end
return shiftedMap
end
-->Creates basically a table of piecenamed enumerated strings
function makeTableOfPieceNames(name, nr, startnr, piecefoonction)
    T = {}
    start = startnr or 1

    for i = start, nr do
        namecopy = name
        namecopy = namecopy .. i
        T[i] = namecopy
    end
    if piecefoonction then
        for i = start, nr do
            T[i] = piecefoonction(T[i])
        end
    end
    return T
end

--> Adds to a Table, argument as keys, subtables
function addTableTables(T, ...)
    local arg = arg; if (not arg) then arg = { ... }; arg.n = #arg end
    String = "T"
    boolOneTimeNil = false
    if arg then
        for k, v in ipairs(arg) do
            String = String .. "[" .. v .. "]"
            Spring.Echo(String)

            if boolOneTimeNil == false then
                if loadstring(String) ~= nil then
                else
                    boolOneTimeNil = true
                end
            else
                loadstring(String .. "={}")
            end
        end
    end
    return T
end

-->filters out the dead 
function validateUnitTable(T)
    TVeryMuchAlive = {}

    for i = #T, 1, -1 do
        boolUnitDead = Spring.GetUnitIsDead(T[i])
        if boolUnitDead and boolUnitDead == false then
            TVeryMuchAlive[#TVeryMuchAlive + 1] = T[i]
        end
    end

    return TVeryMuchAlive or {}
end

-->adds a num Table to a num Table
function TAddT(OrgT, T)
    for i = 1, #T do
        OrgT[#OrgT + i] = T[i]
    end
    return OrgT
end

function count(T)
	if not T then return 0 end
	index = 0
	for k,v in pairs(T) do 
		if v then 
		index= index +1 
		end 
	end
	return index
end

function getNthElementT(T, nth)
	index = 0
	for k,v in pairs(T) do
		if v then index= index +1 end 
		if index== nth then 
			return k, v1
		end
	end
end

function randDict(Dict)
if lib_boolDebug == true then
assert(type(Dict)=="table")
end
totalElements = count(Dict)
randElement = math.random(1,totalElements)
index= 1
anyElement=1
for k,v in pairs (Dict) do
anyElement = k
	if index ==randElement then 
	return k,v
	end
index=inc(index)
end
return anyElement


end

--> randomizes Table Entrys
function shuffleT(T)
local	randT= {}
	size = count(T)
	allreadyInserted={}
	
	for i = 1, size do
		rIndexStart = math.random(1, size)
		boolFoundSomething = false
		for k = rIndexStart, size do
			if not allreadyInserted[k] then
				key,v = getNthElementT(T, k)
				randT[i] = T[key] 
				allreadyInserted[k]=true				
				boolFoundSomething = true
			end
		end
		
		if boolFoundSomething == false then
			for k = 1, rIndexStart do
				if not allreadyInserted[k] then
					key,v = getNthElementT(T, k)
					randT[i] = T[key] 
					allreadyInserted[k]=true
				end
			end
		end
	end
	
	return randT
end

-->Copys a table
function tableCopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[tableCopy(orig_key)] = tableCopy(orig_value)
        end
        setmetatable(copy, tableCopy(getmetatable(orig)))
    else
        copy = orig
    end
    return copy
end

--> Destroys A Table of Units
function DestroyTable(T, boolSelfd, boolReclaimed, condFunction, unitID)
    if T then
        for i = 1, #T, 1 do
            if condFunction(T[i]) == true then
                Spring.DestroyUnit(T[i], boolSelfd, boolReclaimed, unitID)
            end
        end
    end
end

function explodeT(TableOfPieces, Conditions, StepSize)
    lStepSize = StepSize or 1
    for i = 1, #TableOfPieces, lStepSize do
        Explode(TableOfPieces[i], Conditions)
    end
end

--> Recursively Echo a Table out
function rEchoT(T, layer)
    local l = layer or 0
    if T then
        if type(T) == 'table' then
            Spring.Echo(stringBuilder( l, " ") .. "T:")
            for k, v in pairs(T) do
					Spring.Echo(stringBuilder( l, " ").."Key "..k)					
                rEchoT(T[k], l + 1)
            end
        else
            Concated = stringBuilder( math.max(1, l) - 1, " ") .. "|"

            typus = type(T)
            if typus == "number" or typus == "string" then
                Spring.Echo(Concated .. T)
            elseif typus == "boolean" then
                Spring.Echo(Concated .. "boolean" .. ((T == true) and "True"))
            elseif typus == "function" then
                Spring.Echo(Concated .. "function: Result")
					  rEchoT(T(),layer)
            end
        end
    end
end

function ringModulu(value, inc,  ringCap , Sign)
value = value +1* Sign
if value < 0 or value == ringCap then return value, Sign*-1 end
 return value, Sign

end

function echoT(T, boolAssertTable, name)

    lboolAssertTable = boolAssertTable or false
    if not type(T) == "table" then Spring.Echo("Element is of Type:" .. type(T)); return end
    lname = name or "AnnonymTable"
    if T.name then lname = T.name end


    if lname then
        Spring.Echo("============================= " .. lname .. " ======================================")
        Spring.Echo("|| ||")
    else
        Spring.Echo("============================= KeyValue Table=====================================")
        Spring.Echo("|| ||")
    end

    for k, v in pairs(T) do
        typek = type(k)
        typev = type(v)

        if typev == "table" then
            rEchoT(typev, 0)
        end
        nonprintableType = {
            ["table"] = true,
            ["function"] = true,
            ["boolean"] = true,
        }
        if nonprintableType[typek] == nil then
            if not nonprintableType[typev] then
                Spring.Echo(" " .. k .. " 	---> 	" .. v .. " -> 	[ " .. ((assert(v))) .. " ] ")
            elseif typev == "table" then
                echoT(v)
            elseif typev == "boolean" then
                Spring.Echo(" " .. k .. " 	---> 	" .. (boolToString(v)) .. " ")
            else
                Spring.Echo("Key " .. k .. " -> " .. " holds no value")
            end
        end
    end

    if lboolAssertTable == true then
        for k, v in pairs(T) do
            assert(v)
        end
    end


    Spring.Echo("================================================================================")
end

function boolToString(value)
    if value == true then return "true" else return "false" end
end


function filterTableByTable(T, T2, compareFunc)
    reTable = {}
    for i = 1, #T do
        if compareFunc(T[i], T2) == true then reTable[#reTable + 1] = T[i] end
    end
    return reTable
end

function tableToKeyTable(T)
    KT = {}
    for i = 1, #T do
        KT[T[i]] = T[i]
    end
    return KT
end

function keyTableToTables(T)
    counter = 1
    TableKey = {}
    TableValue = {}
    counter = 1
    for k, v in pairs(T) do
        TableKey[counter] = k
        TableValue[counter + 1] = v
        counter = counter + 2
    end

    return TableKey, TableValue
end

function insertKeysIntoTable(T, T2)
    for i = 1, #T do
        if not T2[T[i]] then
            T2[T[i]] = T[i]
        end
    end
    return T2
end


-->itterates over a table, executing a function with a argumentTable
function elementWise(T, fooNction, ArghT)
    reTable = {}

    for k, v in pairs(T) do
        reTable[k] = fooNction(T[k], ArghT)
    end

    return reTable
end

-->recursive itterates over a Keytable, executing a function 
function recElementWise(T, fooNction, ArghT)
    reTable = {}

    for k, v in pairs(T) do
        if type(T[k]) ~= "table" then
            reTable[k] = fooNction(T[k], ArghT)
        else
            reTable[k] = recElementWise(T[k], fooNction, ArghT)
        end
    end

    return reTable
end

-->count Elements in a Dictionary
function countT(T)
    it = 0
    for k, v in pairs(T) do
        it = it + 1
    end
    return it
end


--> Join Operation on two tables
join = function(id, argT)
    resulT = {}
    for num, idInTable in pairs(argT) do
        resulT[#resulT + 1] = { id = id, obj = idInTable }
    end
    return resulT
end

--> Validator
validator = function(id)
    deadOrAlive = Spring.GetUnitIsDead(id)
    if deadOrAlive and deadOrAlive == false then
        return id
    end
end

--> takes a Table, and executes Function on it
-- non Function Values are handed to the function following it
-- returning nil removes a element from the process chain
function process(Table, ...)
    local arg = { ... }
    local arg = arg; if (not arg) then arg = { ... }; arg.n = #arg end
    T = {}
    if Table then
        T = Table
    else
        if lib_boolDebug == true then
            echo("Lua:lib_UnitScript:Process: No Table handed over")
            return
        end
    end
    if not arg then echo("No args in process") return end
    if type(arg) == "function" then return elementWise(T, arg) end


    TempArg = {}
    TempFunc = {}
    --if not arg then return Table end

    for _, f in pairs(arg) do
        if type(f) == "function" then
            T = elementWise(T, f, TempArg)
            TempArg = {}
        else
            TempArg[#TempArg + 1] = f
        end
    end
    return T
end

-->traverses tables and applys a function to them
function recProcess(Table, ...)
    local arg = { ... }
    local arg = arg; if (not arg) then arg = { ... }; arg.n = #arg end
    T = {}
    if Table then T = Table else echo("Lua:lib_UnitScript:Process: No Table handed over") return end
    if not arg then echo("No args in process") return end
    if type(arg) == "function" then return elementWise(T, arg) end


    TempArg = {}
    TempFunc = {}
    --if not arg then return Table end

    for _, f in pairs(arg) do
        if type(f) == "function" then
            T = recElementWise(T, f, TempArg)
            TempArg = {}
        else
            TempArg[#TempArg + 1] = f
        end
    end
    return T
end

--======================================================================================
--Geometry functions
--======================================================================================
-->Rotates a point around another Point
function drehMatrix(x, y, zx, zy, degInRad)
    x = x - zx
    y = y - zy
    tempX = (math.cos(degInRad) * x) + ((-1.0 * math.sin(degInRad)) * y)
    y = (math.sin(degInRad) * x + (math.cos(degInRad)) * y)


    x = tempX + zx
    y = y + zy
    return x, y
end

-->Checks wether a point is within a triangle
function pointWithinTriangle(x1, y1, x2, y2, x3, y3, xt, yt)

    --triAngleDeterminates
    x1x2 = 0.5 * (x1 * y2 - x2 * y1)
    x2x3 = 0.5 * (x2 * y3 - x3 * y2)
    x3x1 = 0.5 * (x3 * y1 - x1 * y3)
    --pointAngleDeterminates
    x1xt = 0.5 * (x1 * yt + xt * y1)
    x2xt = 0.5 * (x2 * yt + xt * y2)
    x3xt = 0.5 * (x3 * yt + xt * y3)

    det1 = x1x2 + x1xt + x2xt --x1x2xt
    det2 = x2xt + x3xt + x2x3 --x3x2xt
    det1 = x3xt + x3x1 + x1xt --x1x3xt
    detSum = det1 + det2 + det3
    if detSum < 0 then
        --Point is outside of triAngle
        return true
    end

    if detSum >= 0 then
        --Point is inside of triAngle
        return false
    end
end

-->returns the absolute distance on negative and positive values
function absDistance(valA, valB) 

    if Signum(valA) == Signum(valB) then
        return math.abs(math.abs(valA) - math.abs(valB))
    else
        return math.abs(valA) + math.abs(valB)
    end
end

--functions
-->returns the Negated Axis
function mirror(value)
    value = -1 * value
    return value
end

-->returns the 2 norm of a vector
function distance(x, y, z, xa, ya, za)
	if type(x)== "table" then
		return distance(x.x, x.y, x.z, y.x, y.y, y.z)
	end

    if xa ~= nil and ya ~= nil and za ~= nil then
        return math.sqrt((x - xa) ^ 2 + (y - ya) ^ 2 + (z - za) ^ 2)
    elseif x ~= nil and y ~= nil and z ~= nil then
        return math.sqrt(x * x + y * y + z * z)
    else
        return math.sqrt((x - y) ^ 2)
    end
end

function setParent(unitID, child)

 env = Spring.UnitScript.GetScriptEnv(child)

    if env then
		env.parent= unitID
    end
end

function distancePieceToUnit(unitID, Piece, targetID)
	ex,ey,ez = Spring.GetUnitPiecePosDir(unitID, Piece)
	tx,ty,tz = Spring.GetUnitPosition(targetID)
	return distance(ex,ey, ez, tx,ty,tz)
end

--> get two unit distVector
function vectorUnitToUnit(idA, idB)
    x, y, z = Spring.GetUnitPosition(idA)
    xb, yb, zb = Spring.GetUnitPosition(idB)

    return Vector:new(x - xb, y - yb, z - zb)
end

-->returns the Distance between two units
function distanceUnitToUnit(idA, idB)
    if lib_boolDebug == true then
        if (not idA or type(idA) ~= "number") then echo("Not existing idA or not a number"); return; end
        if (not idB or type(idB) ~= "number") then echo("Not existing idB or not a number"); return; end
        if Spring.ValidUnitID(idA) == false then echo("distanceUnitToUnit::idA Not a valid UnitID"); return end
        if Spring.ValidUnitID(idB) == false then echo("distanceUnitToUnit::idB Not a valid UnitID"); return; end
    end
    x, y, z = Spring.GetUnitPosition(idA)
    xb, yb, zb = Spring.GetUnitPosition(idB)

    if not x or not xb then echo("distanceToUnit::Invalid Unit - no position recived") return end
    assert(x)
    return distance(x, y, z, xb, yb, zb)
end

--> gives a close hunch at the distance and avoids expensive sqrt math by using herons Algo
function approxDist(x, y, z, digitsPrecision)
    resultSoFar = x * x + y * y + z * z
    lastResult = resultSoFar
    for i = 1, digitsPrecision do
        lastResult = (lastResult + resultSoFar / lastResult) / 2
    end
    return lastResult
end

--> increment a value
function inc(value)
    return value + 1
end

--> decrement a value
function dec(value)
    return value - 1
end

--======================================================================================
--String Operations
--======================================================================================
--> creates a table of pieces with name
function makeTableOfNames(name, startnr, endnr)
    T = {}
    for i = startnr, endnr, 1 do
        T[#T + 1] = name .. i
    end
    return T
end

--> chreates from a examplestring a string of length

function stringBuilder(length, sign)
    str = ""
    for i = 1, length do
        str = str .. sign
    end
    return str
end


--======================================================================================
--Debug Tools 
--======================================================================================
--> testUnit for existance - Debugfunction
function testUnit(unitid)
    if not unitid then echo("TestUnit no unitid given to testUnit()"); return end
    echo("UnitTested")
    if type(unitid) ~= "number" then echo("unitid is not a number-type is " .. type(unitid) .. " with value: " .. unitid); return end

    validUnit = Spring.ValidUnitID(unitid)
    if validUnit and validUnit == true then
        echo("U" .. unitid .. " :unitid is valid")
    else
        echo("U" .. unitid .. " :unitid is invalid")
        return
    end
    isAlive = Spring.GetUnitIsDead(unitid)
    if isAlive and isAlive == true then
        echo("U" .. unitid .. ":unitid is alive")
    else
        echo("U" .. unitid .. ":unitid is dead")
        return
    end
end

function HideWrap(piecenr)
    if lib_boolDebug == true then
        if type(piecenr) == "string" then
            Spring.Echo("Hide did get a string.." .. piecenr); assert(true == false);
        end
        if type(piecenr) == "table" then
            Spring.Echo("PieceNr in hide is a table");
            --echoT(piecenr)
            assert(true == false);
        end

        if type(piecenr) == "number" then
            PieceMap = Spring.GetUnitPieceList(unitID)
            if not PieceMap[piecenr] then
                Spring.Echo("Piece not a valid Nr" .. piecenr)
                return
            end
            Hide(piecenr)
        end
    else
        Hide(piecenr)
    end
end

function ShowWrap(piecenr)
    if lib_boolDebug == true then
        if type(piecenr) == "string" then
            Spring.Echo("Hide did get a string.." .. piecenr); assert(true == false);
        end
        if type(piecenr) == "table" then
            Spring.Echo("PieceNr in hide is a table");
            --echoT(piecenr)
            assert(true == false);
        end

        if type(piecenr) == "number" then
            PieceMap = Spring.GetUnitPieceList(unitID)
            if not PieceMap[piecenr] then
                Spring.Echo("Piece not a valid Nr" .. piecenr)
                return
            end
            Hide(piecenr)
        end
    else
        Hide(piecenr)
    end
end


--> asserts all Elements in Table are of Type
function assertTableType(T, Type)
	for k,v in pairs(T) do
		if type(v) ~= Type then
		Spring.Echo("assertTypeTable::Error: Key "..k.." not of type ".. Type.. " got ".. type(v).. "instead")
		assert(true==false)
		end
	end
end


--> checks wether a number value is nan
function isNaN(value)
    return (value ~= value)
end

function assertUnit(id)
	if (Spring.ValidUnitID(id) == true) then
		return 
	else
		assert(true==false)
	end
end

function assertAxis(axis)
axisT = {
		[1] = true,
		[2] = true,
		[3] = true
		}
if axisT[axis] then return else assert(true==false)end		
end

function assertAlive(id)
	if (Spring.GetUnitIsDead(id) == false) then
		return 
	else
		assert(true==false)
	end
end
function assertBool(val)
    assert(type(val) == "boolean")
end

function assertStr(val)
    assert(type(val) == "string")
end

function assertNum(val)
    assert(type(val) == "number")
end

function assertTableNotNil(Table)
    for k, v in pairs(Table) do
        if not v then echo("asserTable has key " .. k .. " without a value")
        else
            typeV = type(v)
            if typeV == "table" then
			asserTable(v); 
			end
        end
    end
end

--expects dimensions and a comperator function or value/string/object={membername= expectedtype}--expects dimensions and a comperator function or value/string/object={membername= expectedtype}
function assertT(ExampleTable, checkTable, checkFunctionTable)
   
    if type(arg) == "number" then echo("assertT:: Not a valid table- recived number " .. arg); return false end
	
	for key, value in pairs(ExampleTable) do
		if  checkTable[key] then
			valueType= type(value)
			
			if valueType == "table" then 
				if (assertT(value, checkTable[key], checkFunctionTable[key]) == false) then
					echo("Assert Table Error: Table did not contain wellformed subtable for key "..key)
					assert(true == false)
				end
			end
			
				if type(checkTable[key]) ~= valueType then 
					echo("Error: Wrong Type found for key ".. key..". Type "..valueType.." expected, got ".. type(	checkTable[key]).." instead ")
				else -- valid type - lets check the value for correctness
					if checkFunctionTable[key] then
						if checkFunctionTable[key](value) == false then 
							echo("Error: Value is not fullfilling condition function")
							return false
						end
						return true
					end		
					return true
				end		
		else
			valueType= type(value)
			echo("Assert Table Error: Table did not contain a value of type "..valueType.." for key :"..key)
			assert(true==false)
		end
	end
end

-->prints a table in steps
function printT(tab, size, step)
    maxdigit = getDigits(tab[size / 2][size / 2])
    step = step or (size / 12)
    Spring.Echo(stringBuilder(size, "_") .. "\n")
    for i = 1, size, step do
        seperator = "|"
        str = ""

        for j = 1, size, step do
            str = str .. seperator .. math.floor(tab[math.ceil(i)][math.ceil(j)])
            if getDigits(math.floor(tab[math.ceil(i)][math.ceil(j)])) < maxdigit then
                for i = 1, maxdigit - getDigits(math.floor(tab[math.ceil(i)][math.ceil(j)])), 1 do
                    str = str .. " "
                end
            end
        end
        Spring.Echo(str)
    end
    Spring.Echo(stringBuilder(size, "_") .. "\n")
end

--> echos out strings
function echo(stringToEcho, ...)
    local arg = arg; if (not arg) then arg = { ... }; arg.n = #arg end

    Spring.Echo(stringToEcho)
    if arg then
        counter = 0
        for k, v in ipairs(arg) do
            if k and v then
                if type(v) == "table" then
                    echoT(v)
                else
                    Spring.Echo(k .. " " .. v)
                end
            elseif k then
                Spring.Echo(k)
            end
        end
    end
end
--> prints a square 2dmap 
function echo2DMap(tmap, squareSideDimension, valueSignMap)
    map = {}
    local map = tmap
    step = 8

    valueSignMap = valueSignMap or {
        [0] = " 0 ",
        [false] = " € ",
        [true] = " T "
    }

    if squareSideDimension ~= nil and squareSideDimension < 128 then step = 1 end

    for x = 2, #map, step do
        StringToConcat = ""
        for z = 2, #map, step do
            if not map[x][z] then
                StringToConcat = StringToConcat .. " "
            elseif valueSignMap[map[x][z]] then
                StringToConcat = StringToConcat .. valueSignMap[map[x][z]]
            else
                StringToConcat = StringToConcat .. printFloat(map[x][z], 3) .. " "
            end
        end
        Spring.Echo(StringToConcat)
    end
end

function printFloat(anyNumber, charsToPrint)
    stringifyFloat = "" .. anyNumber
    return string.sub(stringifyFloat, 1, charsToPrint)
end

--> Flashes a Piece for debug purposes
function flashPiece(pname, Time, rate)
    r = rate
    t = Time or 1000
    if not rate then r = 50 end

    for i = 0, Time, 2 * r do
        Sleep(r)
        Show(pname)
        Sleep(r)
        Hide(pname)
    end
end

function debugDisplayPieceChain(Tables)
    for i = 1, #Tables, 1 do
        x, y, z, _, _, _ = Spring.GetUnitPiecePosDir(unitID, Tables[i])
        Spring.SpawnCEG("redlight", x, y + 10, z, 0, 1, 0, 50, 0)
    end
end

--> echos out a Units Properties
function echoUnitStats(id)
    h, mh, pD, cP, bP = Spring.GetUnitHealth(id)
    echo(h, mh, pD, "Capture Progress:" .. cP, "Build Progress:" .. bP)
end


--======================================================================================
--Random Operations
--======================================================================================

--> Execute Random Function in Table
function randTableFunc(Table)
	Table=shuffleT(Table)
	randElement=math.random(1,table.getn(Table))
	return Table[randElement]()
end

-->a Fairer random Function that selects of a table everyNthElement at least candidatesInInterval Number many elements
function randFairT(T, candidatesInInterval, everyNthElement)
	tagYourIt={}
	if candidatesInInterval >= everyNthElement then echo("randFairT error"); return {} end

	for i=1, #T, everyNthElement do
	internalCount=0
		for j=i, i+everyNthElement do
			if randChance((internalCount/candidatesInInterval) * 100)==true  then
				tagYourIt[#tagYourIt+1] = T[j]
				internalCount=internalCount+1
			end
		end
	end
	return tagYourIt
end


function randChance(likeLihoodInPercent)
	return (math.random(1,100) <= likeLihoodInPercent)
end

--> returns a randomized Signum
function randSign()
    if math.random(0, 1) == 1 then return 1 else return -1 end
end

-->Returns randomized Boolean
function maRa()
    return math.random(0, 1) == 1
end

-->Returns not nil if random
function raNil()
    if math.random(0, 1) == 1 then return maRa() else return end
end

-->Randomizes a Vector
function randVec(boolStayPositive)

    if boolStayPositive and boolStayPositive == true then
        return { x = math.random(0, 1000) / 1000, y = math.random(0, 1000) / 1000, z = math.random(0, 1000) / 1000 }
    else
        return { x = math.random(-1000, 1000) / 1000, y = math.random(-1000, 1000) / 1000, z = math.random(-1000, 1000) / 1000 }
    end
end

-->Sanitizing RandomIntervall -cause brando has electrolytes
function cbrandoVal(LowLimit, UpLimit)
    upLim = UpLimit or LowLimit + 1
    if LowLimit >= upLim then LowLimit = upLim - 1 end
    return math.ceil(math.random(LowLimit, UpLimit))
end

-->Sanitizing RandomIntervall -cause brando has electrolytes
function brandoVal(LowLimit, UpLimit)
    upLim = UpLimit or LowLimit + 1
    if LowLimit >= upLim then LowLimit = upLim - 1 end
    return math.random(LowLimit, UpLimit)
end

function iRand(start, fin)
    if not fin or fin < start then fin = start + 1 end

    return math.ceil(sanitizeRandom(start, fin))
end

--> Executes a random Function from a table of functions
function randFunc(...)
    local arg = { ... }
    if not arg then return end
    index = sanitizeRandom(1, #arg)
    return arg[index]()
end

--======================================================================================
--Arithmetic operations
--======================================================================================

-->gets Signum of a number
function Signum(val)
    return math.abs(val) / val
end

--> takes the average over a number of argument
function average(...)
    local arg = table.pack(...)
    if not arg then return nil end
    sum = 0
    it = 0
    for k, v in pairs(arg) do
        sum = sum + v
        it = it + 1
    end
    return sum / it
end

--> Converts to points, to a degree in Radians
function convPointsToDeg(ox, oz, bx, bz)
    if not bx then --orgin cleaned point
        return math.atan2(ox, oz)
    else
        bx = bx - ox
        bz = bz - oz
        return math.atan2(bx, bz)
    end
end

--> clamp Disregarding Signum
function clampMaxSign(value, Max)
    if math.abs(value) > Max then
        signum = math.abs(value) / value
        return Max * signum
    else
        return value
    end
end

--> clamps a value between a lower and a upper value
function clamp(val, low, up)
    if val > up then return up end
    if val < low then return low end
    return val
end

--> clamps between a lower value and modulu operates on the upper value
function clampMod(val, low, up)
    if val > up then return (val % up) + 1 end
    if val < low then return low end
    return val
end

--> inverted parrabel from 1 to 0
function Parabel(x, A, B, yOffset, xShift, invert)
	invSign= -1 
	xShift = xShift or 0
	
		if invert == false then 
			invSign = 1
		end

	return	invSign * ( A * ((x + xShift)^2) + B )  + yOffset
end


function ANHINEG(value)
    if value < 0 then
        value = M(value)
    end
    return value
end

function PP(value)
    value = value + 1
    return value
end

--Bit Operators -Great Toys for the BigBoys
function SR(value, shift)
    reSulTan = math.bit_bits(value, shift)
    return reSulTan
end

function SL(value, shift)
    reSulTan = math.bit_bits(value, M(shift))
    return reSulTan
end

function AND(value1, value2)
    reSulTan = math.bit_and(value1, value2)
    return reSulTan
end

function OR(value1, value2)
    reSulTan = math.bit_or(value1, value2)
    return reSulTan
end

function XOR(value1, value2)
    reSulTan = math.bit_xor(value1, value2)
    return reSulTan
end


function INV(value)
    reSulTanane = math.bit_inv(value)
    return value
end


--> increments in a ring
function ringcrement(index, upValue, LowValue)
	
	if index + 1 > upValue then 
		index= LowValue; 
		return index 
	end
	
return index +1
end

--> takes a given position and the dir of a surface and calculates the vector by which the vector is reflectd,
--if fall in angle == escape angle
function mirrorAngle(nX, nY, nZ, dirX, dirY, dirZ)
    max = math.max(dirX, math.max(dirY, dirZ))
    dirX, dirY, dirZ = dirX / max, dirY / max, dirZ / max
    max = math.max(nX, math.max(nY, nZ))
    nX, nY, nZ = nX / max, nY / max, nZ / max


    a = math.atan2(nY, nZ) --alpha	x_axis
    b = math.atan2(nX, nY) --beta	z_axis

    ca = math.cos(a)
    cma = math.cos(-1 * a)
    ncma = cma * -1
    sa = math.sin(a)
    sma = math.sin(-1 * a)
    nsma = sma * -1

    cb = math.cos(b)
    cmb = math.cos(-1 * b)
    ncmb = cmb * -1
    sb = math.sin(b)
    smb = math.sin(-1 * b)
    nsmb = smb * -1
    -- -c(a)*c(-a)+s(a)*s(-a)																		|-c(a)-s(-a)+ s(a)*c(-a)																	|0				|0
    -- c(-b)*[(c(b)*s(a)*c(-a)+c(b)*c(a)*s(-a))]+-s(-b)*[(-s(a)*s(b)*c(-a))+(-s(b)*c(a)*s(-a))]		|c(-b)*[c(b)*s(a)*-s(-a) + c(b)*c(a)*c(-a) ]+-s(-b)*[-s(a)*s(b)*-s(-a)+(-s(b)*c(a)*c(-a)]	|-s(b)*s(-b)	|0
    -- s(-b)*[c(b)*s(a)*c(-a)+c(b)*c(a)*s(-a)	]+ c(-b) *[ -s(a)*s(b)*c(-a) + (-s(b)*c(a)*s(-a)]	|s(-b)*[c(b)*s(a)*-s(-a) + c(b)*c(a)*c(-a) ]+c(-b)*[-s(a)*s(b)*-s(-a)+(-s(b)*c(a)*c(-a)]	|-c(b)*c(-b)	|0

    dirX = dirX * ncma * cma + sa * sma + dirY * ncma * -1 * sma + sa * cma
    dirY = dirX * cmb * ((cb * sa * cma + cb * ca * sma)) + -1 * smb * ((-1 * sa * sb * cma) + (-1 * sb * ca * sma)) + dirY * cmb * (cb * sa * -1 * sma + cb * ca * cma) + (-1 * smb * -1 * sa * sb * -1 * sma + -1 * sb * ca * cma) + dirZ * -1 * sb * smb
    dirZ = dirX * smb * (cb * sa * cma + cb * ca * sma) + cmb * (-1 * sa * sb * cma + (-1 * sb * ca * sma)) + dirY * smb * (cb * sa * -1 * sma + cb * ca * cma + cmb * -1 * sa * sb * -1 * sma + (-1 * sb * ca * cma)) + dirZ * -1 * cb * cmb

    return dirX, dirY, dirZ
end

-->RotationMatrice for allready Normalized Values
function Rotate(x, z, Rad)

    sinus = math.sin(Rad)
    cosinus = math.cos(Rad)

    return x * cosinus + z * -sinus, x * sinus + z * cosinus
end

-->multiplies a 3x1 Vector with a 3x3 Matrice
function vec3MulMatrice3x3(vec, Matrice)
    return {
        x = Matrice[1][1] * vec.x + Matrice[1][2] * vec.y, Matrice[1][3] * vec.z,
        y = Matrice[2][1] * vec.x + Matrice[2][2] * vec.y, Matrice[2][3] * vec.z,
        z = Matrice[3][1] * vec.x + Matrice[3][2] * vec.y, Matrice[3][3] * vec.z,
    }
end

--RawMatrice
-- {
-- [1]={[1]=,[2]=,[3]=,},
-- [2]={[1]=,[2]=,[3]=,},
-- [3]={[1]=,[2]=,[3]=,}
-- }
function YRotate(Deg)
    return {
        [1] = { [1] = math.cos(Deg), [2] = 0, [3] = math.sin(Deg) * -1, },
        [2] = { [1] = 0, [2] = 1, [3] = 0 },
        [3] = { [1] = math.sin(Deg), [2] = 0, [3] = math.cos(Deg), }
    }
end

function XRotate(Deg)
    return {
        [1] = { [1] = 1, [2] = 0, [3] = 0 },
        [2] = { [1] = 0, [2] = math.cos(Deg), [3] = math.sin(Deg) * -1 },
        [3] = { [1] = 0, [2] = math.sin(Deg), [3] = math.cos(Deg) }
    }
end

function ZRotate(Deg)
    return {
        [1] = { [1] = math.cos(Deg), [2] = math.sin(Deg) * -1, [3] = 0, },
        [2] = { [1] = math.sin(Deg), [2] = math.cos(Deg), [3] = 0, },
        [3] = { [1] = 0, [2] = 0, [3] = 1, }
    }
end

function rotateUnitAroundUnit(centerID, rotatedUnit, degree)
    ax, ay, az = Spring.GetUnitPosition(centerID)
    bx, by, bz = Spring.GetUnitPosition(rotatedUnit)
    vx, vz = bx - ax, bz - az
    vx, vz = Rotate(vx, vz, math.rad(degree))

    Spring.SetUnitPosition(rotatedUnit, ax + vx, az + vz)
end

function rotateVecDegX(vec, DegX)
    tempDegRotY = math.asin(vec.x / (math.sqrt(vec.x ^ 2 + vec.z ^ 2)))

    -- y-axis
    vec = vec3MulMatrice3x3(vec, YRotate(tempDegRotY * -1))

    tempDegRotZ = math.asin(vec.y / math.sqrt(vec.x ^ 2 + vec.z ^ 2))
    --z-axis
    vec = vec3MulMatrice3x3(vec, YRotate(tempDegRotZ * -1))
    --actual Rotation around the x-axis
    vec = vec3MulMatrice3x3(vec, XRotate(DegX))

    --undo z-axis
    vec = vec3MulMatrice3x3(vec, YRotate(tempDegRotZ))

    -- undo y-axis
    vec = vec3MulMatrice3x3(vec, YRotate(tempDegRotY))
    return vec
end



--======================================================================================
-- Deprecated VectorOperations 
-- for more recent implementations see lib_type

function mix(vA, vB, fac)
	if type(vA) == "number" and type(vB) == "number" then
		return (fac * vA +(1-fac) * vB)
	end
	
    fac = math.min(1.0, math.max(0.0, fac))
    return addVector(mulVector(vA, fac), mulVector(vB, 1 - fac))
end


local countConstAnt = 0
function mulVector(vl, value)
	if not vl  then return nil end

    countConstAnt = countConstAnt + 1
    --if not value or type(value)~='number' and #value == 0 then Spring.Echo("JW::RopePhysix::"..countConstAnt)end 


    if  type(vl) == 'number' and type(value) == "number" then
        return vl * value
    end

    if value and type(value) == 'number' then --Skalar
        return {
            x = vl.x * value,
            y = vl.y * value,
            z = vl.z * value
        }
    end

    if value.x and vl.x then
        --		Spring.Echo("JW:lib_UnitScript:mulVector"..countConstAnt)
        return { x = vl.x * value.x, y = vl.y * value.y, z = vl.z * value.z }
    end

    return nil
end

function norm2Vector(v1, v2)
    if not v1 then return nil end
    if not v1.x then return nil end

    v = subVector(v1, v2) or v1
    return math.sqrt(v.x * v.x + v.y * v.y + v.z * v.z)
end

function divVector(v1, val)
    if not v1 or not val then return nil end
    if not v1.x or type(val) ~= "number" then return nil end

    if type(val) == "number" then
        return { x = v1.x / val, y = v1.y / val, z = v1.z / val }
    else
        return { x = v1.x / val.x, y = v1.y / val.y, z = v1.z / val.y }
    end
end

function addVector(v1, val)
    if not v1 or not val then return nil end

    if type(val) == "table" then
        return { x = v1.x + val.x, y = v1.y + val.y, z = v1.z + val.z }
    else
        return { x = v1.x + val, y = v1.y + val, z = v1.z + val }
    end
end

function subVector(v1, v2)
    if not v1 or not v2 then return end

    if type(v1) == "number" then
        Spring.Echo("lib_UnitScript::Error:: Cant substract a Vector from a value!")
        return
    end

    if type(v2) == "number" then
        return { x = v1.x - v2, y = v1.y - v2, z = v1.z - v2 }
    else
        return { x = v1.x - v2.x, y = v1.y - v2.y, z = v1.z - v2.z }
    end
end

function applyForce(force, force2)
    return addVector(force, force2)
end

function normVector(v)
    l = math.sqrt(v.x * v.x + v.y * v.y + v.z * v.z)
    return { x = v.x / l, y = v.y / l, z = v.z / l }
end

function sumNormVector(v)
    sum = math.abs(v.x) + math.abs(v.y) + math.abs(v.z)
    return { x = v.x / sum, y = v.y / sum, z = v.z / sum }
end


function VDotProduct(V1, V2)
    if not V1 or not V2 then return nil end
    return DotProduct(V1.x, V1.y, V1.z, V2.x, V2.y, V2.z)
end

function Vabs(Vectors)
    return distance(Vectors.x, Vectors.y, Vectors.z)
end

function Vcross(V1, V2)
    if not V1 or not V2 then return nil end

    return (V1.y * V2.z - V1.z * V2.y) - (V1.x * V2.z - V1.z * V2.x) - (V1.x * V2.y - V1.y * V2.x)
end

function DotProduct(x, y, z, ax, ay, az)
    return x * ax + y * ay + az * z
end

--======================================================================================
--> gets a Vector from a Piece
function getVectorPieceRelPos(unitID, piece)
	 ex,ey,ez = Spring.GetUnitPiecePosition(unitID, piece)
	 return Vector:new(ex,ey,ez)
end
--> gets a Vector from a Piece
function getVectorPieceAbsPos(unitID, piece)
	 ex,ey,ez = Spring.GetUnitPiecePosDir(unitID, piece)
	 return Vector:new(ex,ey,ez)
end


--> old Vector constructor- uses lib_type constructor
function makeVector(x, y, z)
    return {x = x, y = y, z = z}
end


function getUnitPositionV(id)
	ix,iy,iz = Spring.GetUnitPosition(id)
	if ix then
	local v = Vector:new(ix, iy, iz)
		return v
	else
			local v =  Vector:new(0,0,0)
			return v
	end
end

function rangeClampVector(vector,range)
	vector= vector.normalized()
	vector= vector * range
	return vector
end
--======================================================================================
--Filter Functions
--======================================================================================

-->filtersOutUnitsOfType. Uses a Cache, if handed one to return allready Identified Units
function removeUnitsOfTypeInT(T, UnitTypeTable, Cache)
    if type(UnitTypeTable) == "number" then
        copyOfType = UnitTypeTable;
        UnitTypeTable = {}
        UnitTypeTable[copyOfType] = true
    end

    if Cache then
        returnTable = {}
        for num, id in pairs(T) do
            if (Cache[id] and Cache[id] == false) or   UnitTypeTable[Spring.GetUnitDefID(id)] == nil then
                Cache[id] = false
                returnTable[#returnTable + 1] = id
            else
                Cache[id] = true
            end
        end
        return returnTable, Cache

    else
        local returnTable = {}
        for num, id in pairs(T) do
            defID = Spring.GetUnitDefID(id)
            if not UnitTypeTable[defID] then
                returnTable[#returnTable + 1] = id
            end
        end
        return returnTable
    end
end

-->filtersOutUnitsOfType. Uses a Cache, if handed one to return allready Identified Units
function getUnitsOfTypeInT(T, UnitTypeTable, Cache)
    if type(UnitTypeTable) == "number" then
        copyOfType = UnitTypeTable;
        UnitTypeTable = {}
        UnitTypeTable[copyOfType] = true
    end

    if Cache then
        returnTable = {}
        for num, id in pairs(T) do
            if Cache[id] and Cache[id] == true or T[id] and UnitTypeTable[Spring.GetUnitDefID(id)] then
                Cache[id] = true
                returnTable[#returnTable + 1] = id
            else
                Cache[id] = false
            end
        end
        return returnTable, Cache

    else
        local returnTable = {}
        for num, id in pairs(T) do
            defID = Spring.GetUnitDefID(id)
            if UnitTypeTable[defID] then
                returnTable[#returnTable + 1] = id
            end
        end
        return returnTable
    end
end

function getUnarmedInT(T)
    returnTable = {}
    for num, id in pairs(T) do
        def = Spring.GetUnitDefID(id)
        if UnitDefs[def].canAttack or UnitDefs[def].canFight then
            returnTable[#returnTable + 1] = id
        end
    end
    return returnTable
end

-->filters Out TransportUnits
function getTransportsInT(T)
    returnTable = {}
    for num, id in pairs(T) do
        def = Spring.GetUnitDefID(id)
        if false == UnitDefs[def].isTransport then
            returnTable[#returnTable + 1] = id
        end
    end
    return returnTable
end

-->filters Out Immobile Units
function getImmobileInT(T, UnitDefs)
    returnTable = {}
    boolFilterOut = boolFilterOut or true
    for num, id in pairs(T) do
        def = Spring.GetUnitDefID(id)
        if UnitDefs[def].isImmobile == true then
            returnTable[#returnTable + 1] = id
        end
    end
    return returnTable
end

-->filters Out Immobile Units
function removeImmobileInT(T, UnitDefs)
    returnTable = {}
    boolFilterOut = boolFilterOut or true
    for num, id in pairs(T) do
        def = Spring.GetUnitDefID(id)
        if UnitDefs[def].isImmobile == false then
            returnTable[#returnTable + 1] = id
        end
    end
    return returnTable
end

function removeBuildingInT(T, UnitDefs)
   returnTable = {}

    for num, id in pairs(T) do
        def = Spring.GetUnitDefID(id)
    
        if  UnitDefs[def] and UnitDefs[def].isBuilding == false then
            returnTable[#returnTable + 1] = id
        end
    end
    return returnTable

end

--> filters Out Buildings
function getBuildingInT(T, UnitDefs)

    returnTable = {}

    for num, id in pairs(T) do
        def = Spring.GetUnitDefID(id)
        if  UnitDefs[def] and UnitDefs[def].isBuilding == true then
            returnTable[#returnTable + 1] = id
        end
     
    end
    return returnTable
end

--> filters Out Builders
function getBuilderInT(T)
    returnTable = {}
    for num, id in pairs(T) do
        def = Spring.GetUnitDefID(id)
        if false == UnitDefs[def].isBuilder then
            returnTable[#returnTable + 1] = id
        end
    end
    return returnTable
end

--> filters Out Mobile Builders
function getMobileBuildersInT(T, boolCondi)
    boolCond = boolCondi or false

    returnTable = {}
    for num, id in pairs(T) do
        def = Spring.GetUnitDefID(id)
        if boolCond == UnitDefs[def].isMobileBuilder then
            returnTable[#returnTable + 1] = id
        end
    end
    return returnTable
end

function getStaticBuildersInT(T)
    returnTable = {}
    for num, id in pairs(T) do
        def = Spring.GetUnitDefID(id)
        if false == UnitDefs[def].isStaticBuilder then
            returnTable[#returnTable + 1] = id
        end
    end
    return returnTable
end

function getFactorysInT(T)
    returnTable = {}
    for num, id in pairs(T) do
        def = Spring.GetUnitDefID(id)
        if false == UnitDefs[def].isFactory then
            returnTable[#returnTable + 1] = id
        end
    end
    return returnTable
end

function getExtractorsInT(T)
    returnTable = {}
    for num, id in pairs(T) do
        def = Spring.GetUnitDefID(id)
        if false == UnitDefs[def].isExtractor then
            returnTable[#returnTable + 1] = T[i]
        end
    end
    return returnTable
end

function getGroundUnitsInT(T)
    returnTable = {}
    for num, id in pairs(T) do
        def = Spring.GetUnitDefID(T[i])
        if false == UnitDefs[def].isGroundUnit then
            returnTable[#returnTable + 1] = T[i]
        end
    end
    return returnTable
end

function getAirUnitsInT(T, UnitDefs, lboolFilterOut)

    boolFilterOut = lboolFilterOut or false
    returnTable = {}
    for num, id in pairs(T) do
        def = Spring.GetUnitDefID(id)
        if boolFilterOut == UnitDefs[def].isAirUnit then
            returnTable[#returnTable + 1] = id
        end
    end
    return returnTable
end

function getStrafingAirUnitsInT(T)
    returnTable = {}
    for i = 1, #T do
        def = Spring.GetUnitDefID(T[i])
        if false == UnitDefs[def].isStrafingAirUnit then
            returnTable[#returnTable + 1] = T[i]
        end
    end
    return returnTable
end

function getNextKey(T, oldKey, boolFirst)
    boolNext = false

    if boolFirst then for k, v in pairs(T) do return k, v; end end

    for key, value in pairs(T) do
        if boolNext == true then
            return key, value
        end
        if key == oldKey then
            boolNext = true
        end
    end
end

function getHovringAirUnitsInT(T)
    returnTable = {}
    for i = 1, #T do
        def = Spring.GetUnitDefID(T[i])
        if false == UnitDefs[def].isHoveringAirUnit then
            returnTable[#returnTable + 1] = T[i]
        end
    end
    return returnTable
end

function getFighterAirUnitsInT(T)
    returnTable = {}
    for i = 1, #T do
        def = Spring.GetUnitDefID(T[i])
        if false == UnitDefs[def].isFighterAirUnit then
            returnTable[#returnTable + 1] = T[i]
        end
    end
    return returnTable
end

function getBomberAirUnitInT(T)
    returnTable = {}
    for i = 1, #T do
        def = Spring.GetUnitDefID(T[i])
        if false == UnitDefs[def].isBomberAirUnit then
            returnTable[#returnTable + 1] = T[i]
        end
    end
    return returnTable
end


--======================================================================================
--Sfx Operations
--======================================================================================
function spawnCegAtPiece(unitID, pieceId, cegname, offset)

    boolAdd = offset or 10


    if not unitID then error("lib_UnitScript::Not enough arguments to spawnCEGatUnit") end
    if not pieceId then error("lib_UnitScript::Not enough arguments to spawnCEGatUnit") end
    if not cegname then error("lib_UnitScript::Not enough arguments to spawnCEGatUnit") end
    x, y, z = Spring.GetUnitPiecePosDir(unitID, pieceId)

    if y then
        y = y + boolAdd
        Spring.SpawnCEG(cegname, x, y, z, 0, 1, 0, 0, 0)
    end
end

--> creates a ceg, that traverses following its behavioural function
function cegDevil(cegname, x, y, z, rate, lifetimefunc, endofLifeFunc, boolStrobo, range, damage, behaviour)
	endofLifeFunc= endofLifeFunc or function(x,y,z) end
	boolStrobo= boolStrobo or false
	range = range or 20
	damage = damage or 0
    knallfrosch = function(x, y, z, counter, v)
        if counter % 120 < 60 then -- aufwärts
            if v then
                return x * v.x, y * v.y, z * v.z, v
            else
                return x, y, z, { x = (math.random(10, 14) / 10) * randSign(), y = math.random(1, 2), z = (math.random(10, 14) / 10) * randSign() }
            end
        elseif Spring.GetGroundHeight(x, z) - y < 10 then --rest
            return x, y, z
        else --fall down
            if v and v.y < 0 then
                return x * v.x, y * v.y, z * v.z, v
            else
                return x, y, z, { x = (math.random(10, 11) / 10) * randSign(), y = math.random(1, 2), z = (math.random(10, 14) / 10) * randSign() }
            end
        end
    end
    functionbehaviour = behaviour or knallfrosch
    Time = 0
    local SpawnCeg = Spring.SpawnCEG
    v = makeVector(0, 0, 0)


    while lifetimefunc(Time) == true do
        x, y, z, v = functionbehaviour(x, y, z, Time, v)

        if boolStrobo == true then
            d = randVec()
            SpawnCeg(cegname, x, y, z, d.x, d.y, d.z, range, damage)
        else
            SpawnCeg(cegname, x, y, z, 0, 1, 0, range, damage)
        end

        Time = Time + rate
        Sleep(rate)
    end
	if endofLifeFunc then
    endofLifeFunc(x, y, z)
	end
end

--//////////////////////////////////////////////////////////////////////////////
--////////////////////////         Wild West Begin          ////////////////////
--//////////////////////////////////////////////////////////////////////////////

-->PieceDebug loop
function PieceLight(unitID, piecename, cegname)
    while true do
        x, y, z = Spring.GetUnitPiecePosDir(unitID, piecename)
        Spring.SpawnCEG(cegname, x, y + 10, z, 0, 1, 0, 50, 0)
        Sleep(250)
    end
end

-->SortPoint
function makePiecePoint(piece)
    x, y, z = Spring.GetUnitPiecePosDir(unitID, piece)
    return { x = x, y = y, z = z }
end

function makePieceMap(unitID)
    List = Spring.GetUnitPieceMap(unitID)
    return List or {}
end

function hideAllPieces(unitID)
    List = Spring.GetUnitPieceMap(unitID)

    for k, v in pairs(List) do
        Hide(v)
    end
end

--> Attaches a Unit to a Piece near a Impact side
function AttachUnitToPieceNearImpact(toAttachUnitID, AttackerID, px, py, pz, range)
    T = getAllInCircle(px, pz, range)
    boolFirstMatch = false
    process(T,
        function(id)
            if Spring.GetUnitLastAttacker(id) == AttackerID then
                return id
            end
        end,
        function(id)
            if boolFirstMatch == true then return end

            lastAttackedPiece = Spring.GetUnitLastAttackedPiece(id)
            if lastAttackedPiece then
                boolFirstMatch = true
                Spring.UnitAttach(id, toAttachUnitID, lastAttackedPiece)
            end
        end)
end


function getTeamSide(teamid)
    teamID, leader, isDead, isAiTeam, side, allyTeam, customTeamKeys, incomeMultiplier = Spring.GetTeamInfo(teamid)
    return side, teamID, leader, isDead, isAiTeam, allyTeam, customTeamKeys, incomeMultiplier
end

function getUnitSide(unitID)
    teamid = Spring.GetUnitTeam(unitID)
    return getTeamSide(teamid)
end




-->idle Animation Loop
function idleLoop(Body, axis, FrontLeg, RearLeg, degree, BodyBackDeg, speed, Time, boolNoDown)

    Turn(Body, axis, math.rad(degree), speed)
    for i = 1, #FrontLeg, 1 do
        Turn(FrontLeg[i].Up, axis, math.rad(-degree), speed)
        if boolNoDown == false then
            Turn(FrontLeg[i].Down, axis, math.rad(0), speed)
        end
    end

    for i = 1, #RearLeg, 1 do
        Turn(RearLeg[i].Up, axis, math.rad(-degree), speed)
        if boolNoDown == false then
            Turn(RearLeg[i].Down, axis, math.rad(0), speed)
        end
    end

    for i = 1, #FrontLeg, 1 do
        WaitForTurns(FrontLeg[i].Up)
        if boolNoDown == false then
            WaitForTurns(FrontLeg[i].Down)
        end
    end

    for i = 1, #RearLeg, 1 do
        WaitForTurns(RearLeg[i].Up)
        if boolNoDown == false then
            WaitForTurns(RearLeg[i].Down)
        end
    end
    WaitForTurn(Body, axis)
    Sleep(Time)

    Turn(Body, axis, math.rad(BodyBackDeg), speed)
    for i = 1, #FrontLeg, 1 do
        Turn(FrontLeg[i].Up, axis, math.rad(-BodyBackDeg), speed)
        if boolNoDown == false then
            Turn(FrontLeg[i].Down, axis, math.rad(0), speed)
        end
    end

    for i = 1, #RearLeg, 1 do
        Turn(RearLeg[i].Up, axis, math.rad(-BodyBackDeg), speed)
        if boolNoDown == false then
            Turn(RearLeg[i].Down, axis, math.rad(0), speed)
        end
    end
    for i = 1, #FrontLeg, 1 do
        WaitForTurns(FrontLeg[i].Up)
        if boolNoDown == false then
            WaitForTurns(FrontLeg[i].Down)
        end
    end

    for i = 1, #RearLeg, 1 do
        WaitForTurns(RearLeg[i].Up)
        if boolNoDown == false then
            WaitForTurns(RearLeg[i].Down)
        end
    end
    WaitForTurn(Body, axis)
    Sleep(Time)
end

function getUnitName(UnitDef, UnitDefID)
    for name, def in pairs(UnitDef) do
        if def.id == UnitDefID then
            return name
        end
    end
    return "UnitName not found in UnitDefID:: UnitParsing Errors"
end



-->Get the Ground Normal, uses a handed over function and returns a corresponding Table
function getGroundMapTable(Resolution, HandedInFunction)
    ReT = {}
    local spGetGroundNormal = Spring.GetGroundNormal
    for x = 1, Game.mapSizeX, Resolution do
        ReT[x] = {}
        for y = 1, Game.mapSizeY, Resolution do
            dx, dy, dz = spGetGroundNormal(x, y)
            ReT[x][y] = Helperfunction(dx, dy, dz)
        end
    end
    return ReT
end

-->Generalized map processing Function
-->Get the Ground Normal, uses all handed over functions for processing and returns a corresponding Table
function doForMapPos(Resolution, ...)
    local arg = arg; if (not arg) then arg = { ... }; arg.n = #arg end

    for k, v in pairs(arg) do if type(v) ~= "function" then return Spring.Echo(" Argument is not a processing function") end end

    ReT = {}
    for x = 1, Game.mapSizeX, Resolution do
        ReT[x] = {}
        for y = 1, Game.mapSizeY, Resolution do
            res = {}
            for k, v in pairs(arg) do
                res = arg(x, y, res)
            end
            ReT[x][y] = res
        end
    end
    return ReT
end



-->Function estimates the relative Position of a Piece to another by comparing ther Coordinates
function PieceStarCoordPiece(myPos, PiecePos, cubicsize)

    --[1]=--front
    --[2]=--rear
    --[3]=--side left
    --[4]=	--side right
    --[5]=	--up
    --[6]=	--low


    if withinRange(myPos.y, PiecePos.y, cubicsize) == true then

        if withinRange(myPos.x, PiecPos.x, cubicsize) == true then -- Piece is on the side
            if myPos.z > piecePos.z then return 3 else return 4 end
        else -- Piece is either in front or behind
            if myPos.x > piecePos.x then return 2 else return 1 end
        end
    else -- pos is either above or below the layer 
        if myPos.y > PiecePos.y then return 6 else return 5 end
    end
end

--> checks wether a value with threshold factor is within range of a second value
function withinRange(value1, value2, treShold)
    if value1 * treShold > value2 or value1 * (1 - treShold) < treShold then
        return true
    else
        return false
    end
end

--> Checks wether a Point is within a six sided polygon
function sixPointInsideDetAlgo(x1, y1, x2, y2, x3, y3, x4, y4, x5, y5, x6, y6, xPoint, yPoint)
    boolInside = true
    detSum = 0
    for i = 0, 6, 1 do
        tempdet = 0.5 * ((x((i + 1) % 7)) * (y((i + 2) % 7)) + (x((i + 2) % 7)) * (y((i + 1) % 7)))
        detSum = detSum + tempdet
    end

    if detSum >= 0 then
        boolInside = false
    end

    return boolInside
end

-->Gets the Height of a Unit
function getunitHeight(UnitId)
    _, y, _ = Spring.GetUnitPosition(unitID)
    return y
end



-->gets the original Mapheight
function getHistoricHeight(UnitId)
    tempX, tempY, tempZ = Spring.GetUnitPosition(UnitId)
    tempY = Spring.GetGroundOrigHeight(tempX, tempZ)
    return tempY
end

--> returns true if point is within range -returns false if it is on the outside
local previousResult
local previousCubic
local rangeOfOld = -1


--> faster way of finding out wether a point is within a circle
function isWithinCircle(circleRange, xCoord, zCoord)
    newCubic = 0
    if rangeOfOld == circleRange then
        newCubic = previousCubic
    else
        newCubic = 0.7071067811865475 * circleRange
        previousCubic = newCubic
    end

    negCircleRange = -1 * circleRange

    --checking the most comon cases |Coords Outside the Circlebox
    if xCoord > circleRange or xCoord < negCircleRange then
        return false
    end

    if zCoord > circleRange or zCoord < negCircleRange then
        return false
    end

    negNewCubic = -1 * newCubic


    --checking everything within the circle box
    if (xCoord < newCubic and xCoord > negNewCubic) and (zCoord < newCubic and zCoord > negNewCubic) then
        return true
    end


    -- very few cases make it here.. to the classic, bad old range compare
    if math.sqrt(xCoord ^ 2 + zCoord ^ 2) < circleRange then
        return true
    else
        return false
    end
end



-->generates a Pieces List Keyed to the PieceName
function makeKeyPiecesTable(unitID, piecefunction)

    returnTable = {}
    piecesTable = Spring.GetUnitPieceList(unitID)

    if piecesTable ~= nil then
        for i = 1, #piecesTable, 1 do
            returnTable[piecesTable[i]] = piecefunction(piecesTable[i])
        end
    end
    return returnTable
end


function makePieceTable(unitID)
    RetT = {}
    piecesTable = Spring.GetUnitPieceMap(unitID)
    for k, v in pairs(piecesTable) do
        RetT[#RetT + 1] = v
    end
    return RetT
end


-->generates a Pieces List 
function generatepiecesTableAndArrayCode(unitID, boolLoud)
    bLoud = boolLoud or false

    if bLoud == true then
        Spring.Echo("")
        Spring.Echo("--PIECESLIST::BEGIN |>----------------------------")
        Spring.Echo("piecesTable={}")
        piecesTable = {}
        piecesTable = Spring.GetUnitPieceList(unitID)
        --Spring.Echo("local piecesTable={}")
        if piecesTable ~= nil then
            for i = 1, #piecesTable, 1 do
                workingString = piecesTable[i]
                Spring.Echo("" .. piecesTable[i] .. " = piece(\"" .. piecesTable[i] .. "\")\n piecesTable[#piecesTable+1]= " .. piecesTable[i])
            end
        end

        Spring.Echo("PIECESLIST::END |>-----------------------------")
    end


    return makePieceTable(unitID)
end


--> finds GenericNames and Creates Tables with them
function makePiecesTablesByNameGroups(boolMakePiecesTable, boolSilent)

    boolSilentRun = boolSilent or true
    pieceMap = Spring.GetUnitPieceMap(unitID)
    piecesTable = Spring.GetUnitPieceList(unitID)

    TableByName = {}
    NameAndNumber = {}
    ReturnTable = {}

    for i = 1, #piecesTable, 1 do
        s = string.reverse(piecesTable[i])

        for w in string.gmatch(s, "%d+") do
            if w then
                s = string.sub(s, string.len(w), string.len(s))
                NameAndNumber[i] = {
                    name = string.sub(piecesTable[i], 1, string.len(piecesTable[i]) - string.len(w)),
                    number = string.reverse(w)
                }

                if TableByName[NameAndNumber[i].name] then
                    TableByName[NameAndNumber[i].name] = TableByName[NameAndNumber[i].name] + 1
                else
                    TableByName[NameAndNumber[i].name] = 1
                end
                break
            end
        end
        if not NameAndNumber[i] then NameAndNumber[i] = { name = string.reverse(s) } end
    end


    if boolSilentRun == false then
        for k, v in pairs(TableByName) do
            if v > 1 then
                Spring.Echo(k .. " = {}")
            end
        end


        for k, v in pairs(NameAndNumber) do

            if v and v.number then
                Spring.Echo(v.name .. v.number .. " = piece\"" .. v.name .. v.number .. "\"")
                Spring.Echo(v.name .. "[" .. v.number .. "]= " .. v.name .. v.number)
            else
                Spring.Echo(v.name .. " = piece(" .. v.name .. ")")
            end
        end

        if boolMakePiecesTable and boolMakePiecesTable == true then
            generatepiecesTableAndArrayCode(unitID)
        end

    else

        --pack the piecesTables in a UeberTable by Name
        for tableName, _ in pairs(TableByName) do
            local PackedAllNames = {}
            --Add the Pieces to the Table
            for k, v in pairs(NameAndNumber) do

                if v and v.number and v.name == tableName then
                    piecename = v.name .. v.number
                    if lib_boolDebug == true then
                        if lib_boolDebug == true and pieceMap[piecename] then
                            Spring.Echo(v.name .. "[" .. v.number .. "] = " .. piecename .. " Piecenumber: " .. pieceMap[piecename])
                        else
                            Spring.Echo("pieceMap contains no piece named " .. piecename)
                        end
                    end
                    convertToNumber = tonumber(v.number)
                    PackedAllNames[convertToNumber] = pieceMap[piecename]
                end
            end
            ReturnTable[tableName] = PackedAllNames
        end

        return ReturnTable
    end
end

function getUnitPieceVolume(unit, Piece)
vx, vy, vz = Spring.GetUnitPieceCollisionVolumeD
	if vx then
		return math.abs(vx*vy*vz) 
	end
return 0
end


function getUnitBiggestPiece(unit, cache)
defID= Spring.GetUnitDefID(unit)
if cache and cache[defID] then return cache[defID], cache end

volumeMax = -math.huge
biggestPieceSoFar= nil
pieceMap= Spring.GetUnitPieceMap(unit)

	for name,number in pairs(pieceMap) do
		volume = getUnitPieceVolume(unit, number)
			if volume > volumeMax then
			biggestPieceSoFar= number
			volumeMax = volume 
			end
	end
	
cache[defID] = biggestPieceSoFar
return biggestPieceSoFar, cache
end

--> Transfers a World Position into Unit Space
function worldPosToLocPos(owpX, owpY, owpZ, wpX, wpY, wpZ)
    return wpX - owpX, wpY - owpY, wpZ - owpZ
end

-->allows for a script breakpoint via widget :TODO incomplete
function stop(name)
    lib_boolOnce = false
    while true do
        Sleep(3000)
        if lib_boolOnce == false then
            lib_boolOnce = true
            Spring.Echo("Script at " .. name .. " has stopped")
        end
    end
end

function delayedHide(piece, timeT)
	Sleep(timeT)
	Hide(piece)
end

function delayedShow(piece, timeT)
	Sleep(timeT)
	Show(piece)
end

-->Validates that a table of UnitIds or a UnitID still exist and is alive
-->Non existant ids are silently filtered out
function affirm(T)
    if type(T) == "number" then t1 = T; T = { [1] = t1 } end
    resulT = process(T,
        function(id)
            if exists(id) == true then return id end
        end)
    if resulT then
        if #resulT > 1 then
            return resulT else
            return resulT[1]
        end
    end
end

-->Unit Verfication
function exists(unitid)
    validUnit = Spring.GetUnitIsDead(unitid)
    if validUnit and validUnit == true then return true end

    return false
end

--> This function process result of Spring.PathRequest() to say whether target is reachable or not
function IsTargetReachable(moveID, ox, oy, oz, tx, ty, tz, radius)
    local result, lastcoordinate, waypoints
    local path = Spring.RequestPath(moveID, ox, oy, oz, tx, ty, tz, radius)
    if path then
        local waypoint = path:GetPathWayPoints() --get crude waypoint (low chance to hit a 10x10 box). NOTE; if waypoint don't hit the 'dot' is make reachable build queue look like really far away to the GetWorkFor() function.
        local finalCoord = waypoint[#waypoint]
        if finalCoord then --unknown why sometimes NIL
            local dx, dz = finalCoord[1] - tx, finalCoord[3] - tz
            local dist = math.sqrt(dx * dx + dz * dz)
            if dist <= radius + 20 then --is within radius?
                result = true
                lastcoordinate = finalCoord
                waypoints = waypoint
            else
                result = false
                lastcoordinate = finalCoord
                waypoints = waypoint
            end
        end
    else
        result = true
        lastcoordinate = nil
        waypoints = nil
    end
	
    return result, lastcoordinate, waypoints
end

--forceFunctionTable Example
function hitByExplosionAtCenter(objX, objY, objZ, worldX, worldY, worldZ, objectname, mass, dirX, dirY, dirZ)
    objX, objY, objZ = objX - worldX, objY - worldY, objZ - worldZ
    distanceToCenter = (objX ^ 2 + objY ^ 2 + objZ ^ 2) ^ 0.5
    blastRadius = 350
    Force = 4000000000000
    factor = blastRadius / (2 ^ distanceToCenter)
    if distanceToCenter > blastRadius then factor = 0 end
    normalIsDasNicht = math.max(math.abs(objX), math.max(math.abs(objY), math.abs(objZ)))

    objX, objY, objZ = objX / normalIsDasNicht, objY / normalIsDasNicht, objZ / normalIsDasNicht
    --density of Air in kg/m^3 -- area
    airdrag = 0.5 * 1.1455 * ((normalIsDasNicht * factor * Force) / mass) ^ 2 * 15 * 0.47

    if math.abs(objX) == 1 then
        return objX * factor * Force - airdrag, objY * factor * Force, objZ * factor * Force
    elseif math.abs(objY) == 1 then

        return objX * factor * Force, objY * factor * Forceairdrag, objZ * factor * Force
    else

        return objX * factor * Force, objY * factor * Force, objZ * factor * Forceairdrag
    end
end

--> a Pseudo Physix Engien in Lua, very expensive, dont use extensive	--> forceHead(objX,objY,objZ,worldX,worldY,worldZ,objectname,mass)
function PseudoPhysix(piecename, pearthTablePiece, nrOfCollissions, forceFunctionTable)


    speed = math.random(1, 4)
    rand = math.random(10, 89)
    Turn(piecename, x_axis, math.rad(rand), speed)
    dir = math.random(-90, 90)
    speed = math.random(1, 3)
    Turn(piecename, y_axis, math.rad(dir), speed)


    --SpeedUps
    local spGPos = Spring.GetUnitPiecePosDir
    local spGGH = Spring.GetGroundHeight
    local spGN = Spring.GetGroundNormal
    local mirAng = mirrorAngle
    local spGUPP = Spring.GetUnitPiecePosition
    local spGUP = Spring.GetUnitPosition
    local ffT = forceFunctionTable
    posX, posY, posZ, dirX, dirY, dirZ = spGPos(unitID, pearthTablePiece)
    ForceX, ForceY, ForceZ = 0, 0, 0
    oposX, oposY, oposZ = posX, posY, posZ


    mass = 600
    simStep = 75
    gravity = -1 * (Game.gravity) -- in Elmo/s^2 --> Erdbeschleunigung 

    --tV=-1* 
    terminalVelocity = -1 * (math.abs((2 * mass * gravity)) ^ 0.5)
    ForceGravity = -1 * (mass * Game.gravity) -- kgE/ms^2

    GH = spGGH(posX, posZ) --GroundHeight
    if oposY < GH then oposY = GH end



    VelocityX, VelocityY, VelocityZ = 0, 0, 0
    factor = (1 / 1000) * simStep


    boolRestless = true

    while boolRestless == true do

        -- reset
        ForceX, ForceY, ForceZ = 0, 0, 0

        -- update
        posX, posY, posZ, dirX, dirY, dirZ = spGPos(unitID, pearthTablePiece)
        _, _, _, dirX, dirY, dirZ = spGPos(unitID, piecename)

        --normalizing
        normalizer = math.max(math.max(dirX, dirY), dirZ)
        if normalizer == nil or normalizer == 0 then normalizer = 0.001 end
        dirX, dirY, dirZ = dirX / normalizer, dirY / normalizer, dirZ / normalizer

        -- applying gravity and forces 
        ForceY = ForceGravity

        if ffT ~= nil then --> forceHead(objX,objY,objZ,oDirX,oDirY,oDirZ,objectname,dx,dy,dz)
            bx, by, bz = Spring.spGUP(unitID)
            dx, dy, dz = spGUPP(unitID, piecename)
            dmax = math.sqrt(dx ^ 2 + dy ^ 2 + dz ^ 2)
            dx, dy, dz = dx / dmax, dy / dmax, dz / dmax

            for i = 1, #ffT, 1 do
                f2AddX, f2AddY, f2AddZ = ffT[i](posX, posY, posZ, bx, by, bz, piecename, mass, dx, dy, dz)
                ForceX = ForceX + f2AddX
                ForceY = ForceY + f2AddY
                ForceZ = ForceZ + f2AddZ
            end
        end

        GH = spGGH(posX + VelocityX + (ForceX / mass) * factor, posZ + VelocityZ + (ForceZ / mass) * factor)
        boolCollide = false


        --GROUNDcollission

        if (posY - GH - 15) < 0 then
            boolCollide = true
            nrOfCollissions = nrOfCollissions - 1


            total = math.abs(VelocityX) + math.abs(VelocityY) + math.abs(VelocityZ)
            --get Ground Normals

            nX, nY, nZ = spGN(posX, posZ)
            max = math.max(nX, math.max(nY, nZ))
            _, tnY, _ = nX / max, nY / max, nZ / max

            --if still enough enough Force or stored kinetic energy
            if total > 145.5 or nrOfCollissions > 0 or tnY < 0.5 then
            else
                --PhysixEndCase
                boolRestless = false
            end


            VelocityX, VelocityY, VelocityZ = 0, 0, 0


            --could do the whole torque, but this prototype has fullfilled its purpose
            --	up=math.max(math.max((total/mass)%5,4),1)+1

            dirX, dirY, dirZ = mirAng(nX, nY, nZ, dirX, dirY, dirZ)
            speed = math.random(5, 70) / 10
            Turn(piecename, x_axis, dirX, speed)
            speed = math.random(5, 60) / 10
            Turn(piecename, y_axis, dirY, speed)
            speed = math.random(5, 50) / 10
            Turn(piecename, z_axis, dirZ, speed)



            --we have the original force * constant inverted - Gravity and Ground channcel each other out
            RepulsionForceTotal = ((math.abs(ForceY) + math.abs(ForceZ) + math.abs(ForceX)) * -0.65)
            ForceY = ForceY + ((dirY * RepulsionForceTotal))

            ForceX = ForceX + ((dirX * RepulsionForceTotal))
            ForceZ = ForceZ + ((dirZ * RepulsionForceTotal))
            VelocityY = math.max(VelocityY + ((ForceY / mass) * factor), terminalVelocity * factor)

        else

            --FreeFall		

            VelocityY = math.max(VelocityY + ((ForceY / mass) * factor), terminalVelocity * factor)
        end



        VelocityX = math.abs(VelocityX + (ForceX / mass) * factor)
        VelocityZ = math.abs(VelocityZ + (ForceZ / mass) * factor)

        --Extract the Direction from the Force
        xSig = ForceX / math.max(math.abs(ForceX), 0.000001)
        ySig = ForceY / math.max(math.abs(ForceY), 0.000001)
        zSig = ForceZ / math.max(math.abs(ForceZ), 0.000001)

        -- FuturePositions
        fX, fY, fZ = worldPosToLocPos(oposX, oposY, oposZ, posX + math.abs(VelocityX) * xSig, posY + math.abs(VelocityY) * ySig, posZ + math.abs(VelocityZ) * zSig)

        if boolCollide == true or boolRestless == false or (fY - GH - 12 < 0) then fY = -1 * oposY + GH end
        --Debugdatadrop

        --	Spring.Echo("ySig",ySig.."	Physix::ComendBonker::fY",fY.."VelocityY::",VelocityY .." 	ForceY::",ForceY .." 	POSVAL:", posY + VelocityY*ySig)

        Move(pearthTablePiece, x_axis, fX, VelocityX * 1000 / simStep + 0.000000001)
        Move(pearthTablePiece, y_axis, fY, VelocityY * 1000 / simStep)
        Move(pearthTablePiece, z_axis, fZ, VelocityZ * 1000 / simStep + 0.000000001)



        Sleep(simStep)
    end
end


function getDigits(number)
    digit = 1
    if number < 0 then digit = 2 end
    while math.abs(number) > 10 do
        number = number / 10
        digit = digit + 1
    end
    return digit
end



function inherit(childClass, parent)
    local orig_type = type(parent)
	local copy = parentClass or {}
  
        for orig_key, orig_value in next, parent, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(parent)))

    return copy
end

-- This code is a adapted Version of the NeHe-Rope Tutorial. All Respect towards those guys.
-- RopePieceTable by Convention contains (SegmentBegin)----(SegmentEnd)(SegmentBegin)----(SegmentEnd) 
-- RopeConnectionPiece PieceID-->ContainsMass,ColRadius |
 
-- ForceFunction --> forceHead(objX,objY,objZ,worldX,worldY,worldZ,objectname,mass)


function ropePhysix(RopePieceTable, MassLengthPerPiece, forceFunctionTable, SpringConstant, boolDebug)

    --SpeedUps
    assert(RopePieceTable, "RopePieceTable not provided")
    assert(MassLengthPerPiece, "MassLengthPerPiece not provided")

    assert(forceFunctionTable, "forceFunctionTable not provided")
    assert(SpringConstant, "SpringConstant not provided")

    local spGPos = Spring.GetUnitPiecePosDir
    local spGGH = Spring.GetGroundHeight
    local spGN = Spring.GetGroundNormal
    local spGUPP = Spring.GetUnitPiecePosition
    local spGUP = Spring.GetUnitPosition
    local ffT = forceFunctionTable
    local groundHeight = function(piece)
        x, y, z, _, _, _ = Spring.GetUnitPiecePosDir(unitID, piece)
        return Spring.GetGroundHeight(x, z)
    end
    -- Each Particle Has A Weight Of 50 Grams
	
	
	

end

--add Operators to unitscript

function eraNonArgMul(A, B)
    if A == "0" or B == "0" or A == "" or B == "" then return ""
    else return "(" .. A .. "*" .. B .. ")"
    end
end

function eraNonArgAdd(A, B)
    if A == "0" or A == "" and B ~= "0" and B ~= "" then return B end
    if B == "0" or B == "" and A ~= "0" and A ~= "" then return A end
    return A .. "+" .. B
end

--> used to calc shadder matrixes in lua.. fill in, calc, optimize, print out
function matrixLab()
    mA = {
        [1] = "cos(z)",
        [2] = "-sin(z)",
        [3] = "0",
        [4] = "sin(z)",
        [5] = "cos(z)",
        [6] = "0",
        [7] = "0",
        [8] = "0",
        [9] = "1",
    }
    mB = {
        [1] = "-1",
        [2] = "0",
        [3] = "0",
        [4] = "0",
        [5] = "cos(x)",
        [6] = "-sin(x)",
        [7] = "0",
        [8] = "sin(x)",
        [9] = "cos(x)",
    }
    mC = {
        [1] = "cos(y)",
        [2] = "0",
        [3] = "sin(y)",
        [4] = "0",
        [5] = "1",
        [6] = "0",
        [7] = "-sin(y)",
        [8] = "0",
        [9] = "cos(y)",
    }


    mD = MatrixBuilder3x3(MatrixBuilder3x3(mA, mB), mC)
    --echoT(mD)
end

function mirrorMatriceXAxis(x, y, z)
    --return 360-x,y,z*-1																																							

    x = ((-1 * math.cos(z)) * math.cos(y)) + ((-1 * math.sin(z) * -1 * math.sin(x)) * -1 * math.sin(y)) * x + ((-1 * math.sin(z) * math.cos(x))) * y + ((-1 * math.cos(z)) * math.sin(y)) + ((-1 * math.sin(z) * -1 * math.sin(x)) * math.cos(y)) * z

    y = ((-1 * math.sin(z)) * math.cos(y)) + ((math.cos(z) * -1 * math.sin(x)) * -1 * math.sin(y)) * x + ((math.cos(z) * math.cos(x))) * y + ((-1 * math.sin(z)) * math.sin(y)) + ((math.cos(z) * -1 * math.sin(x)) * math.cos(y)) * z

    z = ((math.cos(x)) * -1 * math.sin(y)) * x + ((math.sin(x))) * y + ((math.cos(x)) * math.cos(y)) * z
    return x, y, z
end

function MatrixBuilder3x3(A, B)
    return {
        [1] = eraNonArgAdd(eraNonArgAdd(eraNonArgMul(A[1], B[1]), eraNonArgMul(A[2], B[4])), eraNonArgMul(A[3], B[7])),
        [2] = eraNonArgAdd(eraNonArgAdd(eraNonArgMul(A[1], B[2]), eraNonArgMul(A[2], B[5])), eraNonArgMul(A[3], B[8])),
        [3] = eraNonArgAdd(eraNonArgAdd(eraNonArgMul(A[1], B[3]), eraNonArgMul(A[2], B[6])), eraNonArgMul(A[3], B[9])),
        [4] = eraNonArgAdd(eraNonArgAdd(eraNonArgMul(A[4], B[1]), eraNonArgMul(A[5], B[4])), eraNonArgMul(A[6], B[7])),
        [5] = eraNonArgAdd(eraNonArgAdd(eraNonArgMul(A[4], B[2]), eraNonArgMul(A[5], B[5])), eraNonArgMul(A[6], B[8])),
        [6] = eraNonArgAdd(eraNonArgAdd(eraNonArgMul(A[4], B[3]), eraNonArgMul(A[5], B[6])), eraNonArgMul(A[6], B[9])),
        [7] = eraNonArgAdd(eraNonArgAdd(eraNonArgMul(A[7], B[1]), eraNonArgMul(A[8], B[4])), eraNonArgMul(A[9], B[7])),
        [8] = eraNonArgAdd(eraNonArgAdd(eraNonArgMul(A[7], B[2]), eraNonArgMul(A[8], B[5])), eraNonArgMul(A[9], B[8])),
        [9] = eraNonArgAdd(eraNonArgAdd(eraNonArgMul(A[7], B[3]), eraNonArgMul(A[8], B[6])), eraNonArgMul(A[9], B[9])),
    }
end




function midVector(PointA, PointB)
    PointA.x, PointA.y, PointA.z = PointA.x + PointB.x, PointA.y + PointB.y, PointA.z + PointB.z
    return divVector(PointA, 2)
end


function checkCenterPastPoint(MidPoint, GatePoint, PrevGatePoint)

    OrgPoint = subVector(GatePoint, PrevGatePoint)
    assert(OrgPoint)
    MirrorPointV = mulVector(OrgPoint, -1)

    -- if distance to PrevGatePoint < then distance to mirrored Point
    if norm2Vector(subVector(MirrorPointV, MidPoint)) >= norm2Vector(subVector(OrgPoint, MidPoint)) then
        return true
    else
        return false
    end
end

function absVec(vec)
    vec.x = math.abs(vec.x)
    vec.y = math.abs(vec.y)
    vec.z = math.abs(vec.z)
    return vec
end

function eqVec(vecA, vecB)
    return vecA.x == vecB.x and vecA.y == vecB.y and vecA.z == vecB.z
end

function spawnCegAtPiece(unitID, pieceId, cegname, offset)

    boolAdd = offset or 10


    if not unitID then error("lib_UnitScript::Not enough arguments to spawnCEGatUnit") end
    if not pieceId then error("lib_UnitScript::Not enough arguments to spawnCEGatUnit") end
    if not cegname then error("lib_UnitScript::Not enough arguments to spawnCEGatUnit") end
    x, y, z = Spring.GetUnitPiecePosDir(unitID, pieceId)

    if y then
        y = y + boolAdd
        Spring.SpawnCEG(cegname, x, y, z, 0, 1, 0, 0, 0)
    end
end

function getPieceMap(id)

    dpiecesTable = Spring.GetUnitPieceMap(id)
    ux, uy, uz = Spring.GetUnitPosition(id)
    tpiecesTable = {}
    i = 1
    for k, v in pairs(dpiecesTable) do
        x, y, z = Spring.GetUnitPiecePosDir(id, v)
        tpiecesTable[i] = {}
        tpiecesTable[i].pid = v
        tpiecesTable[i].x = x or ux
        tpiecesTable[i].y = y or uy
        tpiecesTable[i].z = z or uz
        i = i + 1
    end
    return tpiecesTable
end

function getFrameDepUnqOff(limit)
    if not GG.FrameDependentOffset then GG.FrameDependentOffset = { val = 0, frame = Spring.GetGameFrame() } end
    if GG.FrameDependentOffset.frame ~= Spring.GetGameFrame() then GG.FrameDependentOffset.val = 0; GG.FrameDependentOffset.frame = Spring.GetGameFrame() end

    GG.FrameDependentOffset.val = GG.FrameDependentOffset.val + 1
    sign = randSign()
    return sign * math.random(0, (GG.FrameDependentOffset.frame * GG.FrameDependentOffset.val) % limit + 1)
end

--> Play a soundfile only by unittype
function PlaySoundByUnitDefID(unitdef, soundfile, loudness, Time, nrOfUnitsParallel, predelay)
    if not unitdef then return false end
    if predelay and predelay > 0 then Sleep(predelay) end

    loud = loudness or 1
    if loud == 0 then loud = 1 end

    if GG.UnitDefSoundLock == nil then GG.UnitDefSoundLock = {} end
    if GG.UnitDefSoundLock[unitdef] == nil then GG.UnitDefSoundLock[unitdef] = 0 end

    if GG.UnitDefSoundLock[unitdef] < nrOfUnitsParallel then
        GG.UnitDefSoundLock[unitdef] = GG.UnitDefSoundLock[unitdef] + 1
        Spring.PlaySoundFile(soundfile, loud)
        if Time > 0 then
            Sleep(Time)
        end
        GG.UnitDefSoundLock[unitdef] = GG.UnitDefSoundLock[unitdef] - 1
        return true
    end
    return false
end

--This Takes any LanguageString and 'translates' it meaning it replaces stringparts with the Sound
--This is deterministic, meaning for a person and LanguageTable it always produces the same sound
--SoundPerson is a Function that allows to convay additional params into the sound-
--e.g. Out of Breath, Angry, tired, sad, by changing loudness and choosen soundsnippet
--its call signature is SoundPerson(translatedSoundSnippet, position in sentence, translatedTable)
function speakMorkDorkUruk(LanguageTable, SymbolLenght, SoundTable, Text, ScreenPos, StandardLoud, LoudRange, SoundPerson)

    --translate the Text via the language Table
    local lplaySoundFile = Spring.PlaySoundFile
    local translatedTable = {}
    local lSoundPerson = SoundPerson or nil

    for i = 1, #Text do
        c = str:sub(i, math.min(#Text, i + SymbolLenght))
        hash = LanguageTable.Hash(c)
        translatedTable[i] = LanguageTable[hash] or " "
    end

    if lSoundPerson then
        for it = 1, #translatedTable do
            choosenSound, loudness = lSoundPerson(translatedTable[it], it, translatedTable)
            if SoundTable[choosenSound] then
                lplaySoundFile(SoundTable[choosenSound], loudness)
            end
        end
    else
        lplaySoundFile(SoundTable[choosenSound], StandardLoud + math.random(LoudRange / 10, LoudRange))
    end
end

function getLowestPointOfSet(Table, axis)
    if #Table < 1 then return nil end

    index = 1
    y = math.huge
    if axis == "y_axis" then
        for i = 1, #Table do
            if Table[i].y < y then
                y = Table[i].y
                index = i
            end
        end
    end
    if axis == "z_axis" then
        for i = 1, #Table do
            if Table[i].z < y then
                y = Table[i].z
                index = i
            end
        end
    end
    if axis == "x_axis" then
        for i = 1, #Table do
            if Table[i].x < y then
                y = Table[i].x
                index = i
            end
        end
    end
    return Table[index].x, Table[index].y, Table[index].z, index
end

function getHighestPointOfSet(Table, axis)
    if type(Table) ~= "table" then
        echo("getHighestPointOfSet:not a table")
        return nil
    end

    if #Table < 1 or table.getn(Table) == 0 then
        echo("getHighestPointOfSet:table is empty")
        return nil
    end

    index = 1
    y = -math.huge
    if axis == "y_axis" then
        for i = 1, #Table do
            if Table[i].y > y then
                y = Table[i].y
                index = i
            end
        end
    end
    if axis == "z_axis" then
        for i = 1, #Table do
            if Table[i].z > y then
                y = Table[i].z
                index = i
            end
        end
    end
    if axis == "x_axis" then
        for i = 1, #Table do
            if Table[i].x > y then
                y = Table[i].x
                index = i
            end
        end
    end


    return Table[index].x, Table[index].y, Table[index].z, index
end

function getNearestGroundEnemy(id, UnitDefs)
    ed = Spring.GetUnitNearestEnemy(id)
    if ed then
        --early out
        eType = Spring.GetUnitDefID(ed)

        if UnitDef[eType].isAirUnit == false then return ed end
        eTeam = Spring.GetUnitTeam()
        allUnitsOfTeam = Spring.GetTeamUnits(eTeam)
        mindist = math.huge
        foundUnit = nil

        process(allUnitsOfTeam,
            function(ied)
                if ied ~= ed and distanceUnitToUnit(id, ied) < mindist then
                    if UnitDef[Spring.GetUnitDefID(ied)].isAirUnit == false then
                        mindist = distanceUnitToUnit(id, ied)
                        foundUnit = ied
                    end
                end
            end)
        if Spring.ValidUnitID(foundUnit) == true then return foundUnit end
    end
end


function pieceToPoint(pieceNumber)
    reTab = {}

    reTab.x, reTab.y, reTab.z = Spring.GetUnitPiecePosition(unitID, pieceNumber)
    return reTab
end

function piec2Point(piecesTable)
    if not piecesTable then
        echo("lib_UnitScript::piec2Point: No argument recived")
        return
    end

    if type(piecesTable) ~= "table" then
        echo("lib_UnitScript::piec2Point: Not a valid table- got" .. piecesTable .. " of type " .. type(piecesTable) .. " instead ")
        return
    end

    reTab = {}

    for i = 1, #piecesTable do
        reTab[i] = {}
        reTab[i].Piece = piecesTable[i]
        reTab[i].x, reTab[i].y, reTab[i].z = Spring.GetUnitPiecePosDir(unitID, piecesTable[i])
        reTab[i].index = i
    end

    return reTab
end

--> spawn a ceg on the map above ground
function markPosOnMap(x, y, z, colourname, boolGadget)


    h = Spring.GetGroundHeight(x, z)
    if h > y then y = h end
    for i = 1, 5 do
        Spring.SpawnCEG(colourname, x, y + 10, z, 0, 1, 0, 50, 0)
			if not boolGadget then
				Sleep(200)
			end
	end
end

--> Takes a Table of Locks and locks it if the lock is free 
function TestSetLock(Lock, number)
    if TestLocks(number) == true then
        Lock[number] = true
        return true
    end
    return false
end

-->Test a rows of locks 
function TestLocks(Lock, number)
    for i = 1, table.getn(Lock) do
        if number ~= i and Lock[i] == true then return false end
    end
    return true
end

--> Sets a Lock free
function ReleaseLock(Lock, number)
    Lock[number] = false
end

function normTwo(...)
    local arg = arg; if (not arg) then arg = { ... }; arg.n = #arg end
    sum = 0
    for k, v in pairs(arg) do
        sum = sum + v * v
    end
    return math.sqrt(sum)
end


function filterOutTeam(TableOfUnits, teamid)
    returnTable = {}
    for i = 1, #TableOfUnits, 1 do
        tid = Spring.GetUnitTeam(TableOfUnits[i])
        if tid ~= teamid then returnTable[#returnTable + 1] = TableOfUnits[i] end
    end
    return returnTable
end

--> Grabs every Feature in a circle, filters out the featureID
function getAllFeatureNearUnit(unitID, Range)
    px, py, pz = Spring.GetUnitPosition(unitID)
    return Spring.GetFeaturesInCylinder(px, pz, Range)
end

--> Grabs every Unit in a circle, filters out the unitid
function getAllNearPiece(unitID, Piece, Range)
    px, py, pz = Spring.GetUnitPiecePosDir(unitID, Piece)
    return getAllInCircle(px, pz, Range, unitID)
end

--> Grabs every Unit in a circle, filters out the unitid
function getAllNearUnit(unitID, Range)
    px, py, pz = Spring.GetUnitPosition(unitID)
    return getAllInCircle(px, pz, Range, unitID)
end

--> Grabs every Unit in a circle, filters out the unitid or teamid if given
function getAllInCircle(x, z, Range, unitID, teamid)
    if not x or not z then
        return {}
    end
    if not Range then assert(Range) end

    T = {}
    if teamid then
        T = Spring.GetUnitsInCylinder(x, z, Range, teamid)
    else
        T = Spring.GetUnitsInCylinder(x, z, Range)
    end

    if unitID and T and #T > 1 and type(unitID) == 'number' then
        for num, id in ipairs(T) do
            if id == unitID then
                table.remove(T, num)
            end
        end
    end
    return T
end

--> Grabs every Unit in a circle, filters out the unitid
function getInCircle(unitID, Range, teamid)

    T = {}
    x, _, z = Spring.GetUnitBasePosition(unitID)
    if teamid then
        T = Spring.GetUnitsInCylinder(x, z, Range, teamid)
    else
        T = Spring.GetUnitsInCylinder(x, z, Range)
    end

    if T and #T > 1 and type(unitID) == 'number' then
        table.remove(T, unitID)
    end
    return T
end


-->Spawn CEG at unit
function spawnCEGatUnit(unitID, cegname, xoffset, yoffset, zoffset,dx,dy,dz)
	if not dx then
		dx, dy ,dz = 0, 1, 0
	end
	
    x, y, z = Spring.GetUnitPosition(unitID)
    if xoffset then
        Spring.SpawnCEG(cegname, x + xoffset, y + yoffset, z + zoffset, dx,dy,dz, 50, 0)
    else
        Spring.SpawnCEG(cegname, x, y, z, dx,dy,dz, 50, 0)
    end
end



function getLowest(Table)
    lowest = 0
    val = 0
    for k, v in pairs(Table) do
        if v < val then
            val = v
            lowest = k
        end
    end
end

function sumTable(Table)
    a = 0
    for i = 1, #Table do
        a = a + Table[i]
    end
    return a
end

function sumTableKV(Table)
    a = 0
    for k, v in pairs(Table) do
        a = a + v
    end
    return a
end

function PieceLight(unitID, piecename, cegname)
    while true do
        x, y, z = Spring.GetUnitPiecePosDir(unitID, piecename)
        Spring.SpawnCEG(cegname, x, y + 10, z, 0, 1, 0, 50, 0)
        Sleep(250)
    end
end

function TableToDict(T)
    reT = {}
    if not T then return reT end

    for i = 1, #T do
        if T[i] then
            reT[T[i]] = T[i]
        end
    end
    return reT
end

function mergeTables(...)
    local arg = arg; if (not arg) then arg = { ... }; arg.n = #arg end
    Table = {}
    if not arg then return end

    for _, v in pairs(arg) do
        if v and type(v) == "table" then
            Table = TableMergeTable(Table, v)
        end
    end

    return Table
end

function TableMergeTable(TA, TB)
    T = {}
    if #TA >= #TB then
        T = TableToDict(TA)

        for i = 1, #TB do
            if not T[TB[i]] then
                TA[#TA + 1] = TB[i]
            end
        end
        return TA
    else
        T = TableToDict(TB)
        for i = 1, #TA do
            if not T[TA[i]] then
                TB[#TB + 1] = TA[i]
            end
        end
        return TB
    end
end

--> Forms a Tree from handed over Table
--	this function needs a global Itterator and but is threadsafe, as in only one per unit
--	it calls itself, waits for all other threads running parallel to reach the same recursion Depth
-- 	once hitting the UpperLimit it ends
function executeLindeMayerSystem(gramarTable, String, oldDeg, Degree, UpperLimit, recursionDepth, recursiveItterator, PredPiece)

    -- this keeps all recursive steps on the same level waiting for the last one - who releases the herd
    gainLock(recursiveItterator)

    --we made it into the next step and get our piece
    GlobalTotalItterator = GlobalTotalItterator + 1
    local hit = GlobalTotalItterator

    if not hit or TreePiece[hit] == nil or hit > UpperLimit then
        releaseLocalLock(recursiveItterator)
        return
    end


    --DebugInfo
    --Spring.Echo("Level "..recursiveItterator.." Thread waiting for Level "..(recursiveItterator-1).. " to go from ".. GlobalInCurrentStep[recursiveItterator-1].." to zero so String:"..String.." can be processed")

    while GlobalInCurrentStep[recursiveItterator - 1] > 0 do
        Sleep(50)
    end

    --return clauses
    if not String or String == "" or string.len(String) < 1 or recursiveItterator == recursionDepth then
        RecursionEnd[#RecursionEnd + 1] = PredPiece
        releaseLocalLock(recursiveItterator)
        return
    end

    ox, oy, oz = Spring.GetUnitPiecePosition(unitID, PredPiece)

    --Move Piece to Position

    Show(TreePiece[hit])

    Move(TreePiece[hit], x_axis, ox, 0)
    Move(TreePiece[hit], y_axis, oy, 0)
    Move(TreePiece[hit], z_axis, oz, 0, true)
    --DebugStoreInfo[#DebugStoreInfo+1]={"RecursionStep:"..hit.." ||RecursionDepth: "..recursiveItterator.." ||String"..String.." ||PredPiece: "..PredPiece.." || Moving Piece:"..TreePiece[hit].."to x:"..ox.." y:"..oy.." z:"..oz}

    --stores non-productive operators
    OperationStorage = {}
    --stores Recursions and Operators
    RecursiveStorage = {}

    for i = 1, string.len(String) do
        --extracting the next token form the current string and find out what type it is
        token = string.sub(String, i, i)
        typeOf = type(gramarTable.transitions[token])

        -- if the typeof is a function and a productive Element 
        if typeOf == 'function' and gramarTable.productiveSymbols[token] then
            --execute every operation so far pushed back into the operationStorage on the current piece

            for i = #OperationStorage, 1, -1 do
                gramarTable.transitions[OperationStorage[i]](oldDeg, Degree, TreePiece[hit], PredPiece, recursiveItterator, recursiveItterator == UpperLimit - 1)
            end

            WaitForTurn(TreePiece[hit], x_axis)
            WaitForTurn(TreePiece[hit], y_axis)
            WaitForTurn(TreePiece[hit], z_axis)
            --renewOperationStorage
            OperationStorage = {}

            --This LindeMayerSystem has a go
            StartThread(executeLindeMayerSystem,

                gramarTable,
                gramarTable.transitions[token](oldDeg, Degree, TreePiece[hit], PredPiece, recursiveItterator, recursiveItterator == UpperLimit - 1),
                oldDeg,
                Degree,
                UpperLimit,
                recursionDepth,
                recursiveItterator + 1,
                EndPiece[math.max(1, math.min(#EndPiece, hit))])

            --if we have a non productive function we push it back into the OperationStorage
        elseif typeOf == "function" then --we execute the commands on the current itteration-- which i
            OperationStorage[#OperationStorage + 1] = token

            --recursionare pushed into the recursionstorage and executed after the current string has beenn pushed
        elseif typeOf == "string" and token == gramarTable.transitions["RECURSIONSTART"] then
            --Here comes the trouble, we have to postpone the recurssion 
            RecursiveStorage[#RecursiveStorage + 1], recursionEnd = extractRecursion(String, i, gramarTable.transitions["RECURSIONSTART"], gramarTable.transitions["RECURSIONEND"])
            i = math.min(recursionEnd + 1, string.len(String))
        end
    end

    --Recursions are itterated last but not least
    if table.getn(RecursiveStorage) > 0 then
        for i = 1, #RecursiveStorage do


            StartThread(executeLindeMayerSystem,

                gramarTable,
                RecursiveStorage[i],
                oldDeg,
                Degree,
                UpperLimit,
                recursionDepth,
                recursiveItterator + 1,
                EndPiece[math.max(1, math.min(#EndPiece, hit))])
        end
    end
    --Recursion Lock - the last one steps the Global Itteration a level up

    releaseLocalLock(recursiveItterator)
    --Spring.Echo("Thread Level "..recursiveItterator.." signing off")
    return
end



-->prepares large speaches for the release to the world
function prepSpeach(Speach, Names, Limits, Alphas, DefaultSleepBylines)
    --if only Speach 
    if Speach and not Names and not Limits then

        return { Speach = Speach }
    end

    Name = Names or "Dramatis Persona"
    Limit = Limits or 42
    Alpha = Alphas or 0.9
    DefaultSleepByline = DefaultSleepBylines or 750

    T = {}
    itterator = 1
    lineend = Limit
    size = string.len(Speach) or #Speach or Limit
    assert(size, "Size does matter")
    assert(Speach and type(Speach) == "string", "Speach not of type string", Speach)
    assert(lineend and type(lineend) == "number", "Limit not a number", Limit)
    assert(size and type(size) == "number", "Limit not a number", Limit)

    if string.len(Speach) < Limit then

        subtable = { line = Speach, alpha = Alpha, name = Name, DelayByLine = DefaultSleepByline }
        retTable = {}
        retTable[1] = subtable
        return retTable
    end


    whitespace = "%s"
    while lineend < size do

        lineend = string.find(Speach, whitespace, itterator + Limit) or string.len(Speach)
        subString = string.sub(Speach, itterator, lineend)
        Spring.Echo(subString)
        if subString then
            T[#T + 1] = { line = subString, alpha = Alpha, name = Name, DelayByLine = DefaultSleepByline }
        else
            break
        end

        if not lineend then
            break
        else
            itterator = Limit + 1
        end
        assert(lineend)
        assert(size)
    end

    return T, true
end


--> Displays Text at UnitPos Thread
-->> Expects a table with Line "Text", a speaker Name "Text", a DelayByLine "Numeric", a Alpha from wich it will start decaying "Numeric"
function say(LineNameTimeT, timeToShowMs, NameColour, TextColour, OptionString, UnitID)
    assert(LineNameTimeT)
    timeToShowFrames = math.ceil((timeToShowMs / 1000) * 30)

    px, py, pz = 0, 0, 0
    if not UnitID or Spring.ValidUnitID(UnitID) == false then
        echo("Im out 1")
        return
    end

    if type(LineNameTimeT) == "string" then
        Tables = {}
        Tables[1] = { name = "speaker", line = LineNameTimeT, DelayByLine = 500, Alpha = 1.0 }
        LineNameTimeT = Tables
    end

    --catching the case that there is not direct Unit speaking
    if not UnitID or type(UnitID) == "string" then
        Spring.Echo(LineNameTimeT[1].name .. ": " .. LineNameTimeT[i].line)
        if not LineNameTimeT[2].line then return end
        for i = 1, #LineNameTimeT, 1 do
            for j = 1, #LineNameTimeT[i], 1 do
                echo(LineNameTimeT[i][j].line)
            end
        end
        echo("Im out 2")
        return
    end

    local spGetUnitPosition = Spring.GetUnitPosition
    if not GG.Dialog then GG.Dialog = {} end

    lineBuilder = ""
    spaceString = stringBuilder( string.len(LineNameTimeT[1].name .. ": " or 5)," ")

    GG.Dialog[UnitID] = {}
    lineBuilder = lineBuilder .. LineNameTimeT[1].name .. ": " .. LineNameTimeT[1].line .. "\n"

    for i = 2, #LineNameTimeT, 1 do
        lineBuilder = spaceString .. LineNameTimeT[i].line .. "\n"
    end


    --Sleep Time till next line
    _, unitheigth, _ = Spring.GetUnitCollisionVolumeData(UnitID)
    GG.Dialog[UnitID][#GG.Dialog[UnitID] + 1] = {
        frames = timeToShowFrames,
        line = lineBuilder,
        lifetime = timeToShowFrames,
        unitheigth = unitheigth,
        color = TextColour
    }

    echo("Im out 3")
end

-->
function getUnitGroundHeigth(unitID)
    px, py, pz = Spring.GetUnitPosition(unitID)

    if px then
        h = Spring.GetGroundHeight(px, pz)
        if h then
            return h
        end
    end
end

--> creates a heightmap distortion table
function prepareCupTable(size, height, innerdiameter, percentage)
    if not size or not height then return nil end
    cent = math.ceil(size / 2)
    T = {}
    for o = 1, size, 1 do
        T[o] = {}
        for i = 1, size, 1 do
            --default
            T[o][i] = 0
            distcent = math.sqrt((cent - i) ^ 2 + (cent - o) ^ 2)
            if distcent < cent - 1 then
                T[o][i] = (cent - distcent) * height
				if distcent < innerdiameter then
				  T[o][i] = (cent - distcent) * ( height * percentage)
				
				end
            end
        end
    end

    return T
end

--> creates a heightmap distortion table
function prepareHalfSphereTable(size, height)
    if not size or not height then return nil end
    cent = math.ceil(size / 2)
    T = {}
    for o = 1, size, 1 do
        T[o] = {}
        for i = 1, size, 1 do
            --default
            T[o][i] = 0
            distcent = math.sqrt((cent - i) ^ 2 + (cent - o) ^ 2)
            if distcent < cent - 1 then
                T[o][i] = (cent - distcent) * height
            end
        end
    end

    return T
end


--> creates a heightmap distortion table that averages the height 
function smoothGroundHeigthmap(size, x, z)
    gh = Spring.GetGroundHeight(x, z)
    if not size then return nil end

    T = {}
    for o = 1, size, 1 do
        T[o] = {}
        for i = 1, size, 1 do
            lgh = Spring.GetGroundHeight(x + ((o - (size / 2)) * 8), z + ((i - (size / 2)) * 8))
            sign = -1
            if lgh < gh then sign = 1 end
            --default
            T[o][i] = math.abs(gh - lgh) * sign
        end
    end
    return T
end

--> returns the distance between two heigthvalues
function getGroundHeigthDistance(h1, h2)
    return distance(h1, 0, 0, h2, 0, 0)
end



--> returns the gh, the units heigth and wether the unit is underground
function getGroundHeigthAtPiece(uID, pieceName)
    px, py, pz = Spring.GetUnitPiecePosDir(uID, pieceName)
    gh = Spring.GetGroundHeight(px, pz)

    return gh, py, py < gh
end

--> multiplies a deformation map with a factor
function multiplyHeigthmapByFactor(map, factor)
    for o = 1, #map, 1 do
        for i = 1, #map[o], 1 do
            map[o][i] = map[o][i] * factor
        end
    end
    return map
end

--> blend Heigthmap
function blendToValueHeigthmap(map, dimension, blendStartRadius, blendEndRadius, ValueToBlend)
    center = { x = math.ceil(dimension / 2), z = math.ceil(dimension / 2) }
    total = blendEndRadius - blendStartRadius

    for o = 1, dimension, 1 do
        for i = 1, dimension, 1 do
            ldist = distance(center.x, 0, center.z, o, 0, i)
            if ldist > blendStartRadius and ldist < blendEndRadius then
                factor = (ldist - blendStartRadius) / total
                map[o][i] = map[o][i] * (1 - factor) + ValueToBlend * (factor)
            end
        end
    end
    return map
end

--> takes any given MapTable and nullifys the value outside and inside the circle
function circularClampHeigthmap(map, dimension, radius, boolInside, overWriteValue)
    center = { x = math.ceil(dimension / 2), z = math.ceil(dimension / 2) }
    for o = 1, dimension, 1 do
        for i = 1, dimension, 1 do

            if distance(center.x, 0, center.z, o, 0, i) > radius then -- we are Outside
                if boolInside == false then
                    map[o][i] = overWriteValue
                end
            else
                if boolInside == true then
                    map[o][i] = overWriteValue
                end
            end
        end
    end
    return map
end

--> consumes a resource if available 
function consumeAvailableRessource(typeRessource, amount, teamID)

    if "m" == string.lower(typeRessource) or "metal" == string.lower(typeRessource) then
        currentLevel = Spring.GetTeamResources(teamID, "metal")
        if amount > currentLevel then
            return false
        end

        if Spring.UseTeamResource(teamID, "metal", amount) then return true end
    end

    if "energy" == string.lower(typeRessource) or "e" == string.lower(typeRessource) then
        currentLevel = Spring.GetTeamResources(teamID, "energy")
        if amount > currentLevel then
            return false
        end

        if Spring.UseTeamResource(teamID, "energy", amount) then return true end
    end
    return false
end


-->samples over a given Array around Point x,y, with the samplefunction 
function sample(NumericIndex, x, y, sampleFunction, factor)
    quadNumericIndex = {}
    if type(NumericIndex) == "number" then
        for i = -1 * NumericIndex, NumericIndex do
            for j = -1 * NumericIndex, NumericIndex do

                quadNumericIndex[i][j] = { x = i * factor, z = j * factor }
            end
        end
    else
        quadNumericIndex = NumericIndex
    end

    for i = 1, #quadNumericIndex, 1 do
        for j = 1, #quadNumericIndex, 1 do
            quadNumericIndex[i][j] = sampleFunction(x + quadNumericIndex[i][j].x, y + (quadNumericIndex[i][j].z or quadNumericIndex[i][j].y))
        end
    end
    return quadNumericIndex
end

--> GetDistanceNearestEnemy
function distanceNearestEnemy(id)
    ed = Spring.GetUnitNearestEnemy(id)
    return distanceUnitToUnit(id, ed)
end

function holdsForAll(Var, fillterConditionString, ...)
    local arg = arg; if (not arg) then arg = { ... }; arg.n = #arg end
    if arg then
        for k, Val in pairs(arg) do
            if loadstring("Var" .. fillterConditionString .. "Val") == false then return end
        end
        return true
    else
        return true
    end
end

--> filters  out following a functionstring (deprecated)
function is(Var, fillterConditionString, ...)
    local arg = arg; if (not arg) then arg = { ... }; arg.n = #arg end
    f = loadstring(fillterConditionString)
    if type(f) == "function" then
        for k, Val in pairs(arg) do
            if (f(Var, Val) == true) then return true end
        end

    else

        for k, Val in pairs(arg) do
            if loadstring("Var" .. fillterConditionString .. "Val") == true then return true end
        end

        return false
    end
end



function makeNewAffirmativeMatrice()
    V = {
        [1] = 1,
        [2] = 0,
        [3] = 0,
        [4] = 0,
        [5] = 0,
        [6] = 1,
        [7] = 0,
        [8] = 0,
        [9] = 0,
        [10] = 0,
        [11] = 1,
        [12] = 0,
        [13] = 0,
        [14] = 0,
        [15] = 0,
        [16] = 1
    }
    function V.Mul(other)
        V[1] = 0; V[2] = 0; V[3] = 0; V[4] = 0;
        V[5] = 0; V[6] = 0; V[7] = 0; V[8] = 0;
        V[9] = 0; V[10] = 0; V[11] = 0; V[12] = 0;
        V[13] = 0; V[14] = 0; V[15] = 0; V[16] = 1
    end

    --TODO
    --http://springrts.com/phpbb/viewtopic.php?f=21&t=32246
    return V
end


--> produces a  Rotation matrice around axis for a degree in affirmative Coordinates
function makeAffirmativeRotate(axis, deg_)
    V = makeNewAffirmativeMatrice()
    if axis == "x_axis" then
        V[6] = math.cos(-deg_)
        V[7] = -1 * math.sin(-deg_)
        V[10] = math.sin(-deg_)
        V[11] = math.cos(-deg_)

    elseif axis == "y_axis" then
        V[1] = math.cos(-deg_)
        V[3] = math.sin(-deg_)
        V[9] = -1 * math.sin(-deg_)
        V[11] = math.cos(-deg_)
    else
        V[1] = math.cos(-deg_)
        V[5] = math.sin(-deg_)
        V[2] = -1 * math.sin(-deg_)
        V[6] = math.cos(-deg_)
    end
    return V
end

-->Returns a Unit from the Game without killing it
function removeFromWorld(unit, offx, offy, offz)
    hideUnit(unit)
    --TODO - keepStates in general and commandqueu
    pox, poy, poz = Spring.GetUnitPosition(unit)
    Spring.SetUnitAlwaysVisible(unit, false)
    Spring.SetUnitBlocking(unit, false, false, false)
    Spring.SetUnitNoSelect(unit, true)
    Spring.MoveCtrl.Enable(unit, true)
    if offx then
        Spring.SetUnitPosition(unit, offx, offy, offz)
    end
end

-->Removes a Unit from the Game without killing it
function returnToWorld(unit, px, py, pz)
    showUnit(unit)
    Spring.MoveCtrl.Disable(unit)
    if pz then
        Spring.SetUnitPosition(unit, px, py, pz)
    end
    Spring.SetUnitAlwaysVisible(unit, true)
    Spring.SetUnitBlocking(unit, true, true, true)
    Spring.SetUnitNoSelect(unit, false)
end

--> reveal a Unit 
function showUnit(unit)
    Spring.SetUnitCloak(unit, false, 1)
end

--> hide a Unit
function hideUnit(unit)
    Spring.SetUnitCloak(unit, true, 4)
end

--> kill All Units near Pieces Volume
function killAtPiece(unitID, piecename, selfd, reclaimed, sfxfunction)
    px, py, pz = Spring.GetUnitPieceCollisionVolumeData(unitID, piecename)
    tpx, tpy, tpz = Spring.GetUnitPiecePosDir(unitID, piecename)
    if px and tpx then
        size = square(px, py, pz)
        if size then
            T = getAllInCircle(tpx, tpz, size / 2, unitID)

            if T and #T > 0 then

                if sfxfunction then
                    for i = 1, #T do
                        ux, uy, uz = Spring.GetUnitPosition(T[i])
                        sfxfunction(ux, uz, uz)
                        Spring.DestroyUnit(T[i], selfd, reclaimed)
                    end

                else
                    for i = 1, #T do
                        Spring.DestroyUnit(T[i], selfd, reclaimed)
                    end
                end
            end
        end
    end
end


--> spins a units piece along its smallest axis
function SpinAlongSmallestAxis(unitID, piecename, degree, speed)
    if not piecename then return end
    vx, vy, vz = Spring.GetUnitPieceCollisionVolumeData(unitID, piecename)
    if vx and vy and vz then
        areax, areay, areaz = vy * vz, vx * vz, vy * vx
    end

    if holdsForAll(areax, " <= ", areay, areaz) then Spin(piecename, x_axis, math.rad(degree), speed) return end
    if holdsForAll(areay, " <= ", areaz, areax) then Spin(piecename, y_axis, math.rad(degree), speed) return end
    if holdsForAll(areaz, " <= ", areay, areax) then Spin(piecename, z_axis, math.rad(degree), speed) return end
end

function LayFlatOnGround(unitID, piecename, speeds)
    speed = speeds or 0
    if not piecename then return end
    vx, vy, vz = Spring.GetUnitPieceCollisionVolumeData(unitID, piecename)
    if vx and vy and vz then
        areax, areay, areaz = vy * vz, vx * vz, vy * vx
    end

    if holdsForAll(areax, " >= ", areay, areaz) then tP(piecename, 0, 90, 90, speed) return end
    if holdsForAll(areay, " >= ", areaz, areax) then tP(piecename, 90, 0, 90, speed) return end
    if holdsForAll(areaz, " >= ", areay, areax) then tP(piecename, 0, 0, 0, speed) return end
end

-->Helperfunction of recursiveAddTable
function getPieceChildrenTable(pieceNum, piecetable)
    if not pieceNum then return end
    T = Spring.GetUnitPieceInfo(unitID, pieceNum)
    children = T.children
    if children then
        for i = 1, #children do children[i] = piecetable[children[i]] end
    end
    return children, T.max
end

--> returns the root Piece of a units skeletton
function getRoot(unitID)
    pieceMap = Spring.GetUnitPieceMap(unitID)
    for name, number in pairs(pieceMap) do
        infoTable = Spring.GetUnitPieceInfo(unitID, number)
        if (infoTable.parent == "[null]") then return name, infoTable.children end
    end
end

--> returns a Unique ID - upper limit is 565939020162275221
function getUniqueID()
    if not GG.GUID then GG.GUID = 0 end
    GG.GUID = GG.GUID + 0.1 / math.pi
    return GG.GUID
end

--> checks wether a piece is below another piece
function recPieceBelow(hierarchy, currentPiece, endPiece, reTable)
    boolBelow = false

    if not hierarchy[currentPiece] then return nil end
    for k, pieceNumber in pairs(hierarchy[currentPiece]) do
        local retTable = reTable

        if pieceNumber == endPiece then
            retTable[#retTable + 1] = endPiece
            return true, retTable
        end

        retTable[#retTable + 1] = pieceNumber
        boolFound, T = recPieceBelow(hierarchy, pieceNumber, endPiece, retTable)
        if boolFound == true then
            return true, T
        end
    end
    return false
end

-->returns a chain of pieces from startPiece to endPiece going over a hierarchy
function getPieceChain(hierarchy, startPiece, endPiece)
    pieceChain = {}
    pieceChain[1] = startPiece
    boolBelow, pieceChain = recPieceBelow(hierarchy, startPiece, endPiece, pieceChain)
    return pieceChain
end

--> creates a hierarchical table of pieces, descending from root
function getPieceHierarchy(unitID, pieceFunction)

    rootname, children = getRoot(unitID)
    rootNumber = pieceFunction(rootname)
    hierarchy = {}
    hierarchy[rootNumber] = {}
    openTable = {}
    for k, pieceName in pairs(children) do
        hierarchy[rootNumber][#hierarchy[rootNumber] + 1] = pieceFunction(pieceName)
        table.insert(openTable, pieceFunction(pieceName))
    end

    while table.getn(openTable) > 0 do
        for num, pieceNumber in pairs(openTable) do
            tables = Spring.GetUnitPieceInfo(unitID, pieceNumber)
            if not hierarchy[pieceNumber] then hierarchy[pieceNumber] = {} end
            if tables and tables.children then
                for num, pieceName in pairs(tables.children) do
                    newPieceNumber = pieceFunction(pieceName)
                    hierarchy[pieceNumber][#hierarchy[pieceNumber] + 1] = newPieceNumber
                    table.insert(openTable, pieceFunction(pieceName))
                end
                table.remove(openTable, num)
            end
        end
    end


    return hierarchy, rootname
end

function getUnitPieceNameFromNumber(Name)
	--TODO
	
end

--> returns  a skelett table via recursion (Expensive)
function recMapDown(Result, pieceMap, Name)
	if type(Name) == "number" then
		Name = getUnitPieceNameFromNumber(Name)
	end

    if pieceMap[Name] then
        for _, pieceNumber in pairs(pieceMap[Name]) do
            info = Spring.GetUnitPieceInfo(unitID, pieceNumber)
            Result[#Result + 1] = pieceNumber
            if info and pieceMap[info.name] and info.children then
                Result = recMapDown(Result, pieceMap, info.name)
            end
        end
    end
    return Result
end

-->Returns all Pieces in a Hierarchy below the named point
function getPiecesBelow(unitID, PieceName, pieceFunction)
    pieceMap = getPieceHierarchy(unitID, pieceFunction)
    return recMapDown({}, pieceMap, PieceName)
end

--Hashmap of pieces --> with accumulated Weight in every Node
--> Every Node also holds a bendLimits which defaults to ux=-45 x=45, uy=-180 y=180,uz=-45 z=45
function recursiveAddTable(T, piecename, parent, piecetable)
    if not piecename then return T, 0 end

    C, max = getPieceChildrenTable(piecename, piecetable)

    if not T[parent] then T[parent] = {} end

    if C and #C > 0 then
        for i = 1, #C do
            T, nr = recursiveAddTable(T, C[i], piecename, piecetable)
        end
        bendLimits = computateBendLimits(piecename, parent)
        T[parent].bendLimits = bendLimits
        T[parent].weight = max[1] * max[2] * max[3]
        T[parent].nr = #C
    else

        if not T[parent][piecename] then T[parent][piecename] = {} end
        computateBendLimits(piecename, parent)
        T[parent].bendLimits = bendLimits
        T[parent][piecename].weight = 1
    end
    return T
end

--> finds the radian in a triangle where only the lenght of two sides are known
function triAngleTwoSided(LowerSide, OpposingSide)
    norm = math.sqrt(LowerSide * LowerSide + OpposingSide * OpposingSide)
    return math.atan2(LowerSide / norm, OpposingSide / norm)
end

function getCubeSphereRad(x, y, z)
    xy, xz, yz = x * y, x * z, y * z

    if xy > xz and xy > yz then return math.sqrt(x * x + y * y) end

    if xz > xy and xz > yz then return math.sqrt(x * x + z * z) end

    if yz > xy and yz > xz then return math.sqrt(y * y + z * z) end
end

function computateBendLimits(piecename, parent)
    paPosX, paPosY, paPosZ = Spring.GetUnitPiecePosition(unitID, parent)
    cPosX, cPosY, cPosZ = Spring.GetUnitPiecePosition(unitID, piecename)

    --the offset of the piece in relation to its parentpiece
    v = {}
    v.x, v.y, v.z = cPosX - paPosX, cPosY - paPosY, cPosZ - paPosZ

    pax, pay, paz = Spring.GetUnitPieceCollisionVolumeData(unitID, parent)
    radOfParentSphere = getCubeSphereRad(pax, pay, paz)
    cx, cy, cz = Spring.GetUnitPieceCollisionVolumeData(unitID, piecename)
    radOfPieceSphere = getCubeSphereRad(cx, cy, cz)
    -- rotate the vector so that it aligns with x,y,z origin vectors
    -- computate the orthogonal 
    -- computate the dead degree cube
    wsize = triAngleTwoSided(v.x, v.y)
    -- rotate the computated window inverse to the vector back
    -- voila

    --Y-Axis 
    -->TODO:RAGDOLL |_\ -- you approximate the motherpiece with a circle and then do a math.acos( circleradius/distance)
    --defaulting to a maxturn
    return { ux = -15, x = 15, uy = -180, y = 180, uz = -15, z = 15 }
end

function square(...)
    local arg = arg; if (not arg) then arg = { ... }; arg.n = #arg end
    if not arg then return 0 end
    sum = 0
    for k, v in pairs(arg) do
        if v then
            sum = sum + v ^ 2
        end
    end
    return math.sqrt(sum)
end


-->Turns a piece towards its broadest side by Collissionvolume
function turnPieceToLongestSide(unitID, pic, Speed)
    cv = {}
    x, y, z = Spring.GetUnitPieceCollisionVolumeData(unitID, centerPiece)
    xy = x * y; yz = y * z; zx = z * x
    signum = math.random(-1, 1)
    signum = signum / math.abs(signum)
    if xy > yz and xy > zx then tP(pic, 90 * signum, 0, 0, Speed); return z / 2 end
    if yz > xy and yz > zx then tP(pic, 0, 0, 90 * signum, Speed); return x / 2 end
    if zx > xy and zx > yz then tP(pic, 0, math.random(-360, 360), 0, Speed); return y / 2 end
end

-->forges a hierachical ragdoll for the table of pieces for the given lifetime lets that ragdoll hit the floor
function ragDoll(tableOfPieces, centerPiece, fallSpeed, lifetime)
    deltaMovement = 1
    cv = {}
    PiecesMap = {}
    FallSpeed = fallSpeed or 9.81
    cv.x, cv.y, cv.z = Spring.GetUnitPieceCollisionVolumeData(unitID, centerPiece)
    averageSize = average(cv.x, cv.y, cv.z)
    boolOnce = false; boolGo = false

    while lifetime > 0 do
        --we care for the centerPieceFalling
        px, py, pz = Spring.GetUnitPiecePosition(unitID, centerPiece)
        wpx, wpy, wpz = Spring.GetUnitPiecePosDir(unitID, centerPiece)
        h = Spring.GetGroundHeight(wpx, wpz)
        Dist = wpy - averageSize - FallSpeed / 4; if Dist < h then Dist = 0; if boolGo == true then boolGo = false; boolOnce = true end end
        if boolOnce == true then averageSize = turnPieceToLongestSide(unitID, centerPiece, 9.81 / 6); boolOnce = false end
        if py - h - averageSize / 2 > 0 then Move(centerPiece, y_axis, Dist, FallSpeed) end

        --and now we handle the other pieces going down
        subsOfCenterPiece = tableOfPieces[centerPiece]
        for _, v in pairs(subsOfCenterPiece) do
            traversePiecesMapToGround(centerPiece, v, PiecesMap, 9.81, 250)
        end

        Sleep(250)
        lifetime = lifetime - 250
    end
end

-->MovesAParentPiece
function movePieceToGround(parent, subPiece, Speed)

    local spGetUnitPiecePosDir = Spring.GetUnitPiecePosDir
    px, py, pz = spGetUnitPiecePosDir(unitID, subPiece)
    gh = Spring.GetGroundHeight(px, pz)
    --necessaryData
    paX, paY, paZ = spGetUnitPiecePosDir(unitID, parent)

    --TargetCoordsToTurnTowards
    TurnPieceTowardsPoint(subPiece, px, gh + 3, pz, Speed)
end


-->Traverses the PiecesMapDown recursively solving 
function traversePiecesMapToGround(parentPiece, currentPiece, PiecesMap, Gravity, UpdateCycleLength)
    -- if the piece is underground it moves its parent to get itself above ground
    cX, cY, cZ = Spring.GetUnitPiecePosDir(unitID, currentPiece)
    if cY < Spring.GetGroundHeight(cX, cZ) then

        -- if this Piece has subsidarys, it tryies to move itself to the ground, before calling for every children

        tP(currentPiece, tx, ty, tz, Gravity / (1000 / UpdateCycleLength))

        for _, UnitPiece in pairs(PiecesMap[parentPiece]) do
        end
    end
end

function stableConditon(legNr, q)
    return GG.MovementOS_Table ~= nil and
            GG.MovementOS_Table[unitID].stability > 0.5 and GG.MovementOS_Table[unitID].quadrantMap[math.max(math.min(4, q), 1)] > 0 or GG.MovementOS_Table[unitID].quadrantMap[math.max(math.min(4, legNr % 2), 1)] and GG.MovementOS_Table[unitID].quadrantMap[math.max(math.min(4, legNr % 2), 1)] > 0
end


--> Sets the Speed of a Unit
function setSpeedEnv(k, val)
    val = math.max(0.000000001, math.min(val, 1.0))
    env = Spring.UnitScript.GetScriptEnv(k)

    if env then
        udef = Spring.GetUnitDefID(k)
        Spring.UnitScript.CallAsUnit(k, Spring.UnitScript.SetUnitValue, COB.MAX_SPEED, math.ceil(UnitDefs[udef].speed * val * 2184.53))
    end
end


--Controlls One Feet- Relies on a Central Thread running and regular updates of each feet on his status
function feetThread(quadrant, degOffSet, turnDeg, nr, FirstAxisPoint, KneeT, SensorPoint, Weight, Force, LiftFunction, LegMax, WiggleFunc, ScriptEnviroment, SensorT)
    LMax = LegMax or 5
    oldHeading = 0
    Sleep(500)

    stabilize(quadrant,
        degOffSet,
        turnDeg,
        nr,
        FirstAxisPoint,
        KneeT,
        SensorPoint,
        Weight,
        Force,
        LiftFunction,
        ScriptEnviroment,
        SensorT)

    while true do
        while GG.MovementOS_Table[unitID].boolmoving == true do
            echo("lib_UnitScript::adaptiveAnimation::MovingTrue")
            --while GG.MovementOS_Table[unitID].boolmoving==true and stableConditon(nr,quadrant) do

            --feet go over knees if FeetLiftForce > totalWeight of Leg

            liftFeedForward(quadrant,
                degOffSet,
                turnDeg,
                nr,
                FirstAxisPoint,
                KneeT,
                SensorPoint,
                Weight,
                Force,
                LiftFunction,
                ScriptEnviroment)
            Sleep(100)
            stabilize(quadrant,
                degOffSet,
                turnDeg,
                nr,
                FirstAxisPoint,
                KneeT,
                SensorPoint,
                Weight,
                Force,
                LiftFunction,
                SensorT)
            Sleep(100)
            pushBody(quadrant,
                degOffSet,
                turnDeg,
                nr,
                FirstAxisPoint,
                KneeT,
                SensorPoint,
                Weight,
                Force,
                nr,
                ScriptEnviroment)

            Sleep(100)
            stabilize(quadrant,
                degOffSet,
                turnDeg,
                nr,
                FirstAxisPoint,
                KneeT,
                SensorPoint,
                Weight,
                Force,
                LiftFunction,
                ScriptEnviroment,
                SensorT)
            Sleep(100)
        end

        stabilize(quadrant,
            degOffSet,
            turnDeg,
            nr,
            FirstAxisPoint,
            KneeT,
            SensorPoint,
            Weight,
            Force,
            LiftFunction,
            ScriptEnviroment,
            SensorT)
        Sleep(100)
    end
end

--return Feet into origin position and push body above ground
function pushBody(quadrant, degOffSet, turnDeg, nr, FirstAxisPoint, KneeT, SensorPoint, Weight, Force, nr, ScriptEnviroment)
    if lib_boolDebug == true then Spring.Echo("lib_UnitScript::pushBody") end
    Turn(FirstAxisPoint, y_axis, math.rad(degOffSet), 0.3)
    xp, yp, zp = Spring.GetUnitPiecePosDir(unitID, SensorPoint)
    dif = yp - Spring.GetGroundHeight(xp, zp)

    Time = 0

    WaitForTurn(FirstAxisPoint, y_axis)
end

-->Uses the LiftAnimation Function to Lift the Feed
function liftFeedForward(quadrant, degOffSet, turnDeg, nr, FirstAxisPoint, KneeT, SensorPoint, Weight, Force, LiftFunction)
    if lib_boolDebug == true then Spring.Echo("lib_UnitScript::liftFeedForward") end
    GG.MovementOS_Table[unitID].quadrantMap[quadrant % 4 + 1] = GG.MovementOS_Table[unitID].quadrantMap[quadrant % 4 + 1] - 1
    speed = clamp(Force / (#KneeT * Weight), 0.15, 0.25)
    withOffset = sanitizeRandom(0, turnDeg)
    if withOffset > 180 then withOffset = withOffset * -1 end
    Turn(FirstAxisPoint, y_axis, math.rad(degOffSet + withOffset), speed)
    --lifts Feed from the ground 	
    LiftFunction(KneeT, Force / (#KneeT * Weight))

    --Turn foot forward and upward
    WaitForTurn(FirstAxisPoint, y_axis)
    Sleep(500)
    Turn(FirstAxisPoint, y_axis, math.rad(degOffSet), speed)
    for i = 1, #KneeT, 1 do
        Turn(KneeT[i], x_axis, math.rad(-2), speed)
    end
    WaitForTurn(FirstAxisPoint, y_axis)
end


-->Stabilizes the Feet above ground and rest
function stabilize(quadrant, degOffSet, turnDeg, nr, FirstAxisPoint, KneeT, SensorPoint, Weight, Force, LiftFunction, ScriptEnviroment, SensorT)

    xp, yp, zp = Spring.GetUnitPiecePosDir(unitID, SensorPoint)
    dif = yp - Spring.GetGroundHeight(xp, zp)
    degToGo = 0
    counter = 0
    olddif = 0
    WaitForTurn(FirstAxisPoint, y_axis)
    Turn(FirstAxisPoint, y_axis, math.rad(degOffSet), 0.15)
    assert(ScriptEnviroment.GetPieceRotation)
    assert(SensorT)

    unitHeigth = GG.MovementOS_Table[unitID].stability * Height
    propagatedCounterChange = 0

    for i = #KneeT, 1, -1 do
        measureIndex = clamp(i, 1, #KneeT)
        boolUnderground = true


        x, y, z = Spring.GetUnitPiecePosDir(unitID, SensorT[measureIndex])
        xdeg, y_deg, z_deg = ScriptEnviroment.GetPieceRotation(KneeT[i])
        tDeg = math.deg(xdeg)

        GroundHeight = Spring.GetGroundHeight(x, z)
        --	if lib_boolDebug == true then	Spring.Echo("lib_UnitScript::stabilize::PieceHeigth".. ( y -35 -unitHeigth ).." < "..GroundHeight.." ::GroundHeight") end

        if y - GroundHeight > 20 then --Go down		
            if y - GroundHeight < 5 then break end

            tDeg = clamp(tDeg + 0.25 + propagatedCounterChange, -75, math.max((1 / i) * 75, 25))
            tDeg = convertToNeg(tDeg)
            propagatedCounterChange = propagatedCounterChange - 0.25
            Turn(KneeT[i], x_axis, math.rad(tDeg), 0.0175)
        else --Go up	faster					
            boolUnderground = true

            tDeg = clamp(tDeg - 1.15 + propagatedCounterChange, -75, math.max((1 / i) * 75, 25))
            tDeg = convertToNeg(tDeg)
            propagatedCounterChange = propagatedCounterChange + 1.15
            Turn(KneeT[i], x_axis, math.rad(tDeg), 0.135)
        end
    end
    WaitForTurns(KneeT)
end

function convertToNeg(val)
    if val < 0 then return 360 - (360 + val) end
    return val
end

--expects a Table containing:



function getADryWalkAbleSpot()
    smin, smax = Spring.GetGroundExtremes()
    if smax <= 0 then return end
    cond = function(i, j, chunkSizeX, chunkSizeZ)
        h = Spring.GetGroundHeight(i * chunkSizeX, chunkSizeZ * j)
        if h > 0 then
            v = {}
            v.x, v.y, v.z = Spring.GetGroundNormal(i * chunkSizeX, chunkSizeZ * j)
            v = normVector(v)
            if v.y < 0.3 or math.abs(v.x) > 0.7 or math.abs(v.z) < 0.3 then
                return math.ceil(i * chunkSizeX), math.ceil(i * chunkSizeZ)
            end
        end
    end
    return getPathFullfillingCondition(cond, 64)
end


-->finds a spot on the map that is dry, and walkable
function getPathFullfillingCondition(condition, maxRes, filterTable, mapSizeX, mapSizeZ)
    if type(condition) ~= "function" then echo("getPathFullfillingCondition recived not a valid function") end
    local lcondition = condition

    probeResolution = 4.0
    local spGetGroundHeight = Spring.GetGroundHeight
    assert(Game.mapSizeX)
    assert(Game.mapSizeZ)
    while true do

        chunkSizeX = (Game.mapSizeX - 1) / probeResolution
        chunkSizeZ = (Game.mapSizeZ - 1) / probeResolution
        xRand, zRand = math.floor(sanitizeRandom(1, probeResolution - 1)), math.floor(sanitizeRandom(1, probeResolution - 1))

        for i = xRand, probeResolution, 1 do
            for j = zRand, probeResolution, 1 do
                ax, ay, az = lcondition(i, j, chunkSizeX, chunkSizeZ, filterTable)
                if ax then return ax, ay, az end
            end
        end


        for i = 1, xRand, 1 do
            for j = 1, zRand, 1 do
                ax, ay, az = lcondition(i, j, chunkSizeX, chunkSizeZ, filterTable)
                if ax then return ax, ay, az end
            end
        end

        probeResolution = probeResolution * 2
        if probeResolution > maxRes then Spring.Echo("Aborting Due to High Probe Resolution"); return end
    end
end

-->ConditionFunctions
function GetSpot_condDeepSea(x, y, chunksizeX, chunksizeZ, filterTable)
    h = Spring.GetGroundHeight(x * chunkSizeX, y * chunkSizeZ)
    if h < filterTable.minBelow and h > filterTable.maxAbove then return x * chunkSizeX, y * chunkSizeZ end
end



function binaryInsertTable(Table, Value, ToInsert, key)
    i = math.floor(table.getn(Table) / 2)
    upLim, loLim = table.getn(Table), 1
    previousi = 1
    if key then ToInsert = { value = ToInsert, key = key }

        while true do
            if Value > Table[i] and Table[i + 1] and Value > Table[i + 1] then
                previousi = i
                i = i + math.floor((upLim - loLim) / 2)
                loLim = previousi
            elseif Value < Table[i] and Table[i - 1] and Value < Table[i - 1] then
                previousi = i
                i = i - math.floor((upLim - loLim) / 2)
                uplim = previousi
            else
                table.insert(Table, ToInsert, i)
                return Table, i
            end
        end
    end
end


function sanitizeRandom(lowerBound, UpperBound)
    if lowerBound >= UpperBound then return lowerBound end

    return math.random(lowerBound, UpperBound)
end

function todoAssert(object, functionToPass, todoCheckNext)
    if functionToPass(object) == true then return end
    echo("Error:Todo:" .. todoCheckNext)
end

-->Sanitizes a Variable for a table
function sanitizeItterator(Data, Min, Max)
    return math.max(Min, math.min(Max, math.floor(Data)))
end

-->Splits a Table into Two Tables
function splitTable(T, breakP, breakEnd)
    breakPoint = breakP or math.ceil(#T / 2)
    breakPoint = sanitizeItterator(breakPoint, 1, table.getn(T))
    local T1 = {}

    for i = breakPoint, breakEnd, 1 do
        T1[#T1 + 1] = T[i]
    end

    return T1
end





function getMidPoint(a, b)
    ax, ay, az = a.x, a.y, a.z
    bx, by, bz = b.x.b.y, b.z
    return (ax - bx) / 2 + ax, (ay - by) / 2 + ay, (az - bz) / 2 + az
end

function swingPointOutFromCenterByFrame(ax, ay, az, frame, swing, totalFrame)
    extend = swing * math.sin(frame / totalFrame) * randSign()
    return ax + math.random(math.min(extend, extend * -1), math.abs(extend)),
    ay + math.random(math.min(extend, extend * -1), math.abs(extend)),
    az + math.random(math.min(extend, extend * -1), math.abs(extend))
end

--> make a CEG CLOUD
function CEG_CLOUD(cegname, size, pos, lifetime, nr, densits, plifetime, swing, speedInFrames)
    local spCEG = Spring.SpawnCEG
    quarter = math.ceil(plifetime / 4)
    it = 1
    pT = {}
    for i = 1, nr do
        pT[i] = { x = math.random(-size, size), y = math.random(-size, size) * 0.5, z = math.random(-size, size) }
    end

    while lifetime > 0 do
        frame = Spring.GetGameFrame()

        for i = it, nr, it do
            --between every particle that isnt first and last
            if i ~= 1 and i ~= nr then
                if i == 1 then
                    fx, fy, fz = getMidPoint(pT[nr], pT[2])
                else
                    fx, fy, fz = getMidPoint(pT[nr - 1], pT[1])
                end
                pT[i].x, pT[i].y, pT[i].z = swingPointOutFromCenterByFrame(fx, fy, fz, frame, swing, speedInFrames)
            else
                fx, fy, fz = getMidPoint(pT[i - 1], pT[i + 1])
                pT[i].x, pT[i].y, pT[i].z = swingPointOutFromCenterByFrame(fx, fy, fz, frame, swing, speedInFrames)
            end
            spCEG(cegname, pT[i].x, pT[i].y, pT[i].z, math.random(0, 1), math.random(0, 1), math.random(0, 1), 0, 0)
        end
        it = (it % 4) + 1
        lifetime = lifetime - quarter
        Sleep(quarter)
    end
end

-->renames piecenames placeholders in a given s3o file 
-- replaced asciichars must be equal in digits	
function objectPieceRenamer(filename)


    local file = io.open(filename, "r+b")



    if file then


        -- Opens a file in append mode
        lineTable = {}

        keycount = {}
        keycount["aa"] = {};
        keycount["bb"] = {};
        keycount["cc"] = {};
        keycount["dd"] = {};
        keycount["ee"] = {};
        keycount["ff"] = {};
        keycount["gg"] = {};
        keycount["aa"].matchcounter = 0
        keycount["bb"].matchcounter = 0
        keycount["cc"].matchcounter = 0
        keycount["dd"].matchcounter = 0
        keycount["ee"].matchcounter = 0
        keycount["ff"].matchcounter = 0
        keycount["gg"].matchcounter = 0

        local outputc = io.open("output.c", "wb")


        keycount["aa"].nr = 1; keycount["bb"].nr = 2; keycount["cc"].nr = 3; keycount["dd"].nr = 4; keycount["ee"].nr = 5; keycount["ff"].nr = 6; keycount["gg"].nr = 7


        count = 0
        for line in file:lines() do

            copystring = line
            for k, v in pairs(keycount) do

                matchCounter = v.matchcounter
                while string.find(copystring, "c" .. k) or string.find(copystring, "E" .. k) do
                    if string.find(copystring, "c" .. k) then
                        copystring = string.gsub(copystring, "c" .. k, "c" .. v.nr, 1)
                        matchCounter = matchCounter + 1
                    end
                    if string.find(copystring, "E" .. k) then
                        copystring = string.gsub(copystring, "E" .. k, "E" .. v.nr, 1)
                        matchCounter = matchCounter + 1
                    end

                    if matchCounter == 2 then
                        v.nr = v.nr + 7
                        matchCounter = 0
                    end
                end
                v.matchcounter = matchCounter
            end
            outputc.write(outputc, copystring .. "\n")
        end
        outputc:close()

    else
        Spring.Echo(" could not open file")
    end
end

-->Inserts a Value only if it is not found
function TableInsertUnique(Table, Value)
    for i = 1, #Table do
        if Table[i] == Value then return Table end
    end
    table.insert(Table, Value)
    return Table
end

function delayedCommand(id, command, target, option, framesToDelay)

persPack={}
	function delay(evtID, frame, persPack, startFrame)
		if frame >= startFrame +framesToDelay then
		 Command(id, command, target, option)
		 return nil, persPack
		end
		
		return frame+10, persPack
	end

    GG.EventStream:CreateEvent(delayedCommand,
             persPack,
             Spring.GetGameFrame() + framesToDelay)

end
-->Generic Simple Commands
function Command(id, command, target, option)
    options = option or {}
    --abort previous command

    if command == "build" then
        x, y, z = Spring.GetUnitPosition(unitID)
        x, y, z = x + 50, y, z + 50
        Spring.SetUnitMoveGoal(unitID, x, y, z)
        Spring.GiveOrderToUnit(unitID, -1 * target, {}, {})
    end

    if command == "attack" then
        coords = { target.x, target.y, target.z }
        Spring.SelectUnitArray({ [1] = id })
        Spring.GiveOrder(CMD.FIGHT, coords, CMD.OPT_RIGHT + CMD.OPT_SHIFT)
    end

    if command == "repair" or command == "assist" then
        spGiveOrderToUnit(unitID, CMD_GUARD, { target }, { "" })
    end

    if command == "go" then
        Spring.GiveOrderToUnit(id, CMD.MOVE, { target.x, target.y, target.z }, options) --{"shift"}
        return
    end

    if command == "stop" then
        Spring.GiveOrderToUnit(id, CMD.STOP, {}, {})
        return
    end

    if command == "setactive" then
		currentState = GetUnitValue(COB.ACTIVATION)
		if currentState == 0 then currentState = 1 else currentState = 0 end
		SetUnitValue(COB.ACTIVATION, currentState)
		return
    end
	
	    if command == "cloak" then
		currentState = GetUnitValue(COB.ACTIVATION)
		if currentState == 0 then currentState = 1 else currentState = 0 end
		
		Spring.UnitScript.SetUnitValue(COB.CLOAKED, currentState)

		return
    end
end

function isPieceAboveGround(unitID,pieceName)
x,y,z =Spring.GetUnitPiecePosDir(unitID,pieceName)
gh= Spring.GetGroundHeight(x,z)
if gh >  0 then return true end
return false
end

--> Gets a List of Geovents + Positions
function getGeoventList()

    features = Spring.GetAllFeatures()
    GeoventList = {}
    for i = 1, #features do
        id = features[i]
        defID = Spring.GetFeatureDefID(id)
        if defID == FeatureDefNames["geovent"].id then
            fx, fy, fz = Spring.GetFeaturePosition(id)
            GeoventList[#GeoventList + 1] = { x = fx, y = fy, z = fz, id = id }
        end
    end
    return GeoventList
end


--> returns a table of all unitnames  a unit can build
function GetUnitCanBuild(unitName)
    unitDef = UnitDefNames[unitName]
    T = {}
    if unitDef.isFactory or unitDef.isBuilder and unitDef.buildOptions then
        for index, unitname in ipairs(buildOptions) do
            T[unitname] = unitname
        end
    end
    return T
end

function removeDictFromDict(dA, dB)
for k, v in pairs(dA) do
dB[k] = nil
end
return dB
end

function unitCanBuild(unitDefID)
	assert(UnitDefs)

	if unitDefID and UnitDefs[unitDefID]  then		
		return UnitDefs[unitDefID].buildOptions 
	else
			return {}
	end
end

--computates a map of all unittypes buildable by a unit (detects loops)
--> getUnitBuildAbleMap
function getUnitCanBuildList(unitDefID, closedTableExtern)
    Result = {}

    openTable = unitCanBuild(unitDefID) or {}
	if lib_boolDebug == true then	
		echo("Unit "..UnitDefs[unitDefID].name.." can built:")
	end
   closedTable = closedTableExtern or {}
   closedTable[unitDefID] = true  
	CanBuildList = unitCanBuild(unitDefID)
	

   for num, defID in pairs(CanBuildList) do

		
		if defID and not closedTable[defID] then
			Result[defID] =defID		
			unitsToIntegrate, closedTable = getUnitCanBuildList(defID, closedTable)
			if unitsToIntegrate then
				for k=1,#unitsToIntegrate do
					if lib_boolDebug == true then	
						echo("Unit "..UnitDefs[unitDefID].name)
					end
					
				Result[unitsToIntegrate[k]] = unitsToIntegrate[k]
				end
			end
		end
   end

    return Result,closedTable
end

-->Stuns a Unit
function stunUnit(k, factor)
    hp = Spring.GetUnitHealth(k)
    if hp then Spring.SetUnitHealth(k, { paralyze = hp * factor }) end
end

--> Transfer UnitStats
function transferUnitStatusToUnit(unitID, targetID)
    exP = Spring.GetUnitExperience(unitID)
    hp, maxHP, para, cap, bP = Spring.GetUnitHealth(unitID)
    newhp, newmaxHP, _, _, _ = Spring.GetUnitHealth(unitID)
    Spring.SetUnitExperience(targetID, exP)

    factor = 1 / (hp / maxHP)
    hp = math.ceil(newmaxHP * factor)

    Spring.SetUnitHealth(targetID, { health = hp, capture = cap, paralyze = para, build = bP })
end

function createUnitAtPiece(unitID, typeID, Piece, team)
 x,y,z,_,_,_ =Spring.GetUnitPiecePosDir(unitID, Piece)
 teamID= team or Spring.GetUnitTeam(unitID)
 return Spring.CreateUnit(typeID, x, y, z, math.ceil(math.random(0, 3)), teamID)
end
--> Transforms a selected unit into another type
function transformUnitInto(unitID, unitType, setVel)
    x, y, z = Spring.GetUnitPosition(unitID)
    teamID = Spring.GetUnitTeam(unitID)
    vx, vy, vz, vl = Spring.GetUnitVelocity(unitID)
    rotx, roty, rotz = Spring.GetUnitRotation(unitID)
    currHp, oldMaxHp = Spring.GetUnitHealth(unitID)

    id = Spring.CreateUnit(unitType, x, y, z, math.ceil(math.random(0, 3)), teamID)
    if id and vx and rotx then

        Spring.SetUnitPosition(id, x, y, z)
        if setVel then
            Spring.SetUnitVelocity(id, vx * vl, vy * vl, vz * vl)
        end
        Spring.SetUnitRotation(id, rotx, roty, rotz)

        transferUnitStatusToUnit(unitID, id)
        transferOrders(unitID, id)
        Spring.DestroyUnit(unitID, false, true)
        return id
    end
    Spring.DestroyUnit(unitID, false, true)
end


--> Get Unit Target if a Move.Cmd was issued
function getUnitMoveGoal(unitID)
    cmds = Spring.GetCommandQueue(unitID, 4)
    for i = #cmds, 1, -1 do
        if cmds[i].id and cmds[i].id == CMD.MOVE and cmds[i].params then
            return cmds[i].params[1], cmds[i].params[2], cmds[i].params[3]
        end
    end
end

function get2DSquareFormationPosition(nr, size, unitsInRow)

	row = math.floor(nr/unitsInRow)
	place = nr % unitsInRow 
	return row*size, place*size
end

function drawFunctionGenerator(sizeX, sizeY, typeName)
    heightMapTable = makeTable({}, sizeX, sizeY)
    if typeName == "Cliff" then
        --generate a Point rotate to random deg, at random offset add to opposing rotation a second and a third point
        cliffstartpoint = Vector:new(0, sizeY / 2)
        startPointRad = math.random(-math.pi, math.pi)
        cliffEndPointARad = startPointRad + math.pi + math.random(math.pi / 8, math.pi / 4)
        cliffEndPointBRad = startPointRad + math.pi - math.random(math.pi / 8, math.pi / 4)
        cliffEndPointA = Vector:new(0, sizeY / -2)
        cliffEndPointB = Vector:new(0, sizeY / -2)

        --rotate cliffstartpoint by startPointRad
        --rotate cliffEndPointA by cliffEndPointA
        --rotate cliffEndPointB by cliffEndPointB


        extrapolationFunction = function(value, maxValue, bLeftRight)
            if bLeftRight == true then
                return math.sin((value / maxValue) * math.pi * 2)
            else
                return math.cos((value / maxValue) * math.pi * 3)
            end
        end



        return heightMapTable
    end
end

--> Gets the MaxSpeed Of A unit
function getMaxSpeed(unitID, UnitDefs)
    uDefID = Spring.GetUnitDefID(unitID)
    return UnitDefs[uDefID].speed
end


--> resets the speed of a unit
function reSetSpeed(unitID, UnitDefs)
    setSpeedEnv(unitID, 1.0)
end



--> every PixelPiecetable consists of a List of Pieces, a selectFunction and a PlaceFunction
-- both recive a List of allready in Pixel Placed Pieces and the relative Heigth they are at, 
-- and gives back a piece, and its heigth, the Selector returns nil upon Complete 
function createLandscapeFromFeaturePieces(pixelPieceTable, drawFunctionTable)
    echo("TODO:createLandscapeFromFeaturePieces")
end

--> transfers Order from one Unit to another
function transferOrders(originID, unitID)

    CommandTable = Spring.GetUnitCommands(originID)
    first = false
    if CommandTable then
        for _, cmd in pairs(CommandTable) do
            if #CommandTable ~= 0 then
                if first == false then
                    first = true
                    if cmd.id == CMD.MOVE then
                        Spring.GiveOrderToUnit(unitID, cmd.id, cmd.params, {})
                    elseif cmd.id == CMD.STOP then
                        Spring.GiveOrderToUnit(unitID, CMD.STOP, {}, {})
                    end
                else
                    Spring.GiveOrderToUnit(unitID, cmd.id, cmd.params, { "shift" })
                end
            else
                Spring.GiveOrderToUnit(unitID, CMD.STOP, {}, {})
            end
        end
    end
end


-->Generate a Description Text for a Unit
function unitDescriptionGenerator(Unit, UnitDefNames)
    local ud = UnitDefNames[Unit]
    stringBuilder = ""
    lB = "\n"


    function unitDefToStr(ud)
        str = "normal"
        if ud.reclaimable == true then str = str .. ", reclaimable" end
        if ud.capturable == true then str = str .. ", capturable" end
        if ud.repairable == true then str = str .. ", repairable" end
        return str
    end

    function trueStr(bool)
        if bool == false then return "not" end
        return " "
    end

    function retStr(val, str1, str2)
        if not val then return str1 end
        return str2 or ""
    end

    function cStr(bool, str)
        if bool and bool == true then
            return str
        else
            return ""
        end
    end

    utype = generateTypeString(ud)
    name = ud.name
    description = ud.description
    maxDamage = ud.maxDamage
    autoHeal = ud.autoHeal
    idleAutoHeal = ud.idleAutoHeal
    idleTime = ud.idleTime
    buildCostMetal = ud.buildCostMetal
    buildCostEnergy = ud.buildCostEnergy
    ustatus = generateStatusString(ud)
    harvestStorage = ud.harvestStorage
    metalStorage = ud.metalStorage
    energyStorage = ud.energyStorage
    extractsMetal = ud.extractsMetal
    windGenerator = ud.windGenerator
    tidalGenerator = ud.tidalGenerator
    metalUse = ud.metalUse
    metalUpkeep = ud.metalUpkeep
    energyUse = ud.energyUse
    metalMake = ud.metalMake
    energyMake = ud.energyMake

    makesMetal = ud.makesMetal
    onOffable = ud.onOffable
    activateWhenBuilt = ud.activateWhenBuilt
    sightDistance = ud.sightDistance
    airSightDistance = ud.airSightDistance
    losEmitHeight = ud.losEmitHeight
    radarEmitHeight = ud.radarEmitHeight
    radarDistance = ud.radarDistance
    radarDistanceJam = ud.radarDistanceJam
    sonarDistance = ud.sonarDistance
    sonarDistanceJam = ud.sonarDistanceJam
    stealth = ud.stealth

    canCloak = ud.canCloak
    cloakCostMoving = ud.cloakCostMoving
    initCloaked = ud.initCloaked
    minCloakDistance = ud.minCloakDistance
    decloakOnFire = ud.decloakOnFire
    cloakTimeout = ud.cloakTimeout
    canMove = ud.canMove
    canAttack = ud.canAttack
    canFight = ud.canFight
    canRepeat = ud.canRepeat
    canPatrol = ud.canPatrol
    canGuard = ud.canGuard
    canCloak = ud.canCloak
    canSelfDestruct = ud.canSelfDestruct
    moveState = ud.moveState
    fireState = ud.fireState
    noAutoFire = ud.noAutoFire
    canManualFire = ud.canManualFire
    --[[
	
	stringBuilder=stringBuilder..
	"=== Unit: "..name.." ==="..lB..
	"The unit "..name.." is a "..utype.." unit."..
	"Internally also described as "..description..", the "..name.." has "..maxDamage.." Hitpoints."..
	"To build a "..name.." costs "..buildCostMetal.." metal and "..buildCostEnergy.." energy."..
	"The "..name.." is a "..ustatus.. " unit."..
	retStr(harvestStorage, "This harvester can store "..harvestStorage.." in internal holds.")..lB..
	reStr(metalStorage, "The "..name.."s storage contributes ".. metalStorage.." to the teams metal storage.")..lB..
	reStr(metalStorage, "The "..name.."s storage contributes ".. energyStorage.." to the teams energy storage.")
..lB..
	reStr(extractsMetal, "The "..name.." extracts "..extractsMetal.." from the ground.")
..lB..
	reStr(windGenerator, "It is able to convert gas-currents into energy at a rate of "..windGenerator)
..lB..

	reStr(tidalGenerator, "Tidal forces can be converted to energy up too "..tidalGenerator .. " per Unit.")
..lB..
	reStr(metalUse, "The unit uses up to "..metalUse .. " metal.")
..lB..
	reStr(metalUpkeep,metalUpkeep.. " is used once the"..name.. " is activated.")
..lB..
	reStr(energyUse,energyUse.. " units of energy are used once the"..name.. " is activated.")..lB..
	reStr(metalMake," The "..name.. " generates "..metalMake.." uncoditionally every gametick.")
..lB..
	reStr(energyMake," Further the "..name.. " is constantly generating "..energyMake.." of energy.")..lB..
	reStr(makesMetal," In Addition the "..name.. " cpmverts "..makesMetal.." units of energy into metal.")..lB..
	"==== Unit Stats ===="..lB.. 
	reStr(onOffable,"A "..name.. " special abilitys can "..trueStr(onOffable).." be toggled via GUI. By default the special Ability is "..trueStr(activateWhenBuilt).." active."
..lB.. 
	reStr(sightDistance,"The "..name.. " can, depending on terrain, see as far as "..sightDistance.." at day and night."
..lB.. 
	reStr(airSightDistance,"The "..name.. " can set Air Units as far as "..airSightDistance..".")
..lB.. 
	reStr(losEmitHeight,""..name.. " viewpoint is "..losEmitHeight.." over ground.")
..lB.. 
	reStr(radarEmitHeight," Radar is emitted at "..radarEmitHeight.." over ground with a distance of "..radarDistance.."by the "..name..)
..lB.. 
	reStr(radarDistanceJam," Radar is jammed in a range of "..radarDistanceJam.." elmos.")
..lB.. 
	reStr(sonarDistance,""..name.." detects Submarines/Ships in a Range of "..sonarDistance.." around itself.")
..lB.. 
	reStr(sonarDistanceJam," Other ships sonar is d Submarines/Ships in a Range of "..sonarDistance.." around itself.")
..lB.. 
	reStr(stealth,"The "..name.." s a stealth unit.")
..lB.. 
	reStr(sonarStealth,"Capable of hidding from Sonarunits.")
..lB.. 
	reStr(seismicDistance,"And able to detect enemys via seismic Signatures at a distance of "..seismicDistance.." .")
..lB.. 
	reStr(seismicDistance,"The "..name.." itself emits a seismic signature detectable up to ".. seismicDistance*15 .." elmos.")
..lB.. 
	reStr(seismicDistance,"The "..name.." itself emits a seismic signature detectable up to ".. seismicDistance*15 .." elmos.")
..lB.. 
	reStr(canCloak,"The "..name.." is clokable with costs of "..cloakCost.." per second to uphold and "..reStr(cloakCostMoving," and additional costs of "..cloakCostMoving.. " while moving."..reStr(initCloaked, " The "..name.." is cloaked from the start.")))
..lB.. 
	reStr(canCloak,"The "..name.." is clokable with costs of "..cloakCost.." per second to uphold and "..reStr(cloakCostMoving," and additional costs of "..cloakCostMoving.. " while moving."..reStr(initCloaked, " The "..name.." is cloaked from the start.")))
..lB.. 
	reStr(minCloakDistance,"The "..name.." will be unveiled when a enemy comes closer as "..minCloakDistance.." in a "( reStr(decloakSpherical, "sphere.", "circle.")or " it.")
..lB.. 
	reStr(decloakOnFire,"If the "..name.." fires its weapon, it will "..trueStr(decloakOnFire)decloaked.." decloak."
..lB.. 
	reStr(cloakTimeout,"To recloak the "..name.." will have to wait for "..cloakTimeout.." seconds.") 
..lB.. 
	reStr(cloakTimeout,"Among the commands for the Unit are"..
	cStr(canMove," move,")..
	cStr(canAttack, " attack,")..
	cStr(canFight, " fight,")..
	cStr(canPatrol, " patrol,")..
	cStr(canGuard, " guard,")..
	cStr(canCloak, " cloak,").." and "
	cStr(canRepeat, " repeat ").."."
	.."In Addition the "..name.." can be orders to "..
	cStr(canSelfDestruct, " selfdestruct,")..
	cStr(moveState ~= -1, " switch between move states,")..
	cStr(noAutoFire, " switch between the fire state,")..
	cStr(fireState ~= -1, " with "..fireState.." as default ")..
	cStr(canManualFire, " and the order to manfual fire ").."."..
	
	cStr(builder, name.." is a builder that can be orders to "..
	cStr(canRestore, " restore ")..
	cStr(canRepair, " repair ")..
	cStr(canReclaim, " relcaim")..
	cStr(canResurrect," and ressurect ")..
	cStr(canCapture, " or capture. ")).."other units."..
	
	
	

	
	buildDistance default: 128.0 
	
	How far away from itself the unit can build, measured to the centre of the unit being built. The minimum value is 38.0. 
	
	buildRange3D default: false 
	
	Does the builders buildDistance apply in all 3 dimensions or only 2? 
	
	workerTime default: 0.0 lua: buildSpeed 
	
	How fast the builder builds, used in conjunction with the buildTime of the unit being built. Effectively, Time to build = buildTime / workerTime. If this value is <= 0.0 then builder is set to false. 
		
		repairSpeed default: workerTime 
		
		How fast the builder can repair other units. 
		
		reclaimSpeed default: workerTime 
		
		How fast the builder can reclaim other units and features. 
		
		resurrectSpeed default: workerTime 
		
		How fast the builder can resurrect corpse features back o living units. 
		
		captureSpeed default: workerTime 
		
		How fast the builder can capture other units. 
		
		terraformSpeed default: workerTime 
		
		How fast the builder levels and restores terrain. 
		
		canAssist default: builder 
		
		Can the builder assist other constructions? 
		
		canBeAssisted default: true 
		
		Can the builder be assisted by other builders? 
		
		canSelfRepair default: false 
		
		Can the builder repair itself? 
		
		showNanoSpray default: true 
		
		Does the builder emit OTA-style nanospray whilst constructing? 
		
		[3] nanoColor default: {0.2, 0.7, 0.2} aka green 
		
		The RGB colour of a builders' emitted nano particles if showNanoSpray = true. Also controls the RBG colour of a unit's own nanoframe if showNanoFrame = true. 
		
		fullHealthFactory default: ? 
		
		If true, units are repaired before they are allowed to leave the factory i.e. units from this factory will be healed back to 100% health if they are damaged during construction. 
		
		isAirbase default: false Removed in 101.0 in favour of more flexible lua custom commands
		
		Is this unit an airbase? Aircraft may land and repair on units which are airbases. 
		
		Movement & Placement
		
		footprX default: 1 
		
		How wide the unit is in footpr units, left to right. 1 footpr unit = 16 elmos. Cannot be below 1. For mobile units this should be the same as the footprX of its movementClass. Also used for obstacle avoidance. 
		
		footprZ default: 1 
		
		How wide the unit is in footpr units, top to bottom. 1 footpr unit = 16 elmos. Cannot be below 1. For mobile units this should be the same as the footprZ of its movementClass. Also used for obstacle avoidance. 
		
		string yardmap default: "" 
		
		Used to determine a structure from a mobile unit. A string of characters which defines in detail each 'footpr square' of the structure. Each footpr square may be:
		
		y - 'Yard' - Always open, unblocking, 
		c - 'Construction' - Open and unblocking only while constructing (for factories, controlled via COB.YARD_OPEN see Animation-LuaCallouts#Other), 
		i - 'Inversed Construction' - Closed and blocking only while constructing (for factories, controlled via COB.YARD_OPEN see Animation-LuaCallouts#Other) (New in version 89.0), 
		g - 'Geothermal' - Flags that the unit must be placed over a geoThermal feature, does not actually count as a square, 
		h - 'High Resolution' - Indicates that the yardmap will use double resolution with four times as many characters. Must be the first character, and does not count as a square itself (New in version 93.0), 
		o - 'Obstacle' - Always closed, blocking, all other chars are treated the same way. 
		
		Tip: 'Draw' out the yardmap over multiple lines. As of 89.0 all whitespace characters are ignored, including newlines. 
		
		levelGround default: false 
		
		For structures. Does the constructor have to level the ground underneath the build area before beginning to build the structure? 
		
		string movementClass default: "" lua: moveDef.name 
		
		The name of the movement type a mobile, non aircraft, unit should use. See Movedefs.lua. 
		
		canHover default: false Removed in 95.0
		
		Is the unit a hovercraft? Hovercraft can cross water of any depth without a speed penalty. Hover's must also have HOVER within the name of their movementClass (see Movedefs.lua). 
		
		er default: true if waterline = true, false otherwise 
		
		When a mobile unit is crossing water, or a structure is placed on water, does it on top of the water or crawl / lay on the sea bed? 
		
		upright default: false 
		
		Does the unit follow the terrain or always remain upright? Generally used for walkers. 
		
		maxSlope default: 0.0 lua: maxHeightDif 
		
		The maximum slope a building can be placed on. Mobile unit's use the maxSlope set in their movementClass. The value is in degrees and is clamped between 0.0 and 89.0. This value is converted to a "maximum allowed height difference" (call it M), which involves a hard-coded constant. When a building gets placed, the height of each of its footpr squares is compared to a reference height (calculated for the build position). If the difference exceeds M for any square, that build position is rejected. The value readable from lua has been changed from that in the unitdef and reflects the ernal engine value. 
		
		minWaterDepth default: -10e6 
		
		The minimum depth of water a building can be placed on. Mobile unit's use the minWaterDepth set in their movementClass. 
		
		maxWaterDepth default: 10e6 
		
		The maximum depth of water a building can be placed on. Mobile unit's use the maxWaterDepth set in their movementClass. 
		
		waterline default: 0.0 
		
		How low in the water does a ship sit? Higher values means the ship is lower in the water. 
		
		minCollisionSpeed default: 1.0 
		
		The minimum net impact speed that will cause a unit to be damaged by collisions with another unit. 
		
		pushResistant default: false 
		
		Can the unit be pushed around by other units? Turning it on doesn't remove all pushing but is a marked improvement. 
		
		maxVelocity default: 0.0 lua: speed 
		
		The maximum speed attainable by the unit in elmos per frame. If the value is -ve, the absolute value is used. 
		
		maxReverseVelocity default: 0.0 lua: rSpeed New in version 99.0
		
		The maximum speed attainable by the unit in reverse in elmos per frame. If the value is -ve, the absolute value is used. 
		
		acceleration default: 0.5 lua: maxAcc 
		
		The acceleration of the unit, in elmos per frame2. If the value is -ve, the absolute value is used. 
		
		brakeRate default: acceleration lua: maxDec 
		
		The deceleration of the unit, in elmos per frame2. If the value is -ve, the absolute value is used. For units with canFly = true this is multiplied by 0.1. Prior to 95.0 this was scaled by 0.1 for aircraft and the default was 3x acceleration. 
		
		myGravity default: 0.4 
		
		As Spring aircraft are slower than real aircraft this tag allows to lower gravity to compensate. Multiplies against map gravity for aircraft, replaces map gravity for ground vehicles if non-zero. 
		
		turnRate default: 0.0 
		
		How fast the unit can turn. degrees per seconds = 0.16 * turnRate. 
		
		turnInPlace default: true 
		
		Does the unit turn on the spot (like a person or tank) or must it be moving forwards to turn (like a car). 
		
		turnInPlaceSpeedLimit default: A complex formula based on turnRate and maxVelocity 
		
		For units with turnInPlace = false, this defines the minimum speed it will slow down to (the speed at which the turn is actually performed can be higher depending on the angular difference and turnRate). 
		
		turnInPlaceAngleLimit default: 0.0 New in version 86.0
		
		For units with turnInPlace = true, defines the maximum angle (in degrees) of a turn above which it starts to brake. 
		
		blocking default: true 
		
		Does the unit block the movement of other units? (Mines, i.e. non-mobile units with the kamikaze tag default to false). 
		
		crushResistance default: mass New in version 85.0
		
		How resistant is the unit to being crushed? Any MoveClass with a crushStrength greater than this will crush the unit - IFF this has been enabled via Spring.SetUnitBlocking and the collider impulse exceeds that of the colidee. 
		
		Flanking
		
		flankingBonusMode default: flankingBonus.defaultMode set in Modrules.lua 
		
		The mode of operation of Spring's inbuilt flanking system. Can be 0 - No flanking bonus. Mode 1 builds up the ability to move over time, and swings to face attacks, but does not respect the way the unit is facing. Mode 2 also can swing, but moves with the unit as it turns. Mode 3 stays with the unit as it turns and otherwise doesn't move, the ideal mode to simulate something such as tank armour. 
		
		[3] flankingBonusDir default: {0.0, 0.0, 1.0} 
		
		This is the direction vector where the armour is facing; i.e. where the least damage is applied. The default is straight forwards. 
		
		flankingBonusMax default: 1.9 
		
		The maximum multiplier to the damage dealt, when a unit is hit from the opposite direction to flankingBonusDir. 
		
		flankingBonusMin default: 0.9 
		
		The minimum multiplier to the damage dealt, when a unit is hit from the same direction as flankingBonusDir. 
		
		flankingBonusMobilityAdd default: 0.01 
		
		This defines the ability of flankingBonusDir to move over time. Its value is added to the mobility every SlowUpdate. When the unit is attacked, the build up mobility value is multiplied by a vector facing the attack, which is added to flankingBonusDir. 
		
		Aircraft
		
		canFly default: false 
		
		Can the unit fly, i.e. is it an aircraft? 
		
		canSubmerge default: false 
		
		Can the aircraft land underwater? 
		
		factoryHeadingTakeoff default: true 
		
	Controls the take-off behaviour of aircraft with hoverAttack = true. true means planes start matching their heading right after taking off from the pad, false means they maain the heading of the pad until reaching cruiseAlt. 
	
	collide default: true 
	
	Does the unit collide with other aircraft, or can it occupy the same space? 
	
	hoverAttack default: false 
	
	Controls whether the aircraft flys and attacks like a fighter/bomber or a helicopter/gunship. 
	
	airStrafe default: true 
	
	For aircraft with hoverAttack = true, controls if the unit strafes side to side while attacking or remains stationary. 
	
	cruiseAlt default: 0.0 lua: wantedHeight 
	
	The altitude in elmos which the unit attempts to fly at while cruising. 
	
	airHoverFactor default: -1.0 lua: dlHoverFactor 
	
	For aircraft with hoverAttack = true, less then 0 means it can land and >= 0 indicates how much the unit will move during hovering on the spot. 
		
		bankingAllowed default: true 
		
		For aircraft with hoverAttack = true, controls whether or not the unit banks when moving turning. 
		
		useSmoothMesh default: true 
		
	Does the aircraft follow the real map terrain or the special smoothed out navigation mesh generated by Spring specifically for aircraft?} Can become problematic for construction aircrafts, building in canyons. 
	
	maxFuel default: 0.0 Removed in 101.0 in favour of more flexible lua custom commands
	
	The maximum flight time in seconds before aircraft must return to an airbase to refuel. 
	
	refuelTime default: 5.0 Removed in 101.0 in favour of more flexible lua custom commands
	
	The time in seconds required to refuel the aircraft at an airbase. 
	
	minAirbasePower default: 0.0 Removed in 101.0 in favour of more flexible lua custom commands
	
	The minimum workerTime an airbase must have to repair / refuel this aircraft. 
	
	canLoopbackAttack default: false 
	
	Can the aircraft perform an Immelmann turn? 
	
	Advanced Air Tags
	
	The following set of tags are not well understood and using non-default values can lead to undesired flight behaviours. wingDrag default: 0.07 
	
	The drag caused by the aircraft's wing. Clamped between 0.0 and 1.0. 
	
	wingAngle default: 0.08 
	
	The angle between the front and the wing plane. 
	
	frontToSpeed default: 0.1 
	
	Fudge factor for lining up speed and front of plane. 
	
	speedToFront default: 0.07 
	
	Fudge factor for lining up speed and front of plane. 
	
	crashDrag default: 0.005 
	
	The drag used when crashing. Clamped between 0.0 and 1.0. 
	
	maxBank default: 0.8 
	
	The maximum roll (z-axis rotation) the aircraft can achieve. 
	
	maxPitch default: 0.45 
	
	The maximum pitch (x-axis rotation) the aircraft tries to keep. 
	
	turnRadius default: 500.0 
	
	H to Spring unit AI about the required turning radius. 
	
	verticalSpeed default: 3.0 
	
	The speed of takeoff and landing, at least for gunships (hoverAttack = true). 
	
	maxAileron default: 0.015 
	
	The maximum turn speed around the roll (z) axis. 
	
	maxElevator default: 0.01 
	
	The maximum turn speed around the pitch (x) axis. 
	
	maxRudder default: 0.004 
	
	The maximum turn speed around the yaw (y) axis. 
	
	maxAcc default: 0.065 
	
	The maximum acceleration or 'engine power' of the aircraft. 
	
	attackSafetyDistance default: 0 Exists only in version 99.0
	
	Fighters abort dive toward target if within attackSafetyDistance and try to climb back to normal altitude while still moving toward target. It's disabled by default. Set to half of the minimum weapon range to avoid collisions, enemy fire, AOE damage. If set to greater than the weapon range, the unit will fly over the target like a bomber. This tag was removed in version 100.0 and changed to a Spring.SetMoveTypeData key. 
	
	Flares
	
	The following set of tags are rarely used and are hardcoded to only work vs. missile weapons. The texture is hardcoded to be flareprojectiletexture defined in Resources.lua. canDropFlare default: false 
	
	Can this aircraft drop flares to distract missile weapons? 
	
	flareReload default: 5.0 lua: flareReloadTime 
	
	The time in seconds between successive flare drops. 
	
	flareDelay default: 0.3 
	
	The delay between detecting an incoming missile and launching flares. Multiplied by a random number between 1 and 16. 
	
	flareEfficiency default: 0.5 
	
	The probability that an incoming missile will target the flare instead of the aircraft. 
	
	[3] flareDropVector default: {0.0, 0.0, 0.0} 
	
	The direction vector which flares are emitted in. 
	
	flareTime default: 3 
	
	The lifetime of a dropped flare in frames. 
	
	flareSalvoSize default: 4 
	
	How many flares are dropped at once? 
	
	flareSalvoDelay default: 0 
	
	The delay in frames between the release of each individual flare in a burst. 
	
	Transports
	
	transportSize default: 0 
	
	The size of units that the transport can pick up, in terms of the passengers footprX. 
	
	mransportSize default: 0 
	
	The smallest size of unit that the transport can pick up, in terms of the passengers footprX. 
	
	transportCapacity default: 0 
	
	The total number of units that the transport can pick up, with each unit multiplied by it's footprX size. Prior to 101.0 if this tag is not present, then any Script.AttachUnit and Script.DropUnit call in the animation script will be ignored (See Animation-LuaCallouts#Other), in successive versions all units can use Spring.UnitAttach et al regardless of this tag. 
		
		transportMass default: 100000.0 
		
		The total cumulative mass of passengers the transport can carry. 
		
		mransportMass default: 0.0 
		
		The minimum mass passenger the transport can carry. 
		
		loadingRadius default: 220.0 
		
		How far away in elmos can the transporter pick up and drop units? 
		
		unloadSpread default: 1.0 
		
		How spread out the passengers are when unloaded. Is multiplied by the passengers radius. 
		
		isFirePlatform default: false 
		
		Can transported units still aim and shoot while loaded by this transport? 
		
		holdSteady default: false 
		
		If true - passengers are slaved to orientation of transporter attachment piece, if false - passengers are slaved to orientation of transporter body. 
		
		releaseHeld default: false 
		
		Does the transporter unload it's passengers when it dies? 
		
		cantBeTransported default: false for mobile units, true for structures 
		
		Controls if a unit is transportable at all or not. If false it is overridden by Modrules.lua transportability subtable tags. 
		
		transportByEnemy default: true 
		
		Controls if a unit can be transported by an enemy transport. i.e. can it be kidnapped. 
		
		transportUnloadMethod default: 0 
		
		For air transports. Can be 0 - Land to unload individually, 1 - Flyover drop (i.e. Parachute), or 2 - Land and flood unload all passengers. Can be used on ground transports with mixed results. 
		
		fallSpeed default: 0.2 
		
		For air transports with transportUnloadMethod = 1. The speed in elmos per second which units will fall at when released from the transport. 
		
		unitFallSpeed default: 0.0 
		
		Allows you to override fallSpeed for an individual passenger. 
		
		Categories
		
		string category default: "" 
		
		The category tag is a string of separate words, each representing a category of units. There is a maximum of 32 categories. The primary purpose of categories is weapon targeting (See #weapons). 
		
		string noChaseCategory default: "" 
		
		The unit will still target enemies with a matching category, but will not chase after it if it moves out of weapon range. 
		
		Decals
		
		leaveTracks default: false 
		
		Does the unit leave a track mark decal behind it when it moves? For mobile units. 
		
		string trackType default: "stdTank" 
		
		The filename of the image, without extension, assumed to be in Bitmaps/Tracks/, to be used as the track decal. The red channel of the image controls the brightness and the green channel the alpha (how visible it is) of the track. Blue channel is unused. 
		
		trackWidth default: 32.0 
		
		The width of the track decal left on the ground, in elmos. 
		
		trackOffset default: 0.0 
		
		How far back in elmos the track should be drawn from the centre of the unit. 
		
		trackStrength default: 32.0 
		
		How visible or 'deep' the track mark should be. Also used to determine how long the decal should last. 
		
		trackStretch default: 1.0 
		
		How much the track is stretched in the forward direction compared to the sides (i.e. used to change aspect ratio). 
		
		useBuildingGroundDecal default: false 
		
		For structures, do they display a ground decal on the terrain under their model? 
			
			string buildingGroundDecalType default: "" 
			
			The filename of the image to be used as ground decal. Assumed to be in Unittextures/. 
			
			buildingGroundDecalSizeX default: 4 
			
			How wide the decal is left to right, in footpr units. 
			
			buildingGroundDecalSizeY default: 4 
			
			How wide the decal is top to bottom, in footpr units. 
			
			buildingGroundDecalDecaySpeed default: 0.1 
			
		A measure of how quickly the decal should fade out if the structure dies. Essentially this value is multiplied by the time since death and subtracted from the original alpha until the decal is fully transparent. 
		
		Collision Volumes
		
		For a deeper explanation of these tags, see Gamedev:CollisionVolumes. Note that all collision checks first do a pre-check with the unit radius before doing the colvol checks. Ergo the unit radius must be larger or equal to the colvol! [3] modelCenterOffset default: {0.0, 0.0, 0.0} Removed in 89.0 (Now set via lua)
			
			How far from the model's defined centre should the centre of the unit be? 
			
			usePieceCollisionVolumes default: false lua: collisionVolume.defaultToPieceTree 
			
			When turned on the model and UnitDef collision volumes are ignored and Spring generates a bounding box volume for each piece of the unit model. These volumes can be manipulated or replaced by Spring.SetUnitPieceCollisionVolumeData. Increases the performance cost of collision calculations. 
			
			string collisionVolumeType default: "ellipsoid" lua: collisionVolume.type 
			
			What shape should the unit's collision volume be? Can be box, ellipsoid or a cylinder aligned to an axis; cylX, cylY, cylZ. 
			
			[3] collisionVolumeScales default: {0.0, 0.0, 0.0} lua: collisionVolume.scale{X|Y|Z} 
			
			The lengths of the collision volume in each of the three axes. Note that non-spherical ellipsoids and elliptical cylinders are not supported. 
			
			[3] collisionVolumeOffsets default: {0.0, 0.0, 0.0} lua: collisionVolume.offset{X|Y|Z} 
			
			The offset from the unit centre to the hit volume centre in each axis. 
			
			useFootPrCollisionVolume default: false lua: .collisionVolume.defaultToFootpr New in version 92.0
			
			Replaces any defined collision volume with a box with dimensions equal to the object's footpr (this also overrides any custom scaling and/or offsets). 
			
			collisionVolumeTest default: 0 Removed in 90.0 (Now always continuous)
			
			The type of test used to detect collisions. Can be 0 (discrete) or 1 (continuous). Use the latter for catching high speed projectiles which may otherwise 'skip through' small collision volumes, but beware of the increased performance cost. 
			
			Attack Behaviours
			
			highTrajectory default: 0 lua: highTrajectoryType 
			
			Can the unit fire it's (ballistic) weapons in a high trajectory arc? Can be 0 - Low trajectory only, 1 - High trajectory only, or 2 - Toggle button. 
			
			kamikaze default: false lua: canKamikaze 
			
			Does the unit attack its target by blowing itself up? 
			
			kamikazeDistance default: 0.0 lua: kamikazeDist 
			
			How close to the target, in elmos, the unit must get before detonating. Measured in 3D, not 2D. 
			
			kamikazeUseLOS default: false 
			
			Does the target unit have to be in LOS when detonating or only within kamikazeDistance. 
			
			strafeToAttack default: false 
			
			Should the unit move sideways when it can't shoot? 
			
			Other
			
			string decoyFor default: "" 
			
			The UnitDef name (not human name) which this unit is a decoy for. 
			
			selfDestructCountdown default: 5 lua: selfDCountdown 
			
			The length in seconds taken between issuing self destruct order and the unit exploding. 
			
			damageModifier default: 1.0 lua: armoredMultiple 
			
			The multiplier applied to weapon damage when the units ARMORED status (See Lua_ConstCOB) is turned on. 
			
			isTargetingUpgrade default: false lua: targFac 
			
			Does the unit upgrade the targeting so that units shoot accurately at enemy units which are in radar but not in LOS. 
			
			isFeature default: false 
			
			Does the unit immediately die o it's corpse feature when built? Used mainly for making walls. 
			
			hideDamage default: false 
			
			Should the units current health be invisible to enemy players? 
			
			showPlayerName default: false 
			
			Should the unit display it's controlling player as its name instead of name. Generally used for commander or hero units. 
			
			showNanoFrame default: true 
			
			Does the unit show an OTA-style nanoframe whilst being constructed? 
			
			unitRestricted default: MAX_UNITS lua: maxThisUnit 
			
			How many of this unit type may a player control at once? Defaults to being the maximum amount of units controllable. Is overridden by lobby unit restrictions. 
			
			power default: buildCostMetal + (buildCostEnergy / 60.0) 
			
			The relative power of the unit. Used in weapon targeting priority and experience gain calculations. 
			
			
			
			
			echo("Unit: "..name)
			echo("The "..name.." is a "utype
			]]
end