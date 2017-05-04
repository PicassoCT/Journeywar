function gadget:GetInfo()
  return {
    name      = "HeatDeathShader",
    desc      = "Dead Vehicles glow while dead",
    author    = "me",
    date      = "Sep. 20014",
    license   = "GPL 3.141",
    layer     = 0,
    enabled   = false,
  }
end

if (gadgetHandler:IsSyncedCode()) then
WreckageIs={
			[UnitDefNames["gcvehiccorpsemini"].id]=true,
			[UnitDefNames["gcvehiccorpse"].id]=true
			}

	function gadget:UnitCreated(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam) 
			if WreckageIs[unitDefID] then	
					SendToUnsynced("glowing_heatDeathShader_Start", unitID, Spring.GetGameFrame())
			end
	end

else  --UNSYNCED
	--shaderCode
	---[[----------------------------------------------------------------------------
	local fragmentShaderSource=[[
varying float time;
uniform vec2 resolution;
varying vec3 fPosition;
varying vec3 fNormal;

vec3 fixedNormal;


vec3 hit= vec3(1.0,0.8,0.3 );


vec3 glowing= vec3(0.9,0.3,0.1);


vec3 cooldown= vec3(0.4,0.1,0.05);


vec3 wreck=vec3(0.185,0.155,0.155);


vec3 currColor;
float averageShadow;

float PI=3.14159;
float privateTime=0.0;
float fixedTime=0.0;
float totalTime=1.0;
float percenTage=0.0;
vec3 emptyVec = vec3(0.0,0.0,0.0);

vec3 clampAfter(vec3 x, float Time, float TimeLimit)
{
    return (Time < TimeLimit ? x :emptyVec);
}

vec3 openEnded(vec3 x, float Time, float TimeLimit, vec3 deFault)
{
  return Time < TimeLimit ? x :deFault;
}

void main()
{
privateTime+=0.1;
percenTage= (mod((time),totalTime))/totalTime*PI;


averageShadow=(fNormal.x*fNormal.x+fNormal.y*fNormal.y+fNormal.z+fNormal.z)/3.25;

currColor=(
 
 (percenTage < 0.5*PI ?  hit*cos(percenTage)*2.0 :emptyVec)

+ (percenTage < PI ? glowing*sin(percenTage)*2.5 :emptyVec)

+ (percenTage < PI*2.0 ? cooldown*sin(PI+percenTage)*2.0 :emptyVec)

+openEnded(wreck*abs(sin(PI+percenTage)),PI+percenTage,PI*2.0,abs(wreck*0.3))
);

  gl_FragColor = vec4(currColor*(1.0-averageShadow), 1);
}

]]
	
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


    varying vec3 cameraDir;
    varying vec3 teamColor;
    varying vec3 light;
  	varying vec3  pos;

attribute vec3 position;
attribute vec3 normal;
uniform mat3 normalMatrix;
uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;
varying vec3 fNormal;
varying vec3 fPosition;
varying float time=0.0;
varying float changeRate;
float totalTime=1.0;
float PI_HALF= 3.14159/2.0;
float PI =3.14159;



void main()
{
   fNormal = normalize(normalMatrix * normal);
  //vec4 pos = modelViewMatrix * vec4(position, 1.0);

    float sigNum=1.0;
	time+=0.001;
    float relTime=abs(mod(time/totalTime,totalTime));
    //melting process - a inverse cosinus rising 
    float meltSpeed=abs(cos(relTime/(PI*2.0)));
    float molten = abs(1.0-cos((time/totalTime)*PI_HALF));
    
    //percentage we scale the vector out or inwards
    float percentage= (sqrt(abs(normal.y)/(abs(normal.x)+abs(normal.z) +0.01)))/50.0; // /50
    
    sigNum=(fNormal.y >= 0.0)  ? -1.41  : 1.0;
  
  //computate the total melting and end it at max where the molten metall gets hadr
  //keep Constant Change
  changeRate= relTime < 0.5*totalTime? mix(0.0,percentage*sigNum*molten,relTime/0.5*(totalTime)):percentage*sigNum*molten;
  
    
    // move the position along the normal and transform it
    vec3 newPosition = position + fNormal * changeRate;
    gl_Position = projectionMatrix * modelViewMatrix * vec4( newPosition, 1.0  );
 
}
    ]]
	
	
	local shaderTable = {
	vertex= vertexShaderSource,
	 fragment = fragmentShaderSource,
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
	local redHotUnits={}
	glowTime=900
	
	--Transfers the Data to the shader
	local function HeatDeath(callname,id, startframe)		
	--Forge values in which to store the Holes Data
					if gl.CreateShader then
						Spring.Echo("HeatDeath::forging Shader")
						if not redHotUnits[id] then 	redHotUnits[id]	=startframe+ glowTime end									
						Spring.UnitRendering.SetUnitLuaDraw(id,true)						
					else
						Spring.Echo("<HeatDeath-Shader>: GLSL not supported.")
					end
	end
	

	
	function gadget:GameFrame(frame)
	
		for k,v in pairs(redHotUnits) do
			if k and v== frame then
				redHotUnits[k]=nil
			end
		end
	
	end
	
	function gadget:Initialize()   
		Spring.Echo("HeatDeath Initialised")
			shaderProgram=gl.CreateShader(shaderTable)			
      -- This associate the messages with the functions
      -- So that when the synced sends a message "f" it calls the function f in unsynced
		gadgetHandler:AddSyncAction("glowing_heatDeathShader_Start", HeatDeath)

	end	  
    
	function gadget:DrawUnit(unitID, drawMode)
		if redHotUnits[unitID] then				
		glUseShader(shaderProgram)			
		end	
	end

end

