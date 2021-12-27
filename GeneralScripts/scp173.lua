--By naschemaa and nathhhknowledge.
--JUST THE SCRIPT (NEED HELP=Private Message)
ragdolldeath = true
cantouchkill = false
debugmode = false
canchase = true
chasing = false
amount = 0
speed = 0.6
heartbeat = game:GetService("RunService").Heartbeat
pathfindingser = game:GetService("PathfindingService")
scphead = script.Parent
hitbox = script.Parent.Hitbox
deathsound = script.Parent.Death
killsound = script.Parent.Kill
jumpscaresounds = {scphead.Jumpscare,scphead.Jumpscare2,scphead.Jumpscare3,scphead.Jumpscare4,scphead.Jumpscare5,scphead.Jumpscare6}
concretemovesound = script.Parent["Concrete Moving"]
canjumpscare = false
distance = 120
function checkhowmanycharactersseeme()
	while heartbeat:wait() do
		amount = 0
		for i,v in pairs(workspace:GetChildren()) do
			if v.ClassName == "Model" then
				local characterhumanoid = v:findFirstChildOfClass("Humanoid")
				local characterscpdet = v:findFirstChild("SCPDetection")
				local characterhead = v:findFirstChild("Head")
				if characterhumanoid and characterscpdet then
					if characterhumanoid.Health > 0 then
						if (characterscpdet.Position - scphead.Position).magnitude < distance then
							if characterhead.Orientation.y > characterscpdet.Orientation.y - 90 and characterhead.Orientation.y < characterscpdet.Orientation.y + 90 then
								amount = amount + 1
								if debugmode then
									print(v.Name)
								end
							else
								--do n o t h i n g
							end
						end
					end
				end
			end
		end
		if debugmode then
			print("people staring at this thing: "..amount)
		end
	end
end
function adddetectors()
	while heartbeat:wait() do
		for i,v in pairs(workspace:GetChildren()) do
			if v.ClassName == "Model" then
				local characterhumanoid = v:findFirstChildOfClass("Humanoid")
				local characterhead = v:findFirstChild("Head")
				if characterhumanoid and characterhead then
					if characterhumanoid.Health <= 0 then
						if v:findFirstChild("SCPDetection") then
							v:findFirstChild("SCPDetection"):destroy()
						end
					else
						if not v:findFirstChild("SCPDetection") then
							local lookpart = Instance.new("Part", v)
							lookpart.CanCollide = false
							lookpart.Size = Vector3.new(1,1,1)
							lookpart.Anchored = true
							lookpart.Shape = "Cylinder"
							lookpart.Transparency = 1
							if debugmode then
								lookpart.Transparency = 0
							end
							lookpart.Name = "SCPDetection"
							local deed = false
							local function lookatme()
								local hed = characterhead
								while heartbeat:wait() do
									lookpart.CFrame = CFrame.new(hed.Position, scphead.Position)
								end
							end
							spawn(lookatme)
						end
					end
				end
			end
		end
	end
end
function orientation()
	while heartbeat:wait() do
		scphead.Orientation = Vector3.new(0,scphead.Orientation.y,0)
	end
end
function kill(part)
	if cantouchkill then
		if part.Parent then
			local victimhumanoid = part.Parent:findFirstChildOfClass("Humanoid")
			if victimhumanoid then
				if victimhumanoid.Health > 0 then
					killsound:Play()
					for i,v in pairs(victimhumanoid.Parent:GetChildren()) do
						if v.ClassName == "Script" or v.ClassName == "LocalScript" then
							v.Disabled = true
						end
					end
					victimhumanoid.Parent:BreakJoints()
					victimhumanoid.Health = 0
					if ragdolldeath then
						ragdollkill(victimhumanoid.Parent)
					end
					if scphead:findFirstChild("ChaseWho") then
						scphead:findFirstChild("ChaseWho"):destroy()
					end
				end
			end
		end
	end
