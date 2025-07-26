# Instructions pour la sauvegarde de l'iPhone et l'extraction des photos

Ce document décrit les étapes pour sauvegarder un iPhone en utilisant `libimobiledevice` et extraire les photos avec un script Python.

## 1. Installation de `libimobiledevice`

Assurez-vous que `libimobiledevice` est installé sur votre système. Vous pouvez l'installer en utilisant votre gestionnaire de paquets. Par exemple, sur Debian/Ubuntu :

```bash
sudo apt-get install libimobiledevice-utils
```

## 2. Sauvegarde de l'iPhone

Connectez votre iPhone à votre ordinateur via USB. Assurez-vous que l'appareil est déverrouillé et que vous faites confiance à l'ordinateur.

Pour créer une sauvegarde, exécutez la commande suivante dans votre terminal :

```bash
idevicebackup2 backup --full /path/to/backup/folder
```

Remplacez `/path/to/backup/folder` par le chemin où vous souhaitez stocker la sauvegarde.

## 3. Extraction des photos

Une fois la sauvegarde terminée, vous pouvez utiliser le script Python fourni pour extraire les photos. Le script lira la base de données de la sauvegarde pour obtenir les informations sur les photos et les copiera dans un nouveau dossier.

Pour exécuter le script, utilisez la commande suivante :

```bash
python3 extract_photos.py /path/to/backup/folder /path/to/output/folder
```

Remplacez `/path/to/backup/folder` par le chemin de la sauvegarde que vous venez de créer et `/path/to/output/folder` par le dossier où vous souhaitez enregistrer les photos extraites.
