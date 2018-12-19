rm -rdf ./test-2.4.2/node_modules
rm -rdf ./test-2.5.0/node_modules
rm -rdf ./test-2.5.1/node_modules

cd /project/test-2.4.2
npm install
cd /project/test-2.5.0
npm install
cd /project/test-2.5.1
npm install


cd /project/test-2.4.2
npm test

cd /project/test-2.5.0
npm test

cd /project/test-2.5.1
npm test




