local Effect = require(game:GetService("ReplicatedStorage").Classes.Effect)

return Effect.New({
    -- make this also masks footsteps
    Name = "Undetectable",
    Description = "Makes the player's aura invisible for the duration of the effect.",
    Duration = 15,
})
