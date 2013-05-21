# CHEssentials - the CommandHelper replacement for Essentials.
#
# Copyright (c) 2013 by the sk89q.com community
#
# Editors
#  * surfarcher
# Contributors
#  * PseudoKnight
#  * raGan
#  * surfarcher
#  
console('[CHEssentials] main.ms loading...')



assign(@CHEssentialsSettings, array())
export(@CHEssentialsSettings)
console('[CHEssentials]  - Initialising...')
#proc(_main,
	@s=''
	
	try(@s=read('settings.txt'))
	
	if(@s == '') {
		console('[CHEssentials]    - ERROR loading settings.txt!')
	} else {	
		console('[CHEssentials]    - Loading settings.txt')
		import(@CHEssentialsSettings)
		
		@sa=split('\n', @s)
		foreach(@sa, @s) {
			if(length(trim(@s)) > 0 && string_position(trim(@s), '#') != 0) {
				# Line has content and first non-whitespace character isn't a comment. Strip any trailing comment.
				if(string_position(@s, '#') > 0) {
					# Ignore anything after the comment character.
					@s=substr(@s, 0, string_position(@s, '#'))
				}
				
				# If line contains an = it's a setting, store the value by name.
				if(string_position(@s, '=') > 0) {
					@sk=trim(substr(@s, 0, string_position(@s, '=')))
					@sv=trim(substr(@s, string_position(@s, '=') + 1))
					
					# If the key contains seomthing store it.
					if(@sk != '') {
						array_set(@CHEssentialsSettings, @sk, @sv)
					}
				}
			}
		}
		if(array_size(@CHEssentialsSettings) < 1) {
			console('[CHEssentials]  - ERROR! No configuration loaded!')
		}
	}
#)



console('[CHEssentials] main.ms LOADED!')

#EOF
