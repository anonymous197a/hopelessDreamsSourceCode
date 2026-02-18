local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Emote = require(ReplicatedStorage.Classes.Emote)

return Emote.New({
    Config = {
        Name = "Pick up the phone",
		Quote = "Just pick up the phone",
		Credits = "made by: Dead Sal",
    },
	AnimationIds = "rbxassetid://93683223257915",
	SoundIds = "rbxassetid://107597657413718",
    SpeedMultiplier = 0,
})
