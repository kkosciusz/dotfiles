-- figure out environment in which we are running
Env = {}
Env.is_connected_via_mosh = os.getenv("NCURSES_NO_UTF8_ACS") == "1"
Env.is_os_windows = vim.fn.has('win32')
