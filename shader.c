precision highp float;

varying vec3 n;
varying vec2 uv;
varying float time;
uniform sampler2D tex;
varying vec3 Position;

//#pragma include "noise2D.glsl // for snoise(vec2 v)
//#pragma include "noise3D.glsl" //  for snoise(vec3 v)
//#pragma include "noise4D.glsl" //  for snoise(vec4 v)
//#pragma include "cellular2D.glsl" //  for cellular(vec2 P)
//#pragma include "cellular2x2.glsl" //  for cellular2x2(vec2 P)
//#pragma include "cellular2x2x2.glsl" //  for cellular2x2x2(vec3 P)
//#pragma include "cellular3D.glsl" //  cellular(vec3 P)


varying vec3 startPoint;
varying vec3 endPoint;

 vec3 X_Axis = vec3(1.0,0,0);
 vec3 Y_Axis = vec3(0,1.0,0);
 vec3 Z_Axis = vec3(0,0,1.0);


uniform vec2 resolution;
varying vec3 fPosition;
varying vec3 fNormal;


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

struct mask{
	int start;
	int end;	
};

mask ArrayMask[8];

struct PointPair{
vec2 Up;
vec2 Low;
};

//Particle bound to a attractor
struct Particle{
	float degreeRelToCenter;
//Positions are relative Positions to CenterPos
	vec2 pos;
//Directions are non-nomralized Vectors, containing as Sqrt(Vec) the force
	vec2 dir;
	
	vec2 lastPos;
	vec2  lastDir;
	bool isCenter;
	float MaxDistToPredecessor;
};


struct Attractor{
	vec2 pos;
	vec2 dir;
	float linGravity;
	float expGravity;
	float PulseStrenghtTimeRatio;	
//describes how much each pieces NewDir is affected by linGravity over time
	float sinusFactor;
};


//Configuration
#define ParticlesSize 3
Particle Particles[ParticlesSize];
vec3 ColorStartToEnd[2];

Attractor Center;
#define CenterPathSize 7
vec2 CenterPath[CenterPathSize];

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
	ROTATE(rotMat,(p1-p2),tempVec,	rotatedPoints[0])//(matrice,value,tempNameVec4,output) 
	ROTATE(rotMat,(p2-p2),tempVec,	rotatedPoints[1])
	ROTATE(rotMat,(p3-p2),tempVec,	rotatedPoints[2])
	ROTATE(rotMat,(p4-p2),tempVec,	rotatedPoints[3])
	
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
void AddDraw(colSampler Up, colSampler Down, vec2 newPUp, vec2 newPDown, vec2 oldPUp, vec2 oldPDown)
{ 
	int _x,_y;
	vec3 invlengthGradientCompo[GRADIENT_SIZE]; //r=1/upComponent, g=1/lowComponent, b= 1/nilComponent
	vec4 tempRotateMat;
	float degree= atan(oldPUp.y- newPUp.y,oldPUp.x- newPUp.x)*2.0;
	degree= (degree > 0.0 ? degree : (2.0*PI + degree)) * 360.0 / (2.0*PI);
	
	mat4 rotMat ;
	mat4 iRotMat;
	rotMat=		rotationMatrix(Z_Axis,degree) ;
	iRotMat=	rotationMatrix(Z_Axis,-degree);

	
	CalcExtrema(newPUp,oldPUp,oldPDown,newPDown,rotMat);
	
	for (_x=xMin; _x < xMax; _x++)
	{ //columns
	//Mixture of the Colours @ start and end
	float ratio= float(_x/xMax);
	vec3 tUpCol=Up.colStart*(1.0-ratio) + Up.colEnd*(ratio);
	vec3 tDownCol=Down.colStart*(1.0-ratio) + Down.colEnd*(ratio);
	bool  bLineStarted= false;
	float particleSpeed;

	 PointPair PointPairFront;
	 PointPairFront.Up=newPUp; 
	 PointPairFront.Low=newPDown;
	 PointPair PointPairRear;
	  PointPairRear.Up=oldPUp; 
	 PointPairRear.Low=oldPDown;
	 
	if (mod(float(_x),8.0)==0.0)
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
			if (_x== int(pos.x) && _y == int(Position.y)){
			int index=int(int(pos.y)/yMax);
			int indy=int(int(pos.y)/yMax)*GRADIENT_SIZE;
			gl_FragColor = vec4((invlengthGradientCompo[index].r* tUpCol + 
			invlengthGradientCompo[indy].g*tDownCol),
			1.0);
				
			}
		}
	}	
}


vec2 updateParticlePosition(int p, float)
{
	float speed= sqrt(length(Particles[p].dir));
	float degree;
	float vecdeg=atan(Particles[p].dir.x,Particles[p].dir.y);
	
	mat4  rMat;
	rMat=rotationMatrix(Y_Axis,degree+vecdeg);
	vec4 newPos= rMat*vec4(Particles[p].pos,0.0,1.0);
	
	return vec2(newPos.x,newPos.y);	
}

int InterPolationSteps = 5;

void update(float percent)
{
	//initialise Particles and Attractor
			colSampler Up	={0.0,0.0,0.0};
			colSampler Down ={0.0,0.0,0.0};
	//This loop will later be broken up into parallel drawjobs
	//Drawing into a Texturingunit per quadstrip means its will be a linear constant  
	//Cost Total:   C* ProcessingUnits  
	for (int quadStripTex= 0; quadStripTex< CenterPath.size * percent; quadStripTex++)
	{
	//Move along the CenterPath in SimSteps   -> Steps of the same colourgradient can be parallized  
	//Cost Total:   (steps*(particles-1)) /ProcessingUnits
	
		for (int steps=0; steps < InterPolationSteps;steps++){
	
			Attractor.pos= newAttractorPosition((0.1+steps)/InterPolationSteps,i,percent);
			//update Physic Sim			
			
			//SetNewPosition
			for (int p=1;p< Particles.size; p++)
			{	
			//save the particles old Position

			Particles[p].lastPos=Particles[p].pos;
			Particles[p].pos = updateParticlePosition(p);
			Up	={1.0,0.0,0.0};
			Down={1.0,1.0,0.0};
			AddDraw( Up,  Down, Particles[p].pos, Particles[p-1].pos, Particles[p].lastPos, Particles[p-1].lastPos);			
			}
		}
	}
	
	
}


float totalTime=90.0;
float colDecayTime=30.0;


void main()
{
	vec3 eyeSpaceLigthDirection = vec3(0.0,0.0,1.0);
   	float diffuse = max(0.0,dot(normalize(n),eyeSpaceLigthDirection));
//the percentAgeOfTheWay the projectile has travelled
	float percent=mod(time/totalTime,1.0);
	float percentColourDecay=mod(time/colDecayTime,1.0);
	gl_FragColor=vec4(0.0,0.0,0.0,1.0);
  //This function redraws the Texture once Per Frame
  update(percent);
  
}
