module DocTestsTest
using Compat.Test

const bad_str = """
```jldoctest
julia> 1 + 2
2

julia> 1 + 1
2
```
```jldoctest
julia> 1 + 1
2

julia> 1 + 2
2
```
```jldoctest
julia> 1 + 2
2

julia> 1 + 2
2
```
"""

const good_str = """
```jldoctest
julia> 1 + 2
3

julia> 1 + 1
2
```
```jldoctest
julia> 1 + 1
2

julia> 1 + 2
3
```
```jldoctest
julia> 1 + 2
3

julia> 1 + 2
3
```
"""

function test_doctest_fixup()
    srcdir = "/Users/Fredrik/DocumenterTest/src"
    # println(srcdir)
    builddir = "/Users/Fredrik/DocumenterTest/build"
    # println(builddir)
    open(joinpath(srcdir, "index.md"), "w") do f
        write(f, bad_str)
    end
    # makedocs(source = srcdir, build = builddir)
    makedocs(source = srcdir, build = builddir, doctest = :fixup)
    makedocs(source = srcdir, build = builddir, strict=true)
    open(joinpath(srcdir, "index.md"), "r") do f
        str = read(f, String)
        @test str == good_str
    end
end





end # module
