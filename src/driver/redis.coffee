createClient = require('redis').createClient

port = process.env.REDIS_PORT_6379_TCP_PORT or 6379
host = process.env.REDIS_PORT_6379_TCP_ADDR or 'redis'
pass = process.env.REDIS_PORT_6379_TCP_PASS or null

module.exports = createClient port, host, auth_pass: pass

