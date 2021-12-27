--PUT THIS IN WORKSPACE IF YOU WANT AUTO-REDIRECT
--PUT THIS IN A PART IF YOU WANT ONCLICK-REDIRECT (Don't forget to use a ClickDetector)
function onTouched(hit)
   local player = game.Players:GetPlayerFromCharacter(hit.Parent)
   if player then
       game:GetService("TeleportService"):Teleport(2482628107,player) --Replace 2482628107 by the id of your place.
  end
end


script.Parent.Touched:connect(onTouched)

--By naschemaa.
