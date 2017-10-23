function gadget:GetInfo()
    return {
        name = "HeatDeathShader",
        desc = "Dead Vehicles glow while dead",
        author = "me",
        date = "Sep. 20014",
        license = "GPL 3.141",
        layer = 256,
        enabled = true, --until the problem of all units having the shader applied is fixed
    }
end

if (gadgetHandler:IsSyncedCode()) then
    WreckageIs = {
        [UnitDefNames["gcvehiccorpsemini"].id] = true,
        [UnitDefNames["gcvehiccorpse"].id] = true,

    }

    burningUnits = {}
    TIME_BURNING = 900

    function gadget:UnitCreated(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam)
        if WreckageIs[unitDefID] then
            burningUnits[unitID] = TIME_BURNING
            SendToUnsynced("glowing_heatDeathShader_Start", unitID)
        end
    end

    function gadget:GameFrame(frame)
        if frame % 30 == 0 then
            for id, frames in pairs(burningUnits) do
                burningUnits[id] = frames - 30
                if frames - 30 < 0 then
                    SendToUnsynced("glowing_heatDeathShader_End", id)
                    burningUnits[id] = nil
                end
            end
        end
    end

else --UNSYNCED
    --shaderCode
    --- [[----------------------------------------------------------------------------
    local fragmentShaderSource = [[
uniform float time;
varying vec3 fNormal;

vec3 hit= vec3(1.0,0.8,0.3 );

vec3 glowing= vec3(0.9,0.3,0.1);

vec3 cooldown= vec3(0.4,0.1,0.05);

vec3 wreck=vec3(0.185,0.155,0.155);

vec3 currColor;
float averageShadow;
float PI=3.14159;

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

    local vertexShaderSource = [[
    uniform float time;
  	varying vec3  pos;

    const vec4 centerPos = vec4(0.0,0.0,0.0,1.0);

    varying vec3 fNormal;
    varying float changeRate;


    float PI_HALF= 3.14159/2.0;
    float PI =3.14159;

void main() {
    fNormal = normalize(gl_NormalMatrix * gl_Normal);

    float sigNum=1.0;

    //melting process - a inverse cosinus rising
    float molten = abs(1.0-cos((time)*PI_HALF));

    //percentage we scale the vector out or inwards
    float percentage= (sqrt(abs(fNormal.y)/(abs(fNormal.x)+abs(fNormal.z) +0.01)))/50.0; // /50

    sigNum=(fNormal.y >= 0.0)  ? -1.41  : 1.0;

    //computate the total melting and end it at max where the molten metall gets hadr
    //keep Constant Change
    changeRate= time < 0.5  ?
        mix(0.0, percentage * sigNum*molten, time / 0.5 ):
        percentage* sigNum* molten;


    // move the position along the normal and transform it
    vec3 newPosition = gl_Vertex + fNormal * changeRate;
    gl_Position =  gl_ModelViewProjectionMatrix * vec4( newPosition, 1.0  );

}
    ]]

    local shaderTable = {
        vertex = vertexShaderSource,
        fragment = fragmentShaderSource,
        uniformInt = {},
        uniform = {
            time = 0,
        },
    }
    --]]--------------------------------------------------------------------------

    --variables for the task ahead
    local shaderProgram
    local glUseShader = gl.UseShader

    local redHotUnits = {}
    glowTime = 900

    --Transfers the Data to the shader
    local function glowing_heatDeathShader_Start(callname, id)
        --Forge values in which to store the Holes Data


        if not redHotUnits[id] then
            redHotUnits[id] = Spring.GetGameFrame()
        end
        Spring.UnitRendering.SetUnitLuaDraw(id, true)
    end

    --Transfers the Data to the shader
    local function glowing_heatDeathShader_End(callname, id)
        --Forge values in which to store the Holes Data

        if redHotUnits[id] then
            redHotUnits[id] = nil
        end
        Spring.UnitRendering.SetUnitLuaDraw(id, false)
    end

    local timer = 0

    function gadget:Initialize()

        if gl.CreateShader then

            shaderProgram = gl.CreateShader(shaderTable)
            if shaderProgram == nil then
                Spring.Echo("HeatDeathShader" .. gl.GetShaderLog())
            end
            -- This associate the messages with the functions
            -- So that when the synced sends a message "f" it calls the function f in unsynced
            gadgetHandler:AddSyncAction("glowing_heatDeathShader_Start", glowing_heatDeathShader_Start)
            gadgetHandler:AddSyncAction("glowing_heatDeathShader_End", glowing_heatDeathShader_End)
            timer = gl.GetUniformLocation(shaderProgram, 'time')
        else
            Spring.Echo("<HeatDeath-Shader>: GLSL not supported.")
        end
    end


    local function getTime(startFrame)
        totalTime = Spring.GetGameFrame() - startFrame
         times= math.min(0.95, math.max(totalTime / glowTime, 0.0001))
        return times
    end

    function gadget:DrawUnit(unitID, drawMode)
        if shaderProgram then
            if redHotUnits[unitID] then
                glUseShader(shaderProgram)
                gl.Uniform(timer, getTime(redHotUnits[unitID]))
					 glUseShader(0)        
				end
        end
     end

        function gadget:Finalize()
            if (gl.DeleteShader) then
                gl.DeleteShader(shaderProgram)
            end
        end
  

end