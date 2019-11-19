sub init()
    m.top.backgroundURI = "pkg:/images/mountains.jpg"

    m.top.setFocus(true)

    m.pindialog = m.top.findNode("PinDialogExample")
    m.postergrid = m.top.findNode("examplePosterGrid")
    m.Video = m.top.findNode("Video")

    m.pindialog = createObject("roSGNode", "PinDialogExample")
    m.pindialog.visible = true
    m.pindialog.setFocus(true)

    m.postergrid.translation = [ 130, 160 ]

    m.readPosterGridTask = createObject("roSGNode", "ContentReader")
    ' m.readPosterGridTask.contenturi = "http://www.sdktestinglab.com/Tutorial/content/rendergridps.xml"
    m.readPosterGridTask.contenturi = "pkg:/images/rendergridps.xml"
    m.readPosterGridTask.observeField("content", "showpostergrid")
    m.readPosterGridTask.control = "RUN"
    m.postergrid.observeField("itemSelected", "playContent")
end sub

sub showpostergrid()
    m.postergrid.content = m.readPosterGridTask.content
end sub

sub playContent()
    selected = m.postergrid.itemSelected
    selectedVideo = m.postergrid.content.getChild(selected)
    print selectedVideo.shortdescriptionline1
    m.Video.content = selectedVideo
    print m.Video.content.url
    m.Video.visible = "true"
    m.Video.control = "play"
    m.Video.setFocus(true)
end sub