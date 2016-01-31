   // KELEK 010


   uniform float time0_1;
   uniform float time0_2PI;
   varying vec2 Position;
   varying vec3 fNormal;
   //Color at Vertex Start

   varying float sinUs;
   
    vec4 Black =vec4(0.0,0.0,0.0,0.0);
    vec4 Green =vec4(0.0,1.0,0.0,1.0);
    vec4 Blue =vec4(0.0,0.0,1.0,1.0);
    vec4 Red =vec4(1.0,0.0,0.0,1.0);
    vec4 White =vec4(1.0,1.0,1.0,1.0);
    vec4 Grey =vec4(0.5,0.5,0.5,1.0);
    
    vec3 X_Axis = vec3(1.0,0,0);
    vec3 Y_Axis = vec3(0,1.0,0);
    vec3 Z_Axis = vec3(0,0,1.0);
    
    varying vec4 vertexStartCol;
    varying vec4 vertexEndCol;
   
   #define INTERPOLATION_STEPS 1
   #define MAX_RANGE_PARTICLES 15.0
   //Constants
   #define PI 3.14159
   #define PI2 (PI*2.0)
   #define INT_MAX ((!0)-1)
   #define INT_MIN (!0)
   

   //hc = 2·sqrt(s·(s - a)·(s - b)·(s - c))/c
   #define POSPROPORTION(DISTPOSUP,DISTPOSDOWN,DISTUPDOWN,RESULT) RESULT=(((DISTPOSUP)+(DISTPOSDOWN)+(DISTUPDOWN))*0.5);RESULT=((2.0*sqrt((RESULT)*((RESULT)-(DISTPOSUP))*((RESULT)-(DISTPOSDOWN))*((RESULT)-(DISTUPDOWN))))/(DISTUPDOWN));RESULT=((RESULT)*(RESULT)+(DISTPOSUP)*(DISTPOSUP));RESULT=(sqrt((RESULT))/(DISTUPDOWN));

   
   //debugInfo
   #define isParticleNearPosition(PARTICLE,POSITION,TOLERANCE)  (distance(PARTICLE + Center.Pos,POSITION) < TOLERANCE) 
   //Helper functions
   #define RAND(X,Y)  (fract(sin(dot(X + Y ,vec2(12.9898,78.233)))*43758.5453))
   #define max(A,B)  = (A > B)? A: B;
   //Describes a linear Colour Gradient 
   struct colSampler{
   vec4 colStart;
   vec4 colEnd;   
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
   mask maskStartEnd;

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

   #define ADD_PATHPOINT(NR,PX,PY) CenterPath[NR]= vec2(PX,PY);

   //Configuration
   #define CenterPathSize 4
   vec2 CenterPath[CenterPathSize];


   #define ParticlesSize 5
   Particle Particles[ParticlesSize];

   #define ParticleConstructor(NR, DEG, POSX, POSY, DIRX, DIRY, MAXDIST)    Particles[NR].rotationInAngleStep= DEG;Particles[NR].Pos= vec2(POSX,POSY);Particles[NR].dir= vec2(DIRX,DIRY);Particles[NR].lastPos= vec2(POSX,POSY); Particles[NR].lastDir= vec2(DIRX,DIRY);Particles[NR].MaxDistToPredecessor= -1.0;
      //Defining the Colours the Gradient traverses from Start to End - Outermost color Gradient
      colSampler OuterCol   ;
      colSampler InnerCol ;
   #define GRADIENT_SIZE 9   
     float Gradient[GRADIENT_SIZE];
     
   void init()
   {
   int i;
   //PathPoints
   ADD_PATHPOINT( 0, 1.0,0.0)        
   ADD_PATHPOINT( 1, -10.0,-5.0)            
   ADD_PATHPOINT( 2, -10.0,-10.0)            
   ADD_PATHPOINT( 3, 0,-20.0)                
   //ADD_PATHPOINT( 4,-5.0,4.0)         
   //ADD_PATHPOINT( 5,-4.0,5.0)         
   //ADD_PATHPOINT( 6,-3.0,6.0)         
   //ADD_PATHPOINT( 7,-2.0,7.0)
ParticleConstructor(0, PI* 0.3,1.0 ,1.1,0.1,0.1,20.0);     
ParticleConstructor(1, PI* 0.3,2.0 ,1.1,0.3,0.1,20.0);    
ParticleConstructor(2, PI* 0.3,4.0 ,1.1,0.3,0.1,20.0);     
ParticleConstructor(3, PI* 0.3,8.0 ,1.1,0.3,0.1,20.0);     
ParticleConstructor(4, PI* 0.3,12.0 ,1.1,0.3,0.1,20.0);     
   //StartPositionsParticle
   //ParticleConstructor(0, PI* time0_1,1.0 ,1.1,0.1,0.1,20.0);
   //ParticleConstructor(1, PI* time0_1,2.0 ,1.1,0.3,0.1,20.0);
   //ParticleConstructor(2, PI* time0_1,4.0 ,1.1,0.3,0.1,20.0);
   //ParticleConstructor(3, PI* time0_1,8.0 ,1.1,0.3,0.1,20.0);
   //ParticleConstructor(4, PI* time0_1,12.0 ,1.1,0.3,0.1,20.0);
   //ParticleConstructor(2, 4.0, 5.0,-1.0,0.1,0.1,2.0);

   //Initializing the Center 
   Center.Pos= vec2(0.0,0.0); 
   Center.dir= vec2(0.0,0.0);
   Center.linGravity=0.0; 
   Center.expGravity= 0.0;
   Center.PulseStrenghtTimeRatio=0.0;
   Center.sinusFactor=0.0;
   Center.maxDistanceParticles=MAX_RANGE_PARTICLES;
   
   //Colours and Gradient
      Gradient[0]=0.0;
      Gradient[1]=0.3 *sinUs;
      Gradient[2]=0.05*sinUs;
      Gradient[3]=0.7*sinUs;
      Gradient[4]=0.2*sinUs;
      Gradient[5]=1.0*sinUs;
      Gradient[6]=0.2*sinUs;
      Gradient[7]=0.3*sinUs;
      Gradient[8]=0.0; 
  
   }

   //Is the Pixel in Question in the physic sim
   bool isPixelInSim(int steps, vec2 Pos)
   {
   return  (distance(CenterPath[steps],Pos) < Center.maxDistanceParticles);
   }


   mat2 rotationMatrix(float angle)
   {
   return mat2( cos(angle), sin(angle),
         -1.0*sin(angle), cos (angle)); 
   }

   //sums up the component of a vector   
   float sum(vec3 element)
   {return element.x+element.y+element.z;}
   float sumv2(vec2 element)
   {return element.x+element.y;}   

   float interpolate(vec2 posA, vec2 posB, float Max)
   {   //Currently fades exponential to the midst Oo-.. ..-oO*1/MoveMentSpeedParticle 
      vec2 Mid=((posA + posB)*0.5);
      float DisTance;
      if( distance(posA,Mid) < distance(posB, Mid))
      DisTance= distance(posA, Mid);
      else
      DisTance= distance(posB, Mid);   
      
      return abs(min(DisTance/(Max*0.5), 1.0));
   }

   float alphaGradient(int index, float factor)
   {
   return   Gradient[index]*factor+ Gradient[min(GRADIENT_SIZE-1,index+1)]* (1.0-factor);      
   }
   



   bool PointInTriangle( vec2 a, vec2 b, vec2 c,vec2 s)
   {
      float as_x = s.x-a.x;
      float as_y = s.y-a.y;

      bool s_ab = (b.x-a.x)*as_y-(b.y-a.y)*as_x > 0.0;

      if((c.x-a.x)*as_y-(c.y-a.y)*as_x > 0.0 == s_ab) return false;

      if((c.x-b.x)*(s.y-b.y)-(c.y-b.y)*(s.x-b.x) > 0.0 != s_ab) return false;

      return true;
   }

   #define norm(v)     sqrt(dot(v,v))     // norm = length of  vector
   #define dist(u,v)      norm(u-v)          // distance = norm of difference
     // dist_Point_to_Segment(): get the distance of a point to a segment
   //     Input:  a Point P and a Segment S (in any dimension)
   //     Return: the shortest distance from P to S
   float minimum_distance(vec2 P0, vec2 P1, vec2 P)
   {
       vec2  v = P1 - P0;
       vec2  w = P - P0;

       float c1 = dot(w,v);
       if ( c1 <= 0 )
           return dist(P, P0);

       float c2 = dot(v,v);
       if ( c2 <= c1 )
           return dist(P, P1);


       vec2 Pb = P0 + (c1 / c2)*v;
       return dist(P, Pb);
   }



   //debugPrintBorders of Quads
   bool PointOnBorder(vec2 offSet, vec2 newPOut, vec2 newPIn, vec2 oldPOut, vec2 oldPIn, vec2 PixelPos,float tol)
   {
   newPOut+=offSet;
   newPIn+=offSet;
   oldPOut+=offSet;
   oldPIn+=offSet;

   if (minimum_distance(newPOut,newPIn,PixelPos) < tol) return true;
   if (minimum_distance(newPIn,oldPIn,PixelPos) < tol) return true;
   if (minimum_distance(oldPOut,oldPIn,PixelPos) < tol) return true;
   if (minimum_distance(oldPOut,newPOut,PixelPos) < tol) return true;
   return false;
   }

   
   #define COMPOSE(COL,COLB, FACTOR) ((COL* FACTOR) +(COLB *(1.0- FACTOR)))
   
   //Draws Additive the polygons into the texture  
   //Particle Speed is factored in via the colSamplers
   vec4 AddDraw(colSampler OuterCol, colSampler InnerCol, float outFac, float inFac, vec2 newPOut, vec2 newPIn, vec2 oldPOut, vec2 oldPIn, vec2 PixelPos, int gradIndex)
   { 
    float tempAlpha;
      
      if  (PointOnBorder( oldPOut,  newPOut,  newPIn,  oldPOut,  oldPIn,  PixelPos,0.03)==true ) return Red;
      
   
      vec2 PixelPosRotCoords;
      //Get PixelPosition into Center Coordinate System Coords
      PixelPos= PixelPos -Center.Pos.xy; 

      //check wether the Point is actually in the quad to prevent unnecessary work workload
     if (PointInTriangle(newPOut, newPIn, oldPOut, PixelPos)==false && PointInTriangle(newPIn,  oldPOut,oldPIn, PixelPos)== false  ) return Black;
      
      PointPair PointPairFront;
      PointPair PointPairRear;
      
      //The points are still in the center
      PointPairFront.Up=newPOut; 
      PointPairFront.Low=newPIn;
    
      PointPairRear.Up= oldPOut; 
      PointPairRear.Low=oldPIn;
   
      //Move the Point into the Coordinate System around the Last Outer Particle Point
      PixelPosRotCoords=PixelPos.xy- oldPOut.xy;
      //Rotate it with the computated Matrice
      float _x = PixelPosRotCoords.x;
      float _y = PixelPosRotCoords.y;
      //determinates the 
      //CalcExtrema(newPOut,oldPOut,oldPIn,newPIn,rotMat);
      
       
     float DistanceMidFrontRear, DistanceFrontPos;
     float totalDistanceRear, distancePosRearOut,distancePosRearIn, rearUpNormResult,rearDownNormResult;
     float totalDistanceFront, distancePosFrontOut,distancePosFrontIn, frontUpNormResult,frontDownNormResult;
     float  distFrontRear,distancePosRear;
     float distNormFrontRear;
     vec2  midPosFront, midPosRear;
 
//Rear   
      //distance of the quads Rear In and Out
       totalDistanceRear= distance(oldPOut,oldPIn);
      //distance of the Position to the rear Outward Vertex
      distancePosRearOut=distance(PixelPos,oldPOut);
       //distance of the Position to the rear Inward Vertex
      distancePosRearIn=distance(PixelPos,oldPIn);
      
      //computes the distance in percent down
   POSPROPORTION(distancePosRearOut,distancePosRearIn,totalDistanceRear,rearUpNormResult);
      //computes the distance in percent up
      rearDownNormResult= 1.0 - rearUpNormResult;

//Front
      //distance of the quads Front In and Out
       totalDistanceFront= distance(oldPOut,oldPIn);
      //distance of the Position to the front Outward Vertex
      distancePosFrontOut=distance(PixelPos,oldPOut);
       //distance of the Position to the front Inward Vertex
      distancePosFrontIn=distance(PixelPos,oldPIn);
      
      //computes the distance in percent down
    POSPROPORTION(distancePosFrontOut,distancePosFrontIn,totalDistanceFront,frontUpNormResult);
      //computes the distance in percent up
      frontDownNormResult= 1.0 - frontUpNormResult;
      //midPos
      midPosFront= COMPOSE(newPIn,newPOut,frontUpNormResult);
   //Distance Front Rear
    distFrontRear= distance(newPIn,oldPIn);
   distancePosRear = distance(PixelPos,oldPIn);
    distNormFrontRear=0;
   POSPROPORTION(distancePosRear,distancePosFrontIn,distFrontRear,distNormFrontRear);
   
   //Front Alpha Gradient
   float FrontAlphaGradient=alphaGradient(gradIndex,frontDownNormResult);
   //Rear Alpha Gradient
   float RearAlphaGradient=alphaGradient(gradIndex,rearDownNormResult);
   
   //Lower one wins
   FrontAlphaGradient= min(FrontAlphaGradient,InnerCol.colStart.a);
   RearAlphaGradient=min (RearAlphaGradient,InnerCol.colEnd.a);
   
   //Get a global Percentage
   float absoluteAlphaGradient=    COMPOSE(FrontAlphaGradient,RearAlphaGradient,distNormFrontRear);
      


   
   vec4 tInCol=    InnerCol.colStart*(distNormFrontRear) +   InnerCol.colEnd*(1.0-distNormFrontRear);
   vec4 tOutCol=    OuterCol.colStart*(distNormFrontRear) +   OuterCol.colEnd*(1.0-distNormFrontRear);  
     
      
     float relativeInnerOut=mix(frontUpNormResult,rearUpNormResult,0.5);
    
       vec4 resultCol= tOutCol* (1.0-relativeInnerOut) + tInCol *(relativeInnerOut);
      resultCol*=absoluteAlphaGradient;
       return resultCol;
        
      
   }

   //calculate a new attractor position
   vec2 newAttractorPosition(vec2 interValStart, vec2 interValEnd, float percentage, float time)
   {   
      vec2 midPoint= vec2(interValEnd*(1.0 -percentage)+ interValStart*percentage);
      
      return midPoint;
   }

   void updateParticlePosition( int p)
   {   
      float fRotationDynamicPart, fTotalRotation;
      mat2  rMat;
      //save the particles old Position
      Particles[p].lastPos=Particles[p].Pos;

      //calculte dynamic part of the Rotation
      fRotationDynamicPart=0.0;//atan(Particles[p].dir);
      fTotalRotation =  Particles[p].rotationInAngleStep + fRotationDynamicPart; // speed*atan(Particles[p].dir.x,Particles[p].dir.y);
      //fTotalRotation=sin(time0_1*PI2 -PI);
    
      rMat=rotationMatrix(fTotalRotation);
      
      Particles[p].Pos.xy =  rMat*Particles[p].Pos.xy;   
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
      float outerFactorDistance, innerFactorDistance;
      
      //DebugDelMe
        //if (atParticleStartPos(Pos,0.1)== true) return Red;
      //DebugDelMe 
      
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
         //Set the Start End Colour
          InnerCol.colStart=    vertexStartCol*startPercentage + vertexEndCol*(1.0 - startPercentage) ;      OuterCol.colStart= InnerCol.colStart;
          InnerCol.colEnd  =   vertexStartCol*endPercentage   + vertexEndCol*(1.0 - endPercentage)  ;      OuterCol.colEnd = InnerCol.colEnd;
        
         for (int steps=0; steps < INTERPOLATION_STEPS ;steps++)
         {          
            
           //calculate the new AttractorPosition
           Center.Pos= newAttractorPosition(CenterPath[attrPath],CenterPath[attrPath+1],(0.1+float(steps))/InterPolationSteps,time);
         
     
         //debugInfo
        // if ( sum(vec3(abs(Pos- Center.Pos),0.0))< 0.125) return Green;
          
           //update Physic Sim    
           
             //SetNewPosition
            for (int p=0;p < ParticlesSize; p++)
            {  
               //calculate a new Position
               updateParticlePosition( p);
               
               //factor in the traversed Distance into the colour (this disregards the curve taken)   
               float OutTraversedDistance = distance(Particles[p].Pos,Particles[p].lastPos);
               float InnerTraversedDistance= distance(Particles[p-1].Pos,Particles[p-1].lastPos);
               float sumDistance= OutTraversedDistance + InnerTraversedDistance;
            
               //multiply by traversed distance
               outerFactorDistance=1.0-(OutTraversedDistance/sumDistance);
               innerFactorDistance=1.0-(InnerTraversedDistance/sumDistance);
        
      
         
             if (p > 0)
             {
    
             accumulatedColour = accumulatedColour +  AddDraw(OuterCol, InnerCol,outerFactorDistance,innerFactorDistance, Particles[p].Pos, Particles[p-1].Pos, Particles[p].lastPos, Particles[p-1].lastPos,Pos,int( float(float(p)/float(ParticlesSize)* GRADIENT_SIZE)));  
          
             } 
            }
         }
       }
   return accumulatedColour;
   }


   float totalTime=90.0;
   float colDecayTime=30.0;
   float globalPercentColDecay;


   void main(void)
   {

      //initialise Particles and Attractor 
      init();
      //SetToDefault
      gl_FragColor=Black;  
      
      //the percentAgeOfTheWay the projectile has travelled
      globalPercentColDecay = mod(time0_1/colDecayTime,1.0);
      bool  InPhySim=false;
      bool  ItterationTest=false;
      
      for (int i=0; i< CenterPathSize;i++)
      {
        ItterationTest= isPixelInSim(i,Position.xy);
        InPhySim = ( InPhySim || ItterationTest);
      
      }
     

      if (InPhySim==true) {
        gl_FragColor= doPhySim(mod(time0_1/totalTime,1.0), time0_1, Position.xy);
       
        }
      else 
      { 
      
        gl_FragColor= ((vec4(0.9,0.9,0.9,1.0) + gl_FragColor)/sum(1.0 - normalize(fNormal)));
      }   

   }


