--This is a default Roblox script.
-----------------------------
--[[ v Settings! v ]]--
local SprintingSpeed = 30 --How fast your player moves (Obviously the bigger the number the faster you go)
local JumpStaminaRemoval = 0
local DegenerateWait = 0.1 --Time waited before bar reduces in size (The Smaller The Number the Faster It Goes)
local RegenerateWait = 0.05 --Time waited before bar increases in size (The Smaller The Number the Faster It Goes)
local DegenerateRate = -1 --Total its reduced (Make Sure it is a negative number!!!!!)
local RegenerateRate = 2 --Total its increased (Make Sure it is a positive number!!!!!)
--[[ ^ Settings! ^ ]]--
-----------------------------
--[[ . ]]--
--Varibles--
Player = game.Players.LocalPlayer
Character = Player.Character or Player.CharacterAdded:Wait()
animationR = Character:WaitForChild('Humanoid'):LoadAnimation(script:WaitForChild('AnimationRun'))
animationJ = Character:WaitForChild('Humanoid'):LoadAnimation(script:WaitForChild('AnimationJump'))
Stamina = Player.PlayerGui:FindFirstChild('Stamina').Bar
--WIP--
BarColorWhole = nil
BarColorTwoThird = nil
BarColorOneThird = nil
--WIP-- ^
CanRun = true
CanJump = true
CanjumpIf = true
CanStop = true
Sbar = Stamina.AbsoluteSize.X
KeyDown = game:GetService('UserInputService')
--^Varibles^--
--The Stuff That Makes It Work--
game:GetService('UserInputService').InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.LeftShift and CanRun == true or KeyDown:IsKeyDown(Enum.KeyCode.LeftShift) then
		CanRun = false 
		animationR:Play()
		Player.Character:FindFirstChild('Humanoid').WalkSpeed = SprintingSpeed
		local C1 = coroutine.create(function()
			for I = Stamina.AbsoluteSize.X , 0, DegenerateRate do
				Stamina.Size = UDim2.new(0, I, 0,25)
				wait(DegenerateWait)
				if not KeyDown:IsKeyDown(Enum.KeyCode.LeftShift) then
					break
				end
				if KeyDown:IsKeyDown(Enum.KeyCode.Space) then
					if Stamina.AbsoluteSize.X <= 0 then
						Player.Character:FindFirstChild('Humanoid').WalkSpeed = 16
						animationR:Stop()
						Stamina.Size = UDim2.new(0,0,0,25)	
					end
					coroutine.yield()
					break
				end
				CanRun = true
				if Stamina.AbsoluteSize.X <= 0  then
					Player.Character:FindFirstChild('Humanoid').WalkSpeed = 16
					animationR:Stop()
					Stamina.Size = UDim2.new(0,0,0,25)
				end	
			end
		end)
		coroutine.resume(C1)
	end
	if input.KeyCode == Enum.KeyCode.Space then
		Stamina.Size = Stamina.Size - UDim2.new(0,JumpStaminaRemoval,0,0)
		if Stamina.AbsoluteSize.X < 0 then
			Stamina.Size = UDim2.new(0,0,0,25)
		end	
	end		
end)

game:GetService('UserInputService').InputEnded:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.LeftShift or input.KeyCode == Enum.KeyCode.Space and CanStop == true then
		CanStop = false
		if not KeyDown:IsKeyDown(Enum.KeyCode.LeftShift) then
			animationR:Stop()
			Player.Character:FindFirstChild('Humanoid').WalkSpeed = 16
		end
		wait(1)
		local C2 = coroutine.create(function()
			for I =  Stamina.AbsoluteSize.X, 250, RegenerateRate do
				if KeyDown:IsKeyDown(Enum.KeyCode.LeftShift) then
					break
				end
				if KeyDown:IsKeyDown(Enum.KeyCode.Space) then
					coroutine.yield()
					break		
				end
				Stamina.Size = UDim2.new(0,I,0,25)
				Character:FindFirstChild('Humanoid').JumpPower = 50
				wait(RegenerateWait)
			end
		end)
		coroutine.resume(C2)
		if KeyDown:IsKeyDown(Enum.KeyCode.Space) then
			coroutine.resume(C2)
		end
		CanStop = true
	end
end)
game:GetService('UserInputService').JumpRequest:Connect(function(input)
	if Stamina.AbsoluteSize.X <= 0 then
		animationJ:Stop()
		Character:FindFirstChild('Humanoid').JumpPower = 0
		Stamina.Size = UDim2.new(0,0,0,25)		
	end
	if CanJump == true and Stamina.AbsoluteSize.X > 0 then
		CanJump = false
		animationJ:Play()
		Stamina.Size = Stamina.Size - UDim2.new(0,JumpStaminaRemoval,0,0)
		CanJump = true
	end
end)
------------------------------------------------------------------------------------
------------------------------------End Function------------------------------------
------------------------------------------------------------------------------------

--[[--Did You Change The Animation IDs and forget the Original Ones? Well here are some below!
--1150956145 Run
--1253502461 Jump
--]]--End

--[[--Current Bugs--
--1. Loops Degenerate Stamina Multiple Times While Running. Saying 1(2x) or 45(5x) etc
     Have Not Seen a Drop in Total Run Time yet so it is not a top Priority
--2.
--]]--End






--Useless comments-- 
--if input.UserInputType == Enum.UserInputType.Keyboard then	
--	elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
--		print(input.Position)
--	end
--[[
game:GetService('ReplicatedStorage').REvents.CreateAnim.OnClientEvent:Connect(function()
	print(1)	
	aR = Instance.new('Animation', script)
	aR.Name = 'AnimationRun'
	aR.AnimationId = '1150956145'
	aJ =Instance.new('Animation', script)
	aJ.Name = 'AnimationJump'
	aJ.AnimationId = '1253502461'
	wait(1)
end)
]]
--			if input.KeyCode == Enum.KeyCode.LeftShift then
				
--			end
--		end)

--Uploaded by naschemaa
