
uniform float time0_1;
uniform float time0_2PI;
varying vec2 Position;
varying vec3 fNormal;

 vec4 Black =vec4(0.0,0.0,0.0,0.0);
 vec4 Green =vec4(0.0,1.0,0.0,1.0);
 vec4 Blue =vec4(0.0,0.0,1.0,1.0);
 vec4 Red =vec4(1.0,0.0,0.0,1.0);
  
 vec3 X_Axis = vec3(1.0,0,0);
 vec3 Y_Axis = vec3(0,1.0,0);
 vec3 Z_Axis = vec3(0,0,1.0);
 
 vec3 Col_Head= vec3(0.7,0.8,0.95);
 vec3 Col_Tail= vec3(0.15,0.4,0.45);

#define INTERPOLATION_STEPS 6
#define MAX_RANGE_PARTICLES 25.0
#define PI 3.14159
#define PI2 (PI*2.0)
#define isParticlePosition(PARTICLE,POSITION,TOLERANCE)  (distance(PARTICLE + Center.Pos,POSITION) < TOLERANCE) 
//Helper functions
#define RAND(X,Y)  (fract(sin(dot(X + Y ,vec2(12.9898,78.233))) * 43758.5453))

mat2 rotationMatrix(float angle)
{
return mat2( cos(angle), sin(angle),
        -1.0*sin(angle), cos (angle)); 
}

mat4 rotationMatrix4(vec3 axis, float angle)
{

    float SIN = sin(angle);
    float COS = cos(angle);
    float OCOS = 1.0 - COS;
     axis = normalize(axis);
  return mat4(OCOS * axis.x * axis.x + COS,           OCOS * axis.x * axis.y - axis.z * SIN,  OCOS * axis.z * axis.x + axis.y * SIN,  0.0,
              OCOS * axis.x * axis.y + axis.z * SIN,  OCOS * axis.y * axis.y + COS,           OCOS * axis.y * axis.z - axis.x * SIN,  0.0,
              OCOS * axis.z * axis.x - axis.y * SIN,  OCOS * axis.y * axis.z + axis.x * SIN,  OCOS * axis.z * axis.z + COS,           0.0,
                 0.0,                                 0.0,                                    0.0,                                    1.0);
 
 }
//sums up the component of a vector   
float sum(vec3 element)
{return element.x+element.y+element.z;}


float interpolate(vec2 posA, vec2 posB, float Max)
{   //Currently fades exponential to the midst Oo-.. ..-oO  * 1/MoveMentSpeedParticle 
   vec2 Mid=((posA + posB)* 0.5);
   float DisTance;
   if( distance(posA,Mid) < distance(posB, Mid))
   DisTance= distance(posA, Mid);
   else
   DisTance= distance(posB, Mid);   
   
   return abs(min(DisTance/(Max* 0.5), 1.0));
}

//Describes a linear Colour Gradient 
struct colSampler{
vec3 colStart;
vec3 colEnd;   
};

//Works as a mask, allowing to precomp, wether a rotation is needed
struct borderLine{
   vec2 StartUp;
   vec2 EndUp;
   vec2 StartLow;
   vec2 EndLow;   
};
//Describes a linewise mask, pixelstart and pixelend
struct mask{
   int start;
   int end;   
};
//1byte mask
mask ArrayMask[8];

struct PointPair{
vec2 Up;
vec2 Low;
};

//Center of the Pseudo-LorenzSim Physics
struct Attractor{
   vec2 Pos;
   vec2 dir;
   float linGravity;
   float expGravity;
   float PulseStrenghtTimeRatio;   
//describes how much each pieces NewDir is affected by linGravity over time
   float sinusFactor;
   float maxDistanceParticles;
};

Attractor Center;

#define ADD_PATHPOINT(NR,PX,PY) CenterPath[NR]= vec2(PX,PY);

#define CenterPathSize 4
vec2 CenterPath[CenterPathSize];



//Particle bound to a attractor
struct Particle{
   float rotationInAngleStep;
//Positions are relative Positions to CenterPos
   vec2 Pos;
//Directions are non-nomralized Vectors, containing as Sqrt(Vec) the force
   vec2 dir;
   
   vec2 lastPos;
   vec2  lastDir;

