mailbox = require './pop3'
_       = require 'lodash'

module.exports =
  'check mail': (args) ->
    msgPromise = mailbox.getMessages args.host, args.port, args.username, args.password
    msgPromise.then (messageData) ->
      for key, val of _.omit(args, ['host', 'port', 'username', 'password'])
        console.log val
        expect(messageData).toMatch(val)
    .catch (error) ->
      console.log error
  'delete mail': (args) ->
    delPromise = mailbox.deleteAllMessages args.host, args.port, args.username, args.password
    delPromise.then () ->
      console.log "All messages deleted"
    .catch () ->
      console.log "Error occured while deleting messages"
