-- $Id$
--FeatureShadder
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local materials = {
	hueShadedFeature = {
		shaderDefinitions = {
			"#define use_perspective_correct_shadows",

			--"#define tex1Alpha",
		},
		shaderPlugins = {
        
        FRAGMENT_PRE_SHADING = [[
		
		
		uniform sampler2DRect texture;
		const mat3 rgb2yiq = mat3(0.299, 0.587, 0.114, 0.595716, -0.274453, -0.321263, 0.211456, -0.522591, 0.311135);
		const mat3 yiq2rgb = mat3(1.0, 0.9563, 0.6210, 1.0, -0.2721, -0.6474, 1.0, -1.1070, 1.7046);
		uniform float hue;
	
	
		vec3 yColor = rgb2yiq * texture2DRect(texture, gl_TexCoord[0].st).rgb; 
	
		float originalHue = atan(yColor.b, yColor.g);
		float finalHue = originalHue + hue;
	
		float chroma = sqrt(yColor.b*yColor.b+yColor.g*yColor.g);
	
		vec3 yFinalColor = vec3(yColor.r, chroma * cos(finalHue), chroma * sin(finalHue));
		gl_FragColor    = vec4(yiq2rgb*yFinalColor, 1.0);

		
		
        ]],
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
	},
}


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

return materials 

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
