Pour X11, la meilleure option est xwinwrap + mpv :
bashsudo apt install mpv
Ensuite installe xwinwrap :
bashsudo apt install xwinwrap
Si xwinwrap n'est pas disponible directement :
bashsudo apt install wmctrl x11-utils
git clone https://github.com/ujjwal96/xwinwrap
cd xwinwrap
make
sudo make install
Puis lance ton fichier en fond d'écran :
bashxwinwrap -fs -fdt -ni -b -nf -un -o 1.0 -- mpv -wid WID --loop --no-audio /chemin/vers/
