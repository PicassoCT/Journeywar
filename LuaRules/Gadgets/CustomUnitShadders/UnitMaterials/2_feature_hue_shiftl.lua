-- $Id$
--FeatureShadder
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local materials = {
	hueShadedFeature = {
		shaderDefinitions = {
			"#define use_perspective_correct_shadows",
			"#define use_featureHueShift"
			--"#define tex1Alpha",
		},
		shader    = include(GADGET_DIR .. "featureMaterials/Shaders/feature_default.lua"),
		usecamera = false,
		culling   = GL.BACK,
		predl  = nil,
		postdl = nil,
		texunits  = {
			[0] = '%%UNITDEFID:0',
			[1] = '%%UNITDEFID:1',
			[2] = '$shadow',
			[3] = '$specular',
			[4] = '$reflection',
		},
	},
	hueShadedFeatureFlipped = {
		shaderDefinitions = {
			"#define use_perspective_correct_shadows",
		},
		shader    = include("featureMaterials/Shaders/feature_default.lua"),
		usecamera = false,
		culling   = GL.BACK,
		predl  = nil,
		postdl = nil,
		texunits  = {
			[0] = '%%UNITDEFID:0',
			[1] = '%%UNITDEFID:1',
			[2] = '$shadow',
			[3] = '$specular',
			[4] = '$reflection',
		},
		DrawFeature=DrawFeature,
		FeatureCreated=FeatureCreated
	},
}

	mapinfo= VFS.Include('Map/MapInfo.lua', nil, VFSMODE)	
	--if not mapinfo.FeatureHueOffSet then    widgetHandler:RemoveWidget() end
		
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- no additional texture needed for this one
return materials, mapinfo.FeatureHueOffSet or {}

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
