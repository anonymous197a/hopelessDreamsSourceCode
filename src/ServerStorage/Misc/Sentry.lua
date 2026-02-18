local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ServerScriptService = game:GetService("ServerScriptService")
local StarterPlayer = game:GetService("StarterPlayer")
local SentryModule = {}

local CommonFunctions = require(ServerScriptService.System.CommonFunctions)
local CharacterUtils = require(ReplicatedStorage.Modules.Utils.CharacterUtils)
local AnimationManager = require(StarterPlayer.StarterCharacterScripts.AnimationManager)
local Zone = require(ReplicatedStorage.Packages.Zone)


function SentryModule.New(sentryFolder : Folder, owner : Player)
    local self = {}
    --house keeping stuff
    self.State = "Building"
    self.Level = 1
    self.Owner = owner
    self.Target = nil
    self.Reference = sentryFolder
    --get the model then like clone it and do stuff

    local radius = Instance.new("Part")
    

    self.Model = sentryFolder.LevelOne:Clone()
    self.Model.Parent = workspace
    self.Model:PivotTo(owner.Character.HumanoidRootPart.CFrame * CFrame.new(0, -1, -2))
    self.YawHinge = self.Model.Head.YawHinge
    self.PitchHinge = self.Model.Head.PitchHinge
    self.DeployAnim = CharacterUtils.LoadAnimationFromID(self.Model, "rbxassetid://92007718598031")
    self.Base = self.Model.Torso
    print(self.Owner, self.Model)
    radius.Parent = self.Model
    radius.Shape = Enum.PartType.Ball
    radius.Size = Vector3.new(50, 50, 50)
    radius.Transparency = 0.5
    radius.CanCollide = false
    radius.Anchored = true
    radius.CFrame = owner.Character.HumanoidRootPart.CFrame * CFrame.new(0, -1, -2)
    self.DeployAnim:Play()
    task.wait(5)
    print("finished anim")
    for _, joints in pairs(self.Model.ToggleJoints:GetChildren()) do
        joints.Enabled = false
    end
    self.Zone = Zone.new(radius)
    -- uh this is the only way i can make it track npcs
    self.Zone.partEntered:Connect(function(item)
        if item.Parent:FindFirstChild("Humanoid") and not self.Target then
            if item.Parent:FindFirstChild("Role") then
                self.Target = item.Parent  -- temp self target
                if item.Parent.Role.Value == "Killer" then
                    --self.Target = item.Parent  
                end
            else
                self.Target = item.Parent
            end
        end
    end)
    self.Zone.partExited:Connect(function(item)
        if item.Parent:FindFirstChild("Humanoid") and self.Target == item.Parent then
            self.Target = nil
        end
    end)
    local lastShot = os.clock()
    local params = RaycastParams.new()
    params.FilterDescendantsInstances = {self.Model}
    params.CollisionGroup = "Default"
    self.Connection = RunService.Heartbeat:Connect(function(dt)
        if self.Target and self.Target:FindFirstChild("HumanoidRootPart") then
            local direction = self.Base.CFrame:PointToObjectSpace(self.Target.HumanoidRootPart.Position)
            local flatdir = direction * Vector3.new(1, 0, 1)

            self.YawHinge.TargetAngle = math.deg(Vector3.zAxis:Angle(-flatdir, Vector3.yAxis))
	
	        local axis = Vector3.yAxis:Cross(flatdir)
	        self.PitchHinge.TargetAngle = -math.deg(flatdir:Angle(direction, axis))
            local direction = self.Target.HumanoidRootPart.Position - self.Model.PrimaryPart.Position
            local ray = workspace:Raycast(self.Model.PrimaryPart.Position, direction, params)
            if ray and ray.Instance then 
                print(ray.Instance:FindFirstAncestorOfClass("Model")) 
            end
            if ray and ray.Instance and ray.Instance:FindFirstAncestorOfClass("Model") == self.Target then
                if os.clock() - lastShot > 0.2 then
                    lastShot = os.clock()
                    ray.Instance:FindFirstAncestorOfClass("Model").Humanoid:TakeDamage(1)
                    print("shoot")
                    for _, children in pairs(self.Model.Barrel1.Muzzle:GetChildren()) do
                        children.Enabled = true
                    end
                else
                    for _, children in pairs(self.Model.Barrel1.Muzzle:GetChildren()) do
                        children.Enabled = false
                    end
                end
                CommonFunctions.ApplyEffect({
                    TargetHumanoid = self.Target.Humanoid,
                    EffectSettings = {
                        Name = "Slowness",
                        Level = 1,
                        Duration = 2,
                    }
                })
            end
        end
    end)
    return self
end

function SentryModule.Upgrade(self)

end

function SentryModule.Destroy(self)

end

return SentryModule