local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")
local Types = require(ReplicatedStorage.Classes.Types)
local Sentry = require(ServerStorage.Misc.Sentry)

local CommonUtils = RunService:IsServer() and require(ServerScriptService.System.CommonFunctions)

local BuildermanBehaviorModule = {}

function BuildermanBehaviorModule.Build(self : Types.Ability)
    --uncle dane
    local sentryModel = self.OwnerProperties.Character:GetAttribute("SentryModel") -- its an object i believe
    if not sentryModel then
        warn("you got no sentry model, we should prob fall back but i do later")
        return
    end
    print(sentryModel)
    local sentryFolder = game.ReplicatedStorage.Assets.BuildermanSentries:FindFirstChild(sentryModel)
    local sentry = Sentry.New(sentryFolder, self.Owner)
    
end


return BuildermanBehaviorModule