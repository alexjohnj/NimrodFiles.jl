# Functions relating to converting Nimrod data to an ASCII ESRI grid

"""
    toasciigrid(n::Nimrod, outfile::AbstractString)

Write an instance of `Nimrod` to an ESRI ASCII file.

Arguments
=========

- `n::Nimrod` -- The nimrod data structure to write out.
- `outfile::AbstractString` -- The name of the file to write to.

Returns
=======

- `nothing`

Notes
=====

- It is assumed that the spatial resolution is the same in the x and y
  directions.
- For instances of `Nimrod{AbstractFloat}`, the no data value is given by header
  field 38.
- For instances of `Nimrod{Integer}`, the no data value is given by header field
  25.
"""
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
