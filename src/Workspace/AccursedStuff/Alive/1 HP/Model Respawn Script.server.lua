--how to setup
--1. put script into the character model
--you should be done, once the npc/character dies it respawns
--very easy to configure

local model = script.Parent
local humanoid = model.Humanoid
local resptime = 1
local modclone = model:Clone()

humanoid.Died:connect(function()
	wait(resptime)
	modclone:MakeJoints() -- grr this is deprecated
	modclone.Humanoid.Health = modclone.Humanoid.MaxHealth
	modclone.Parent = workspace
	script.Parent:Destroy()
end)