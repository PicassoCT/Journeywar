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
		shader    = include("ModelMaterials/Shaders/default.lua"),
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
			[5] = '%HUETEX',
		},
	},
	hueShadedFeatureFlipped = {
		shaderDefinitions = {
			"#define use_perspective_correct_shadows",
		},
		shader    = include("ModelMaterials/Shaders/default.lua"),
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
			[5] = '%HUETEX',
		},
	},
}

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Automated normalmap detection

local unitMaterials = {}


local function basename(fullpath)
	local _,_,base = fullpath:find("([^\\/:]*)$")
	local _,_,path = fullpath:find("(.*[\\/:])[^\\/:]*$")
	if not path then path = "" end
	if     base then base = base:gsub("%....", "") end
	return base, path
end


local function FindTextureFile(filepath)
	local huetex

	--// extract basename of a given filepath (e.g. the path of tex1 or tex2)
	local basefilename, basepath = basename(filepath)
	if (tonumber(basefilename:sub(-1,-1))) then
		--// remove trailing numbers (e.g. corcom1.png -> corcom1 -> corcom)
		basefilename = basefilename:sub(1,-2)
	end
	if (basefilename:sub(-1,-1) == "_") then
		--// remove trailing underscores (e.g. corcom_1.png -> corcom_1 -> corcom)
		basefilename = basefilename:sub(1,-2)
	end

	--// check if there is a corresponding _normals.dds file
	for _,dir in ipairs{basepath, "", "unittextures"} do
		local foundFiles = VFS.DirList(dir, basefilename .. "_huetex.*")
		if (foundFiles and foundFiles[1]) then
			huetex = foundFiles[1]
			break
		end
	end

	return huetex
end


local function FindNormalmapFromModel(modelpath, fileext)
	if not modelpath then
		return
	end

	local huetex

	if (fileext == "s3o") then
		--// in case of S3O check the model's tex1 & tex2 and use it to find the normalmap
		--// fdef.model.textures is empty at gamestart, so read the texture filenames from the s3o directly
		local rawstr  = VFS.LoadFile(modelpath)
		local header  = rawstr:sub(1,60)
		local texPtrs = VFS.UnpackU32(header, 45, 2)

		local tex1,tex2
		if (texPtrs[2] > 0)
			then tex2 = rawstr:sub(texPtrs[2]+1, rawstr:len()-1)
			else texPtrs[2] = rawstr:len() end
		if (texPtrs[1] > 0)
			then tex1 = rawstr:sub(texPtrs[1]+1, texPtrs[2]-1) end

		--// output units without tex2
		if not tex2 then
			Spring.Log(gadget:GetInfo().name, LOG.WARNING, fdef.name .. " missing a tex2")
		end

		huetex = FindTextureFile(tex1) or FindTextureFile(tex2)
	end

	--// all others & fallback use just modelfilename itself to find the normalmap
	return huetex or FindTextureFile(modelpath)
end



for i=1,#FeatureDefs do
	local fdef = FeatureDefs[i]

	if (fdef.customParams.huetex and VFS.FileExists(fdef.customParams.huetex)) then
		if fdef.customParams.huetex:lower():find(".dds") then
			unitMaterials[fdef.name] = {"hueShadedFeature", huetex = fdef.customParams.huetex}
		else
			unitMaterials[fdef.name] = {"hueShadedFeatureFlipped", huetex = fdef.customParams.huetex}
		end

	elseif (fdef.model.type ~= "3do") then
		local huetex = FindNormalmapFromModel(fdef.model.path, fdef.model.type)
		if huetex then
			if huetex:lower():find(".dds") then
				unitMaterials[fdef.name] = {"hueShadedFeature", huetex = huetex}
			else
				unitMaterials[fdef.name] = {"hueShadedFeatureFlipped", huetex = huetex}
			end
		end
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

return materials, unitMaterials

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
