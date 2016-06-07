   // KELEK 010 V


   uniform float time0_1;
   uniform float time0_2PI;
   varying vec2 Position;
   varying vec3 fNormal;
   //Color at Vertex Start

   varying float sinUs;
   
    vec4 Black =vec4(0.0,0.0,0.0,0.0);
    vec4 Green =vec4(0.0,1.0,0.0,1.0);
    vec4 Blue =vec4(0.0,0.0,1.0,1.0);
   vec4 Yellow =vec4(0.0,0.1,1.0,1.0);
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
   // #define POSPROPORTION(DISTPOSUP,DISTPOSDOWN,DISTUPDOWN,RESULT) RESULT=(((DISTPOSUP)+(DISTPOSDOWN)+(DISTUPDOWN))*0.5);RESULT=((2.0*sqrt((RESULT)*((RESULT)-(DISTPOSUP))*((RESULT)-(DISTPOSDOWN))*((RESULT)-(DISTUPDOWN))))/(DISTUPDOWN));RESULT=((RESULT)*(RESULT)+(DISTPOSUP)*(DISTPOSUP));RESULT=(sqrt((RESULT))/(DISTUPDOWN));
   float posProportion( vec2 pPixel, vec2 pointA, vec2 pointB) {

   vec2 posIntersect;

   float m_X =       pointA.x -pointB.x;
   float m_Y =    pointA.y -pointB.y;
   float m_AB =   m_X/m_Y;
   float m_Intercept =  -1.0 * (m_Y/m_X);

   //computatet the steigung of the intercept
   //yi = m_Intercept * xi +t_intercept;
   //t_intercept = yi - m_Intercept *xi;
   float t_intercept = pPixel.y - m_Intercept *pPixel.x;
   float t_ab = pointA.y - (-1* m_Intercept) * pointA.x;

   //yi = m_Intercept * xi +t_intercept;
   //yab = m_ab * xab +t_ab;

   //we need the intersectionpoint
    posIntersect.x      = ( t_intercept - t_ab) /( m_AB -  m_Intercept);
    posIntersect.y    = m_Intercept *   (posIntersect.x + t_intercept);

   return distance(pointA, posIntersect)/distance(pointA,pointB);
   }

   
   //debugInfo
   #define isParticleNearPosition(PARTICLE,POSITION,TOLERANCE)  (distance(PARTICLE + Center.Pos,POSITION) < TOLERANCE) 
   //Helper functions
   #define RAND(X,Y)  (fract(sin(dot(X + Y ,vec2(12.9898,78.233)))*43758.5453))
   #define MATH_MAX(A,B)  = (A > B)? A: B;
   //Describes a linear Colour Gradient 
   struct colSampler{
   vec4 colIn;
   vec4 colOut;   
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
   #define CenterPathSize 2
   vec2 CenterPath[CenterPathSize];


   #define PARTICLESSIZE 5
   Particle Particles[PARTICLESSIZE];
   
   #define PERCENTAGE (1.0/ float(PARTICLESSIZE))
   
   #define GRADIENT_SIZE 9   
   float Gradient[GRADIENT_SIZE];
    
   #define ParticleConstructor(NR, DEG, POSX, POSY, DIRX, DIRY, MAXDIST)    Particles[NR].rotationInAngleStep= DEG;Particles[NR].Pos= vec2(POSX,POSY);Particles[NR].dir= vec2(DIRX,DIRY);Particles[NR].lastPos= vec2(POSX,POSY); Particles[NR].lastDir= vec2(DIRX,DIRY);Particles[NR].MaxDistToPredecessor= -1.0;
      //Defining the Colours the Gradient traverses from Start to End - Outermost color Gradient
      colSampler GradStartCol;
      colSampler GradEndCol;
     
   void init()
   {
   int i;
   //PathPoints
   ADD_PATHPOINT( 0, 1.0,0.0)        
   ADD_PATHPOINT( 1, -10.0,-5.0)            
   //ADD_PATHPOINT( 2, -10.0,-10.0)            
   //ADD_PATHPOINT( 3, 0,-20.0)                
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
   bool PointOnBorder(vec2 offSet, vec2 pNewOut, vec2 pNewIn, vec2 pOldOut, vec2 pOldIn, vec2 pPixel,float tol)
   {
   pNewOut+=offSet;
   pNewIn+=offSet;
   pOldOut+=offSet;
   pOldIn+=offSet;

   if (minimum_distance(pNewOut,pNewIn,pPixel) < tol) return true;
   if (minimum_distance(pNewIn,pOldIn,pPixel) < tol) return true;
   if (minimum_distance(pOldOut,pOldIn,pPixel) < tol) return true;
   if (minimum_distance(pOldOut,pNewOut,pPixel) < tol) return true;
   return false;
   }

   #define NORM(VAL_A,VAL_B) VAL_A = VAL_A/sqrt((VAL_A *VAL_A)+ (VAL_B*VAL_B)); VAL_B = 3* VAL_B/sqrt((VAL_A *VAL_A)+ (VAL_B*VAL_B));
   #define COMPOSE(COL,COLB, FACTOR) ((COL* FACTOR) +(COLB *(1.0 - FACTOR)))
   #define BLEND(COL_A,COL_B, START, END, RESULT_VARA, RESULT_VARB) RESULT_VARA= COL_A*START + COL_B *(1.0-START); RESULT_VARB= COL_A* END + COL_B(1.0- END);
   #define BLENDSAMPLER(COL_A,COL_B,COL_C,COL_D, PERCENT,   RESULT_VAR) RESULT_VAR.colIn= COL_A*PERCENT + COL_B *(1.0-PERCENT);RESULT_VAR.colOut= COL_C*PERCENT + COL_D *(1.0-PERCENT);
   
   //Draws Additive the polygons into the texture  
   //Particle Speed is factored in via the colSamplers
  vec4 AddDraw(colSampler qFrontCol,colSampler qRearCol, vec2 pNewOut, vec2 pNewIn, vec2 pOldOut, vec2 pOldIn, vec2 pPixel, int gradIndex)
   { 
   
    //check wether the Point is actually in the quad to prevent unnecessary work workload
   if (PointInTriangle(pNewOut, pNewIn, pOldOut, pPixel)==false && PointInTriangle(pNewIn,  pOldOut,pOldIn, pPixel)== false  ) return Black; 
      
   //TODO remove Debug
    if  (PointOnBorder( Center.Pos.xy,   pNewOut,  pNewIn,  pOldOut,  pOldIn,  pPixel,0.03)==true ) return Red;
       
        //Get pPixelition into Center Coordinate System Coords
     //   pPixel= pPixel - Center.Pos.xy; 


        
       float DistanceMidFrontRear, DistanceFrontPos;
       float totalDistanceRear, distancePosRearOut,distancePosRearIn, rearUpNormResult,rearDownNormResult;
       float totalDistanceFront, distancePosFrontOut,distancePosFrontIn, frontUpNormResult,frontDownNormResult;
       float distNormFrontRear;
       vec2  midPosFront, midPosRear;
       vec2  pMidInner, pMidOuter;
       vec2 pMidFront, pMidRear;
    
          //Rear    Side
        //total distance of the quads Rear In and Out Point
        totalDistanceRear= distance(pOldOut,pOldIn);      
        
      //distance of the Pixel Position to the rear Outward Point
        distancePosRearOut=distance(pPixel,pOldOut);
        
      //distance of the Position to the rear Inward Point
        distancePosRearIn=distance(pPixel,pOldIn);
        
        //computes the distance in percent up
      rearUpNormResult = posProportion( pPixel, pOldOut,  pOldIn);

      //POSPROPORTION(distancePosRearOut,distancePosRearIn,totalDistanceRear,rearUpNormResult);
        
      //computes the distance in percent down
        rearDownNormResult= 1.0 - rearUpNormResult;
        
      //estimate the midPos with the given percentage
       // midPosRear= COMPOSE(pOldIn,pOldOut,rearDownNormResult);
 
   //Front  Side
        //distance of the quads Front In and Out
         totalDistanceFront= distance(pNewOut,pNewIn);
        //distance of the Position to the front Outward Vertex
        distancePosFrontOut=distance(pPixel, pNewOut);
         //distance of the Position to the front Inward Vertex
        distancePosFrontIn=distance(pPixel,pNewIn);
        
        //computes the distance in percent down
      frontUpNormResult = posProportion( pPixel, pNewOut,  pNewIn);
      
      //computes the distance in percent up
        frontDownNormResult= abs( 1.0 - frontUpNormResult);
        //midPos
        //midPosFront= COMPOSE(pNewIn,pNewOut,frontUpNormResult);
   
   
    float    totalDistance_Inner, distancePosFrontIn_Inner, distancePosRearIn_Inner, FrontNormResult_Inner, RearNormResult_Inner  ;
    float    totalDistance_Outer, distancePosFrontOut_Outer, distancePosRearOut_Outer, Rear_NormResult_Outer, Front_NormResult_Outer  ;
   
   //Inner Side
        //distance of the quads Front In and Out
        totalDistance_Inner =    distance(pNewIn ,pOldIn); //distance
        //distance of the Position to the front Outward Vertex
        distancePosFrontIn_Inner  = distance(pPixel,  pNewIn); //distance
         //distance of the Position to the front Inward Vertex
        distancePosRearIn_Inner =distance(pPixel , pOldIn); //distance
        
        //computes the distance in percent down
         FrontNormResult_Inner = posProportion( pPixel, pNewIn,  pOldIn);
       
      //computes the distance in percent up
        RearNormResult_Inner = abs(1.0 - FrontNormResult_Inner);
      //midPos
        pMidInner= COMPOSE(pNewIn,pOldIn,FrontNormResult_Inner);
     //midPos
        pMidFront = COMPOSE(pNewIn,pNewOut,FrontNormResult_Inner);
   if (distance(pPixel,pMidInner) < 0.3 ) return Green;
     // if (distance(pPixel,pMidFront) < 0.3 ) return Yellow;
   
   //Outer Side
      //distance of the quads Front Out and Rear Out
        totalDistance_Outer = distance(pNewOut,pOldOut); //distance
        //distance of the Position to the front Outward Vertex
        distancePosFrontOut_Outer  = distance(pPixel, pNewOut); //distance
         //distance of the Position to the front Inward Vertex
        distancePosRearOut_Outer =distance(pPixel,pOldOut); //distance
        
        //computes the distance in percent down
       Rear_NormResult_Outer = posProportion( pPixel, pNewOut,  pOldOut);
           //computes the distance in percent up
        Front_NormResult_Outer = 1.0 - Rear_NormResult_Outer;
      //midPos
        pMidOuter= COMPOSE(pNewOut,pOldOut,Rear_NormResult_Outer);
      
      if (distance(pPixel,pMidOuter) < 0.3 ) return Green;
      

      
   float percentage_distDown    = distance(pMidOuter, pPixel)   ; //distance
   float percentage_distUp    = distance(pMidInner,pPixel)   ;//distance
   float dist_norm            = sqrt( percentage_distDown*percentage_distDown + percentage_distUp* percentage_distUp);
   
   //recombine the percentages of frontheight and rearheight
      percentage_distDown    =    abs(percentage_distDown /dist_norm);
      percentage_distUp      =    abs(percentage_distUp /dist_norm);
      
   //Lets compose the Color - Distortion Free
         
   //mix the lower color
   vec4 lowerCol = (qFrontCol.colIn * RearNormResult_Inner) + (qRearCol.colIn * (FrontNormResult_Inner));
   
   //mix the upper color
   vec4 upperCol = (qFrontCol.colOut * Front_NormResult_Outer) + (qRearCol.colOut * (Rear_NormResult_Outer) );
   

   
   
   //mix the lower and upper color
    vec4 resultCol= mix(lowerCol, upperCol, percentage_distDown);
   return resultCol; 
     
   //Front Alpha Gradient
      float FrontAlphaGradient=alphaGradient(gradIndex,frontDownNormResult);
   //Rear Alpha Gradient
      float RearAlphaGradient=alphaGradient(gradIndex,rearDownNormResult);
      
      //Lower one wins
      FrontAlphaGradient= min(FrontAlphaGradient,qFrontCol.colIn.a);
      RearAlphaGradient=  min (RearAlphaGradient,qRearCol.colIn.a);
      
      //Get a global Percentage
      float absoluteAlphaGradient=    COMPOSE(FrontAlphaGradient,RearAlphaGradient,distNormFrontRear);
      
     
      float distanceFrontMidPos_Pos= distance(midPosFront,pPixel);
      
      
 

      //  resultCol*=absoluteAlphaGradient;
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
      for (int i= 0; i< PARTICLESSIZE;i++)
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
        if (atParticleStartPos(Pos,0.1)== true) return Red;
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
         //Set the Start End Colour of this PartPath
          GradEndCol.colOut=    vertexStartCol*startPercentage + vertexEndCol*(1.0 - startPercentage) ;      GradEndCol.colIn=   GradEndCol.colOut;
          GradStartCol.colOut  =   vertexStartCol*endPercentage   + vertexEndCol*(1.0 - endPercentage)  ;      GradStartCol.colIn =  GradStartCol.colOut ;
        
         for (int steps=0; steps < INTERPOLATION_STEPS ;steps++)
         {          
            
        //calculate the new AttractorPosition
        Center.Pos= newAttractorPosition(CenterPath[attrPath],CenterPath[attrPath+1],(0.1+float(steps))/InterPolationSteps,time);
         //Colorsampler containing the strips Front and Rear Color
       float StripFrontPercentage, StripRearPercentage,stripPercent;
       stripPercent= 1/INTERPOLATION_STEPS;
       
       StripFrontPercentage = min( stripPercent*(steps+1),1.0);
       StripRearPercentage =min( stripPercent*(steps),1.0);
    
       colSampler StripFront;
       colSampler StripRear;
          
        //mix this color for this interpolation step
    
      BLENDSAMPLER(GradStartCol.colIn, GradEndCol.colIn, GradEndCol.colOut, GradEndCol.colOut,StripFrontPercentage, StripFront)
      BLENDSAMPLER(GradStartCol.colIn, GradEndCol.colIn, GradEndCol.colOut, GradEndCol.colOut, StripRearPercentage, StripRear)

             //SetNewPosition
            for (int p=0;p < PARTICLESSIZE; p++)
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
        
  
              //Get the outer Percentage of the colorstrip
      
            colSampler RearCol;
         colSampler FrontCol;
         
             if (p > 0)
             {
         float index = float(p-1);
         if (index == 0) index = 1;

         
         RearCol.colIn =      (index * PERCENTAGE *StripRear.colIn )+  ((PARTICLESSIZE- index)*PERCENTAGE *StripRear.colOut); 
         RearCol.colOut =     ((p)*PERCENTAGE *StripRear.colIn)  +  ((PARTICLESSIZE-p)*PERCENTAGE *StripRear.colOut); 
         FrontCol.colIn =   ((index)*PERCENTAGE *StripFront.colIn)  +  ((PARTICLESSIZE- index)*PERCENTAGE *StripFront.colOut); 
         FrontCol.colOut =   ((p)*PERCENTAGE *StripFront.colIn)  +  ((PARTICLESSIZE-p)*PERCENTAGE *StripFront.colOut); 
         
      //TODO Delete Me
       RearCol.colIn  = Red;
       RearCol.colOut = Blue;
       
         FrontCol.colIn= Red;
         FrontCol.colOut = Blue;
      //TODO Delete Me 

       
             accumulatedColour = accumulatedColour +  AddDraw(FrontCol, RearCol, Particles[p].Pos, Particles[p-1].Pos, Particles[p].lastPos, Particles[p-1].lastPos, Pos, int( float(float(p)/float(PARTICLESSIZE)* GRADIENT_SIZE)));  
          
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


