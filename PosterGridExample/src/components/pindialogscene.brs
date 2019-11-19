sub init()
      'm.top.backgroundURI = "pkg:/images/mountains.jpg"

      example = m.top.findNode("instructLabel")

      examplerect = example.boundingRect()
      centerx = (1280 - examplerect.width) / 2
      centery = (720 - examplerect.height) / 2
      example.translation = [ centerx, centery ]

      m.top.setFocus(true)
end sub

sub showdialog()
      pindialog = createObject("roSGNode", "PinDialog")
      pindialog.backgroundUri = "pkg:/images/rsgde_dlg_bg_hd.9.png"
      'm.top.backgroundUri = "pkg:/images/rde_splash_fhd.jpg"
      pindialog.title = "Please set a Parental Pin"
      pindialog.buttons = ["OK", "Cancel"]
      m.top.dialog = pindialog
      
      m.top.dialog.observeField("buttonSelected", "pinSet")
end sub

sub pinSet()
    selected = m.top.dialog.buttonSelected
    'dim selected[] = dialog.buttonSelected
    if (selected = 0)
       ' set parentalPin to pindialog.pin
        dialog = createObject("roSGNode", "Dialog")
        dialog.backgroundUri = "pkg:/images/rsgde_dlg_bg_hd.9.png"
        dialog.title = "Your pin is:"
        dialog.optionsDialog = true
        dialog.message = m.top.dialog.pin
        m.top.dialog = dialog

      '   screen = CreateObject("roSGScreen")
      '   scene = screen.CreateScene("PosterGridExample")
      ' m.top.scene.createChild(screen.CreateScene("PosterGridExample"))
      ' BEFORE/AFTER THE MESSAGE HAS BEEN SHOWN, THE POSTERGRID SHOULD BE LOADED
    else
        ' showDialog()
        showDialog()
    end if
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
      if press then
        if key = "OK"

          showdialog()

          return true
        end if
      end if

      return false
end function