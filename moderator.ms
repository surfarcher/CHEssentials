# CHEssentials - the CommandHelper replacement for Essentials.
#
# Copyright (c) 2013 by the sk89q.com community

include('common.ms')


# surfarcher, 16-May-2013, 6pt.
proc(_CHEmo_killall, @mobType, @radius,
	# Build the array of entities to iterate.
	@el=null
	if(@mobType == '?') {
		_CHEc_emsg(player(), 'Usage: /killall [mob type] [radius]')
	} else if(@radius != '' && !is_numeric(@radius)) {
		_CHEc_emsg(player(), 'Radius must be a number if it is supplied!')
	} else if (to_lower(trim(@mobType)) == 'player') {
		_CHEc_emsg(player(), 'You can\'t kill players with /killall!')
	} else {
		if(is_numeric(@radius)) {
			if(@mobType == '') {
				@el=entities_in_radius(ploc(), @radius)
			} else {
				@el=entities_in_radius(ploc(), @radius, @mobType)
			}
		} else {
			@el=all_entities(pworld())
		}
	}
	
	# Build the list of mobs to kill.
	if(@mobType != '') {
		@mt=array(to_upper(trim(@mobType)))
	} else {
		@mt=array('WITHER', 'WITCH', 'CREEPER', 'SKELETON', 'SPIDER', 'GIANT', 'ZOMBIE', 'SLIME', 
							'GHAST', 'PIG_ZOMBIE', 'ENDERMAN', 'CAVE_SPIDER', 'BLAZE', 'ENDER_DRAGON')
	}
	
	# Kill everything in @el of a type that's in @mt.
	if(!is_null(@el)) {
		@i=0
		foreach(@el, @e) {
			if(array_contains_ic(@mt, entity_type(@e))) {
				entity_remove(@e)
				@i++
			}
		}
		_CHEc_smsg(player(), 'Killed '.@i.' '.if(@mobType == '', 'mob', @mobType).'s.')
	}
)


# surfarcher, 16-May-2013, 3pt.
proc(_CHEmo_remove, @type, @radius,
	@t=trim(to_lower(@type))
	if(@t == 'drops' || @t == 'drop') {
		call_alias('/killall DROPPED_ITEM '.@radius)
	} else if (@t == 'arrows' || @t == 'arrow') {
		call_alias('/killall ARROW '.@radius)
	} else if (@t == 'boats' || @t == 'boat') {
		call_alias('/killall BOAT '.@radius)
	} else if (@t == 'minecarts' || @t == 'minecart') {
		call_alias('/killall MINECART '.@radius)
	} else if (@t == 'xps' || @t == 'xp') {
		call_alias('/killall EXPERIENCE_ORB '.@radius)
	} else if (@t == 'paintings' || @t == 'painting') {
		call_alias('/killall PAINTING '.@radius)
	} else {
		_CHEc_emsg(player(), 'Usage: /remove <drops|arrows|boats|minecarts|xp|paintings> [radius]')
	}
)


# surfarcher, 15-May-2013, 4pt.
proc(_CHEmo_weather, @mode, @duration,
	@b=null
	if(@mode == 'sun' || (@mode == '' && has_storm())) {
		@b=False
	} else if(@mode == 'storm' || (@mode == '' && !has_storm())) {
		@b=True
	} else {
		_CHEc_emsg(player(), 'Usage: /weather <sun|storm> [seconds]')
	}
	
	if(!is_null(@b)) {
		if(is_integral(@duration)) {
			storm(@b, pworld(), @duration * 20)
		} else {
			storm(@b)
		}
	}
)


# EOF
