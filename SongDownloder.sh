#!/bin/bash

gum style --border rounded --margin "3" --align="center" --padding "2 2" --border-foreground 57 "$(gum style --foreground 85 'Song Downloader')"

SONGNAME="Song Name"; URL="URL"
ACTIONS=$(gum choose --cursor.foreground="85" --item.foreground 57 "$URL" "$SONGNAME")

if [ "$URL" == "$ACTIONS" ]
then
	URLINP=$(gum input --prompt.foreground="57" --cursor.foreground="85" --placeholder "Paste the link of your song")
	youtube-dl -f bestaudio $URLINP --quiet --extract-audio --audio-format mp3 & pid=$!
	while ps -p $pid &>/dev/null; do
		gum spin --spinner.foreground="57" --title.foreground="85" --title  "Fetching Song from the URl..." -- sleep 3
	done
	echo -e "Aight ! the download is over, $(gum style --foreground 57 "VIBE TIME")."
else
	SONGINP=$(gum input --prompt.foreground="57" --cursor.foreground="85" --placeholder "What song are you looking for ?")
	SONGINP_NOSPACE="$(echo -e "${SONGINP}" | tr -d '[:space:]')"
	QUERY=$(curl -s https://www.googleapis.com/youtube/v3/search\?part\=snippet\&q\=$SONGINP_NOSPACE\&type\=video\&maxResults\=1\&key\=$YT_API_KEY | jq -r '.items[] | "\(.snippet.channelTitle) => \(.snippet.title) \(.id.videoId)"')
	youtube-dl -f bestaudio https://www.youtube.com/watch?v=${QUERY:(-11)} --quiet --extract-audio --audio-format mp3 & pid=$!
	while ps -p $pid &>/dev/null; do
		gum spin --spinner.foreground="57" --title.foreground="85" --title  "Fetching Song from the URl..." -- sleep 3
	done
	echo -e "Aight ! the download is over, $(gum style --foreground 57 "VIBE TIME")."
fi


