#!/usr/bin/bash

touch /root/initstart

cd /root/
apt-get install -y default-jdk
mkdir minecraft_server
cd minecraft_server
wget https://cdn.getbukkit.org/spigot/spigot-1.14.jar
java -Xms1G -Xmx1G -XX:+UseG1GC -jar spigot-1.14.jar nogui<<EOF

stop
EOF
rm eula.txt
echo "eula=true" > eula.txt

sudo apt-get install -y git openjdk-8-jre-headless
wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
git config --global --unset core.autocrlf
java -jar BuildTools.jar
rm server_properties
wget https://www.dropbox.com/s/3z446jutacgx241/server.properties?dl=1
mv 'server.properties?dl=1' server.properties
wget https://www.dropbox.com/s/jd3jfgc2aaaopw6/spigot.yml?dl=1
mv 'spigot.yml?dl=1' spigot.yml
sudo iptables -A INPUT -p tcp --dport 25565 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 25577 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
apt install tmux
tmux new -d -s server_minecraft 
tmux send-keys -t server_minecraft "java -Xms1G -Xmx3G -XX:+UseG1GC -jar spigot-1.14.jar nogui" 
ENTER

touch /root/initend
