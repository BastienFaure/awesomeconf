-- os.execute("command -v xcompmgr >/dev/null 2>&1 && xcompmgr -cf &")
os.execute("command -v dropbox >/dev/null 2>&1 && dropbox start")
os.execute("command -v thunderbird >/dev/null 2>&1 && thunderbird &")
os.execute("command -v solaar >/dev/null 2>&1 && solaar &")
os.execute("command -v xautolock && xautolock -time 1 -locker slock &")
os.execute("pkill -9 nm-applet;dbus-launch nm-applet &")
