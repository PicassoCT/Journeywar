varying vec2 Position;
varying vec3 fNormal;
uniform mat4 modelViewMatrix;
varying float time0_1;
varying float time0_2PI;



void main(void)
{
   
    gl_Position = gl_ModelViewProjectionMatrix *gl_Vertex;
    Position.x = 0.5 * mix(gl_Vertex.x, gl_Vertex.y, abs(gl_Normal.x));
    Position.y = 0.5 * mix(gl_Vertex.z, gl_Vertex.y, abs(gl_Normal.z));
   
   
    //Position=f4Position.xyz;
    fNormal= gl_Normal;
   
   
}