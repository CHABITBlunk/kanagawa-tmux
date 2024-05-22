#!/usr/bin/env bash
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# title      Kanagawa                                                 +
# version    1.0.0                                                    +
# repository https://github.com/chabitblunk/kanagawa-tmux             +
# author     chabitblunk                                              +
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

RESET="#[fg=brightwhite,bg=#080808,nobold,noitalics,nounderscore,nodim]"
CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

tmux set -g status-left-length 80
tmux set -g status-right-length 150

# Highlight colors
tmux set -g mode-style "fg=#c6c6c6,bg=#323437"

tmux set -g message-style "bg=#80a0ff,fg=#323437"
tmux set -g message-command-style "fg=#e4e4e4,bg=#323437"

tmux set -g pane-border-style "fg=#323437"
tmux set -g pane-active-border-style "fg=#80a0ff"

tmux set -g status-style bg="#080808"

SCRIPTS_PATH="$CURRENT_DIR/src"
TMUX_VARS="$(tmux show -g)"
PANE_BASE="$(echo "$TMUX_VARS" | grep pane-base-index | cut -d" " -f2 | bc)"

default_window_id_style="none"
default_pane_id_style="hsquare"
default_zoom_id_style="dsquare"

window_id_style="$(echo "$TMUX_VARS" | grep '@window_id_style' | cut -d" " -f2)"
pane_id_style="$(echo "$TMUX_VARS" | grep '@pane_id_style' | cut -d" " -f2)"
zoom_id_style="$(echo "$TMUX_VARS" | grep '@zoom_id_style' | cut -d" " -f2)"
window_id_style="${window_id_style:-$default_window_id_style}"
pane_id_style="${pane_id_style:-$default_pane_id_style}"
zoom_id_style="${zoom_id_style:-$default_zoom_id_style}"

git_status="#($SCRIPTS_PATH/git-status.sh #{pane_current_path})"
wb_git_status="#($SCRIPTS_PATH/wb-git-status.sh #{pane_current_path} &)"
window_number="#($SCRIPTS_PATH/custom-number.sh #I $window_id_style)"
custom_pane="#($SCRIPTS_PATH/custom-number.sh #P $pane_id_style)"
zoom_number="#($SCRIPTS_PATH/custom-number.sh #P $zoom_id_style)"

#+--- Bars LEFT ---+
# Session name
tmux set -g status-left "#[fg=#080808,bg=#ae81ff,bold] #{?client_prefix,󰠠 ,#[dim]󰤂 }#[fg=#080808,bg=#ae81ff,bold,nodim]#S $RESET"

#+--- Windows ---+
# Focus
tmux set -g window-status-current-format "#[fg=#8cc85f,bg=#080808]   #[fg=#c6c6c6]$window_number #[bold,nodim]#W#[nobold,dim]#{?window_zoomed_flag, $zoom_number, $custom_pane} #{?window_last_flag,,} "
# Unfocused
tmux set -g window-status-format "#[fg=#e4e4e4,bg=default,none,dim]   $window_number #W#[nobold,dim]#{?window_zoomed_flag, $zoom_number, $custom_pane}#[fg=yellow,blink] #{?window_last_flag,󰁯 ,} "

#+--- Bars RIGHT ---+
tmux set -g status-right "  %Y-%m-%d #[]❬ %H:%M $git_status$wb_git_status"
tmux set -g window-status-separator ""
