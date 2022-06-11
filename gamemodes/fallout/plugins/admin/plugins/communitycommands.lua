PLUGIN.name = "Community Commands"
PLUGIN.author = "Voluntary Gaming"
PLUGIN.desc = "Adds /group, /content, /rules and /eventlocal"

nut.chat.register("eventlocal", {
	onCanSay =  function(speaker, text)
		return speaker:IsAdmin()
	end,
	onCanHear = nut.config.get("chatRange", 280) * 6,
	onChatAdd = function(speaker, text)
		chat.AddText(Color(255, 150, 0), text)
	end,
	prefix = {"/eventlocal"},
	font = "nutMediumFont"
})

