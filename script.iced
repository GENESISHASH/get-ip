_ = require('wegweg')({globals:on,shelljs:on})

INTERVAL_DELAY_SECS = 30
HTTP_ENDPOINT = "https://checkip.amazonaws.com/"

perform = false

if !_.exists(file_time = __dirname + '/.last-time')
  _.writes(file_time,_.time().toString())
  last_time = 0
else
  last_time = +(_.reads file_time)

if !_.exists(file_ip = __dirname + '/.last-ip')
  _.writes(file_ip,'0.0.0.0')
  last_ip = '0.0.0.0'
else
  last_ip = _.reads(file_ip).trim()

if _.time() - last_time >= INTERVAL_DELAY_SECS
  perform = true

if perform
  await _.get HTTP_ENDPOINT, defer e,r,ip_addr
  if e then throw e

  if _.type(ip_addr) isnt 'string'
  	ip_addr = ip_addr.toString()

  if ip_addr
  	ip_addr = ip_addr.trim()
  	_.writes(file_time,_.time())
  	_.writes(file_ip,ip_addr.trim())
else
  ip_addr = last_ip

log ip_addr
exit 0

