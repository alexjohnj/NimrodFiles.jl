# NimrodFiles

[![Build Status](https://travis-ci.org/alexjohnj/NimrodFiles.jl.svg?branch=master)](https://travis-ci.org/alexjohnj/NimrodFiles.jl)
[![Build status](https://ci.appveyor.com/api/projects/status/0xwx5mqvn7bad44b?svg=true)](https://ci.appveyor.com/project/alexjohnj/nimrodfiles-jl)

A Julia package for reading Nimrod files supplied by the Met Office. The package
has been tested on a few composite radar images.

## Usage

The main function in this package is `readnimrod`. This reads the header and
data section of a Nimrod file and returns an instance of `Nimrod{T}`. This is a
composite type with two fields, `hdr_dump` and `data`. `hdr_dump` is of type `Array{Any}`
and contains the fields of the header in the order they are specified in
the [Nimrod specification][nimrod-spec]. `data` is of type `Matrix{T}` where `T`
is the data type and size specified in the header (e.g., `Int16`). The number of
rows and columns are specified in the header.

[nimrod-spec]: http://browse.ceda.ac.uk/browse/badc/ukmo-nimrod/doc/Nimrod_File_Format_v1.7.pdf

A quick example of using NimrodFiles:

``` julia
using NimrodFiles

nf = readnimrod("metoffice-c-band-rain-radar_uk_201603260000_1km-composite.dat")

# Test data matrix size matches what's in the header
@assert (nf.hdr_dump[16], nf.hdr_dump[17]) == size(nf.data)
```

NimrodFiles also exposes the function `readnimrod_hdr` which works in the same
manner but only returns an array of the header contents.

## TODO

- [x] Add convenience fields to `Nimrod{T}` (e.g., date, nrows, ncols fields).
- [x] Add function to convert Nimrod files to an ASCII format.

## License

Good old MIT.
