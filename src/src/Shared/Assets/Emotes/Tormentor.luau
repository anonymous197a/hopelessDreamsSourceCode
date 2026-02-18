local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Emote = require(ReplicatedStorage.Classes.Emote)

return Emote.New({
    Config = {
        Name = "Tormentor",
		Quote = "Aubree hates this show",
		Credits = "made by: x33xeee",
    },
	AnimationIds = "rbxassetid://134180313624603",
	SoundIds = "rbxassetid://138280511177382",
    SpeedMultiplier = 0.1,
})
