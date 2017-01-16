-- missile_explosion

return {
  ["jghostdancerswitch"] = {

  
    bitmapmuzzleflame = {
          air                = true,
          class              = [[CBitmapMuzzleFlame]],
          count              = 1,
          ground             = true,
          underwater         = 1,
          water              = true,
          properties = {
            colormap           = [[  0.5 0.5 1 1    0 0.9 0.9  0.8   0 0.9 0.9 0.8 ]],
            dir                = [[dir]],
            frontoffset        = 10,
            fronttexture       = [[smokeSmall]],--redexplo
            length             = -45,
            sidetexture        = [[ptree]],
            size               = 12,
            sizegrowth         = -0.8,
            ttl                =20,
          },
        },
		
		
		    bitmapmuzzleflame2 = {
          air                = true,
          class              = [[CBitmapMuzzleFlame]],
          count              = 1,
          ground             = true,
          underwater         = 1,
          water              = true,
          properties = {
            colormap           = [[  0.5 0.5 1 1    0 0.9 0.9  0.8   0 0.9 0.9 0.8 ]],
            dir                = [[dir]],
            frontoffset        = 0,
            fronttexture       = [[smokeSmall]],--redexplo
            length             = 25,
            sidetexture        = [[ptree]],
            size               = 9,
            sizegrowth         = 0.8,
            ttl                =20,
          },
        },		 

		tend = {
          air                = true,
          class              = [[CBitmapMuzzleFlame]],
          count              = 1,
          ground             = true,
          underwater         = 1,
          water              = true,
          properties = {
            colormap           = [[  0.05 0.05 0.05 0.5 0.05 0.05 0.05 0.5  0.05 0.05 0.05 0.5]],
            dir                = [[dir]],
            frontoffset        = 0,
            fronttexture       = [[smokeSmall]],--redexplo
            length             = 25,
            sidetexture        = [[TenderTendrils]],
            size               = 9,
            sizegrowth         = 1.95,
            ttl                =20,
          },
        },	
		
		backtend = {
          air                = true,
          class              = [[CBitmapMuzzleFlame]],
          count              = 1,
          ground             = true,
          underwater         = 1,
          water              = true,
          properties = {
            colormap           = [[  0.2 0.2 0.2 0.5 0.2 0.2 0.2 0.5  0.2 0.2 0.2 0.5]],
            dir                = [[dir]],
            frontoffset        = 0,
            fronttexture       = [[smokeSmall]],--redexplo
            length             = -42,
            sidetexture        = [[TenderTendrils]],
            size               = 9,
            sizegrowth         = -0.95,
            ttl                =20,
          },
        },
		
		
		    tendrils = {
          air                = true,
          class              = [[CBitmapMuzzleFlame]],
          count              = 4,
          ground             = true,
          underwater         = 1,
          water              = true,
          properties = {
            colormap           = [[  0.01 0.01 0.01 0.5 0.01 0.01 0.01 0.5  0.01 0.01 0.01 0.5]],
            dir                = [[0r-1r1,0.1r-0.9r0.9,0r-1r1]],
            frontoffset        = 0,
            fronttexture       = [[smokeSmall]],--redexplo
            length             = 35,
            sidetexture        = [[TenderTendrils]],
            size               = 10,
            sizegrowth         = -3.15,
            ttl                =20,
          },
        },
		
		tendrils = {
          air                = true,
          class              = [[CBitmapMuzzleFlame]],
          count              = 4,
          ground             = true,
          underwater         = 1,
          water              = true,
          properties = {
            colormap           = [[  0.01 0.01 0.01 0.5 0.01 0.01 0.01 0.5  0.01 0.01 0.01 0.5]],
            dir                = [[0r-1r1,0.1r-0.9r0.9,0r-1r1]],
            frontoffset        = 0,
            fronttexture       = [[smokeSmall]],--redexplo
            length             = -35,
            sidetexture        = [[TenderTendrils]],
            size               = 5,
            sizegrowth         = 0.55,
            ttl                =20,
          },
        },
		
		
		    spikes = {
          air                = true,
          class              = [[CBitmapMuzzleFlame]],
          count              = 3,
          ground             = true,
          underwater         = 1,
          water              = true,
          properties = {
            colormap           = [[  0.01 0.01 0.01 1 0.01 0.01 0.01 1  0.01 0.01 0.01 1]],
            dir                = [[0r-1r1,0.1r-0.9r0.9,0r-1r1]],
            frontoffset        = 0,
            fronttexture       = [[smokeSmall]],--redexplo
            length             = 45,
            sidetexture        = [[shard]],
            size               = 10,
            sizegrowth         = 0.15,
            ttl                = 15,
          },
        },   
			sspikes = {
          air                = true,
          class              = [[CBitmapMuzzleFlame]],
          count              = 3,
          ground             = true,
          underwater         = 1,
          water              = true,
          properties = {
            colormap           = [[  0.01 0.01 0.01 1 0.01 0.01 0.01 1  0.01 0.01 0.01 1]],
            dir                = [[0r-1r1,0.1r-0.9r0.9,0r-1r1]],
            frontoffset        = 0,
            fronttexture       = [[smokeSmall]],--redexplo
            length             = -42,
            sidetexture        = [[shard]],
            size               = 12,
            sizegrowth         = -0.15,
            ttl                = 15,
          },
        },
		
		pinkstripe = {
    

      air                = true,
      class              = [[CBitmapMuzzleFlame]],
      count              = 1,
      ground             = true,
      underwater         = false,
      water              = true,
      properties = { 
        colormap           = [[0.5 0.5 1  0.01  	 0 0.9 0.9 0.01 	 0 0.9 0.9 0.01    0 0.9 0.9 0.01 	]],
        dir                = [[dir]],
        frontoffset        = 0,
        fronttexture       = [[empty]],
        length             = -82,
        sidetexture        = [[citdronegrad]],
        size               = -3,
        sizegrowth         = 0.18,
        ttl                = 24,
      }
    },
   
		pinkstripe2 = {
    

      air                = true,
      class              = [[CBitmapMuzzleFlame]],
      count              = 1,
      ground             = true,
      underwater         = false,
      water              = true,
      properties = {
        colormap           = [[0.5 0.5 1  0.01  	 0 0.9 0.9 0.01 	 0 0.9 0.9 0.01    0 0.9 0.9 0.01 	]],
        dir                = [[dir]],
        frontoffset        = 0,
        fronttexture       = [[empty]],
        length             = 45,
        sidetexture        = [[citdronegrad]],
        size               = -3,
        sizegrowth         = 1.18,
        ttl                = 24,
      }
    },	

		
   
		
	 

  },

}

