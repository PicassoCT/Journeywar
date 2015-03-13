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
  
local glDepthTest        		= gl.DepthTest
local glAlphaTest        		= gl.AlphaTest
local glColor            		= gl.Color
local glText             		= gl.Text
local glTranslate        		= gl.Translate
local glBillboard        		= gl.Billboard
local glDrawFuncAtUnit   		= gl.DrawFuncAtUnit
local GL_GREATER     	 		= GL.GREATER
local GL_SRC_ALPHA				= GL.SRC_ALPHA	
local GL_ONE_MINUS_SRC_ALPHA	= GL.ONE_MINUS_SRC_ALPHA
local glBlending          		= gl.Blending 
     

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
