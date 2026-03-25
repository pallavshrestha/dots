-- Example config for Swayimg

-- The viewer searches for the config file in the following locations:
-- 1. $XDG_CONFIG_HOME/swayimg/init.lua
-- 2. $HOME/.config/swayimg/init.lua
-- 3. $XDG_CONFIG_DIRS/swayimg/init.lua
-- 4. /etc/xdg/swayimg/init.lua

-- set order by file size for the image list
swayimg.imagelist.set_order("numeric")

swayimg.imagelist.enable_adjacent(true)
swayimg.viewer.enable_loop(true)

-- text
swayimg.text.set_size(14)
swayimg.text.set_foreground(0xd9dee9ff)
swayimg.text.set_background(0000000000)
swayimg.text.set_shadow(0000000000)

swayimg.text.set_font('Iosevka Nerd Font')

swayimg.text.set_timeout(5)
swayimg.text.set_status_timeout(3)
-- swayimg.text.set_status(status)


swayimg.viewer.set_window_background(0xee2e3440)

swayimg.slideshow.set_default_scale("optimal")
swayimg.viewer.set_default_scale("fit")

-- set top left text block scheme for viewer mode
swayimg.viewer.set_text("topleft", {
  "File: {name}",
  "Format: {format}",
  "File size: {sizehr}",
  "File time: {time}",
  "EXIF date: {meta.Exif.Photo.DateTimeOriginal}",
  "EXIF camera: {meta.Exif.Image.Model}"
})

swayimg.slideshow.set_text("bottomright", {
    "{dir}"
})

swayimg.gallery.set_text("bottomright", {
  "{name}",
})

swayimg.text.hide()

-- bind the left arrow key to move the image to the left by 1/10 of the application window size
swayimg.viewer.on_key("Left", function()
  local wnd = swayimg.get_window_size()
  local pos = swayimg.viewer.get_position()
  swayimg.viewer.set_abs_position(math.floor(pos.x - wnd.width / 10), pos.y);
end)

-- bind mouse vertical scroll button with pressed Ctrl to zoom in the image at mouse pointer coordinates
swayimg.viewer.on_mouse("Ctrl-ScrollUp", function()
  local pos = swayimg.get_mouse_pos()
  local scale = swayimg.viewer.get_scale()
  scale = scale + scale / 10
  swayimg.viewer.set_abs_scale(scale, pos.x, pos.y);
end)

-- bind the Delete key in slide show mode to delete the current file and display a status message
swayimg.slideshow.on_key("Shift-Delete", function()
  local image = swayimg.slideshow.get_image()
  os.remove(image.path)
  swayimg.text.set_status("File "..image.path.." removed")
end)

-- set a custom window title in gallery mode
swayimg.gallery.on_image_change(function()
  local image = swayimg.gallery.get_image()
  swayimg.set_title("Gallery: "..image.path)
end)

-- print paths to all marked files by pressing Ctrl-p in gallery mode
swayimg.gallery.on_key("Ctrl-p", function()
  local entries = swayimg.imagelist.get()
  for _, entry in ipairs(entries) do
    if entry.mark then
        print(entry.path)
    end
  end
end)


swayimg.viewer.on_key("q", swayimg.exit )
swayimg.slideshow.on_key("q", swayimg.exit )
swayimg.gallery.on_key("q", swayimg.exit )

swayimg.viewer.on_key("k",  function() swayimg.viewer.set_fix_scale("keep") end)
swayimg.viewer.on_key("r", function() swayimg.viewer.set_fix_scale("fit") end)
swayimg.viewer.on_key("g", function() swayimg.viewer.set_fix_scale("fill") end)
