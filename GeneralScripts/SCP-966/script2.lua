--MADE BY A FREIND.
local larm = script.Parent:FindFirstChild("Left Arm")
local rarm = script.Parent:FindFirstChild("Right Arm")

function findNearestTorso(pos)
	local list = game.Workspace:children()
	local torso = nil
	local dist = 1000
	local temp = nil
	local human = nil
	local temp2 = nil
	for x = 1, #list do
		temp2 = list[x]
		if (temp2.className == "Model") and (temp2 ~= script.Parent) then
			temp = temp2:findFirstChild("Torso")
			human = temp2:findFirstChild("Humanoid")
			if (temp ~= nil) and (human ~= nil) and (human.Health > 0) then
				if (temp.Position - pos).magnitude < dist then
					torso = temp
					dist = (temp.Position - pos).magnitude
				end
			end
		end
	end
	return torso
end

function Hit(hit)
	local human = hit.Parent:FindFirstChild("Humanoid")
	if human ~= nil then
		human.Health =  human.Health -8
	end
end

larm.Touched:connect(Hit)
rarm.Touched:connect(Hit)

while true do
	if script.Parent:FindFirstChild("README") == nil then
		script.Parent.Robot.Disabled = true
		script.Parent.Script2.Disabled = true
		script:Destroy()
	end
	wait(0.1)
	local target = findNearestTorso(script.Parent.Torso.Position)
	if target ~= nil then
		script.Parent.Zombie:MoveTo(target.Position, target)
	end
end
