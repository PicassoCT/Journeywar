
local featureDef  =  {
   name           = "test_glowplantfeature",
   blocking       = false,
   category       = "GCORPSE",
   damage            = 3000,
   description       = "Shader Test Plants",
   energy            = 12,
   flammable         = true,
   footprintX        = 1,
   footprintZ        = 1,
   upright           = false,
   height            = "6",
   hitdensity        = "5",
	smokeTime =0,
   object            = "features/featureObj/glowPlants.s3o",
   reclaimable       = false,
   resurrectable  =0,
   nodrawundergray  = true,
   autoreclaimable      = false,  

}
return lowerkeys({[featureDef.name] = featureDef})
