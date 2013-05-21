# CHEssentials - the CommandHelper replacement for Essentials.
#
# Copyright (c) 2013 by the sk89q.com community


proc(_CHEc_setting, @setting,
	import(@CHEssentialsSettings)
	
	@ret=null
	if(array_contains(array_keys(@CHEssentialsSettings), @setting)) {
		@ret=trim(@CHEssentialsSettings[@setting])
	}
	
	return(@ret)
)


proc(_CHEc_smsg, @player, @msg,
	@p=player(@player)
	if(ponline(@p)) {
		tmsg(@p, color(_CHEc_setting('msg.color.source')).@msg)
	}
)


proc(_CHEc_dmsg, @player, @msg,
	@p=player(@player)
	if(ponline(@p)) {
		tmsg(@p, color(_CHEc_setting('msg.color.dest')).@msg)
	}
)


proc(_CHEc_emsg, @player, @msg,
	@p=player(@player)
	if(ponline(@p)) {
		tmsg(@p, color(_CHEc_setting('msg.color.error')).@msg)
	}
)


#EOF
