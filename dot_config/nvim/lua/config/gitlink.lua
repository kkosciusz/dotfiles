-- Generate web links for browsing code in git repositories.
--
-- Suggested keymaps:
-- vim.keymap.set("n", "<space>gl", "<cmd>GitLink<CR>")
-- vim.keymap.set("v", "<space>gl", ":GitLink<CR>")

local M = {}

M.config = {
  -- Ordered list of patterns matched against the origin remote URL.
  -- type: "github" | "gitiles" | function(host, project, ref, path, line_from, line_to) -> string
  patterns = {
    { match = "github%.com", type = "github" },
    { match = "%gerrit.corp.arista.io", type = "gitiles" },
  },
  -- "origin_head" | "branch" | "sha"
  default_ref = "origin_head",
}

function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})
end

local function git_exec(cmd)
  local result = vim.fn.system(cmd)
  if vim.v.shell_error ~= 0 then
    return nil, result
  end
  return result:gsub("%s+$", "")
end

local function get_git_info()
  local root, err = git_exec("git rev-parse --show-toplevel")
  if not root then
    vim.notify("Not in a git repository: " .. (err or ""), vim.log.levels.ERROR)
    return nil
  end

  local remote_url
  remote_url, err = git_exec("git remote get-url origin")
  if not remote_url then
    vim.notify("No origin remote: " .. (err or ""), vim.log.levels.ERROR)
    return nil
  end

  local file = vim.fn.expand("%:p")
  local rel_path = file:sub(#root + 2)

  return {
    root = root,
    remote_url = remote_url,
    rel_path = rel_path,
  }
end

local function get_ref(override)
  if override then
    return override
  end

  local ref_type = M.config.default_ref

  if ref_type == "sha" then
    return git_exec("git rev-parse HEAD")
  end

  if ref_type == "branch" then
    return git_exec("git branch --show-current")
  end

  -- origin_head (default)
  local ref = git_exec("git rev-parse --abbrev-ref origin/HEAD")
  if ref then
    return ref:gsub("^origin/", "")
  end
  -- fallback to current branch
  return git_exec("git branch --show-current")
end

local function parse_remote(url)
  local host, project

  -- ssh://user@host:port/project.git
  host, project = url:match("ssh://[^@]+@([^:/]+)[:%d]*/(.+)")
  if host then return host, project:gsub("%.git$", "") end

  -- user@host:project.git
  host, project = url:match("[^@]+@([^:]+):(.+)")
  if host then return host, project:gsub("%.git$", "") end

  -- https://host/project.git
  host, project = url:match("https?://([^/]+)/(.+)")
  if host then return host, project:gsub("%.git$", "") end

  return nil, nil
end

local function github_url(host, project, ref, path, line_from, line_to)
  local url = string.format("https://%s/%s/blob/%s/%s", host, project, ref, path)
  if line_from then
    url = url .. "#L" .. line_from
    if line_to and line_to ~= line_from then
      url = url .. "-L" .. line_to
    end
  end
  return url
end

local function gitiles_url(host, project, ref, path, line_from, line_to)
  local url = string.format("https://%s/plugins/gitiles/%s/+/refs/heads/%s/%s", host, project, ref, path)
  if line_from then
    url = url .. "#" .. line_from
  end
  return url
end

local generators = {
  github = github_url,
  gitiles = gitiles_url,
}

function M.generate_link(line_from, line_to, opts)
  opts = opts or {}

  local info = get_git_info()
  if not info then return nil end

  local host, project = parse_remote(info.remote_url)
  if not host then
    vim.notify("Cannot parse remote URL: " .. info.remote_url, vim.log.levels.ERROR)
    return nil
  end

  local ref = get_ref(opts.ref)
  if not ref then
    vim.notify("Cannot determine git ref", vim.log.levels.ERROR)
    return nil
  end

  for _, p in ipairs(M.config.patterns) do
    if info.remote_url:match(p.match) then
      if type(p.type) == "function" then
        return p.type(host, project, ref, info.rel_path, line_from, line_to)
      end
      local gen = generators[p.type]
      if gen then
        return gen(host, project, ref, info.rel_path, line_from, line_to)
      end
    end
  end

  vim.notify("No matching pattern for remote: " .. info.remote_url, vim.log.levels.WARN)
  return nil
end

function M.copy_link(line_from, line_to, opts)
  local url = M.generate_link(line_from, line_to, opts)
  if url then
    vim.fn.setreg("+", url)
    vim.notify("Copied: " .. url)
  end
end

vim.api.nvim_create_user_command("GitLink", function(opts)
  local ref = opts.args ~= "" and opts.args or nil
  local line_from, line_to = nil, nil
  if opts.range > 0 then
    line_from = opts.line1
    line_to = opts.line2
  end
  M.copy_link(line_from, line_to, { ref = ref })
end, { range = true, nargs = "?", desc = "Copy git web link to clipboard" })

return M
