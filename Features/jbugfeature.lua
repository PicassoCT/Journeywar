
local featureDef  =  {
   name           = "bug",
   blocking       = false,
   category       = "JCORPSE",
   damage            = 3000,
   description       = " it was, a bug its no more, its a feature",
   energy            = 12,
   flammable         = true,
   footprintX        = 1,
   footprintZ        = 1,
   upright           = false,
   height            = "6",
   hitdensity        = "5",
	smokeTime =25,
   object            = "features/featureObj/jbugfeature.s3o",
   reclaimable       = true,
   resurrectable  =0,
   nodrawundergray  = true,
   autoreclaimable      = true,

}
return lowerkeys({[featureDef.name] = featureDef})