end
hitbox.Touched:connect(kill)
going = false
function attack()
	while heartbeat:wait() do
		if amount == 0 and canchase then
			cantouchkill = true
			canjumpscare = true
			going = true
			for i,v in pairs(workspace:GetChildren()) do
				if v.ClassName == "Model" and v.Name ~= scphead.Parent.Name then
					local characterhumanoid = v:findFirstChildOfClass("Humanoid")
					local characterhead = v:findFirstChild("Head")
					if characterhumanoid and characterhead then
						if characterhumanoid.Health > 0 then
							if not scphead:findFirstChild("ChaseWho") then
								chasewho = Instance.new("ObjectValue", scphead)
								chasewho.Name = "ChaseWho"
								chasewho.Value = characterhead
							end
							if (chasewho.Value.Position - scphead.Position).magnitude < distance then
								chasing = true
								local path = pathfindingser:FindPathAsync(scphead.Position, chasewho.Value.Position, distance)
								local waypoints = path:GetWaypoints()
								if path.Status == Enum.PathStatus.Success then
									for i,v in pairs(waypoints) do
										if i >= 3 then
											if amount == 0 then
												scphead.Anchored = true
												scphead.CFrame = CFrame.new(v.Position)
												scphead.CFrame = scphead.CFrame * CFrame.new(0,6.6/2,0)
												scphead.CFrame = CFrame.new(scphead.Position, chasewho.Value.Position) * CFrame.fromEulerAnglesXYZ(-0.1,0,0)
												concretemovesound.Volume = 2
												cantouchkill = true
												wait(0.05)
											end
										end
									end
								else
									scphead.Anchored = false
								end
								chasing = false
								concretemovesound.Volume = 0
							else
								chasewho:destroy()
								chasing = false
							end
						elseif characterhumanoid.Health <= 0 then
							scphead.Anchored = true
							chasing = false
						end
					end
				end
			end
		else
			if going then
				for i,v in pairs(workspace:GetChildren()) do
					if v.ClassName == "Model" then
						local characterhumanoid = v:findFirstChildOfClass("Humanoid")
						local characterhead = v:findFirstChild("Head")
						if characterhumanoid and characterhead then
							if characterhumanoid.Health > 0 then
								if (characterhead.Position - scphead.Position).magnitude < 20 then
									canjumpscare = false
									local whatjumpscare = math.random(1,table.getn(jumpscaresounds))
									jumpscaresounds[whatjumpscare]:Play()
								end
							elseif characterhumanoid.Health <= 0 then
								--nothing again
							end
						end
					end
				end
			end
			if scphead:findFirstChild("ChaseWho") then
				scphead:findFirstChild("ChaseWho"):destroy()
			end
			cantouchkill = false
			scphead.Anchored = true
			chasing = false
			going = false
			concretemovesound.Volume = 0
		end
	end
