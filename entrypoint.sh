#!/usr/bin/env bash

set -eo pipefail

if [[ $VIDEO_URL ]]; then
	echo "VIDEO_URL:" $VIDEO_URL
else
	echo "VIDEO_URL missing"
	exit 1
fi

if [[ $FPS ]]; then
	echo "FPS:" $FPS
else
	echo "FPS missing"
	exit 1
fi

if [[ $MODE ]]; then
	echo "MODE:" $MODE
else
	echo "MODE missing"
	exit 1
fi

if [[ $ALIGN ]]; then
	echo "ALIGN :" $ALIGN
else
	echo "ALIGN missing"
	exit 1
fi

echo "Starting..."

curl -o video.mp4 $VIDEO_URL

ffmpeg -i video.mp4 -r $FPS -f image2 frame_%07d.png

if [ "$ALIGN" = true ] ; then
	align_image_stack -m -a aligned_ frame_*
	convert aligned_* -evaluate-sequence $MODE stacked.jpg
else
	convert frame_* -evaluate-sequence $MODE stacked.jpg
fi
