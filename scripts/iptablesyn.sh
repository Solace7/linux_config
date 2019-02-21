sudo iptables -A OUTPUT -p tcp --dport 24800 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 24800 -j ACCEPT
