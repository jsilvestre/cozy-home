cozydb = require 'cozydb'

module.exports = CozyInstance = cozydb.getModel 'CozyInstance',
    domain: String
    locale: String
    helpUrl: String
    background: String
    connectedOnce: Boolean

CozyInstance.first = (callback) ->
    CozyInstance.request 'all', (err, instances) ->
        if err then callback err
        else if not instances or instances.length is 0 then callback null, null
        else  callback null, instances[0]

CozyInstance.getLocale = (callback) ->
    CozyInstance.first (err, instance) ->
        callback err, instance?.locale or null

CozyInstance.all = (callback) ->
    CozyInstance.request 'all', callback

CozyInstance.destroyAll = (callback) ->
    CozyInstance.requestDestroy 'all', callback
