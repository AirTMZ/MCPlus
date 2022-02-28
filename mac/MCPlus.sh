#!/bin/sh

ETC_HOSTS=/etc/hosts
OLD_OSX=/private/etc/hosts
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
NC='\033[0m' 


function uninstall() {
   if [ -f "$ETC_HOSTS" ]
   then
		echo -e "${WHITE}	${NC}"
		IP="144.172.75.113"
		HOSTNAME="s.optifine.net"
		HOSTS_LINE="$IP[[:space:]]$HOSTNAME"
		if [ -n "$(grep $HOSTS_LINE $ETC_HOSTS)" ]
		then
			echo -e "${YELLOW}MCPlus found in hosts file, Removing now...${NC}";
			sudo sed -i".bak" "/$HOSTS_LINE/d" $ETC_HOSTS
			sudo dscacheutil -flushcache;
			if [ -n "$(grep $HOSTNAME $ETC_HOSTS)" ]
                then
                    echo -e "${RED}Something went wrong when uninstalling MCPlus, Try again.${NC}";
                else
                    echo -e "${GREEN}MCPlus was successfully uninstalled :(${NC}";
			fi
		else
			echo -e "${RED}MCPlus was not found in your $ETC_HOSTS file.${NC}";
		fi
   else
		IP="144.172.75.113"
		HOSTNAME="s.optifine.net"
		HOSTS_LINE="$IP[[:space:]]$HOSTNAME"
		if [ -n "$(grep $HOSTS_LINE $OLD_OSX)" ]
		then
			echo -e "${YELLOW}MCPlus was found, Removing now...${NC}";
			sudo sed -i".bak" "/$HOSTS_LINE/d" $OLD_OSX
			sudo dscacheutil -flushcache;
			if [ -n "$(grep $HOSTNAME $OLD_OSX)" ]
                then
                    echo -e "${RED}Something went wrong when uninstalling MCPlus, Try again.${NC}";
                else
                    echo -e "${GREEN}MCPlus was successfully uninstalled :(${NC}";
			fi
		else
			echo -e "${RED}MCPlus was not found ¯\_(ツ)_/¯${NC}";
		fi
	fi	
}

function install() {
	echo -e "${WHITE}━━━︱MCPlus︱━━━${NC}"
    IP="144.172.75.113"
    HOSTNAME="s.optifine.net"
    HOSTS_LINE="$IP[[:space:]]$HOSTNAME"
    line_content=$( printf "%s\t%s\n" "$IP" "$HOSTNAME" )
	if [ -f "$ETC_HOSTS" ];
	then
		if [ -n "$(grep $HOSTS_LINE $ETC_HOSTS)" ]
        then
            echo -e "${RED}MCPlus is already installed${NC}"
        else
            echo -e "${YELLOW}Installing MCPlus${NC}";
			sudo sed -i".bak" "/$HOSTNAME/d" $ETC_HOSTS;
            sudo -- sh -c -e "echo '$line_content' >> /etc/hosts";
			sudo dscacheutil -flushcache;

            if [ -n "$(grep $HOSTNAME $ETC_HOSTS)" ]
                then
                    echo -e "${GREEN}MCPlus was installed succesfully!${NC}";
                else
                    echo -e "${RED}Failed to install MCPlus, Try again.${NC}";
            fi
		fi
	else
		IP="144.172.75.113"
		HOSTNAME="s.optifine.net"
		HOSTS_LINE="$IP[[:space:]]$HOSTNAME"
		line_content=$( printf "%s\t%s\n" "$IP" "$HOSTNAME" )
		if [ -n "$(grep $HOSTS_LINE $OLD_OSX)" ]
        then
            echo -e "${RED}MCPlus is already installed${NC}"
        else
            echo "Installing MCPlus...";
			echo -e "${YELLOW}Installing MCPlus${NC}";
			sudo sed -i".bak" "/$HOSTNAME/d" $OLD_OSX;
            sudo -- sh -c -e "echo '$line_content' >> /private/etc/hosts";
			sudo dscacheutil -flushcache;

            if [ -n "$(grep $HOSTNAME $OLD_OSX)" ]
                then
                    echo -e "${GREEN}MCPlus was installed succesfully :)${NC}";
                else
                    echo -e "${RED}Failed to install MCPlus, Try again.${NC}";
            fi
		fi
	fi
}

if [ $# -eq 0 ]
  then
    echo -e "${WHITE}━━━︱MCPlus︱━━━${NC}"
    echo -e "${RED}Please supply an argument and try again.${NC}"
fi

$@
