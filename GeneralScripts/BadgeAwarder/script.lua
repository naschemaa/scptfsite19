--PUT IN A PART WITH A Value who nammed "BadgeID". Put the id of the badge in "BadgeID".
--TESTED ON ROBLOX STUDIO.
function OnTouch(part)
	if (part.Parent:FindFirstChild("Humanoid") ~= nil) then
		local p = game.Players:GetPlayerFromCharacter(part.Parent)
		if (p ~= nil) then
			
			local b = game:GetService("BadgeService")
			b:AwardBadge(p.userId, script.Parent.BadgeID.Value)
		end
	end
end

script.Parent.Touched:connect(OnTouch)

--By naschemaa.
