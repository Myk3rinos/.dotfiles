return {
    'danilamihailov/beacon.nvim',
    event = 'VeryLazy',
    config = function()
        require('beacon').setup({
            enabled = true,                      -- Activer le beacon
            speed = 2,                           -- Vitesse de l'animation (plus = plus rapide)
            width = 40,                          -- Largeur de la fenêtre beacon
            winblend = 70,                       -- Transparence initiale (0-100)
            fps = 60,                            -- FPS de l'animation
            min_jump = 10,                       -- Saut minimal pour déclencher (en lignes)
            cursor_events = { 'CursorMoved' },   -- Événements qui déclenchent le beacon
            window_events = { 'WinEnter', 'FocusGained' },  -- Événements de fenêtre
            highlight = {
                bg = '#C792EA',                  -- Couleur violet/mauve
                ctermbg = 15
            }
        })
    end,
}
