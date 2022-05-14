# input

## input.keystate(code)

| Variable      | Type     |  Description   |
| ------------- | -------- | -------------- |
| `code`        | `Number` | Button KeyCode |

|  Return Value |
| ------------- |
| `true` or `false` |

??? tip
    You can see all keycodes [here](https://docs.microsoft.com/ru-ru/windows/win32/inputdev/virtual-key-codes)

Example:
    ```lua
    client.add_callback('on_paint', function()
        if input.keystate(0x01) then
            print('LMB pressed')
        end
    end)
    ```


## input.getcursorpos()

| Return Value |
| ------------ |
| X coordinate |
| Y coordinate |

Example:
    ```lua
    client.add_callback('on_paint', function()
        local cursorpos = input.getcursorpos()
        print('X coordinate: '..cursorpos.x)
        print('Y coordinate: '..cursorpos.y)
    end)
    ```