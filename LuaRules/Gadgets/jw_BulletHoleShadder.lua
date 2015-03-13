function gadget:GetInfo()
  return {
    name      = "BulletHoleshader",
    desc      = "Fire in the hole- another word for yesterdays peperoni",
    author    = "me",
    date      = "Sep. 20014",
    license   = "The Exhibitionistic GPL- meaning if you use this, you have to talk a day and a hour to everyone you meet about journeywar",
    layer     = 0,
    enabled   = false,
  }
end

if (gadgetHandler:IsSyncedCode()) then


   function GetWeaponIndex(weaponname,unitname)
   if UnitDefNames[unitname] and UnitDefNames[unitname].weapons then
		for i=1, table.getn(UnitDefNames[unitname].weapons),1 do
			if UnitDefNames[unitname].weapons[i].name == weaponname then return i end
		end
	end
   end
   
	local HoleInOneT={}
	unitdefWeaponPos=GetWeaponIndex("comendsniper","ccomender")
	HoleInOneT[WeaponDefNames["comendsniper"].id] = {diameter=45,pos=unitdefWeaponPos }	
	unitdefWeaponPos=GetWeaponIndex("sniperslavemelee","csniper")	
	HoleInOneT[WeaponDefNames["sniperslavemelee"].id] = {diameter=45, pos= 1}
	local PIECE_VOLUMEMINFORHOLE = 420
	local PIECE_INV = 1/PIECE_VOLUMEMINFORHOLE

		--set the weapons registrated above on the watchlist
		for k,_ in ipairs(HoleInOneT) do
		Script.SetWatchWeapon(k , true)
		end
	--Sends Hole Data to unsynced
	function TearANewOne(unitid, piecename, x,y,z, amountOfDamage, dirSX, dirSY, dirSZ,WeaponType)
		sx,sy,sz,ox,oy,oz=Spring.GetUnitPieceCollisionVolumeData(unitid, piecename)
		if ((sx*ox)*(sz*oz)*(sy*oy))*PIECE_INV > PIECE_VOLUMEMINFORHOLE then 
		--find out if that shot makes a hole
		_,max=Spring.GetUnitHealth(unitid)
			if amountOfDamage > max/12 and (nx*dirSX+ny*dirSY+nz*dirSZ) > 1.5 then
			Hole={	unitID=unitid,
					piecename=piecename,
					depth=amountOfDamage/max,
					diameter=HoleInOneT[WeaponType].diameter,
					pos={[1]=x,[2]=y,[3]=z}, 
					dirShot={[1]=dirSX,[2]=dirSY,[3]=dirSZ},
					teamColourInternal={ [1]=1.0,[2]=0.0,[3]=0.0,[4]=0.0},
					teamColurExternal={[1]=0.0,[2]=1.0,[3]=0.0,[4]=0.0}
					}
					
			SendToUnsynced("BulletHole", Hole)
			end
		end
	end

	function gadget:UnitDamaged(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam) 
			if HoleInOneT[weaponDefID] then	
			Spring.Echo("JW_BULETHOLESHADER::YOU KNOW IT HIT HIM LIKE A HAMMER!")
			vx,vy,vz=Spring.GetUnitWeaponVectors(attackerID, HoleInOneT[weaponDefID].pos)
				if vx then
				norm=math.sqrt(vx*vx+vy*vy+vz*vz)*-1
				vx,vy,vz=vx/norm,vy/norm,vz/norm
			
				piecename,frame=Spring.GetUnitLastAttackedPiece(unitID)
				map=Spring.GetUnitPieceMap(unitID)
					Spring.Echo(#map)
					Spring.Echo(map)
				Spring.Echo(map[piecename])
			
				TearANewOne(unitID,map[piecename], x,y,z, amountOfDamage, vx,vy,vz, weaponDefID)
				else
				Spring.Echo("JW_BULETHOLESHADER:: No viable WeaponVector found")
				end
			end
	end
	
else  --UNSYNCED
	--shaderCode
	---[[----------------------------------------------------------------------------
	local vertexShaderSource=[[

//#define use_shadow
	#define MaxDepth= 50
    uniform mat4 camera;   //ViewMatrix (gl_ModelViewMatrix is ModelMatrix!)
    uniform vec3 cameraPos;
    uniform vec3 sunPos;
    uniform vec3 sunDiffuse;
    uniform vec3 sunAmbient;
  #ifdef use_shadow
    uniform mat4 shadowMatrix;
    uniform vec4 shadowParams;
  #endif

	vec4 transformPointAlongNormal(vec4 point, vec3 impactNormal, float scalar)
	{
	impactNormal=impactNormal * scalar
	point=point + impactNormal	
	return point
	}
	
	float ScalarByDistance(float Distance, float Diameter)
	{
	float relPos=Distance/Diameter;
	if (relPos < 0.5) return (1-relPos)*MaxDepth; 
	if (relPos >= 0.5) return -1*(x*x)*(0.5*MaxDepth)+MaxDepth;
	}

    float DistToPoint(vec3 point,vec3 point2)
	{
	point.x -= point2.x;
	point.y -= point2.y;
	point.z -= point2.z;
	return Sqrt(point.x* point.x + point.y*point.y+ point.z*point.z);
	}
	
    varying vec3 normal;
    varying vec3 cameraDir;
    varying vec3 teamColor;
    varying vec3 light;
	
	//poped from the stack variables
	uniform float depth;
	uniform float diameter;
	
	uniform float posX    ;
	uniform float posY    ;
	uniform float posZ    ;
	uniform float dirX    ;
	uniform float dirY    ;
	uniform float dirZ    ;
	
	//Shadder draws bulletholes on unitbodies, looking like this
	//__.-.   .-.__
	//     \_/
	//
	//_____    ______
		   \__/
	
	
	//colours of the wound interior rgb
	uniform float tColInt1;
    uniform float tColInt2;
	uniform float tColInt3;
	//colours of the wound extended rgb
	uniform float tColExt1;
	uniform float tColExt2;
	uniform float tColExt3;
	
	
	varying vec3  pos;
	varying vec4  dirShot;
	
    void main(void)
    {
		int i;
      gl_TexCoord[0].st = gl_MultiTexCoord0.st;
	    float DistPoint=0;
		
		for (i=0; i<VertexContainer; i++)
		{
		DistPoint=DistToPoint(VertexContainer[i],pos);
	
			//if your vertex point is near enough to the impact- and yes this reaches parts on the other side- and deforms them outwards
			if ( DistPoint < 2*diameter)
			{
			transformPointAlongNormal( ScalarByDistance(VertexContainer[i],pos,diameter));
			}
		}
	  //gl_Vertex=gl_Vertex*4 // You get a big head from getting shot at
	  
      vec4 worldPos = gl_ModelViewMatrix * v;
	  
	  //GL Magic here the unit is setup to release back into the world
      normal    = normalize(gl_NormalMatrix * gl_Normal);
      cameraDir = worldPos.xyz - cameraPos;
	  teamColor = gl_TextureEnvColor[0].rgb;

      float a = max( dot(normal, sunPos), 0.0);
      light   = a * sunDiffuse + sunAmbient;

     #ifdef use_shadow
      gl_TexCoord[1] = shadowMatrix * worldPos;
      gl_TexCoord[1].st = gl_TexCoord[1].st * (inversesqrt( abs(gl_TexCoord[1].st) + shadowParams.z) + shadowParams.w) + shadowParams.xy;
     #endif

      gl_Position = gl_ProjectionMatrix * camera * worldPos;
    ]]
	
	
	local shaderTable = {
	vertex= vertexShaderSource,
	-- fragment = fragmentShaderSource,
	-- uniformInt = uniformInt,
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
	local PenetratedUnits ={}
	
	
	--Transfers the Data to the shader
	local function BulletHole(callname,Hole)		
	--Forge values in which to store the Holes Data
					if gl.CreateShader then
					Spring.Echo("JW_BULETHOLESHADER::forging Shader")
					shaderTable.uniform={	depth=Hole.depth,
											diameter=Hole.diameter, 
											posX=Hole.pos[1],
											posY=Hole.pos[2], 
											posZ=Hole.pos[3], 
											dirX=Hole.dirShot[1],
											dirY=Hole.dirShot[2],
											dirZ=Hole.dirShot[3],
											tColInt1=Hole.teamColourInternal[1],
											tColInt2=Hole.teamColourInternal[2],
											tColInt2=Hole.teamColourInternal[3],
											tColExt1=Hole.teamColurExternal[1],
											tColExt2=Hole.teamColurExternal[2],
											tColExt3=Hole.teamColurExternal[3],
											}
											
											
					shaderProgram=gl.CreateShader(shaderTable)			
						if shaderProgram then 
						PenetratedUnits[Hole.unitID]={shader=shaderProgram, piecename=Hole.piecename} 
						else
						Spring.Echo("shader not created")
						Spring.Echo(gl.GetShaderLog())
						end
					Spring.UnitRendering.SetUnitLuaDraw(Hole.unitID,true)
					else
					Spring.Echo("<BulletHoleshader>: GLSL not supported.")
					end
	end

	function gadget:Initialize()   
		Spring.Echo("BulletHoleshader Initialised")
      -- This associate the messages with the functions
      -- So that when the synced sends a message "f" it calls the function f in unsynced
		gadgetHandler:AddSyncAction("BulletHole", BulletHole)
	end	  
    
	function gadget:DrawUnit(unitID, drawMode)
		if PenetratedUnits[unitID] then
		-- DODO is that the shader works for the whole unit.. not only for the unitpiece
		--Solutions, store the piecename in the shader and grab the piece-matrix
		glUseShader(PenetratedUnits[unitID].shader)	
		PenetratedUnits[unitID]=nil
		end
	end 
	
end 

--[[
uniform vec2 mapSizePO2;     // (1.0 / pwr2map{x,z} * SQUARE_SIZE)
uniform vec2 mapSize;        // (1.0 /     map{x,z} * SQUARE_SIZE)

uniform mat4 shadowMatrix;
uniform vec4 shadowParams;

uniform vec3 camPos;

uniform float simFrame;
uniform vec3 windSpeed;

const float PI = 3.14159265358979323846264;

void main() {
	vec2 texOffset = vec2(0.,0.);

	#ifdef DISTANCE_NEAR
		#ifdef SHADOW_GEN
		vec4 vertexPos = gl_Vertex;
		#else
		vec4 vertexPos = gl_ModelViewMatrix * gl_Vertex;
		#endif
		#ifdef ANIMATION
		vec2 windScale;
		windScale.x = sin((simFrame + gl_MultiTexCoord0.s) * 5.0 / (10.0 + floor(gl_MultiTexCoord0.s))) * 0.01;
		windScale.y = (1.0 + sin((vertexPos.x + vertexPos.z) / 45.0 + simFrame / 15.0)) * 0.025;
		windScale *= gl_MultiTexCoord0.tt;

		vertexPos.x += dot(windSpeed.zx, windScale);
		vertexPos.z += dot(windSpeed.xz, windScale);
		#endif

	vec4 worldPos = vertexPos;
	#endif

	#ifdef DISTANCE_FAR
	vec4 worldPos = gl_Vertex;
		vec3 billboardDirZ = normalize(gl_Vertex.xyz - camPos.xyz);
		vec3 billboardDirX = normalize(cross(billboardDirZ, vec3(0.,1.,0.)));
		vec3 billboardDirY = cross(billboardDirX, billboardDirZ);
		float ang = acos(billboardDirZ.y);
		texOffset.x = clamp(floor((ang + PI / 16.0 - PI / 2.0) / PI * 30.0), 0.0, 15.0) / 16.0;

		#ifdef ANIMATION
		float windScale =
			0.005 * (1.0 + sin((worldPos.x + worldPos.z) / 45.0 + simFrame / 15.0)) *
			gl_Normal.y * (1.0 - texOffset.x);

		 worldPos.xz += (windSpeed.xz * windScale);
		#endif

		worldPos.xyz += billboardDirX * gl_Normal.x * (1.0 + windScale);
		worldPos.xyz += billboardDirY * gl_Normal.y * (1.0 + windScale);
		worldPos.xyz += billboardDirZ;

	vec4 vertexPos = gl_ModelViewMatrix * worldPos;
	#endif

	#if defined(HAVE_SHADOW) || defined(SHADOW_GEN)
	vec2 p17 = vec2(shadowParams.z, shadowParams.z);
	vec2 p18 = vec2(shadowParams.w, shadowParams.w);
	#ifdef SHADOW_GEN
	vec4 vertexShadowPos = gl_ModelViewMatrix * worldPos;
	#else
	vec4 vertexShadowPos = shadowMatrix * worldPos;
	#endif
		vertexShadowPos.st *= (inversesqrt(abs(vertexShadowPos.st) + p17) + p18);
		vertexShadowPos.st += shadowParams.xy;

	gl_TexCoord[1] = vertexShadowPos;
	#endif

	#ifdef SHADOW_GEN
	{
		gl_TexCoord[3].st = gl_MultiTexCoord0.st + texOffset;
		gl_Position = gl_ProjectionMatrix * vertexShadowPos;
		return;
	}
	#endif

	gl_TexCoord[0].st = worldPos.xz * mapSizePO2;
	gl_TexCoord[2].st = worldPos.xz * mapSize;
	gl_TexCoord[3].st = gl_MultiTexCoord0.st + texOffset;

	gl_FrontColor = gl_Color;
	gl_Position = gl_ProjectionMatrix * vertexPos;

	gl_FogFragCoord = distance(camPos, worldPos.xyz);
	gl_FogFragCoord = (gl_Fog.end - gl_FogFragCoord) * gl_Fog.scale;
	gl_FogFragCoord = clamp(gl_FogFragCoord, 0.0, 1.0);
}
]]