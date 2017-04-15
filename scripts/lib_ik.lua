--[[
This library is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this library; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
MA 02110-1301, USA.

]]--

include "lib_UnitScript.lua"
include "lib_type.lua"

function isValidIKPiece(self, PieceID) --TODO Test
if #self.segments < 1 then return false end

	for k,v in pairs(self.segments) do
		if v.pieceID==PieceID then return true end
	end
return false
end

function SetTransformation(self, valX, valY, valZ) --TODO Test
	for i=0, i < 3* #self.segments, 1 do
				-- apply the change to the theta angle
				self.segments[i/3].apply_angle_change(valX, self.segments[i/3].get_right());
				-- apply the change to the phi angle
				self.segments[i/3].apply_angle_change(valY, self.segments[i/3].get_up());
				-- apply the change to the z angle
				self.segments[i/3].apply_angle_change(valZ, self.segments[i/3].get_z());
	end
end

function solveIK(self, frames)

	-- // prev and curr are for use of halving
	-- // last is making sure the iteration gets a better solution than the last iteration,
	-- // otherwise revert changes
	-- Point3f goal_point;
	-- goal_point = this->goalPoint;
    -- float prev_err, curr_err, last_err = 9999;
    -- Point3f current_point;
    -- int max_iterations = 200;
    -- int count = 0;
    -- float err_margin = 0.01;

    -- goal_point -= base;
    -- if (goal_point.norm() > this->getMaxLength()) {
		-- std::cout<<"Goal Point out of reachable sphere! Normalied to" << this->getMaxLength()<<std::endl;
	    -- goal_point =  ( this->goalPoint.normalized() * this->getMaxLength());
	-- }
	
    -- current_point = calculate_end_effector();
	-- printPoint("Base Point:",base);
	-- printPoint("Start Point:",current_point);
	-- printPoint("Goal  Point:",goal_point);
	-- // save the first err
    -- prev_err = (goal_point - current_point).norm();
    -- curr_err = prev_err;
    -- last_err = curr_err;

	-- // while the current point is close enough, stop iterating
    -- while (curr_err > err_margin) {
		-- // calculate the difference between the goal_point and current_point
	    -- Vector3f dP = goal_point - current_point;

		-- // create the jacovian
	    -- int segment_size = segments.size();

		-- // build the transpose matrix (easier for eigen matrix construction)
	    -- MatrixXf jac_t(3*segment_size, 3);
	    -- for(int i=0; i<3*segment_size; i+=3) {
		    -- Matrix<float, 1, 3> row_theta =compute_jacovian_segment(i/3, goal_point, segments[i/3].get_right());
		    -- Matrix<float, 1, 3> row_phi = compute_jacovian_segment(i/3, goal_point, segments[i/3].get_up());
		    -- Matrix<float, 1, 3> row_z = compute_jacovian_segment(i/3, goal_point, segments[i/3].get_z());

		    -- jac_t(i, 0) = row_theta(0, 0);
		    -- jac_t(i, 1) = row_theta(0, 1);
		    -- jac_t(i, 2) = row_theta(0, 2);

		    -- jac_t(i+1, 0) = row_phi(0, 0);
		    -- jac_t(i+1, 1) = row_phi(0, 1);
		    -- jac_t(i+1, 2) = row_phi(0, 2);

		    -- jac_t(i+2, 0) = row_z(0, 0);
		    -- jac_t(i+2, 1) = row_z(0, 1);
		    -- jac_t(i+2, 2) = row_z(0, 2);
		-- }

		-- // compute the final jacovian
	    -- MatrixXf jac(3, 3*segment_size);
	    -- jac = jac_t.transpose();

	    -- Matrix<float, Dynamic, Dynamic> pseudo_ijac;
	    -- MatrixXf pinv_jac(3*segment_size, 3);
	    -- pinv_jac = pseudoInverse(jac);

	    -- Matrix<float, Dynamic, 1> changes = pinv_jac * dP;


	    -- for(int i=0; i<3*segment_size; i+=3) {
			-- // save the current transformation on the segments
		    -- segments[i/3].save_transformation();

			-- // apply the change to the theta angle
		    -- segments[i/3].apply_angle_change(changes[i], segments[i/3].get_right());
			-- // apply the change to the phi angle
			-- //segments[i/3].apply_angle_change(3.1415/3, segments[i/3].get_up());
			-- segments[i/3].apply_angle_change(changes[i+1], segments[i/3].get_up());
			-- // apply the change to the z angle
		    -- segments[i/3].apply_angle_change(changes[i+2], segments[i/3].get_z());
		-- }

		-- // compute current_point after making changes
	    -- current_point = calculate_end_effector();

		-- //cout << "current_point: " << vectorString(current_point) << endl;
		-- //cout << "goal_point: " << vectorString(goal_point) << endl;

	    -- prev_err = curr_err;
	    -- curr_err = (goal_point - current_point).norm();

	    -- int halving_count = 0;

		-- // make sure we aren't iterating past the solution
	    -- while (curr_err > last_err) {
			-- // undo changes
		    -- for(int i=0; i<segment_size; i++) {
				-- // unapply the change to the saved angle
			    -- segments[i].load_transformation();
			-- }
		    -- current_point = calculate_end_effector();
		    -- changes *= 0.5;
			-- // reapply halved changes
		    -- for(int i=0; i<3*segment_size; i+=3) {
				-- // save the current transformation on the segments
			    -- segments[i/3].save_transformation();

				-- // apply the change to the theta angle
			   -- // segments[i/3].apply_angle_change(3.1415/8, segments[i/3].get_right());
				-- segments[i/3].apply_angle_change(changes[i], segments[i/3].get_right());
				-- // apply the change to the phi angle
			    -- segments[i/3].apply_angle_change(changes[i+1], segments[i/3].get_up());
				-- // apply the change to the z angle
			    -- segments[i/3].apply_angle_change(changes[i+2], segments[i/3].get_z());
			-- }

			-- // compute the end_effector and measure error
		    -- current_point = calculate_end_effector();
		    -- prev_err = curr_err;
		    -- curr_err = (goal_point - current_point).norm();

		    -- halving_count++;
		    -- if (halving_count > 100)
			    -- break;
		-- }

	    -- if (curr_err > last_err) {
			-- // undo changes
		    -- for(int i=0; i<segment_size; i++) {
				-- // unapply the change to the saved angle
			    -- segments[i].load_last_transformation();
			-- }
		    -- current_point = calculate_end_effector();
		    -- curr_err = (goal_point - current_point).norm();
		    -- break;
		-- }
	    -- for(int i=0; i<segment_size; i++) {
			-- // unapply the change to the saved angle
		    -- segments[i].save_last_transformation();
		-- }
	    -- last_err = curr_err;


		-- // make sure we don't infinite loop
	    -- count++;
	    -- if (count > max_iterations) {
		    -- break;
		-- }
	-- }


	-- applyIkTransformation(OVERRIDE);
