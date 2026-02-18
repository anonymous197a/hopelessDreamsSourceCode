local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Emote = require(ReplicatedStorage.Classes.Emote)
local Types = require(ReplicatedStorage.Classes.Types)
local RunService = game:GetService("RunService") -- i hate how i have to manually import this in studio
-- thanks for nothing

local function Behavior(self : Types.Emote, character : Model) -- haha im going batshit insane
	if RunService:IsServer() then
		print(character)
		for _, v in pairs(script:GetChildren()) do
			local clone = v:Clone()
			clone.Parent = character
			if clone.Name == "HumanoidRootPart" then
				clone.Light.SpotLight.Color = character.Torso.Color
			end
			for _, i in pairs(clone:GetDescendants()) do
				if clone.Name == "Left Arm" or clone.Name == "Right Arm" then
					if i:IsA("BasePart") then
						print(i)
						i.Color = character:FindFirstChild(clone.Name).Color
					end
				end
			end

			for _, j in pairs(clone:GetDescendants()) do
				if j:IsA("Motor6D") then
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
		Name = "Subterfuge",
		Quote = "Noise, oh i hear a voice.",
		Credits = "made by: Dead Sal, Churgney Gurgney",
	},
	AnimationIds = "rbxassetid://104014617052565",
	SoundIds = "rbxassetid://88534946735498",
	SpeedMultiplier = 0,

	Behaviour = Behavior,

	OnStop = StopBehavior




})

