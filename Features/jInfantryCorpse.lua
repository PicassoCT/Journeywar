
local featureDef  =  {
   name           = "jInfantryCorpse",
   blocking       = false,
   category       = "JCORPSE",
   damage            = 3000,
   description       = "Not dead yet, just dropping a meal for the next wave.",
   energy            = 12,
   flammable         = true,
   footprintX        = 1,
   footprintZ        = 1,
   upright           = false,
   height            = "6",
   hitdensity        = "5",
	smokeTime =0,
   object            = "features/featureObj/placeholder.s3o",
   reclaimable       = false,
   resurrectable  =1,
   nodrawundergray  = true,
   autoreclaimable      = false,  

}
return lowerkeys({[featureDef.name] = featureDef})
