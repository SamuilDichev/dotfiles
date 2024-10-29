#!/bin/bash

repos_path="$HOME/repos"

# Function to check if a session exists
session_exists() {
    tmux has-session -t "$1" 2>/dev/null
}

# Function to create a session if it doesn't exist
create_session() {
    local session_name="$1"
    local session_path="$2"

    if ! session_exists "$session_name"; then
        tmux new-session -d -s "$session_name" -c "$session_path"
        tmux split-window -h -c "$session_path"
        tmux split-window -v -c "$session_path"
        tmux select-pane -t 1
    fi
}

# General
create_session "dotfiles" "$repos_path/dotfiles"
create_session "General" "~"

# Work
create_session "Trade Ticket" "$repos_path/trade-ticket-service"
