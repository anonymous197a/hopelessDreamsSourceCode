local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ServerScriptService = game:GetService("ServerScriptService")

local CommonUtils = RunService:IsServer() and require(ServerScriptService.System.CommonFunctions)
local Hitbox = ReplicatedStorage.Classes.Hitbox

local ShedletskyBehaviorModule = {}

local function ToggleSwordVisibility(model : Model, visible : boolean)
    for _, children in pairs(model:GetChildren()) do
        if children:IsA("BasePart") then
            children.Transparency = visible and 0 or 1
        end
    end
end

local SwordsList = {
    -- icedagger, darkheart literally only visual effect
    "LinkedSword",
    "Firebrand",
    "Venomshank",
    "Icedagger",
    "Windforce",
    "Illumina",
    "Darkheart",
    "Ghostwalker"
}

function ShedletskyBehaviorModule.Swing(self)
     --idk twin
    local currentSword = self.OwnerProperties.Character:GetAttribute("CurrentSword") -- thank you lua dynamic variables
    print(currentSword)
    currentSword = SwordsList[currentSword]
    print(currentSword)
    local swordModel : Model = self.OwnerProperties.Character:FindFirstChild(currentSword)
    if swordModel then
        ToggleSwordVisibility(swordModel, true)
    end

    print(currentSword) 
    task.delay(0.8, function()
    Hitbox.New(self.Owner, {
			CFrameOffset = CFrame.new(0, 0, -5),
			Size = Vector3.new(1, 9, 7), -- if you know you know
			Time = 1.2,
			Damage = 30,
			Reason = "Swing Attack",
            EffectsToApply = {{TargetHumanoid = self.OwnerProperties.Humanoid, EffectSettings = {Name = "Stunned", Level = 1, Duration = 3.5}}}
		})
    end)
       
    print("swing thing")  
end

function ShedletskyBehaviorModule.Chicken(self)
   CommonUtils.ApplyEffect({TargetHumanoid = self.OwnerProperties.Humanoid, EffectSettings = {Name = "Regeneration", Level = 3, Duration = 10}})
end

function ShedletskyBehaviorModule.Switch(self)
    self.OwnerProperties.Character:SetAttribute("CurrentSword", (self.OwnerProperties.Character:GetAttribute("CurrentSword") + 1) % 8)
    print(self.OwnerProperties.Character:GetAttribute("CurrentSword"))
end

return ShedletskyBehaviorModule