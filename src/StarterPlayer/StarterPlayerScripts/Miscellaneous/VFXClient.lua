local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Network = require(ReplicatedStorage.Modules.Network)
local RockModule = require(ReplicatedStorage.Modules.RockModule)
local Utils = require(ReplicatedStorage.Modules.Utils)
local Players = game:GetService("Players")

local VFXClient = {}

function VFXClient:Init()
    print("VFXCLIENT INIT")
    Network:SetConnection("1xShockwave", "REMOTE_EVENT", function(hitPos)
        local distance = (hitPos - Utils.Character.GetRootPart(Players.LocalPlayer).Position).Magnitude
        print(distance)
        Utils.Player.ShakeCamera(math.max(200 - distance, 0) / 1000, 0.4)
        
        local explosion = ReplicatedStorage.VFX["1x1x1x1"].Shockwave:Clone()
        explosion.Parent = workspace
        explosion.Position = hitPos
        RockModule.Ground(hitPos, 8, Vector3.new(2, 2, 2), {workspace.Players}, 8, false, 10)
        for _, children in pairs(explosion:GetDescendants()) do
            if children:IsA("ParticleEmitter") then
                children:Emit(children:GetAttribute("EmitCount"))
            end
            if children:IsA("Sound") then
                children:Play()
            end
        end
        
        print("yo i recieved the event")
    end)
end

return VFXClient