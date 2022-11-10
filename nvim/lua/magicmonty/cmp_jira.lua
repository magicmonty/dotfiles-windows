local Job = require('plenary.job')
local empty = vim.fn.empty
local glob = vim.fn.glob
local source = {}
local credentialsFile = vim.fn.stdpath('data') .. '/cmp_jira.json'

local function file_exists(file)
  if empty(file) == 1 then
    return false
  end

  local f = io.open(file, 'rb')
  if f then
    f:close()
  end
  return f ~= nil
end

local function read_json(file)
  if not file_exists(file) then
    return
  end
  local lines = ''
  for line in io.lines(file) do
    lines = lines .. '\n' .. line
  end

  local ok, parsed = pcall(vim.json.decode, lines)
  if ok then
    return parsed
  end
end

local function write_json(file, json)
  local v = vim.fn.json_encode(json)

  local f = io.open(file, 'w+')
  if f then
    f:write(v)
    f:flush()
    f:close()
  end
end

local function getCredentials()
  local credentials = read_json(glob(credentialsFile))
  if not credentials
      or not credentials.username
      or empty(credentials.username) == 1
      or not credentials.password
      or empty(credentials.password) == 1
      or not credentials.url
      or empty(credentials.url) == 1
  then
    local url
    while empty(url) == 1 do
      url = vim.fn.input('Jira Instance: ', '')
    end

    local username
    while empty(username) == 1 do
      username = vim.fn.input('Jira Username: ', '')
    end

    local password
    while empty(password) == 1 do
      password = vim.fn.input('Jira Password: ', '')
    end

    credentials = {
      url = url,
      username = username,
      password = password,
    }

    write_json(credentialsFile, credentials)
  end

  return credentials
end

source.new = function()
  local credentials = getCredentials()
  local self = setmetatable({ credentials = credentials, cache = {} }, { __index = source })

  return self
end

source.complete = function(self, params, callback)
  if not self.credentials
      or not self.credentials.username
      or not self.credentials.password
      or not self.credentials.url
  then
    return
  end

  local completionWord = params.context.cursor_before_line
  local regex = self:make_regex(params.option)
  local matches = vim.fn.matchlist(completionWord, regex)
  if not matches or not matches[3] then
    return
  end

  local project = matches[3]

  local bufnr = vim.api.nvim_get_current_buf()
  local cache_key = project .. '_' .. bufnr
  local cache = self.cache[cache_key]

  if not cache or cache.isIncomplete then
    local url = self.credentials.url
        .. '/rest/api/2/search?jql=project='
        .. project
        .. '%20AND%20statusCategory!="To%20Do"%20AND%20assignee%20was%20currentUser()%20ORDER%20BY%20key'
    if cache and cache.isIncomplete then
      url = url .. '&startAt=' .. (cache.startAt + cache.maxResults)
    end

    Job
        :new({
          command = 'curl',
          args = {
            '-u',
            self.credentials.username .. ':' .. self.credentials.password,
            '-X',
            'GET',
            '-H',
            '"Content-type: application/json"',
            url,
          },

          on_exit = function(job)
            local result = job:result()
            local ok, parsed = pcall(vim.json.decode, table.concat(result, ''))

            if not ok then
              return
            end

            if not parsed or not parsed.issues then
              callback()
              return
            end

            local items = {}
            if cache then
              items = cache.items
            end

            for _, jira_item in ipairs(parsed.issues) do
              local description = ''
              if not jira_item.fields.description then
                description = jira_item.fields.description
              end

              table.insert(items, {
                label = jira_item.key,
                documentation = {
                  kind = 'markdown',
                  value = '# ' .. jira_item.key .. ' - ' .. jira_item.fields.summary .. '\n\n' .. string.gsub(
                    description,
                    '\r\n',
                    '\n'
                  ),
                },
              })
            end

            table.sort(items, function(a, b)
              return a.label < b.label
            end)

            local isIncomplete = (parsed.startAt + parsed.maxResults) <= parsed.total
            callback({ items = items, isIncomplete = isIncomplete })
            self.cache[cache_key] = {
              items = items,
              isIncomplete = isIncomplete,
              startAt = parsed.startAt,
              maxResults = parsed.maxResults,
              total = parsed.total,
            }
          end,
        })
        :start()
  else
    callback({ items = cache.items, isIncomplete = false })
  end
end

source.make_regex = function(_, option)
  local result = '\\(^\\|\\s\\)\\(\\u\\{3,}\\)-\\(\\d\\+\\)\\?'
  if not option.slugs then
    return result
  end

  result = ''
  for i, slug in ipairs(option.slugs) do
    if i == 1 then
      result = slug
    else
      result = result .. '\\|' .. slug
    end
  end

  return '\\(^\\|\\s\\)\\(' .. result .. '\\)-\\d*'
end

source.get_keyword_pattern = function(_, params)
  local result = '\\(\\u\\{3,}\\)-\\d*'
  if not params.option.slugs then
    return result
  end

  for i, slug in ipairs(params.option.slugs) do
    if i == 1 then
      result = slug
    else
      result = result .. '\\|' .. slug
    end
  end

  return '\\(' .. result .. '\\)-\\d*'
end

source.is_available = function(self)
  if not self.credentials then
    return false
  end

  return vim.bo.filetype == 'gitcommit'
end

return source
-- vim: foldlevel=99
