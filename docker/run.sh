# docker pull colmap/colmap:latest
./build.sh
docker run --rm \
	-e QT_XCB_GL_INTEGRATION=xcb_egl \
    -e DISPLAY=:0 \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -w /working \
    -v $1:/working \
    --gpus all \
    --privileged \
    -it colmap:latest