end

function applyIK(self,boolCounterUnitRotation)

end

function setIKActive(self)

end

function SetUnitIKGoal(self,boolIsWorldCoordinate,vTarget)
	self.vGoal= vTarget
end

function SetUnitIKSpeed(self)

end

function SetUnitIKPieceLimits(self, pieceNumber, vLimX, vLimY, vLimZ)

end

-- //////////////////////////////////////////////////////////////////////
-- // Template for the pseudo Inverse
-- //////////////////////////////////////////////////////////////////////
-- template<typename _Matrix_Type_>
-- _Matrix_Type_ pseudoInverse(const _Matrix_Type_ &a, double epsilon =
-- std::numeric_limits<double>::epsilon())
-- {
	-- Eigen::JacobiSVD< _Matrix_Type_ > svd(a ,Eigen::ComputeThinU |
	-- Eigen::ComputeThinV);

	-- double tolerance =  epsilon * std::max(a.cols(), a.rows()) *svd.singularValues().array().abs()(0);
	-- return svd.matrixV() *  (svd.singularValues().array().abs() >
	-- tolerance).select(svd.singularValues().array().inverse(),
	-- 0).matrix().asDiagonal() * svd.matrixU().adjoint();
-- }
-- //////////////////////////////////////////////////////////////////////



