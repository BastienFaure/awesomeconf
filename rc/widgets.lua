-- {{{ Wibox
-- Create a textclock widget
-- Network usage widget
-- Initialize widget, use widget({ type = "textbox" }) for awesome < 3.5

-- netwidget
netwidget = wibox.widget.textbox()

-- separator
separator = wibox.widget.textbox()
separator:set_text(" :: ")

-- clock
mytextclock = awful.widget.textclock()

-- memory
memwidget = awful.widget.progressbar()
memwidget:set_width(8)
memwidget:set_height(10)
memwidget:set_vertical(true)
memwidget:set_background_color("#494B4F")
memwidget:set_border_color(nil)
memwidget:set_color({
                        type = "linear",
                        from = {0,0},
                        to = { 10,0 },
                        stops = {
                                    {0, "#AECF96"},
                                    {0.5, "#88A175"},
                                    {1, "#FF5656"}
                        }
})

-- cpu
cpuwidget = awful.widget.graph()
cpuwidget:set_width(50)
cpuwidget:set_background_color("#494B4F")
cpuwidget:set_color({
                        type = "linear",
                        from = { 0, 0 },
                        to = { 10,0 },
                        stops = {
                                    {0, "#FF5656"},
                                    {0.5, "#88A175"},
                                    {1, "#AECF96" }
                        }
})

-- battery
batwidget = wibox.widget.textbox()

-- temp
tempwidget = wibox.widget.textbox()


-- Register widgets
vicious.register(netwidget, vicious.widgets.net, '<span color="#CC9393">${enp8s0 down_kb}</span> <span color="#7F9F7F">${enp8s0 up_kb}</span>', 3)
vicious.register(batwidget,vicious.widgets.bat, 'Power: <span color="#3232ff">$1 $2% $3</span>', 60, "BAT0")
vicious.register(tempwidget, vicious.widgets.thermal, "Temp: <span color='#d7e0ea'>$1°С</span>",37,"thermal_zone0")
vicious.register(memwidget, vicious.widgets.mem, "$1", 1)
vicious.register(cpuwidget, vicious.widgets.cpu, "$1", 1)

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mylauncher)
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    right_layout:add(netwidget)
    right_layout:add(separator)
    right_layout:add(batwidget)
    right_layout:add(separator)
    right_layout:add(tempwidget)
    right_layout:add(separator)
    right_layout:add(cpuwidget)
    right_layout:add(separator)
    right_layout:add(memwidget)
    right_layout:add(separator)
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    right_layout:add(mytextclock)
    right_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end
-- }}}
