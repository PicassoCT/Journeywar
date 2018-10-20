-- In-game, type /luarules kpai in the console to toggle the ai debug messages

function gadget:GetInfo()
	return {
		name = "Game of Goo",
		desc = "Plays the Game of Grey Goo",
		author = "Picasso",
		date = "around since last tuesday",
		license = "Licensed under the Recursive License: "..
		"a) Every version drafted, has a completely diffrent license then all its predecessors"..
		"b) Include all previous licenses"..
		"c) Fullfills all conditions of the previous licenses",
		layer = 666,
		enabled = true
	}
end

if (gadgetHandler:IsSyncedCode()) then
	VFS.Include("scripts/lib_UnitScript.lua")
	VFS.Include("scripts/lib_jw.lua")
	gaiaTeam = Spring.GetGaiaTeamID()
	
	local GOL = {}
	
	GooSizeSquare= 280
	tickEverynthSecond= 1
	tickEveryNthFrame= 30*tickEverynthSecond
	
	x_GridSize,z_GridSize = math.ceil(Game.mapSizeX/GooSizeSquare)-1, math.ceil(Game.mapSizeZ/GooSizeSquare)-1

	GOL.Grid = {}
	grid_instance={}	
	
	GOL.live_cell = {alive = true, unitID = nil}
	GOL.cell_dead = {alive = false}
	GOL.random_cell = function (cell_index_x, cell_index_z)
		if math.random(0,100) > 75 then 
			local liveCellCopy = 	GOL.live_cell
			x,z = cell_index_x*GooSizeSquare, cell_index_z * GooSizeSquare
			liveCellCopy.unitID = Spring.CreateUnit("greygoo",x,0,z, 1, gaiaTeam)
			return liveCellCopy, true
		else 
			return GOL.cell_dead , false
		end
	end
	
	GOL.cell_dead.next_state = function(alive_neighbours, cell_index_x, cell_index_z)
		if alive_neighbours == 3 then
			local liveCellCopy = 	GOL.live_cell
			x,z = cell_index_x*GooSizeSquare, cell_index_z*GooSizeSquare
			liveCellCopy.unitID = Spring.CreateUnit("greygoo",x,0,z, 1, gaiaTeam)
			return liveCellCopy, true
		else
			return GOL.cell_dead, false
		end
	end
	
	GOL.live_cell.next_state = function(alive_neighbours, cell_index_x, cell_index_z)
		if alive_neighbours >=2 and alive_neighbours <= 3 then
			return GOL.live_cell, true
		else
			if grid_instance[cell_index_x][cell_index_z].unitID then
				destroyUnitConditional(grid_instance[cell_index_x][cell_index_z].unitID, true, false)	
			end
			return GOL.cell_dead, false
		end
	end
	

	
	
	GOL.Grid.count_live_neighbours = function(grid, x, y)
		neighbour_positions = {
			{-1,-1}, {0,-1}, {1,-1},
			{-1,0}, {1,0},
			{-1,1}, {0,1}, {1,1}
		}
		live_neighbour_count = 0
		for i,pos in ipairs(neighbour_positions) do
			x_i, y_i = x+pos[1], y+pos[2]
			
			if x_i>=1 and y_i>=1 and x_i <= #grid[1] and y_i <= #grid then
				if grid[y+pos[2]][x+pos[1]] == GOL.live_cell then
					live_neighbour_count = live_neighbour_count + 1
				end
			end
		end
		return live_neighbour_count
	end
	
	
	GOL.Grid.evolve = function(grid)
		new_grid = {}
		local boolAtleastOneAlive=false
		for row_i, row in ipairs(grid) do
			table.insert(new_grid, {})
			for cell_i, cell in ipairs(row) do
				new_cell, stillAlive = cell.next_state( GOL.Grid.count_live_neighbours(grid, cell_i, row_i),row_i, cell_i )
				table.insert(new_grid[row_i], new_cell)
				if stillAlive == true then boolAtleastOneAlive = true end
			end
		end
		return new_grid, boolAtleastOneAlive
	end
	

	GOL.Grid.random_grid = function(x, y)
	grid = {}
		
		for x_i = 1,x,1 do
			table.insert(grid, {})
			for y_i = 1,y,1 do
				result = GOL.random_cell(x_i,y_i)
				table.insert(grid[#grid], result)
			end
		end
		return grid
	end
	

	function gadget:Initialize()
		grid_instance = GOL.Grid.random_grid(x_GridSize,z_GridSize)
	end
	
	function gadget:GameFrame(frame)
		if frame > 0 and frame % tickEveryNthFrame == 0 then
			updateGameOfGoo(frame)
		end
	end
	
	function updateGameOfGoo(frame)
		grid_instance, boolAtleastOneAlive = GOL.Grid.evolve(grid_instance)
		--if boolAtleastOneAlive == false then gadget:Shutdown() end
	end
	
	function gadget:UnitDestroyed(unitID, unitDefID, unitTeam)
		if (unitDefID == UnitDefNames["greygoo"].id) then
			for x=1,x_GridSize do
				for z=1,z_GridSize do
					if grid_instance[x][z].unitID and  grid_instance[x][z].unitID == unitID then
						grid_instance[x][z] = GOL.cell_dead
					end
				end
			end
		end 
	end 

	
	function gadget:Shutdown()
		Spring.Echo("Greygoo Gadget Shutting down")
	end
end