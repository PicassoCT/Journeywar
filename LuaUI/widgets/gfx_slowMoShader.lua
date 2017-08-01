----------------------------------------------------------------------------------------------------
--                                          TACTICAL GRID                                         --
--                         Widget display tactical grid and border fade.                          --
----------------------------------------------------------------------------------------------------
function widget:GetInfo()
        return {
                name      = "TacticalGrid",
                desc      = "Tactical Grid Tool",
                author    = "a1983",
                date      = "21 12 2012",
                license   = "xxx",
                layer     = math.huge,
                --handler   = true, -- used widget handlers
                enabled   = true  -- loaded by default,
				--hidden 	  = true
        }
end
----------------------------------------------------------------------------------------------------

local vsx, vsy
local screencopy
local shaderProgram

local glUseShader = gl.UseShader
local glCopyToTexture = gl.CopyToTexture
local glTexture = gl.Texture
local glTexRect = gl.TexRect

--vec3(0.491, 0.831, 0.261)
	nightvision = [[
		uniform sampler2D screencopy;
		
		float getIntensity(vec4 color) {
		  vec3 intensityVector = color.rgb * vec3(0.491, 0.261, 0.831);
		  return length(intensityVector);
		}
		
		void main() {
		  vec2 texCoord = vec2(gl_TextureMatrix[0] * gl_TexCoord[0]);
		  vec4 origColor = texture2D(screencopy, texCoord);
		  float intensity = getIntensity(origColor);
		  intensity = intensity * 1.5;
		  if (intensity > 1) intensity = 1;
		  if (intensity < 0.5) {
			if (intensity < 0.2) {
			  gl_FragColor = vec4(intensity*0.15, intensity*0.15, intensity*0.15, 0.9);
			} else if (intensity < 0.35) {
			  gl_FragColor = vec4(intensity*0.15, intensity*0.4, intensity*0.15, 0.9);
			} else {
			  gl_FragColor = vec4(intensity*0.2, intensity*0.8, intensity*0.2, 0.9);
			}
		  } else {
			if (intensity < 0.75) {
			  if (mod(gl_FragCoord.y, 4.0) < 2.0) {
				gl_FragColor = vec4(intensity*0.5, intensity*0.8, intensity*0.3, 0.9);
			  } else {
				gl_FragColor = vec4(intensity*0.2, intensity, intensity*0.4, 1);
			  }
			} else {
			  gl_FragColor = vec4(intensity*0.5, intensity, intensity*0.7, 0.9);
			}
		  }
		}
	]],

	local uniformInt = {
	  screencopy = 0,
	}

	local shaderTable = {
	  fragment = fragmentShaderSource.nightvision,
	  uniformInt = uniformInt,
	}

function widget:Initialize()
  vsx, vsy = widgetHandler:GetViewSizes()
  widget:ViewResize(vsx, vsy)
  
	if gl.CreateShader then
		shaderProgram = gl.CreateShader(shaderTable)
	else
		Spring.Echo("<Night Vision Shader>: GLSL not supported.")
	end
  
	if not shaderProgram then
    Spring.Log(widget:GetInfo().name, LOG.ERROR, gl.GetShaderLog())
    widgetHandler:RemoveWidget()
	end	

end

function widget:Shutdown()
	if shaderProgram then
		gl.DeleteShader(shaderProgram)
	end
end
	
function widget:ViewResize(viewSizeX, viewSizeY)
	vsx, vsy = viewSizeX, viewSizeY

screencopy = gl.CreateTexture(vsx, vsy, {
    border = false,
    min_filter = GL.NEAREST,
    mag_filter = GL.NEAREST,
	})
end



function widget:DrawScreenEffects()
	if WG.boolDrawSlowMoVision and WG.boolDrawSlowMoVision == true then
	  glCopyToTexture(screencopy, 0, 0, 0, 0, vsx, vsy)
	  glTexture(0, screencopy)
	  glUseShader(shaderProgram)
	  glTexRect(0,vsy,vsx,0)
	  glTexture(0, false)
	  glUseShader(0)
	end
end
	