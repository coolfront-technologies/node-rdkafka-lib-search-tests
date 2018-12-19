# node-rdkafka lib search tests

## Purpose
The purpose of this project is to share a solution used to test for unexpected results when node-rdkafka searches for a library on an ubuntu 18 system.

## Concept
Using controlled ubuntu systems via docker and isolated  node-rdkafka versions we then check how the generated binaries search for librdkafka.so.1

 ```
  #example of raw cli command to list library search paths used
  LD_DEBUG=libs ldd /project/test-2.4.2/node_modules/node-rdkafka/build/Release/node-librdkafka.node
```
## Implementation Overview
To accomplish this for multple versions of node-rdkafka and in an attempt to reduce steps we are using docker for the controlled ubuntu images and mocha to report on behavior expectations. Its not a perfect solution, but should hit on 2 goals which are to show lib search issues if present and share an approach to test such things which are dependant on os/machine setup specifics.

We'll be producting 2 isolated ubuntu environments. One to represent a system which does not have librdkafak.so.1 present already and another which does. For this effect the system will have the tool kafkacat preinstalled.

## Getting started

1. install docker community edition
* [for ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
* [for windows](https://docs.docker.com/docker-for-windows/install/)

2. clone this project
3. run build:
   *  windows:
      * build.bat
   *  linux:
      * build.sh
4. run tests
   * windows:
     * test-no-lib-issue.bat
     * test-wrong-lib-issue.bat
   * linux:
     * test-no-lib-issue.sh
     * test-wrong-lib-issue.sh

## Under the hood
1. build.bat/sh
   * builds 2 images:
     * mike-coolfront/librdkafka-no-lib-issue
     * mike-coolfront/librdkafka-wrong-lib-issue

   * first it will ensure the images don't exist.
   * Then build the images.
     * when built a copy of the project is placed at /project with in the docker images.
     * the project folder contains isolated test areas for each targeted node-rdkafka version
       * test-2.4.2
       * test-2.5.0
       * test-2.5.1
2. test flow
   * When either test-no-lib-issue or test-wrong-lib-issue is run the following process is performed
     1. a docker container is launch with the desired starting environment
     2. start.sh is run within the docker container
        1. each test area has its node_modules folder removed. Note: This is needed to ensure a clean build of node-rdkafka for each version.
        2. each test area has its modules installed/built
        3. each test area runs its test


## Extras
* to use a mounted volume for the project files
  * update ub18Clean
    * change
      * ```COPY ./ /project```
      * to
      * ```VOLUME /project```

  * run ```build.bat/sh```
* to test search paths used for a different binary such as librdkafka++.so
  ```
  LD_DEBUG=libs ldd /project/test-2.4.2/node_modules/node-rdkafka/build/deps/librdkafka++.so
  ```