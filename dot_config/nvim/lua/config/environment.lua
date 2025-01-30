-- figure out environment in which we are running
Env = {}
Env.is_connected_via_mosh = os.getenv("NCURSES_NO_UTF8_ACS") == "1"
