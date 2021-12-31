## memory.find_process(name)

| Variable      | Type     |
| ------------- | -------- |
| `name`        | `String` |

Example:
    ```lua
    memory.find_process('csgo.exe')
    ```

## memory.find_module(name)

| Variable      | Type     |    Description     |
| ------------- | -------- | ------------------ |
| `name`        | `String` | Name of the module |

|   Return Value   |
| ---------------- |
| `module handle` |

Example:
    ```lua
    local client_dll = memory.find_module('client.dll')
    ```

## memory.readmemory(t, offset, add)

| Variable      | Type     |    Description     |
| ------------- | -------- | ------------------ |
| `t`        | `String` | Name of the module |
| `offset`        | `handle` | Handle of the module |  <!-- Заполнить таблицу нормально -->
| `add`        | `int` | Prop offset |

|   Return Value   |
| ---------------- |
| What you asked for in t |

Example:
    ```lua
    local offsets = {
        dwLocalPlayer = 0xDA747C,
        index = 0x64,
    } -- 10.11.2021
    local lp = memory.readmemory("void*", client_dll, offsets.dwLocalPlayer)
    local lp_index = memory.readmemory("int", ffi.cast("int", lp), offsets.index)
    print(tostring(lp_index)) -- Prints local player index
    ```

## memory.writememory(t, offset, add, value)

| Variable      | Type     |    Description     |
| ------------- | -------- | ------------------ |
| `t`        | `String` | Name of the module |
| `offset`        | `handle` | Handle of the module |  <!-- Заполнить таблицу нормально -->
| `add`        | `int` | Prop offset |
| `value`        | ??? | What you need to write |

Example:
    ```lua
    -- TODO
    ```