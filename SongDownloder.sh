#!/bin/bash

gum style --border rounded --margin "3" --align="center" --padding "2 2" --border-foreground 57 "$(gum style --foreground 85 'Song Downloader')"

SONGNAME="Song Name"; URL="URL"
ACTIONS=$(gum choose --cursor.foreground="85" --item.foreground 57 "$URL" "$SONGNAME")

if [ "$URL" <<< "$ACTIONS" ]; then
  URLINP=$(gum input --prompt.foreground="57" --cursor.foreground="85" --placeholder "Paste the link of your song")
  youtube-dl -f bestaudio $URLINP --quiet --extract-audio --audio-format mp3 & pid=$!
  while ps -p $pid &>/dev/null; do
    gum spin --spinner.foreground="57" --title.foreground="85" --title  "Fetching Song from the URl..." -- sleep 3
done
  echo -e "Aight ! the download is over, $(gum style --foreground 57 "VIBE TIME")."
  else


fi


