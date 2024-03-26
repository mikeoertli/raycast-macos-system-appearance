#!/usr/bin/env bash

# @raycast.title Set/toggle macOS system appearance
# @raycast.author Mike Oertli
# @raycast.authorURL https://github.com/mikeoertli
# @raycast.description Set or toggle the macOS system appearance (light mode, dark mode, or toggle).

# @raycast.icon images/appearance.png
# @raycast.mode silent
# @raycast.packageName system
# @raycast.schemaVersion 1
# @raycast.argument1 { "type": "dropdown", "placeholder": "Toggle", "percentEncoded": false, "optional": true, "data": [{"title": "Toggle", "value": "toggle"}, {"title": "Dark", "value": "dark"}, {"title": "Light", "value": "light"}]}


# Function to switch to Light Mode
set_light_mode() {
    osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to false'
}

# Function to switch to Dark Mode
set_dark_mode() {
    osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to true'
}

get_appearance_mode() {
  # Get the macOS interface style (light or dark)
  os_appearance=$(defaults read -g AppleInterfaceStyle 2>/dev/null)

  # Check if the interface style is not set or empty, it means light mode
  if [ -z "$os_appearance" ]; then
    os_appearance="light"
  fi

  echo $os_appearance
}

toggle_appearance_mode() {
  if [[ $(get_appearance_mode) == "light" ]]; then
    set_dark_mode
  else
    set_light_mode
  fi
}

if [ $# -eq 0 ]; then
  toggle_appearance_mode
else
  # Check the first argument passed to the script
  case "$1" in
      light)
          set_light_mode
          ;;
      dark)
          set_dark_mode
          ;;
      toggle)
          toggle_appearance_mode
          ;;
  esac
fi

exit 0