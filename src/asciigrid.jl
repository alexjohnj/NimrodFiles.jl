# Functions relating to converting Nimrod data to an ASCII ESRI grid

toasciigrid(n::Nimrod, outfile::AbstractString) = open((f) -> toasciigrid(n, f), outfile, "w")
function toasciigrid{T<:Integer}(n::Nimrod{T}, outfile::IOStream)
    hdrstr = """nrows $(size(n.data)[1])
ncols $(size(n.data)[2])
xllcenter $(n.llcenter[1])
yllcenter $(n.llcenter[2])
cellsize $(n.xpix_size)
nodata_value $(n.hdr_dump[25])
"""

    write(outfile, hdrstr)
    writedlm(outfile, n.data, ' ')
    return
end

function toasciigrid{T<:AbstractFloat}(n::Nimrod{T}, outfile::IOStream)
    hdrstr = """nrows $(size(n.data)[1])
ncols $(size(n.data)[2])
xllcenter $(n.llcenter[1])
yllcenter $(n.llcenter[2])
cellsize $(n.xpix_size)
nodata_value $(n.hdr_dump[38])
"""

    write(outfile, hdrstr)
    writedlm(outfile, n.data, ' ')
    return
end
