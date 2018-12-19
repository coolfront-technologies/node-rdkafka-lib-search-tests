# node-rdkafka lib search tests

## Purpose
The purpose of this project is to share a solution used to test for unexpected results when node-rdkafka searches for librdkafka.so.1 on an ubuntu 18 system.

## Implementation Overview
To accomplish this for multple versions of node-rdkafka and in an attempt to reduce steps we are using docker to supply the controlled ubuntu images and mocha to report on behavior expectations. Mocha will run the cli commands to dump the search paths used and then analyse the text output. Its not a perfect solution, but should hit on 2 goals which are to show lib search issues if present and share an approach to test such things which are dependant on os/machine setup specifics.

We'll be producing 2 isolated ubuntu environments. One to represent a system which does not have librdkafak.so.1 present already and another which does. For the latter, the system will have the tool kafkacat preinstalled.

 ```
  #example of raw cli command to list library search paths used
  LD_DEBUG=libs ldd /project/test-2.4.2/node_modules/node-rdkafka/build/Release/node-librdkafka.node
 ```

## Getting started

1. install docker community edition
* [for ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
* [for windows](https://docs.docker.com/docker-for-windows/install/)

2. clone this project
3. run build (only needed initially if only running tests)
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
1. What does build.bat/sh do?
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
2. What does test-no-lib-issue.bat/sh and test-wrong-lib-issue.bat/sh do?
   * When either is run the following process is performed
     1. a temporary docker container is launched with the desired starting environment
     2. start.sh is run within the docker container from either test-no-lib-issue or test-wrong-lib-issue
        1. First start.sh will remove the node_modules folder if present.
           * Note: This is needed to ensure a clean build of node-rdkafka for each version when using the VOLUME mount approach     mentioned in the Extras section.
        2. Then it builds the node modules for test area
        3. Then it runs the tests in each test area

# Troubleshooting project
1. if you run a non-windows host system and run into permission denied issues with the shell scripts then you can perform the following:
   ```
   > chmod 744 *.sh
   > ./build.sh
   ```

2. if a temp container is some how still running you can perform the following:
   * list your running docker containers
   * then call docker stop using your the a part or all of the offending containr's ID
   ```
   > docker ps

    | CONTAINER ID | IMAGE                                     | ... |
    |--------------|-------------------------------------------|-----|
    | 7DC34236E9D1 | mike-coolfront/librdkafka-wrong-lib-issue | ... |
    | ...          | ...                                       | ... |

   > docker stop 7DC3
   ```

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