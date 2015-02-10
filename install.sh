SOURCE_COMMAND="source $HOME/.ssk.sh"
RC_FILE_EXT="rc"

shell=`echo $SHELL | awk -F/ '{print $NF}'`
os=`cat /etc/*-release | grep ID | awk -F= '{print $2}'`

echo "Running OS 	:	$os"
echo "Running shell :	$shell"

echo "Copying resources ..."
cp ssk.sh $HOME/.ssk.sh

rc_file="$HOME/.$shell$RC_FILE_EXT"
if [ -f $rc_file ] ; then
	echo "Configuring in $rc_file ..."

	grep $SOURCE_COMMAND 1>/dev/null
	if [ $? -eq 1 ] ; then
		echo $SOURCE_COMMAND >> /$rc_file
	fi

	source $rc_file
	echo "It's done !"
else
	# TODO create the file or let the user select the file name
	echo "ERROR"
fi

case $os in
	'arch')
		echo "pacman -S colorsvn colordiff"
		;;
esac
