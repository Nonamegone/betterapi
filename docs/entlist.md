## entlist.get_players(num)

| Variable | Type     | Description |
| -------- | -------- | ----------- |
| `num`    | `Number` |    Type     |


|  Return Value    |
| ---------------- |
| Table of players |

num = 0 - enemies only 
num = 1 - teammates only
num = 2 - all players

Example:
    ```lua
    local playerstable = entlist.get_players(num)
    for k,v in pairs(playerstable) do
        print(v:get_health())
    end
    ```