local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Types = require(ReplicatedStorage.Classes.Types)

type AchievementGroup = {
    Title: string,
    LayoutOrder: number,
    Achievements: {[string]: Types.Achievement}
}

return {
    General = {
        Title = "General",
        LayoutOrder = 1,
        Achievements = {
            Welcome = {
                Title = "Enter The Gates, and be forever Hopeless",
                Description = "Play Hopeless Dreams, for the first time.",
                RewardType = "Currency",
                Amount = 300,
                LayoutOrder = 1,
            },
        },
    },
} :: {[string]: AchievementGroup}
