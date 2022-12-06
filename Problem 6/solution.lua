local function read_file(path)
    local file = io.open(path, "rb") -- r read mode and b binary mode
    if not file then return nil end
    local content = file:read "*a" -- *a or *all reads the whole file
    file:close()
    return content
end

local function getTableSize(t)
    local count = 0
    for _, __ in pairs(t) do
        count = count + 1
    end
    return count
end


local function unique(s)
    local a = {}
    local set = {}
    for i = 1, #s, 1 do
        a[i] = s:sub(i, i)
    end
    for _, value in ipairs(a) do
  set[value] = true
end
--     print(getTableSize(set),#s)
    return getTableSize(set) == #s
end

local function scan_first_unique(data,n)
    for i = 1, #data - n, 1 do
        if unique(data:sub(i, i + n -1)) then
            return i+n -1;
        else
--             print(data:sub(i, i + n))
        end
    end
end


local function main()
    local d = read_file('input.txt')
    print(scan_first_unique(d,4))
    print(scan_first_unique(d,14))
end

main()
