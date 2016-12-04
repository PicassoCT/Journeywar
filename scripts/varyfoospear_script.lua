include "createCorpse.lua"
include "lib_OS.lua"
 include "lib_UnitScript.lua" 
include "lib_Animation.lua"

 include "lib_Build.lua" 


function script.HitByWeapon ( x, z, weaponDefID, damage ) 
end
center=piece"center"

Animations={}
local animCmd = {['turn']=Turn,['move']=Move};
	Animations['walk'] = {
	{


		['time'] = 1,
		['commands'] = {
			{['c']='turn',['p']=LegUL, ['a']=x_axis, ['t']=0.066902, ['s']=0.200707},
			{['c']='turn',['p']=LegUL, ['a']=z_axis, ['t']=0.287421, ['s']=0.862262},
			{['c']='turn',['p']=LegUL, ['a']=y_axis, ['t']=-1*-2.743958, ['s']=1.192905},
			{['c']='turn',['p']=LegLU, ['a']=x_axis, ['t']=-0.024598, ['s']=0.073795},
			{['c']='turn',['p']=LegLU, ['a']=z_axis, ['t']=-0.011629, ['s']=0.034888},
			{['c']='turn',['p']=LegLU, ['a']=y_axis, ['t']=-1*-3.898080, ['s']=2.269462},
			{['c']='turn',['p']=Kreis02, ['a']=x_axis, ['t']=0.004295, ['s']=0.006781},
			{['c']='turn',['p']=Kreis02, ['a']=z_axis, ['t']=-0.067655, ['s']=0.106823},
			{['c']='turn',['p']=Kreis02, ['a']=y_axis, ['t']=-1*-3.170332, ['s']=0.045377},
			{['c']='turn',['p']=UpperJaw, ['a']=x_axis, ['t']=0.000000, ['s']=0.000000},
			{['c']='turn',['p']=UpperJaw, ['a']=z_axis, ['t']=-0.000000, ['s']=0.000000},
			{['c']='turn',['p']=LegUU, ['a']=x_axis, ['t']=-1.140458, ['s']=3.421374},
			{['c']='turn',['p']=LegUU, ['a']=z_axis, ['t']=-0.016751, ['s']=0.050253},
			{['c']='turn',['p']=LegUU, ['a']=y_axis, ['t']=-1*-5.141648, ['s']=6.000165},
			 
			 
			 
			{['c']='turn',['p']=LegUL01, ['a']=x_axis, ['t']=-0.060187, ['s']=0.180562},
			{['c']='turn',['p']=LegUL01, ['a']=z_axis, ['t']=0.243041, ['s']=0.729124},
			{['c']='turn',['p']=LegUL01, ['a']=y_axis, ['t']=-1*-3.478970, ['s']=1.012133},
			{['c']='turn',['p']=LegLL01, ['a']=x_axis, ['t']=-0.638258, ['s']=1.914774},
			{['c']='turn',['p']=LegLL01, ['a']=z_axis, ['t']=0.558237, ['s']=1.674712},
			{['c']='turn',['p']=LegLL01, ['a']=y_axis, ['t']=-1*-3.309543, ['s']=0.503851},
			{['c']='turn',['p']=LegLU01, ['a']=x_axis, ['t']=0.021893, ['s']=0.065680},
			{['c']='turn',['p']=LegLU01, ['a']=z_axis, ['t']=-0.005549, ['s']=0.016647},
			{['c']='turn',['p']=LegLU01, ['a']=y_axis, ['t']=-1*-2.518434, ['s']=1.869477},
			{['c']='turn',['p']=LegUU01, ['a']=x_axis, ['t']=0.492988, ['s']=1.478964},
			{['c']='turn',['p']=LegUU01, ['a']=z_axis, ['t']=0.023457, ['s']=0.070371},
			{['c']='turn',['p']=LegUU01, ['a']=y_axis, ['t']=-1*-0.908746, ['s']=6.698540},
			 
			 
			 
			{['c']='turn',['p']=LegLL, ['a']=x_axis, ['t']=0.473665, ['s']=1.420994},
			{['c']='turn',['p']=LegLL, ['a']=z_axis, ['t']=0.589191, ['s']=1.767572},
			{['c']='turn',['p']=LegLL, ['a']=y_axis, ['t']=-1*-3.013098, ['s']=0.385485},
			{['c']='turn',['p']=LowerJaw, ['a']=x_axis, ['t']=0.000000, ['s']=0.000000},
			{['c']='turn',['p']=LowerJaw, ['a']=z_axis, ['t']=-0.000000, ['s']=0.000000},
		}
	},
	{
		['time'] = 11,
		['commands'] = {
			{['c']='turn',['p']=LegUL, ['a']=x_axis, ['t']=0.567134, ['s']=1.667439},
			{['c']='turn',['p']=LegUL, ['a']=z_axis, ['t']=0.721728, ['s']=1.447691},
			{['c']='turn',['p']=LegUL, ['a']=y_axis, ['t']=-1*-3.311061, ['s']=1.890343},
			{['c']='turn',['p']=LegLU, ['a']=x_axis, ['t']=0.110691, ['s']=0.450965},
			{['c']='turn',['p']=LegLU, ['a']=z_axis, ['t']=-0.299911, ['s']=0.960938},
			{['c']='turn',['p']=LegLU, ['a']=y_axis, ['t']=-1*-4.998260, ['s']=3.667265},
			{['c']='turn',['p']=LegUL01, ['a']=x_axis, ['t']=-1.259300, ['s']=3.997041},
			{['c']='turn',['p']=LegUL01, ['a']=z_axis, ['t']=0.378080, ['s']=0.450130},
			{['c']='turn',['p']=LegUL01, ['a']=y_axis, ['t']=-1*-3.162030, ['s']=1.056466},
			{['c']='turn',['p']=LegUU, ['a']=x_axis, ['t']=-0.051387, ['s']=3.630238},
			{['c']='turn',['p']=LegUU, ['a']=z_axis, ['t']=-0.028889, ['s']=0.040460},
			{['c']='turn',['p']=LegUU, ['a']=y_axis, ['t']=-1*-4.039178, ['s']=3.674900},
			 
			 
			 
			{['c']='turn',['p']=LegLL01, ['a']=x_axis, ['t']=-0.000000, ['s']=2.127527},
			{['c']='turn',['p']=LegLL01, ['a']=z_axis, ['t']=-0.000000, ['s']=1.860791},
			{['c']='turn',['p']=LegLL01, ['a']=y_axis, ['t']=-1*-3.141593, ['s']=0.559835},
			{['c']='turn',['p']=LegLU01, ['a']=x_axis, ['t']=0.340208, ['s']=1.061050},
			{['c']='turn',['p']=LegLU01, ['a']=z_axis, ['t']=-0.006957, ['s']=0.004693},
			{['c']='turn',['p']=LegLU01, ['a']=y_axis, ['t']=-1*-1.113250, ['s']=4.683945},
			{['c']='turn',['p']=LegUU01, ['a']=x_axis, ['t']=0.050725, ['s']=1.474210},
			{['c']='turn',['p']=LegUU01, ['a']=z_axis, ['t']=-0.018216, ['s']=0.138910},
			{['c']='turn',['p']=LegUU01, ['a']=y_axis, ['t']=-1*-2.325583, ['s']=4.722789},
			 
			 
			 
			{['c']='turn',['p']=LegLL, ['a']=x_axis, ['t']=-0.000000, ['s']=1.578882},
			{['c']='turn',['p']=LegLL, ['a']=z_axis, ['t']=0.000000, ['s']=1.963968},
			{['c']='turn',['p']=LegLL, ['a']=y_axis, ['t']=-1*-3.141593, ['s']=0.428317},
		}
	},
	{
		['time'] = 20,
		['commands'] = {
			{['c']='turn',['p']=LegUL, ['a']=x_axis, ['t']=0.000000, ['s']=2.430575},
			{['c']='turn',['p']=LegUL, ['a']=z_axis, ['t']=0.000000, ['s']=3.093120},
			{['c']='turn',['p']=LegUL, ['a']=y_axis, ['t']=-1*-3.141593, ['s']=0.726291},
			{['c']='turn',['p']=LegLU, ['a']=x_axis, ['t']=0.000000, ['s']=0.474391},
			{['c']='turn',['p']=LegLU, ['a']=z_axis, ['t']=-0.000000, ['s']=1.285332},
			{['c']='turn',['p']=LegLU, ['a']=y_axis, ['t']=-1*-3.141593, ['s']=7.957143},
			{['c']='turn',['p']=Kreis02, ['a']=x_axis, ['t']=0.002853, ['s']=0.006179},
			{['c']='turn',['p']=Kreis02, ['a']=z_axis, ['t']=-0.037663, ['s']=0.128538},
			{['c']='turn',['p']=Kreis02, ['a']=y_axis, ['t']=-1*-3.157657, ['s']=0.054320},
			{['c']='turn',['p']=UpperJaw, ['a']=x_axis, ['t']=0.000000, ['s']=0.000000},
			{['c']='turn',['p']=UpperJaw, ['a']=z_axis, ['t']=-0.000000, ['s']=0.000000},
			{['c']='turn',['p']=LegUU, ['a']=x_axis, ['t']=0.000000, ['s']=0.220229},
			{['c']='turn',['p']=LegUU, ['a']=z_axis, ['t']=-0.000000, ['s']=0.123810},
			{['c']='turn',['p']=LegUU, ['a']=y_axis, ['t']=-1*-3.141593, ['s']=3.846794},
			{['c']='turn',['p']=LegUL01, ['a']=x_axis, ['t']=0.000000, ['s']=5.396998},
			{['c']='turn',['p']=LegUL01, ['a']=z_axis, ['t']=0.000000, ['s']=1.620344},
			{['c']='turn',['p']=LegUL01, ['a']=y_axis, ['t']=-1*-3.141593, ['s']=0.087590},
			{['c']='turn',['p']=LegLL01, ['a']=x_axis, ['t']=-0.000000, ['s']=0.000000},
			{['c']='turn',['p']=LegLL01, ['a']=z_axis, ['t']=-0.000000, ['s']=0.000000},
			{['c']='turn',['p']=LegLU01, ['a']=x_axis, ['t']=-0.000000, ['s']=1.458035},
			{['c']='turn',['p']=LegLU01, ['a']=z_axis, ['t']=-0.000000, ['s']=0.029815},
			{['c']='turn',['p']=LegLU01, ['a']=y_axis, ['t']=-1*-3.141593, ['s']=8.692896},
			{['c']='turn',['p']=LegUU01, ['a']=x_axis, ['t']=-0.000000, ['s']=0.217394},
			{['c']='turn',['p']=LegUU01, ['a']=z_axis, ['t']=-0.000000, ['s']=0.078068},
			{['c']='turn',['p']=LegUU01, ['a']=y_axis, ['t']=-1*-3.141593, ['s']=3.497187},
			{['c']='turn',['p']=LegLL, ['a']=x_axis, ['t']=-0.000000, ['s']=0.000000},
			{['c']='turn',['p']=LegLL, ['a']=z_axis, ['t']=-0.000000, ['s']=0.000000},
			{['c']='turn',['p']=LowerJaw, ['a']=x_axis, ['t']=0.000004, ['s']=0.000016},
			{['c']='turn',['p']=LowerJaw, ['a']=z_axis, ['t']=-0.000059, ['s']=0.000254},
			{['c']='turn',['p']=LowerJaw, ['a']=y_axis, ['t']=-1*-3.141618, ['s']=0.000107},
		}
	},
	{
		['time'] = 27,
		['commands'] = {
			{['c']='turn',['p']=LegUL, ['a']=x_axis, ['t']=-0.000000, ['s']=0.000000},
			{['c']='turn',['p']=LegUL, ['a']=z_axis, ['t']=0.000000, ['s']=0.000000},
			{['c']='turn',['p']=LegUL, ['a']=y_axis, ['t']=-1*-3.141593, ['s']=0.000000},
			{['c']='turn',['p']=LegLU, ['a']=x_axis, ['t']=-0.000000, ['s']=0.000000},
			{['c']='turn',['p']=LegLU, ['a']=z_axis, ['t']=-0.000000, ['s']=0.000000},
			{['c']='turn',['p']=LegLU, ['a']=y_axis, ['t']=-1*-3.141593, ['s']=0.000000},
			{['c']='turn',['p']=Kreis02, ['a']=x_axis, ['t']=-0.002229, ['s']=0.010163},
			{['c']='turn',['p']=Kreis02, ['a']=z_axis, ['t']=0.068037, ['s']=0.211399},
			{['c']='turn',['p']=Kreis02, ['a']=y_axis, ['t']=-1*-3.112989, ['s']=0.089336},
			{['c']='turn',['p']=UpperJaw, ['a']=x_axis, ['t']=-0.000000, ['s']=0.000000},
			{['c']='turn',['p']=UpperJaw, ['a']=z_axis, ['t']=-0.000000, ['s']=0.000000},
			{['c']='turn',['p']=UpperJaw, ['a']=y_axis, ['t']=-1*-3.141593, ['s']=0.000000},
			 
			 
			 
			{['c']='turn',['p']=LegUU, ['a']=x_axis, ['t']=-0.000000, ['s']=0.000000},
			{['c']='turn',['p']=LegUU, ['a']=z_axis, ['t']=-0.000000, ['s']=0.000000},
			{['c']='turn',['p']=LegUU, ['a']=y_axis, ['t']=-1*-3.141593, ['s']=0.000000},
			{['c']='turn',['p']=LegUL01, ['a']=x_axis, ['t']=0.000000, ['s']=0.000000},
			{['c']='turn',['p']=LegUL01, ['a']=z_axis, ['t']=0.000000, ['s']=0.000000},
			{['c']='turn',['p']=LegUL01, ['a']=y_axis, ['t']=-1*-3.141593, ['s']=0.000000},
			{['c']='turn',['p']=LegLL01, ['a']=x_axis, ['t']=-0.000000, ['s']=0.000000},
			{['c']='turn',['p']=LegLL01, ['a']=z_axis, ['t']=-0.000000, ['s']=0.000000},
			{['c']='turn',['p']=LegLL01, ['a']=y_axis, ['t']=-1*-3.141593, ['s']=0.000000},
			{['c']='turn',['p']=LegLU01, ['a']=x_axis, ['t']=-0.000000, ['s']=0.000000},
			{['c']='turn',['p']=LegLU01, ['a']=z_axis, ['t']=-0.000000, ['s']=0.000000},
			{['c']='turn',['p']=LegLU01, ['a']=y_axis, ['t']=-1*-3.141593, ['s']=0.000000},
			 
			{['c']='turn',['p']=LegUU01, ['a']=x_axis, ['t']=-0.000000, ['s']=0.000000},
			{['c']='turn',['p']=LegUU01, ['a']=z_axis, ['t']=-0.000000, ['s']=0.000000},
			{['c']='turn',['p']=LegUU01, ['a']=y_axis, ['t']=-1*-3.141593, ['s']=0.000000},
			{['c']='turn',['p']=LegLL, ['a']=x_axis, ['t']=-0.000000, ['s']=0.000000},
			{['c']='turn',['p']=LegLL, ['a']=z_axis, ['t']=-0.000000, ['s']=0.000000},
			{['c']='turn',['p']=LegLL, ['a']=y_axis, ['t']=-1*-3.141593, ['s']=0.000000},
			{['c']='turn',['p']=LowerJaw, ['a']=x_axis, ['t']=-0.005176, ['s']=0.017265},
			{['c']='turn',['p']=LowerJaw, ['a']=z_axis, ['t']=-0.299837, ['s']=0.999258},
			{['c']='turn',['p']=LowerJaw, ['a']=y_axis, ['t']=-1*-3.141534, ['s']=0.000280},
		}
	},
	{
		['time'] = 36,
		['commands'] = {
			{['c']='turn',['p']=LowerJaw, ['a']=x_axis, ['t']=-0.004479, ['s']=0.001230},
			{['c']='turn',['p']=LowerJaw, ['a']=z_axis, ['t']=-0.015884, ['s']=0.501093},
			{['c']='turn',['p']=LowerJaw, ['a']=y_axis, ['t']=-1*-3.142831, ['s']=0.002290},
		}
	},
	{
		['time'] = 42,
		['commands'] = {
			{['c']='turn',['p']=Kreis02, ['a']=x_axis, ['t']=0.006918, ['s']=0.010553},
			{['c']='turn',['p']=Kreis02, ['a']=z_axis, ['t']=-0.095059, ['s']=0.188188},
			{['c']='turn',['p']=Kreis02, ['a']=y_axis, ['t']=-1*-3.182147, ['s']=0.079797},
		}
	},
	{
		['time'] = 53,
		['commands'] = {
			{['c']='turn',['p']=LowerJaw, ['a']=x_axis, ['t']=0.003503, ['s']=0.009578},
			{['c']='turn',['p']=LowerJaw, ['a']=z_axis, ['t']=-0.057148, ['s']=0.049517},
			{['c']='turn',['p']=LowerJaw, ['a']=y_axis, ['t']=-1*-3.165802, ['s']=0.027564},
			 
		}
	},
}

