# fish-history-merger

### Example usage
```
#!/bin/sh
fish-history-merger ~/.local/share/fish/fish_history ~/Dropbox/fish_history | tee ~/.local/share/fish/fish_history.temp ~/Dropbox/fish_history.temp > /dev/null
mv ~/.local/share/fish/fish_history.temp ~/.local/share/fish/fish_history
mv ~/Dropbox/fish_history.temp ~/Dropbox/fish_history
```
