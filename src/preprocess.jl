function chunks(path)
    out = collect(tokenize(read(path, String)))
    # for i in reverse(1:length(out))
    #     println(Tokenize.Tokens.kind(out[i]))
    # end
    out
end

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
#         else
#             @info "Skipping: $line"
#         end
#     end
#     return out 
# end


function to_markdown(path; toc=true, tocdepth=2, addnumbers=true)
    
end