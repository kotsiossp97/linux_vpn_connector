printUsage(){
    echo "Usage:"
    printf "\t$SCRIPTNAME -n CONNECTION_NAME -s VPN_SERVER -u USERNAME -p PASSWORD\n"
}

checkArguments(){
    if [ -z "$SERVER" ]; then
            echo "Missing argument -s."
            printUsage
            exit 1
    fi

    if [ -z "$USERNAME" ]; then
            echo "Missing argument -u."
            printUsage
            exit 1
    fi

    if [ -z "$PASSWORD" ]; then
            echo "Missing argument -p."
            printUsage
            exit 1
    fi

    if [ -z "$CONNECTION_NAME" ]; then
            echo "Missing argument -n."
            printUsage
            exit 1
    fi
}

testPPTPClient(){
        cmd=$(pptpsetup --help)
        status=$?
        
        if [ $status != 0 ]
        then
                echo "Fatal: pptpclient not found on this system."
                echo "Install it with: apt install pptp-linux"
                echo
                exit 1
        else
                echo "Success: pptp-linux is installed"
                echo
        fi
}

testPPTPClient

SCRIPTNAME="$0"

while getopts "hn:s:u:p:" option; do
        case $option in
                n)
                        CONNECTION_NAME="$OPTARG";;
                s)
                        SERVER="$OPTARG";;
                u)
                        USERNAME="$OPTARG";;
                p)
                        PASSWORD="$OPTARG";;
                \:)
                        printf "Argument missing from %s option\n" $OPTARG;;
                h | *)
                        printUsage
                        exit 0
                        ;;
        esac    
done

checkArguments

CREATE_CMD="pptpsetup --create $CONNECTION_NAME --server $SERVER --username $USERNAME --password $PASSWORD"

$($CREATE_CMD)
status=$?

if [ $status != 0 ]
then
        echo "Failure in command pptpsetup"
        echo
        exit 1
fi

echo "require-mppe-128" >> /etc/ppp/peers/$CONNECTION_NAME

echo "Connection to $CONNECTION_NAME VPN successfully created."
echo "To connect to the VPN use the command:"
printf "\tpon $CONNECTION_NAME"
echo

echo "To route connections to specific IPs through the VPN use the command:"
printf "\tip route add 10.2.8.0/24 dev ppp0"
printf "This routes all connections to 10.2.8.* through the VPN.\nReplace the IP as needed."
