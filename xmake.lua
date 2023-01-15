
set_languages("c99", "cxx20")

add_rules("mode.debug", "mode.release")

add_defines(
    "_MSC_VER=1929",
    "UNICODE",
    "_WIN64",
    "_AMD64_",
    "AMD64"
)

add_subdirs("src")
