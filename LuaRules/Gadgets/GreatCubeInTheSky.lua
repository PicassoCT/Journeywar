function gadget:GetInfo()
	return {
		name = "Great Cube In The Sky",
		desc = "Like a rotating sky-box",
		author = "zwzsg",
		date = "12 may 2010",
		license = "Please refer to form C57-3",
		version = 2,
		layer = 0,
		enabled = true
	}
end

-----------------------------
-- 0,0 -- 			-- 1,0--
-- 			-- North -- --
-- -- -- --
-----------------------------
-- -- -- --
-- East -- Top -- West --
-- -- -- --
-----------------------------
-- -- -- --
-- Down -- South -- --
-- 0,1 -- -- 1,1--
-----------------------------

if not gadgetHandler:IsSyncedCode() then
	VFS.Include('scripts/lib_UnitScript.lua', nil, VFSMODE)


	--UNSYNCED
	mapinfo =  VFS.Include("mapinfo.lua")
	Spring.Echo("GreatCubeInTheSky::mapOptions")
	echo(mapOptions)
	
		boolSkyboxActive= true
	if mapinfo and mapinfo.atmosphere and mapinfo.atmosphere.skyBox then
		boolSkyboxActive= false
	end
	
	local Cube = nil
	local HoloTable = nil
	
	local function HoloTableVertices()
		gl.TexCoord(0, 1)
		gl.Vertex(-1, -1, 1)
		gl.TexCoord(1, 1)
		gl.Vertex(1, -1, 1)
		gl.TexCoord(1, 0)
		gl.Vertex(1, -1, -1)
		gl.TexCoord(0, 0)
		gl.Vertex(-1, -1, -1)
	end
	
	local function CubeVertices()
		-- Top face
		gl.TexCoord(1 / 3, 1 / 3)
		gl.Vertex(1, 1, -1)
		gl.TexCoord(2 / 3, 1 / 3)
		gl.Vertex(-1, 1, -1)
		gl.TexCoord(2 / 3, 2 / 3)
		gl.Vertex(-1, 1, 1)
		gl.TexCoord(1 / 3, 2 / 3)
		gl.Vertex(1, 1, 1)
		-- South face
		gl.TexCoord(1 / 3, 2 / 3)
		gl.Vertex(1, 1, 1)
		gl.TexCoord(2 / 3, 2 / 3)
		gl.Vertex(-1, 1, 1)
		gl.TexCoord(2 / 3, 1)
		gl.Vertex(-1, -1, 1)
		gl.TexCoord(1 / 3, 1)
		gl.Vertex(1, -1, 1)
		-- East face
		gl.TexCoord(0, 1 / 3)
		gl.Vertex(1, -1, -1)
		gl.TexCoord(1 / 3, 1 / 3)
		gl.Vertex(1, 1, -1)
		gl.TexCoord(1 / 3, 2 / 3)
		gl.Vertex(1, 1, 1)
		gl.TexCoord(0, 2 / 3)
		gl.Vertex(1, -1, 1)
		-- West face
		gl.TexCoord(2 / 3, 1 / 3)
		gl.Vertex(-1, 1, -1)
		gl.TexCoord(1, 1 / 3)
		gl.Vertex(-1, -1, -1)
		gl.TexCoord(1, 2 / 3)
		gl.Vertex(-1, -1, 1)
		gl.TexCoord(2 / 3, 2 / 3)
		gl.Vertex(-1, 1, 1)
		-- North face
		gl.TexCoord(1 / 3, 0)
		gl.Vertex(1, -1, -1)
		gl.TexCoord(2 / 3, 0)
		gl.Vertex(-1, -1, -1)
		gl.TexCoord(2 / 3, 1 / 3)
		gl.Vertex(-1, 1, -1)
		gl.TexCoord(1 / 3, 1 / 3)
		gl.Vertex(1, 1, -1)
		-- Down face
		gl.TexCoord(0, 1)
		gl.Vertex(-1, -1, 1)
		gl.TexCoord(0.33, 1)
		gl.Vertex(1, -1, 1)
		gl.TexCoord(0.33, 0.67)
		gl.Vertex(1, -1, -1)
		gl.TexCoord(0, 0.67)
		gl.Vertex(-1, -1, -1)
	end
	
	
	local function DrawCube()
		gl.PushAttrib(GL.ALL_ATTRIB_BITS)
		gl.DepthTest(true)
		gl.Texture(":ca:bitmaps/GreatCubeInTheSky.png") -- Change this to your texture.
		gl.BeginEnd(GL.QUADS, CubeVertices)
		gl.Texture(false)
		gl.Color(1, 1, 1, 1)
		gl.PopAttrib()
	end
	
	local function DrawTable()
		gl.PushAttrib(GL.ALL_ATTRIB_BITS)
		gl.DepthTest(true)
		gl.Texture(":ca:bitmaps/holotable.png") -- Change this to your texture.
		gl.BeginEnd(GL.QUADS, HoloTableVertices)
		gl.Texture(false)
		gl.Color(1, 1, 1, 1)
		gl.PopAttrib()
	end
	
	
	function gadget:DrawWorldPreUnit()
		
		if not HoloTable then
			HoloTable = gl.CreateList(DrawTable)
		end
		if not Cube then
			Cube = gl.CreateList(DrawCube)
		end
		
		local x, y, z = Spring.GetCameraPosition()
		local d = 1.8 * math.max(Game.mapSizeX, Game.mapSizeZ, y)
		local f = 9001 + Spring.GetGameFrame()
		if boolSkyboxActive == false then
			gl.PushMatrix()
			gl.Translate(x, y, z)
			gl.Scale(d, d, d)
			f = (f / 100) % 360
			gl.Rotate(f / 2, f / 2, 0, 1) -- Angle, then axis of rotation
			gl.CallList(Cube)
			gl.PopMatrix()			
		
		
		gl.PushMatrix()
		gl.Translate(x, y, z)
		gl.Scale(d * 0.8, d, d * 0.8)
		gl.Rotate(1, 1, 1, 1) -- Angle, then axis of rotation
		gl.CallList(HoloTable)
		gl.PopMatrix()
		end
	end
	
	function gadget:Shutdown()
		if Cube then
			gl.DeleteList(Cube)
			Cube = nil
			Holotable = nil
		end
	end
end