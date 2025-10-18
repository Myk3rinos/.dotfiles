#!/bin/bash

# Script pour lancer le menu Kitty centré à l'écran

# Dimensions de la fenêtre
WINDOW_WIDTH=600
WINDOW_HEIGHT=300

# Fonction pour centrer avec xdotool (X11)
center_with_xdotool() {
    # sleep 0.5

    # Trouver la fenêtre
    local window_id=$(xdotool search --class "kitty-menu" 2>/dev/null | tail -1)

    if [ -n "$window_id" ]; then
        # Obtenir les dimensions de l'écran
        eval $(xdotool getdisplaygeometry --shell)

        # Calculer la position centrale
        local x=$(( (WIDTH - WINDOW_WIDTH) / 2 ))
        local y=$(( (HEIGHT - WINDOW_HEIGHT) / 2 ))

        # Positionner la fenêtre
        xdotool windowmove "$window_id" $x $y
        xdotool windowsize "$window_id" $WINDOW_WIDTH $WINDOW_HEIGHT
    fi
}

# Fonction pour centrer avec wmctrl (X11)
center_with_wmctrl() {
    # sleep 0.5

    # Obtenir les dimensions de l'écran
    local screen_info=$(xrandr --current | grep '*' | head -1 | awk '{print $1}')
    local screen_width=$(echo $screen_info | cut -d'x' -f1)
    local screen_height=$(echo $screen_info | cut -d'x' -f2)

    # Calculer la position centrale
    local x=$(( (screen_width - WINDOW_WIDTH) / 2 ))
    local y=$(( (screen_height - WINDOW_HEIGHT) / 2 ))

    # Positionner la fenêtre
    wmctrl -r "kitty-menu" -e "0,$x,$y,$WINDOW_WIDTH,$WINDOW_HEIGHT"
}

# Vérifier si une instance du menu est déjà ouverte
if xdotool search --class "kitty-menu" &>/dev/null; then
    # Fenêtre déjà ouverte, la mettre au premier plan
    xdotool search --class "kitty-menu" windowactivate
    exit 0
fi

# Lancer Kitty avec le menu
kitty --config /home/will/.dotfiles/kitty/kitty_menu.conf \
      --class kitty-menu \
      --name kitty-menu \
      --title "Menu de sélection" \
      bash /home/will/.dotfiles/script/menu/menu_select.sh &

KITTY_PID=$!

# Attendre un peu et centrer la fenêtre
if command -v xdotool &> /dev/null; then
    center_with_xdotool
elif command -v wmctrl &> /dev/null; then
    center_with_wmctrl
fi

# Attendre la fin du processus kitty
wait $KITTY_PID
