#!/bin/bash

cd MediaApp
flutter run -d linux --release &
MEDIAAPP_PID=$!

echo "Waiting for Media to start..."
while ! pgrep -f "flutter" > /dev/null; do
  sleep 1
done
echo "Media app is running with PID $MEDIAAPP_PID"
cd ../

./MediaServer/build/MediaServer &
MEDIASERVER_PID=$!

echo "MediaService running with PID $MEDIASERVER_PID"

trap "echo 'Stopping processes...'; kill $MEDIASERVER_PID $MEDIAAPP_PID; exit" SIGINT

# Wait for processes to finish
wait