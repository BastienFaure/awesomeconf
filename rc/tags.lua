-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {
    names = { 1, 2, 3, 4, 5, 6, 7, "mail", "social" ,"skype", "jabber" },
    layout = { layouts[2], layouts[2], layouts[2], layouts[2], layouts[2], layouts[2], layouts[2], layouts[2], layouts[2], layouts[2], layouts[2], layouts[2] }
}

for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6, 7, "mail", "social", "skype", "jabber" }, s, tags.layout)
end
-- }}}
