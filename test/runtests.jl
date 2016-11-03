using NimrodFiles
using Base.Test

@testset "NimrodFiles" begin
    @testset "File Reading" begin
        # Test reading a hex edited Nimrod file. The contents are an 8x8 grid
        # with "5" on the diagonals and "-1" on the off diagonals. Data is
        # stored as 2 Byte integers. The coordinate system is set up with (0,0)
        # in the top left corner and each resolution cell being 10x10m.
        @testset "16-Bit Integer Data" begin
            expectedData = ones(Int16, (8,8)) * -1;
            expectedData[[i for i in 1:9:64]] = 5
            testFile = readnimrod("test_hexed_composite_2BI.dat")

            @test size(testFile.data) == (8, 8)
            @test testFile.data == expectedData
            @test testFile.gridtype == NimrodFiles.nationalgrid
            @test isapprox(testFile.xpix_size, 10f0)
            @test isapprox(testFile.ypix_size, 10f0)
            @test testFile.llcorner == (0f0, -80f0)
            @test testFile.llcenter == (5f0, -75f0)

            @test testFile.hdr_dump[105] == "mm/h*32"
            @test testFile.hdr_dump[106] == "Plr single site radars"
            @test testFile.hdr_dump[107] == "Rainfall rate Composite"
        end

        # Same thing but for 32-Bit integer data
        @testset "32-Bit Integer data" begin
            expectedData = ones(Int32, (8,8)) * -1;
            expectedData[[i for i in 1:9:64]] = 5
            testFile = readnimrod("test_hexed_composite_4BI.dat")

            @test size(testFile.data) == (8, 8)
            @test testFile.data == expectedData
            @test testFile.gridtype == NimrodFiles.nationalgrid
            @test isapprox(testFile.xpix_size, 10f0)
            @test isapprox(testFile.ypix_size, 10f0)
            @test testFile.llcorner == (0f0, -80f0)
            @test testFile.llcenter == (5f0, -75f0)

            @test testFile.hdr_dump[105] == "mm/h*32"
            @test testFile.hdr_dump[106] == "Plr single site radars"
            @test testFile.hdr_dump[107] == "Rainfall rate Composite"
        end

        # And now 32-Bit Floating Point Data
        @testset "32-Bit Floating Point data" begin
            expectedData = ones(Float32, (8,8)) * -1;
            expectedData[[i for i in 1:9:64]] = 5
            testFile = readnimrod("test_hexed_composite_4BF.dat")

            @test size(testFile.data) == (8, 8)
            @test testFile.data == expectedData
            @test testFile.gridtype == NimrodFiles.nationalgrid
            @test isapprox(testFile.xpix_size, 10f0)
            @test isapprox(testFile.ypix_size, 10f0)
            @test testFile.llcorner == (0f0, -80f0)
            @test testFile.llcenter == (5f0, -75f0)

            @test testFile.hdr_dump[105] == "mm/h*32"
            @test testFile.hdr_dump[106] == "Plr single site radars"
            @test testFile.hdr_dump[107] == "Rainfall rate Composite"
        end
    end
end
