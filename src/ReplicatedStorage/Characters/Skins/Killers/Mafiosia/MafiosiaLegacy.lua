local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Character = require(ReplicatedStorage.Classes.Character)
local Types = require(ReplicatedStorage.Classes.Types)

local function OnMafiosiaInit(self: Types.Killer, Char: Model)
    if not RunService:IsServer() then
        return
    end

    Char:FindFirstChildWhichIsA("Humanoid"):ApplyDescription(Players:GetHumanoidDescriptionFromUserIdAsync(self.Owner.UserId))
end

return Character.CreateSkin("Killer", "Mafiosia", {
    Config = {
        Name = "Legacy",
        Quote = "Legacy",
        Price = 9,

        Origin = {},
    },

    OnInit = OnMafiosiaInit(),
})
