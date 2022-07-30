# API modifications

## ffi.class(ctype, values, typedef)

| Variable      | Type     |
| ------------- | -------- |
| `ctype`        | `String` |
| `values`        | `classmember Table` |
| `typedef`        | `String` |

Example:
    ```lua
    ffi.class("IClientRenderable", {
        GetModel = classmember("model_t*(__thiscall*)(void*)", 8),
        SetupBones = classmember("bool(__thiscall*)(void*, matrix3x4_t* pBoneToWorldOut, int nMaxBones, int boneMask, float currentTime)", 13)
    })
    ```

## menu.get_color_t(path)

| Variable      | Type     |
| ------------- | -------- |
| `path`        | `String` |

Example:
    ```lua
    menu.add_color('color')
    
    client.add_callback('on_paint', function()
        local clr = menu.get_color_t('color')
        draw.rect(100,100,100,100,clr, 5)
    end)
    ```