#include <stdio.h>
#include <stdlib.h>
#include <math.h>

typedef struct vec2{float x; float y}vec2;
typedef struct vec3{float x; float y; float z;}vec3;
typedef struct vec4{float x; float y; float z; float a}vec4;
#define bool int
#define false 0
#define true 1

vec4 Black={.x=0.0, .y=0.0,.z=0.0,.a=0.0};

//Describes a linear Colour Gradient
typedef struct colSampler{
vec3 colStart;
vec3 colEnd;
}colSampler;

//Works as a mask, allowing to precomp, wether a rotation is needed
typedef struct borderLine{
   vec2 StartUp;
   vec2 EndUp;
   vec2 StartLow;
   vec2 EndLow;
} borderLine;
//Describes a linewise mask, pixelstart and pixelend
typedef struct mask{
   int start;
   int end;
}mask;
//1byte mask
mask ArrayMask[8];

typedef struct PointPair{
vec2 Up;
vec2 Low;
}PointPair;


//Center of the Pseudo-LorenzSim Physics
typedef struct Attractor{
   vec2 Pos;
   vec2 dir;
   float linGravity;
   float expGravity;
   float PulseStrenghtTimeRatio;
//describes how much each pieces NewDir is affected by linGravity over time
   float sinusFactor;
   float maxDistanceParticles;
}Attractor;

Attractor Center;


 vec4 Green ={.x=0.0,.y=1.0,.z=0.0,.a=1.0};
 vec4 Blue ={.x=0.0,.y=0.0,.z=1.0,.a=1.0};
 vec4 Red ={.x=1.0,.y=0.0,.z=0.0,.a=1.0};

 vec3 X_Axis = {.x=1.0,.y=0,.z=0};
 vec3 Y_Axis = {.x=0,.y=1.0,.z=0};
 vec3 Z_Axis = {.x=0,.y=0,.z=1.0};

 vec3 Col_Head= {.x=0.7,.y=0.8,.z=0.95};
 vec3 Col_Tail= {.x=0.15,.y=0.4,.z=0.45};
 typedef struct mat2 {float array[2][2];
                }mat2;
 typedef struct mat4 {float array[4][4];
                }mat4;
#define INTERPOLATION_STEPS 6
#define MAX_RANGE_PARTICLES 25.0
#define PI 3.14159
#define PI2 (PI*2.0)
#define isParticlePosition(PARTICLE,POSITION,TOLERANCE)  (distance(PARTICLE + Center.Pos,POSITION) < TOLERANCE)
//Helper functions
#define RAND(X,Y)  (fract(sin(dot(X + Y ,vec2(12.9898,78.233))) * 43758.5453))

mat2 rotationMatrix(float angle)
{
    mat2 retVal;
retVal.array[0][0]=cos(angle);
retVal.array[0][1]=sin(angle);
retVal.array[1][0]=-1.0*sin(angle);
retVal.array[1][1]=cos (angle);
return retVal;
}


//sums up the component of a vector
float sum(vec3 element)
{return element.x+element.y+element.z;}


float interpolate(vec2 posA, vec2 posB, float Max)
{   //Currently fades exponential to the midst Oo-.. ..-oO  * 1/MoveMentSpeedParticle
   //vec2 Mid=((posA + posB)/ 0.5);
   vec2 Mid;
   Mid.x= (posA.x+posB.x) * 0.5;
   Mid.y= (posA.y+posB.y) * 0.5;

   float DisTance;
   if( distance(posA,Mid) < distance(posB, Mid))
   DisTance= distance(posA, Mid);
   else
   DisTance= distance(posB, Mid);

   return abs(min(DisTance/(Max* 0.5), 1.0));
}



#define ADD_PATHPOINT(NR,PX,PY) CenterPath[NR].x= PX; CenterPath[NR].y= PY;

#define CenterPathSize 4
vec2 CenterPath[CenterPathSize];



//Particle bound to a attractor
typedef struct Particle{
   float rotationInAngleStep;
//Positions are relative Positions to CenterPos
   vec2 Pos;
//Directions are non-nomralized Vectors, containing as Sqrt(Vec) the force
   vec2 dir;

   vec2 lastPos;
   vec2  lastDir;

   float MaxDistToPredecessor;
}Particle;
//Configuration
#define ParticlesSize 2
Particle Particles[ParticlesSize];



#define ParticleConstructor(NR, DEG, POSX, POSY, DIRX, DIRY, MAXDIST)    Particles[NR].rotationInAngleStep= DEG;Particles[NR].Pos.x= POSX; \
Particles[NR].Pos.y= POSY;Particles[NR].dir.x= DIRX;Particles[NR].dir.y= DIRY;Particles[NR].lastPos.x=POSX;Particles[NR].lastPos.y =POSY; \
Particles[NR].lastDir.x= DIRX; Particles[NR].lastDir.y= DIRY;Particles[NR].MaxDistToPredecessor= -1.0;

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
Center.Pos.x= -0.5;
Center.Pos.y= -0.5;
Center.dir.x= 0;
Center.dir.y= 0;
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

