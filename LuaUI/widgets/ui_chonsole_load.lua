----------------------------------------------------------------------------
----------------------------------------------------------------------------
-- Copy this file to both the luaui/widgets and the luarules/gadgets folders

-- Set this line to the Chonsole installation folder
CHONSOLE_FOLDER = "luaui/chonsole"

-- Do NOT modify the following lines
if Script.GetName() == "LuaUI" then
	VFS.Include("luaui/widgets/ui_chonsole.lua", nil, VFS.DEF_MODE)
elseif Script.GetName() == "luarules" then
	VFS.Include("luarules/gadgets/ui_chonsole.lua", nil, VFS.DEF_MODE)
end
