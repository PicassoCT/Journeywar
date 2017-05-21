function gadget:GetInfo()
	return {
		name = "BulletHoleshader",
		desc = "Fire in the hole- another word for yesterdays peperoni",
		author = "me",
		date = "Sep. 20014",
		license = "Humilation License: If you use this comercially, the CEO of your company has to start everyday, by exlaiming in front of the employees: >> Im a worthless parasit, leaching on the creativity of those i would degrade in every other conversation. Im sorry for existing. <<",
		layer = 0,
		enabled = false,
	}
end

if (gadgetHandler:IsSyncedCode()) then

VFS.Include('scripts/lib_UnitScript.lua', nil, VFSMODE)


	local HoleInOneT = {}
	HoleInOneT[WeaponDefNames["comendsniper"].id] = { diameter = 64}
	HoleInOneT[WeaponDefNames["sniperslavemelee"].id] = { diameter = 32}
	local PIECE_VOLUMEMINFORHOLE = 420
	local PIECE_INV = 1 / PIECE_VOLUMEMINFORHOLE
	 = {}

	--set the weapons registrated above on the watchlist
	for k, _ in ipairs(HoleInOneT) do
		Script.SetWatchWeapon(k, true)
	end
	--Sends Hole Data to unsynced
	function TearANewOne(unitid, piecename, dirVec, WeaponType, boolJourney)
			x,y,z =Spring.GetUnitPiecePosition(unitid, piecename)
			
			internalColour={r=0,g=0,b=0}
			externalColour={r=0.5, g=0.5, b=0.5}
			if boolJourney == true then
			internalColour={r=1.0,g=0,b=0}
			externalColour={r=0.95, g=0.2, b=0.2}
			end
			
			
				Hole = {
					unitID = unitid,
					piecename = piecename,
					depth = HoleInOneT[WeaponType].diameter/2,
					diameter = HoleInOneT[WeaponType].diameter,
					pos = { x = x, y = y, z = z },
					dirShot = dirVec,
					teamColourInternal = internalColour
					teamColurExternal = externalColour
				}

				SendToUnsynced("BulletHoleStart", Hole)
	
 
	end

	cache= {}
	swissCheeseUnit={}
	function gadget:UnitDamaged(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, projectileID, attackerID, attackerDefID, attackerTeam)
		if HoleInOneT[weaponDefID] then
			Spring.Echo("JW_BULETHOLESHADER::YOU KNOW IT HIT HIM LIKE A HAMMER!")
			vec= vectorUnitToUnit(unitID, attackerID)
			if vec then
			   vec = normVector(vec)

				biggestPiece, cache = getUnitBiggestPiece(unitID, cache)
				side = select(2, Spring.Spring.GetAIInfo(unitTeam))
				TearANewOne(unitID, biggestPiece, vec, weaponDefID)
				swissCheeseUnit[unitID] = true
			end
		end
	end
	
	 function gadget:UnitDestroyed(unitID)
	  if swissCheeseUnit[unitID] then
		 endToUnsynced("BulletHoleEmd", unitID)
	 end
	 end