   float MaxDistToPredecessor;
};
//Configuration
#define ParticlesSize 2
Particle Particles[ParticlesSize];



#define ParticleConstructor(NR, DEG, POSX, POSY, DIRX, DIRY, MAXDIST)    Particles[NR].rotationInAngleStep= DEG;Particles[NR].Pos= vec2(POSX,POSY);Particles[NR].dir= vec2(DIRX,DIRY);Particles[NR].lastPos= vec2(POSX,POSY); Particles[NR].lastDir= vec2(DIRX,DIRY);Particles[NR].MaxDistToPredecessor= -1.0;

void init()
{
//PathPoints
ADD_PATHPOINT( 0,0.0,0.0)        
ADD_PATHPOINT( 1,-5.0,5.0)            
ADD_PATHPOINT( 2,-10.0,2.0)            
ADD_PATHPOINT( 3,-20.0,3.0)                
//ADD_PATHPOINT( 4,-5.0,4.0)         
//ADD_PATHPOINT( 5,-4.0,5.0)         
//ADD_PATHPOINT( 6,-3.0,6.0)         
//ADD_PATHPOINT( 7,-2.0,7.0)        

    
//StartPositionsParticle
ParticleConstructor(0, PI, 15.0,10.0,0.1,0.1,20.0);
ParticleConstructor(1, 3.0, 10.5,1.0,0.3,0.1,20.0);
//ParticleConstructor(2, 4.0, 5.0,-1.0,0.1,0.1,2.0);

//Initializing the Center 
Center.Pos= vec2(-0.5,-0.5); 
Center.dir= vec2(0.0,0.0);
Center.linGravity=0.0; 
Center.expGravity= 0.0;
Center.PulseStrenghtTimeRatio=0.0;
Center.sinusFactor=0.0;
Center.maxDistanceParticles=MAX_RANGE_PARTICLES;
}


//Is the Pixel in Question in the physic sim
bool isPixelInSim(int steps, vec2 Pos)
{
if (distance(CenterPath[steps],Pos) < Center.maxDistanceParticles)
   { return true;}

return false;
}



#define ROTATE(matrice,value,tempNameVec2,output) tempNameVec2 =(matrice * value.xy);output = tempNameVec2;

   //y= m*x +t" 
void CalcArrayMask (mat2 rotateIntoOrigin, int LineNr,  PointPair PointPairFront, PointPair PointPairRear ) 
{
   vec2 tempResult;

   ROTATE(rotateIntoOrigin,PointPairFront.Up,tempResult,PointPairFront.Up)
   
   ROTATE(rotateIntoOrigin,PointPairFront.Low,tempResult,PointPairFront.Low)
   
   ROTATE(rotateIntoOrigin,PointPairRear.Up,tempResult,PointPairRear.Up)
   
   ROTATE(rotateIntoOrigin,PointPairRear.Low,tempResult,PointPairRear.Low)
   
   float SlopeFront= ((PointPairFront.Up.y - PointPairFront.Low.y)/(PointPairFront.Up.x - PointPairFront.Low.x));
   float SlopeRear = ((PointPairRear.Up.y - PointPairRear.Low.y)/(PointPairRear.Up.x - PointPairRear.Low.x));
   for (int  i=0; i< 8; i++)
   {
      ArrayMask[i].start= int(SlopeFront * (PointPairFront.Up.x) * float(LineNr+ i));
      ArrayMask[i].end=   int( SlopeRear * (PointPairFront.Up.x) *  float(LineNr+ i));
   }
}


#define GRADIENT_SIZE 8
//global Extremas of the Quad
int xMin,xMax,yMin,yMax;

void CalcExtrema(vec2 p1,vec2 p2,vec2 p3,vec2 p4,mat2 rotMat)
{
   vec2 rotatedPoints[4];
   vec2 tempVec;
   ROTATE(rotMat,(p1-p2),tempVec,   rotatedPoints[0])//(matrice,value,tempNameVec2,outputdestination) 
   ROTATE(rotMat,(p2-p2),tempVec,   rotatedPoints[1])
   ROTATE(rotMat,(p3-p2),tempVec,   rotatedPoints[2])
   ROTATE(rotMat,(p4-p2),tempVec,   rotatedPoints[3])
   //Initalisation
   xMin=900000;
   yMin=xMin;
   xMax=yMin*-1;
   yMax=yMin*-1;
   
   for (int i=0;i<4;i++)
   {
   if (int(rotatedPoints[i].x) >= xMax) xMax= int(rotatedPoints[i].x);
   if (int(rotatedPoints[i].x) <= xMin) xMin=int(rotatedPoints[i].x);
   if (int(rotatedPoints[i].y) > yMax) yMax=int(rotatedPoints[i].y);
   if (int(rotatedPoints[i].y) < yMin) yMin=int(rotatedPoints[i].y);
   }
}


