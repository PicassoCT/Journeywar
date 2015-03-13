
local featureDef  =  {
   name           = "honeypot",
   blocking       = false,
   category       = "jCorpse",
   damage            = 100,
   description       = "he came, went and blew",
   energy            = 12,
   flammable         = true,
   footprintX        = 2,
   footprintZ        = 2,
   upright           = false,
   height            = "6",
   hitdensity        = "5",
	smokeTime =15,
   object            = "features/featureObj/jhoneypotfeature.s3o",
   reclaimable       = true,
   resurrectable  =0,
   nodrawundergray  = true,
   autoreclaimable      = true,

}
return lowerkeys({[featureDef.name] = featureDef})
