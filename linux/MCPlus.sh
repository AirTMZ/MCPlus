#!/usr/bin/env bash
ETC_HOSTS=/etc/hosts
RED='\033[1;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
NC='\033[0m' 

function uninstall() {
	echo -e "${WHITE}━━━︱MCPlus︱━━━${NC}"
    IP="144.172.75.113"
    HOSTNAME="s.optifine.net"
    HOSTS_LINE="$IP[[:space:]]$HOSTNAME"
    if [ -n "$(grep -P $HOSTS_LINE $ETC_HOSTS)" ]
    then
        echo -e "${YELLOW}MCPlus was found, Removing now...${NC}";
        sudo sed -i".bak" "/$HOSTS_LINE/d" $ETC_HOSTS
		if [ -n "$(grep -P $HOSTNAME $ETC_HOSTS)" ]
                then
                    echo -e "${RED}Something went wrong when uninstalling MCPlus, Try again.${NC}";
                else
                    echo -e "${GREEN}MCPlus was successfully uninstalled :(${NC}";
        fi
    else
        echo -e "${RED}MCPlus was not found ¯\_(ツ)_/¯${NC}";
    fi
}

function install() {
	echo -e "${WHITE}━━━︱MCPlus︱━━━${NC}"
    IP="144.172.75.113"
    HOSTNAME="s.optifine.net"
    HOSTS_LINE="$IP[[:space:]]$HOSTNAME"
    line_content=$( printf "%s\t%s\n" "$IP" "$HOSTNAME" )
    if [ -n "$(grep -P $HOSTS_LINE $ETC_HOSTS)" ]
        then
            echo -e "${RED}MCPlus is already installed${NC}"
        else
            echo -e "${YELLOW}Installing MCPlus...${NC}";
            sudo -- sh -c -e "echo '$line_content' >> /etc/hosts";

            if [ -n "$(grep -P $HOSTNAME $ETC_HOSTS)" ]
                then
                    echo -e "${GREEN}MCPlus was installed succesfully :)${NC}";
                else
                    echo -e "${RED}Failed to install MCPlus, Try again.${NC}";
            fi
    fi
}

if [ $# -eq 0 ]
  then
	echo -e "${BLUE{WHITE}━━━︱MCPlus︱━━━${NC}"
    echo -e "${RED}Please supply an argument and try again.${NC}"
fi

$@