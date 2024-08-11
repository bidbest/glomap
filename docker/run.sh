# docker pull colmap/colmap:latest
./build.sh
docker run --rm --gpus all -w /working -v $1:/working -it colmap:latest
