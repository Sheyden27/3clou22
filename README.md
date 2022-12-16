# 3clou22
## Comment déployer un BungeeCord Minecraft avec des serveurs indépendants
(Fonctionne avec Scaleway, scaleway CLI, et nécessite terraform cli ainsi que GIT, téléchargez-les préalablements:
https://www.scaleway.com/en/cli/, https://developer.hashicorp.com/terraform/downloads, https://git-scm.com/downloads) <br> <br>
Tout d'abord cloner le repository ici présent 3clou22
### Executer les commandes suivantes:


```
(local)$ git clone https://github.com/Sheyden27/3clou22
(local)$ cd 3clou22
(local)$ make init
(local)$ make apply
```
A la suite de cette dernière commande, vous pourrez voir l'ip de votre Bungee et de vos serveurs minecraft,
### **Notez bien l'ip du Bungee** pour plus tard vous y connecter !!

## Attendre ensuite le déploiement du Bungee et des serveurs associés

Pour monitorer ce qui a été créé (OPTIONNEL) :
```
(local)$ ./go bungee-ip
ou (local)$ ./go srvmine1
ou (local)$ ./go srvmine2
(instance distante)# pstree
(instance distante)# ls
```
### Après un ls, si le fichier "initend" est présent, cela signifie que l'installation est terminée
Si le fichier "initstart" n'est pas présent, l'installation n'a pas démarré ! <br>
Il y a surement un problème avec Scaleway dans ce cas, vérifier la création de l'instance sur la console cloud web Scaleway

#### Les fichiers concernant les serveurs déployés se trouvent dans le dossier
- /root/minecraft_bungee <br>ou
- /root/minecraft_server

Selon le role de la machine <br>
La configuration du bungee et des serveurs est automatique
<br> <br> <br>

# Comment se connecter pour commencer à jouer
Utilisez votre client minecraft officiel, ou téléchargez minecraft officiel et placez-vous sur la version 1.14 : https://www.minecraft.net/fr-fr <br>
Si vous **ne disposez pas** de minecraft officiel, utilisez TLauncher pour vous connecter à votre serveur: https://tlauncher.org/en/

## Installation de TLauncher sur Windows:
Utiliser le client executable via le site de TLauncher: https://tlauncher.org/installer

## Installation de TLauncher sur Linux:
### Utiliser le jar que nous mettons à disposition, (plus rapide, préfait)
```
wget https://www.dropbox.com/s/yxwhoryynxk0l6o/TLauncher-2.86.jar?dl=1
mv 'TLauncher-2.86.jar?dl=1' TLauncher-2.86.jar
java -jar TLauncher-2.86.jar
```
### Utiliser l'archive mise à disposition par TLauncher:
```
wget https://tlauncher.org/jar
```
Extraire ensuite l'archive et executer le jar TLauncher.jar avec : 
```
java -jar "VotreJarTLauncher.jar"
```

## Vous serez alors surement invité(e) à mettre à jour TLauncher:
Soit : cliquez sur me rappeler plus tard (plus rapide) <br>
Soit : cliquez sur mettre à jour

## Choix de la version minecraft
Les serveurs minecraft installés sont des serveurs fonctionnant en version 1.14 de minecraft. <br>
Afin de vous connecter à votre serveur minecraft, fixez la version de votre client minecraft sur la **version 1.14** <br>
Vous pouvez **sélectionner la version** en bas à gauche de la fenetre TLauncher <br>
Lancez ensuite le jeu en cliquant sur le bouton jouer

## Se connecter au serveur minecraft
Une fois le jeu lancé, et sur l'écran d'accueil de Minecraft, sélectionnez **multijoueur**
- Ajoutez un nouveau serveur
- Entrez l'ip de l'instance bungee (que vous aviez noté plus tôt) suivie de ":" et du port "25577"
(l'ip devrait ressembler à quelque chose de cette forme là -> **166.166.166.166:25577**, avec une ip différente)
- Confirmez l'ajout du serveur que vous venez d'ajouter
- Cliquez ensuite sur le serveur dans la liste des serveurs puis rejoindre, ou tout simplement double-cliquez dessus

Félicitations, vous êtes connecté(e) au serveur Minecraft !

## Mais où sont les autres serveurs ???
Pour changer de serveur, utilisez la commande suivante sur le tchat minecraft (ouvrez-le avec la touche T par défaut, échap pour quitter le tchat)
```
/server "nom_du_serveur"
```
- En tapant la commande "/server " vous pouvez naviguer entre les différents noms de serveurs disponible en appuyant sur la touche TAB (les deux flèches au dessus de VERR.MAJ, à gauche de la touche A sur un clavier AZERTY)
- Appuyez ensuite sur entrer pour valider votre action, vous serez alors amené(e) sur l'autre serveur

Bravo, vous avez une infrastructure complète qui vous permet de naviguer sur différentes machines avec chacune un serveur hébergé dessus directement via votre client Minecraft !