-- void IkChain::solve( float  life_count) 
-- {
	-- // prev and curr are for use of halving
	-- // last is making sure the iteration gets a better solution than the last iteration,
	-- // otherwise revert changes
	-- Point3f goal_point;
	-- goal_point = this->goalPoint;
    -- float prev_err, curr_err, last_err = 9999;
    -- Point3f current_point;
    -- int max_iterations = 200;
    -- int count = 0;
    -- float err_margin = 0.01;

    -- goal_point -= base;
    -- if (goal_point.norm() > this->getMaxLength()) {
		-- std::cout<<"Goal Point out of reachable sphere! Normalied to" << this->getMaxLength()<<std::endl;
	    -- goal_point =  ( this->goalPoint.normalized() * this->getMaxLength());
	-- }
	
    -- current_point = calculate_end_effector();
	-- printPoint("Base Point:",base);
	-- printPoint("Start Point:",current_point);
	-- printPoint("Goal  Point:",goal_point);
	-- // save the first err
    -- prev_err = (goal_point - current_point).norm();
    -- curr_err = prev_err;
    -- last_err = curr_err;

	-- // while the current point is close enough, stop iterating
    -- while (curr_err > err_margin) {
		-- // calculate the difference between the goal_point and current_point
	    -- Vector3f dP = goal_point - current_point;

		-- // create the jacovian
	    -- int segment_size = segments.size();

		-- // build the transpose matrix (easier for eigen matrix construction)
	    -- MatrixXf jac_t(3*segment_size, 3);
	    -- for(int i=0; i<3*segment_size; i+=3) {
		    -- Matrix<float, 1, 3> row_theta =compute_jacovian_segment(i/3, goal_point, segments[i/3].get_right());
		    -- Matrix<float, 1, 3> row_phi = compute_jacovian_segment(i/3, goal_point, segments[i/3].get_up());
		    -- Matrix<float, 1, 3> row_z = compute_jacovian_segment(i/3, goal_point, segments[i/3].get_z());

		    -- jac_t(i, 0) = row_theta(0, 0);
		    -- jac_t(i, 1) = row_theta(0, 1);
		    -- jac_t(i, 2) = row_theta(0, 2);

		    -- jac_t(i+1, 0) = row_phi(0, 0);
		    -- jac_t(i+1, 1) = row_phi(0, 1);
		    -- jac_t(i+1, 2) = row_phi(0, 2);

		    -- jac_t(i+2, 0) = row_z(0, 0);
		    -- jac_t(i+2, 1) = row_z(0, 1);
		    -- jac_t(i+2, 2) = row_z(0, 2);
		-- }

		-- // compute the final jacovian
	    -- MatrixXf jac(3, 3*segment_size);
	    -- jac = jac_t.transpose();

	    -- Matrix<float, Dynamic, Dynamic> pseudo_ijac;
	    -- MatrixXf pinv_jac(3*segment_size, 3);
	    -- pinv_jac = pseudoInverse(jac);

	    -- Matrix<float, Dynamic, 1> changes = pinv_jac * dP;


	    -- for(int i=0; i<3*segment_size; i+=3) {
			-- // save the current transformation on the segments
		    -- segments[i/3].save_transformation();

			-- // apply the change to the theta angle
		    -- segments[i/3].apply_angle_change(changes[i], segments[i/3].get_right());
			-- // apply the change to the phi angle
			-- //segments[i/3].apply_angle_change(3.1415/3, segments[i/3].get_up());
			-- segments[i/3].apply_angle_change(changes[i+1], segments[i/3].get_up());
			-- // apply the change to the z angle
		    -- segments[i/3].apply_angle_change(changes[i+2], segments[i/3].get_z());
		-- }

		-- // compute current_point after making changes
	    -- current_point = calculate_end_effector();

		-- //cout << "current_point: " << vectorString(current_point) << endl;
		-- //cout << "goal_point: " << vectorString(goal_point) << endl;

	    -- prev_err = curr_err;
	    -- curr_err = (goal_point - current_point).norm();

	    -- int halving_count = 0;

		-- // make sure we aren't iterating past the solution
	    -- while (curr_err > last_err) {
			-- // undo changes
		    -- for(int i=0; i<segment_size; i++) {
				-- // unapply the change to the saved angle
			    -- segments[i].load_transformation();
			-- }
		    -- current_point = calculate_end_effector();
		    -- changes *= 0.5;
			-- // reapply halved changes
		    -- for(int i=0; i<3*segment_size; i+=3) {
				-- // save the current transformation on the segments
			    -- segments[i/3].save_transformation();

				-- // apply the change to the theta angle
			   -- // segments[i/3].apply_angle_change(3.1415/8, segments[i/3].get_right());
				-- segments[i/3].apply_angle_change(changes[i], segments[i/3].get_right());
				-- // apply the change to the phi angle
			    -- segments[i/3].apply_angle_change(changes[i+1], segments[i/3].get_up());
				-- // apply the change to the z angle
			    -- segments[i/3].apply_angle_change(changes[i+2], segments[i/3].get_z());
			-- }

			-- // compute the end_effector and measure error
		    -- current_point = calculate_end_effector();
		    -- prev_err = curr_err;
		    -- curr_err = (goal_point - current_point).norm();

		    -- halving_count++;
		    -- if (halving_count > 100)
			    -- break;
		-- }

	    -- if (curr_err > last_err) {
			-- // undo changes
		    -- for(int i=0; i<segment_size; i++) {
				-- // unapply the change to the saved angle
			    -- segments[i].load_last_transformation();
			-- }
		    -- current_point = calculate_end_effector();
		    -- curr_err = (goal_point - current_point).norm();
		    -- break;
		-- }
	    -- for(int i=0; i<segment_size; i++) {
			-- // unapply the change to the saved angle
		    -- segments[i].save_last_transformation();
		-- }
	    -- last_err = curr_err;


		-- // make sure we don't infinite loop
	    -- count++;
	    -- if (count > max_iterations) {
		    -- break;
		-- }
	-- }


	-- applyIkTransformation(OVERRIDE);
   -- }

