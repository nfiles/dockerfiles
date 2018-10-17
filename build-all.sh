#! /bin/bash

set -e

if [ -z "$REGISTRY_USERNAME" ] || [ -z "$REGISTRY_PASSWORD" ] || [ -z "$REGISTRY_URL" ]; then
	echo "Must provide dockerhub credentials and url" 1>&2
	exit 1
fi

echo "$REGISTRY_PASSWORD" | docker login \
	--username "$REGISTRY_USERNAME" \
	--password-stdin \
	"$REGISTRY_URL" \
	|| exit $?

build_and_push() {
	dir=${1%/}

	if [ ! -d $dir ]; then
		return 0
	fi

	date="$(date +%Y%m%d)"
	image_name=$REGISTRY_URL/$REGISTRY_USERNAME/$dir

	echo image_name: $image_name

	docker build \
		--rm --force-rm \
		-t $image_name:latest \
		-t $image_name:$date \
		-f $dir/Dockerfile \
		$dir
	docker push $REGISTRY_USERNAME/$dir
}
export -f build_and_push

DIRS=$(ls -d */)
parallel -j4 --ungroup --verbose build_and_push {} ::: $DIRS

echo done!
