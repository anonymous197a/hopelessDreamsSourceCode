local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ServerScriptService = game:GetService("ServerScriptService")
local Projectile = require(ReplicatedStorage.Classes.Projectile)
local ServerStorage = game:GetService("ServerStorage")
local Hitbox = require(ReplicatedStorage.Classes.Hitbox)
local Network = require(ReplicatedStorage.Modules.Network)

local CommonUtils = RunService:IsServer() and require(ServerScriptService.System.CommonFunctions)

--i hate how you cant start with a number in variable names screw this engine screw this language
local BehaviorModule = {}

local function ApplyVelocity(intialVelocity : number, character : Model)
    local velInstance = CommonUtils.ApplyVelocity(character, {InitialVelocity = intialVelocity, LerpDelta = 0.1})
    velInstance.Parent = character
    task.delay(0.3, function()
        velInstance:Destroy()
    end)
end

local function ThrowProjectile(thrower : Player)
    local character = thrower.Character
    Projectile.New({
        SourcePlayer = thrower,
        Model = ServerStorage.Assets.Projectiles:FindFirstChild("1x1x1x1Slash"),
        StartingCFrame = character:FindFirstChild("HumanoidRootPart").CFrame,
        Speed = 30,
        Lifetime = 10,
        ThrowType = "Forward",
        HitboxSettings = {Size = Vector3.new(5, 5, 5),
            Damage = 15,
            IsProjectile = true,
            HitMultiple = true,
            ExecuteOnKill = false,
            Shape = Enum.PartType.Block,
                    
        }  
    })
end

function BehaviorModule.TripleSlash(self)
    ApplyVelocity(-80, self.OwnerProperties.Character)
        
    task.delay(2, function() --idk change this value later
        for _ = 1, 3 do
            ThrowProjectile(self.Owner)
            ApplyVelocity(40, self.OwnerProperties.Character)
            task.wait(0.5)
        end
    end)
end

function BehaviorModule.Shockwave(self)
    print("do the shockwave")
    local character = self.OwnerProperties.Character
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end
    
    local lastHitPos = rootPart.Position - Vector3.new(0, 8, 0) 

    local params = RaycastParams.new()
    params.FilterDescendantsInstances = {character}
    params.FilterType = Enum.RaycastFilterType.Exclude

    for _ = 1, 25 do
        local currentForward = rootPart.CFrame.LookVector
        local goalPos = lastHitPos + (currentForward * 8)

        local ray = workspace:Raycast(goalPos + Vector3.new(0, 10, 0), Vector3.new(0, -20, 0), params)

        if ray then
            local hitPos = ray.Position
            
            local diff = (hitPos - lastHitPos)
            local flatDirection = Vector3.new(diff.X, 0, diff.Z).Unit
            
            if flatDirection.Magnitude == 0 then
                flatDirection = Vector3.new(currentForward.X, 0, currentForward.Z).Unit
            end

            local hitboxCFrame = CFrame.lookAt(hitPos, hitPos + flatDirection) 
                                 * CFrame.Angles(0, 0, math.rad(90))

            Hitbox.New(self.Owner, {
                Size = Vector3.new(30, 10, 10),
                CFrame = hitboxCFrame,
                Shape = Enum.PartType.Cylinder,
            })
            lastHitPos = hitPos
            Network:FireAllClientConnection("1xShockwave", "REMOTE_EVENT", hitPos)
        end

        task.wait(0.1)
    end
end

function BehaviorModule.UnstableEye(self)
    print("do the unstable eye")
    CommonUtils.ApplyEffect({TargetHumanoid = self.OwnerProperties.Humanoid, EffectSettings = {Name = "Speed", Level = 2, Duration = 6}})
    CommonUtils.ApplyEffect({TargetHumanoid = self.OwnerProperties.Humanoid, EffectSettings = {Name = "Blindness", Level = 3, Duration = 6}})
end

return BehaviorModule