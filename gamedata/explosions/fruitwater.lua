-- redlight

return {
  ["fruitwater"] = {
    glows = {
      air                = true,
      class              = [[heatcloud]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        heat               = 2,
        heatfalloff        = 0.1,
        maxheat            = 2,
        pos                = [[0,0,0]],
        size               = [[1 r1]],
        sizegrowth         = [[0.1]],
		dir				   =[[0, -1, 0]],
        speed              = [[0, 0.1, 0]],
        texture            = [[laserendorange]],
	  },
	  	usairlos=true,
	
    },
  }

}

