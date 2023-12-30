# KEYBINDS
bind r source-file ~/.tmux.conf \; display "Config reloaded!"
bind t neww -n "todo" -c "#{pane_current_path}" "[[ -e .todo.tdt ]] && vim .todo.tdt || vim ~/.todo.tdt"
bind T neww -n "todo" -c "#{pane_current_path}" "vim ~/.todo.tdt"
bind Q neww -n "sql" -c "#{pane_current_path}" 'vim -c "DBUI"'
bind C-s neww -n "mktm" -c "#{pane_current_path}" "mktm"
bind * run-shell -b "mktm" -c "#{pane_current_path}" "pomo start"
bind @ run-shell -b "mktm" -c "#{pane_current_path}" "pomo stop"

# HA! SEE THIS SCREEN? WE CAN SPLIT BOTH WAYS WITHOUT BREAKING VERSIONS.
bind c new-window -c "#{pane_current_path}"
bind | split-window -h -c "#{pane_current_path}"
bind - split-window -v -c "#{pane_current_path}"
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# Join a pane to the window
bind a choose-tree "joinp -h -s %%"
bind u choose-tree "breakp -da -s %%"

bind -r C-h select-window -t :-
bind -r C-l select-window -t :+
bind -r H resize-pane -L 5
bind -r J resize-pane -D 5
bind -r K resize-pane -U 5
bind -r L resize-pane -R 5
