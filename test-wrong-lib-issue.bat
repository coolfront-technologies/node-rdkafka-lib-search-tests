REM used with volume mount approach
REM docker run -it --rm -v "%cd%:/project" mike-coolfront/librdkafka-wrong-lib-issue bash -c "./start.sh"

REM used with copy at build time approach
docker run -it --rm mike-coolfront/librdkafka-wrong-lib-issue bash -c "./start.sh"