-- //Returns the Negated Accumulated Rotation
function GetBoneBaseRotation()-- Point3f IkChain::GetBoneBaseRotation()
-- {
	-- Point3f accumulatedRotation = Point3f(0,0,0);
	-- float3  modelRot;
	-- LocalModelPiece * parent = segments[0].piece;
	-- //if the goalPoint is a world coordinate, we need the units rotation out of the picture
  
	-- while (parent != NULL){
		-- modelRot= parent->GetRotation();
		-- accumulatedRotation[0] -= modelRot.x;
		-- accumulatedRotation[1] -= modelRot.y;
		-- accumulatedRotation[2] -= modelRot.z;
		
		-- parent = (parent->parent != NULL? parent->parent: NULL);
			
	-- }

	-- //add unit rotation on top
	-- if (isWorldCoordinate){
		-- const CMatrix44f& matrix = unit->GetTransformMatrix(true);
		-- assert(matrix.IsOrthoNormal());
		-- const float3 angles = matrix.GetEulerAnglesLftHand();

		-- accumulatedRotation(0,0) += angles.x;
		-- accumulatedRotation(1,0) += angles.y;
		-- accumulatedRotation(2,0) += angles.z;
	-- }
	
-- return accumulatedRotation;
-- }
end
	




-- //Returns a Jacovian Segment a row of 3 Elements
-- Matrix<float, 1, 3>  IkChain::compute_jacovian_segment(int seg_num, Vector3f  goalPoint, Point3f angle) 
-- {
	-- Segment *s = &(segments.at(seg_num));
	-- // mini is the amount of angle you go in the direction for numerical calculation
	-- float mini = 0.0005;

	-- Point3f transformed_goal = goalPoint;
	-- for(int i=segments.size()-1; i>seg_num; i--) {
		-- // transform the goal point to relevence to this segment
		-- // by removing all the transformations the segments afterwards
		-- // apply on the current segment
		-- transformed_goal -= segments[i].get_end_point();
	-- }

	-- Point3f my_end_effector = calculate_end_effector(seg_num);

	-- // transform them both to the origin
	-- if (seg_num-1 >= 0) {
		-- my_end_effector -= calculate_end_effector(seg_num-1);
		-- transformed_goal -= calculate_end_effector(seg_num-1);
	-- }

	-- // original end_effector
	-- Point3f original_ee = calculate_end_effector();

	-- // angle input is the one you rotate around
	-- // remove all the rotations from the previous segments by applying them
	-- AngleAxisf t = AngleAxisf(mini, angle);

	-- // transform the segment by some delta(theta)
	-- s->transform(t);
	-- // new end_effector
	-- Point3f new_ee = calculate_end_effector();
	
	-- // reverse the transformation afterwards
	-- s->transform(t.inverse());

		-- // difference between the end_effectors
	-- // since mini is very small, it's an approximation of
	-- // the derivative when divided by mini
	-- Vector3f  diff = new_ee - original_ee;

	-- // return the row of dx/dtheta, dy/dtheta, dz/dtheta
	-- Matrix<float, 1, 3> ret;
	-- ret << diff[0]/mini, diff[1]/mini, diff[2]/mini;
	-- return ret;
-- }

