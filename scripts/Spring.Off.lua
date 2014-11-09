-- This is the Spring.Offline Debug Library V0.01
-- While Spring, if it runs your script into a miatake - it will print a error into the infolog
-- This library will write a error to std:out, but then supply a surrogate number/result to keep executing
-- In Addition let it be known, that this library is only there for gadgets and unitscripts. 

function GotSpring(Args)
return Spring
end
--this shall not pass
function TypeCheck(Var, FunctionShortName,  RangeFunction)

	
		
		if type(Var.Var)~= Var.Type then  
			print("Var ".. Var.Name.." in ".. FunctionShortName.. "is not of Type "..Var)
			return false 
			end
		else
		
		boolGo=false
		if RangeTable and RangeTable[Var.Var]~= nil then
		boolGo=true
		end
		if RangeFunction and RangeFunction(Var.Var)== true then
		boolGo=true
		end
		
		if boolGo == false then 
		print("Var ".. Var.Name.." in ".. FunctionShortName.. "is not in Range")
		return false
		end
	end
	return true
end

Spring={}

--This Code is autogoonerated .. 

-->> SyncedRead


-->> SyncedCtrl


-->> UnsyncedRead

-->> UnsyncedCtrl



-- A Example
--Spring.GetUnitPosition(untid)
--TypeCheck("number", "unitid", unitid, "GetUnitPosition", 42, {}, f= function f(val) return val > 0 and val == math.floor(val) end)
