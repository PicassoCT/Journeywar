 /*
 This takes a quadrupple of points, and warps it by the factors encoded into the factors
 a..h. This allows to stretch any rectangular image to any proportions.
 This allows us to avoid the distorted colourstretching effects the shader shows so far.
 We assume with uv the originally coordinates a perfect rectangular square and will solve this
 0 0	pNewIn	x0	y0
 1 0	pNewOut	x1	y1
 1 1	pOldOut	x2	y2
 0 1	pOldIn 	x3	y3

 
 */
  mat16 computateTransformationMatrice(
				vec2 pNewOut, 
				vec2 pNewIn, 
				vec2 pOldOut, 
				vec2 pOldIn){
					
	float a, b, c, d, e , f , g, h;	
	//These are multiplication factors	
	
					
	

		return mat16( 	0 ,0 ,c ,0 ,/**/ 0 , 0, 0				, 0,                | pNewIn.x
						a, 0, c ,0 ,/**/ 0 , 0, -1*pNewOut.x*g	, 0,                | pNewOut.x
						a, b, c,0 ,/**/  0 , 0, -1*pOldOut.x*g	, -1*pOldOut.x*h,   | pOldOut.x
						0, b, c,0 ,/**/  0 , 0,  0				,  -1*pOldIn.x*h,   | pOldIn.x
						                                                            |
						0, 0, 0, 0, /**/ 0 , f,0				,0				    | pNewIn.y 
						0, 0, 0, d, /**/ 0 , f, -1*pNewOut.y*g , 0                  | pNewOut.y
						0, 0, 0, d, /**/ e , f, -1*pOldOut.y*g	,-1*pOldOut.y*h     | pOldOut.y
						0, 0, 0, 0, /**/ e , f, 0              , -1*pOldIn.y*h		| pOldIn.y
					)
				
	  /*
	  c 										 = pNewIn.x
	  a+ c  -1*pNewOut.x*g 						 = pNewOut.x
	  a+b+c+  -1*pOldOut.x*g	+ -1*pOldOut.x*h = pOldOut.x
	  b+ c +  -1*pOldIn.x*h 					 =pOldIn.x
	  
	  */
	  
	  
  }

  //precompute the matrice
  

  vec4 AddDraw(	colSampler qFrontCol,d
				colSampler qRearCol, 
				vec2 pNewOut, 
				vec2 pNewIn, 
				vec2 pOldOut, 
				vec2 pOldIn, 
				vec2 pPixel, 
				mat16 transformationMatrice,
				int gradIndex)
   { 
		float distTopNewOut = distance(pPixel,pNewOut);
		float distTopNewIn = distance(pPixel,pNewIn);
		float distTopOldOut = distance(pPixel,pOldOut);
		float distTopOldIn = distance(pPixel,pOldIn);
		float distTotal= distTopNewOut + distTopNewIn + distTopOldOut + distTopOldIn;d
		
   
		//matrice proportionieren
		
		//einmultiplizieren
		
		//anwenden
		
		//punkt auf dem Gradienten bestimmen
		
		//evaluiertes resultat zeichnen
   }

 