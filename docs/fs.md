## fs.createdir(path)

| Variable      | Type     |       Description        |
| ------------- | -------- | ------------------------ |
| `path`        | `String` | Path to create directory |

Example:
    ```lua
    fs.createdir('C:/BetterAPI')
    ```

## fs.download(from, to)

| Variable      | Type     |    Description     |
| ------------- | -------- | ------------------ |
| `from`        | `String` |  Url to read   |
| `to`          | `String` |   Path to write    |

Example:
    ```lua
    fs.download('https://pastebin.com/raw/Q5rDZCPJ', 'C:/BetterAPI/Gnome.lua')
    ```

## fs.addfont(path)

| Variable      | Type     | Description  |
| ------------- | -------- | ------------ |
| `path`        | `String` | Path to font |

Example:
    ```lua
    fs.addfont('C:/BetterAPI/gnomefont.ttf')
    ```


## fs.scriptpath()

|          Return Value           |
| ------------------------------- |
| Path to script that launched it |

Example:
    ```lua
    local scriptpath = fs.scriptpath()
    ```