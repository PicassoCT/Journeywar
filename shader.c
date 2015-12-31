varying vec2 uv;
varying float fTime0_1;
varying float fTime0_2PI;

 vec4 Black =vec4(0.0,0.0,0.0,1.0);
 vec3 X_Axis = vec3(1.0,0,0);
 vec3 Y_Axis = vec3(0,1.0,0);
 vec3 Z_Axis = vec3(0,0,1.0);
 
 vec3 Col_Head= vec3(0.7,0.8,0.95);
 vec3 Col_Tail= vec3(0.15,0.4,0.45);

 
 
 
vec3 fPosition;
varying vec3 fNormal;

#define INTERPOLATION_STEPS 6

//Helper functions
#define RAND(X,Y)  (fract(sin(dot(X + Y ,vec2(12.9898,78.233))) * 43758.5453))

mat4 rotationMatrix(vec3 axis, float angle)
{
   float SIN = sin(angle);
    float COS = cos(angle);
    float OCOS = 1.0 - COS;
     axis = normalize(axis);
  return mat4(OCOS * axis.x * axis.x + COS,  OCOS * axis.x * axis.y - axis.z * SIN,  OCOS * axis.z * axis.x + axis.y * SIN,  0.0,
              OCOS * axis.x * axis.y + axis.z * SIN,  OCOS * axis.y * axis.y + COS,           OCOS * axis.y * axis.z - axis.x * SIN,  0.0,
                  OCOS * axis.z * axis.x - axis.y * SIN,  OCOS * axis.y * axis.z + axis.x * SIN,  OCOS * axis.z * axis.z + COS,           0.0,
                  0.0,                                0.0,                                0.0,                                1.0);
}


float interpolate(vec2 posA, vec2 posB, float Max)
{   //Currently fades exponential to the midst Oo-.. ..-oO  * 1/MoveMentSpeedParticle 
   vec2 Mid=((posA + posB)/ 0.5);
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
   vec2 pos;
   vec2 dir;
   float linGravity;
   float expGravity;
   float PulseStrenghtTimeRatio;   
//describes how much each pieces NewDir is affected by linGravity over time
   float sinusFactor;
   float maxDistanceParticles;
};

Attractor Center;

#define ADD_CENTERPOINT(NR,PX,PY) CenterPath[NR]= vec2(PX,PY);

#define CenterPathSize 7
vec2 CenterPath[CenterPathSize];


//Particle bound to a attractor
struct Particle{
   float degreeRelToCenter;
//Positions are relative Positions to CenterPos
   vec2 pos;
//Directions are non-nomralized Vectors, containing as Sqrt(Vec) the force
   vec2 dir;
   
   vec2 lastPos;
   vec2  lastDir;

   float MaxDistToPredecessor;
};
//Configuration
#define ParticlesSize 3
Particle Particles[ParticlesSize];



#define ParticleConstructor(NR, DEG, POSX, POSY, DIRX, DIRY, MAXDIST);    Particles[NR].degreeRelToCenter= DEG;\
                                         Particles[NR].pos= vec2(POSX,POSY);\
                                                      Particles[NR].dir= vec2(DIRX,DIRY);\
                                                      Particles[NR].lastPos= vec2(POSX,POSY);\
                                                      Particles[NR].lastDir= vec2(DIRX,DIRY);\
                                                      Particles[NR].MaxDistToPredecessor= -1.0;
void init()
{
ADD_CENTERPOINT(0,-1.0,1.0)
ADD_CENTERPOINT(1,0.0,0.0)
ADD_CENTERPOINT(2,1.0,0.0)

                                                  

ParticleConstructor(0, 2.0, 1.0,1.0,0.1,0.1,2.0);
ParticleConstructor(1, 2.0, 1.0,1.0,0.3,0.1,2.0);
ParticleConstructor(2, 2.0, 2.0,-1.0,0.1,0.1,2.0);
   
Center.pos= vec2(0.0,0.0); 
Center.dir= vec2(0.0,0.0);
Center.linGravity=0.0; 
Center.expGravity= 0.0;
Center.PulseStrenghtTimeRatio=0.0;
Center.sinusFactor=0.0;
}




#define ROTATE(matrice,value,tempNameVec4,output) tempNameVec4 =(matrice * vec4(value.x,value.y,0.0,1.0));output = tempNameVec4.xy;

   //y= m*x +t" 
void CalcArrayMask (mat4 rotateIntoOrigin, int LineNr,  PointPair PointPairFront, PointPair PointPairRear ) 
{
   vec4 tempResult;

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

#define PI 3.14159
#define GRADIENT_SIZE 8

int xMin,xMax,yMin,yMax;
void CalcExtrema(vec2 p1,vec2 p2,vec2 p3,vec2 p4,mat4 rotMat)
{
   vec2 rotatedPoints[4];
   vec4 tempVec;
   ROTATE(rotMat,(p1-p2),tempVec,   rotatedPoints[0])//(matrice,value,tempNameVec4,output) 
   ROTATE(rotMat,(p2-p2),tempVec,   rotatedPoints[1])
   ROTATE(rotMat,(p3-p2),tempVec,   rotatedPoints[2])
   ROTATE(rotMat,(p4-p2),tempVec,   rotatedPoints[3])
   
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

//Draws Additive the polygons into the texture  
//Particle Speed is factored in via the colSamplers
vec4 AddDraw(colSampler OuterCol, colSampler InnerCol, vec2 newPUp, vec2 newPDown, vec2 oldPUp, vec2 oldPDown)
{ 

   vec3 invlengthGradientCompo[GRADIENT_SIZE]; //r=1/upComponent, g=1/lowComponent, b= 1/nilComponent
   vec4 tempRotateMat;
   float degree= atan(oldPUp.y- newPUp.y,oldPUp.x- newPUp.x)*2.0;
   degree= (degree > 0.0 ? degree : (2.0*PI + degree)) * 360.0 / (2.0*PI);
   
   mat4 rotMat ;
   mat4 iRotMat;
   rotMat=      rotationMatrix(Z_Axis,degree) ;
   iRotMat=   rotationMatrix(Z_Axis,-degree);

   
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
         vec2 pos;
         ROTATE(rotMat,vec2(_x,_y),tempRotateMat,pos)
         
         //access the texture and draw
      
         //texture.rgb += (invlengthGradientCompo[int(pos.y/yMax)].r*tUpCol + invlengthGradientCompo[int(pos.y/yMax)*GRADIENT_SIZE].g*tDownCol);
      
                
         if (_x== int(pos.x) && _y == int(pos.y)){
          int index=int(int(pos.y)/yMax);
          int indy=int(int(pos.y)/yMax)*GRADIENT_SIZE;
          return vec4(0.0,0.0,1.0,1.0);
           //  return vec4((invlengthGradientCompo[index].r* tUpCol + 
          //invlengthGradientCompo[indy].g*tDownCol),
          //1.0);
            
          }
      }
   }   
   return vec4(0.0,0.0,0.0,1.0);
}

