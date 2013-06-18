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


proc(_CHEc_player, @player,
	@ret=null
	
	try(@ret=player(@player))
	if(is_null(@ret)) {
		if(array_contains_ic(get_offline_players(), @player)) {
			@ret=@player
		}
	}
	
	return(@ret)
)

proc(_CHEc_perm, @player, @permission, @message = null,
	@perm = 'essentials.' . @permission
	if(has_permission(@player, @permission)) {
		return(true)
	} else {
		if(is_null(@message)) {
			tmsg(@player, color('red'). 'You do not have access to that command.')
		} else {
			tmsg(@player, @message)
		}
		return(false)
	}
)



#EOF
