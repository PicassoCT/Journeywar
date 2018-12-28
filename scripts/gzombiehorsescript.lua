include "lib_UnitScript.lua"
include "lib_Animation.lua"
include "lib_jw.lua"
include "lib_OS.lua"
include "lib_type.lua"

pieceTable = generatepiecesTableAndArrayCode(unitID, false)
skeleton = buildSkeleton("center", pieceTable)
LegsAndTentacles = getElementsNStepsDown(4, skeleton)


piecesTable = {}
center = piece("center")
piecesTable[#piecesTable + 1] = center
Mover = piece("Mover")
piecesTable[#piecesTable + 1] = Mover
kuttel = piece("kuttel")
piecesTable[#piecesTable + 1] = kuttel
bhleg1 = piece("bhleg1")
piecesTable[#piecesTable + 1] = bhleg1
foleg1 = piece("foleg1")
piecesTable[#piecesTable + 1] = foleg1
bhleg4 = piece("bhleg4")
piecesTable[#piecesTable + 1] = bhleg4
foleg4 = piece("foleg4")
piecesTable[#piecesTable + 1] = foleg4
thehand = piece("thehand")
piecesTable[#piecesTable + 1] = thehand
bhleg3 = piece("bhleg3")
piecesTable[#piecesTable + 1] = bhleg3
foleg3 = piece("foleg3")
piecesTable[#piecesTable + 1] = foleg3
bhleg2 = piece("bhleg2")
piecesTable[#piecesTable + 1] = bhleg2
foleg2 = piece("foleg2")
piecesTable[#piecesTable + 1] = foleg2

legsTable = {}
bhleg1 = piece("bhleg1")
legsTable[#legsTable + 1] = bhleg1
foleg1 = piece("foleg1")
legsTable[#legsTable + 1] = foleg1
bhleg4 = piece("bhleg4")
legsTable[#legsTable + 1] = bhleg4
foleg4 = piece("foleg4")
legsTable[#legsTable + 1] = foleg4
thehand = piece("thehand")
legsTable[#legsTable + 1] = thehand
bhleg3 = piece("bhleg3")
legsTable[#legsTable + 1] = bhleg3
foleg3 = piece("foleg3")
legsTable[#legsTable + 1] = foleg3
bhleg2 = piece("bhleg2")
legsTable[#legsTable + 1] = bhleg2
foleg2 = piece("foleg2")
legsTable[#legsTable + 1] = foleg2
LegTable = {}

for i = 1, 4 do
	LegTable[i] = {}
	upName = "bhleg" .. i
	downName = "foleg" .. i
	LegTable[i].down = piece(downName)
	LegTable[i].up = piece(upName)
end



Kugel01 = piece("Kugel01")
piecesTable[#piecesTable + 1] = Kugel01
Kugel02 = piece("Kugel02")
piecesTable[#piecesTable + 1] = Kugel02
Kugel03 = piece("Kugel03")
piecesTable[#piecesTable + 1] = Kugel03
Kugel04 = piece("Kugel04")
piecesTable[#piecesTable + 1] = Kugel04
Kugel05 = piece("Kugel05")
piecesTable[#piecesTable + 1] = Kugel05
Kugel06 = piece("Kugel06")
piecesTable[#piecesTable + 1] = Kugel06
Galle = piece("Galle")
piecesTable[#piecesTable + 1] = Galle

Liver = piece("Liver")
piecesTable[#piecesTable + 1] = Liver
Heart = piece("Heart")
piecesTable[#piecesTable + 1] = Heart

leHrtChamb = piece("leHrtChamb")
piecesTable[#piecesTable + 1] = leHrtChamb
riHrtChamb = piece("riHrtChamb")
piecesTable[#piecesTable + 1] = riHrtChamb
Lunge2 = piece("Lunge2")
piecesTable[#piecesTable + 1] = Lunge2
Lf1 = piece("Lf1")
piecesTable[#piecesTable + 1] = Lf1
Lunge1 = piece("Lunge1")
piecesTable[#piecesTable + 1] = Lunge1
Lf2 = piece("Lf2")
piecesTable[#piecesTable + 1] = Lf2
spine = piece("spine")
piecesTable[#piecesTable + 1] = spine
head = piece("head")
piecesTable[#piecesTable + 1] = head
jaw = piece("jaw")
piecesTable[#piecesTable + 1] = jaw
eye = piece("eye")
piecesTable[#piecesTable + 1] = eye
windpipe = piece("windpipe")
piecesTable[#piecesTable + 1] = windpipe

waveTablePipes = {}
gal1 = piece("gal1")
waveTablePipes[#waveTablePipes + 1] = gal1
gal2 = piece("gal2")
waveTablePipes[#waveTablePipes + 1] = gal2
gal3 = piece("gal3")
waveTablePipes[#waveTablePipes + 1] = gal3
gal4 = piece("gal4")
waveTablePipes[#waveTablePipes + 1] = gal4
add1 = piece("add1")
waveTablePipes[#waveTablePipes + 1] = add1
add2 = piece("add2")
waveTablePipes[#waveTablePipes + 1] = add2
add3 = piece("add3")
waveTablePipes[#waveTablePipes + 1] = add3
add4 = piece("add4")
waveTablePipes[#waveTablePipes + 1] = add4
add5 = piece("add5")
waveTablePipes[#waveTablePipes + 1] = add5
add6 = piece("add6")
waveTablePipes[#waveTablePipes + 1] = add6
add7 = piece("add7")
waveTablePipes[#waveTablePipes + 1] = add7
add8 = piece("add8")
waveTablePipes[#waveTablePipes + 1] = add8

waveTablePipesGal = {}
gal1 = piece("gal1")
waveTablePipesGal[#waveTablePipesGal + 1] = gal1
gal2 = piece("gal2")
waveTablePipesGal[#waveTablePipesGal + 1] = gal2
gal3 = piece("gal3")
waveTablePipesGal[#waveTablePipesGal + 1] = gal3
gal4 = piece("gal4")
waveTablePipesGal[#waveTablePipesGal + 1] = gal4

waveTablePipesAdd = {}
add1 = piece("add1")
waveTablePipesAdd[#waveTablePipesAdd + 1] = add1
add2 = piece("add2")
waveTablePipesAdd[#waveTablePipesAdd + 1] = add2
add3 = piece("add3")
waveTablePipesAdd[#waveTablePipesAdd + 1] = add3
add4 = piece("add4")
waveTablePipesAdd[#waveTablePipesAdd + 1] = add4

waveTablePipesAddPerspective = {}
add5 = piece("add5")
waveTablePipesAddPerspective[#waveTablePipesAddPerspective + 1] = add5
add6 = piece("add6")
waveTablePipesAddPerspective[#waveTablePipesAddPerspective + 1] = add6
add7 = piece("add7")
waveTablePipesAddPerspective[#waveTablePipesAddPerspective + 1] = add7
add8 = piece("add8")
waveTablePipesAddPerspective[#waveTablePipesAddPerspective + 1] = add8

pipeTable = { waveTablePipesAdd, waveTablePipesGal, waveTablePipesAddPerspective }
center = piece "center"
boolRegenerate = false
local boolaLittleNap = false

local boolFirstTime = true
local boolOneTime = true
local boolunDamagedVirgin = true
local boolNotDeadYet = true
local viewDistance = 650

SIG_WALK = 2
SIG_RESET = 16
SIG_DEFAULT = 32

local hitPoints = 0
local StartPoints = 0

local ID_DICE = 0
local boolRarmed = 1
local boolLarmed = 1

local boolCrawler = false
--UTILS-----------------------------------------------

Animations = {}

PI_FOURTH = 3.1415 * 2 - (3.14159 / 2)

Animations["run"] = {
	{
		['Time'] = 0,
		['commands'] = {
			{ ['c'] = 'turn', ['p'] = spine, ['a'] = x_axis, ['t'] = PI_FOURTH + 1.914811, ['s'] = 1.671767 },
			{ ['c'] = 'turn', ['p'] = spine, ['a'] = z_axis, ['t'] = -0.145958, ['s'] = 0.560527 },
			{ ['c'] = 'turn', ['p'] = spine, ['a'] = y_axis, ['t'] = -1 * 0.113158, ['s'] = 0.483773 },
			
			{ ['c'] = 'turn', ['p'] = jaw, ['a'] = x_axis, ['t'] = PI_FOURTH + 1.580033, ['s'] = 0.000707 },
			{ ['c'] = 'turn', ['p'] = jaw, ['a'] = z_axis, ['t'] = -0.033723, ['s'] = 0.000217 },
			{ ['c'] = 'turn', ['p'] = jaw, ['a'] = y_axis, ['t'] = -1 * 0.016122, ['s'] = 0.000469 },
			
			{ ['c'] = 'turn', ['p'] = head, ['a'] = x_axis, ['t'] = PI_FOURTH + 1.247980, ['s'] = 1.662386 },
			{ ['c'] = 'turn', ['p'] = head, ['a'] = z_axis, ['t'] = 0.039134, ['s'] = 0.364934 },
			{ ['c'] = 'turn', ['p'] = head, ['a'] = y_axis, ['t'] = -1 * -0.107522, ['s'] = 0.619628 },
			
			{ ['c'] = 'turn', ['p'] = foleg4, ['a'] = x_axis, ['t'] = PI_FOURTH + 2.977930, ['s'] = 1.718160 },
			{ ['c'] = 'turn', ['p'] = foleg4, ['a'] = z_axis, ['t'] = -0.667501, ['s'] = 1.064532 },
			{ ['c'] = 'turn', ['p'] = foleg4, ['a'] = y_axis, ['t'] = -1 * 0.241990, ['s'] = 0.010017 },
			
			{ ['c'] = 'turn', ['p'] = thehand, ['a'] = x_axis, ['t'] = PI_FOURTH + 0.061581, ['s'] = 1.822651 },
			{ ['c'] = 'turn', ['p'] = thehand, ['a'] = z_axis, ['t'] = -0.213877, ['s'] = 0.216029 },
			{ ['c'] = 'turn', ['p'] = thehand, ['a'] = y_axis, ['t'] = -1 * -0.947596, ['s'] = 1.156799 },
			
			{ ['c'] = 'turn', ['p'] = foleg1, ['a'] = x_axis, ['t'] = PI_FOURTH + 2.933083, ['s'] = 1.268011 },
			{ ['c'] = 'turn', ['p'] = foleg1, ['a'] = z_axis, ['t'] = -0.553581, ['s'] = 0.632288 },
			{ ['c'] = 'turn', ['p'] = foleg1, ['a'] = y_axis, ['t'] = -1 * 0.318673, ['s'] = 0.207489 },
			
			{ ['c'] = 'turn', ['p'] = foleg3, ['a'] = x_axis, ['t'] = PI_FOURTH + 2.922546, ['s'] = 3.361750 },
			{ ['c'] = 'turn', ['p'] = foleg3, ['a'] = z_axis, ['t'] = 0.134211, ['s'] = 0.632786 },
			{ ['c'] = 'turn', ['p'] = foleg3, ['a'] = y_axis, ['t'] = -1 * -0.312433, ['s'] = 0.613854 },
			
			{ ['c'] = 'turn', ['p'] = foleg2, ['a'] = x_axis, ['t'] = PI_FOURTH + 1.897717, ['s'] = 1.189725 },
			{ ['c'] = 'turn', ['p'] = foleg2, ['a'] = z_axis, ['t'] = -0.164275, ['s'] = 0.489085 },
			{ ['c'] = 'turn', ['p'] = foleg2, ['a'] = y_axis, ['t'] = -1 * 0.041822, ['s'] = 0.095318 },
			
			{ ['c'] = 'turn', ['p'] = Mover, ['a'] = x_axis, ['t'] = PI_FOURTH + 1.578821, ['s'] = 0.000944 },
			{ ['c'] = 'turn', ['p'] = Mover, ['a'] = z_axis, ['t'] = -0.033352, ['s'] = 0.000289 },
			{ ['c'] = 'turn', ['p'] = Mover, ['a'] = y_axis, ['t'] = -1 * 0.015319, ['s'] = 0.000626 },
			
			{ ['c'] = 'turn', ['p'] = Lamp, ['a'] = x_axis, ['t'] = PI_FOURTH + 0.646446, ['s'] = 0.000543 },
			{ ['c'] = 'turn', ['p'] = Lamp, ['a'] = z_axis, ['t'] = 0.049289, ['s'] = 0.000824 },
			{ ['c'] = 'turn', ['p'] = Lamp, ['a'] = y_axis, ['t'] = -1 * 1.870910, ['s'] = 0.000631 },
			
			{ ['c'] = 'turn', ['p'] = kuttel, ['a'] = x_axis, ['t'] = PI_FOURTH + 1.519477, ['s'] = 0.261342 },
			{ ['c'] = 'turn', ['p'] = kuttel, ['a'] = z_axis, ['t'] = -0.016490, ['s'] = 0.074412 },
			{ ['c'] = 'turn', ['p'] = kuttel, ['a'] = y_axis, ['t'] = -1 * -0.024334, ['s'] = 0.174591 },
			
			{ ['c'] = 'turn', ['p'] = eye, ['a'] = x_axis, ['t'] = PI_FOURTH + 1.578821, ['s'] = 0.000944 },
			{ ['c'] = 'turn', ['p'] = eye, ['a'] = z_axis, ['t'] = -0.033352, ['s'] = 0.000289 },
			{ ['c'] = 'turn', ['p'] = eye, ['a'] = y_axis, ['t'] = -1 * 0.015319, ['s'] = 0.000626 },
			
			{ ['c'] = 'turn', ['p'] = bhleg2, ['a'] = x_axis, ['t'] = PI_FOURTH + 1.996434, ['s'] = 0.032630 },
			{ ['c'] = 'turn', ['p'] = bhleg2, ['a'] = z_axis, ['t'] = -0.104554, ['s'] = 0.028765 },
			{ ['c'] = 'turn', ['p'] = bhleg2, ['a'] = y_axis, ['t'] = -1 * -0.074266, ['s'] = 0.940692 },
			
			{ ['c'] = 'turn', ['p'] = bhleg3, ['a'] = x_axis, ['t'] = PI_FOURTH + 0.946303, ['s'] = 0.920012 },
			{ ['c'] = 'turn', ['p'] = bhleg3, ['a'] = z_axis, ['t'] = 0.054789, ['s'] = 0.121528 },
			{ ['c'] = 'turn', ['p'] = bhleg3, ['a'] = y_axis, ['t'] = -1 * 0.147846, ['s'] = 0.005428 },
			
			{ ['c'] = 'turn', ['p'] = bhleg1, ['a'] = x_axis, ['t'] = PI_FOURTH + 1.815464, ['s'] = 1.981304 },
			{ ['c'] = 'turn', ['p'] = bhleg1, ['a'] = z_axis, ['t'] = -0.132113, ['s'] = 0.198573 },
			{ ['c'] = 'turn', ['p'] = bhleg1, ['a'] = y_axis, ['t'] = -1 * 0.121273, ['s'] = 0.854907 },
			
			{ ['c'] = 'turn', ['p'] = center, ['a'] = x_axis, ['t'] = PI_FOURTH + 1.578821, ['s'] = 0.000944 },
			{ ['c'] = 'turn', ['p'] = center, ['a'] = z_axis, ['t'] = -0.033352, ['s'] = 0.000289 },
			{ ['c'] = 'turn', ['p'] = center, ['a'] = y_axis, ['t'] = -1 * 0.015319, ['s'] = 0.000626 },
			
			{ ['c'] = 'turn', ['p'] = bhleg4, ['a'] = x_axis, ['t'] = PI_FOURTH + 2.011774, ['s'] = 1.617437 },
			{ ['c'] = 'turn', ['p'] = bhleg4, ['a'] = z_axis, ['t'] = -0.214368, ['s'] = 0.676931 },
			{ ['c'] = 'turn', ['p'] = bhleg4, ['a'] = y_axis, ['t'] = -1 * 0.111372, ['s'] = 0.356133 },
			
			{ ['c'] = 'turn', ['p'] = windpipe, ['a'] = x_axis, ['t'] = PI_FOURTH + 1.578821, ['s'] = 0.000944 },
			{ ['c'] = 'turn', ['p'] = windpipe, ['a'] = z_axis, ['t'] = -0.033352, ['s'] = 0.000289 },
			{ ['c'] = 'turn', ['p'] = windpipe, ['a'] = y_axis, ['t'] = -1 * 0.015319, ['s'] = 0.000626 },
		},
	},
	{
		['Time'] = 6,
		['commands'] = {
			{ ['c'] = 'turn', ['p'] = head, ['a'] = x_axis, ['t'] = PI_FOURTH + 1.713760, ['s'] = 1.397339 },
			{ ['c'] = 'turn', ['p'] = head, ['a'] = z_axis, ['t'] = -0.075518, ['s'] = 0.343956 },
			{ ['c'] = 'turn', ['p'] = head, ['a'] = y_axis, ['t'] = -1 * 0.068285, ['s'] = 0.527420 },
			
			{ ['c'] = 'turn', ['p'] = spine, ['a'] = x_axis, ['t'] = PI_FOURTH + 1.655329, ['s'] = 0.778444 },
			{ ['c'] = 'turn', ['p'] = spine, ['a'] = z_axis, ['t'] = -0.058812, ['s'] = 0.261439 },
			{ ['c'] = 'turn', ['p'] = spine, ['a'] = y_axis, ['t'] = -1 * 0.032348, ['s'] = 0.242429 },
		}
	},
	{
		['Time'] = 7,
		['commands'] = {
			{ ['c'] = 'turn', ['p'] = kuttel, ['a'] = x_axis, ['t'] = PI_FOURTH + 1.635086, ['s'] = 0.385363 },
			{ ['c'] = 'turn', ['p'] = kuttel, ['a'] = z_axis, ['t'] = -0.020278, ['s'] = 0.012625 },
			{ ['c'] = 'turn', ['p'] = kuttel, ['a'] = y_axis, ['t'] = -1 * 0.014136, ['s'] = 0.128234 },
		}
	},
	{
		['Time'] = 8,
		['commands'] = {
			{ ['c'] = 'turn', ['p'] = foleg3, ['a'] = x_axis, ['t'] = PI_FOURTH + 2.343386, ['s'] = 2.171851 },
			{ ['c'] = 'turn', ['p'] = foleg3, ['a'] = z_axis, ['t'] = -0.104626, ['s'] = 0.895637 },
			{ ['c'] = 'turn', ['p'] = foleg3, ['a'] = y_axis, ['t'] = -1 * -0.207484, ['s'] = 0.393560 },
			
			{ ['c'] = 'turn', ['p'] = bhleg2, ['a'] = x_axis, ['t'] = PI_FOURTH + 0.959405, ['s'] = 5.185146 },
			{ ['c'] = 'turn', ['p'] = bhleg2, ['a'] = z_axis, ['t'] = 0.221155, ['s'] = 1.628544 },
			{ ['c'] = 'turn', ['p'] = bhleg2, ['a'] = y_axis, ['t'] = -1 * 0.142568, ['s'] = 1.084170 },
			
			{ ['c'] = 'turn', ['p'] = bhleg3, ['a'] = x_axis, ['t'] = PI_FOURTH + 1.823546, ['s'] = 3.289661 },
			{ ['c'] = 'turn', ['p'] = bhleg3, ['a'] = z_axis, ['t'] = 0.174358, ['s'] = 0.448383 },
			{ ['c'] = 'turn', ['p'] = bhleg3, ['a'] = y_axis, ['t'] = -1 * -0.040289, ['s'] = 0.705505 },
			
			{ ['c'] = 'turn', ['p'] = bhleg1, ['a'] = x_axis, ['t'] = PI_FOURTH + 2.127169, ['s'] = 1.558523 },
			{ ['c'] = 'turn', ['p'] = bhleg1, ['a'] = z_axis, ['t'] = -0.277849, ['s'] = 0.728677 },
			{ ['c'] = 'turn', ['p'] = bhleg1, ['a'] = y_axis, ['t'] = -1 * 0.223538, ['s'] = 0.511327 },
			
			{ ['c'] = 'turn', ['p'] = bhleg4, ['a'] = x_axis, ['t'] = PI_FOURTH + 0.729455, ['s'] = 6.411594 },
			{ ['c'] = 'turn', ['p'] = bhleg4, ['a'] = z_axis, ['t'] = -0.007970, ['s'] = 1.031990 },
			{ ['c'] = 'turn', ['p'] = bhleg4, ['a'] = y_axis, ['t'] = -1 * -0.476193, ['s'] = 2.937826 },
			
			{ ['c'] = 'turn', ['p'] = foleg2, ['a'] = x_axis, ['t'] = PI_FOURTH + 3.284622, ['s'] = 6.934522 },
			{ ['c'] = 'turn', ['p'] = foleg2, ['a'] = z_axis, ['t'] = -0.176445, ['s'] = 0.060849 },
			{ ['c'] = 'turn', ['p'] = foleg2, ['a'] = y_axis, ['t'] = -1 * -0.585845, ['s'] = 3.138336 },
		}
	},
	{
		['Time'] = 14,
		['commands'] = {
			{ ['c'] = 'turn', ['p'] = bhleg2, ['a'] = x_axis, ['t'] = PI_FOURTH + 2.257275, ['s'] = 3.539646 },
			{ ['c'] = 'turn', ['p'] = bhleg2, ['a'] = z_axis, ['t'] = 0.136755, ['s'] = 0.230181 },
			{ ['c'] = 'turn', ['p'] = bhleg2, ['a'] = y_axis, ['t'] = -1 * -0.079328, ['s'] = 0.605172 },
			
			{ ['c'] = 'turn', ['p'] = foleg4, ['a'] = x_axis, ['t'] = PI_FOURTH + 1.697587, ['s'] = 3.491844 },
			{ ['c'] = 'turn', ['p'] = foleg4, ['a'] = z_axis, ['t'] = 0.114314, ['s'] = 2.132222 },
			{ ['c'] = 'turn', ['p'] = foleg4, ['a'] = y_axis, ['t'] = -1 * -0.048340, ['s'] = 0.791811 },
			
			{ ['c'] = 'turn', ['p'] = bhleg1, ['a'] = x_axis, ['t'] = PI_FOURTH + 1.101771, ['s'] = 2.796538 },
			{ ['c'] = 'turn', ['p'] = bhleg1, ['a'] = z_axis, ['t'] = -0.076896, ['s'] = 0.548053 },
			{ ['c'] = 'turn', ['p'] = bhleg1, ['a'] = y_axis, ['t'] = -1 * -0.224609, ['s'] = 1.222219 },
			
			{ ['c'] = 'turn', ['p'] = bhleg4, ['a'] = x_axis, ['t'] = PI_FOURTH + 2.114652, ['s'] = 3.777811 },
			{ ['c'] = 'turn', ['p'] = bhleg4, ['a'] = z_axis, ['t'] = -0.605601, ['s'] = 1.629902 },
			{ ['c'] = 'turn', ['p'] = bhleg4, ['a'] = y_axis, ['t'] = -1 * 0.139662, ['s'] = 1.679604 },
			
			{ ['c'] = 'turn', ['p'] = foleg2, ['a'] = x_axis, ['t'] = PI_FOURTH + 1.721432, ['s'] = 4.263246 },
			{ ['c'] = 'turn', ['p'] = foleg2, ['a'] = z_axis, ['t'] = -0.355424, ['s'] = 0.488124 },
			{ ['c'] = 'turn', ['p'] = foleg2, ['a'] = y_axis, ['t'] = -1 * 0.050368, ['s'] = 1.735127 },
		}
	},
	{
		['Time'] = 16,
		['commands'] = {
			{ ['c'] = 'turn', ['p'] = head, ['a'] = x_axis, ['t'] = PI_FOURTH + 2.003366, ['s'] = 1.086022 },
			{ ['c'] = 'turn', ['p'] = head, ['a'] = z_axis, ['t'] = -0.211024, ['s'] = 0.508149 },
			{ ['c'] = 'turn', ['p'] = head, ['a'] = y_axis, ['t'] = -1 * 0.156345, ['s'] = 0.330225 },
			
			{ ['c'] = 'turn', ['p'] = bhleg3, ['a'] = x_axis, ['t'] = PI_FOURTH + 1.052405, ['s'] = 2.570470 },
			{ ['c'] = 'turn', ['p'] = bhleg3, ['a'] = z_axis, ['t'] = 0.407401, ['s'] = 0.776810 },
			{ ['c'] = 'turn', ['p'] = bhleg3, ['a'] = y_axis, ['t'] = -1 * -0.007959, ['s'] = 0.107765 },
			
			{ ['c'] = 'turn', ['p'] = spine, ['a'] = x_axis, ['t'] = PI_FOURTH + 1.427763, ['s'] = 0.853373 },
			{ ['c'] = 'turn', ['p'] = spine, ['a'] = z_axis, ['t'] = 0.015127, ['s'] = 0.277270 },
			{ ['c'] = 'turn', ['p'] = spine, ['a'] = y_axis, ['t'] = -1 * -0.054550, ['s'] = 0.325870 },
			
			{ ['c'] = 'turn', ['p'] = kuttel, ['a'] = x_axis, ['t'] = PI_FOURTH + 1.526754, ['s'] = 0.361106 },
			{ ['c'] = 'turn', ['p'] = kuttel, ['a'] = z_axis, ['t'] = 0.040140, ['s'] = 0.201393 },
			{ ['c'] = 'turn', ['p'] = kuttel, ['a'] = y_axis, ['t'] = -1 * 0.047392, ['s'] = 0.110854 },
			
			{ ['c'] = 'turn', ['p'] = foleg3, ['a'] = x_axis, ['t'] = PI_FOURTH + 3.361003, ['s'] = 3.392055 },
			{ ['c'] = 'turn', ['p'] = foleg3, ['a'] = z_axis, ['t'] = -0.179453, ['s'] = 0.249425 },
			{ ['c'] = 'turn', ['p'] = foleg3, ['a'] = y_axis, ['t'] = -1 * -0.435498, ['s'] = 0.760046 },
		}
	},
	{
		['Time'] = 18,
		['commands'] = {
			{ ['c'] = 'turn', ['p'] = jaw, ['a'] = x_axis, ['t'] = PI_FOURTH + 1.578821, ['s'] = 0.001069 },
			{ ['c'] = 'turn', ['p'] = jaw, ['a'] = z_axis, ['t'] = -0.033352, ['s'] = 0.000327 },
			{ ['c'] = 'turn', ['p'] = jaw, ['a'] = y_axis, ['t'] = -1 * 0.015319, ['s'] = 0.000709 },
		}
	},
	{
		['Time'] = 24,
		['commands'] = {
			{ ['c'] = 'turn', ['p'] = head, ['a'] = x_axis, ['t'] = PI_FOURTH + 1.606202, ['s'] = 1.489365 },
			{ ['c'] = 'turn', ['p'] = head, ['a'] = z_axis, ['t'] = -0.034302, ['s'] = 0.662708 },
			{ ['c'] = 'turn', ['p'] = head, ['a'] = y_axis, ['t'] = -1 * -0.049573, ['s'] = 0.772192 },
			
			{ ['c'] = 'turn', ['p'] = spine, ['a'] = x_axis, ['t'] = PI_FOURTH + 1.044426, ['s'] = 1.437513 },
			{ ['c'] = 'turn', ['p'] = spine, ['a'] = z_axis, ['t'] = 0.081510, ['s'] = 0.248937 },
			{ ['c'] = 'turn', ['p'] = spine, ['a'] = y_axis, ['t'] = -1 * -0.318996, ['s'] = 0.991673 },
		}
	},
	{
		['Time'] = 25,
		['commands'] = {
			{ ['c'] = 'turn', ['p'] = thehand, ['a'] = x_axis, ['t'] = PI_FOURTH + 1.578821, ['s'] = 1.685822 },
			{ ['c'] = 'turn', ['p'] = thehand, ['a'] = z_axis, ['t'] = -0.033352, ['s'] = 0.200583 },
			{ ['c'] = 'turn', ['p'] = thehand, ['a'] = y_axis, ['t'] = -1 * 0.015319, ['s'] = 1.069905 },
			
			{ ['c'] = 'turn', ['p'] = kuttel, ['a'] = x_axis, ['t'] = PI_FOURTH + 1.774305, ['s'] = 0.571270 },
			{ ['c'] = 'turn', ['p'] = kuttel, ['a'] = z_axis, ['t'] = 0.236679, ['s'] = 0.453551 },
			{ ['c'] = 'turn', ['p'] = kuttel, ['a'] = y_axis, ['t'] = -1 * 0.139728, ['s'] = 0.213082 },
			
			{ ['c'] = 'turn', ['p'] = foleg3, ['a'] = x_axis, ['t'] = PI_FOURTH + 2.072460, ['s'] = 3.865628 },
			{ ['c'] = 'turn', ['p'] = foleg3, ['a'] = z_axis, ['t'] = -0.342395, ['s'] = 0.488825 },
			{ ['c'] = 'turn', ['p'] = foleg3, ['a'] = y_axis, ['t'] = -1 * -0.223337, ['s'] = 0.636483 },
			
			{ ['c'] = 'turn', ['p'] = foleg4, ['a'] = x_axis, ['t'] = PI_FOURTH + 3.256168, ['s'] = 3.596724 },
			{ ['c'] = 'turn', ['p'] = foleg4, ['a'] = z_axis, ['t'] = 0.629490, ['s'] = 1.188867 },
			{ ['c'] = 'turn', ['p'] = foleg4, ['a'] = y_axis, ['t'] = -1 * 0.791089, ['s'] = 1.937144 },
			
			{ ['c'] = 'turn', ['p'] = bhleg2, ['a'] = x_axis, ['t'] = PI_FOURTH + 0.524930, ['s'] = 4.330862 },
			{ ['c'] = 'turn', ['p'] = bhleg2, ['a'] = z_axis, ['t'] = 0.400618, ['s'] = 0.659657 },
			{ ['c'] = 'turn', ['p'] = bhleg2, ['a'] = y_axis, ['t'] = -1 * -0.393541, ['s'] = 0.785531 },
			
			{ ['c'] = 'turn', ['p'] = bhleg3, ['a'] = x_axis, ['t'] = PI_FOURTH + 2.161916, ['s'] = 3.328533 },
			{ ['c'] = 'turn', ['p'] = bhleg3, ['a'] = z_axis, ['t'] = 0.248212, ['s'] = 0.477568 },
			{ ['c'] = 'turn', ['p'] = bhleg3, ['a'] = y_axis, ['t'] = -1 * 0.103073, ['s'] = 0.333096 },
			
			{ ['c'] = 'turn', ['p'] = bhleg1, ['a'] = x_axis, ['t'] = PI_FOURTH + 1.924836, ['s'] = 2.469193 },
			{ ['c'] = 'turn', ['p'] = bhleg1, ['a'] = z_axis, ['t'] = -0.692170, ['s'] = 1.845821 },
			{ ['c'] = 'turn', ['p'] = bhleg1, ['a'] = y_axis, ['t'] = -1 * 0.460921, ['s'] = 2.056590 },
			
			{ ['c'] = 'turn', ['p'] = foleg1, ['a'] = x_axis, ['t'] = PI_FOURTH + 1.250242, ['s'] = 5.048521 },
			{ ['c'] = 'turn', ['p'] = foleg1, ['a'] = z_axis, ['t'] = 0.052633, ['s'] = 1.818642 },
			{ ['c'] = 'turn', ['p'] = foleg1, ['a'] = y_axis, ['t'] = -1 * 0.013437, ['s'] = 0.915709 },
			
			{ ['c'] = 'turn', ['p'] = bhleg4, ['a'] = x_axis, ['t'] = PI_FOURTH + 0.489442, ['s'] = 3.750485 },
			{ ['c'] = 'turn', ['p'] = bhleg4, ['a'] = z_axis, ['t'] = -0.393311, ['s'] = 0.489899 },
			{ ['c'] = 'turn', ['p'] = bhleg4, ['a'] = y_axis, ['t'] = -1 * -0.292200, ['s'] = 0.996605 },
			
			{ ['c'] = 'turn', ['p'] = foleg2, ['a'] = x_axis, ['t'] = PI_FOURTH + 3.571097, ['s'] = 4.624163 },
			{ ['c'] = 'turn', ['p'] = foleg2, ['a'] = z_axis, ['t'] = -0.571501, ['s'] = 0.540192 },
			{ ['c'] = 'turn', ['p'] = foleg2, ['a'] = y_axis, ['t'] = -1 * -0.989040, ['s'] = 2.598520 },
		}
	},
	{
		['Time'] = 32,
		['commands'] = {
			{ ['c'] = 'turn', ['p'] = head, ['a'] = x_axis, ['t'] = PI_FOURTH + 1.027331, ['s'] = 3.473225 },
			{ ['c'] = 'turn', ['p'] = head, ['a'] = z_axis, ['t'] = -0.559519, ['s'] = 3.151303 },
			{ ['c'] = 'turn', ['p'] = head, ['a'] = y_axis, ['t'] = -1 * 0.292373, ['s'] = 2.051677 },
			
			{ ['c'] = 'turn', ['p'] = spine, ['a'] = x_axis, ['t'] = PI_FOURTH + 1.573997, ['s'] = 3.177426 },
			{ ['c'] = 'turn', ['p'] = spine, ['a'] = z_axis, ['t'] = -0.053126, ['s'] = 0.807815 },
			{ ['c'] = 'turn', ['p'] = spine, ['a'] = y_axis, ['t'] = -1 * 0.101304, ['s'] = 2.521802 },
		}
	},
	{
		['Time'] = 35,
		['commands'] = {
			{ ['c'] = 'turn', ['p'] = bhleg3, ['a'] = x_axis, ['t'] = PI_FOURTH + 0.435086, ['s'] = 4.317076 },
			{ ['c'] = 'turn', ['p'] = bhleg3, ['a'] = z_axis, ['t'] = 0.397859, ['s'] = 0.374119 },
			{ ['c'] = 'turn', ['p'] = bhleg3, ['a'] = y_axis, ['t'] = -1 * 0.243839, ['s'] = 0.351915 },
			
			{ ['c'] = 'turn', ['p'] = bhleg1, ['a'] = x_axis, ['t'] = PI_FOURTH + 0.835095, ['s'] = 2.972021 },
			{ ['c'] = 'turn', ['p'] = bhleg1, ['a'] = z_axis, ['t'] = -0.138003, ['s'] = 1.511363 },
			{ ['c'] = 'turn', ['p'] = bhleg1, ['a'] = y_axis, ['t'] = -1 * -0.335229, ['s'] = 2.171318 },
			
			{ ['c'] = 'turn', ['p'] = foleg1, ['a'] = x_axis, ['t'] = PI_FOURTH + 2.868972, ['s'] = 4.414717 },
			{ ['c'] = 'turn', ['p'] = foleg1, ['a'] = z_axis, ['t'] = -0.670613, ['s'] = 1.972490 },
			{ ['c'] = 'turn', ['p'] = foleg1, ['a'] = y_axis, ['t'] = -1 * 0.336853, ['s'] = 0.882045 },
			
			{ ['c'] = 'turn', ['p'] = foleg3, ['a'] = x_axis, ['t'] = PI_FOURTH + 3.176024, ['s'] = 2.758910 },
			{ ['c'] = 'turn', ['p'] = foleg3, ['a'] = z_axis, ['t'] = 0.104924, ['s'] = 1.118298 },
			{ ['c'] = 'turn', ['p'] = foleg3, ['a'] = y_axis, ['t'] = -1 * -0.560348, ['s'] = 0.842528 },
		}
	},
	{
		['Time'] = 37,
		['commands'] = {
			{ ['c'] = 'turn', ['p'] = bhleg2, ['a'] = x_axis, ['t'] = PI_FOURTH + 1.927814, ['s'] = 2.805768 },
			{ ['c'] = 'turn', ['p'] = bhleg2, ['a'] = z_axis, ['t'] = -0.095991, ['s'] = 0.993218 },
			{ ['c'] = 'turn', ['p'] = bhleg2, ['a'] = y_axis, ['t'] = -1 * 0.154792, ['s'] = 1.096666 },
			
			{ ['c'] = 'turn', ['p'] = head, ['a'] = x_axis, ['t'] = PI_FOURTH + 0.891518, ['s'] = 0.582055 },
			{ ['c'] = 'turn', ['p'] = head, ['a'] = z_axis, ['t'] = -0.033842, ['s'] = 2.252902 },
			{ ['c'] = 'turn', ['p'] = head, ['a'] = y_axis, ['t'] = -1 * -0.091142, ['s'] = 1.643635 },
			
			{ ['c'] = 'turn', ['p'] = spine, ['a'] = x_axis, ['t'] = PI_FOURTH + 1.870288, ['s'] = 1.269819 },
			{ ['c'] = 'turn', ['p'] = spine, ['a'] = z_axis, ['t'] = -0.335121, ['s'] = 1.208554 },
			{ ['c'] = 'turn', ['p'] = spine, ['a'] = y_axis, ['t'] = -1 * 0.301930, ['s'] = 0.859826 },
			
			{ ['c'] = 'turn', ['p'] = foleg2, ['a'] = x_axis, ['t'] = PI_FOURTH + 1.578821, ['s'] = 3.984551 },
			{ ['c'] = 'turn', ['p'] = foleg2, ['a'] = z_axis, ['t'] = -0.033352, ['s'] = 1.076298 },
			{ ['c'] = 'turn', ['p'] = foleg2, ['a'] = y_axis, ['t'] = -1 * 0.015319, ['s'] = 2.008717 },
		}
	},
	{
		['Time'] = 38,
		['commands'] = {
			{ ['c'] = 'turn', ['p'] = foleg4, ['a'] = x_axis, ['t'] = PI_FOURTH + 1.318394, ['s'] = 14.533304 },
			{ ['c'] = 'turn', ['p'] = foleg4, ['a'] = z_axis, ['t'] = 0.207612, ['s'] = 3.164080 },
			{ ['c'] = 'turn', ['p'] = foleg4, ['a'] = y_axis, ['t'] = -1 * -0.700615, ['s'] = 11.187777 },
			
			{ ['c'] = 'turn', ['p'] = kuttel, ['a'] = x_axis, ['t'] = PI_FOURTH + 1.578821, ['s'] = 0.418893 },
			{ ['c'] = 'turn', ['p'] = kuttel, ['a'] = z_axis, ['t'] = -0.033352, ['s'] = 0.578638 },
			{ ['c'] = 'turn', ['p'] = kuttel, ['a'] = y_axis, ['t'] = -1 * 0.015319, ['s'] = 0.266591 },
			
			{ ['c'] = 'turn', ['p'] = bhleg4, ['a'] = x_axis, ['t'] = PI_FOURTH + 0.686340, ['s'] = 1.476734 },
			{ ['c'] = 'turn', ['p'] = bhleg4, ['a'] = z_axis, ['t'] = -0.546595, ['s'] = 1.149627 },
			{ ['c'] = 'turn', ['p'] = bhleg4, ['a'] = y_axis, ['t'] = -1 * -0.040096, ['s'] = 1.890780 },
		}
	},
	{
		['Time'] = 42,
		['commands'] = {
			{ ['c'] = 'turn', ['p'] = foleg4, ['a'] = x_axis, ['t'] = PI_FOURTH + 2.343670, ['s'] = 3.075829 },
			{ ['c'] = 'turn', ['p'] = foleg4, ['a'] = z_axis, ['t'] = -0.230624, ['s'] = 1.314709 },
			{ ['c'] = 'turn', ['p'] = foleg4, ['a'] = y_axis, ['t'] = -1 * 0.283591, ['s'] = 2.952618 },
			
			{ ['c'] = 'turn', ['p'] = bhleg4, ['a'] = x_axis, ['t'] = PI_FOURTH + 1.578821, ['s'] = 2.677445 },
			{ ['c'] = 'turn', ['p'] = bhleg4, ['a'] = z_axis, ['t'] = -0.033352, ['s'] = 1.539728 },
			{ ['c'] = 'turn', ['p'] = bhleg4, ['a'] = y_axis, ['t'] = -1 * 0.015319, ['s'] = 0.166245 },
		}
	},
	{
		['Time'] = 44,
		['commands'] = {
			{ ['c'] = 'turn', ['p'] = head, ['a'] = x_axis, ['t'] = PI_FOURTH + 1.578821, ['s'] = 2.577388 },
			{ ['c'] = 'turn', ['p'] = head, ['a'] = z_axis, ['t'] = -0.033352, ['s'] = 0.001838 },
			{ ['c'] = 'turn', ['p'] = head, ['a'] = y_axis, ['t'] = -1 * 0.015319, ['s'] = 0.399227 },
			
			{ ['c'] = 'turn', ['p'] = spine, ['a'] = x_axis, ['t'] = PI_FOURTH + 1.578821, ['s'] = 1.093001 },
			{ ['c'] = 'turn', ['p'] = spine, ['a'] = z_axis, ['t'] = -0.033352, ['s'] = 1.131635 },
			{ ['c'] = 'turn', ['p'] = spine, ['a'] = y_axis, ['t'] = -1 * 0.015319, ['s'] = 1.074792 },
		}
	},
	{
		['Time'] = 46,
		['commands'] = {
			{ ['c'] = 'turn', ['p'] = bhleg1, ['a'] = x_axis, ['t'] = PI_FOURTH + 1.330827, ['s'] = 2.478659 },
			{ ['c'] = 'turn', ['p'] = bhleg1, ['a'] = z_axis, ['t'] = -0.069681, ['s'] = 0.341613 },
			{ ['c'] = 'turn', ['p'] = bhleg1, ['a'] = y_axis, ['t'] = -1 * -0.089848, ['s'] = 1.226902 },
			
			{ ['c'] = 'turn', ['p'] = foleg1, ['a'] = x_axis, ['t'] = PI_FOURTH + 1.987245, ['s'] = 4.408633 },
			{ ['c'] = 'turn', ['p'] = foleg1, ['a'] = z_axis, ['t'] = -0.032925, ['s'] = 3.188440 },
			{ ['c'] = 'turn', ['p'] = foleg1, ['a'] = y_axis, ['t'] = -1 * 0.194573, ['s'] = 0.711402 },
		}
	},
	{
		['Time'] = 47,
		['commands'] = {
			{ ['c'] = 'turn', ['p'] = bhleg3, ['a'] = x_axis, ['t'] = PI_FOURTH + 1.164988, ['s'] = 4.379414 },
			{ ['c'] = 'turn', ['p'] = bhleg3, ['a'] = z_axis, ['t'] = 0.027040, ['s'] = 2.224917 },
			{ ['c'] = 'turn', ['p'] = bhleg3, ['a'] = y_axis, ['t'] = -1 * 0.155782, ['s'] = 0.528340 },
			
			{ ['c'] = 'turn', ['p'] = foleg3, ['a'] = x_axis, ['t'] = PI_FOURTH + 2.215515, ['s'] = 5.763054 },
			{ ['c'] = 'turn', ['p'] = foleg3, ['a'] = z_axis, ['t'] = -0.009454, ['s'] = 0.686273 },
			{ ['c'] = 'turn', ['p'] = foleg3, ['a'] = y_axis, ['t'] = -1 * -0.216388, ['s'] = 2.063758 },
		}
	},
	{
		['Time'] = 52,
		['commands'] = {}
	},
}

function vectorBetrag(xv, yv, x2, y2)
	-- determiniere h�heren Wert
	xv = xv - x2
	yv = yv - y2
	
	xv = xv * xv
	yv = yv * yv
	local xyv = xv + yv
	local Betrag = math.sqrt(xyv)
	
	return math.floor(Betrag)
end

------------------------------------------------------
function getRandomAxis()
	if math.random(0, 1) == 1 then
		return x_axis
	else
		return z_axis
	end
end

function resetPosition()
	Signal(SIG_RESET)
	SetSignalMask(SIG_RESET)
	Sleep(500)
	resetT(legsTable, 1, true, false)
	reset(kuttel, 3)
	Sleep(500)
	if math.random(0, 1) == 1 then
		Turn(kuttel, x_axis, math.rad(30), 60)
		Move(kuttel, y_axis, -15, 54)
		WaitForMove(kuttel, y_axis)
		Turn(kuttel, x_axis, math.rad(-5), 12)
		Move(kuttel, y_axis, 0, 54)
		WaitForMove(kuttel, y_axis)
		Turn(kuttel, x_axis, math.rad(0), 12)
	end
	if maRa() == true then
		dropDead()
	else
		
		breathOS(kuttel, 5, 10, LegTable, 4, 450, 6)
	end
end

function dropDead()
	Sleep(800)
	for i=1, math.random(1,4), 1 do
		
		
		if math.random(0, 25) < 15 then
			turnPieceRandDir(spine, 6, 22, -44, 44, -44, 22, -22)
			turnPieceRandDir(head, 6, 22, 21, 44, -44, 22, -22)
		end
		if math.random(0, 9) == 2 then
			signum = signum * -1
			upVal = math.random(3, 9)
			
			for i = 1, upVal do
				turnPieceRandDir(kuttel, 0.75, 22, -22, 66, -66, 22, -22)
				limit = math.random(-20, -15)
				speed = math.random(0.5, 1.2)
				waveATable(waveTablePipesAddPerspective, getRandomAxis(), modFunction, signum, speed, math.random(3, 12), math.random(3, 9), maRa(), 90 * randSign())
				waveATable(waveTablePipesAdd, getRandomAxis(), modFunction, signum, speed, math.random(3, 12), math.random(3, 9), maRa(), 90 * randSign())
				waveATable(waveTablePipes, getRandomAxis(), modFunction, signum, speed, math.random(3, 12), math.random(3, 9), maRa(), 90 * randSign())
				waveATable(legsTable, getRandomAxis(), modFunction, signum, speed, math.random(3, 12), math.random(3, 9), maRa(), 90 * randSign())
				Move(kuttel, y_axis, limit, 42)
				
				Sleep(1400)
			end
			Time = math.ceil(math.random(300, 500))
			Sleep(Time)
			reset(kuttel, 2)
			Move(kuttel, y_axis, 0, 12)

			Sleep(15000)
	
			
			resetT(legsTable, 9, true, false)
		end
		
		Sleep(1000)
	end
end

modULater = 0
function script.HitByWeapon(x, z, weaponDefID, damage)
	if damage > 10 then
		modULater = modULater % 10 + 1
		if modULater > 5 and math.random(0, 1) == 1 then
			EmitSfx(Heart, 1024)
		end
	end
	
	return damage
end

signum = -1
modFunction = function(x) return x end

stopCounter = 0
zombieDefID = Spring.GetUnitDefID(unitID)
function walk()
	Signal(SIG_WALK)
	SetSignalMask(SIG_WALK)
	reset(kuttel, 3)
	reset(center, 3)
	if stopCounter <= 0 then
		StartThread(PlaySoundByUnitDefID, zombieDefID, "sounds/zombie/gzombiehores.ogg", 0.5, 2000, 1, 0)
		stopCounter = math.random(5, 12)
	end
	
	while (true) do
		PlayAnimation("run")
	end
end



function constructSkeleton(unit, piece, offset)
	if (offset == nil) then
		offset = { 0, 0, 0 };
	end
	
	local bones = {};
	local info = Spring.GetUnitPieceInfo(unit, piece);
	
	for i = 1, 3 do
		info.offset[i] = offset[i] + info.offset[i];
	end
	
	bones[piece] = info.offset;
	local map = Spring.GetUnitPieceMap(unit);
	local children = info.children;
	
	if (children) then
		for i, childName in pairs(children) do
			local childId = map[childName];
			local childBones = constructSkeleton(unit, childId, info.offset);
			for cid, cinfo in pairs(childBones) do
				bones[cid] = cinfo;
			end
		end
	end
	return bones;
end


function script.Create()
	StartPoints = Spring.GetUnitHealth(unitID)
	
	speed = math.random(0.5, 1.2)
	waveATable(waveTablePipesAddPerspective, getRandomAxis(), modFunction, signum, speed, math.random(3, 12), math.random(3, 9), maRa(), 90 * randSign())
	waveATable(waveTablePipesAdd, getRandomAxis(), modFunction, signum, speed, math.random(3, 12), math.random(3, 9), maRa(), 90 * randSign())
	waveATable(waveTablePipes, getRandomAxis(), modFunction, signum, speed, math.random(3, 12), math.random(3, 9), maRa(), 90 * randSign())
	
	local map = Spring.GetUnitPieceMap(unitID)
	local offsets = constructSkeleton(unitID, center, { 0, 0, 0 })
	
	for a, anim in pairs(Animations) do
		for i, keyframe in pairs(anim) do
			local commands = keyframe.commands;
			for k, command in pairs(commands) do
				-- commands are described in (c)ommand,(p)iece,(a)xis,(t)arget,(s)peed format
				-- the t attribute needs to be adjusted for move commands from blender's absolute values
				if (command.c == "move") then
					local adjusted = command.t - (offsets[command.p][command.a]);
					Animations[a][i]['commands'][k].t = command.t - (offsets[command.p][command.a]);
				end
			end
		end
	end
	StartThread(defaultEnemyAttack, unitID, SIG_DEFAULT, 10000)
end

local animCmd = { ['turn'] = Turn, ['move'] = Move };

function PlayAnimation(animname)
	
	
	
	if not Animations[animname] then Spring.Echo(animname .. "does not exist") end
	
	local anim = Animations[animname];
	assert(anim, animname)
	for i = 1, #anim do
		local commands = anim[i].commands;
		for j = 1, #commands do
			local cmd = commands[j];
			if cmd.p then
				animCmd[cmd.c](cmd.p, cmd.a, cmd.t, cmd.s);
			end
		end
		if (i < #anim) then
			local t = anim[i + 1]['Time'] - anim[i]['Time'];
			Sleep(t * 33); -- sleep works on milliseconds
		end
	end
end

boolMoving = false
function script.StartMoving()
	boolMoving = true
	
	Signal(SIG_RESET)
	Signal(SIG_DEFAULT)
	
	
	StartThread(walk)
	--normal Zombie
	--walk()
end



function script.StopMoving()
	stopCounter = stopCounter - 1
	-- health check
	--lay down
	boolRegen = false
	boolMoving = false
	Signal(SIG_WALK)
	
	StartThread(resetPosition)
end

function script.AimWeapon1(heading, pitch)
	if boolSnapWeaponLoaded == true then
		Turn(spine, y_axis, heading, 8)
		Turn(spine, x_axis, math.rad(-24), 12)
		Turn(head, x_axis, math.rad(56), 12)
		WaitForTurns(head, spine)
		return true
	else
		return boolSnapWeaponLoaded
	end
end


function script.AimFromWeapon1()
	return head
end

function script.QueryWeapon1()
	return head
end

boolSnapWeaponLoaded = true
function snapAnim()
	boolSnapWeaponLoaded = false
	Turn(spine, x_axis, math.rad(0), 12)
	Turn(head, x_axis, math.rad(0), 12)
	WaitForTurns(head, spine)
	boolSnapWeaponLoaded = true
end

function script.FireWeapon1()
	StartThread(snapAnim)
	
	return true
end



function script.Killed(recentDamage, maxHealth)
	x, y, z = Spring.GetUnitPosition(unitID)
	if x then
		myteam = Spring.GetUnitTeam(unitID)
		T = getAllInCircle(x, z, 4192, unitID, myteam)
		zombieDefID = UnitDefNames["zombie"].id
		
		process(T,
		function(id)
			defID = Spring.GetUnitDefID(id)
			if defID == zombieDefID then return id end
		end,
		function(id)
			if id then
				Spring.SetUnitMoveGoal(id, x, y, z)
			end
		end)
		boolNotDeadYet = false
		Signal(SIG_WALK)
	end
	return 0
end


function script.Activate()
	boolRegenerate = true
	
	return 1
end

function script.Deactivate()
	boolRegenerate = false
	
	
	return 0
end