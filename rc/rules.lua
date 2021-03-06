-- {{{ Rules
if screen.count() > 1 then
    auxiliary_screen = 2
else
    auxiliary_screen = 1
end

awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    { rule = { class = "Gajim" },
      properties = { tag = tags[1][11] } },
    { rule = { class = "Icedove" },
      properties = { tag = tags[1][8] } },
    { rule = { class = "Thunderbird" },
      properties = { tag = tags[1][8] } },
    { rule = { class = "Skype" },
      properties = { tag = tags[1][10] } },
    { rule = { class = "Pidgin" },
      properties = { tag = tags[1][9] } },
    { rule = { class = "irssi" },
      properties = { tag = tags[1][9] } },
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --  properties = { tag = tags[1][2] } },
}
-- }}}
