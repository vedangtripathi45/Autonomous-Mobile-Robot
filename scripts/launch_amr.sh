#!/bin/bash

echo "--- AMR Launch Sequence ---"

FIX_CMD='F=$(find /usr/lib -name "libGraphicsMagick++-Q16.so.12*" | head -n 1) && ln -sf $F /usr/lib/libGraphicsMagick++.so.12 && ln -sf $F /usr/lib/aarch64-linux-gnu/libGraphicsMagick++.so.12 && ldconfig'

# 1. Agar container 'bot' pehle se chal raha hai, toh seedha andar ghuso
if [ "$(sudo docker ps -q -f name=bot)" ]; then
    echo "AMR Container 'bot' is already running. Entering terminal..."
    sudo docker exec bot bash -c "$FIX_CMD"
    sudo docker exec -it bot bash
    exit
fi

# 2. Agar container 'bot' ruka hua (stopped) hai, toh start karke andar jao
if [ "$(sudo docker ps -aq -f name=bot)" ]; then
    echo "Starting stopped AMR container 'bot'..."
    sudo docker start bot
    sudo docker exec bot bash -c "$FIX_CMD"
    sudo docker exec -it bot bash
    exit
fi

# 3. Agar container hai hi nahi, toh teri nayi image se fresh create karo
echo "Creating NEW AMR container from image 'vedang_amr'..."
sudo docker run -it \
--name bot \
--network host \
--runtime nvidia \
--privileged \
-v /dev:/dev \
-v ~/ros2_ws:/ros2_ws \
vedang_amr bash -c "$FIX_CMD && exec bash"
