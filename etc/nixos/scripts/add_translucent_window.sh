#!/usr/bin/env bash
#!/bin/bash

CONFIG="$HOME/.config/hypr/categories/windows_opacity.conf"

ACTIVE_OPACITY="0.85"
INACTIVE_OPACITY="0.85"

# Get class of the currently focused window without jq
WINDOW_CLASS=$(hyprctl activewindow -j | grep -o '"class": *"[^"]*"' | sed 's/"class": *"\(.*\)"/\1/')

if [ -z "$WINDOW_CLASS" ]; then
  echo "No active window detected."
  exit 1
fi

RULE="windowrule = opacity $ACTIVE_OPACITY, $INACTIVE_OPACITY,class:^($WINDOW_CLASS)$"

# Check if rule already exists
if grep -Fxq "$RULE" "$CONFIG"; then
  echo "Rule for class '$WINDOW_CLASS' already exists."
else
  echo "$RULE" >>"$CONFIG"
  echo "Added rule: $RULE"
  dunstify "Added blur to: $WINDOW_CLASS"
fi

# Reload Hyprland config
hyprctl reload
