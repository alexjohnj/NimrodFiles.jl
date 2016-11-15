@testset "ASCII Conversion" begin
    n = readnimrod("test_hexed_composite_2BI.dat")
    test_ascii_file = "test_ascii_tmp.nim"
    toasciigrid(n, test_ascii_file)

    expectedFileContents = """nrows 8
ncols 8
xllcenter 5.0
yllcenter -75.0
cellsize 10.0
nodata_value -1
5 5 -1 -1 -1 -1 -1 -1
-1 5 -1 -1 -1 -1 -1 -1
-1 -1 5 -1 -1 -1 -1 -1
-1 -1 -1 5 -1 -1 -1 -1
-1 -1 -1 -1 5 -1 -1 -1
-1 -1 -1 -1 -1 5 -1 -1
-1 -1 -1 -1 -1 -1 5 -1
-1 -1 -1 -1 -1 -1 -1 5
"""
    @test readstring(test_ascii_file) == expectedFileContents
    rm(test_ascii_file)
end
