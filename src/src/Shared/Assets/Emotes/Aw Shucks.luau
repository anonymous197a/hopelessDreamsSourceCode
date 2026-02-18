local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Emote = require(ReplicatedStorage.Classes.Emote)
local Types = require(ReplicatedStorage.Classes.Types)
local RunService = game:GetService("RunService")

local function Behavior(self : Types.Emote, character : Model) -- haha im going batshit insane
	if RunService:IsServer() then
		print(character)
		for _, v in pairs(script:GetChildren()) do
			print(v)
			local clone = v:Clone()
			clone.Parent = character
			if clone.Name == "HumanoidRootPart" then
				clone.Light.SpotLight.Color = character.Torso.Color
			end
			for _, j in pairs(clone:GetDescendants()) do
				if j:IsA("Motor6D") then
					print(j)
					j.Part0 = character:FindFirstChild(clone.Name)
					break
				end
			end
		end
	end
end

local function StopBehavior(self : Types.Emote, character : Model)
	if RunService:IsServer() then
		for _, v in pairs(character:GetChildren()) do
			if v:IsA("Model") and table.find(v:GetTags(), "EmoteObject") then
				print(v)
				v:Destroy()
			end
		end
	end
end

return Emote.New({
    Config = {
        Name = "Aw Shucks",
		Quote = "I'LL WATCH AS YOU BLEEED",
		Credits = "made by: Dead Sal",
    },
	AnimationIds = "rbxassetid://93705847005076",
	SoundIds = "rbxassetid://100607467031895",
	SpeedMultiplier = 0.1,
	
	Behaviour = Behavior,
	OnStop = StopBehavior,
})
