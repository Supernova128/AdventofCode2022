using DelimitedFiles
using JSON


m = readlines("input.txt")

global path = "/"

global device = Dict()

global directory_size = Dict()


function main()
	for line in m
		#     println(line)
		if line[1] == '$'
			cmd_handle(SubString(line,3,length(line)))
		else
			handle_ls(line)
		end
	end
	sizes = dir_sizer(device,'/')
	println(add_upto(directory_size,100000))
	println(find_smallest(directory_size['/'] - 70000000 + 30000000))

end

function cmd_handle(cmd)
	if SubString(cmd,1,2) == "cd"
		#         println(SubString(cmd,4,))
		handle_cd(SubString(cmd,4,))
	end
end

function add_upto(d,i)
	total = 0
	for value in values(d)
		if value <= i
			total += value
		end
	end
	return total
end

function handle_cd(cd)
	if cd != ".." && cd != "/"
		global path *= cd * "/"
		#     println(path)
	elseif cd == ".."
		#     println(path)
		global path = SubString(path,1,second_to_last(path,'/'))
	end
end

function second_to_last(str,char)
	last_index = findlast(char,str)
	#     println(last_index)
	return findlast(char,str[1:last_index-1])
end

function handle_ls(info)
	if SubString(info,1,3) == "dir"
		add_dir(SubString(info,5,))
	else
		add_file(split(info," ")[1],split(info," ")[2])
	end
end

function add_dir(name)
	p = read_dict()
	if !(name in keys(p))
		p[name] = Dict()
	end
end


function add_file(size,name)
	path = read_dict()
	if !(path in keys(path))
		path[name] = size
	end
end


function read_dict()
	tmp = device
	#     println(split(path,'/'))
	for x in split(path,'/')
		tmp = get(tmp,x,tmp)
	end
	return tmp
end


function dir_sizer(x,name)
	size = 0
	for (key,value) in pairs(x)
		if typeof(value) == Dict{Any, Any}
			#             println(key)
			size += dir_sizer(value,name * key * "/")
		else
			#             print(value)
			size += parse(Int32,value)
		end

	end
	directory_size[name] = size
	return size
end

function find_smallest(size)
	best = directory_size['/']
	for value in values(directory_size)
		if value < best && value >= size
			best = value
		end
	end
	return best
end

main()



