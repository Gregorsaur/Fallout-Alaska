hook.Add('DoPlayerDeath','Jetted',function(ply)
	local jet = ply:GetNWEntity('Jetted')
	if !IsValid(jet) then return end
	jet:Remove()
end)