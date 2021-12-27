--Made by naschemaa.
      local soundIds = {150185006,150184965,150185025}
local sounds = {}
for i=1,#soundIds do
	local s = Instance.new("Sound")
	s.SoundId = "http://www.roblox.com/asset/?id=" .. soundIds[i]
	s.Volume = 1
	s.Parent = script.Parent
	sounds[#sounds + 1] = s
end
fpor = game.Workspace.FindPartOnRay
seen_dist = 200
function canSee(subject,viewer)
	if (not subject) or (not viewer) then return false end
	local sh = subject:findFirstChild("Death")
	local vh = viewer:findFirstChild("Head")
	if (not sh) or (not vh) then return false end
	local vec = sh.Position - vh.Position
	local isInFOV = (vec:Dot(vh.CFrame.lookVector) > 0)
	if (isInFOV) and (vec.magnitude < seen_dist) then
		local ray = Ray.new(vh.Position,vec.unit*200)
		local por = fpor(workspace,ray,viewer,false)
		return (por == nil) or (por:IsDescendantOf(subject))
	end
	return false
end
function canSee2(subject,viewer)
	if (not subject) or (not viewer) then return false end
	local sh = subject:findFirstChild("Death")
	local vh = viewer:findFirstChild("Head")
	if (not sh) or (not vh) then return false end
	local vec = sh.Position - vh.Position
	if (vec.magnitude < seen_dist) then
		local ray = Ray.new(vh.Position,vec.unit*200)
		local por = fpor(workspace,ray,viewer,false)
		return (por == nil) or (por:IsDescendantOf(subject))
	end
	return false
end

function stick(x, y)
	weld = Instance.new("Weld") 
	weld.Part0 = x
	weld.Part1 = y
	local HitPos = x.Position
	local CJ = CFrame.new(HitPos) 
	local C0 = x.CFrame:inverse() *CJ 
	local C1 = y.CFrame:inverse() * CJ 
	weld.C0 = C0 
	weld.C1 = C1 
	weld.Parent = x
	x.Anchored = false
	y.Anchored = false
	
end
stick(script.Parent, script.Parent.Parent.Phys)
function stick2(x, y)
	weld = Instance.new("Weld") 
	weld.Part0 = x
	weld.Part1 = y
	local HitPos = x.Position
	local CJ = CFrame.new(HitPos) 
	local C0 = x.CFrame:inverse() *CJ 
	local C1 = y.CFrame:inverse() * CJ 
	weld.C0 = C0 
	weld.C1 = C1 
	weld.Parent = x
	x.Anchored = false
	y.Anchored = false
end
stick(script.Parent, script.Parent.Parent.Phys4)
function stick2(x, y)
	weld = Instance.new("Weld") 
	weld.Part0 = x
	weld.Part1 = y
	local HitPos = x.Position
	local CJ = CFrame.new(HitPos) 
	local C0 = x.CFrame:inverse() *CJ 
	local C1 = y.CFrame:inverse() * CJ 
	weld.C0 = C0 
	weld.C1 = C1 
	weld.Parent = x
	x.Anchored = false
	y.Anchored = false
end
stick(script.Parent, script.Parent.Parent.Phys5)
stick(script.Parent, script.Parent.Face)
function stick2(x, y)
	weld = Instance.new("Weld") 
	weld.Part0 = x
	weld.Part1 = y
	local HitPos = x.Position
	local CJ = CFrame.new(HitPos) 
	local C0 = x.CFrame:inverse() *CJ 
	local C1 = y.CFrame:inverse() * CJ 
	weld.C0 = C0 
	weld.C1 = C1 
	weld.Parent = x
	x.Anchored = false
	y.Anchored = false
end

stick(script.Parent, script.Parent.Parent.Phys3)
function stick2(x, y)
	weld = Instance.new("Weld") 
	weld.Part0 = x
	weld.Part1 = y
	local HitPos = x.Position
	local CJ = CFrame.new(HitPos) 
	local C0 = x.CFrame:inverse() *CJ 
	local C1 = y.CFrame:inverse() * CJ 
	weld.C0 = C0 
	weld.C1 = C1 
	weld.Parent = x
	x.Anchored = false
	y.Anchored = false
end
stick2(script.Parent, script.Parent.Parent.Phys2)
while true do
	local minmag = nil
	local minply = nil
	local mindir = nil
	local beingwatched = false
	players = game:GetService("Players"):GetChildren()
	for i=1,#players do
		char = players[i].Character
		if char then
			local foundhead = char:FindFirstChild("Head")
			local foundHumanoidRootPart = char:FindFirstChild("HumanoidRootPart")
			local foundhum = char:FindFirstChild("Humanoid")
			if foundhead and foundHumanoidRootPart and foundhum and foundhum.Health > 0 then
				local sub = (script.Parent.CFrame.p - foundhead.CFrame.p)
				local dir = sub.unit
				local mag = sub.magnitude
				if not minmag or minmag > mag then
					minmag = mag
					minply = char:FindFirstChild("HumanoidRootPart")
					mindir = dir
					if canSee(script.Parent.Parent, char) then beingwatched = true end
				end
			end
		end
	end

	if minply and not beingwatched and canSee2(script.Parent.Parent, minply.Parent) then
		if minmag and minmag <= 200 then
			local unit = (script.Parent.Position-minply.Position).unit
			unit = Vector3.new(unit.X,0,unit.Z)
			script.Parent.CFrame = CFrame.new(script.Parent.Position + (unit*-15), Vector3.new(minply.Position.X, script.Parent.Position.Y, minply.Position.Z))
			script.Parent.CFrame = script.Parent.CFrame * CFrame.Angles(0,math.rad(180),0)
			script.Parent.Slide:Play()
			wait(0.000001)
			if minmag < 10 and minply.Parent:FindFirstChild("Humanoid") and minply.Parent.Humanoid.Health > 0 and not beingwatched then
				script.Parent.CFrame = CFrame.new(script.Parent.Position, Vector3.new(minply.Position.X, script.Parent.Position.Y, minply.Position.Z))
				minply.Parent:BreakJoints()
				script.Parent.Kill:Play()
			end
		end
	end
	wait(.000001)
	script.Parent.Slide:Pause()
	wait(.000001)
end
