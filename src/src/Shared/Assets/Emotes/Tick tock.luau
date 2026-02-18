local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Emote = require(ReplicatedStorage.Classes.Emote)

return Emote.New({
    Config = {
        Name = "Tick Tock",
		Quote = "Let me out of here",
		Credits = "made by: Dead Sal",
    },
	AnimationIds = "rbxassetid://130458217516796",
	SoundIds = "rbxassetid://0",
    SpeedMultiplier = 0.1,
})
