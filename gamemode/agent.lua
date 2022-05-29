-- Represents one in game bot
Agent = {
    actions = {},
    action_index = 1,
}


function Agent:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Agent:GetAvgDistance()
    local sum = 0
    for i, v in ipairs(self.actions) do
        if v.pos then
            sum = sum + v.pos:Distance(self.target)
        end     
    end
    return sum / #self.actions
end

function Agent:GetFitness()
    return math.ceil(map(self:GetAvgDistance() , 0, 3000, 100, 0))   
end

function Agent:AddAction(action)
    table.insert(self.actions, action)
end

function Agent:GetActions()
    return self.actions
end

function Agent:ClearActions()
    self.actions = {}
    self.action_index = 1
end

function Agent:GetRandomAction()
    return {
        pitch = math.random(-89, 89),
        yaw = math.random(-180, 180),

        forwardspeed = math.random(-250, 250),
        sidemove = math.random(-250, 250),
    }
end


function Agent:SetTarget(target)
    self.target = target
end

function Agent:Reset()
    self.ply:SetPos(Vector(59.20, -141.36, 10143.03))
    self:ClearActions()
end


function Agent:GenerateRandomActions(seconds)
    local actions = {}
    local tickrate = 1 / engine.TickInterval()
    local ticks = seconds * tickrate
    for i = 1, ticks do
        table.insert(actions, self:GetRandomAction())
    end
    return actions
end

function Agent:Think(cmd)
    if #self.actions >= self.action_index then
        local action = self.actions[self.action_index]
        cmd:SetViewAngles(Angle(action.pitch, action.yaw, 0))
        cmd:SetForwardMove(action.forwardspeed)
        cmd:SetSideMove(action.sidemove)
        self.actions[self.action_index].pos = self.ply:GetPos()
        self.action_index = self.action_index + 1
    else
        -- print("All out.")
    end
end

function GM:PlayerSpawn()
end