local panel = script.Parent
local typebuttons = panel.TypeButtons
local displaylabel = panel.DisplayPart.SurfaceGui.TextLabel
local enterbutton = panel.EnterButton
local cantype = true
local spawnlocation = panel.SpawnLocation

local request = ""

local validcharacters = {
	"Noob"
}

for _, buttons in typebuttons:GetChildren() do
	buttons.cd.MouseClick:Connect(function(player : Player)
		if cantype then
			request = request .. buttons.Name
			displaylabel.Text = request
		end
	end)
end

enterbutton.cd.MouseClick:Connect(function(player : Player)
	if table.find(validcharacters, request:sub(1, 1):upper() .. request:sub(2):lower()) then
		print("valid")
		cantype = false
		displaylabel.Text = "Spawning " .. request
		local rig = game.ServerStorage.Game.Actors.Normal:FindFirstChild(request:sub(1, 1):upper() .. request:sub(2):lower()).Default:Clone()
		rig.Parent = game.Workspace
		rig:PivotTo(spawnlocation.CFrame)
		request = ""
		task.wait(1)
		displaylabel.Text = request
		cantype = true

	else
		print("invalid")
		cantype = false
		displaylabel.Text = "Invalid character"
		request = ""
		task.wait(1)
		displaylabel.Text = request
		cantype = true
	end
end)


