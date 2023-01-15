

add_rules("mode.debug", "mode.release")

rule("stl_dirs")
    
    -- set_policy("check.auto_ignore_flags", false)
    on_config(function (target)
        -- print("remove flag: -kernel")
        -- local cxflags = target:get("cxflags")
        -- if "table" == type(cxflags) then
        --     for i, v in ipairs(cxflags) do
        --         cxflags[i] = string.gsub(v, "-kernel", "-no-kernel")
        --     end
        -- else
        --     cxflags = string.gsub(cxflags, "-kernel", "-no-kernel")
        -- end
        -- target:set("cxflags", cxflags, {force=false})

        -- 因为2022的14.34.31933版本sdk会报 error LNK2019: 无法解析的外部符号 __std_find_trivial_1
        -- 所以目前暂时不用自动填最新sdk路径的方法
        -- add msvc stl includedirs
        import("detect.sdks.find_vstudio")
        local vs = find_vstudio({})
        local max_version = 0
        local sdk_includedirs = ""
        for k, v in pairs(vs) do
            local nk = tonumber(k)
            if max_version < nk then
                max_version = nk
                sdk_includedirs = vs[k]["vcvarsall"][os.arch()]["INCLUDE"]
                -- print(vs[k])
            end
        end
        
        local incTable = {}
        sdk_includedirs = sdk_includedirs:gsub("\\\\", "\\")
        for token in string.gmatch(sdk_includedirs, "[^%;]+") do
            token = token:gsub("14.34.31933", "14.29.30133")
            table.insert(incTable, token)
        end
        
        local includedirs = target:get("includedirs")
        if "table" == type(includedirs) then
            for _, v in ipairs(includedirs) do
                table.insert(incTable, v)
            end
        else
            table.insert(incTable, includedirs)
        end
        -- print(incTable)
        target:set("includedirs", incTable)
    end)

target("hvpp")
    add_rules("wdk.static", "wdk.env.wdm", "stl_dirs")

    local src_dir = path.join("hvpp", "hvpp")
    add_files(src_dir.."/**.cpp")
    add_files(src_dir.."/**.asm")

    add_includedirs(
        "hvpp",
        src_dir.."/lib",
        src_dir.."/vmexit"
    )

target("hvppdrv")
    add_rules("wdk.driver", "wdk.env.wdm", "stl_dirs")

    local src_dir = path.join("hvppdrv", "hvpp")
    add_files("hvppdrv/**.cpp")

    add_includedirs("hvpp")

    add_deps("hvpp")
