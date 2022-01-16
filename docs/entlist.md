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

## entlist.find_by_class(class)

| Variable |   Type   |    Description     |
| -------- | -------- | ------------------ |
| `class`  | `String` | Name of this class |


|          Return Value            |
| -------------------------------- |
| Entity that have this class name |

Example:
    ```lua
    local chicken = entlist.find_by_class(CChicken)
    print(tostring(chicken:get_prop_bool('CChicken', 'm_jumpedThisFrame'))) -- Maybe:D
    ```

## entlist.get_player_resource()

|       Return Value       |
| ------------------------ |
| CCSPlayerResource entity |

Example:
    ```lua
    local CCSPlayerResource = entlist.get_player_resource()
    print(tostring(CCSPlayerResource:get_prop_int('CCSPlayerResource', 'm_iPlayerC4'))) -- Maybe:D
    ```