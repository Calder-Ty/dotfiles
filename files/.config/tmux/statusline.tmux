set -g status-position top
# Left
set -g status-left
set -g status-left-length 30
set -g status-left '#[fg=colour244][#S]'

# Centre
set -g status-fg white
set -g status-style bg=terminal
set -g status-justify left
setw -g window-status-current-format ' #I:#W#F '
setw -g window-status-style 'fg=colour244'
setw -g window-status-format ' #I:#W#F '

set -g @statusline_volume "#(/home/tyler/.config/tmux/scripts/audiobar.sh volume)"
set -g @statusline_title "#(/home/tyler/.config/tmux/scripts/audiobar.sh title | cut -c1-20)"
set -g @statusline_artist "#(/home/tyler/.config/tmux/scripts/audiobar.sh artist | cut -c1-20)"
set -g @statusline_pomodoro "#{?#(pomo status | cut -f1 -d' '),#[fg=#8f40ff],#[fg=#c72c77]}#(/home/tyler/.config/tmux/plugins/pomo-status-bar)"

# First empty the status line
set -g status-right-length 100
set -g status-right ''
# set -aFg status-right '#[fg=#5e5e5e]#{@statusline_pomodoro}'
# set -aFg status-right ' #[fg=#5e5e5e]#{@statusline_volume}'
# set -ag status-right ' #[fg=#8f40ff]#[bg=#8f40ff]'
set -aFg status-right ' #[fg=lightgreen]#{@statusline_title}'
set -aFg status-right ' #[fg=cyan]#{@statusline_artist}'
# set -ag status-right '#[fg=#8f40ff]#[bg=default]'
set -ag status-right ' #[fg=blue]%H:%M:%S #[fg=green]%Y-%m-%d'
