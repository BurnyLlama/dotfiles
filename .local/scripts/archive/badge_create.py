#!/bin/env python3
import sys
import time

import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk
from gi.repository import GdkPixbuf
import sys
import os
import setproctitle

HEADING = sys.argv[2]
ICON = sys.argv[1]
CONTENT = sys.argv[3]
POSITION = 970

setproctitle.setproctitle('badge')

window = Gtk.Window(Gtk.WindowType.POPUP)
window.set_default_size(256, 82)
window.set_position(Gtk.WindowPosition.CENTER)
window.move(window.get_position()[0], POSITION)

badge = Gtk.Box(orientation=0)

logo_pixbuf = GdkPixbuf.Pixbuf.new_from_file_at_scale(ICON, 64, 64, True)
logo = Gtk.Image()
logo.set_from_pixbuf(logo_pixbuf)
logo.set_hexpand(False)

body = Gtk.Box(orientation=1)
        
header = Gtk.Label()
header.set_markup(f"<b><big><big>{HEADING}</big></big></b>")
header.set_justify(Gtk.Justification.LEFT)

content = Gtk.Label()
content.set_markup(f"<big>{CONTENT}</big>")

body.pack_start(header, True, True, 1)
body.pack_start(content, True, True, 1)

badge.pack_start(logo, False, True, 8)
badge.pack_start(body, True, True, 16)

window.add(badge)
window.show_all()
Gtk.main()
