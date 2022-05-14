# player

## player:is_alive()

|  Return Value    |
| ---------------- |
| bool Is player alive or not |

Example:
    ```lua
    local lp = entitylist.get_local_player()
    print(tostring(lp:is_alive()))
    ```

## player:gethitboxpos(hitbox_id)

|   Variable  |   Type   |              Description               |
| ----------- | -------- | -------------------------------------- |
| `hitbox_id` | `Number` | Id of hitbox you want to know position |


|  Return Value    |
| ---------------- |
| `vector` position  |

Example:
    ```lua
    client.add_callback( 'on_paint', function() 
        local lp = entitylist.get_local_player()
        local headpos = lp:gethitboxpos(0)
        local pos2d = render.world_to_screen( headpos )
        if not pos2d then return end
        render.draw_rect_filled( pos2d.x - 7.5, pos2d.y - 7.5, 15, 15, color.new(255,100,100) )
    end)
    ```