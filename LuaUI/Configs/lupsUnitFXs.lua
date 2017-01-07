-- note that the order of the MergeTable args matters for nested tables (such as colormaps)!

local presets = {
	commandAuraRed = {
		{class='StaticParticles', options=commandCoronaRed},
			{class='GroundFlash', options=MergeTable(groundFlashRed, {radiusFactor=3.5,mobile=true,life=60,
		colormap={ {1, 0.2, 0.2, 1},{1, 0.2, 0.2, 0.85},{1, 0.2, 0.2, 1} }})},
	},
	commandAuraOrange = {
		{class='StaticParticles', options=commandCoronaOrange},
			{class='GroundFlash', options=MergeTable(groundFlashOrange, {radiusFactor=3.5,mobile=true,life=math.huge,
		colormap={ {0.8, 0, 0.2, 1},{0.8, 0, 0.2, 0.85},{0.8, 0, 0.2, 1} }})},
	},
	commandAuraGreen = {
		{class='StaticParticles', options=commandCoronaGreen},
			{class='GroundFlash', options=MergeTable(groundFlashGreen, {radiusFactor=3.5,mobile=true,life=math.huge,
		colormap={ {0.2, 1, 0.2, 1},{0.2, 1, 0.2, 0.85},{0.2, 1, 0.2, 1} }})},
	},
	commandAuraBlue = {
		{class='StaticParticles', options=commandCoronaBlue},
			{class='GroundFlash', options=MergeTable(groundFlashBlue, {radiusFactor=3.5,mobile=true,life=math.huge,
		colormap={ {0.2, 0.2, 1, 1},{0.2, 0.2, 1, 0.85},{0.2, 0.2, 1, 1} }})},
	},	
	commandAuraViolet = {
		{class='StaticParticles', options=commandCoronaViolet},
			{class='GroundFlash', options=MergeTable(groundFlashViolet, {radiusFactor=3.5,mobile=true,life=math.huge,
		colormap={ {0.8, 0, 0.8, 1},{0.8, 0, 0.8, 0.85},{0.8, 0, 0.8, 1} }})},
	},	
	
	commAreaShield = {
		{class='ShieldJitter', options={delay=0, life=math.huge, heightFactor = 0.75, size=350, strength = .001, precision=50, repeatEffect=true, quality=4}},
	},
	
	commandShieldRed = {
		{class='ShieldSphere', options=MergeTable({colormap1 = {{1, 0.1, 0.1, 0.6}}, colormap2 = {{1, 0.1, 0.1, 0.15}}}, commandShieldSphere)},
		--		{class='StaticParticles', options=commandCoronaRed},
			--		{class='GroundFlash', options=MergeTable(groundFlashRed, {radiusFactor=3.5,mobile=true,life=60,
		--			colormap={ {1, 0.2, 0.2, 1},{1, 0.2, 0.2, 0.85},{1, 0.2, 0.2, 1} }})},	
	},
	commandShieldOrange = {
		{class='ShieldSphere', options=MergeTable({colormap1 = {{0.8, 0.3, 0.1, 0.6}}, colormap2 = {{0.8, 0.3, 0.1, 0.15}}}, commandShieldSphere)},
	},	
	commandShieldGreen = {
		{class='ShieldSphere', options=MergeTable({colormap1 = {{0.1, 1, 0.1, 0.6}}, colormap2 = {{0.1, 1, 0.1, 0.15}}}, commandShieldSphere)},
	},
	commandShieldBlue= {
		{class='ShieldSphere', options=MergeTable({colormap1 = {{0.1, 0.1, 0.8, 0.6}}, colormap2 = {{0.1, 0.1, 1, 0.15}}}, commandShieldSphere)},
	},	
	commandShieldViolet = {
		{class='ShieldSphere', options=MergeTable({colormap1 = {{0.6, 0.1, 0.75, 0.6}}, colormap2 = {{0.6, 0.1, 0.75, 0.15}}}, commandShieldSphere)},
	},	
}


