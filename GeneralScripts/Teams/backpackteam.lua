--PUT THE TOOLS INTO THE TEAM
function teamFromColor(color) 
	for _,t in pairs(game:GetService("Teams"):GetChildren()) do 
		if t.TeamColor==color then return t end 
	end 
	return nil 
end 

function onSpawned(plr) 
	local tools = teamFromColor(plr.TeamColor):GetChildren() 
	for _,c in pairs(tools) do 
		c:Clone().Parent = plr.Backpack 
	end 
end 

function onChanged(prop,plr)
	if prop=="Character" then 
		onSpawned(plr) 
	end 
end 

function onAdded(plr) 
	plr.Changed:connect(function(prop) 
		onChanged(prop,plr) 
	end) 
end 

game.Players.PlayerAdded:connect(onAdded) 
--By naschemaa.
