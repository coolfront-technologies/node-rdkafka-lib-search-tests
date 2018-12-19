#!/bin/bash
#clean house to ensure expected start point
rm -rdf ./test-2.4.2/node_modules
rm -rdf ./test-2.5.0/node_modules
rm -rdf ./test-2.5.1/node_modules

#rebuild
cd /project/test-2.4.2
npm install
cd /project/test-2.5.0
npm install
cd /project/test-2.5.1
npm install

#run test for each version
cd /project/test-2.4.2
npm test

cd /project/test-2.5.0
npm test

cd /project/test-2.5.1
npm test