-- // computes end_effector up to certain number of segments
-- Point3f IkChain::calculateEndEffector(int segment_num /* = -1 */) {
	-- Point3f ret;

	-- int segment_num_to_calc = segment_num;
	-- // if default value, compute total end effector
	-- if (segment_num == -1) {
		-- segment_num_to_calc = segments.size() - 1;
	-- }
	-- // else don't mess with it

	-- // start with base
	-- ret = base;
	-- for(int i=0; i<=segment_num_to_calc; i++) {
		-- // add each segments end point vector to the base
		-- ret += segments[i].get_end_point();
	-- }
	-- // return calculated end effector
	-- return ret;
-- }
function todoGetUnitMatrice()


end

function calculateEndEffector(self)
	vecReti = Vector:new(0,0,0)
	--  computes end_effector up to certain number of segments

	vecReti=

	-- // start with base
	-- reti = base;
	-- for(int i=0; i<=segment_num_to_calc; i++) {
		-- // add each segments end point vector to the base
		-- reti += segments[i].get_end_point();
	-- }
	-- // return calculated end effector
	-- return reti ;
-- }
end

-- /******************************************************************************/
function transformGoalToUnitSpace(self,vecGoal) --TODO test
	matrice= todoGetUnitMatrice()

	vTemp={[1]=vecGoal.x,[2]=vecGoal.y,[3]=vecGoal.z,[4]=1}
	vGoal={[1]=vecGoal.x,[2]=vecGoal.y,[3]=vecGoal.z,[4]=1}
	for y=1,4 do
	sum=0	
		for idx=1,4 do
			sum=sum + matrice[y][idx]* vecGoal[idx]
		end
	vGoal[y]=sum
	end
	
	--normalize it
	for y=1,4 do
	vGoal[y]=vGoal[y]/vGoal[4]
	end

	return vecGoal
end

function getMaxLength(self) --TODO test
totalLength=0
	for k,segment in pairs(self.segments) do
		totalLength=totalLength+segment.magnitude
	end
return totalLength
end

