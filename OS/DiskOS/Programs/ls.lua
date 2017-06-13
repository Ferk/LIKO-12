--Lists the folders and files at the current directory.
local term = require("C://terminal") --Require the terminal api.

print("") --A new line

local paths = {...} --Get the arguments passed to this program

local function showList(path)
  --Returns a table containing the names of folders and files in the given directory
  local files = fs.directoryItems(path)
  for k, f in ipairs(files) do
    color(fs.isFile(path..f) and 7 or 11)
    print(f.." ",false)
  end
  print("")
end

if #paths == 0 then
  -- Without arguments, show current directory.
  showList(term.getpath())
else
  for i, rpath in ipairs(paths) do
    local path, pathExists = term.parsePath(rpath)

    if not pathExists then
      color(8) print(rpath..": No such file or directory") color(7)
    elseif fs.isFile(path) then
	  color(9) print(path) color(7)
	else
	  color(9) print(path,false) color(7)
	  print("/")
	  showList(path)
	end
  end
end