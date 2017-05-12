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

]] --

include "lib_UnitScript.lua"
include "lib_type.lua"

IkChain = {
    ikID = getUniqueID(),
    vSpeed = Vector:new(0, 0, 0),
    vGoal = Vector:new(0, 0, 0),
    base = Vector:new(0, 0, 0),
    segments = {}
jacobiMatrice = {},
boolGoalChanged = false,
boolIsWorldCoordinate = boolIsWorldCoordinate,
boolAktive = true,
boolCounterUnitRotation = boolCounterUnitRotation,
resolution = timeResolution,
boolDeleteIkChain = false
}

IkChain.__index = IkChain



function IkChain:isValidIKPiece(self, PieceID) --TODO Test
    if #self.segments < 1 then return false end

    for k, v in pairs(self.segments) do
        if v.pieceID == PieceID then return true end
    end
    return false
end

function IkChain:SetTransformation(self, valX, valY, valZ) --TODO Test
    for i = 0, i < 3 * #self.segments, 1 do
        -- apply the change to the theta angle
        self.segments[math.floor(i / 3)].apply_angle_change(valX, self.segments[math.floor(i / 3)].get_right());
        -- apply the change to the phi angle
        self.segments[math.floor(i / 3)].apply_angle_change(valY, self.segments[math.floor(i / 3)].get_up());
        -- apply the change to the z angle
        self.segments[math.floor(i / 3)].apply_angle_change(valZ, self.segments[math.floor(i / 3)].get_z());
    end
end

function IkChain:solveIK(self, frames)

    -- prev and curr are for use of halving
    --  last is making sure the iteration gets a better solution than the last iteration,
    --  otherwise revert changes
    local goal_point = self.goalPoint
    local current_point = vector:new(0, 0, 0)
    prev_err, curr_err, last_err = math.huge, math.huge, math.huge
    max_iterations = 200;
    ItterationCount = 0;
    local err_margin = 0.01;

    goal_point - = self.base;
    if (goal_point.norm() > self.getMaxLength()) then
        Spring.Echo("Goal Point out of reachable sphere! Normalied to" .. self.getMaxLength())
        goal_point = (self.goalPoint.normalized() * self.getMaxLength())
    end

    current_point = self.calculate_end_effector();
    -- printPoint("Base Point:",base);
    -- printPoint("Start Point:",current_point);
    -- printPoint("Goal  Point:",goal_point);
    -- save the first err
    prev_err = (goal_point - current_point).norm()
    curr_err = prev_err
    last_err = curr_err

    --while the current point is close enough, stop iterating
    while (curr_err > err_margin) do
        -- calculate the difference between the goal_point and current_point
        local dP = goal_point - current_point;

        -- create the jacovian
        segment_size = #self.segments

        -- build the transpose matrix (easier for eigen matrix construction)
        jac_t = matrix:new(3 * segment_size, 3);
        for ( i = 1, i < 3 * segment_size, 3) do
        selector = math.floor(i / 3)
        row_theta = compute_jacovian_segment(selector, goal_point, self.segments[selector].get_right());
        row_phi = compute_jacovian_segment(selector, goal_point, self.segments[selector].get_up());
        row_z = compute_jacovian_segment(selector, goal_point, self.segments[selector].get_z());

        jac_t.setRow(i, row_theta)

        jac_t.setRow(i + 1, row_phi)

        jac_t.setRow(i + 2, row_z)
    end

        -- compute the final jacovian
        jac = jac_t.transpose()
        pinv_jac = Matrix:new(3 * segment_size, 3)
        pinv_jac = getPseudoInverse(jac)

        changes = pinv_jac * dP

        for i = 1, i < 3 * segment_size, 3 do
            selector = math.floor(i / 3)
            -- save the current transformation on the segments
            self.segments[selector].save_transformation();

            -- apply the change to the theta angle
            self.segments[selector].apply_angle_change(changes[i], segments[selector].get_right())
            -- apply the change to the phi angle
            self.segments[selector].apply_angle_change(changes[i + 1], self.segments[selector].get_up())

            -- apply the change to the z angle
            self.segments[selector].apply_angle_change(changes[i + 2], self.segments[selector].get_up())
        end

        -- compute current_point after making changes
        current_point = self.calculate_end_effector()

        --cout << "current_point: " << vectorString(current_point) << endl;
        --cout << "goal_point: " << vectorString(goal_point) << endl;

        prev_err = curr_err;
        curr_err = (goal_point - current_point).norm();

        halving_count = 0;

        -- make sure we aren't iterating past the solution
        while (curr_err > last_err) do
            -- undo changes
            for int i = 1, segment_size, 1 do
            -- unapply the change to the saved angle
            self.segments[i].load_transformation();
        end

            current_point = self.calculate_end_effector();
            changes = changes / 2;
            -- reapply halved changes
            for i = 1, 3 * segment_size, 3 do
                selector = i / 3
                -- save the current transformation on the segments
                -- segments[selector].save_transformation();

                -- apply the change to the theta angle
                self.segments[selector].apply_angle_change(changes[i], self.segments[selector].get_right());
                -- apply the change to the phi angle
                self.segments[selector].apply_angle_change(changes[i + 1], self.segments[selector].get_up());
                -- apply the change to the z angle
                self.segments[selector].apply_angle_change(changes[i + 2], self.segments[selector].get_z());
            end

            -- compute the end_effector and measure error
            current_point = self.calculate_end_effector();
            prev_err = curr_err;
            curr_err = (goal_point - current_point).norm();

            halving_count + +;
            if (halving_count > 100) then
                break
            end
        end

        if (curr_err > last_err) then
            -- undo changes
            for ( int i = 1, segment_size, i + +) do
            -- unapply the change to the saved angle
            self.segments[i].load_last_transformation();
        end
            current_point = self.calculate_end_effector();
            curr_err = (goal_point - current_point).norm();
            break
        end

        for i = 1, segment_size do
            -- unapply the change to the saved angle
            self.segments[i].save_last_transformation();
        end
        last_err = curr_err;


        -- make sure we don't infinite loop
        ItterationCount = ItterationCount + 1
        if (ItterationCount > max_iterations) then
            break
        end
    end

    self.applyIkTransformation("OVERRIDE");
