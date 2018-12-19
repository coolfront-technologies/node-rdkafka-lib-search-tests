# used with volume mount approach
# docker run -it --rm -v "$PWD:/project" mike-coolfront/librdkafka-no-lib-issue bash -c "./start.sh"

# used with copy at build time approach
docker run -it --rm mike-coolfront/librdkafka-no-lib-issue bash -c "./start.sh"
