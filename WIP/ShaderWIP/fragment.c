varying vec2 Position;
varying vec3 fNormal;
uniform mat4 modelViewMatrix;
varying float time0_1;
varying float time0_2PI;
   varying vec4 vertexStartCol;
   varying vec4 vertexEndCol;
    vec3 Green =vec3(0.2,1.0,0.1);
    vec3 Blue =vec3(0.6,0.6,1.0);
    varying int vertexInSim = 0;
    
    
#define PI 3.14159    
   varying float sinUs;
void main(void)
{
   
    gl_Position = gl_ModelViewProjectionMatrix *gl_Vertex;
    Position.x = 0.5 * mix(gl_Vertex.x, gl_Vertex.y, abs(gl_Normal.x));
    Position.y = 0.5 * mix(gl_Vertex.z, gl_Vertex.y, abs(gl_Normal.z));
   vertexStartCol=vec4(Green,0.9);
   vertexEndCol=vec4(Blue,0.3);
   sinUs=sin(((time0_2PI- PI)/300.0));
   sinUs=1.0;
  //  Position=f4Position.xy;
    fNormal= gl_Normal;
   
   
}