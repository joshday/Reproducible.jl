function chunks(path)
    run(`julia $path`)
    lines = readlines(path)
end

# function chunks(path)
#     out = String[]
#     t = collect(tokenize(read(path, String)))

#     samechunk = false

#     for ti in t
#         # If triple quoted string, assume it gets copied exactly into markdown
#         if Tokens.kind(ti) == Tokens.TRIPLE_STRING 
#             push!(out, replace(string(ti), "\"\"\"" => ""))
        
#         # if previous line
#         elseif samechunk
#         end
#     end
#     out
# end

# content_string = "\"\"\"\n"

# function chunks(path, partinit=0)
#     out = String[]
#     part = Int[]

#     continue_code = continue_content = false

#     i = partinit

#     for line in eachline(path)
#         line = rstrip(line) * "\n"
        
#         # content
#         if continue_content
#             if line == content_string  
#                 continue_content = false 
#             else
#                 out[end] *= line
#             end
#         elseif line == content_string
#             push!(out, ""); push!(part, i+=1)
#             continue_content = true
        
#         # code 
#         elseif continue_code 
#             if occursin("end", line)
#                 continue_code = false 
#             else
#                 out[end] *= line
#             end
#         elseif startswith(line, "@code")
#             if occursin("begin", line)
#                 continue_code = true
#                 push!(out, ""); push!(part, i+=1)
#             else 
#                 push!(out, line); push!(part, i+=1)
#             end

#         # includes 
#         elseif startswith(line, "include")
#             file = match(r"\"(.*?)\"", line).captures[1]
#             dir = dirname(abspath(path))
#             part2, out2 = chunks(joinpath(dir, file))
#             append!(out, out2); append!(part, part2)
#         end
#     end
#     part, out
# end

# is_still_content(line) = !occursin("\"\"\"", line)
# is_still_code(line) = !occursin("end", line)


# function chunks(path; verbose=true)
#     out = Chunk[]

#     continue_code = continue_content = false

#     for line in eachline(path)
#         line = rstrip(line) * "\n"
#         if startswith(line, "@content")
#             push!(out, Content(""))
#             continue_content = true 
#         elseif continue_content
#             if (continue_content = is_still_content(line))
#                 out[end].s *= line 
#             end
#         elseif startswith(line, "@code")
#             push!(out, Code(""))
#             continue_code = true 
#         elseif continue_code 
#             if (continue_code = is_still_code(line))
#                 out[end].s *= line
#             end
#         elseif startswith(line, "include")
#             file = match(r"\"(.*?)\"", line).captures[1]
#             dir = dirname(abspath(path))
#             append!(out, chunks(joinpath(dir, file)))
#         elseif line == "\n"
#         else
#             @info "Skipping: $line"
#         end
#     end
#     return out 
# end


# function to_markdown(path; toc=true, tocdepth=2, addnumbers=true)
    
# end