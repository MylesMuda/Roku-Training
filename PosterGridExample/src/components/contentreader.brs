sub init()
      m.top.functionName = "getJsonContent"
end sub

sub getcontent()
      content = createObject("roSGNode", "ContentNode")

      contentxml = createObject("roXMLElement")

      ' readInternet = createObject("roUrlTransfer")
      ' readInternet.setUrl(m.top.contenturi)
      ' contentxml.parse(readInternet.GetToString())

      readLocal = createObject("roByteArray")
      ' readLocal.ReadFile("pkg:/images/rendergridps.xml")
      readLocal.ReadFile(m.top.contenturi)
      contentxml.parse(readLocal.ToAsciiString())

      if contentxml.getName()="Content"
        for each item in contentxml.GetNamedElements("item")
          itemcontent = content.createChild("ContentNode")
          itemcontent.setFields(item.getAttributes())
        end for
      end if

      m.top.content = content
end sub

sub getJsonContent()
      content = createObject("roSGNode", "ContentNode")

      readInternetJson = createObject("roUrlTransfer")
      readInternetJson.SetUrl("http://c4.arm.accedo.tv/develop/matt/feed.json")
      JsonResponse = ParseJson(readInternetJson.GetToString())

      For Each item in JsonResponse
          itemcontent = content.createChild("ContentNode")
          itemcontent.setFields(item)
          itemcontent.setfield("hdgridposterurl", item.image.href)
          itemcontent.setfield("shortdescriptionline1", item.title)
      End For

    m.top.content = content
end sub