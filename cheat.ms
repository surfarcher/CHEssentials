# CHEssentials - the CommandHelper replacement for Essentials.
#
# Copyright (c) 2013 by the sk89q.com community
include('common.ms')


# surfarcher, 18-May-2013, 8pt.
proc(_CHEch_exp, @parm1, @player, @amount,
	# Parm 1 can be player if there's now @player.
	if(@parm1 != 'give' && @parm1 != 'set' && @parm1 != 'show' && @player == '') {
		@player=@parm1
		@parm1='show'
	}
	@parm1=to_lower(trim(@parm1))
	
	# Translate the amount parm.
	@is_level=False
	if(@amount != '') {
		if(is_numeric(@amount)) {
			@a=integer(@amount)
		} else if(reg_count('^L\\d+$', @amount)) {
			@is_level=True
			@a=integer(substr(@amount, 1))
		}
	}
	
	# Show usage on parm check fail.
	if((@parm1 != 'give' && @parm1 != 'set' && @parm1 != 'show') || @player == '' || (@parm1 == 'give' && @a == '' ) || (@parm1 == 'set' && @a == '' )) {
		_CHEc_emsg(player(), 'Usage: /exp playername')
		_CHEc_emsg(player(), 'Usage: /exp <give|set|show> playername [amount|L<level>]')
	} else {
		try(@p=player(@player))
		if(@p == '') {
			_CHEc_emsg(player(), 'Player "'.if(@player, @player, @parm1).'" isn\'t online.')
		} else {
			# Permissions check.
			@perm='essentials.exp'.@parm1
			if(@parm1 == 'give' || @parm1 == 'set', @perm.='.'.@parm1)
			if(@p != player(), @perm.='.others')
			
			if(!has_permission(@perm)) {
				_CHEc_emsg(player(), 'You don\'t have permission to do that.')
			} else {
				_CHEc_smsg(player(), @p.' '.@parm1.' '.@a)
				# Do the exp task.
				switch(@parm1,
					'give',
						if(@is_level) {
							_CHEc_emsg(player(), 'You can\'t give a level, set /exp set instead.')
						} else {
							give_pexp(@p, @a)
							_CHEc_smsg(player(), 'Gave '.@p.' '.@a.' experience.')
						},
					'set',
						if(@is_level) {
							@oxp=ptexp(@p)
							set_ptexp(@p, 0)
							set_plevel(@p, @a)
							@a=ptexp(@p) - @oxp
						} else {
							set_ptexp(@p, @a)
						}
						_CHEc_smsg(player(), 'Set '.@p.'\'s experience to '.@a.'.'),
					'show',
						_CHEc_smsg(player(), @p.' has '.ptexp(@p).' experience (level '.plevel(@p).')')
				)
			}
		}
	}
)


proc(_CHEch_fly, @player, @bool,	
	if(@player) {
		try(@p = player(@player), _CHEc_emsg(player(), 'Unknown player.') die())
		if(@p != player() && !has_permission('essentials.fly.others')) { 
			_CHEc_emsg(player(), 'You do not have permission.')
		} else {
			if(@bool, @b = @bool, @b = !phas_flight(@p))
			switch(@b,
				array('on', 'true'),
				  set_pflight(@p, 1)
				  _CHEc_smsg(player(), 'Turned on fly mode for '.@p.'.')
				  _CHEc_dmsg(@p, player().' turned on your fly mode.'),
				array('off', 'false'),
				  set_pflight(@p, 0)
				  _CHEc_smsg(player(), 'Turned off fly mode for '.@p.'.')
				  _CHEc_dmsg(@p, player().' turned off your fly mode.'), 
			  _CHEc_emsg(player(), 'Usage: /fly [player] [on|off]')
			)
		}
	} else {
		if(phas_flight()) {
			set_pflight(0)
			_CHEc_smsg(player(), 'Turned off fly mode.')
		} else {
			set_pflight(1)
			_CHEc_smsg(player(), 'Turned on fly mode.')
		}
	}
)


# EOF
