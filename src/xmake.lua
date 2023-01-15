

add_rules("mode.debug", "mode.release")

target("hvpp")
    add_rules("wdk.static", "wdk.env.wdm")

    local src_dir = path.join("hvpp", "hvpp")
    add_files(src_dir.."/**.cpp")
    add_files(src_dir.."/**.asm")

    add_includedirs(
        "hvpp",
        src_dir.."/lib",
        src_dir.."/vmexit"
    )
    add_includedirs(
        "C:/Program Files (x86)/Microsoft Visual Studio/2019/Enterprise/VC/Tools/MSVC/14.29.30133/include",
        "C:/Program Files (x86)/Microsoft Visual Studio/2019/Enterprise/VC/Tools/MSVC/14.29.30133/atlmfc/include",
        "C:/Program Files (x86)/Microsoft Visual Studio/2019/Enterprise/VC/Auxiliary/VS/include",
        "C:/Program Files (x86)/Windows Kits/10/Include/10.0.22621.0/ucrt",
        "C:/Program Files (x86)/Microsoft Visual Studio/2019/Enterprise/VC/Auxiliary/VS/UnitTest/include",
        "C:/Program Files (x86)/Windows Kits/10/Include/10.0.22621.0/km/crt",
        "C:/Program Files (x86)/Windows Kits/10/Include/10.0.22621.0/km",
        "C:/Program Files (x86)/Windows Kits/10/Include/10.0.22621.0/shared",
        "C:/Program Files (x86)/Windows Kits/10/Include/wdf/kmdf/1.15"
    )


target("hvppdrv")
    add_rules("wdk.driver", "wdk.env.wdm")

    local src_dir = path.join("hvppdrv", "hvpp")
    add_files("hvppdrv/**.cpp")

    add_includedirs(
        "hvpp",
        src_dir.."/ia32",
        src_dir.."/lib",
        src_dir.."/vmexit"
    )
    add_includedirs(
        "C:/Program Files (x86)/Microsoft Visual Studio/2019/Enterprise/VC/Tools/MSVC/14.29.30133/include",
        "C:/Program Files (x86)/Microsoft Visual Studio/2019/Enterprise/VC/Tools/MSVC/14.29.30133/atlmfc/include",
        "C:/Program Files (x86)/Microsoft Visual Studio/2019/Enterprise/VC/Auxiliary/VS/include",
        "C:/Program Files (x86)/Windows Kits/10/Include/10.0.22621.0/ucrt",
        "C:/Program Files (x86)/Microsoft Visual Studio/2019/Enterprise/VC/Auxiliary/VS/UnitTest/include",
        "C:/Program Files (x86)/Windows Kits/10/Include/10.0.22621.0/km/crt",
        "C:/Program Files (x86)/Windows Kits/10/Include/10.0.22621.0/km",
        "C:/Program Files (x86)/Windows Kits/10/Include/10.0.22621.0/shared",
        "C:/Program Files (x86)/Windows Kits/10/Include/wdf/kmdf/1.15"
    )

    add_deps("hvpp")
