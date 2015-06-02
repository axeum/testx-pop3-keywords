POP3client  = require 'poplib'
q           = require 'q'

allMsgData = ""

exports.getMessages = (host, port, username, password) ->

  deferred = q.defer()

  client = new POP3client port, host,
    tlserrs: false
    enabletls: false
    debug: true

  i=1

  client.on 'connect', ->
    console.log 'CONNECT success'
    client.login username, password
    return
  client.on 'login', (status, rawdata) ->
    if status
      console.log 'LOGIN success'
      client.list()
    else
      console.log 'LOGIN failed'
      console.log "ERROR is #{rawdata}"
      client.quit()
      deferred.reject()
    return
  client.on 'list', (status, msgnumber, data, rawdata) ->
    if status
      console.log 'LIST success'
      if i <= msgnumber
        client.retr(i)
      else
        client.quit()
        deferred.resolve allMsgData
    else
      console.log 'LIST failed'
      console.log "ERROR is #{rawdata}"
    return
  client.on 'retr', (status, msgnumber, data, rawdata) ->
    if status
      console.log 'RETR success'
      allMsgData += "\n #{data}"
      i++
      client.list()
    else
      console.log 'RETR failed'
      console.log "ERROR is #{rawdata}"
      client.quit()
      deferred.reject()
    return

  deferred.promise

exports.deleteAllMessages = (host, port, username, password) ->

  deferred = q.defer()

  client = new POP3client port, host,
    tlserrs: false
    enabletls: false
    debug: true

  i=1

  client.on 'connect', ->
    console.log 'CONNECT success'
    client.login username, password
    return
  client.on 'login', (status, rawdata) ->
    if status
      console.log 'LOGIN success'
      client.list()
    else
      console.log 'LOGIN failed'
      console.log "ERROR is #{rawdata}"
      client.quit()
      deferred.reject()
    return
  client.on 'list', (status, msgnumber, data, rawdata) ->
    if status
      console.log 'LIST success'
      if msgnumber
        console.log "Deleting message #{i}"
        client.dele(msgnumber)
      else
        client.quit()
        deferred.resolve()
    else
      console.log 'LIST failed'
      console.log "ERROR is #{rawdata}"
      client.quit()
      deferred.reject()
    return
  client.on 'dele', (status, msgnumber, data, rawdata) ->
    if status
      console.log 'DELE success'
      i++
      client.list()
    else
      console.log 'DELE failed'
      console.log "ERROR is #{rawdata}"
      client.quit()
      deferred.reject()
    return

  deferred.promise
