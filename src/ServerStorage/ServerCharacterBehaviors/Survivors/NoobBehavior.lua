local RunService = game:GetService("RunService")
local ServerScriptService = game:GetService("ServerScriptService")

local CommonUtils = RunService:IsServer() and require(ServerScriptService.System.CommonFunctions)

local NoobBehaviorModule = {}

function NoobBehaviorModule.HealBurger(self)
    CommonUtils.ApplyEffect({TargetHumanoid = self.OwnerProperties.Humanoid, EffectSettings = {Name = "Regeneration", Level = 3, Duration = 10}})
end

function NoobBehaviorModule.Epicsauce(self)
    CommonUtils.ApplyEffect({TargetHumanoid = self.OwnerProperties.Humanoid, EffectSettings = {Name = "Speed", Level = 1, Duration = 10}})
    CommonUtils.ApplyEffect({TargetHumanoid = self.OwnerProperties.Humanoid, EffectSettings = {Name = "Burning", Level = 1, Duration = 10}})
end

return NoobBehaviorModule