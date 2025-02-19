#!/bin/bash

# Change to the Source Directory
cd $SYNC_PATH

# Set-up ccache
if [ -z "$CCACHE_SIZE" ]; then
    ccache -M 50G
else
    ccache -M ${CCACHE_SIZE}
fi

# Run the Extra Co

# Prepare the Build Environment
source build/envsetup.sh

# lunch the target
lunch ${LUNCH_COMBO} || { echo "ERROR: Failed to lunch the target!" && exit 1; }

# Build the Code
if [ -z "$J_VAL" ]; then
    make -j$(nproc --all) $TARGET || { echo "ERROR: Build Failed!" && exit 1; }
elif [ "$J_VAL"="0" ]; then
    make $TARGET || { echo "ERROR: Build Failed!" && exit 1; }
else
    make -j${J_VAL} $TARGET || { echo "ERROR: Build Failed!" && exit 1; }
fi

# Exit
exit 0
