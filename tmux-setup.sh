#!/bin/bash

repos_path="$HOME/repos"

# Function to check if a session exists
session_exists() {
    tmux has-session -t "$1" 2>/dev/null
}

# Function to create a session if it doesn't exist
create_session() {
    local session_name="$1"
	shift
	local session_paths=("$@")

    if session_exists "$session_name"; then
        return
    fi

    tmux new-session -d -s "$session_name" -c "${session_paths[0]}"
    tmux split-window -h -c "${session_paths[0]}"
    tmux select-pane -t 1

    for path in  "${session_paths[@]:1}"; do
        tmux new-window -t "$session_name:" -c "$path"
        tmux split-window -h -c "$path"
        tmux select-pane -t 1
    done

	tmux select-window -t "$session_name:1"
	tmux select-pane -t 1

}

# General
create_session "dotfiles" "$repos_path/dotfiles"
create_session "General" "~"

# Work
create_session "Trade Ticket" "$repos_path/trade-ticket-service" "$repos_path/trade-ticket-ui-23"
