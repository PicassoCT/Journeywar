-- $Id$
--FeatureShadder
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local materials = {
	groundTexShadedFeature = {
	  shaderDefinitions = {
         "#define use_perspective_correct_shadows",

       },
		shaderPlugins = {
        VERTEX_PRE_TRANSFORM = [[
				In Lua GL:
			1) Bind mapDiffuse texture to the shader.
			2) Pass the rendered feature's world position in an uniform.

			//In vertex shader:
			//3) calculate vertex world position based on vertex local position and feature world-position uniform
			//4) adjust texture coordinates of the vertex on the mapDiffuse texture to match vertex's world position

	
		]],
		 FRAGMENT_PRE_SHADING = [[
		 	//In fragment shader (or somewhere else?)
			//5) Blend between mapDiffuse and unitDiffuse based on the loaded blend texture .
		 ]]

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
			[5] = '$blend_channel',
		},
	},
	
	groundTexShadedFeatureFlipped = {
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
			[5] = '$blend_channel'
		},
	},
}


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

return materials 

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
