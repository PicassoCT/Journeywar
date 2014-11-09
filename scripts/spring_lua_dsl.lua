--making a spring domain specific language?
		
 function doWith(T,...)
 argstack={}
 currentFunction=function (T) return T end

 
      for _, qelement in pairs(arg) do
	  q_type=type(qelement)
	  
	  if q_type=="function" then 
	  --execute old function with args on Table
	  T=currentFunction(T, arg=argstack)
	  argstack={}
	  --store new function
	  currentFunction=qelement
		  else
		  argstack[#argstack+1]=qelement
		  end
      end
 return T
 end
  
  
  
function bundleTask(Table,Tasks)
	for i=1,#Table do
		for j=1,#Tasks do
			Tasks[j](Table[i])
		end
	end
end
  
