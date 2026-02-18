local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Character = require(ReplicatedStorage.Classes.Character)
local Types = require(ReplicatedStorage.Classes.Types)

local function OnNoobInit(self: Types.Survivor, Char: Model)
    if not RunService:IsServer() then
        return
    end

    Char:FindFirstChildWhichIsA("Humanoid"):ApplyDescription(Players:GetHumanoidDescriptionFromUserIdAsync(self.Owner.UserId))
end

return Character.CreateSkin("Survivor", "Noob", {
    Config = {
        Name = "Yourself",
        Quote = "the man in the mirror nods his head",
        Price = 1,

        Origin = {},
    },

    OnInit = OnNoobInit,
})
