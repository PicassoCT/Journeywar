
local featureDef  =  {
   name           = "exconroach",
   blocking       = false,
   category       = "jCorpse",
   damage            = 3000,
   description       = "it used to work",
   energy            = 12,
   flammable         = true,
   footprintX        = 2,
   footprintZ        = 2,
   upright           = false,
   height            = "6",
   hitdensity        = "5",
	smokeTime =15,
   object            = "features/featureObj/jconroachfeature.s3o",
   reclaimable       = true,
   resurrectable  =0,
   nodrawundergray  = true,
   autoreclaimable      = true,

}
return lowerkeys({[featureDef.name] = featureDef})
