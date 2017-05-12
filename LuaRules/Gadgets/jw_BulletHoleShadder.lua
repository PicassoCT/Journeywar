function gadget:GetInfo()
    return {
        name = "BulletHoleshader",
        desc = "Fire in the hole- another word for yesterdays peperoni",
        author = "me",
        date = "Sep. 20014",
        license = "The Exhibitionistic GPL- meaning if you use this, you have to talk a day and a hour to everyone you meet about journeywar",
        layer = 0,
        enabled = false,
    }
end

if (gadgetHandler:IsSyncedCode()) then


    function GetWeaponIndex(weaponname, unitname)
        if UnitDefNames[unitname] and UnitDefNames[unitname].weapons then
            for i = 1, table.getn(UnitDefNames[unitname].weapons), 1 do
                if UnitDefNames[unitname].weapons[i].name == weaponname then return i end
            end
        end
    end

    local HoleInOneT = {}
    unitdefWeaponPos = GetWeaponIndex("comendsniper", "ccomender")
    HoleInOneT[WeaponDefNames["comendsniper"].id] = { diameter = 45, pos = unitdefWeaponPos }
    unitdefWeaponPos = GetWeaponIndex("sniperslavemelee", "csniper")
    HoleInOneT[WeaponDefNames["sniperslavemelee"].id] = { diameter = 45, pos = 1 }
    local PIECE_VOLUMEMINFORHOLE = 420
    local PIECE_INV = 1 / PIECE_VOLUMEMINFORHOLE

    --set the weapons registrated above on the watchlist
    for k, _ in ipairs(HoleInOneT) do
        Script.SetWatchWeapon(k, true)
    end
    --Sends Hole Data to unsynced
    function TearANewOne(unitid, piecename, x, y, z, amountOfDamage, dirSX, dirSY, dirSZ, WeaponType)
        sx, sy, sz, ox, oy, oz = Spring.GetUnitPieceCollisionVolumeData(unitid, piecename)
        if ((sx * ox) * (sz * oz) * (sy * oy)) * PIECE_INV > PIECE_VOLUMEMINFORHOLE then
            --find out if that shot makes a hole
            _, max = Spring.GetUnitHealth(unitid)
            if amountOfDamage > max / 12 and (nx * dirSX + ny * dirSY + nz * dirSZ) > 1.5 then
                Hole = {
                    unitID = unitid,
                    piecename = piecename,
                    depth = amountOfDamage / max,
                    diameter = HoleInOneT[WeaponType].diameter,
                    pos = { [1] = x, [2] = y, [3] = z },
                    dirShot = { [1] = dirSX, [2] = dirSY, [3] = dirSZ },
                    teamColourInternal = { [1] = 1.0, [2] = 0.0, [3] = 0.0, [4] = 0.0 },
                    teamColurExternal = { [1] = 0.0, [2] = 1.0, [3] = 0.0, [4] = 0.0 }
                }

                SendToUnsynced("BulletHole", Hole)
            end
        end
    end

    function gadget:UnitDamaged(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, projectileID, attackerID, attackerDefID, attackerTeam)
        if HoleInOneT[weaponDefID] then
            Spring.Echo("JW_BULETHOLESHADER::YOU KNOW IT HIT HIM LIKE A HAMMER!")
            vx, vy, vz = Spring.GetUnitWeaponVectors(attackerID, HoleInOneT[weaponDefID].pos)
            if vx then
                norm = math.sqrt(vx * vx + vy * vy + vz * vz) * -1
                vx, vy, vz = vx / norm, vy / norm, vz / norm

                piecename, frame = Spring.GetUnitLastAttackedPiece(unitID)
                map = Spring.GetUnitPieceMap(unitID)
                Spring.Echo(#map)
                Spring.Echo(map)
                Spring.Echo(map[piecename])

                TearANewOne(unitID, map[piecename], x, y, z, amountOfDamage, vx, vy, vz, weaponDefID)
            else
                Spring.Echo("JW_BULETHOLESHADER:: No viable WeaponVector found")
            end
        end
    end

else --UNSYNCED
    --shaderCode
    --- [[----------------------------------------------------------------------------
    local vertexShaderSource = [[

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

	attribute vec3 position;
attribute vec3 normal;
uniform mat3 normalMatrix;
uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;
varying vec3 fNormal;
varying vec3 fPosition;
uniform float time;
varying float depthHole;
varying float holeMax;
float PI= 3.14159;
float PI_2= 3.14159/2.0;
struct hole
{
  vec3 dir;
  vec3 modPos;
  float diameter;
  };

#define randO( co)  fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453)
#define signEqual(  X, Y) (sign(X) == sign(Y))

 hole watHitIt;
//TODO: Converter for world to modelholes -

// dist_Point_to_Segment(): get the distance of a point to a segment
//     Input:  a Point P and a Segment S (in any dimension)
//     Return: the shortest distance from P to S
float dist_Point_to_Segment( vec3 P, vec3 SP0, vec3 SP1)
{
     vec3 v = SP1 - SP0;
     vec3 w = P - SP0;

     float c1 = dot(w,v);
     if ( c1 <= 0.0 )
          return distance(P, SP0);

     float c2 = dot(v,v);
     if ( c2 <= c1 )
          return distance(P, SP1);

     float b = c1 / c2;
     vec3 Pb = SP0 + b * v;
     return distance(P, Pb);
}

//calculate wether we are on the entry or exit point of the bullet
bool vecDirEqNorm(vec3 Normal, vec3 dir )
{
  if( signEqual(Normal.x,dir.x) && signEqual(Normal.y, dir.y) && signEqual(Normal.z, dir.z)) return true;
  
  return false;
}


/*                        zzzzz                                               */
/*                       zz   z                                               */
/*                       z    zzzzzzzz                                        */
/*                       z                                                    */
/*                       z                                                    */
/*                      zz                                                    */
/*                      z                                                     */
/*                     zz                                                     */
/*                 zzzzz                                                      */
/*                                                                            */
/*    The Deformation as  Cosin and sin                                        */

float effectByDistance(float distP)
{
  if (distP <= 0.4) return (-1.0 + (1.0-cos(distP*PI_2)))*2.125 ;
  
   if (distP <= 0.9) return (1.0 - cos( ((distP-0.40)/0.5)*PI_2)  )*2.0;
 
  return max( abs (1.0-cos(((distP-0.8)/0.2)*PI_2)),0.0) ;
 
}

void main()
{
  fNormal = normalize(normalMatrix * normal);
  fNormal= normal;
  //vec4 pos = modelViewMatrix * vec4(position, 1.0);
  float dist;

  watHitIt.modPos=vec3(0.0,0.4,0.0);
  watHitIt.dir= vec3(0.0,1.0,0.0);
  watHitIt.diameter=0.5;
  holeMax=watHitIt.diameter;

  //computate the distance of vertext to bullethole
  dist=dist_Point_to_Segment(position, watHitIt.modPos+watHitIt.dir*2.0,watHitIt.modPos+watHitIt.dir*-2.0); 
  //&& (vecDirEqNorm(fNormal,watHitIt.dir*-1.0))
  depthHole=dist;
  float factor= dist <   watHitIt.diameter ?   effectByDistance(dist/watHitIt.diameter): 0.0;

    vec3 newPosition = position + fNormal * factor/15.0;
    gl_Position = projectionMatrix * modelViewMatrix * vec4( newPosition, 1.0  );


}
    ]]

    local fragmentShaderSource = [[
	precision highp float;
uniform float time;
uniform vec2 resolution;
varying vec3 fPosition;
varying vec3 fNormal;
varying float depthHole;
vec3 black=vec3(0.0,0.0,0.0);
vec3 white=vec3(0.8,0.95,1.0);
varying float holeMax;

vec3 bulletColours(float depth, vec3 orgcol)
{
  
  if (depth < 0.2) return black;
  
  if (depth < 0.4)
  { 
    
    float relDeth=( (depth- 0.2)/ 0.2);
    
    return ((1.0 -relDeth)*black+ (relDeth)*white);
    }
  
  float relDeth=( (depth- 0.4)/ 0.2);
  return (1.0 - relDeth)*sqrt(black)+ (relDeth)*orgcol;
  }


void main()
{vec3 col;

    col=normalize(fNormal);
    
  if (depthHole!= 0.0 && depthHole < holeMax+0.1)
    col= bulletColours(depthHole,col);
  gl_FragColor = vec4(col, 1.001);
  
}
	]]
    local shaderTable = {
        vertex = vertexShaderSource,
        fragment = fragmentShaderSource,
        -- uniformInt = uniformInt,
    }
    --]]--------------------------------------------------------------------------

    --variables for the task ahead
    local shaderProgram
    local glUseShader = gl.UseShader
    local glCopyToTexture = gl.CopyToTexture
    local glTexture = gl.Texture
    local glTexRect = gl.TexRect
    local boolShaderWorking = true
    local vsx, vsy
    local screencopy
    local boolWorking = true
    local PenetratedUnits = {}


    --Transfers the Data to the shader
    local function BulletHole(callname, Hole)
        --Forge values in which to store the Holes Data
        if gl.CreateShader then
            Spring.Echo("JW_BULETHOLESHADER::forging Shader")
            shaderTable.uniform = {
                depth = Hole.depth,
                diameter = Hole.diameter,
                posX = Hole.pos[1],
                posY = Hole.pos[2],
                posZ = Hole.pos[3],
                dirX = Hole.dirShot[1],
                dirY = Hole.dirShot[2],
                dirZ = Hole.dirShot[3],
                tColInt1 = Hole.teamColourInternal[1],
                tColInt2 = Hole.teamColourInternal[2],
                tColInt2 = Hole.teamColourInternal[3],
                tColExt1 = Hole.teamColurExternal[1],
                tColExt2 = Hole.teamColurExternal[2],
                tColExt3 = Hole.teamColurExternal[3],
            }


            shaderProgram = gl.CreateShader(shaderTable)
            if shaderProgram then
                PenetratedUnits[Hole.unitID] = { shader = shaderProgram, piecename = Hole.piecename }
            else
                Spring.Echo("shader not created")
                Spring.Echo(gl.GetShaderLog())
            end
            Spring.UnitRendering.SetUnitLuaDraw(Hole.unitID, true)
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
            PenetratedUnits[unitID] = nil
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