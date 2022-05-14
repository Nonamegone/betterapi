# Examples with BetterAPI

=== "Clip"
    ```lua
    require('betterapi')
    local font = draw.init_font('Verdana', 12, 12, 0, {EFontFlags('DROPSHADOW')})

    local triangleSize = 14
    local boxSize = {x = 200, y = 200, w = 400, h = 200}
    local drag = {x = 0, y = 0}
    local drug = false

    local inBox = function (x,y,w,h, x1,y1)
        return x1 > x and x1 < x + w and y1 > y and y1 < y + h
    end

    client.add_callback('on_paint', function ()
        local cpos = input.getcursorpos()
        local boxX = boxSize.x + boxSize.w - triangleSize
        local boxY = boxSize.y + boxSize.h - triangleSize
        local cond = input.keystate(0x01) and inBox(boxX, boxY, triangleSize, triangleSize, cpos.x, cpos.y)
        if not drug and cond then
            drug = true
            drag.x = boxX - cpos.x + triangleSize
            drag.y = boxY - cpos.y + triangleSize
        end

        if drug and not input.keystate(0x01) then
            drug = false
        end

        if drug then
            boxSize.w = math.max((drag.x + cpos.x) - boxSize.x, 10)
            boxSize.h = math.max((drag.y + cpos.y) - boxSize.y, 10)
        end

        draw.filled_rect(boxSize.x, boxSize.y, boxSize.w, boxSize.h,40,40,40,255)
        local vertices = {vec2.new(boxSize.x + boxSize.w, boxSize.y + boxSize.h), vec2.new(boxSize.x + boxSize.w - triangleSize, boxSize.y + boxSize.h), vec2.new(boxSize.x +   boxSize.w, boxSize.y + boxSize.h - triangleSize)}
        draw.set_clip(200,200,boxSize.w,boxSize.h)
        draw.text(font, 200, 200, 255,255,255,255, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.     Convallis posuere morbi leo urna molestie at. Odio eu feugiat pretium nibh ipsum consequat nisl. Eu facilisis sed odio morbi quis commodo. Ipsum dolor sit amet consectetur     adipiscing elit pellentesque habitant. Felis eget nunc lobortis mattis aliquam. Hac habitasse platea dictumst quisque sagittis purus sit amet volutpat. Libero enim sed     faucibus turpis in eu. Eu lobortis elementum nibh tellus. Eu ultrices vitae auctor eu. Eu augue ut lectus arcu bibendum at varius vel.')
        draw.polygon(vertices, true, 60, 60, 60, 255)
        draw.end_clip()
    end)
    ```