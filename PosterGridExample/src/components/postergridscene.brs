sub init()
    m.top.backgroundURI = "pkg:/images/mountains.jpg"

    m.top.setFocus(true)

    m.postergrid = m.top.findNode("examplePosterGrid")

    m.postergrid.translation = [ 130, 160 ]

    m.readPosterGridTask = createObject("roSGNode", "ContentReader")
    ' m.readPosterGridTask.contenturi = "http://www.sdktestinglab.com/Tutorial/content/rendergridps.xml"
    m.readPosterGridTask.contenturi = "pkg:/images/rendergridps.xml"
    m.readPosterGridTask.observeField("content", "showpostergrid")
    m.readPosterGridTask.control = "RUN"
end sub

sub showpostergrid()
    m.postergrid.content = m.readPosterGridTask.content
end sub