end




function IkChain:SetUnitIKGoal(self, boolIsWorldCoordinate, vTarget)
    self.boolIsWorldCoordinate = boolIsWorldCoordinate
    self.vGoal = vTarget
end

function IkChain:SetUnitIKSpeed(self)
end

function IkChain:SetUnitIKPieceLimits(self, pieceNumber, vLimX, vLimY, vLimZ)
end


function IkChain:getPseudoInverse(jac)


    ----------------------------------------------------------------------
    -- Template for the pseudo Inverse
    ----------------------------------------------------------------------
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
    ----------------------------------------------------------------------
end


--Returns the Negated Accumulated Rotation
function IkChain:GetBoneBaseRotation(self) -- Point3f IkChain::GetBoneBaseRotation()

    accumulatedRotation = Vector:new(0, 0, 0)
    modelRot = Vector:new(0, 0, 0)
    self.LocalModelPiece * parent = segments[0].piece
    --if the goalPoint is a world coordinate, we need the units rotation out of the picture

    -- while (parent != NULL)then
    -- modelRot= parent->GetRotation();
    -- accumulatedRotation[0] -= modelRot.x;
    -- accumulatedRotation[1] -= modelRot.y;
    -- accumulatedRotation[2] -= modelRot.z;

    -- parent = (parent->parent != NULL? parent->parent: NULL);

    -- }

    --add unit rotation on top
    -- if (isWorldCoordinate)then
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



