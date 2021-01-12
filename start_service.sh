echo "looking for file!"

timeout=600

while [ ! -f /etc/systemd/system/openvpn.service ];
do
  # When the timeout is equal to zero, show an error and leave the loop.
  if [ "$timeout" == 0 ]; then
    echo "ERROR: Timeout while waiting for the file"
  fi

  if [ $(($timeout%30)) == 0 ]; then
  	echo "${timeout} seconds remaining"
  fi
sudo systemctl daemon-reload
  sleep 1

  # Decrease the timeout of one
  ((timeout--))
done

echo "reloading daemon"
sudo systemctl daemon-reload
echo "enabling service"
sudo systemctl enable openvpn.service
echo "starting service"
sudo systemctl start openvpn.service
echo "checking status"
sudo systemctl status openvpn.service -l
