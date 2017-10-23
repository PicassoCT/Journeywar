function gadget:GetInfo()
  return {
    name      = "Deformation per Piece",
    desc      = "Linear Deforms two equalpieces per animation into another",
    author    = "Everyone and the dog ",
    date      = "Sep. 20014",
    license   = "ARGLWARGL - you just made that, up did you. Yes, and it will cost you 2500 $ with your lawyer to check on              that. Unless you GPL your own stuff  - then its luarules.",
    layer     = 0,
    enabled   = false,
	--Currently Defunct due to lack of glsl foo
  }
end

if (gadgetHandler:IsSyncedCode()) then
  
    function gadget:frame(frame)
    if frame % 5 == 0 then
    if GG.MeshDefAnim then
      local MDeform=MeshDefAnim 
      for i=1,#MDeform,1 do
        Deform(MDeform.unitid, MDeform.piecePairTime)
      end  
    end
    end
      
    end
  

    function Deform(unit, piecePairTime)
      Descriptor={id=unit,piecePairTime}
      
					
			SendToUnsynced("DeformAnimation", Descriptor)
		end
	
else  --UNSYNCED
	--shaderCode
	---[[----------------------------------------------------------------------------
	local vertexShaderSource=[[
  
  for (int i=1,i< sizeof(dla)/sizeof(float3),i++)
  {
  vertex[i] =mix (dla[i],dlb[i],percentage);
  }
  
    ]]
	
	
	local shaderTable = {
	vertex= vertexShaderSource,
	-- fragment = fragmentShaderSource,
	 uniformInt = uniformInt,
	}
	--]]--------------------------------------------------------------------------	

	--variables for the task ahead	
	local shaderProgram 	
	local glUseShader 		= gl.UseShader
	local glCopyToTexture 	= gl.CopyToTexture
	local glTexture 		= gl.Texture
	local glTexRect 		= gl.TexRect
	local boolShaderWorking	= true
	local vsx,vsy 
	local screencopy
	local boolWorking=true
	local DeformedUnits ={}
	

	
	--Transfers the Data to the shader
	local function DeformAnimation(callname,Descriptor)		
	--Forge values in which to store the Holes Data
					if gl.CreateShader then
					Spring.Echo(" _DeformationShadder::forging Shader")
        --  Descriptor={id=unit,piecePairTime} 
        --piecePairTime contains pieceA, piece B (equal in Vertexes), a startframe, a    finnishframe
        prevMax=#shaderTable.UniformInt
        for i=1,#Descriptor,1 do
          for k=1,#Descriptor.piecePairTime, 1 do
            
  materialID=TODO
  
      if (Descriptor.piecePairTime.pieceA) then
        if (not dla) then
          dla = gl.CreateList(function()
            gl.MultiTexCoord(4,100)
            gl.UnitPiece(Descriptor.id,Descriptor.piecePairTime.pieceA)
            gl.MultiTexCoord(4,0)
            end)
        end
        Spring.UnitRendering.SetPieceList(Descriptor.id,materialID,Descriptor.piecePairTime.pieceA,dla)
      end   
      
      if (Descriptor.piecePairTime.pieceB) then
        if (not dlb) then
            dlb = gl.CreateList(function()
            gl.MultiTexCoord(4,100)
            gl.UnitPiece(Descriptor.id,Descriptor.piecePairTime.pieceB)
            gl.MultiTexCoord(4,0)
            end)
        end
        Spring.UnitRendering.SetPieceList(Descriptor.id,materialID,Descriptor.piecePairTime.pieceB,dlb)
      end
 
            
            
             shaderTable.UniformInt[Max+i]={pieceA=dla,
                                            pieceB=dlb,
                                            percentage=(frame-piecePairTime.startframe)/piecePairTime.totframe,
                                            id=Descriptor.id
                                            }
          end
        end
                                          
            shaderProgram=gl.CreateShader(shaderTable)			
						if shaderProgram then 
						DeformedUnits[Descriptor.id]={shader=shaderProgram,
                                          frame=frame, 
                                          oldpercentage=math.abs(startframe-frame/frame),
                                          percentage=math.abs(startframe-frame/frame),
                                          startframe=startframe, 
                                          frame=frame,
                                          shaderTable=shaderTable,
                                          shader=shaderProgram} 
						else
						Spring.Echo("shader not created")
						Spring.Echo(gl.GetShaderLog())
						end
					Spring.UnitRendering.SetUnitLuaDraw(Descriptor.id,true)
					else
					Spring.Echo("<DeformShadder>: GLSL not supported.")
					end
	end

	function gadget:Initialize()   
		Spring.Echo("DeformShadder Initialised")
      -- This associate the messages with the functions
      -- So that when the synced sends a message "f" it calls the function f in unsynced
		gadgetHandler:AddSyncAction("DeformAnimation", DeformAnimation)
	end	  
  
  frame=0
	function gadget:frame(f)
  frame=f
  end
  
  function gadget:DrawUnit(unitID, drawMode)
		if DeformedUnits[unitID] then
      glUseShader(DeformedUnits[unitID].shader)	
		-- DODO is that the shader works for the whole unit.. not only for the unitpiece
		--Solutions, store all the piecevertexmatrices in the shader 
    DeformedUnits[unitID].frame=frame

    DeformedUnits[unitID].percentage=math.abs(DeformedUnits[unitID].startframe-frame/DeformedUnits[unitID].frame)
      if (DeformedUnits[unitID].percentage-DeformedUnits[unitID].oldpercentage)>0.01 then
        --update the shadder program.. 
        --i dont know how to pipe it otherwise up, so i frequently recompile the whole shadder
        DeformedUnits[unitID].shader= gl.CreateShader(DeformedUnits[unitID].ShaderProgram) or DeformedUnits[unitID].shader
      end
    
		glUseShader(0)	
		end
	end 
	
end 