else --UNSYNCED
	--shaderCode
	--- [[----------------------------------------------------------------------------
	local vertexShaderSource = [[
varying vec3 fNormal;
varying vec3 fPosition;

uniform float depth 	;
uniform float diameter;
uniform float posX 	;
uniform float posY 	;
uniform float posZ 	;
uniform float dirX 	;
uniform float dirY 	;
uniform float dirZ 	;
uniform float tColInt1;
uniform float tColInt2;
uniform float tColInt2;
uniform float tColExt1;
uniform float tColExt2;
uniform float tColExt3;

float PI= 3.14159;
float PI_2= 3.14159/2.0;
struct hole
{
    vec3 dir;
    vec3 modPos;
    float diameter;
    float depth;
};

#define randO( co)  fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453)
#define signEqual(  X, Y) (sign(X) == sign(Y))

hole watHitIt;
//TODO: Converter for world to modelholes -

// dist_Point_to_Segment(): get the distance of a point to a segment
//	 Input:  a Point P and a Segment S (in any dimension)
//	 Return: the shortest distance from P to S
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


/*						zzzzz											   */
/*					   zz   z											   */
/*					   z	zzzzzzzz										*/
/*					   z													*/
/*					   z													*/
/*					  zz													*/
/*					  z													 */
/*					 zz													 */
/*				 zzzzz													  */
/*																			*/
/*	The Deformation as  Cosin and sin										*/

float effectByDistance(float distP)
{
    if (distP <= 0.4) return (-1.0 + (1.0-cos(distP*PI_2)))*2.125 ;

    if (distP <= 0.9) return (1.0 - cos( ((distP-0.40)/0.5)*PI_2)  )*2.0;

    return max( abs (1.0-cos(((distP-0.8)/0.2)*PI_2)),0.0) ;

}

void mapUniformToStruct()
{

    watHitIt.depth = depth 	;
    watHitIt.diameter = diameter;
    watHitIt.modPos= vec3(posX,posY,posZ);

    watHitIt.dir= vec3(dirX,dirY,dirZ);

}

void main()
{
    float dist;
    mapUniformToStruct();

    fNormal = normalize(gl_NormalMatrix * gl_Normal);

    //computate the distance of vertext to bullethole
    dist= dist_Point_to_Segment(gl_Vertex, watHitIt.modPos+watHitIt.dir*2.0, watHitIt.modPos + watHitIt.dir * -2.0);

    depthHole=dist;
    float factor= dist <   watHitIt.diameter ?   effectByDistance(dist/watHitIt.diameter): 0.0;

    vec3 newPosition = gl_Vertex + fNormal * factor/15.0;
    gl_Position = gl_ModelViewProjectionMatrix * vec4( newPosition, 1.0  );


}


	]]

	local fragmentShaderSource = [[

uniform float depth 	;
uniform float diameter;
uniform float posX 	;
uniform float posY 	;
uniform float posZ 	;
uniform float dirX 	;
uniform float dirY 	;
uniform float dirZ 	;
uniform float tColInt1;
uniform float tColInt2;
uniform float tColInt2;
uniform float tColExt1;
uniform float tColExt2;
uniform float tColExt3;




vec3 inner=vec3(tColInt1,tColInt2,tColInt3);
vec3 outer=vec3(tColExt1,tColExt2,tColExt3);
varying float holeMax;

vec3 bulletColours(float depthh, vec3 orgcol)
{

    if (depthh < 0.2) return inner;

    if (depthh < 0.4)
    {

        float relDeth=( (depthh- 0.2)/ 0.2);

        return ((1.0 -relDeth)*inner+ (relDeth)*outer);
    }

    float relDeth=( (depth- 0.4)/ 0.2);
    return (1.0 - relDeth)*sqrt(inner)+ (relDeth)*orgcol;
}


void main()
{
    vec3 col;

    col=normalize(gl_Normal);

    if (depth!= 0.0 && depth < holeMax+0.1)
        col= bulletColours(depth,col);
    gl_FxragColor = vec4(col, 1.001);

  
}
	]]
	local shaderTable = {
		vertex = vertexShaderSource,
		fragment = fragmentShaderSource,
			 uniform = {
				depth = 0,
				diameter = 0,
				posX = 0,
				posY = 0,
				posZ = 0,
				dirX =0,
				dirY =0,
				dirZ = 0,
				tColInt1 = 0,
				tColInt2 = 0,
				tColInt2 = 0,
				tColExt1 = 0,
				tColExt2 = 0,
				tColExt3 = 0,
		},
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
	
				depth = 0 
				diameter = 0 
				posX = 0 
				posY = 0 
				posZ = 0 
				dirX =0 
				dirY =0 
				dirZ = 0 
				tColInt1 = 0 
				tColInt2 = 0 
				tColInt2 = 0 
				tColExt1 = 0 
				tColExt2 = 0 
				tColExt3 = 0 

	--Transfers the Data to the shader
	local function BulletHoleStart(callname, Hole)
		--Forge values in which to store the Holes Data
		if gl.CreateShader then

			PenetratedUnits[Hole.unitID] = Hole
				
			
			
			Spring.UnitRendering.SetUnitLuaDraw(Hole.unitID, true)
		else
			Spring.Echo("<BulletHoleshader>: GLSL not supported.")
		end
	end

	local function BulletHoleEnd(callname, unitID)
		PenetratedUnits[unitID] = nil
		Spring.UnitRendering.SetUnitLuaDraw(unitID, false)
	end
	
	function gadget:Initialize()
 
		   shaderProgram = gl.CreateShader(shaderTable)
			if shaderProgram then
				depth 				= gl.GetUniformLocation(shaderProgram,"depth")			
				diameter 			= gl.GetUniformLocation(shaderProgram,"diameter")			
				posX 				= gl.GetUniformLocation(shaderProgram,"posX")			
				posY 				= gl.GetUniformLocation(shaderProgram,"posY")			
				posZ 				= gl.GetUniformLocation(shaderProgram,"posZ")			
				dirX 				= gl.GetUniformLocation(shaderProgram,"dirX")			
				dirY 				= gl.GetUniformLocation(shaderProgram,"dirY")			
				dirZ 				= gl.GetUniformLocation(shaderProgram,"dirZ")			
				tColInt1 			= gl.GetUniformLocation(shaderProgram,"tColInt1")			
				tColInt2 			= gl.GetUniformLocation(shaderProgram,"tColInt2")			
				tColInt2 			= gl.GetUniformLocation(shaderProgram,"tColInt2")			
				tColExt1 			= gl.GetUniformLocation(shaderProgram,"tColExt1")			
				tColExt2 			= gl.GetUniformLocation(shaderProgram,"tColExt2")			
				tColExt3 			= gl.GetUniformLocation(shaderProgram,"tColExt3")	
				
				Spring.Echo("BulletHoleshader Initialised")
			else

				Spring.Echo("=============Bullethole shader not created============")
				Spring.Echo(gl.GetShaderLog())
				Spring.Echo("======================================================")
			end
		
		gadgetHandler:AddSyncAction("BulletHoleStart", BulletHoleStart)
		gadgetHandler:AddSyncAction("BulletHoleEnd", BulletHoleEnd)
	end

	function mapDataToUniforms(Hole)
	
	
		unitID = unitid,
					piecename = piecename,
					depth = HoleInOneT[WeaponType].diameter/2,
					diameter = HoleInOneT[WeaponType].diameter,
					pos = { x = x, y = y, z = z },
					dirShot = dirVec,
					teamColourInternal = internalColour
					teamColurExternal = externalColour
					
				depth 				= 	Hole.depth
				diameter 			= 	Hole.diameter	
				posX 				= 	Hole.pos.x
				posY 				= 	Hole.pos.y
				posZ 				= 	Hole.pos.z
				dirX 				= 	Hole.dirShot.x
				dirY 				= 	Hole.dirShot.y
				dirZ 				= 	Hole.dirShot.z
				tColInt1 			= 	Hole.teamColourInternal.r
				tColInt2 			= 	Hole.teamColourInternal.g
				tColInt2 			= 	Hole.teamColourInternal.b
				tColExt1 			= 	Hole.teamColourExternal.r	
				tColExt2 			= 	Hole.teamColourExternal.g	
				tColExt3 			=   Hole.teamColourExternal.b
	
	end
	
	
	function gadget:DrawUnit(unitID, drawMode)
		if PenetratedUnits[unitID] then
			mapDataToUniforms(PenetratedUnits[unitID])
			glUseShader(shaderProgram)
			PenetratedUnits[unitID] = nil
		end
	end


function gadget:Finalize()
		if (gl.DeleteShader) then
			gl.DeleteShader(shaderProgram)
		end
	end
	
end