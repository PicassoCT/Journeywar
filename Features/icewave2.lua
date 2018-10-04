
local featureDef  =  {
   name           = "icewave2",
   blocking       = false,
   category       = "CCORPSE",
   damage            = 3000,
   description       = "Crystalized-Carbonglacier",
   energy            = 12,
   flammable         = true,
   footprintX        = 1,
   footprintZ        = 1,
   upright           = false,
   height            = "6",
   hitdensity        = "5",
	smokeTime =0,
   object            = "features/featureObj/icewave2.s3o",
   reclaimable       = false,
   resurrectable  =1,
   nodrawundergray  = false,
   autoreclaimable      = false,  

}
return lowerkeys({[featureDef.name] = featureDef})