Animations['stand'] = {

	{
		['time'] = 3,
		['commands'] = {
			{['c']='turn',['p']=LegUL01, ['a']=x_axis, ['t']=2.478740, ['s']=0.334477},
			{['c']='turn',['p']=LegUL01, ['a']=z_axis, ['t']=1.146267, ['s']=0.292708},
			{['c']='turn',['p']=LegUL01, ['a']=y_axis, ['t']=-1*-1.608718, ['s']=0.075610},
			{['c']='turn',['p']=LegUL, ['a']=x_axis, ['t']=-2.363755, ['s']=0.103448},
			{['c']='turn',['p']=LegUL, ['a']=z_axis, ['t']=0.804168, ['s']=0.197747},
			{['c']='turn',['p']=LegUL, ['a']=y_axis, ['t']=-1*-4.229409, ['s']=0.165346},
			{['c']='turn',['p']=LegLU, ['a']=x_axis, ['t']=-0.542243, ['s']=0.000339},
			{['c']='turn',['p']=LegLU, ['a']=z_axis, ['t']=-0.435833, ['s']=0.001619},
			{['c']='turn',['p']=LegLU, ['a']=y_axis, ['t']=-1*-5.510730, ['s']=0.236287},
			{['c']='turn',['p']=LegUU, ['a']=x_axis, ['t']=0.572317, ['s']=0.001630},
			{['c']='turn',['p']=LegUU, ['a']=z_axis, ['t']=-0.484922, ['s']=0.000209},
			{['c']='turn',['p']=LegUU, ['a']=y_axis, ['t']=-1*-4.260499, ['s']=0.208215},
			{['c']='turn',['p']=LegLU01, ['a']=x_axis, ['t']=0.843504, ['s']=0.001580},
			{['c']='turn',['p']=LegLU01, ['a']=z_axis, ['t']=-0.303984, ['s']=0.000026},
			{['c']='turn',['p']=LegLU01, ['a']=y_axis, ['t']=-1*-0.795128, ['s']=0.216662},
			{['c']='turn',['p']=LegLL01, ['a']=x_axis, ['t']=1.831349, ['s']=0.019666},
			{['c']='turn',['p']=LegLL01, ['a']=z_axis, ['t']=0.821601, ['s']=0.122791},
			{['c']='turn',['p']=LegLL01, ['a']=y_axis, ['t']=-1*-2.339985, ['s']=0.140386},
			{['c']='turn',['p']=LegLL, ['a']=x_axis, ['t']=-2.667233, ['s']=0.089935},
			{['c']='turn',['p']=LegLL, ['a']=z_axis, ['t']=0.464374, ['s']=0.203297},
			{['c']='turn',['p']=LegLL, ['a']=y_axis, ['t']=-1*-3.863223, ['s']=0.147217},
			{['c']='turn',['p']=LegUU01, ['a']=x_axis, ['t']=-0.438968, ['s']=0.000527},
			{['c']='turn',['p']=LegUU01, ['a']=z_axis, ['t']=-0.625929, ['s']=0.002747},
			{['c']='turn',['p']=LegUU01, ['a']=y_axis, ['t']=-1*-2.158446, ['s']=0.400044},
		}
	},
	{
		['time'] = 26,
		['commands'] = {
			{['c']='turn',['p']=UpperJaw, ['a']=x_axis, ['t']=0.119934, ['s']=0.000738},
			{['c']='turn',['p']=UpperJaw, ['a']=z_axis, ['t']=0.058119, ['s']=0.230964},
			{['c']='turn',['p']=UpperJaw, ['a']=y_axis, ['t']=-1*-3.143838, ['s']=0.001173},
			{['c']='turn',['p']=LegLU, ['a']=x_axis, ['t']=-0.541676, ['s']=0.001134},
			{['c']='turn',['p']=LegLU, ['a']=z_axis, ['t']=-0.433799, ['s']=0.004067},
			{['c']='turn',['p']=LegLU, ['a']=y_axis, ['t']=-1*-5.209370, ['s']=0.602720},
			{['c']='turn',['p']=LegUU, ['a']=x_axis, ['t']=0.573054, ['s']=0.001475},
			{['c']='turn',['p']=LegUU, ['a']=z_axis, ['t']=-0.484806, ['s']=0.000232},
			{['c']='turn',['p']=LegUU, ['a']=y_axis, ['t']=-1*-4.165895, ['s']=0.189208},
			{['c']='turn',['p']=LegLU01, ['a']=x_axis, ['t']=0.845383, ['s']=0.003759},
			{['c']='turn',['p']=LegLU01, ['a']=z_axis, ['t']=-0.303933, ['s']=0.000104},
			{['c']='turn',['p']=LegLU01, ['a']=y_axis, ['t']=-1*-1.053387, ['s']=0.516519},
			{['c']='turn',['p']=LegUU01, ['a']=x_axis, ['t']=-0.438617, ['s']=0.000703},
			{['c']='turn',['p']=LegUU01, ['a']=z_axis, ['t']=-0.624585, ['s']=0.002688},
			{['c']='turn',['p']=LegUU01, ['a']=y_axis, ['t']=-1*-2.355743, ['s']=0.394595},
		}
	},
	{
		['time'] = 41,
		['commands'] = {
		}
	},
	{
		['time'] = 42,
		['commands'] = {
		}
	},
}