vec2 mul(mat2 matrice,float x, float y)
{vec2 retVal;
retVal.x=matrice.array[0][0]*x+matrice.array[0][1] *y;
retVal.y=matrice.array[1][0]*x+matrice.array[1][1] *y;
return retVal;
}

#define ROTATE(matrice,value,tempNameVec2,output) tempNameVec2 =mul(matrice, value.x, value.y);output = tempNameVec2;

   //y= m*x +t"
void CalcArrayMask (mat2 rotateIntoOrigin, int LineNr,  PointPair PointPairFront, PointPair PointPairRear )
{
   vec2 tempResult;
    int i;
   ROTATE(rotateIntoOrigin,PointPairFront.Up,tempResult,PointPairFront.Up)

   ROTATE(rotateIntoOrigin,PointPairFront.Low,tempResult,PointPairFront.Low)

   ROTATE(rotateIntoOrigin,PointPairRear.Up,tempResult,PointPairRear.Up)

   ROTATE(rotateIntoOrigin,PointPairRear.Low,tempResult,PointPairRear.Low)

   float SlopeFront= ((PointPairFront.Up.y - PointPairFront.Low.y)/(PointPairFront.Up.x - PointPairFront.Low.x));
   float SlopeRear = ((PointPairRear.Up.y - PointPairRear.Low.y)/(PointPairRear.Up.x - PointPairRear.Low.x));
   for (  i=0; i< 8; i++)
   {
      ArrayMask[i].start= (int)(SlopeFront * (PointPairFront.Up.x) * (float)(LineNr+ i));
      ArrayMask[i].end=   (int)(SlopeRear * (PointPairFront.Up.x) *  (float)(LineNr+ i));
   }
}


#define GRADIENT_SIZE 8
//global Extremas of the Quad
int xMin,xMax,yMin,yMax;

void CalcExtrema(vec2 p1,vec2 p2,vec2 p3,vec2 p4,mat2 rotMat)
{
   int i;
   vec2 rotatedPoints[4];
   vec2 tempVec;
   vec2 p1p2,p2p2,p3p2,p4p2;
   p1p2.x=p1.x-p2.x;p1p2.y=p1.y-p2.y;
   p2p2.x= 0;p1p2.y=0;
   p3p2.x=p3.x-p2.x;p3p2.y=p3.y-p2.y;
   p4p2.x=p4.x-p2.x;p4p2.y=p4.y-p2.y;

   ROTATE(rotMat,(p1p2),tempVec,   rotatedPoints[0])//(matrice,value,tempNameVec2,outputdestination)
   ROTATE(rotMat,(p2p2),tempVec,   rotatedPoints[1])
   ROTATE(rotMat,(p3p2),tempVec,   rotatedPoints[2])
   ROTATE(rotMat,(p4p2),tempVec,   rotatedPoints[3])
   //Initalisation
   xMin=900000;
   yMin=xMin;
   xMax=yMin*-1;
   yMax=yMin*-1;

   for ( i=0;i<4;i++)
   {
   if (rotatedPoints[i].x >= xMax) xMax= rotatedPoints[i].x;
   if (rotatedPoints[i].x <= xMin) xMin= rotatedPoints[i].x;
   if (rotatedPoints[i].y > yMax) yMax=  rotatedPoints[i].y;
   if (rotatedPoints[i].y < yMin) yMin=  rotatedPoints[i].y;
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



vec4 AddDraw(colSampler OuterCol, colSampler InnerCol, vec2 newPUp, vec2 newPDown, vec2 oldPUp, vec2 oldPDown, vec2 PixelPos)
{
    int _x,_y;

   //Get PixelPosition into Center Coordinate System Coords
   PixelPos.x= PixelPos.x -Center.Pos.x;
   PixelPos.y= PixelPos.y -Center.Pos.y;

	//check wether the Point is actually in the quad to prevent unnecessary work workload
	if (PointInTriangle(newPUp, newPDown, oldPUp, PixelPos)==false || PointInTriangle(newPDown,  oldPUp,oldPDown, PixelPos)== false) return Black;

   vec3 invlengthGradientCompo[GRADIENT_SIZE]; //r=1/upComponent, g=1/lowComponent, b= 1/nilComponent
   vec2 tempRotateMat;
   float orthoAlignQuadDegree;
   orthoAlignQuadDegree=atan2(oldPUp.y- newPUp.y,oldPUp.x- newPUp.x);



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

   for ( _x=xMin; _x < xMax; _x++)
   { //columns

   //Mixture of the Colours @ start and end
   float ratio= (float)(_x/xMax);
   vec3 tUpCol=addvec3(mulvec3_f(OuterCol.colStart;(1.0-ratio)),mulvec3_f(OuterCol.colEnd,(ratio)));
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


int main()
{
    printf("Hello world!\n");
    return 0;
}
