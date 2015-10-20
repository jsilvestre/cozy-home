ObjectPicker = require 'views/object_picker'

module.exports = class IntentManager


    registerIframe : (iframe, remoteOrigin)->
        talker = new Talker(iframe.contentWindow, remoteOrigin)
        talker.onMessage = @handleIntent


    handleIntent : (message) ->
        intent = message.data
        params = intent.params
        switch intent.type

            when 'goto'
                if params.target == '_blank'
                    window.open "#apps/#{params.appUrl}", '_blank'
                else
                    window.app.routers.main.navigate "apps/#{params.appUrl}", true

            when 'pickObject'
                switch intent.params.objectType
                    when 'singlePhoto'
                        if intent.params.isCropped
                            new ObjectPicker(intent.params , \
                              (newPhotoChosen, dataUrl) ->
                                message.respond(
                                    newPhotoChosen :newPhotoChosen
                                    dataUrl        :dataUrl
                                )
                            )
                        else
                            new ObjectPicker(intent.params , \
                              (newPhotoChosen, dataUrl) ->
                                message.respond(
                                    newPhotoChosen :newPhotoChosen
                                    dataUrl        :dataUrl
                                )
                            )
            # usefull to check from the client (app) that the home is there and
            # has the intent manager available
            when 'ping'
                message.respond('pong')



