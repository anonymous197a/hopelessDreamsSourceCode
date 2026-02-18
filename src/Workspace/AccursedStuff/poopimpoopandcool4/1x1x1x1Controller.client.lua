local player : Player = game.Players.LocalPlayer
local anims : Folder = player.Character.Anims
local animator : Animator = player.Character.Humanoid.Animator
local mouse = player:GetMouse()
local camera = game.Workspace.CurrentCamera

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local InnateCharacterScript = require(game.ReplicatedStorage.Modules.InnateCharacterScript)
local Info = require(game.ReplicatedStorage.Game.Actors.Evil["1x1x1x1"].Information)
local AbilityUIModule = require(game.ReplicatedStorage.Modules.AbilityUIManagerModule)

InnateCharacterScript.Movement:Init()

InnateCharacterScript.Movement:SetSettings(Info.WalkSpeed, Info.SprintSpeed, Info.MaxStamina, Info.StaminaDrainRate, Info.StaminaRegenRate)

local Ability1 = AbilityUIModule.new("Slash", math.huge, 1)
local Ability2 = AbilityUIModule.new("SlashProjectile", math.huge, 2)
local Ability3 = AbilityUIModule.new("Shockwave", math.huge, 3)
local Ability4 = AbilityUIModule.new("Unstable Eye 2.0", math.huge, 4)

local canAction = true

game.ReplicatedStorage.Events.ExecutionEvent.OnClientEvent:Connect(function(delay : number, KillCFrame : CFrame)
	player.Character:PivotTo(KillCFrame)
	player.Character.HumanoidRootPart.Anchored = true
	player.Character.Humanoid.AutoRotate = false
	InnateCharacterScript.Movement.CanMove = false
	task.wait(delay)
	player.Character.HumanoidRootPart.Anchored = false
	player.Character.Humanoid.AutoRotate = true
	InnateCharacterScript.Movement.CanMove = true
	
end)

local turncontrol = 0.75


UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
	if gameProcessedEvent then return end
	if player.Character:GetAttribute("Silenced") then return end
	if canAction then
		if input.KeyCode == Enum.KeyCode.Q then
			Info:Ability2()
		end
		if input.KeyCode == Enum.KeyCode.E then
			Info:Ability3()

			player.Character.Humanoid.AutoRotate = false
			local connection = RunService.RenderStepped:Connect(function(dt)
				local camlook = camera.CFrame.LookVector
				local flatlook = Vector3.new(camlook.X, 0, camlook.Z).Unit -- y set to zero unless you want to also upwards lol
				local currentlook = player.Character.HumanoidRootPart.CFrame.LookVector

				local targetCFrame = CFrame.new(player.Character.HumanoidRootPart.Position, player.Character.HumanoidRootPart.Position + flatlook)
				player.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame:Lerp(targetCFrame, turncontrol * dt)
			end)
			task.delay(3, function() --switch this from manual delay please
				connection:Disconnect()
				player.Character.Humanoid.AutoRotate = true
			end)
		end
		if input.KeyCode == Enum.KeyCode.R then
			Info:Ability4()
		end
	end
end)

RunService.RenderStepped:Connect(function(dt)
	InnateCharacterScript.Movement:Update(dt)
end)