Animations['meinFuehrerIcanWalk'] = {
	{
		['time'] = 1,
		['commands'] = {
			{['c']='turn',['p']=LegUL, ['a']=x_axis, ['t']=0.066902, ['s']=0.200707},
			{['c']='turn',['p']=LegUL, ['a']=y_axis, ['t']=0.287421, ['s']=0.862262},
			{['c']='turn',['p']=LegUL, ['a']=z_axis, ['t']=-2.743958, ['s']=1.192905},
			{['c']='turn',['p']=LegLU, ['a']=x_axis, ['t']=-0.024598, ['s']=0.073795},
			{['c']='turn',['p']=LegLU, ['a']=y_axis, ['t']=-0.011629, ['s']=0.034888},
			{['c']='turn',['p']=LegLU, ['a']=z_axis, ['t']=-3.898080, ['s']=2.269462},
			{['c']='turn',['p']=Kreis02, ['a']=x_axis, ['t']=0.004295, ['s']=0.006781},
			{['c']='turn',['p']=Kreis02, ['a']=y_axis, ['t']=-0.067655, ['s']=0.106823},
			{['c']='turn',['p']=Kreis02, ['a']=z_axis, ['t']=-3.170332, ['s']=0.045377},
			{['c']='turn',['p']=UpperJaw, ['a']=x_axis, ['t']=0.000000, ['s']=0.000000},
			{['c']='turn',['p']=UpperJaw, ['a']=y_axis, ['t']=-0.000000, ['s']=0.000000},
			{['c']='turn',['p']=LegUU, ['a']=x_axis, ['t']=-1.140458, ['s']=3.421374},
			{['c']='turn',['p']=LegUU, ['a']=y_axis, ['t']=-0.016751, ['s']=0.050253},
			{['c']='turn',['p']=LegUU, ['a']=z_axis, ['t']=-5.141648, ['s']=6.000165},
			{['c']='move',['p']=LegUU, ['a']=x_axis, ['t']=5.865225, ['s']=0.052407},
			{['c']='move',['p']=LegUU, ['a']=y_axis, ['t']=0.020152, ['s']=0.000895},
			{['c']='move',['p']=LegUU, ['a']=z_axis, ['t']=0.001200, ['s']=0.043959},
			{['c']='turn',['p']=LegUL01, ['a']=x_axis, ['t']=-0.060187, ['s']=0.180562},
			{['c']='turn',['p']=LegUL01, ['a']=y_axis, ['t']=0.243041, ['s']=0.729124},
			{['c']='turn',['p']=LegUL01, ['a']=z_axis, ['t']=-3.478970, ['s']=1.012133},
			{['c']='turn',['p']=LegLL01, ['a']=x_axis, ['t']=-0.638258, ['s']=1.914774},
			{['c']='turn',['p']=LegLL01, ['a']=y_axis, ['t']=0.558237, ['s']=1.674712},
			{['c']='turn',['p']=LegLL01, ['a']=z_axis, ['t']=-3.309543, ['s']=0.503851},
			{['c']='turn',['p']=LegLU01, ['a']=x_axis, ['t']=0.021893, ['s']=0.065680},
			{['c']='turn',['p']=LegLU01, ['a']=y_axis, ['t']=-0.005549, ['s']=0.016647},
			{['c']='turn',['p']=LegLU01, ['a']=z_axis, ['t']=-2.518434, ['s']=1.869477},
			{['c']='turn',['p']=LegUU01, ['a']=x_axis, ['t']=0.492988, ['s']=1.478964},
			{['c']='turn',['p']=LegUU01, ['a']=y_axis, ['t']=0.023457, ['s']=0.070371},
			{['c']='turn',['p']=LegUU01, ['a']=z_axis, ['t']=-0.908746, ['s']=6.698540},
			{['c']='move',['p']=LegUU01, ['a']=x_axis, ['t']=5.853218, ['s']=0.052407},
			{['c']='move',['p']=LegUU01, ['a']=y_axis, ['t']=0.006188, ['s']=0.000895},
			{['c']='move',['p']=LegUU01, ['a']=z_axis, ['t']=-0.048884, ['s']=0.043960},
			{['c']='turn',['p']=LegLL, ['a']=x_axis, ['t']=0.473665, ['s']=1.420994},
			{['c']='turn',['p']=LegLL, ['a']=y_axis, ['t']=0.589191, ['s']=1.767572},
			{['c']='turn',['p']=LegLL, ['a']=z_axis, ['t']=-3.013098, ['s']=0.385485},
			{['c']='turn',['p']=LowerJaw, ['a']=x_axis, ['t']=0.000000, ['s']=0.000000},
			{['c']='turn',['p']=LowerJaw, ['a']=y_axis, ['t']=-0.000000, ['s']=0.000000},
		}
	},
	{
		['time'] = 11,
		['commands'] = {
			{['c']='turn',['p']=LegUL, ['a']=x_axis, ['t']=0.567134, ['s']=1.667439},
			{['c']='turn',['p']=LegUL, ['a']=y_axis, ['t']=0.721728, ['s']=1.447691},
			{['c']='turn',['p']=LegUL, ['a']=z_axis, ['t']=-3.311061, ['s']=1.890343},
			{['c']='turn',['p']=LegLU, ['a']=x_axis, ['t']=0.110691, ['s']=0.450965},
			{['c']='turn',['p']=LegLU, ['a']=y_axis, ['t']=-0.299911, ['s']=0.960938},
			{['c']='turn',['p']=LegLU, ['a']=z_axis, ['t']=-4.998260, ['s']=3.667265},
			{['c']='turn',['p']=LegUL01, ['a']=x_axis, ['t']=-1.259300, ['s']=3.997041},
			{['c']='turn',['p']=LegUL01, ['a']=y_axis, ['t']=0.378080, ['s']=0.450130},
			{['c']='turn',['p']=LegUL01, ['a']=z_axis, ['t']=-3.162030, ['s']=1.056466},
			{['c']='turn',['p']=LegUU, ['a']=x_axis, ['t']=-0.051387, ['s']=3.630238},
			{['c']='turn',['p']=LegUU, ['a']=y_axis, ['t']=-0.028889, ['s']=0.040460},
			{['c']='turn',['p']=LegUU, ['a']=z_axis, ['t']=-4.039178, ['s']=3.674900},
			{['c']='move',['p']=LegUU, ['a']=x_axis, ['t']=5.882694, ['s']=0.058230},
			{['c']='move',['p']=LegUU, ['a']=y_axis, ['t']=0.020450, ['s']=0.000994},
			{['c']='move',['p']=LegUU, ['a']=z_axis, ['t']=-0.013453, ['s']=0.048843},
			{['c']='turn',['p']=LegLL01, ['a']=x_axis, ['t']=-0.000000, ['s']=2.127527},
			{['c']='turn',['p']=LegLL01, ['a']=y_axis, ['t']=-0.000000, ['s']=1.860791},
			{['c']='turn',['p']=LegLL01, ['a']=z_axis, ['t']=-3.141593, ['s']=0.559835},
			{['c']='turn',['p']=LegLU01, ['a']=x_axis, ['t']=0.340208, ['s']=1.061050},
			{['c']='turn',['p']=LegLU01, ['a']=y_axis, ['t']=-0.006957, ['s']=0.004693},
			{['c']='turn',['p']=LegLU01, ['a']=z_axis, ['t']=-1.113250, ['s']=4.683945},
			{['c']='turn',['p']=LegUU01, ['a']=x_axis, ['t']=0.050725, ['s']=1.474210},
			{['c']='turn',['p']=LegUU01, ['a']=y_axis, ['t']=-0.018216, ['s']=0.138910},
			{['c']='turn',['p']=LegUU01, ['a']=z_axis, ['t']=-2.325583, ['s']=4.722789},
			{['c']='move',['p']=LegUU01, ['a']=x_axis, ['t']=5.835749, ['s']=0.058230},
			{['c']='move',['p']=LegUU01, ['a']=y_axis, ['t']=0.005890, ['s']=0.000994},
			{['c']='move',['p']=LegUU01, ['a']=z_axis, ['t']=-0.034231, ['s']=0.048844},
			{['c']='turn',['p']=LegLL, ['a']=x_axis, ['t']=-0.000000, ['s']=1.578882},
			{['c']='turn',['p']=LegLL, ['a']=y_axis, ['t']=0.000000, ['s']=1.963968},
			{['c']='turn',['p']=LegLL, ['a']=z_axis, ['t']=-3.141593, ['s']=0.428317},
		}
	},
	{
		['time'] = 20,
		['commands'] = {
			{['c']='turn',['p']=LegUL, ['a']=x_axis, ['t']=0.000000, ['s']=2.430575},
			{['c']='turn',['p']=LegUL, ['a']=y_axis, ['t']=0.000000, ['s']=3.093120},
			{['c']='turn',['p']=LegUL, ['a']=z_axis, ['t']=-3.141593, ['s']=0.726291},
			{['c']='turn',['p']=LegLU, ['a']=x_axis, ['t']=0.000000, ['s']=0.474391},
			{['c']='turn',['p']=LegLU, ['a']=y_axis, ['t']=-0.000000, ['s']=1.285332},
			{['c']='turn',['p']=LegLU, ['a']=z_axis, ['t']=-3.141593, ['s']=7.957143},
			{['c']='turn',['p']=Kreis02, ['a']=x_axis, ['t']=0.002853, ['s']=0.006179},
			{['c']='turn',['p']=Kreis02, ['a']=y_axis, ['t']=-0.037663, ['s']=0.128538},
			{['c']='turn',['p']=Kreis02, ['a']=z_axis, ['t']=-3.157657, ['s']=0.054320},
			{['c']='turn',['p']=UpperJaw, ['a']=x_axis, ['t']=0.000000, ['s']=0.000000},
			{['c']='turn',['p']=UpperJaw, ['a']=y_axis, ['t']=-0.000000, ['s']=0.000000},
			{['c']='turn',['p']=LegUU, ['a']=x_axis, ['t']=0.000000, ['s']=0.220229},
			{['c']='turn',['p']=LegUU, ['a']=y_axis, ['t']=-0.000000, ['s']=0.123810},
			{['c']='turn',['p']=LegUU, ['a']=z_axis, ['t']=-3.141593, ['s']=3.846794},
			{['c']='turn',['p']=LegUL01, ['a']=x_axis, ['t']=0.000000, ['s']=5.396998},
			{['c']='turn',['p']=LegUL01, ['a']=y_axis, ['t']=0.000000, ['s']=1.620344},
			{['c']='turn',['p']=LegUL01, ['a']=z_axis, ['t']=-3.141593, ['s']=0.087590},
			{['c']='turn',['p']=LegLL01, ['a']=x_axis, ['t']=-0.000000, ['s']=0.000000},
			{['c']='turn',['p']=LegLL01, ['a']=y_axis, ['t']=-0.000000, ['s']=0.000000},
			{['c']='turn',['p']=LegLU01, ['a']=x_axis, ['t']=-0.000000, ['s']=1.458035},
			{['c']='turn',['p']=LegLU01, ['a']=y_axis, ['t']=-0.000000, ['s']=0.029815},
			{['c']='turn',['p']=LegLU01, ['a']=z_axis, ['t']=-3.141593, ['s']=8.692896},
			{['c']='turn',['p']=LegUU01, ['a']=x_axis, ['t']=-0.000000, ['s']=0.217394},
			{['c']='turn',['p']=LegUU01, ['a']=y_axis, ['t']=-0.000000, ['s']=0.078068},
			{['c']='turn',['p']=LegUU01, ['a']=z_axis, ['t']=-3.141593, ['s']=3.497187},
			{['c']='turn',['p']=LegLL, ['a']=x_axis, ['t']=-0.000000, ['s']=0.000000},
			{['c']='turn',['p']=LegLL, ['a']=y_axis, ['t']=-0.000000, ['s']=0.000000},
			{['c']='turn',['p']=LowerJaw, ['a']=x_axis, ['t']=0.000004, ['s']=0.000016},
			{['c']='turn',['p']=LowerJaw, ['a']=y_axis, ['t']=-0.000059, ['s']=0.000254},
			{['c']='turn',['p']=LowerJaw, ['a']=z_axis, ['t']=-3.141618, ['s']=0.000107},
		}
	},
	{
		['time'] = 27,
		['commands'] = {
			{['c']='turn',['p']=LegUL, ['a']=x_axis, ['t']=-0.000000, ['s']=0.000000},
			{['c']='turn',['p']=LegUL, ['a']=y_axis, ['t']=0.000000, ['s']=0.000000},
			{['c']='turn',['p']=LegUL, ['a']=z_axis, ['t']=-3.141593, ['s']=0.000000},
			{['c']='turn',['p']=LegLU, ['a']=x_axis, ['t']=-0.000000, ['s']=0.000000},
			{['c']='turn',['p']=LegLU, ['a']=y_axis, ['t']=-0.000000, ['s']=0.000000},
			{['c']='turn',['p']=LegLU, ['a']=z_axis, ['t']=-3.141593, ['s']=0.000000},
			{['c']='turn',['p']=Kreis02, ['a']=x_axis, ['t']=-0.002229, ['s']=0.010163},
			{['c']='turn',['p']=Kreis02, ['a']=y_axis, ['t']=0.068037, ['s']=0.211399},
			{['c']='turn',['p']=Kreis02, ['a']=z_axis, ['t']=-3.112989, ['s']=0.089336},
			{['c']='turn',['p']=UpperJaw, ['a']=x_axis, ['t']=-0.000000, ['s']=0.000000},
			{['c']='turn',['p']=UpperJaw, ['a']=y_axis, ['t']=-0.000000, ['s']=0.000000},
			{['c']='turn',['p']=UpperJaw, ['a']=z_axis, ['t']=-3.141593, ['s']=0.000000},
			{['c']='move',['p']=UpperJaw, ['a']=x_axis, ['t']=5.868676, ['s']=0.018618},
			{['c']='move',['p']=UpperJaw, ['a']=y_axis, ['t']=-0.014273, ['s']=0.003114},
			{['c']='move',['p']=UpperJaw, ['a']=z_axis, ['t']=-0.032777, ['s']=0.001756},
			{['c']='turn',['p']=LegUU, ['a']=x_axis, ['t']=-0.000000, ['s']=0.000000},
			{['c']='turn',['p']=LegUU, ['a']=y_axis, ['t']=-0.000000, ['s']=0.000000},
			{['c']='turn',['p']=LegUU, ['a']=z_axis, ['t']=-3.141593, ['s']=0.000000},
			{['c']='turn',['p']=LegUL01, ['a']=x_axis, ['t']=0.000000, ['s']=0.000000},
			{['c']='turn',['p']=LegUL01, ['a']=y_axis, ['t']=0.000000, ['s']=0.000000},
			{['c']='turn',['p']=LegUL01, ['a']=z_axis, ['t']=-3.141593, ['s']=0.000000},
			{['c']='turn',['p']=LegLL01, ['a']=x_axis, ['t']=-0.000000, ['s']=0.000000},
			{['c']='turn',['p']=LegLL01, ['a']=y_axis, ['t']=-0.000000, ['s']=0.000000},
			{['c']='turn',['p']=LegLL01, ['a']=z_axis, ['t']=-3.141593, ['s']=0.000000},
			{['c']='turn',['p']=LegLU01, ['a']=x_axis, ['t']=-0.000000, ['s']=0.000000},
			{['c']='turn',['p']=LegLU01, ['a']=y_axis, ['t']=-0.000000, ['s']=0.000000},
			{['c']='turn',['p']=LegLU01, ['a']=z_axis, ['t']=-3.141593, ['s']=0.000000},
			{['c']='move',['p']=LegLU01, ['a']=y_axis, ['t']=0.003408, ['s']=0.000000},
			{['c']='turn',['p']=LegUU01, ['a']=x_axis, ['t']=-0.000000, ['s']=0.000000},
			{['c']='turn',['p']=LegUU01, ['a']=y_axis, ['t']=-0.000000, ['s']=0.000000},
			{['c']='turn',['p']=LegUU01, ['a']=z_axis, ['t']=-3.141593, ['s']=0.000000},
			{['c']='turn',['p']=LegLL, ['a']=x_axis, ['t']=-0.000000, ['s']=0.000000},
			{['c']='turn',['p']=LegLL, ['a']=y_axis, ['t']=-0.000000, ['s']=0.000000},
			{['c']='turn',['p']=LegLL, ['a']=z_axis, ['t']=-3.141593, ['s']=0.000000},
			{['c']='turn',['p']=LowerJaw, ['a']=x_axis, ['t']=-0.005176, ['s']=0.017265},
			{['c']='turn',['p']=LowerJaw, ['a']=y_axis, ['t']=-0.299837, ['s']=0.999258},
			{['c']='turn',['p']=LowerJaw, ['a']=z_axis, ['t']=-3.141534, ['s']=0.000280},
		}
	},
	{
		['time'] = 36,
		['commands'] = {
			{['c']='turn',['p']=LowerJaw, ['a']=x_axis, ['t']=-0.004479, ['s']=0.001230},
			{['c']='turn',['p']=LowerJaw, ['a']=y_axis, ['t']=-0.015884, ['s']=0.501093},
			{['c']='turn',['p']=LowerJaw, ['a']=z_axis, ['t']=-3.142831, ['s']=0.002290},
		}
	},
	{
		['time'] = 42,
		['commands'] = {
			{['c']='turn',['p']=Kreis02, ['a']=x_axis, ['t']=0.006918, ['s']=0.010553},
			{['c']='turn',['p']=Kreis02, ['a']=y_axis, ['t']=-0.095059, ['s']=0.188188},
			{['c']='turn',['p']=Kreis02, ['a']=z_axis, ['t']=-3.182147, ['s']=0.079797},
		}
	},
	{
		['time'] = 53,
		['commands'] = {
			{['c']='turn',['p']=LowerJaw, ['a']=x_axis, ['t']=0.003503, ['s']=0.009578},
			{['c']='turn',['p']=LowerJaw, ['a']=y_axis, ['t']=-0.057148, ['s']=0.049517},
			{['c']='turn',['p']=LowerJaw, ['a']=z_axis, ['t']=-3.165802, ['s']=0.027564},
			{['c']='move',['p']=LowerJaw, ['a']=y_axis, ['t']=-0.010225, ['s']=0.000000},
		}
	},
	{
		['time'] = 66,
		['commands'] = {
			{['c']='turn',['p']=UpperJaw, ['a']=x_axis, ['t']=-0.000000, ['s']=0.000000},
			{['c']='turn',['p']=UpperJaw, ['a']=y_axis, ['t']=-0.000000, ['s']=0.000000},
			{['c']='move',['p']=UpperJaw, ['a']=x_axis, ['t']=5.892879, ['s']=0.021355},
			{['c']='move',['p']=UpperJaw, ['a']=y_axis, ['t']=-0.010225, ['s']=0.003572},
			{['c']='move',['p']=UpperJaw, ['a']=z_axis, ['t']=-0.030494, ['s']=0.002015},
		}
	},
	{
		['time'] = 68,
		['commands'] = {
			{['c']='turn',['p']=Kreis02, ['a']=x_axis, ['t']=0.000000, ['s']=0.006485},
			{['c']='turn',['p']=Kreis02, ['a']=y_axis, ['t']=-0.000000, ['s']=0.089118},
			{['c']='turn',['p']=Kreis02, ['a']=z_axis, ['t']=-3.141593, ['s']=0.038019},
		}
	},
	{
		['time'] = 78,
		['commands'] = {
			{['c']='turn',['p']=LowerJaw, ['a']=x_axis, ['t']=0.024014, ['s']=0.153830},
			{['c']='turn',['p']=LowerJaw, ['a']=y_axis, ['t']=-0.236040, ['s']=1.341689},
			{['c']='turn',['p']=LowerJaw, ['a']=z_axis, ['t']=-3.244802, ['s']=0.592500},
		}
	},
	{
		['time'] = 82,
		['commands'] = {
			{['c']='turn',['p']=LowerJaw, ['a']=x_axis, ['t']=0.003375, ['s']=0.154787},
			{['c']='turn',['p']=LowerJaw, ['a']=y_axis, ['t']=-0.037521, ['s']=1.488894},
			{['c']='turn',['p']=LowerJaw, ['a']=z_axis, ['t']=-3.157999, ['s']=0.651017},
		}
	},
	{
		['time'] = 86,
		['commands'] = {
			{['c']='turn',['p']=LowerJaw, ['a']=x_axis, ['t']=0.011897, ['s']=0.063916},
			{['c']='turn',['p']=LowerJaw, ['a']=y_axis, ['t']=-0.141841, ['s']=0.782405},
			{['c']='turn',['p']=LowerJaw, ['a']=z_axis, ['t']=-3.202658, ['s']=0.334944},
		}
	},
	{
		['time'] = 90,
		['commands'] = {
			{['c']='turn',['p']=LowerJaw, ['a']=x_axis, ['t']=0.002114, ['s']=0.058702},
			{['c']='turn',['p']=LowerJaw, ['a']=y_axis, ['t']=-0.014234, ['s']=0.765643},
			{['c']='turn',['p']=LowerJaw, ['a']=z_axis, ['t']=-3.148008, ['s']=0.327903},
		}
	},
	{
		['time'] = 95,
		['commands'] = {
			{['c']='turn',['p']=LowerJaw, ['a']=x_axis, ['t']=-0.000000, ['s']=0.012682},
			{['c']='turn',['p']=LowerJaw, ['a']=y_axis, ['t']=-0.000000, ['s']=0.085405},
			{['c']='turn',['p']=LowerJaw, ['a']=z_axis, ['t']=-3.141593, ['s']=0.038489},
		}
	},
	{
		['time'] = 100,
		['commands'] = {
		}
	},
}

