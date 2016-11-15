module NimrodFiles

export readnimrod_hdr, readnimrod, Nimrod
export toasciigrid

"""The horizontal grid type for the data. National Grid=0, latitude/longitude,
space view, polar stereographic, xy or other."""
@enum NimrodGridType nationalgrid=0 latlon=1 space=2 polar=3 xy=4 other=5

"""
Representation of the contents of a Nimrod file. The type parameter `T` depends
on the data type and size declared in fields 12 and 13 of the header.

Fields
======

- `hdr_dump::Array{Any}` - Contents of header in the order defined in the Nimrod
  specification.
- `data::Matrix{T}` - Data contents of a Nimrod file.
- `gridtype::NimrodGridType` - Grid type of data coordinates (e.g., lat/lon, NG).
- `xpix_size::Real` - Size of pixels in the x dimension.
- `ypix_size::Real` - Size of pixels in the y dimension.
- `llcorner::Tuple{Real,Real}` - (Easting,Northing) of lower left corner of the image.
"""
type Nimrod{T<:Real}
    hdr_dump::Array{Any}
    data::Matrix{T}

    gridtype::NimrodGridType
    xpix_size::Real
    ypix_size::Real

    """(Easting, Northing) of lower left corner of image."""
    llcorner::Tuple{Real,Real}
    """(Easting, Northing) of the centre of the lower left pixel."""
    llcenter::Tuple{Real,Real}
end

include("./io.jl")
include("./asciigrid.jl")
end # module
