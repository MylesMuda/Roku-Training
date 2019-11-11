sub init()
    print "MainScene loaded into view"
end sub

sub onDeeplink(message as Object)
    deeplink = message.getData()
    print "Deeplinking to -> " deeplink
end sub