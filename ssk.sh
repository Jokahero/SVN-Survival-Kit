STASH_DIRECTORY="~/.ssk_stashes"
STASH_EXT=".stash"
UNAMED_STASH_NAME="unamed"

ORIGINAL_SVN=/usr/bin/svn

svn() {
	if [ "$1" = diff ] || [ "$1" = di ] ; then
		__diff $@
	elif [ "$1" = stash ] ; then
		shift
		__stash $@
	else
		$ORIGINAL_SVN $@
	fi	
}

#
# Uses colordiff if installed
# and use less for more friendliness
#
__diff() {
	type colordiff 1>/dev/null
	if [ $? -eq 0 ] ; then
		$ORIGINAL_SVN $@ | colordiff | less -r
	else
		$ORIGINAL_SVN $@ | less -r
	fi
}

# TODO
# * list
# * pop w/o a name
# * pop w/ a name
# * stash w/o a name
# * stash w/ a name
# * apply w/ a name
#
__stash() {
	if [ $# -eq 0 ] ; then
		file=$STASH_DIRECTORY/$UNAMED_STASH_NAME$STASH_EXT
		if [ -f file ] ; then
			# TODO already unamed stash existing, print an error
		else
			$ORIGINAL_SVN diff > file
			$ORIGINAL_SVN revert . --depth infinity
		fi
	else
		case "$1" in
			"list")
				ls $STASH_DIRECTORY | awk -F. '{print $1}'	
				;;
			"pop")
				file=$STASH_DIRECTORY/$UNAMED_STASH_NAME$STASH_EXT
				if [ -f file ] ; then
					patch -p0 -i file
					rm file
				else
					# TODO nothing stashed as unamed, print an error
				fi
				;;
			"apply")
				shift
				if [ $# -eq 0 ] ; then
					# TODO error ...
				else
					# TODO check if $1 stash exists
					# TODO then apply $1 stash or not
				fi
				;;
			*)
				file=$STASH_DIRECTORY/$1$STASH_EXT
				if [ -f file ] ; then
					patch -p0 -i file
					rm file
				else
					# TODO nothing stashed as $1, print an error
				fi
				;;
		esac
	fi
}

