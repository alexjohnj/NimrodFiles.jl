module NimrodFiles

export readnimrod_hdr

# Header size in bytes
const HEADER_SIZE = 512

type HeaderSizeError <: Exception end

"""
    readnimrod_hdr(fname::AbstractString)
    readnimrod_hdr(f::IOStream)::Array{Any,1}

Read the header of the Nimrod file called `fname` or from the stream
`f`. Returns an array of `Any` containing the fields of the header in the order
they are defined in according to the Nimrod file spec.
"""
readnimrod_hdr(fname::AbstractString) = open(readnimrod_hdr, fname)
function readnimrod_hdr(f::IOStream)::Array{Any,1}
    seekstart(f)

    # First 4 bytes are the length of the header in bytes. Should be 512
    if ntoh(read(f, Int32)) != HEADER_SIZE
        throw(HeaderSizeError())
    end

    # Read first 31 2 byte integer fields
    general_int_elements = map(ntoh, read(f, Int16, 31))

    # 28 4 byte Real fields
    general_real_elements = map(ntoh, read(f, Float32, 28))

    # 45 4 byte real fields
    data_real_elements = map(ntoh, read(f, Float32, 45))

    # 56 bytes of char data forming three fields
    data_char_elements = String(read(f, UInt8, 56))
    data_char_elements = [data_char_elements[1:8];
                          data_char_elements[9:32];
                          data_char_elements[33:56]];
    # Tidy null characters
    map!((s) -> strip(s, '\0'), data_char_elements)

    # Remaining 51 data specific 2 byte integer fields
    data_extra_elements = map(ntoh, read(f, Int16, 51))

    # Last 4 bytes should be size of header again.
    @assert ntoh(read(f, Int32)) == HEADER_SIZE "Last 4 bytes of header weren't its size."

    return vcat(general_int_elements,
                general_real_elements,
                data_real_elements,
                data_char_elements,
                data_extra_elements)
end
end # module
