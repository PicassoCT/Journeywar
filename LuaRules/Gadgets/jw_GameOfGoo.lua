-- In-game, type /luarules kpai in the console to toggle the ai debug messages

function gadget:GetInfo()
	return {
		name = "Game of Goo",
		desc = "Plays the Game of Grey Goo",
		author = "Picasso",
		date = "around since last tuesday",
		license = "Licensed under the Recursive License: "..
		"a) Every version drafted, has a completely diffrent license then all its predecessors"..
		"b) Includes and fullfills all previous licenses conditions.",
		layer = 666,
		enabled = true
	}
end

if (gadgetHandler:IsSyncedCode()) then
	VFS.Include("scripts/lib_UnitScript.lua")
	VFS.Include("scripts/lib_jw.lua")
	gaiaTeam = Spring.GetGaiaTeamID()

	GooSizeSquare= 280
	tickEverynthSecond= 1
	tickEveryNthFrame= 30*tickEverynthSecond
	
	x_GridSize,z_GridSize = math.ceil(Game.mapSizeX/GooSizeSquare)-1, math.ceil(Game.mapSizeZ/GooSizeSquare)-1

	
	grid_instance={}	
	
	local cell_alive = {alive = true, unitID = nil}
	local cell_dead = {alive = false}
	function random_cell (cell_index_x, cell_index_z)
		if math.random(0,100) > 75 then 
			local liveCellCopy = 	cell_alive
			x,z = cell_index_x*GooSizeSquare, cell_index_z * GooSizeSquare
			liveCellCopy.unitID = Spring.CreateUnit("greygoo",x,0,z, 1, gaiaTeam)
			return liveCellCopy, true
		else 
			return cell_dead , false
		end
	end

	
	function next_state (boolAlive, alive_neighbours, cell_index_x, cell_index_z)
	 if boolAlive then
		Spring.Echo("Next State called for alive cell with "..alive_neighbours.." alive neighbours")
			if alive_neighbours >=2 and alive_neighbours <= 3 then
				return  cell_alive, true
			else
				if grid_instance[cell_index_x][cell_index_z].unitID then
					destroyUnitConditional(grid_instance[cell_index_x][cell_index_z].unitID, true, false)	
				end
				return  cell_dead, false
			end
		else
			if alive_neighbours == 3 then
				local liveCellCopy = 	 cell_alive
				x,z = cell_index_x*GooSizeSquare, cell_index_z*GooSizeSquare
				liveCellCopy.unitID = Spring.CreateUnit("greygoo",x,0,z, 1, gaiaTeam)
				return liveCellCopy, true
			else
				return  cell_dead, false
			end	
		end
	end
	

	
	
	function count_live_neighbours(grid, x, y)
		neighbour_positions = {
			{-1,-1}, {0,-1}, {1,-1},
			{-1,0}, {1,0},
			{-1,1}, {0,1}, {1,1}
		}
		live_neighbour_count = 0
		for i,pos in ipairs(neighbour_positions) do
			x_i, y_i = x+pos[1], y+pos[2]
			
			if x_i>=1 and y_i>=1 and x_i <= #grid[1] and y_i <= #grid then
				if grid[y+pos[2]][x+pos[1]].alive == true then
					live_neighbour_count = live_neighbour_count + 1
				end
			end
		end
		return live_neighbour_count
	end
	
	
	function evolve()
		local new_grid = {}
		local boolAtleastOneAlive=false
		for row_i, row in ipairs(grid_instance) do
			new_grid[#new_grid+1]= {}
			for cell_i, cell in ipairs(row) do
				new_cell, stillAlive = next_state(grid_instance[row_i][cell_i].alive, count_live_neighbours(grid_instance, cell_i, row_i),row_i, cell_i )
				new_grid[row_i][cell_i]= new_cell
				if stillAlive == true then boolAtleastOneAlive = true end
			end
		end
		grid_instance= new_grid
		return boolAtleastOneAlive
	end
	

	function random_grid(x, y)
	grid = {}
		
		for x_i = 1,x,1 do
			grid[x_i]={}
			for y_i = 1,y,1 do
				grid[x_i][y_i]= random_cell(x_i,y_i)
		
			end
		end
		return grid
	end
	

	function gadget:Initialize()
		grid_instance = random_grid(x_GridSize,z_GridSize)
	end
	
	function gadget:GameFrame(frame)
		if frame > 0 and frame % tickEveryNthFrame == 0 then
			updateGameOfGoo(frame)
		end
	end
	
	function updateGameOfGoo(frame)
		boolAtleastOneAlive = evolve()
		--if boolAtleastOneAlive == false then gadget:Shutdown() end
	end
	
	function gadget:UnitDestroyed(unitID, unitDefID, unitTeam)
		if (unitDefID == UnitDefNames["greygoo"].id) then
			for x=1,x_GridSize do
				for z=1,z_GridSize do
					if grid_instance[x][z].unitID and  grid_instance[x][z].unitID == unitID then
						grid_instance[x][z] = cell_dead
					end
				end
			end
		end 
	end 

	
	function gadget:Shutdown()
		Spring.Echo("Greygoo Gadget Shutting down")
	end
end