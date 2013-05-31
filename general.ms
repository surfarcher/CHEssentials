# CHEssentials - the CommandHelper replacement for Essentials.
#
# Copyright (c) 2013 by the sk89q.com community

include('common.ms')


# surfarcher, 15-May-2013, 4pt.
proc(_CHEge_getpos, @player,
	@ploc=null
	if(@player != '' && player(@player) != player()) {
		if(has_permission('essentials.getpos.others')) {
			@ploc=ploc(@player)
		} else {
			_CHEc_emsg(player(), 'You don\' have permission to get other players\' locations')
		}
	} else {
		@ploc=ploc()
	}
	
	if(@ploc != null) {
		_CHEc_smsg(player(), 'Player '.player(@player).' is at X:'.@ploc[0].' Y:'.@ploc[1].' Z:'.@ploc[2].' World:'.@ploc[3])
	}
)


# surfarcher, 15-May-2013, 4pt.
proc(_CHEge_whois, @player,
	try(@p=player(@player))
	if(!is_null(@p) && @p != '') {
		@ploc=ploc(@p)
		@pinfo=pinfo(@p)

		_CHEc_smsg(player(), 'Whois: '.@p)
		_CHEc_smsg(player(), ' Nick: '.@pinfo[4])
		_CHEc_smsg(player(), ' Health: '.@pinfo[5].'/20')
		_CHEc_smsg(player(), ' Exp: '.(pexp(@p)*plevel(@p)).' (Level '.plevel(@p).')')
		_CHEc_smsg(player(), ' Location: '.'X:'.integer(@ploc[0]).' Y:'.integer(@ploc[1]).' Z:'.integer(@ploc[2]).' W:'.@ploc[3])
		try(
			_CHEc_smsg(player(), ' Money: '.acc_balance(@p))
		,
			_CHEc_smsg(player(), ' Money: No economy running')
		)
		_CHEc_smsg(player(), ' IP Address: '.@pinfo[3])
		_CHEc_smsg(player(), ' Gamemode: '.pmode(@p))
		#_CHEc_smsg(player(), ' God mode: true')
		_CHEc_smsg(player(), ' OP: '.@pinfo[8])
		_CHEc_smsg(player(), ' Fly mode: '.phas_flight(@p).' ('.if(@pinfo[18], 'IS', 'not').' flying)')
		#_CHEc_smsg(player(), ' AFK: false')
		_CHEc_smsg(player(), ' Blocking: '.@pinfo[17])
		#_CHEc_smsg(player(), ' Jailed: false')
		#_CHEc_smsg(player(), ' Muted: false')
		_CHEc_smsg(player(), ' Sleeping: '.@pinfo[16])
		_CHEc_smsg(player(), ' Sneaking: '.@pinfo[11])
	}
)


# EOF
