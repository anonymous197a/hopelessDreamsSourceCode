local player : Player = game.Players.LocalPlayer
local anims : Folder = player.Character.Anims
local animator : Animator = player.Character.Humanoid.Animator
local mouse = player:GetMouse()
local camera = game.Workspace.CurrentCamera

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local InnateCharacterScript = require(game.ReplicatedStorage.Modules.InnateCharacterScript)
local Info = require(game.ReplicatedStorage.Game.Actors.Evil.Mafiosia.Information)
local AbilityUIModule = require(game.ReplicatedStorage.Modules.AbilityUIManagerModule)

InnateCharacterScript.Movement:Init()

InnateCharacterScript.Movement:SetSettings(Info.WalkSpeed, Info.SprintSpeed, Info.MaxStamina, Info.StaminaDrainRate, Info.StaminaRegenRate)

local Ability1 = AbilityUIModule.new("Slash", math.huge, 1)
local Ability2 = AbilityUIModule.new("Bunny", math.huge, 2)
local Ability3 = AbilityUIModule.new("Gun", math.huge, 3)
local Ability4 = AbilityUIModule.new("Dash", math.huge, 4)
local Ability5 = AbilityUIModule.new("Summon", math.huge, 5)
local Ability6 = AbilityUIModule.new("Switch", math.huge, 6)


--Exclusive to Mafia
local shootanim = animator:LoadAnimation(anims.Shoot)
local shootwindupanim = animator:LoadAnimation(anims.ShootWindup)
local slashanim = animator:LoadAnimation(anims.Slash)
local ability3windupanim  = animator:LoadAnimation(anims.Ability3Windup)
local ability3loopanim = animator:LoadAnimation(anims.Ability3Loop)
local ability3crashanim = animator:LoadAnimation(anims.Ability3Crash)
local ability3missanim = animator:LoadAnimation(anims.Ability3Miss)
local ability3hitanim = animator:LoadAnimation(anims.Ability3Hit)



UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
	if gameProcessedEvent then return end
	if player.Character:GetAttribute("Silenced") then return end
	
	if player.Character:GetAttribute("CanAction") then
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			if game.ReplicatedStorage.GameSettings.NoCooldowns.Value == "true" then
				Info:Ability1()
			else
				if Ability1:GetCooldown() == 0 then
					Ability1:StartCooldown(Info.Ability1Cooldown)
					Info:Ability1()
				end
			end
		end
		if input.KeyCode == Enum.KeyCode.Q then
			if game.ReplicatedStorage.GameSettings.NoCooldowns.Value == "true" then
				Info:Ability2(mouse.Hit.Position)
			else
				if Ability2:GetCooldown() == 0 then
					Ability2:StartCooldown(Info.Ability2Cooldown)
					Info:Ability2(mouse.Hit.Position)
				end
			end
		end
		if input.KeyCode == Enum.KeyCode.E then
			if game.ReplicatedStorage.GameSettings.NoCooldowns.Value == "true" then
				Info:Ability3()
			else
				if Ability3:GetCooldown() == 0 then
					Ability3:StartCooldown(Info.Ability3Cooldown)
					Info:Ability3()
				end
			end
		end
		if input.KeyCode == Enum.KeyCode.R then
			if game.ReplicatedStorage.GameSettings.NoCooldowns.Value == "true" then
				Info:Ability4()
			else
				if Ability4:GetCooldown() == 0 then
					Ability4:StartCooldown(Info.Ability4Cooldown)
					Info:Ability4()
				end
			end
		end
	end
end)




RunService.RenderStepped:Connect(function(dt)

	InnateCharacterScript.Movement:Update(dt)
end)

