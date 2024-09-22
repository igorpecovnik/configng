desc(){
case $1 in
    clear)
    echo "Clear screen on login"
    ;;
    header)
    echo "Show header with logo"
    ;;
    sysinfo)
    echo "Display system information"
    ;;
    tips)
    echo "Show Armbian team tips"
    ;;
    commands)
    echo "Show recommended commands"
    ;;
    *)
    echo "No desc"
    ;;
esac
}

function status(){
source /etc/default/armbian-motd
if [[ $MOTD_DISABLE == *$1* ]] ; then
echo "ON"
else
echo "OFF"
fi
}

i=0
LIST=()
for v in $(grep THIS_SCRIPT= /etc/update-motd.d/* | cut -d"=" -f2 | sed "s/\"//g"); do
i=$(( i + 1 ))
#LIST+=("1" "The first option" OFF)
LIST+=("$v" "$(desc $v)" "$(status $v)")
#LIST+=("$(echo $v) $(status $v) ")")
done

INLIST=($(grep THIS_SCRIPT= /etc/update-motd.d/* | cut -d"=" -f2 | sed "s/\"//g"))
CHOICES=$(whiptail --separate-output --nocancel --title "Adjust welcome screen" --checklist "" 11 50 5 "${LIST[@]}" 3>&1 1>&2 2>&3)
echo ${INLIST[@]} ${CHOICES[@]} | tr ' ' '\n' | sort | uniq -u