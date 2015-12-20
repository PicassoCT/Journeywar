-- $Id$
--FeatureShadder
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local materials = {
	hueShadedFeature = {
	  shaderDefinitions = {
         "#define use_perspective_correct_shadows",

       },
		shaderPlugins = {
        VERTEX_PRE_TRANSFORM = [[
		
		]],
        FRAGMENT_GLOBAL_NAMESPACE = [[precision highp float;
uniform float time;
uniform vec2 resolution;
varying vec3 fPosition;
varying vec3 tPosition;
varying vec3 fNormal;
float hueShiftOffset;

vec3 sum(vec3 val)
{
float sumMid=sqrt(abs(val.x+val.y+val.z));
return vec3(sumMid,sumMid,sumMid);
}


float g_percent;
float r_percent;
vec3 applyOriginalColour()
{
vec3 LeaveGreenTop=vec3(0.5,0.98,0.26);

vec3 GroundStem=vec3(0.71,0.48,0.26);


g_percent= 1.0-abs(sin(max(tPosition.y,0.0)));
r_percent=1.0-g_percent;
return mix(LeaveGreenTop,GroundStem,g_percent);
}

vec3 convertRGBtoHSV(vec3 rgbColor) {
float r = rgbColor[0];
float g = rgbColor[1];
float b = rgbColor[2];
float colorMax = max(max(r,g), b);
float colorMin = min(min(r,g), b);
float delta = colorMax - colorMin;
float h = 0.0;
float s = 0.0;
float v = colorMax;
vec3 hsv = vec3(0.0);
if (colorMax != 0.0) {
s = (colorMax - colorMin ) / colorMax;
}
if (delta != 0.0) {
if (r == colorMax) {
h = (g - b) / delta;
} else if (g == colorMax) {
h = 2.0 + (b - r) / delta;
} else {
h = 4.0 + (r - g) / delta;
}
h *= 60.0;
if (h < 0.0) {
h += 360.0;
}
}
hsv[0] = h;
hsv[1] = s;
hsv[2] = v;
return hsv;
}

vec3 convertHSVtoRGB(vec3 hsvColor) {
float h = hsvColor.x;
float s = hsvColor.y;
float v = hsvColor.z;
if (s == 0.0) {
return vec3(v, v, v);
}
if (h == 360.0) {
h = 0.0;
}
int hi = int(h);
float f = h - float(hi);
float p = v * (1.0 - s);
float q = v * (1.0 - (s * f));
float t = v * (1.0 - (s * (1.0 - f)));
vec3 rgb;
if (hi == 0) {
rgb = vec3(v, t, p);
} else if (hi == 1) {
rgb = vec3(q, v, p);
} else if (hi == 2) {
rgb = vec3(p, v, t);
} if(hi == 3) {
rgb = vec3(p, q, v);
} else if (hi == 4) {
rgb = vec3(t, p, v);
} else {
rgb = vec3(v, p, q);
}
return rgb;
}
	]],
		
		FRAGMENT_PRE_SHADING = [[	
float hueShiftOffset=sin(time*10.0);
//filter out by height
vec3 hueShiftMapValue= vec3(0.3,1.0*hueShiftOffset,0.5);

vec3 vHSV= vec3(0.3*hueShiftOffset,1.0*hueShiftOffset,0.5*hueShiftOffset);

vec3 fragRGB = (applyOriginalColour()) ;


vec3 fragHSV = convertRGBtoHSV(vec3(0.001,0.0001,0.0000)*cos(time));
fragHSV -= vHSV;
fragHSV.x = mod(fragHSV.x, 360.0);
fragHSV.y = mod(fragHSV.y, 1.0);
fragHSV.z = mod(fragHSV.z, 1.0);
fragRGB = fragRGB*r_percent + convertHSVtoRGB(fragHSV)*g_percent;


fragRGB = fragRGB/sum(1.0 - normalize(fNormal));


gl_FragColor = vec4(fragRGB, 1.0);
		
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
