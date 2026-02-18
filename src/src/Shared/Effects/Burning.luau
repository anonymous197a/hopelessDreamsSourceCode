local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Effect = require(ReplicatedStorage.Classes.Effect)
local Types = require(ReplicatedStorage.Classes.Types)

return Effect.New({
    Name = "Burning",
    Description = "Gradually damages health over time.",
    Duration = 10,
    
    ApplyEffect = function(own: Types.Effect, level: number, char: Model)

        --TODO: Add burning visual effect

        if not RunService:IsServer() then
            warn("on client")
            return
        end

        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if not humanoid then
            return
        end

        local damageAmount = 2 + level * 1 -- Damage amount per tick
        local ticks = own.Duration -- Number of ticks (1 per second)

        for i = 1, ticks do
            if humanoid.Health > 0 then
                humanoid.Health = math.max(humanoid.Health - damageAmount, 0)
            end
            task.wait(1)
        end
    end,

    RemoveEffect = function(own: Types.Effect, char: Model)
        -- Not much is needed here but for the future I think it would be cool to have a visual effect that fades out
    end,
})
