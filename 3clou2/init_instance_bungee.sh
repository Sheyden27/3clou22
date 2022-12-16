#!/usr/bin/bash

touch /root/initstart

cd /root/
apt-get install -y default-jdk
mkdir minecraft_bungee
cd minecraft_bungee
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
rm server.properties
mv 'server.properties?dl=1' server.properties
wget https://www.dropbox.com/s/jd3jfgc2aaaopw6/spigot.yml?dl=1
rm spigot.yml
mv 'spigot.yml?dl=1' spigot.yml
sudo iptables -A INPUT -p tcp --dport 25565 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 25577 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
apt install tmux
wget https://ci.md-5.net/job/BungeeCord/lastSuccessfulBuild/artifact/bootstrap/target/BungeeCord.jar
java -Xms512M -Xmx512M -jar BungeeCord.jar<<EOF

end
EOF
wget http://www.multicraft.org/download/conf/?file=bungeecord.jar.conf
mv index.html\?file\=bungeecord.jar.conf bungeecord.jar.conf
wget https://www.dropbox.com/s/c6492uqwnlrebfl/config.yml?dl=1
rm config.yml
mv 'config.yml?dl=1' config.yml

n=1
servname=""
scw-userdata | grep srv | cut -d "=" -f2 | while read -r line ;
do echo $line;
if (($n % 2 != 0))
then
servname=`scw-userdata $line`
echo "  $servname:"  >> /root/minecraft_bungee/config.yml;
fi
if (($n % 2 == 0))
then
echo "    address:" | tr "\n" " " >> /root/minecraft_bungee/config.yml;
scw-userdata $line >> /root/minecraft_bungee/config.yml;
fi
n=$((n+1));
done

tmux new -d -s bungee_minecraft
tmux send-keys -t bungee_minecraft "java -Xms512M -Xmx1G -jar BungeeCord.jar" ENTER
tmux new -d -s bungee_server_minecraft
tmux send-keys -t bungee_server_minecraft "java -Xms1G -Xmx3G -jar spigot-1.14.jar" ENTER

touch /root/initend


