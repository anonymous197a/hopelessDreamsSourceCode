local RunService = game:GetService("RunService")
local ServerScriptService = game:GetService("ServerScriptService")

local CommonUtils = RunService:IsServer() and require(ServerScriptService.System.CommonFunctions)

local ElliotBehaviorModule = {}

local function ToggleModelVisibility(model : Model, visible : boolean)
    for _, children in pairs(model:GetChildren()) do
        if children:IsA("BasePart") then
            children.Transparency = visible and 0 or 1
        end
    end
end

function ElliotBehaviorModule.Pizza(self)
    local Pizza = self.OwnerProperties.Character:FindFirstChild("Pizza")
    if Pizza then
        ToggleModelVisibility(Pizza, true)
        task.delay(0.6, function()
            ToggleModelVisibility(Pizza, false)
            local FunctionalPizza = Pizza:Clone()
            local Joint = FunctionalPizza:FindFirstChildWhichIsA("JointInstance")
            if Joint then
                Joint:Destroy()
            end
            FunctionalPizza.Name = "ActivePizza"
            FunctionalPizza.CanCollide = true
            FunctionalPizza.CollisionGroup = "Items"
            FunctionalPizza.AssemblyLinearVelocity = (self.OwnerProperties.Character.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 0.5, 0)) * self.ThrowForce
            FunctionalPizza.Parent = workspace:FindFirstChild("Map") and workspace.Map.InGame or workspace.TempObjectFolders
        end)
    else
        warn("this model has no pizza thus cannot throw a pizza")
    end 
end


return ElliotBehaviorModule