bool PointInTriangle(vec2 A, vec2 B, vec2 C, vec2 Point)
{   
   //triAngleDeterminates
 float x1x2=0.5*(A.x* B.y- B.x*A.y);
 float x2x3=0.5*(B.x* C.y- C.x*B.y);
 float x3x1=0.5*(C.x* A.y- A.x*C.y);
   //pointAngleDeterminates
  float x1xt=0.5*(A.x*Point.y+Point.x*A.y);
  float x2xt=0.5*(B.x*Point.y+Point.x*B.y);
  float x3xt=0.5*(C.x*Point.y+Point.x*C.y);
   

   if (x1x2+x1xt+x2xt+x2xt+x3xt+x2x3+x3xt+x3x1+x1xt < 0)
	{ return true;}
   else
	{return false;}   
}

//Draws Additive the polygons into the texture  
//Particle Speed is factored in via the colSamplers
vec4 AddDraw(colSampler OuterCol, colSampler InnerCol, vec2 newPUp, vec2 newPDown, vec2 oldPUp, vec2 oldPDown, vec2 PixelPos)
{ 
   //Get PixelPosition into Center Coordinate System Coords
   PixelPos= PixelPos -Center.Pos.xy;

	//check wether the Point is actually in the quad to prevent unnecessary work workload
	if (PointInTriangle(newPUp, newPDown, oldPUp, PixelPos)==false || PointInTriangle(newPDown,  oldPUp,oldPDown, PixelPos)== false) return Black;
   
   vec3 invlengthGradientCompo[GRADIENT_SIZE]; //r=1/upComponent, g=1/lowComponent, b= 1/nilComponent
   vec2 tempRotateMat;
   float orthoAlignQuadDegree= atan(oldPUp.y- newPUp.y,oldPUp.x- newPUp.x);
   orthoAlignQuadDegree= (orthoAlignQuadDegree > 0.0 ? orthoAlignQuadDegree : (PI2 + orthoAlignQuadDegree));
   


   mat2 rotMat ;
   mat2 iRotMat;  
   //Develop Rotation matrice to turn  parallelogram into drawable quad

/*                      OOO                                             OO    */
/*                        ¦¦¦¦                                          OO    */
/*                      ¦¦    ¦¦¦¦¦¦¦¦       xMin ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦    */
/*                     ¦              ¦¦¦¦       ¦                       ¦    */
/*                   ¦¦                ¦¦       ¦                        ¦    */
/*                  ¦                 ¦         ¦                         ¦   */
/*                 ¦                 ¦         ¦                          ¦   */
/*               ¦¦                ¦¦         ¦                           ¦   */
/*              ¦                 ¦           ¦                            ¦  */
/*            ¦¦                 ¦           ¦                             ¦  */
/*           ¦                 ¦¦            ¦                              ¦ */
/*           ¦                ¦             ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ */
/*            ¦              ¦            xMax                            yMax*/
/*            ¦            ¦¦             yMin                                */
/*             ¦          ¦                                                   */
/*             ¦         ¦                                                    */
/*              ¦      ¦¦                                                     */
/*              ¦     ¦                                                       */
/*               ¦   ¦                                                        */
/*               ¦ ¦¦                                                         */
/*                ¦                                                           */
   rotMat=      rotationMatrix(orthoAlignQuadDegree) ;
   iRotMat=   rotationMatrix(-orthoAlignQuadDegree);

   //determinates the 
   CalcExtrema(newPUp,oldPUp,oldPDown,newPDown,rotMat);
     
   for (int _x=xMin; _x < xMax; _x++)
   { //columns
   
   //Mixture of the Colours @ start and end
   float ratio= float(_x/xMax);
   vec3 tUpCol=OuterCol.colStart*(1.0-ratio) + OuterCol.colEnd*(ratio);
   vec3 tDownCol=InnerCol.colStart*(1.0-ratio) + InnerCol.colEnd*(ratio);
   bool  bLineStarted= false;
   float particleSpeed;

    PointPair PointPairFront;
    PointPairFront.Up=newPUp; 
    PointPairFront.Low=newPDown;
    PointPair PointPairRear;
    PointPairRear.Up=oldPUp; 
    PointPairRear.Low=oldPDown;
    
   
    if (mod(float(_x), 8.0)==0.0)
   //(mat4 rotateIntoOrigin, int LineNr,  PointPair PointPairFront, PointPair PointPairRear ) 
   {CalcArrayMask(rotMat, _x,PointPairFront,PointPairRear);}
   
   //rotate the whole line pixel by pixel into one rectangular frame of ref
      for (int _y=yMin;_y<yMax; _y++) //rows
      {  
      
         //abort line if we allready started it and it ran out

         if ((bLineStarted) == false && _y <= ArrayMask[_x].start ) continue;
     
         
         if ((bLineStarted) == true && _y > ArrayMask[_x].end ) break;   
   
         bLineStarted= true;
         vec2 localPos;
         
         ROTATE(rotMat,vec2(_x,_y),tempRotateMat,localPos)
         
         //access the texture and draw
      
         //texture.rgb += (invlengthGradientCompo[int(localPos.y/yMax)].r*tUpCol + invlengthGradientCompo[int(localPos.y/yMax)*GRADIENT_SIZE].g*tDownCol);
      
                
         if (_x == int(localPos.x) && _y == int(localPos.y)){
          int index=int(int(localPos.y)/yMax);
          int indy=int(int(localPos.y)/yMax)*GRADIENT_SIZE;
          return vec4(0.0,0.0,1.0,1.0);
           //  return vec4((invlengthGradientCompo[index].r* tUpCol + 
          //invlengthGradientCompo[indy].g*tDownCol),
          //1.0);
            
          }
      }
   }   
   return Black;
}

