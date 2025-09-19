ardour {
    ["type"]    = "EditorAction",
    name        = "Export active regions",
    license     = "MIT",
    author      = "Bakan",
    description = "Select all regions, set end to regions"
}

function factory () return function ()

    Editor:access_action("Editor","select-all-objects")
    Editor:access_action("Editor","set-session-from-edit-range")
    Editor:access_action("Main","ExportAudio")

end end

function icon (params) return function (ctx, width, height)
	local x = width * .5
	local y = height * .5
	local r = math.min (x, y) * .65

	ctx:arc (x, y, r, 0, 2 * math.pi)
	ctx:set_source_rgba (0, 0, .9, 1)
	ctx:fill_preserve ()
	ctx:set_source_rgba (1, 1, 1, .8)
	ctx:set_line_width (1)
	ctx:stroke ()

	local txt = Cairo.PangoLayout (ctx, "ArdourMono ".. math.ceil(r * 1.7) .. "px")
	txt:set_text ("E")
	local tw, th = txt:get_pixel_size ()
	ctx:set_source_rgba (1, 1, 1, .8)
	ctx:move_to (.5 * (width - tw), .5 * (height - th))
	txt:show_in_cairo_context (ctx)
end end
