🛠️ 2. Correctif automatique après la veille (RECOMMANDÉ)
Crée le script :
sudo nano /lib/systemd/system-sleep/fix-igc

Colle ceci :
#!/bin/sh
case "$1" in
  post)
    /sbin/modprobe -r igc
    /sbin/modprobe igc
    ;;
esac

Rends-le exécutable :
sudo chmod +x /lib/systemd/system-sleep/fix-igc

tion complémentaire (si jamais ça persiste)