function IkChain:compute_jacovian_segment(segmentNum, vGoalPoint, vAngle)
    --returns a Point (1 Column, 3 Rows)
    --Returns a Jacovian Segment a row of 3 Elements
    -- Matrix<float, 1, 3>  IkChain::compute_jacovian_segment(int seg_num, Vector3f  goalPoint, Point3f angle) 

    -- Segment *s = &(segments.at(seg_num));
    -- mini is the amount of angle you go in the direction for numerical calculation
    -- float mini = 0.0005;

    -- Point3f transformed_goal = goalPoint;
    -- for(int i=segments.size()-1; i>seg_num; i--) then
    -- transform the goal point to relevence to this segment
    -- by removing all the transformations the segments afterwards
    -- apply on the current segment
    -- transformed_goal -= segments[i].get_end_point();
    -- }

    -- Point3f my_end_effector = calculate_end_effector(seg_num);

    -- transform them both to the origin
    -- if (seg_num-1 >= 0) then
    -- my_end_effector -= calculate_end_effector(seg_num-1);
    -- transformed_goal -= calculate_end_effector(seg_num-1);
    -- }

    -- original end_effector
    -- Point3f original_ee = calculate_end_effector();

    -- angle input is the one you rotate around
    -- remove all the rotations from the previous segments by applying them
    -- AngleAxisf t = AngleAxisf(mini, angle);

    -- transform the segment by some delta(theta)
    -- s->transform(t);
    -- new end_effector
    -- Point3f new_ee = calculate_end_effector();

    -- reverse the transformation afterwards
    -- s->transform(t.inverse());

    -- difference between the end_effectors
    -- since mini is very small, it's an approximation of
    -- the derivative when divided by mini
    -- Vector3f  diff = new_ee - original_ee;

    -- return the row of dx/dtheta, dy/dtheta, dz/dtheta
    -- Matrix<float, 1, 3> ret;
    -- ret << diff[0]/mini, diff[1]/mini, diff[2]/mini;
    -- return ret;
    -- }
end

function calculateEndEffector(self, pSgementNumber)

    --  computes end_effector up to certain number of segments

    local vecReti = self.base()

    for i = 1; #self.segments do
        vecReti = vecReti + self.segments[i].get_end_point()
    end

    -- return calculated end effector
    return vecReti
end




function todoGetUnitMatrice()
end


-- /******************************************************************************/
function IkChain:transformGoalToUnitSpace(self, vecGoal) --TODO test
    matrice = todoGetUnitMatrice()

    vTemp = { [1] = vecGoal.x, [2] = vecGoal.y, [3] = vecGoal.z, [4] = 1 }
    vGoal = { [1] = vecGoal.x, [2] = vecGoal.y, [3] = vecGoal.z, [4] = 1 }
    for y = 1, 4 do
        sum = 0
        for idx = 1, 4 do
            sum = sum + matrice[y][idx] * vecGoal[idx]
        end
        vGoal[y] = sum
    end

    --normalize it
    for y = 1, 4 do
        vGoal[y] = vGoal[y] / vGoal[4]
    end

    return vecGoal
end

function IkChain:getMaxLength(self) --TODO test
    totalLength = 0
    for k, segment in pairs(self.segments) do
        totalLength = totalLength + segment.magnitude
    end
    return totalLength
end

function IkChain:printIkChain(self)
    for k, segment in pairs(self.segments) do
        segment:printSelf()
    end
end

function IkChain:createJacobiMatrice(self)
    --TODO implement
end

function IkChain:applyTransformation(motionBlendMethod)
    -- GoalChanged=false;
    --The Rotation the Pieces accumulate, so each piece can roate as if in world
    -- Point3f pAccRotation= GetBoneBaseRotation();
    -- pAccRotation= Point3f(0,0,0);

    --Get the Unitscript for the Unit that holds the segment
    -- for (auto seg = segments.begin(); seg !=  segments.end(); ++seg) then
    -- seg->alteredInSolve = true;

    -- Point3f velocity = seg->velocity;
    -- Point3f rotation = seg->get_rotation();

    -- rotation -= pAccRotation;
    -- pAccRotation+= rotation;

    -- unit->script->AddAnim(   CUnitScript::ATurn,
    -- (int)(seg->pieceID),  --pieceID 
    -- xAxis,--axis  
    -- 1.0,--velocity(0,0),-- speed
    -- rotation[0], --TODO jointclamp this
    -- 0.0f --acceleration
    -- );

    -- unit->script->AddAnim( CUnitScript::ATurn,
    -- (int)(seg->pieceID),  --pieceID 
    -- yAxis,--axis  
    -- 1.0,--,-- speed
    -- rotation[1], --TODO jointclamp this
    -- 0.0f --acceleration
    -- );

    -- unit->script->AddAnim(  CUnitScript::ATurn,
    -- (int)(seg->pieceID),  --pieceID 
    -- zAxis,--axis  
    -- 1.0,-- speed
    -- rotation[2], --TODO jointclamp this
    -- 0.0f --acceleration
    -- );
    -- }
