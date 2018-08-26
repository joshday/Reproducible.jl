function preprocess(path)
    file = read(path, String)
end

# function makedoc(path)
#     out = Symbol[]
#     ismd = false
#     lines = filter(!isempty, readlines(path))
#     lines = filter(x -> !startswith(x, "#"), lines)
#     map!(x -> rstrip(x) * "\n", lines, lines)

#     # categorize each line as :md or :code
#     for line in lines
#         if ismd 
#             push!(out, :md)
#             occursin("\"\"\"", line) && (ismd = false)
#         else
#             if occursin("\"\"\"", line) 
#                 ismd = true
#                 push!(out, :md)
#             else
#                 push!(out, :code)
#             end
#         end
#     end

#     # create vector of Chunks
#     chunks = Chunk[]
#     out[1] == :md ? push!(chunks, MD(lines[1])) : push!(chunks, Code(lines[1]))
#     for i in 2:length(lines)
#         c, l = out[i], lines[i]
#         if c == out[i-1]
#             chunks[end].s *= l
#         else
#             c == :md ? push!(chunks, MD(l)) : push!(chunks, Code(l))
#         end
#     end
#     Document(chunks)
# end




# #-----------------------------------------------------------------------# old
# function blocks(path)
#     out = [] 
#     file = read(path, String)
#     i = 1 
#     while i <= length(file)
#         ex, i = Meta.parse(file, i)
#         push!(out, ex)
#         # isa(ex, Expr) && push!(out, Code(ex))
#         # isa(ex, AbstractString) && push!(out, Content(ex))
#     end
#     out
# end

# function evalblocks(blks, mod = Core.eval(Main, Meta.parse("module Temp end")))
#     for b in blks 
#         @eval mod $b
#     end
#     blks
# end