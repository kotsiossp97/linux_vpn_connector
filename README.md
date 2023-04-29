# linux_vpn_connector
Script that creates connection to PPTP VPN on linux

## Requirements
pptp-linux package must be installed on your machine.
Install it with the command:
```
sudo apt install pptp-linux
```

## Usage
- Download the script on your linux machine.
- Give execution permission to the file.
```shell
chmod +x linux_vpn_connector.sh
```
- Run the script with the required arguments
```shell
sudo ./linux_vpn_connector.sh -n <Connection_Name> -s <VPN_Host> -u <Username> -p <Password>
```
- After script ran successfully, you can connect to the VPN using the command:
```shell
sudo pon <Connection_Name>
```
- To test the connection, you can ping an IP on the VPN:
```shell
ping <IP_Address> -I ppp0
```

>Note: Replace values in <> without the symbols.
>
>e.g:
>
>sudo ./linux_vpn_connector.sh -n testVPN -s 12.34.56.78 -u user -p secretPass!
>
>ping 192.168.0.12