effectUnitDefs = {
	--centrail
	
	css =		{
		{class='Ribbon', options={color={.9,.4,0.1,1}, width=1.5, piece="jet2", onActive=false}},
	{class='Ribbon', options={color={.9,.4,0.1,1}, width=1.5, piece="jet1", onActive=false}}				},	
	
		cvictory =		{class='ShieldJitter', options={delay=0,life=math.huge, pos={0,600,0}, size=125, precision=22, strength = 0.25, repeatEffect=true}
	},
	cawilduniverseappears= {
		{class='ShieldSphere', options={life=math.huge, pos={0,0,0}, size=125, onActive=true, colormap1 = {{172/255, 116/255, 230/255, 0.8}}, repeatEffect=true}},
		{class='ShieldJitter', options={delay=0,life=math.huge, pos={0,0,0}, size=130, precision=22, strength = 0.013, repeatEffect=true}},
	},
	
	
	citadell= {
		
		{class='ShieldSphere', options={life=math.huge, pos={0,496,0}, size=1000, onActive=true, colormap1 = {{0.2, 0.8, 0.9, 0.8}}, repeatEffect=true}},
		{class='ShieldJitter', options={delay=0,life=math.huge, pos={0,496,0}, size=1024,onActive=true, precision=22, strength = 0.042, repeatEffect=true}},
		{class='ShieldJitter', options={delay=0,life=math.huge, pos={0,498,0}, size=5, precision=22, strength = 0.15, repeatEffect=true}},
		{class='ShieldJitter', options={delay=0,life=math.huge, pos={0,613,0}, size=100, precision=22, strength = 0.005, repeatEffect=true}},
	},
	
	
	cwallbuilder={
		{class='ShieldJitter', options={delay=0,life=math.huge, pos={0,-25,0}, size=55, precision=22, strength = 0.015, repeatEffect=true}}, 
	},
	cairbase= {
		{class='ShieldJitter', options={delay=0,life=math.huge, pos={0,0,0}, size=42, precision=22, strength = 0.001, repeatEffect=true}},
	},
	
	fclvlone= {
		{class='ShieldJitter', options={delay=0,life=math.huge, pos={0,35,10}, size=42, precision=22, strength = 0.003, repeatEffect=true}},
	},
	cwaterextractor= {
		{class='ShieldJitter', options={delay=0,life=math.huge, pos={0,116,0}, size=25, precision=22, strength = 0.015, repeatEffect=true}},
		
	},
	
	bbind= {
		{class='ShieldJitter', options={delay=0,life=math.huge, pos={0,10,0}, size=96, precision=22, strength = 0.003, repeatEffect=true}},
	},
	
	
	cgunship= {
		{class='ShieldJitter', options={delay=0,life=math.huge, pos={-2,5,-31}, size=20, precision=22, strength = 0.015, repeatEffect=true}}, 
	},
	
	mdigg= {
		{class='ShieldJitter', options={delay=0,life=math.huge, pos={0,24,-20}, size=30, precision=22, strength = 0.005, repeatEffect=true}}, 
	}, 
	
	
	--journeyman
	jstealthdrone ={
		{class='Ribbon', options={color={.1,.4,0.9,1}, width=3.5, size= 32, piece="flare1", onActive=true}},
		{class='Ribbon', options={color={.1,.4,0.9,1}, width=3.5, size= 32, piece="flare2", onActive=true}},
		{class='Ribbon', options={color={.1,.4,0.9,1}, width=3.5, size= 32, piece="flare3", onActive=true}},
		{class='Ribbon', options={color={.1,.4,0.9,1}, width=3.5, size= 32, piece="flare4", onActive=true}},
		{class='Ribbon', options={color={.1,.4,0.9,1}, width=3.5, size= 32, piece="flare5", onActive=true}},
		{class='Ribbon', options={color={.1,.4,0.9,1}, width=3.5, size= 32, piece="flare6", onActive=true}},
		{class='Ribbon', options={color={.1,.4,0.9,1}, width=3.5, size= 32, piece="flare7", onActive=true}},
		{class='Ribbon', options={color={.1,.4,0.9,1}, width=3.5, size= 32, piece="flare8", onActive=true}},
		{class='Ribbon', options={color={.1,.4,0.9,1}, width=22.5, size= 32, piece="nanoemit", onActive=true}},
		
	},	
	jsunshipwater ={
		{class='ShieldJitter', options={delay=0,life=math.huge, pos={0,0,0}, size=325, precision=22, strength = 0.00125, repeatEffect=true}}
		
	},	
	jmeconverter ={
		{class='ShieldSphere', options={life=math.huge, pos={0,35,0}, size=18, colormap1 = {{0.3, 0.9, 0.06, 0.8}}, repeatEffect=true}},
		{class='ShieldJitter', options={life=math.huge, pos={0,35,0}, size=19.5, precision=22, strength = 0.001125, repeatEffect=true}},
		
	},
	tiglil ={
		{class='Ribbon', options={color={.1,.8,0.9,1}, width=3.5, piece="tlhairup", onActive=false}},
	},
	jghostdancer ={
		{class='Ribbon', options={color={.1,.8,0.9,1}, width=3.5, piece="Tail05", onActive=false}},
	},
	
	
	
	jsunshipfire= {
		
		
		--	{class='UnitPieceLight', options={delay=0,life=math.huge, worldspace=true, piece= "sun1", colormap ={ {1,1,1,0}}, repeatEffect=true}},
		
		--{class='ShieldSphere', options={life=math.huge, pos={0,-1200,0}, size=2048, onActive=true, colormap1 = {{1, 0.75, 0.3, 0.8}}, repeatEffect=true}},
		--{class='ShieldJitter', options={delay=0,life=math.huge, pos={0,-1180,0}, size=1000, precision=22, strength = 0.05, repeatEffect=true}},
		{class='ShieldJitter', options={delay=0,life=math.huge, pos={0,0,0}, size=1000, precision=22, strength = 0.005, repeatEffect=true}},
		{class='ShieldJitter', options={delay=0,life=math.huge, pos={0,0,0}, size=225, precision=22, strength = 0.005, repeatEffect=true}},
		{class='ShieldJitter', options={delay=0,life=math.huge, pos={0,0,0}, size=250, precision=22, strength = 0.029, repeatEffect=true}},
	},
	
	
	jshroudshrike={
		{class='ShieldJitter', options={delay=0,life=math.huge, pos={0,15,0}, size=90, precision=22, strength = 0.015, repeatEffect=true}}, 
	},
	
	
	gvolcano= {
		{class='ShieldJitter', options={delay=0,life=math.huge, pos={0,70,0}, size=150, precision=22, strength = 0.01, repeatEffect=true}},
		{class='ShieldJitter', options={delay=0,life=math.huge, pos={0,1200,0}, size=250, precision=22, strength = 0.005, repeatEffect=true}},
		-- 	{class='SphereDistortion', options={layer=1, worldspace = true, life=math.huge, pos={0,496,0}, growth=135.5, strength=0.15, repeatEffect=true, dieGameFrame = math.huge}},--size=1000 precision=22,piece="cishadersp"
	}, 
	
	glava= {
		{class='ShieldJitter', options={delay=0,life=math.huge, pos={0,0,0}, size=42, precision=22, strength = 0.015, repeatEffect=true}},
	},
	
	
	jwatergate= {
		{class='ShieldJitter', options={delay=0,life=math.huge, pos={0,45,0}, size=20, precision=22, strength = 0.015, repeatEffect=true}},
		{class='ShieldJitter', options={delay=0,life=math.huge, pos={0,15,0}, size=20, precision=28, strength = 0.007, repeatEffect=true}},
	},
	jharbour= {
		{class='ShieldJitter', options={delay=0,life=math.huge, pos={0,35,0}, size=60, precision=28, strength = 0.007, repeatEffect=true}},
	},
	
	jracedart= {
		{class='ShieldSphere', options={life=math.huge, pos={0,0,0}, size=5, colormap1 = {{0.62, 0.9, 0.09, 0.8}}, repeatEffect=true}}
	},
	
	beanstalk= {
		{class='ShieldSphere', options={life=math.huge, pos={0,25,0}, size=300, colormap1 = {{0.62, 0.9, 0.09, 0.8}}, repeatEffect=true}},
		{class='ShieldSphere', options={life=math.huge, pos={0,150,0}, size=220, colormap1 = {{0.42, 0.8, 0.1, 0.8}}, repeatEffect=true}},
		{class='ShieldSphere', options={life=math.huge, pos={0,300,0}, size=150, colormap1 = {{0.42, 0.8, 0.1, 0.8}}, repeatEffect=true}},
		{class='ShieldSphere', options={life=math.huge, pos={0,400,0}, size=140, colormap1 = {{0.40, 0.7, 0.1, 0.8}}, repeatEffect=true}},
		{class='ShieldSphere', options={life=math.huge, pos={0,500,0}, size=130, colormap1 = {{0.3, 0.5, 0.12, 0.8}}, repeatEffect=true}},

		{class='Ribbon', options={color={.7,1,0.1,1}, width=12.5, piece="seed", onActive=true}},

		
		{class='ShieldJitter', options={delay=0,life=math.huge, pos={0,20,0}, size=55, precision=22, strength = 0.005, repeatEffect=true}} 
	},
	
	jestorage= {
		{class='ShieldSphere', options={life=math.huge, pos={0,18,2.3}, size=13.57, colormap1 = {{0.9, 0.6, 0.09, 0.8}}, repeatEffect=true}}
	},	
	
	jglowworms= {
		{class='Ribbon', options={color={.8,0.9,0,1}, width=5.5, piece="Glow2", onActive=false}},
		{class='Ribbon', options={color={.8,0.9,0,1}, width=5.5, piece="Glow6", onActive=false}},
	},
	
	
	gcvehiccorpsemini= {
		{class='ShieldJitter', options={delay=0,life=math.huge, pos={0,0,0}, size=5, precision=12, strength = 0.005, repeatEffect=true}}, 
	},
	
	gcvehiccorpse= {
		{class='ShieldJitter', options={delay=0,life=math.huge, pos={0,0,0}, size=9, precision=22, strength = 0.005, repeatEffect=true}}, 
	},
	
	
	--{class='ShieldJitter', options={layer=-16, life=math.huge, pos={0,58.9,0}, size=100, precision=22, strength = 0.001, repeatEffect=true}},
	jbeefeater= {
		{class='ShieldJitter', options={delay=0,life=math.huge, pos={0,36,-12.5}, size=25, precision=22, strength = 0.015, repeatEffect=true}}, 
		{class='ShieldJitter', options={delay=0,life=math.huge, pos={0,36,-56 }, size=25, precision=22, strength = 0.015, repeatEffect=true}}, 
		{class='ShieldJitter', options={delay=0,life=math.huge, pos={0,36,-92}, size=25, precision=22, strength = 0.015, repeatEffect=true}}, 
	},
	
	jbeefeatertail= {
		{class='ShieldJitter', options={delay=0,life=math.huge, pos={0,18,44}, size=25, precision=22, strength = 0.015, repeatEffect=true}}, 
		{class='ShieldJitter', options={delay=0,life=math.huge, pos={0,18,22}, size=25, precision=22, strength = 0.015, repeatEffect=true}}, 
	},
	
	
	jbeefeatermiddle= {
		{class='ShieldJitter', options={delay=0,life=math.huge, pos={0,37,57}, size=25, precision=22, strength = 0.015, repeatEffect=true}}, 
		{class='ShieldJitter', options={delay=0,life=math.huge, pos={0,37,92}, size=25, precision=22, strength = 0.015, repeatEffect=true}}, 
		{class='ShieldJitter', options={delay=0,life=math.huge, pos={0,37,124}, size=25, precision=22, strength = 0.015, repeatEffect=true}}, 
		
		{class='ShieldJitter', options={delay=0,life=math.huge, pos={0,37,-37}, size=25, precision=22, strength = 0.015, repeatEffect=true}}, 
		{class='ShieldJitter', options={delay=0,life=math.huge, pos={0,37,-69}, size=25, precision=22, strength = 0.015, repeatEffect=true}}, 
		{class='ShieldJitter', options={delay=0,life=math.huge, pos={0,37,-101}, size=25, precision=22, strength = 0.015, repeatEffect=true}}, 
	},


	
	
}


effectUnitDefsXmas = {}

local levelScale = {
	1,
	1.1,
	1.2,
	1.25,
	1.3,
}

-- load presets from unitdefs
for i=1,#UnitDefs do
	local unitDef = UnitDefs[i]
	
	if unitDef.customParams and unitDef.customParams.commtype then
	end
	
	if unitDef.customParams then
		local fxTableStr = unitDef.customParams.lups_unit_fxs
		if fxTableStr then
			local fxTableFunc = loadstring("return "..fxTableStr)
			local fxTable = fxTableFunc()
			effectUnitDefs[unitDef.name] = effectUnitDefs[unitDef.name] or {}
			for i=1,#fxTable do	-- for each item in preset table
				local toAdd = presets[fxTable[i]]
				for i=1,#toAdd do
					table.insert(effectUnitDefs[unitDef.name],toAdd[i])	-- append to unit's lupsFX table
				end
			end
		end
	end
end