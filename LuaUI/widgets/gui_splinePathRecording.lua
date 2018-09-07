--------------------------------------------------------------------------------
--------------------------------------------------------------------------------



function widget:GetInfo()
	return {
		name = "Spline Path Recording",
		desc = "Records a Units Path into a Spline",
		author = "PicassoCT",
		version = "1.0",
		date = "YearOfTheGNU",
		license = "GNU GPL, v2 or later",
		layer = math.huge,
		hidden = false,
		handler = true,
		enabled = true -- loaded by default?
	}
end
-- ARDevice --> Broadcast 
-- Host --> Broadcast his IP
-- ARDevice --> Send CFG to HostIP
-- HostWaits for Matrice DATA


local Chili, Screen0
SPLINE_PATH_START_KEY = string.byte("~")

boolSplinePathingActive = false
 function widget:KeyPress(key, mods, isRepeat, label, unicode)

	if  key == SPLINE_PATH_START_KEY then
		boolSplinePathingActive = true	
	end
 end
 
LEFT_MOUSE_BUTTON = 1
function widget:MouseRelease(mx, my, mButton)
	if mButton == LEFT_MOUSE_BUTTON and boolSplinePathingActive == true then
		boolSplinePathingActive = false
		-- Add final node (If different)
		local _, pos = spTraceScreenRay(mx, my, true)
		Spring.Echo("Splinestarting")
		if pos then
				Spring.SendLuaRulesMsg("SPLINESTART|"..mx.."|"..mz)
			--> Send to synced for V-Path Unit Creation
		end
	end
end
-- OnClick -> create Virtual Unit, go into FPS
-- while inFPs
	--store PointData
	
--Create Spline from Points






local function get_slope(is_edge, left, right)
   if is_edge then
      return zero_vector
   else
      local t = right.time - left.time
      assert(t > 0, "Non-increasing time sequence")
      return {(right[1] - left[1])/t, 
              (right[2] - left[2])/t, 
              (right[3] - left[3])/t}
   end
end

function smooth(checkpoints, frames_per_second)
   frames_per_second = frames_per_second or 5
   if #checkpoints < 2 then
      return checkpoints
   end
   -- Prepare formulas for each segment of spline
   local formulas = {}
   for segment = 1, #checkpoints - 1 do
      local left = checkpoints[segment]
      local right = checkpoints[segment + 1]
      local t = right.time - left.time
      assert(t > 0, "Non-increasing time sequence")
      local left_deriv = get_slope(segment == 1, 
         checkpoints[segment - 1], right)
      local right_deriv = get_slope(segment == #checkpoints - 1, 
         left, checkpoints[segment + 2])
      formulas[segment] = {}
      for j = 1, 3 do
         local d = left[j]
         local c = left_deriv[j]
         local a = (right[j] - d - c*t) / (t*t)
         local b = 3*a + (c - right_deriv[j])/t
         formulas[segment][j] = {(a - b)/t, b, c, d}
      end
   end
   -- Calculate spline points
   local total_seconds = checkpoints[#checkpoints].time - checkpoints[1].time
   local segment = 1
   local spline = {}
   for frame_no = 0, total_seconds * frames_per_second do
      local t = checkpoints[1].time + frame_no / frames_per_second
      local point = {time = t}
      while segment < #formulas and t > checkpoints[segment + 1].time do
         segment = segment + 1
      end
      t = t - checkpoints[segment].time
      for j = 1, 3 do
         local c = formulas[segment][j]
         point[j] = ((c[1]*t + c[2])*t + c[3])*t + c[4]
      end
      table.insert(spline, point)
   end
   return spline
end