end
function ragdollkill(character)
	local victimshumanoid = character:findFirstChildOfClass("Humanoid")
	if not character:findFirstChild("UpperTorso") then
		character.Archivable = true
		local ragdoll = character:Clone()
		ragdoll:findFirstChildOfClass("Humanoid").Health = 0
		if ragdoll:findFirstChild("Health") then
			if ragdoll:findFirstChild("Health").ClassName == "Script" then
				ragdoll:findFirstChild("Health").Disabled = true
			end
		end
		for i,v in pairs(character:GetChildren()) do
			if v.ClassName == "Part" or v.ClassName == "ForceField" or v.ClassName == "Accessory" or v.ClassName == "Hat" then
				v:destroy()
			end
		end
		for i,v in pairs(character:GetChildren()) do
			if v.ClassName == "Accessory" then
				local attachment1 = v.Handle:findFirstChildOfClass("Attachment")
				if attachment1 then
					for q,w in pairs(character:GetChildren()) do
						if w.ClassName == "Part" then
							local attachment2 = w:findFirstChild(attachment1.Name)
							if attachment2 then
								local hinge = Instance.new("HingeConstraint", v.Handle)
								hinge.Attachment0 = attachment1
								hinge.Attachment1 = attachment2
								hinge.LimitsEnabled = true
								hinge.LowerAngle = 0
								hinge.UpperAngle = 0
							end
						end
					end
				end
			end
		end
		ragdoll.Parent = workspace
		if ragdoll:findFirstChild("Right Arm") then
			local glue = Instance.new("Glue", ragdoll.Torso)
			glue.Part0 = ragdoll.Torso
			glue.Part1 = ragdoll:findFirstChild("Right Arm")
			glue.C0 = CFrame.new(1.5, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0)
			glue.C1 = CFrame.new(0, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0)
			local limbcollider = Instance.new("Part", ragdoll:findFirstChild("Right Arm"))
			limbcollider.Size = Vector3.new(1.4,1,1)
			limbcollider.Shape = "Cylinder"
			limbcollider.Transparency = 1
			limbcollider.Name = "LimbCollider"
			local limbcolliderweld = Instance.new("Weld", limbcollider)
			limbcolliderweld.Part0 = ragdoll:findFirstChild("Right Arm")
			limbcolliderweld.Part1 = limbcollider
			limbcolliderweld.C0 = CFrame.fromEulerAnglesXYZ(0,0,math.pi/2) * CFrame.new(-0.3,0,0)
		end
		if ragdoll:findFirstChild("Left Arm") then
			local glue = Instance.new("Glue", ragdoll.Torso)
			glue.Part0 = ragdoll.Torso
			glue.Part1 = ragdoll:findFirstChild("Left Arm")
			glue.C0 = CFrame.new(-1.5, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
			glue.C1 = CFrame.new(0, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
			local limbcollider = Instance.new("Part", ragdoll:findFirstChild("Left Arm"))
			limbcollider.Size = Vector3.new(1.4,1,1)
			limbcollider.Shape = "Cylinder"
			limbcollider.Name = "LimbCollider"
			limbcollider.Transparency = 1
			local limbcolliderweld = Instance.new("Weld", limbcollider)
			limbcolliderweld.Part0 = ragdoll:findFirstChild("Left Arm")
			limbcolliderweld.Part1 = limbcollider
			limbcolliderweld.C0 = CFrame.fromEulerAnglesXYZ(0,0,math.pi/2) * CFrame.new(-0.3,0,0)
		end
		if ragdoll:findFirstChild("Left Leg") then
			local glue = Instance.new("Glue", ragdoll.Torso)
			glue.Part0 = ragdoll.Torso
			glue.Part1 = ragdoll:findFirstChild("Left Leg")
			glue.C0 = CFrame.new(-0.5, -1, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0)
			glue.C1 = CFrame.new(-0, 1, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0)
			local limbcollider = Instance.new("Part", ragdoll:findFirstChild("Left Leg"))
			limbcollider.Size = Vector3.new(1.4,1,1)
			limbcollider.Shape = "Cylinder"
			limbcollider.Name = "LimbCollider"
			limbcollider.Transparency = 1
			local limbcolliderweld = Instance.new("Weld", limbcollider)
			limbcolliderweld.Part0 = ragdoll:findFirstChild("Left Leg")
			limbcolliderweld.Part1 = limbcollider
			limbcolliderweld.C0 = CFrame.fromEulerAnglesXYZ(0,0,math.pi/2) * CFrame.new(-0.3,0,0)
		end
		if ragdoll:findFirstChild("Right Leg") then
			local glue = Instance.new("Glue", ragdoll.Torso)
			glue.Part0 = ragdoll.Torso
			glue.Part1 = ragdoll:findFirstChild("Right Leg")
			glue.C0 = CFrame.new(0.5, -1, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0)
			glue.C1 = CFrame.new(0, 1, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0)
			local limbcollider = Instance.new("Part", ragdoll:findFirstChild("Right Leg"))
			limbcollider.Size = Vector3.new(1.4,1,1)
			limbcollider.Shape = "Cylinder"
			limbcollider.Name = "LimbCollider"
			limbcollider.Transparency = 1
			local limbcolliderweld = Instance.new("Weld", limbcollider)
			limbcolliderweld.Part0 = ragdoll:findFirstChild("Right Leg")
			limbcolliderweld.Part1 = limbcollider
			limbcolliderweld.C0 = CFrame.fromEulerAnglesXYZ(0,0,math.pi/2) * CFrame.new(-0.3,0,0)
		end
		if ragdoll:findFirstChild("Head") and ragdoll.Torso:findFirstChild("NeckAttachment") then
			local HeadAttachment = Instance.new("Attachment", ragdoll["Head"])
			HeadAttachment.Position = Vector3.new(0, -0.5, 0)
			local connection = Instance.new('HingeConstraint', ragdoll["Head"])
			connection.LimitsEnabled = true
			connection.Attachment0 = ragdoll.Torso.NeckAttachment
			connection.Attachment1 = HeadAttachment
			connection.UpperAngle = 60
			connection.LowerAngle = -60
		elseif ragdoll:findFirstChild("Head") and not ragdoll.Torso:findFirstChild("NeckAttachment") then
			local hedweld = Instance.new("Weld", ragdoll.Torso)
			hedweld.Part0 = ragdoll.Torso
			hedweld.Part1 = ragdoll.Head
			hedweld.C0 = CFrame.new(0,1.5,0)
		end
		game.Debris:AddItem(ragdoll, 30)
	elseif character:findFirstChild("UpperTorso") then
		character.Archivable = true
		local ragdoll = character:Clone()
		ragdoll:findFirstChildOfClass("Humanoid").Health = 0
		if ragdoll:findFirstChild("Health") then
			if ragdoll:findFirstChild("Health").ClassName == "Script" then
				ragdoll:findFirstChild("Health").Disabled = true
			end
		end
		for i,v in pairs(character:GetChildren()) do
			if v.ClassName == "Part" or v.ClassName == "ForceField" or v.ClassName == "Accessory" or v.ClassName == "Hat" or v.ClassName == "MeshPart" then
				v:destroy()
			end
		end
		for i,v in pairs(character:GetChildren()) do
			if v.ClassName == "Accessory" then
				local attachment1 = v.Handle:findFirstChildOfClass("Attachment")
				if attachment1 then
					for q,w in pairs(character:GetChildren()) do
						if w.ClassName == "Part" or w.ClassName == "MeshPart" then
							local attachment2 = w:findFirstChild(attachment1.Name)
							if attachment2 then
								local hinge = Instance.new("HingeConstraint", v.Handle)
								hinge.Attachment0 = attachment1
								hinge.Attachment1 = attachment2
								hinge.LimitsEnabled = true
								hinge.LowerAngle = 0
								hinge.UpperAngle = 0
							end
						end
					end
				end
			end
		end
		ragdoll.Parent = workspace
		local Humanoid = ragdoll:findFirstChildOfClass("Humanoid")
		Humanoid.PlatformStand = true
		local function makeballconnections(limb, attachementone, attachmenttwo, twistlower, twistupper)
			local connection = Instance.new('BallSocketConstraint', limb)
			connection.LimitsEnabled = true
			connection.Attachment0 = attachementone
			connection.Attachment1 = attachmenttwo
			connection.TwistLimitsEnabled = true
			connection.TwistLowerAngle = twistlower
			connection.TwistUpperAngle = twistupper
			local limbcollider = Instance.new("Part", limb)
			limbcollider.Size = Vector3.new(0.1,1,1)
			limbcollider.Shape = "Cylinder"
			limbcollider.Transparency = 1
			limbcollider:BreakJoints()
			local limbcolliderweld = Instance.new("Weld", limbcollider)
			limbcolliderweld.Part0 = limb
			limbcolliderweld.Part1 = limbcollider
			limbcolliderweld.C0 = CFrame.fromEulerAnglesXYZ(0,0,math.pi/2)
		end
		local function makehingeconnections(limb, attachementone, attachmenttwo, lower, upper)
			local connection = Instance.new('HingeConstraint', limb)
			connection.LimitsEnabled = true
			connection.Attachment0 = attachementone
			connection.Attachment1 = attachmenttwo
			connection.LimitsEnabled = true
			connection.LowerAngle = lower
			connection.UpperAngle = upper
			local limbcollider = Instance.new("Part", limb)
			limbcollider.Size = Vector3.new(0.1,1,1)
			limbcollider.Shape = "Cylinder"
			limbcollider.Transparency = 1
			limbcollider:BreakJoints()
			local limbcolliderweld = Instance.new("Weld", limbcollider)
			limbcolliderweld.Part0 = limb
			limbcolliderweld.Part1 = limbcollider
			limbcolliderweld.C0 = CFrame.fromEulerAnglesXYZ(0,0,math.pi/2)
		end
		local HeadAttachment = Instance.new("Attachment", Humanoid.Parent.Head)
		HeadAttachment.Position = Vector3.new(0, -0.5, 0)
		makehingeconnections(Humanoid.Parent.Head, HeadAttachment, ragdoll.UpperTorso.NeckAttachment, -50, 50)
		makehingeconnections(Humanoid.Parent.LowerTorso, Humanoid.Parent.LowerTorso.WaistRigAttachment, Humanoid.Parent.UpperTorso.WaistRigAttachment, -50, 50)
		makeballconnections(Humanoid.Parent.LeftUpperArm, Humanoid.Parent.LeftUpperArm.LeftShoulderRigAttachment, Humanoid.Parent.UpperTorso.LeftShoulderRigAttachment, -200, 200, 180)
		makehingeconnections(Humanoid.Parent.LeftLowerArm, Humanoid.Parent.LeftLowerArm.LeftElbowRigAttachment, Humanoid.Parent.LeftUpperArm.LeftElbowRigAttachment, 0, -60)
		makehingeconnections(Humanoid.Parent.LeftHand, Humanoid.Parent.LeftHand.LeftWristRigAttachment, Humanoid.Parent.LeftLowerArm.LeftWristRigAttachment, -20, 20)
		--
		makeballconnections(Humanoid.Parent.RightUpperArm, Humanoid.Parent.RightUpperArm.RightShoulderRigAttachment, Humanoid.Parent.UpperTorso.RightShoulderRigAttachment, -200, 200, 180)
		makehingeconnections(Humanoid.Parent.RightLowerArm, Humanoid.Parent.RightLowerArm.RightElbowRigAttachment, Humanoid.Parent.RightUpperArm.RightElbowRigAttachment, 0, -60)
		makehingeconnections(Humanoid.Parent.RightHand, Humanoid.Parent.RightHand.RightWristRigAttachment, Humanoid.Parent.RightLowerArm.RightWristRigAttachment, -20, 20)
		--
		makeballconnections(Humanoid.Parent.RightUpperLeg, Humanoid.Parent.RightUpperLeg.RightHipRigAttachment, Humanoid.Parent.LowerTorso.RightHipRigAttachment, -80, 80, 80)
		makehingeconnections(Humanoid.Parent.RightLowerLeg, Humanoid.Parent.RightLowerLeg.RightKneeRigAttachment, Humanoid.Parent.RightUpperLeg.RightKneeRigAttachment, 0, 60)
		makehingeconnections(Humanoid.Parent.RightFoot, Humanoid.Parent.RightFoot.RightAnkleRigAttachment, Humanoid.Parent.RightLowerLeg.RightAnkleRigAttachment, -20, 20)
		--
		makeballconnections(Humanoid.Parent.LeftUpperLeg, Humanoid.Parent.LeftUpperLeg.LeftHipRigAttachment, Humanoid.Parent.LowerTorso.LeftHipRigAttachment, -80, 80, 80)
		makehingeconnections(Humanoid.Parent.LeftLowerLeg, Humanoid.Parent.LeftLowerLeg.LeftKneeRigAttachment, Humanoid.Parent.LeftUpperLeg.LeftKneeRigAttachment, 0, 60)
		makehingeconnections(Humanoid.Parent.LeftFoot, Humanoid.Parent.LeftFoot.LeftAnkleRigAttachment, Humanoid.Parent.LeftLowerLeg.LeftAnkleRigAttachment, -20, 20)
		for i,v in pairs(Humanoid.Parent:GetChildren()) do
			if v.ClassName == "Accessory" then
				local attachment1 = v.Handle:findFirstChildOfClass("Attachment")
				if attachment1 then
					for q,w in pairs(Humanoid.Parent:GetChildren()) do
						if w.ClassName == "Part" then
							local attachment2 = w:findFirstChild(attachment1.Name)
							if attachment2 then
								local hinge = Instance.new("HingeConstraint", v.Handle)
								hinge.Attachment0 = attachment1
								hinge.Attachment1 = attachment2
								hinge.LimitsEnabled = true
								hinge.LowerAngle = 0
								hinge.UpperAngle = 0
							end
						end
					end
				end
			end
		end
		for i,v in pairs(ragdoll:GetChildren()) do
			for q,w in pairs(v:GetChildren()) do
				if w.ClassName == "Motor6D"--[[ and w.Name ~= "Neck"--]] then
					w:destroy()
				end
			end
		end
		if ragdoll:findFirstChild("HumanoidRootPart") then
			ragdoll.HumanoidRootPart.Anchored = true
			ragdoll.HumanoidRootPart.CanCollide = false
		end
		game.Debris:AddItem(ragdoll, 30)
	end
end
spawn(orientation)
spawn(attack)
spawn(checkhowmanycharactersseeme)
spawn(adddetectors)
