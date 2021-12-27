--ONLY THE SCRIPT.


local button1 = script.Parent.Button1
local button2 = script.Parent.Button2


local click1 = button1.ClickDetector
local click2 = button2.ClickDetector



local isopen = script.Parent.IsOpen
local idle = true
local tweenservice = game:GetService("TweenService")
local info = TweenInfo.new(1.6,Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false, 0)


function active(silent)
	if script.Parent.Locked.Value == true then
		wait(0.01)
	script.Parent.Door1.LockedSound:Play()
			local lockedGui = script.DoorGui:Clone()
			lockedGui.Enabled = false
			lockedGui.TextLabel.TextTransparency = 1
			lockedGui.Enabled = true
			for i = 1,10 do
				lockedGui.TextLabel.TextTransparency = lockedGui.TextLabel.TextTransparency - 0.1
				wait(0.01)
			end
			wait(1)
			for i = 1,20 do
				lockedGui.TextLabel.TextTransparency = lockedGui.TextLabel.TextTransparency + 0.05
				wait(0.01)
			end
			lockedGui:Destroy()
		end
	if idle and not script.Parent.Locked.Value then
		idle = false
		if not isopen.Value and script.Parent.Idle.Value then
			script.Parent.Idle.Value = false
			local ok = {
			CFrame = script.Parent.FakeD1.CFrame
						}
			local ok2 = {
			CFrame = script.Parent.FakeD2.CFrame
			}
local tween1 = tweenservice:Create(script.Parent.Door1, info, ok)
local tween2 = tweenservice:Create(script.Parent.Door2, info, ok2)
			tween1:Play()
			tween2:Play()
				script.Parent.Door1["Open" .. math.random(1,3)]:Play()
			isopen.Value = true
			click1.MaxActivationDistance = 0
			click2.MaxActivationDistance = 0
			wait(2)
			click1.MaxActivationDistance = 5
			click2.MaxActivationDistance = 5
			script.Parent.Idle.Value = true
		elseif isopen.Value and script.Parent.Idle.Value then
			script.Parent.Idle.Value = false
			local ok = {
			CFrame = script.Parent.FDoor1.CFrame
			}
			local ok2 = {
			CFrame = script.Parent.FDoor2.CFrame
			}
			local tween1 = tweenservice:Create(script.Parent.Door1, info, ok)
			local tween2 = tweenservice:Create(script.Parent.Door2, info, ok2)
			tween1:Play()
			tween2:Play()
				script.Parent.Door1["Close" .. math.random(1,3)]:Play()
			isopen.Value = false
			click1.MaxActivationDistance = 0
			click2.MaxActivationDistance = 0
			wait(2)
			click1.MaxActivationDistance = 5
			click2.MaxActivationDistance = 5
			script.Parent.Idle.Value = true
		end
		wait(0.5)
		idle = true
	end
end



click1.MouseClick:connect(function(plr)
	if script.Parent.Locked.Value == false then
		button1.Push:Play()
	end
	active()
end)
click2.MouseClick:connect(function(plr)
	if script.Parent.Locked.Value == false then
		button2.Push:Play()
	end
	active()
end)

--By naschemaa.
