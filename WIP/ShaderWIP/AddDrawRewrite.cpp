
  mat16 computateTransformationMatrice(
				vec2 pNewOut, 
				vec2 pNewIn, 
				vec2 pOldOut, 
				vec2 pOldIn){
					
	float a, b, c, d, e , f , g, h;	
		
	
					
	

		return mat16( 	x, , , ,
						x, , , ,
						x, , , ,
						x, , , ,
					)
				
	  
	  
	  
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

 