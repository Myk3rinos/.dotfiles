
# 🎨 Render Markdown - Démonstration Complète

Guide complet des fonctionnalités de [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim)

1. [test](~/.dotfiles/test.md)
2. [kitty conf](~/.dotfiles/kitty/kitty_n.conf)
---

## 📝 Table des matières

1. [Titres](#titres)
2. [Emphases et Styles](#emphases-et-styles)
3. [Listes](#listes)
4. [Citations](#citations)
5. [Blocs de Code](#blocs-de-code)
6. [Liens](#liens)
7. [Tableaux](#tableaux)
8. [Cases à cocher](#cases-à-cocher)

---

## 📋 Titres

Render-markdown affiche des icônes colorées pour chaque niveau de titre :

# Titre Niveau 1 - 󰎤 Rose vif
## Titre Niveau 2 - 󰲣 Violet
### Titre Niveau 3 - 󰲥 Bleu
#### Titre Niveau 4 - 󰲧 Cyan
##### Titre Niveau 5 - 󰲩 Vert
###### Titre Niveau 6 - 󰲫 Jaune/Orange

---

## ✨ Emphases et Styles

Différents styles de texte sont supportés :

- **Texte en gras** avec `**texte**`
- *Texte en italique* avec `*texte*`
- ***Texte gras et italique*** avec `***texte***`
- ~~Texte barré~~ avec `~~texte~~`
- `Code inline` avec des backticks

---

## 📌 Listes

### Listes non ordonnées

Les puces changent selon le niveau :

- Premier niveau ●
  - Deuxième niveau ○
    - Troisième niveau ◆
      - Quatrième niveau ◇

### Listes ordonnées

1. Premier élément
2. Deuxième élément
3. Troisième élément
   1. Sous-élément A
   2. Sous-élément B
4. Quatrième élément

### Listes mixtes

- Fruits
  1. Pommes
  2. Bananes
  3. Oranges
- Légumes
  1. Carottes
  2. Tomates

---

## 💬 Citations

> Ceci est une citation simple
> Elle peut s'étendre sur plusieurs lignes

> **Citation avec style**
>
> On peut inclure du *formatage* et du `code` dans les citations
>
> > Citation imbriquée niveau 2

---

## 💻 Blocs de Code

### Code Bash (exécutable avec Ctrl+o)

```bash
#!/bin/bash
echo "Hello from Markdown!"
echo "Date: $(date)"
ls -la ~/.dotfiles
```

### Code JavaScript

```javascript
function fibonacci(n) {
  if (n <= 1) return n;
  return fibonacci(n - 1) + fibonacci(n - 2);
}

console.log(fibonacci(10)); // 55
```

### Code Python

```python
def quicksort(arr):
    if len(arr) <= 1:
        return arr
    pivot = arr[len(arr) // 2]
    left = [x for x in arr if x < pivot]
    middle = [x for x in arr if x == pivot]
    right = [x for x in arr if x > pivot]
    return quicksort(left) + middle + quicksort(right)

print(quicksort([3,6,8,10,1,2,1]))
```

### Code inline

Utilisez `npm install` ou `cargo build` dans vos commandes.

---

## 🔗 Liens

### Liens vers fichiers locaux

- [Documentation locale](test.md)
- [Lien relatif](./test.md)

### Liens web avec icônes personnalisées

- [Site web générique](https://example.com) - icône web 󰖟
- [GitHub](https://github.com) - icône GitHub 󰊤
- [Discord](https://discord.com) - icône Discord 󰙯

### Liens avec ancres

- [Aller aux tableaux](#tableaux)
- [Retour en haut](#-render-markdown---démonstration-complète)

### Email et URL automatiques

Contactez-moi : <email@example.com>
Site web : <https://example.com>

---

## 📊 Tableaux

### Tableau simple

| Nom          | Description                    | Statut  | Priorité |
|--------------|--------------------------------|---------|----------|
| Neovim       | Éditeur de texte configuré     | ✅ Fait | Haute    |
| Lazygit      | Interface Git dans le terminal | ✅ Fait | Haute    |
| RMPC         | Client MPD pour la musique     | ✅ Fait | Moyenne  |
| Yazi         | Gestionnaire de fichiers       | ✅ Fait | Moyenne  |

### Tableau avec alignement

| Gauche | Centre | Droite |
|:-------|:------:|-------:|
| G1     |   C1   |     D1 |
| G2     |   C2   |     D2 |
| G3     |   C3   |     D3 |

### Tableau des raccourcis

| Touche         | Action                          | Mode    |
|----------------|---------------------------------|---------|
| `Enter`        | Suivre le lien                  | Normal  |
| `Ctrl+Enter`   | Ouvrir le lien (force)          | Normal  |
| `Ctrl+o`       | Exécuter bloc bash / Retour     | Normal  |
| `gf`           | Aller au fichier                | Normal  |

### Tableau avec code et styles

| Commande       | Description                     | Exemple             |
|----------------|---------------------------------|---------------------|
| `npm install`  | Installe les dépendances        | **Important** ⚠️    |
| `cargo build`  | Compile le projet Rust          | *Rapide* ⚡         |
| `git commit`   | Crée un commit                  | `git commit -m ...` |

---

## ✅ Cases à cocher (Task lists)

### To-Do List projet

- [x] Configurer Neovim
- [x] Installer les plugins
- [ ] Mettre à jour vers Neovim 0.10
- [ ] Configurer LSP pour tous les langages
  - [x] Lua
  - [x] Bash
  - [x] JavaScript
  - [ ] Python
  - [ ] Rust
- [x] Thèmes de couleurs
- [ ] Documentation complète

### Checklist quotidienne

- [ ] Vérifier les emails
- [ ] Mettre à jour les dépendances
- [ ] Faire un backup
- [ ] Tester les nouvelles fonctionnalités

---

## 🎯 Fonctionnalités avancées

### Emojis et symboles

- ✅ Fait
- ❌ Erreur
- ⚠️ Avertissement
- 💡 Idée
- 🚀 Déploiement
- 📝 Documentation
- 🔧 Configuration
- 🎨 Design
- 🐛 Bug
- ⚡ Performance

---

## 🧪 Tests et Scripts exécutables

### Script de test système

```bash
echo "=== Informations Système ==="
uname -a
echo ""
echo "=== Neovim Version ==="
nvim --version | head -n 1
echo ""
echo "=== Dotfiles ==="
ls -lh ~/.dotfiles
```

### Script utilitaire

```bash
# Nettoyage rapide
echo "Nettoyage du cache..."
sudo apt autoclean
sudo apt autoremove
echo "✅ Nettoyage terminé!"
```

### Lancer btop

```bash
btop
```

### Programmes GUI (lancés en arrière-plan)

Ces programmes s'ouvrent sans bloquer Neovim :

**Ouvrir Kitty :**
```bash
kitty
```

```bash
kitty && rmpc
```


**Ouvrir Yazi (file manager) :**
```bash
yazi
```

**Ouvrir Lazygit :**
```bash
lazygit
```

**Ouvrir un nouveau Neovim :**
```bash
nvim ~/.dotfiles/MENU.md
```

---

## 📚 Ressources et Liens utiles

### Documentation

- 📖 [Render Markdown GitHub](https://github.com/MeanderingProgrammer/render-markdown.nvim)
- 📖 [Markdown Guide](https://www.markdownguide.org)
- 📖 [Neovim Documentation](https://neovim.io/doc)

---

## 🎨 Conclusion

Ce fichier démontre toutes les capacités de **render-markdown.nvim** :

1. ✨ Rendu magnifique des éléments Markdown
2. 🎨 Coloration syntaxique personnalisée
3. 🔗 Liens interactifs
4. 💻 Blocs de code exécutables
5. 📊 Tableaux bien formatés
6. ✅ Listes de tâches interactives

> **Note importante** : Pour profiter pleinement de toutes ces fonctionnalités,
> assurez-vous d'avoir Neovim 0.10+ et tous les plugins nécessaires installés.

---

*Dernière mise à jour : 2025 | Créé avec ❤️ et Neovim*
