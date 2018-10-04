--------------------------------------------------------------------------------
--------------------------------------------------------------------------------



function widget:GetInfo()
	return {
		name = "Spline Path Recording",
		desc = "Records a Units Path into a Spline",
		author = "PicassoCT",
		version = "1.0",
		date = "YearOfTheGNU",
		license = "GNU GPL, v2 or later",
		layer = math.huge,
		hidden = false,
		handler = true,
		enabled = true -- loaded by default?
	}
end
-- ARDevice --> Broadcast 
-- Host --> Broadcast his IP
-- ARDevice --> Send CFG to HostIP
-- HostWaits for Matrice DATA


local Chili, Screen0
SPLINE_PATH_START_KEY = string.byte("~")

boolSplinePathingActive = false
 function widget:KeyPress(key, mods, isRepeat, label, unicode)

	if  key == SPLINE_PATH_START_KEY then
		boolSplinePathingActive = true	
	end
 end
 
LEFT_MOUSE_BUTTON = 1
function widget:MouseRelease(mx, my, mButton)
	if mButton == LEFT_MOUSE_BUTTON and boolSplinePathingActive == true then
		boolSplinePathingActive = false
		-- Add final node (If different)
		local _, pos = spTraceScreenRay(mx, my, true)
		Spring.Echo("Splinestarting")
		if pos then
				Spring.SendLuaRulesMsg("SPLINESTART|"..mx.."|"..mz)
			--> Send to synced for V-Path Unit Creation
		end
	end
end
-- OnClick -> create Virtual Unit, go into FPS
-- while inFPs
	--store PointData
	
--Create Spline from Points






local function get_slope(is_edge, left, right)
   if is_edge then
      return zero_vector
   else
      local t = right.time - left.time
      assert(t > 0, "Non-increasing time sequence")
      return {(right[1] - left[1])/t, 
              (right[2] - left[2])/t, 
              (right[3] - left[3])/t}
   end
end

function smooth(checkpoints, frames_per_second)
   frames_per_second = frames_per_second or 5
   if #checkpoints < 2 then
      return checkpoints
   end
   -- Prepare formulas for each segment of spline
   local formulas = {}
   for segment = 1, #checkpoints - 1 do
      local left = checkpoints[segment]
      local right = checkpoints[segment + 1]
      local t = right.time - left.time
      assert(t > 0, "Non-increasing time sequence")
      local left_deriv = get_slope(segment == 1, 
         checkpoints[segment - 1], right)
      local right_deriv = get_slope(segment == #checkpoints - 1, 
         left, checkpoints[segment + 2])
      formulas[segment] = {}
      for j = 1, 3 do
         local d = left[j]
         local c = left_deriv[j]
         local a = (right[j] - d - c*t) / (t*t)
         local b = 3*a + (c - right_deriv[j])/t
         formulas[segment][j] = {(a - b)/t, b, c, d}
      end
   end
   -- Calculate spline points
   local total_seconds = checkpoints[#checkpoints].time - checkpoints[1].time
   local segment = 1
   local spline = {}
   for frame_no = 0, total_seconds * frames_per_second do
      local t = checkpoints[1].time + frame_no / frames_per_second
      local point = {time = t}
      while segment < #formulas and t > checkpoints[segment + 1].time do
         segment = segment + 1
      end
      t = t - checkpoints[segment].time
      for j = 1, 3 do
         local c = formulas[segment][j]
         point[j] = ((c[1]*t + c[2])*t + c[3])*t + c[4]
      end
      table.insert(spline, point)
   end
   return spline
end

--[[
#include "stdafx.h"
#include <stdlib.h>
#include <gl/glut.h>

// 4 control points for our cubic bezier curve
float Points[4][3] = {
{ 10,10,0 },
{ 5,10,2 },
{ -5,0,0 },
{-10,5,-2}
};

// the level of detail of the curve
unsigned int LOD=20;


void OnKeyPress(unsigned char key,int,int) {
switch(key) {

// increase the LOD
case '+':
++LOD;
break;

// decrease the LOD
case '-':
--LOD;

// have a minimum LOD value
if (LOD<3)
LOD=3;
break;
default:
break;
}

// ask glut to redraw the screen for us...
glutPostRedisplay();
}

void OnDraw() {

// clear the screen & depth buffer
glClear(GL_DEPTH_BUFFER_BIT|GL_COLOR_BUFFER_BIT);

// clear the previous transform
glLoadIdentity();

// set the camera position
gluLookAt( 1,10,30, // eye pos
0,0,0, // aim point
0,1,0); // up direction

glColor3f(1,0,1);

// we will draw lots of little lines to make our curve
glBegin(GL_LINE_STRIP);

for(int i=0;i!=LOD;++i) {

// use the parametric time value 0 to 1
float t = (float)i/(LOD-1);

// nice to pre-calculate 1.0f-t because we will need it frequently
float it = 1.0f-t;

// calculate blending functions
float b0 = t*t*t;
float b1 = 3*t*t*it;
float b2 = 3*t*it*it;
float b3 = it*it*it;

// calculate the x,y and z of the curve point by summing
// the Control vertices weighted by their respective blending
// functions
//
float x = b0*Points[0][0] +
b1*Points[1][0] +
b2*Points[2][0] +
b3*Points[3][0] ;

float y = b0*Points[0][1] +
b1*Points[1][1] +
b2*Points[2][1] +
b3*Points[3][1] ;

float z = b0*Points[0][2] +
b1*Points[1][2] +
b2*Points[2][2] +
b3*Points[3][2] ;

// specify the point
glVertex3f( x,y,z );
}
glEnd();

// draw the Control Vertices
glColor3f(0,1,0);
glPointSize(3);
glBegin(GL_POINTS);
for(int i=0;i!=4;++i) {
glVertex3fv( Points[i] );
}
glEnd();

// draw the hull of the curve
glColor3f(0,1,1);
glBegin(GL_LINE_STRIP);
for(int i=0;i!=4;++i) {
glVertex3fv( Points[i] );
}
glEnd();

// currently we've been drawing to the back buffer, we need
// to swap the back buffer with the front one to make the image visible
glutSwapBuffers();
}


void OnInit() {
// enable depth testing
glEnable(GL_DEPTH_TEST);
}


void OnExit() {
}


void OnReshape(int w, int h)
{
if (h==0)
h=1;

// set the drawable region of the window
glViewport(0,0,w,h);

// set up the projection matrix
glMatrixMode(GL_PROJECTION);
glLoadIdentity();

// just use a perspective projection
gluPerspective(45,(float)w/h,0.1,100);

// go back to modelview matrix so we can move the objects about
glMatrixMode(GL_MODELVIEW);
glLoadIdentity();
}


int main(int argc,char** argv) {

// initialise glut
glutInit(&argc,argv);

// request a depth buffer, RGBA display mode, and we want double buffering
glutInitDisplayMode(GLUT_DEPTH|GLUT_RGBA|GLUT_DOUB LE);

// set the initial window size
glutInitWindowSize(640,480);

// create the window
glutCreateWindow("Bezier Curve: +/- to Change Level of Detail");

// set the function to use to draw our scene
glutDisplayFunc(OnDraw);

// set the function to handle changes in screen size
glutReshapeFunc(OnReshape);

// set the function for the key presses
glutKeyboardFunc(OnKeyPress);

// run our custom initialisation
OnInit();

// set the function to be called when we exit
atexit(OnExit);

// this function runs a while loop to keep the program running.
glutMainLoop();
return 0;
}


]]
