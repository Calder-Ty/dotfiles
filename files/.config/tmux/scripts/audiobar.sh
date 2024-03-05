#!/usr/bin/env bash

if [[ -z $PLAYERCTL_CMD ]]; then
	PLAYERCTL_CMD='playerctl'
fi

volume() {

	if [[ -z $(which pactl) ]]; then
		return 1;
	fi

	printf "󰕾 %s" "$(pactl list sinks | cut -b 2- | grep ^Volume | cut -d":" -f3 | cut -d"/" -f2 | tr -d " ")"
}

title() {

	title=$($PLAYERCTL_CMD metadata title)
	if [[ -n $title ]]; then
		printf "♬ %s" "$title"
	fi

}

artist() {
	artist=$($PLAYERCTL_CMD metadata artist)
	if [[ -n $artist ]]; then
		printf "~%s" "$artist"
	fi

}

main() {
	if [[ -z $(which $PLAYERCTL_CMD) ]]; then
		return 1;
	fi

	cmd=$1;
	if [ -z $cmd ]; then
		echo "Usage: $(basename $0) [volume|title|artist]"
		return 1
	fi

	if [ $cmd == "volume" ]; then
		volume;
	elif [ $cmd == "title" ]; then
		title;
	elif [ $cmd == "artist" ]; then
		artist;
	fi

}

main "$@"
