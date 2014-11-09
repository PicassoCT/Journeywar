
local featureDef  =  {
   name           = "lavafeature",
   blocking       = true,
   category       = "gCorpse",
   damage            = 3000,
   description       = "Cooled out Lava",
   energy            = 12,
   flammable         = false,
   footprintX        = 2,
   footprintZ        = 2,
   upright           = false,
   height            = "6",
   hitdensity        = "5",
	smokeTime =1800,
   object            = "features/featureObj/lavafeature.s3o",
   reclaimable       = true,
   resurrectable  =false,
   nodrawundergray  = true,
   autoreclaimable      = true,  

}
return lowerkeys({[featureDef.name] = featureDef})
