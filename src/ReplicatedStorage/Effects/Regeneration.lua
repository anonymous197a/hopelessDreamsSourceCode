local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Effect = require(ReplicatedStorage.Classes.Effect)
local Types = require(ReplicatedStorage.Classes.Types)

return Effect.New({
    Name = "Regeneration",
    Description = "Gradually restores health over time.",
    Duration = 10,
    
    ApplyEffect = function(own: Types.Effect, level: number, char: Model)
        if not RunService:IsServer() then
            return
        end

        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if not humanoid then
            return
        end

        local healAmount = 2 + level * 1 -- Heal amount per tick
        local ticks = own.Duration -- Number of ticks (1 per second)

        for _ = 1, ticks do
            if humanoid.Health < humanoid.MaxHealth then
                humanoid.Health = math.min(humanoid.Health + healAmount, humanoid.MaxHealth)
            end
            task.wait(1)
        end
    end,

    RemoveEffect = function(own: Types.Effect, char: Model)
        -- Not much is needed here but for the future I think it would be cool to have a visual effect that fades out
    end,
})