end

function get_end_point(self) echo("Todo") end

function set_LimitJoint(self) echo("Todo") end

function clampJoint(self) echo("Todo") end

function get_Rotation(self) echo("Todo") end

function get_right(self) echo("Todo") end

function get_up(self) echo("Todo") end

function get_z(self) echo("Todo") end

function get_T(self) echo("Todo") end

function get_Magnitude(self) echo("Todo") end

function save_transformation(self) echo("Todo") end

function load_transformation(self) echo("Todo") end

function save_last_transformation(self) echo("Todo") end

function load_last_transformation(self) echo("Todo") end

function apply_angle_change(self) echo("Todo") end

function resetSegment(self) echo("Todo") end

function randomizeSegment(self) echo("Todo") end

function transformSegment(self) echo("Todo") end

function IkChain:new(unitID, startPiece, endPiece, timeResolution, boolIsWorldCoordinate, boolCounterUnitRotation)
    boolStartPieceValid, _ = checkPiece(unitID, startPiece)
    boolEndPieceValid, PiecList = checkPiece(unitID, endPiece)
    if not boolStartPieceValid or not boolEndPieceValid then return nil, false end
    --forge IK-Chain

    pieceHierarchy = getPieceHierarchy(unitID, piece)
    pieceChain = getPieceChain(pieceHierarchy, startPiece, endPiece)

    for i = 1, table.getn(pieceChain) do
        ikChain.segments[i] = {
            pieceID = pieceChain[i],
            Transformation = AngleAxis:new(0, 0),
            savedTransformation = AngleAxis:new(0, 0),
            lastTransformation = AngleAxis:new(0, 0),
            savedAngle = Vector:new(0, 0, 0),
            pUnitNextPieceBasePoint = Vector:new(0, 0, 0),
            pUnitPieceBasePoint = Vector:new(0, 0, 0),
            magnitude = 0.0,
            vOrgDirVec = Vector:new(0, 0, 0),
        }
        setmetatable(ikChain.segments[i], get_end_point)
        setmetatable(ikChain.segments[i], set_LimitJoint)
        setmetatable(ikChain.segments[i], clampJoint)
        setmetatable(ikChain.segments[i], get_Rotation)
        setmetatable(ikChain.segments[i], get_right)
        setmetatable(ikChain.segments[i], get_up)
        setmetatable(ikChain.segments[i], get_z)
        setmetatable(ikChain.segments[i], get_T)
        setmetatable(ikChain.segments[i], get_Magnitude)
        setmetatable(ikChain.segments[i], save_transformation)
        setmetatable(ikChain.segments[i], load_transformation)
        setmetatable(ikChain.segments[i], save_last_transformation)
        setmetatable(ikChain.segments[i], load_last_transformation)
        setmetatable(ikChain.segments[i], apply_angle_change)
        setmetatable(ikChain.segments[i], resetSegment)
        setmetatable(ikChain.segments[i], randomizeSegment)
        setmetatable(ikChain.segments[i], transformSegment)
    end


    ikChain = initIkChain(ikChain)
    ikChain.jacobiMatrice = createJacobiMatrice(ikChain)



    StartThread(ikLoop, ikChain)
    return ikChain, ikChain.ikID
end

function IkChain:ikLoop(self)
    while self.boolDeleteIkChain == false do
        Sleep(self.resolution)
        while self.boolAktive == true do
            self:solveIK()
            Sleep(self.resolution)
        end
    end
end

setmetatable(IkChain, { __call = function(_, ...) return IkChain.new(...) end })	