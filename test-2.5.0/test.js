const childProcess = require('child_process')
const assert = require('assert')

describe("2.5.0 - librdkafka.so.1 search paths - ", function(){
  it("can find librdkafka.so.1 with expected path", function(){
    var libSearchOutput = childProcess.execSync("LD_DEBUG=libs ldd "+__dirname+"/node_modules/node-rdkafka/build/Release/node-librdkafka.node 2>&1").toString()

    var allMentionsOfLib = libSearchOutput.match(/.*librdkafka.so.1.*/gm)
    var list = JSON.stringify(allMentionsOfLib, null, 2)
    assert( ! libSearchOutput.toString().match(/.*librdkafka\.so\.1 => not found.*/), "librdkafka.so.1 not found. \nAll mentions of lib in search: "+ list )
    assert(libSearchOutput.toString().match(/.*deps\/librdkafka\.so\.1/), "not using librdkafka.so.1 from node-rdkafka's deps directory. \nAll mentions of lib in search: "+ list )

  })
})