//calculate a new attractor position
vec2 newAttractorPosition(vec2 interValStart, vec2 interValEnd, float percentage, float time)
{
   
   vec2 midPoint= vec2(interValEnd*(1.0 -percentage)+ interValStart*percentage);
   
   return midPoint;
}

 vec2 updateParticlePosition( int p)
{
   float fRotationDynamicPart, fTotalRotation;
   mat2  rMat;

    //calculte dynamic part of the Rotation
    fRotationDynamicPart=0.0;//atan(Particles[p].dir);
    fTotalRotation =  Particles[p].rotationInAngleStep + fRotationDynamicPart; // speed* atan(Particles[p].dir.x,Particles[p].dir.y);
    fTotalRotation=sin(time0_1);
 
   rMat=rotationMatrix(fTotalRotation);
   
   return rMat*Particles[p].Pos.xy;   
}

//Debug Displays the ParticlePoints and AttractorPoint
bool atParticleStartPos(vec2 localPos, float tol)
{
   bool match= false;
   for (int i= 0; i< ParticlesSize;i++)
   {   
      if (distance(Particles[i].Pos.x,localPos.x) < tol && distance(Particles[i].Pos.y,localPos.y) < tol )
      {
         match=true;
      }      
   }   
   
      if (distance(Center.Pos.x,localPos.x) < tol && distance(Center.Pos.y, localPos.y) < tol )
      {
         match=true;
      }      
   
   return match;
}

float InterPolationSteps = 5.0;