//calculate a new attractor position
vec2 newAttractorPosition(vec2 interValStart, vec2 interValEnd, float percentage, float time)
{
    vec2 resultPoint;
   vec2 midPoint= vec2(interValEnd*(1.0 -percentage)+ interValStart*percentage);
   
   return resultPoint;
}

 vec2 updateParticlePosition( int p)
{
   float speed;

   float vecdeg;
    Particle temParticle;
    temParticle=Particles[p];
    
    speed=sqrt(length(temParticle.dir));
    Particles[p].degreeRelToCenter =  Particles[p].degreeRelToCenter+ atan(Particles[p].dir.x,Particles[p].dir.y);
   
   mat4  rMat;
   rMat=rotationMatrix(Y_Axis,Particles[p].degreeRelToCenter);
   vec4 newPos;
    newPos=rMat*vec4(Particles[p].pos,0.0,1.0);
   
   return vec2(newPos.x,newPos.y);   
}


float InterPolationSteps = 5.0;

vec4 doPhySim(float percent, float time, vec2 Position)
{
   vec4 accumulatedColour= Black;
   

   
   //Defining the Colours the Gradient traverses from Start to End - Outermost color Gradient
    colSampler EndInterValCol   ;
    colSampler StartInterValCol   ;
       


   //Move along the CenterPath in SimSteps   -> Steps of the same colourgradient can be parallized  
   //Cost Total:   (steps*(particles-1)) /ProcessingUnits
       for (int attrPath=0; attrPath< CenterPathSize-1;attrPath++)
      {
      //if this pixel is within range of a pathPoint+ maxRange
      if (!isPixelInSim(attrPath,Position))continue;
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
          Center.pos= newAttractorPosition(CenterPath[attrPath],CenterPath[attrPath+1],(0.1+float(steps))/InterPolationSteps,time);
          //update Color
               
         EndInterValCol.colStart= Col_Head* StartPercent + Col_Tail * (1.0 - StartPercent)  ;       
         EndInterValCol.colEnd=   Col_Head* EndPercent   + Col_Tail * (1.0 - EndPercent)  ;       
         StartInterValCol=EndInterValCol;
          //update Physic Sim         
          
             //SetNewPosition
            for (int p=1;p< ParticlesSize; p++)
            {   
               //save the particles old Position
                  Particles[p].lastPos=Particles[p].pos;
               //calculate a new Position
               Particles[p].pos=  updateParticlePosition( p);
               //factor in the traversed Distance into the colour (this disregards the curve taken)   
               float OutTraversedDistance =distance(Particles[p].pos,Particles[p].lastPos);
               float InnerTraversedDistance= distance(Particles[p-1].pos,Particles[p-1].lastPos);
               float averageDistance= (OutTraversedDistance+ InnerTraversedDistance)*0.5;
               outerFactorDistance=(averageDistance/OutTraversedDistance);
               innerFactorDistance=(averageDistance/InnerTraversedDistance);
             EndInterValCol.colStart *= outerFactorDistance;
             EndInterValCol.colEnd *= outerFactorDistance;    
            
            StartInterValCol.colStart *= innerFactorDistance;
             StartInterValCol.colEnd *= innerFactorDistance;
                 
               accumulatedColour =accumulatedColour +  AddDraw(EndInterValCol,   StartInterValCol,  Particles[p].pos, Particles[p-1].pos, Particles[p].lastPos, Particles[p-1].lastPos);   
            }
        }
	  }
return accumulatedColour;
}


float totalTime=90.0;
float colDecayTime=30.0;


//Is the Pixel in Question in the physic sim
bool isPixelInSim(int step, vec2 Pos)
{
if (distance(CenterPath[step],Pos) < Center.maxDistanceParticles)
	{ return true;}

return false;
}



void main(void)
{
   //initialise Particles and Attractor
   if (fTime0_1==0.0)
      init();
  
   //the percentAgeOfTheWay the projectile has travelled
   float percentColourDecay=mod(fTime0_1/colDecayTime,1.0);
   bool InPhySim=false;
   bool  Temp;
    for (int i=0; i< CenterPathSize;i++)
   {
	    Temp= isPixelInSim(i,Position);
		InPhySim = ( InPhySim && Temp);
   }
   gl_FragColor=Black;
   
   if (InPhySim==true) 
	   gl_FragColor=doPhySim(mod(fTime0_1/totalTime,1.0), fTime0_1, Position);
}


