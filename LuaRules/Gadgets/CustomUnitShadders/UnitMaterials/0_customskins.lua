-- $Id$
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--[[ local materials = {
   altSkinS3o = {
       shaderDefinitions = {
       },
       shader    = include(GADGET_DIR .. "UnitMaterials/Shaders/default.lua"),
           force         = true,
       usecamera = false,
       culling   = GL.BACK,
       texunits  = {
         [0] = '%ALTSKIN',
         [1] = '%ALTSKIN2',
         [2] = '$shadow',
         [3] = '$specular',
         [4] = '$reflection',
         [5] = '%NORMALTEX',
       },
   },
} ]]

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--[[ local unitMaterials = {}

for i=1,#UnitDefs do
  local udef = UnitDefs[i]

  if (udef.customParams.altskin and VFS.FileExists(udef.customParams.altskin)) then
    local tex2 = "%%"..i..":1"
    unitMaterials[udef.name] = {"altSkinS3o", ALTSKIN = udef.customParams.altskin, ALTSKIN2 = udef.customParams.altskin2 or tex2}
  end --if
end --for ]]

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--[[ 
return materials, unitMaterials
 ]]
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
