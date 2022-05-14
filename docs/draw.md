# draw

## draw.set_clip(x, y, w, h) + draw.end_clip()
| Variable      | Type     |
| ------------- | -------- |
| `x`        | `Number` |
| `y`        | `Number` |
| `w`        | `Number` |
| `h`        | `Number` |

Example:
    ```lua
    client.add_callback('on_paint', function()
        draw.set_clip(150,150,150,150)
        draw.filled_rect(100, 100, 400, 400, 255,255,255,255)
        draw.end_clip()
    end)    
    ```

## draw.line(x0, y0, x1, y1, r, g, b, a)
| Variable      | Type     |
| ------------- | -------- |
| `x`        | `Number` |
| `y`        | `Number` |
| `x1`        | `Number` |
| `y1`        | `Number` |
| `r`        | `Number` |
| `g`        | `Number` |
| `b`        | `Number` |
| `a`        | `Number` |

Example:
    ```lua
    client.add_callback('on_paint', function()
        draw.line(100, 100, 200, 200, 255,255,255,255)
    end)    
    ```


## draw.rect(x, y, w, h, r, g, b, a)
| Variable      | Type     |
| ------------- | -------- |
| `x`        | `Number` |
| `y`        | `Number` |
| `w`        | `Number` |
| `h`        | `Number` |
| `r`        | `Number` |
| `g`        | `Number` |
| `b`        | `Number` |
| `a`        | `Number` |

Example:
    ```lua
    client.add_callback('on_paint', function()
        draw.rect(100, 150, 100, 100, 255,255,255,255)
    end)    
    ```


## draw.filled_rect(x, y, w, h, r, g, b, a)
| Variable      | Type     |
| ------------- | -------- |
| `x`        | `Number` |
| `y`        | `Number` |
| `w`        | `Number` |
| `h`        | `Number` |
| `r`        | `Number` |
| `g`        | `Number` |
| `b`        | `Number` |
| `a`        | `Number` |

Example:
    ```lua
    client.add_callback('on_paint', function()
        draw.filled_rect(100, 150, 100, 100, 255,255,255,255)
    end)    
    ```


## draw.gradientrect(x, y, w, h, r0, g0, b0, a0, r1, g1, b1, a1, horizontal)

| Variable      | Type     |
| ------------- | -------- |
| `x`        | `Number` |
| `y`        | `Number` |
| `w`        | `Number` |
| `h`        | `Number` |
| `r0`        | `Number` |
| `g0`        | `Number` |
| `b0`        | `Number` |
| `a0`        | `Number` |
| `r1`        | `Number` |
| `g1`        | `Number` |
| `b1`        | `Number` |
| `a1`        | `Number` |
| `horizontal`| `Boolean` |

Example:
    ```lua
    client.add_callback('on_paint', function()
        draw.gradientrect(100, 100, 150, 20, color.new(255,255,255), color.new(0,0,0), true)
    end)
    ```

## draw.polygon(vertices, clipvertices, r, g, b, a)
| Variable      | Type     |
| ------------- | -------- |
| `vertices`    | `vec2 Table` |
| `clipvertices`| `Boolean` |
| `r`        | `Number` |
| `g`        | `Number` |
| `b`        | `Number` |
| `a`        | `Number` |

Example:
    ```lua
    local vertices = {vec2.new(100,150), vec2.new(110,150), vec2.new(100,150)} -- up to infinite
    client.add_callback('on_paint', function()
        draw.polygon(vertices, false, 255,255,255,255)
    end)    
    ```


## draw.polyline(vertices, r, g, b, a)
| Variable      | Type     |
| ------------- | -------- |
| `vertices`    | `vec2 Table` |
| `r`        | `Number` |
| `g`        | `Number` |
| `b`        | `Number` |
| `a`        | `Number` |

Example:
    ```lua
    local vertices = {vec2.new(100,150), vec2.new(110,150), vec2.new(100,150)} -- up to infinite
    client.add_callback('on_paint', function()
        draw.polyline(vertices, 255,255,255,255)
    end)    
    ```


## draw.init_rgba(data, w, h)
    -- TODO
    
## draw.rgba(datatbl, x, y, w, h, alpha)
    -- TODO

## draw.init_font(name, h, weight, blur, flags)
| Variable      | Type     |
| ------------- | -------- |
| `name`        | `String` |
| `h`        | `Number` |
| `weight`        | `Number` |
| `blur`        | `Number` |
| `flags`        | `Number Table` |

|  Return Value    |
| ---------------- |
| font id  |

??? tip
    You can see all flags [here](.\)

Example:
    ```lua
    local font = draw.init_font('Verdana', 12, 12, 0, {EFontFlags('DROPSHADOW')})
    ```

## draw.get_textsize(font, text)
| Variable      | Type     |
| ------------- | -------- |
| `font`        | `Number` |
| `text`        | `String` |

|  Return Value    |
| ---------------- |
| `vec2` x,y  |

Example:
    ```lua
    local size = draw.get_textsize(font, 'Hello world!')
    print(tostring(size.x)) 
    print(tostring(size.y))  
    ```

## draw.text(font, x, y, r, g, b, a, text)
| Variable      | Type     |
| ------------- | -------- |
| `font`        | `Number` |
| `r`        | `Number` |
| `g`        | `Number` |
| `b`        | `Number` |
| `a`        | `Number` |
| `text`        | `String` |

Example:
    ```lua
    client.add_callback('on_paint', function()
        draw.text(font, 50, 50, 255,255,255,255, 'Hello world!')
    end)    
    ```


## draw.text_centered(font, x, y, r, g, b, a, text, centered_x, centered_y)
| Variable      | Type     |
| ------------- | -------- |
| `font`        | `Number` |
| `r`        | `Number` |
| `g`        | `Number` |
| `b`        | `Number` |
| `a`        | `Number` |
| `text`        | `String` |
| `centered_x`| `Boolean` |
| `centered_y`| `Boolean` |

Example:
    ```lua
    client.add_callback('on_paint', function()
        draw.text_centered(font, 50, 50, 255,255,255,255, 'Hello world!', true, true)
    end)    
    ```
