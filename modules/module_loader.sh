#!/bin/bash


# This loop loads modules from the modules directory.
for module in $(ls -d modules/*); do
	# echo ${module}
	if [ -d ${module} ]; then
		pushd ${module}
		source *
		popd
	fi
done