Animations['talk'] = {
	{

	{
		['time'] = 66,
		['commands'] = {
			{['c']='turn',['p']=UpperJaw, ['a']=x_axis, ['t']=-0.000000, ['s']=0.000000},
			{['c']='turn',['p']=UpperJaw, ['a']=z_axis, ['t']=-0.000000, ['s']=0.000000},
			 
			 
			 
		}
	},
	{
		['time'] = 68,
		['commands'] = {
			{['c']='turn',['p']=Kreis02, ['a']=x_axis, ['t']=0.000000, ['s']=0.006485},
			{['c']='turn',['p']=Kreis02, ['a']=z_axis, ['t']=-0.000000, ['s']=0.089118},
			{['c']='turn',['p']=Kreis02, ['a']=y_axis, ['t']=-1*-3.141593, ['s']=0.038019},
		}
	},
	{
		['time'] = 78,
		['commands'] = {
			{['c']='turn',['p']=LowerJaw, ['a']=x_axis, ['t']=0.024014, ['s']=0.153830},
			{['c']='turn',['p']=LowerJaw, ['a']=z_axis, ['t']=-0.236040, ['s']=1.341689},
			{['c']='turn',['p']=LowerJaw, ['a']=y_axis, ['t']=-1*-3.244802, ['s']=0.592500},
		}
	},
	{
		['time'] = 82,
		['commands'] = {
			{['c']='turn',['p']=LowerJaw, ['a']=x_axis, ['t']=0.003375, ['s']=0.154787},
			{['c']='turn',['p']=LowerJaw, ['a']=z_axis, ['t']=-0.037521, ['s']=1.488894},
			{['c']='turn',['p']=LowerJaw, ['a']=y_axis, ['t']=-1*-3.157999, ['s']=0.651017},
		}
	},
	{
		['time'] = 86,
		['commands'] = {
			{['c']='turn',['p']=LowerJaw, ['a']=x_axis, ['t']=0.011897, ['s']=0.063916},
			{['c']='turn',['p']=LowerJaw, ['a']=z_axis, ['t']=-0.141841, ['s']=0.782405},
			{['c']='turn',['p']=LowerJaw, ['a']=y_axis, ['t']=-1*-3.202658, ['s']=0.334944},
		}
	},
	{
		['time'] = 90,
		['commands'] = {
			{['c']='turn',['p']=LowerJaw, ['a']=x_axis, ['t']=0.002114, ['s']=0.058702},
			{['c']='turn',['p']=LowerJaw, ['a']=z_axis, ['t']=-0.014234, ['s']=0.765643},
			{['c']='turn',['p']=LowerJaw, ['a']=y_axis, ['t']=-1*-3.148008, ['s']=0.327903},
		}
	},
	{
		['time'] = 95,
		['commands'] = {
			{['c']='turn',['p']=LowerJaw, ['a']=x_axis, ['t']=-0.000000, ['s']=0.012682},
			{['c']='turn',['p']=LowerJaw, ['a']=z_axis, ['t']=-0.000000, ['s']=0.085405},
			{['c']='turn',['p']=LowerJaw, ['a']=y_axis, ['t']=-1*-3.141593, ['s']=0.038489},
		}
	},
	{
		['time'] = 100,
		['commands'] = {
		}
	},
}
}
function script.Create()
Move(center,y_axis,44,0)
--generatepiecesTableAndArrayCode(unitID)

    local map = Spring.GetUnitPieceMap(unitID)
    local offsets = constructSkeleton(unitID,deathpivot, {0,0,0})
    
    for a,anim in pairs(Animations) do
        for i,keyframe in pairs(anim) do
            local commands = keyframe.commands;
            for k,command in pairs(commands) do
                -- commands are described in (c)ommand,(p)iece,(a)xis,(t)arget,(s)peed format
                -- the t attribute needs to be adjusted for move commands from blender's absolute values
                if (command.c == "move") then
                    local adjusted =  command.t - (offsets[command.p][command.a]);
                    Animations[a][i]['commands'][k].t = command.t - (offsets[command.p][command.a]);
                end
            end
        end
    end
