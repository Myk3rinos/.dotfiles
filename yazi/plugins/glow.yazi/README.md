glow.yazi

Plugin for Yazi to preview markdown files with glow. To install, clone the repo inside your ~/.config/yazi/plugins/:

git clone https://github.com/Reledia/glow.yazi.git

then include it in your yazi.toml to use:

[plugin]
prepend_previewers = [
  { name = "*.md", exec = "glow" },
]

Make sure you have glow installed, and can be found in PATH.
