# CHEssentials - the CommandHelper replacement for Essentials.
#
# Copyright (c) 2013 by the sk89q.com community
include('common.ms')


# surfarcher, 27-May-2013, 4pt.
proc(_CHEec_balance, @player,
	# Allow partial matching of online players, otherwise full matching of offline players.
	try(@p=player(@player))
	if(@p == '') {
		if(array_contains_ic(get_offline_players(), @player)) {
			@p=@player
		} else {
			_CHEc_emsg(player(), 'Sorry, but we don\'t know '.@player)
		}
	}
	
	if(@p != '') {
		if (@p != player() && !has_permission('essentials.balance.others')) {
			_CHEc_emsg(player(), 'You don\'t have permission to check another player\'s money.')
		} else {
			_CHEc_smsg(player(), @p.' has '.acc_balance(@p).' money')
		}
	}
)


# surfarcher, 27-May-2013, 5pt.
proc(_CHEec_eco, @operation, @player, @amount,
	@op=trim(to_lower(@operation))
	if((@op != 'give' && @op != 'take' && @op != 'reset') || @player == '' || @amount == '' || !is_numeric(@amount)) {
		_CHEc_emsg(player(), 'Usage: /economy <give|take|reset> player amount')
	} else {
		if(@player == '*') {
			@players=all_players()
		} else if (@player == '**') {
			@players=get_offline_players()
		} else {
			try(@t=player(@player))
			if(@t == '') {
				if(array_contains_ic(get_offline_players(), @player)) {
					@t=@player
				} else {
					_CHEc_emsg(player(), 'Sorry, but we don\'t know '.@player)
				}
			}
			if(@t != '') {
				@players=array(@t)
			}
		}
		
		if(is_array(@players)) {
			foreach(@players, @p) {
				switch(@op,
					'give',
						acc_add(@p, @amount)
						_CHEc_smsg(player(), 'Gave '.@p.' '.@amount.' money')
						,
					'take',
						acc_subtract(@p, @amount)
						_CHEc_smsg(player(), 'Took '.@amount.' money from '.@p)
						,
					'reset',
						acc_set(@p, @amount)
						_CHEc_smsg(player(), 'Set '.@p.'\'s money to '.@amount)
				)
			}
		}
	}
)


# surfarcher, 27-May-2013, 4pt.
proc(_CHEec_pay, @player, @amount,
	if(@player == '' || @amount == '') {
		_CHEc_emsg(player(), 'Usage: /pay player amount')
	} else {
		# Allow partial matching of online players, otherwise full matching of offline players.
		try(@p=player(@player))
		if(@p == '') {
			if(array_contains_ic(get_offline_players(), @player)) {
				@p=@player
			} else {
				_CHEc_emsg(player(), 'Sorry, but we don\'t know '.@player)
			}
		}
		
		if(!is_numeric(@amount)) {
			_CHEc_emsg(player(), @amount.' isn\'t a valid amount')
		} else if(acc_balance(player())< @amount) {
			_CHEc_emsg(player(), 'You don\'t have '.@amount.' to give '.@p)
		} else if(@p != '') {
			acc_subtract(player(), @amount)
			acc_add(@p, @amount)
			_CHEc_smsg(player(), 'You paid '.@p.' '.@amount.' of your money')
		}
	}
)


# EOF
