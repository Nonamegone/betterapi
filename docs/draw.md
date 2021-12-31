## draw.gradientrect(x, y, w, h, color, color2, horizontal)

| Variable      | Type     |    Description     |
| ------------- | -------- | ------------------ |
| `x`        | `Number` | X coordinate to draw |
| `y`        | `Number` | Y coordinate to draw |
| `w`        | `Number` | Width to draw |
| `h`        | `Number` | Height to draw |
| `color`        | `color` | Start Color |
| `color2`        | `color` | End Color |
| `horizontal`        | `Boolean` | Horizontal or not |

Example:
    ```lua
    client.add_callback('on_paint', function()
        draw.gradientrect(100, 100, 150, 20, color.new(255,255,255), color.new(0,0,0), true)
    end)
    ```