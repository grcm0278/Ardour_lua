ardour {
	["type"] = "EditorAction",
	name = "Prepare recording for reharshal take",
	author = "Bakan",
	description = [[
Prepares the Ardour session for recording in reharhal room (creation stage).

* Clears all markers.
* Erases the last capture (assuming that it was a failed one)
* Rewinds the session to starting point.
* Recenables the session.
]]
}

function factory (unused) return function()
	if Session:actively_recording() then
		return end

	for l in Session:locations():list():iter() do
		if l:is_mark() then
			Session:locations():remove(l)
		end
	end

	Session:goto_start()
	Editor:remove_last_capture()
	Session:maybe_enable_record()

end end

function icon (params) return function (ctx, width, height)
	local x = width * .5
	local y = height * .5
	local r = math.min (x, y) * .67

	ctx:arc (x, y, r, 0, 2 * math.pi)
	ctx:set_source_rgba (.9, .4, .4, 1)
	ctx:fill_preserve ()
	ctx:set_source_rgba (0, 0, 0, 1)
	ctx:set_line_width (1)
	ctx:stroke ()

	local txt = Cairo.PangoLayout (ctx, "ArdourMono ".. math.ceil(r * 1.7) .. "px")
	txt:set_text ("P")
	local tw, th = txt:get_pixel_size ()
	ctx:set_source_rgba (0, 0, 0, 1.0)
	ctx:move_to (.5 * (width - tw), .5 * (height - th))
	txt:show_in_cairo_context (ctx)
end end
