#!/usr/bin/env bash
# Send clipboard content to a tmux pane char-by-char to survive
# console connections that lose characters without flow control.
pane_id=$1
delay=$2
content=$(pbpaste)
len=${#content}
for ((i = 0; i < len; i++)); do
    char="${content:$i:1}"
    if [[ "$char" == $'\n' ]]; then
        tmux send-keys -t "$pane_id" Enter
    else
        tmux send-keys -t "$pane_id" -l "$char"
    fi
    sleep "$delay"
done
