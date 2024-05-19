int main (string[] args) {
	Gtk.init (ref args);
	Gtk.Window window = new Gtk.Window (Gtk.WindowType.POPUP);

	window.title = "badge";
	window.window_position = Gtk.WindowPosition.CENTER;
	window.set_default_size (256, 82);
	window.destroy.connect (Gtk.main_quit);
	var pos_x = 1; var pos_y = 1; var pos = int.parse(args[4]);
	window.get_position (out pos_x, out pos_y);
	window.move (pos_x, pos);

	Gtk.Box badge = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);

	Gdk.Pixbuf icon_buf = new Gdk.Pixbuf.from_file_at_scale (args[1], 64, 64, true);
	Gtk.Image icon = new Gtk.Image ();
	icon.set_from_pixbuf (icon_buf);
	icon.set_hexpand (false);

	Gtk.Box body = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);

	Gtk.Label header = new Gtk.Label (null);
	header.set_markup ("<b><big><big>" + args[2] + "</big></big></b>");
	header.set_yalign (1);

	Gtk.Label content = new Gtk.Label(null);
	content.set_markup ("<big>" + args[3] + "</big>");
	content.set_yalign (0);

	body.pack_start (header, true, true, 2);
	body.pack_start (content, true, true, 2);

	badge.pack_start (icon, false, true, 8);
	badge.pack_start (body, true, true, 16);

	window.add (badge);
	window.show_all ();
	Gtk.main ();
	return 0;
}
