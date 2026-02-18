local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ServerScriptService = game:GetService("ServerScriptService")

local PlayerSprintManager = RunService:IsServer() and require(ServerScriptService.Managers.PlayerManager.PlayerSprintManager)
local Effect = require(ReplicatedStorage.Classes.Effect)
local Types = require(ReplicatedStorage.Classes.Types)

return Effect.New({
    Name = "Exhaustion",
    Description = "Reduces stamina gain.",
    Duration = 5,
    ShowInGUI = true,
    ApplyEffect = function(_own: Types.Effect, level: number, char: Model)
        PlayerSprintManager.ManagedPlayers[Players.LocalPlayer].RegenMultiplier = 1 - level * 0.1
    end,
    RemoveEffect = function()
        PlayerSprintManager.ManagedPlayers[Players.LocalPlayer].RegenMultiplier = 1
    end,
})