STASH_DIRECTORY="$HOME/.ssk_stashes"
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

#
# Stores current changes as a patch file
# and reverts all the current changes
#
__stash() {
	if [ $# -eq 0 ] ; then
		repo_id=`__get_repository_id`
		directory=$STASH_DIRECTORY/$repo_id
		file=$UNAMED_STASH_NAME$STASH_EXT
		if [ -f $file ] ; then
			echo "ERROR : some changes are already stashed"
		else
			__store_stash $directory $file
		fi
	else
		case "$1" in
			"list")
				ls $STASH_DIRECTORY | awk -F. '{print $1}'	
				;;
			"pop")
				repo_id=`__get_repository_id`
				file=$STASH_DIRECTORY/$repo_id/$1$STASH_EXT
				if [ -f $file ] ; then
					__apply_patch $file
					rm $file
				else
					echo "ERROR : nothing to pop out"
				fi
				;;
			"apply")
				shift
				if [ $# -eq 0 ] ; then
					echo "ERROR : you must provide a stash name when using 'svn stash apply'"
				else
					repo_id=`__get_repository_id`
					file=$STASH_DIRECTORY/$repo_id/$1$STASH_EXT
					if [ -f $file ] ; then
						__apply_patch $file
					else
						echo "ERROR : $1 is not an existing stash"
					fi
				fi
				;;
			"delete" | "del")
				shift
				if [ $# -eq 0 ] ; then
					echo "ERROR : you must provide a stash name when using 'svn stash delete'"
				else
					repo_id=`__get_repository_id`
					file=$STASH_DIRECTORY/$repo_id/$1$STASH_EXT
					if [ -f $file ] ; then
						rm $file
					fi
				fi
				;;
			*)
				repo_id=`__get_repository_id`
				directory=$STASH_DIRECTORY/$repo_id
				file=$1$STASH_EXT
				if [ -f $file ] ; then
					echo "ERROR : $1 is an already existing stash"
				else
					__store_stash $directory $file
				fi
				;;
		esac
	fi
}

#
# Apply a Subversion patch
#
# param $1	Path to the patch file to apply
#
__apply_patch() {
	patch -p0 -i $1
}

#
# Stores the current changes into a stash
#
# param $1 Directory
# param $2 Stash name
#
__store_stash() {
	[ -d $1 ] || mkdir -p $1
	file_path=$1/$2
	$ORIGINAL_SVN diff > $file_path && $ORIGINAL_SVN revert . --depth infinity 1>/dev/null
	$ORIGINAL_SVN st
}

__get_repository_id() {
	svn info | grep UUID | awk -F': ' '{print $2}'
}

