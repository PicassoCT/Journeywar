    function widget:GetInfo()
            return {
                            name    = "draw Dialog",
                            desc    = "Show all ID of units, features, projectiles",
                            author  = "zwzsg, knorke",
                            date    = "August 2010",
                            license = "Free",
                            layer   = 0,
                            enabled = true,
                    }
    end
  
local glTranslate      = gl.Translate
local glColor          = gl.Color
local glBillboard      = gl.Billboard
local glText           = gl.Text
local glDepthMask      = gl.DepthMask
local glDepthTest      = gl.DepthTest
local glAlphaTest      = gl.AlphaTest
local glBlending       = gl.Blending
local glDrawFuncAtUnit = gl.DrawFuncAtUnit
local glPushMatrix     = gl.PushMatrix
local glPopMatrix      = gl.PopMatrix

local GL_GREATER             = GL.GREATER
local GL_SRC_ALPHA           = GL.SRC_ALPHA
local GL_ONE                 = GL.ONE
local GL_ONE_MINUS_SRC_ALPHA = GL.ONE_MINUS_SRC_ALPHA
     

function widget:DrawWorld()
  --if Spring.IsGUIHidden() then return end

  glDepthTest(true)
  glAlphaTest(GL_GREATER, 0)
  glBlending(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)
   
  
  	if _G and  _G.Dialog then
	local dialog=_G.Dialog
		for i=1,#dialog do
		
		
			local element=dialog[i]
			
			if element.frames > 0 then
				local x,y=Spring.WorldToScreenCoords(element.x,element.y,element.z)
				gl.Text(element.txt,x,y,16,"od")		
			end
		end
	end

  glAlphaTest(false)
  glColor(1,1,1,1)
  glDepthTest(false)
end

----------------------------------------------------------
local function drawText(text,ux,uy,uz,textSize )
  
  glPushMatrix()
  glTranslate(ux, uy, uz)
  glBillboard()
  gl.MultiTexCoord(1, 0.25 + (0.5 ))
  

    glColor(1, 1, 1)

  
  glText(text, 0, 0, textSize, "cno")
  
  glPopMatrix()
end

lastTime=0

function widget:DrawWorld()
  local theTime = Spring.GetGameSeconds()
  
	  if (theTime ~= lastTime) then
	  
	 
	  
	  lastTime = theTime
	 
		
	  _,_,paused = Spring.GetGameSpeed()
	  
	  glDepthMask(true)
	  glDepthTest(true)
	  glAlphaTest(GL_GREATER, 0)
	  glBlending(GL_SRC_ALPHA, GL_ONE)
		gl.Texture(1, LUAUI_DIRNAME .. "images/gradient_alpha_2.png")
	if _G and _G.Dialog then
	 local dialog= _G.Dialog


	  for i, tables in pairs(dialog) do

		 local element=dialog[i]	
		  drawText(element.txt, element.x, element.y, element.z,16,"od")
		  
	  end
	end
	  gl.Texture(1, false)
	  glBlending(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)
	  glAlphaTest(false)
	  glDepthTest(false)
	  glDepthMask(false)
	end
end
