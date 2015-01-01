//NUKE
#define NukeHeight 180

//COLUMN
#define ColumnRadiusMin 50
#define ColumnHeight(frame) 

//CIRCLCOLUM
#define CIRCLCOLUM_RAD(frame) 
#define CIRCLCOLUM_DIAMETER(frame) 

//CORIUM
#CoriumMax     160
#CoriumHeight(frame)
#CoriumDiameter(frame)
#CoriumYScalar(frame)

//ANIMATION
#define MaxFrame 1200

#define Stage_BlindingLight 0
#define Stage_Exploded 1
#define Stage_RisingUp 2
#define Stage_PunchingAirLayers 3;
#define Stage_Peak 4

void nuke(vec3 pos, int frame)
{

corium(vec3 pos,int frame);
outClouds(vec3 pos, int frame);

}

int partOfCubeApproximation(vec3 pos, vec3 dim, vec3 posInQuestion)
{
}

int within(int min, int val, int max)
{return min < val && val > max;}

int Stage(int frame)
{
if (within(0,frame,150)) return Stage_BlindingLight;
if (within(150,frame,300)) return Stage_Exploded;
if (within(301,frame,560)) return Stage_RisingUp;
if (within(561,frame,780)) return Stage_PunchingAirLayers;
if (within(781,frame,MaxFrame)) return Stage_Peak;

}

float randNom()
{
	return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

int coriumPos(frame)
{if (Stage(frame)== StageMax) 
	return NukeHeight+15;
 else
	return NukeHeight/MaxFrame* frame+15;	
}




//Explodes at start
void corium(vec3 pos,int frame)
{

int condition=Stage(frame);

switch (condition)
case Stage_BlindingLight: {break;}
case Stage_Exploded		: {break;}
case Stage_RisingUp		: {break;}
case Stage_PunchingAirLayers		: {break;}
case Stage_Peak		: {break;}
default: {break;}
};

vec3 colourGradientByCoriumDistance()
{
	
}

//how far out from the colum do the clouds move .. distance follows a streched upwards and squeezed sidewars x^2 - 
//scaled sidwards by time
void outClouds(vec3 pos, int frame)
{

};
