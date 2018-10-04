
local featureDef  =  {
   name           = "jbiocorpse",
   blocking       = false,
   category       = "JCORPSE",
   damage            = 3000,
   description       = "M.I.A.",
   energy            = 12,
   flammable         = true,
   footprintX        = 1,
   footprintZ        = 1,
   upright           = false,
   height            = "6",
   hitdensity        = "5",
	smokeTime =0,
   object            = "features/featureObj/jcorpse.s3o",
   reclaimable       = false,
   resurrectable  =1,
   nodrawundergray  = false,
   autoreclaimable      = false,  

}
return lowerkeys({[featureDef.name] = featureDef})
