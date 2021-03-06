#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

VAGRANT_CORE_FOLDER=$(cat '/.coffeecoco-stuff/vagrant-core-folder.txt')

EXEC_ONCE_DIR="$1"
EXEC_ALWAYS_DIR="$2"

echo "Running files in files/${EXEC_ONCE_DIR}"

if [ -d "/.coffeecoco-stuff/${EXEC_ONCE_DIR}-ran" ]; then
    rm -rf "/.coffeecoco-stuff/${EXEC_ONCE_DIR}-ran"
fi

if [ ! -f "/.coffeecoco-stuff/${EXEC_ONCE_DIR}-ran" ]; then
   sudo touch "/.coffeecoco-stuff/${EXEC_ONCE_DIR}-ran"
   echo "Created file /.coffeecoco-stuff/${EXEC_ONCE_DIR}-ran"
fi

find "${VAGRANT_CORE_FOLDER}/files/${EXEC_ONCE_DIR}" -maxdepth 1 -type f -name '*.sh' | sort | while read FILENAME; do
    SHA1=$(sha1sum "${FILENAME}")

    if ! grep -x -q "${SHA1}" "/.coffeecoco-stuff/${EXEC_ONCE_DIR}-ran"; then
        sudo /bin/bash -c "echo \"${SHA1}\" >> \"/.coffeecoco-stuff/${EXEC_ONCE_DIR}-ran\""

        chmod +x "${FILENAME}"
        /bin/bash "${FILENAME}"
    else
        echo "Skipping executing ${FILENAME} as contents have not changed"
    fi
done

echo "Finished running files in files/${EXEC_ONCE_DIR}"
echo "To run again, delete hashes you want rerun in /.coffeecoco-stuff/${EXEC_ONCE_DIR}-ran or the whole file to rerun all"

if [ -z ${EXEC_ALWAYS_DIR} ]; then
    exit 0
fi

echo "Running files in files/${EXEC_ALWAYS_DIR}"

find "${VAGRANT_CORE_FOLDER}/files/${EXEC_ALWAYS_DIR}" -maxdepth 1 -type f -name '*.sh' | sort | while read FILENAME; do
    chmod +x "${FILENAME}"
    /bin/bash "${FILENAME}"
done

echo "Finished running files in files/${EXEC_ALWAYS_DIR}"