vec4 doPhySim(float percent, float time, vec2 Pos)
{
   vec4 accumulatedColour= Black;
   
      if (atParticleStartPos(Pos,0.1)== true) return vec4(1.0,0.0,0.0,0.0);
   

   
   
   //Defining the Colours the Gradient traverses from Start to End - Outermost color Gradient
    colSampler EndInterValCol   ;
    colSampler StartInterValCol   ;
       


   //Move along the CenterPath in SimSteps   -> Steps of the same colourgradient can be parallized  
   //Cost Total:   (steps*(particles-1)) /ProcessingUnits
       for (int attrPath=0; attrPath< CenterPathSize-1;attrPath++)
      {
      //if this pixel is within range of a pathPoint+ maxRange
      if (!isPixelInSim(attrPath,Pos))continue;
      //StartColour of this Part of PathIntervall
      float startPercentage= min(float(attrPath),float(CenterPathSize))/float(CenterPathSize);
      //EndColour of this Part of PathIntervall
      float endPercentage= min(float(attrPath+1),float(CenterPathSize))/float(CenterPathSize);   
     
      
        for (int steps=0; steps < INTERPOLATION_STEPS ;steps++)
        {
          float StartPercent =float(attrPath)/float(CenterPathSize);
          float EndPercent    =float(attrPath+1)/float(CenterPathSize);
          float outerFactorDistance, innerFactorDistance;
          
          //calculate the new AttractorPosition
          Center.Pos= newAttractorPosition(CenterPath[attrPath],CenterPath[attrPath+1],(0.1+float(steps))/InterPolationSteps,time);
          //update Color
               
         EndInterValCol.colStart= Col_Head* StartPercent + Col_Tail * (1.0 - StartPercent)  ;       
         EndInterValCol.colEnd=   Col_Head* EndPercent   + Col_Tail * (1.0 - EndPercent)  ;       
         StartInterValCol=EndInterValCol;
        //debugInfo
        if ( sum(vec3(abs(Pos- Center.Pos),0.0))< 0.125) return Green;
        
          //update Physic Sim         
                
             //SetNewPosition
            for (int p=1;p< ParticlesSize; p++)
            {  
            
             
               //save the particles old Position
               Particles[p].lastPos=Particles[p].Pos;
               //calculate a new Position
               Particles[p].Pos=  updateParticlePosition( p);
               //factor in the traversed Distance into the colour (this disregards the curve taken)   
               float OutTraversedDistance =distance(Particles[p].Pos,Particles[p].lastPos);
               float InnerTraversedDistance= distance(Particles[p-1].Pos,Particles[p-1].lastPos);
               float averageDistance= (OutTraversedDistance+ InnerTraversedDistance)*0.5;
               
                outerFactorDistance=(averageDistance/OutTraversedDistance);
                innerFactorDistance=(averageDistance/InnerTraversedDistance);
                EndInterValCol.colStart *= outerFactorDistance;
                EndInterValCol.colEnd *= outerFactorDistance;    
            
             StartInterValCol.colStart *= innerFactorDistance;
             StartInterValCol.colEnd *= innerFactorDistance;
          
  
               accumulatedColour =accumulatedColour +  AddDraw(EndInterValCol,   StartInterValCol,  Particles[p].Pos, Particles[p-1].Pos, Particles[p].lastPos, Particles[p-1].lastPos,Pos);   
            }
        }
     }
return accumulatedColour;
}


float totalTime=90.0;
float colDecayTime=30.0;



void main(void)
{
      //initialise Particles and Attractor 
      init();
       //SetToDefault
   gl_FragColor=Black;
  
   
   //the percentAgeOfTheWay the projectile has travelled
   float percentColourDecay=mod(time0_1/colDecayTime,1.0);
   bool  InPhySim=false;
   bool  ItterationTest=false;
   
    for (int i=0; i< CenterPathSize;i++)
   {
      ItterationTest= isPixelInSim(i,Position.xy);
      InPhySim = ( InPhySim || ItterationTest);
   
   }
  
// mat4 rotMat=rotationMatrix(Y_Axis, sin(time0_2PI*15.0));
/* mat2 rotMat= mat2( cos(time0_1* 2.0*PI), sin(time0_1* 2.0*PI),
                    -1.0*sin(time0_1* 2.0*PI), cos (time0_1* 2.0*PI));
 
 vec2 TestParticle = vec2 (3.1,-12.0);
 TestParticle=rotMat*TestParticle;
 
*/
   if (InPhySim==true) {
      gl_FragColor= doPhySim(mod(time0_1/totalTime,1.0), time0_1, Position.xy);
     
      }
   else 
   { 
   
      gl_FragColor= ((vec4(0.9,0.9,0.9,1.0) + gl_FragColor)/sum(1.0 - normalize(fNormal)));
   }   



 
 //if( abs(abs(Position.x) - abs(TestParticle.x)) < 1.0 && ( abs( abs(Position.y) - abs(TestParticle.y)) < 1.0) ) gl_FragColor= Red;
}