function printIkChain(self)
	for k,segment in pairs(self.segments) do
		segment:printSelf()
	end
end

function createJacobiMatrice(self)
--TODO implement
end
function applyTransformation(motionBlendMethod)
	-- GoalChanged=false;
	-- //The Rotation the Pieces accumulate, so each piece can roate as if in world
	-- Point3f pAccRotation= GetBoneBaseRotation();
	-- pAccRotation= Point3f(0,0,0);
	
		-- //Get the Unitscript for the Unit that holds the segment
		-- for (auto seg = segments.begin(); seg !=  segments.end(); ++seg) {
			-- seg->alteredInSolve = true;

			-- Point3f velocity = seg->velocity;
			-- Point3f rotation = seg->get_rotation();

			-- rotation -= pAccRotation;
			-- pAccRotation+= rotation;

			-- unit->script->AddAnim(   CUnitScript::ATurn,
									-- (int)(seg->pieceID),  //pieceID 
									-- xAxis,//axis  
									-- 1.0,//velocity(0,0),// speed
									-- rotation[0], //TODO jointclamp this
									-- 0.0f //acceleration
									-- );

			-- unit->script->AddAnim( CUnitScript::ATurn,
									-- (int)(seg->pieceID),  //pieceID 
									-- yAxis,//axis  
									-- 1.0,//,// speed
									-- rotation[1], //TODO jointclamp this
									-- 0.0f //acceleration
									-- );

			-- unit->script->AddAnim(  CUnitScript::ATurn,
									-- (int)(seg->pieceID),  //pieceID 
									-- zAxis,//axis  
									-- 1.0,// speed
									-- rotation[2], //TODO jointclamp this
									-- 0.0f //acceleration
									-- );
		-- }

end
function createIkChain(unitID, startPiece, endPiece)
	boolStartPieceValid, _=checkPiece(unitID,startPiece)
	boolEndPieceValid, PiecList=checkPiece(unitID,endPiece)
	if not boolStartPieceValid or not boolEndPieceValid then return nil, false end
	--forge IK-Chain

	pieceHierarchy=getPieceHierarchy(unitID,piece)
	pieceChain=getPieceChain(pieceHierarchy,startPiece, endPiece)

local	ikChain={
		ikID=getUniqueID(),
		vSpeed=Vector:new(0,0,0),
		vGoal= Vector:new(0,0,0),
		segments={}
		jacobiMatrice={},
		boolGoalChanged=false,
		boolIsWorldCoordinate=true,
		boolAktive=true,
	}
	for i=1, table.getn(pieceChain) do
		ikChain.segments[i]={
							pieceID =pieceChain[i],
							Transformation = AngleAxis:new(0,0),
							savedTransformation = AngleAxis:new(0,0),
							lastTransformation = AngleAxis:new(0,0),
							savedAngle= Vector:new(0,0,0),
							pUnitNextPieceBasePoint= Vector:new(0,0,0),
							pUnitPieceBasePoint= Vector:new(0,0,0),
							magnitude =0.0,
							vOrgDirVec= Vector:new(0,0,0),
							}
	end
	
	ikChain=initIkChain(ikChain)
	ikChain.jacobiMatrice=createJacobiMatrice(ikChain)
	
	setmetatable(ikChain,solveIK)
	setmetatable(ikChain,applyIK)
	setmetatable(ikChain,setIKActive)
	setmetatable(ikChain,SetUnitIKGoal)
	setmetatable(ikChain,SetUnitIKSpeed)
	setmetatable(ikChain,SetUnitIKPieceLimits)
	setmetatable(ikChain,setTransformation)
	setmetatable(ikChain,isValidIKPiece)
	setmetatable(ikChain,printIkChain)
	setmetatable(ikChain,calculateEndEffector)
	setmetatable(ikChain,applyTransformation)
	setmetatable(ikChain,transformGoalToUnitSpace)
	
	
	return ikChain, ikChain.ikID
end