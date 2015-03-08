assert = require 'assert'

Docker = require '../../src/Docker'
docker = null

describe 'Constructor', ->
  it 'should instanciate correctly', ->
    docker = new Docker socket: '/var/run/docker.sock'
    assert docker instanceof Docker

  it 'should throw error for missing socket path option'

describe '#getContainers', ->
  it 'should get running containers', (done) ->
    @timeout 10000
    docker.getContainers (err, body) ->
      #console.log body
      done()

describe '#getStats', ->
  it 'should return stats for container', (done) ->
    @timeout 20000
    docker.container('hipache_www_1').getStats (err, data) ->
      assert.ifError err
      assert.deepEqual Object.keys(data), [
        'read', 'network', 'cpu_stats', 'memory_stats', 'blkio_stats'
      ]

      done()