StartThread(MoveControll)
end

function MoveControll()
	while true do
		if boolMoving==true then
		PlayAnimation("walk")
		else
		
		
		end
	Sleep(150)
	end

end

function PlayAnimation(animname)


if not Animations[animname] then Spring.Echo(animname) end

    local anim = Animations[animname];
	assert(anim, animname)
    for i = 1, #anim do
        local commands = anim[i].commands;
        for j = 1,#commands do
            local cmd = commands[j];
            animCmd[cmd.c](cmd.p,cmd.a,cmd.t,cmd.s);
        end
        if(i < #anim) then
            local t = anim[i+1]['time'] - anim[i]['time'];
            Sleep(t*33); -- sleep works on milliseconds
        end
    end
end

function script.Killed(recentDamage,_)

createCorpseCUnitGeneric(recentDamage)
return 1
end


----aimining & fire weapon
function script.AimFromWeapon1() 
	return center 
end



function script.QueryWeapon1() 
	return center
end

function script.AimWeapon1( Heading ,pitch)	
	--aiming animation: instantly turn the gun towards the enemy

	return true

end
 
 function watchAndWait()
 --hide Unit
 removeFromWorld(unitID)
 
 
 if not GG.ProjectileOrigin then	GG.ProjectileOrigin={} end
 GG.ProjectileOrigin[unitID]=nil
 
 --wakeupcondition
 lifetimeOfProj= 3000*2
 while lifetimeOfProj > 0 and not GG.ProjectileOrigin[unitID] do
 Sleep(150)
 lifetimeOfProj=lifetimeOfProj-150
 end 
 
 --we did wake up, but stuck to the ground or stuck to a unit?
 if  GG.ProjectileOrigin[unitID] then -- we did make it
 
	if  GG.ProjectileOrigin[unitID].boolHitGround==true then -- we are where we should be
	StartThread(getUnstuck_Ground)
	else -- we are Stuck to a Unit
	StartThread(getUnstuck_Unit,GG.ProjectileOrigin[unitID].id,GG.ProjectileOrigin[unitID].lastAttackedPiece)
	end
 
 else
 Spring.Echo("Varyfoospear in projectile nirwana")
 Spring.DestroyUnit(unitID,true,true) 
 end
 
 end

 function getUnstuck_Ground ()
 returnToWorld(unitID)
 PlayAnimation("varyfoospear_unstuckGround")
 end
 
 function getUnstuck_Unit(id, unitpiece)
 Spring.AddUnitDamage(id,120)
 Sleep(3)
	if Spring.ValidUnitID(id) ==true then
	PlayAnimation("varyfoospear_unstuckUnit")
	end
 end
 
function script.FireWeapon1()	
StartThread(watchAndWait)
	return true
end



function script.StartMoving()

end

function script.StopMoving()
		
		
end
