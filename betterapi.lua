ffi = require("ffi")

ffi.cdef[[
    int MessageBoxA(void *w, const char *txt, const char *cap, int type);
    bool CreateDirectoryA(const char* lpPathName, void* lpSecurityAttributes);
    int exit(int arg);

    void* __stdcall URLDownloadToFileA(void* LPUNKNOWN, const char* LPCSTR, const char* LPCSTR2, int a, int LPBINDSTATUSCALLBACK);        
    void* __stdcall ShellExecuteA(void* hwnd, const char* op, const char* file, const char* params, const char* dir, int show_cmd);

    int AddFontResourceA(const char* unnamedParam1);

    bool DeleteUrlCacheEntryA(const char* lpszUrlName);

    typedef struct tagPOINT {
        long x;
        long y;
    } POINT;

    bool GetCursorPos(
        POINT* lpPoint
    );

    short GetAsyncKeyState(
        int vKey
    );

    void* GetProcAddress(void* hModule, const char* lpProcName);
    void* GetModuleHandleA(const char* lpModuleName);
 
    typedef struct {
        uint8_t r;
        uint8_t g;
        uint8_t b;
        uint8_t a;
    } color_struct_t;

    typedef void (*console_color_print)(const color_struct_t&, const char*, ...);

    typedef unsigned long DWORD, *PDWORD, *LPDWORD;  

    typedef void (__cdecl* chat_printf)(void*, int, int, const char*, ...);

]]

local function panoramalib()
    local ffi = require("ffi")
    ffi.cdef[[
        // UIEngine
        typedef void*(__thiscall* access_ui_engine_t)(void*, void); // 11
        typedef bool(__thiscall* is_valid_panel_ptr_t)(void*, void*); // 36
        typedef void*(__thiscall* get_last_target_panel_t)(void*); // 56
        typedef int (__thiscall *run_script_t)(void*, void*, char const*, char const*, int, int, bool, bool); // 113

        // IUIPanel
        typedef const char*(__thiscall* get_panel_id_t)(void*, void); // 9
        typedef void*(__thiscall* get_parent_t)(void*); // 25
        typedef void*(__thiscall* set_visible_t)(void*, bool); // 27
    ]]
    local interface_ptr = ffi.typeof("void***")
    local rawpanoramaengine = utils.create_interface("panorama.dll", "PanoramaUIEngine001")
    local panoramaengine = ffi.cast(interface_ptr, rawpanoramaengine) -- void***
    local panoramaengine_vtbl = panoramaengine[0] -- void**

    local access_ui_engine = ffi.cast("access_ui_engine_t", panoramaengine_vtbl[11]) -- void*

    local function get_last_target_panel(uiengineptr)
        local vtbl = uiengineptr[0] or error("uiengineptr is nil", 2)
        local func = vtbl[56] or error("uiengineptr_vtbl is nil", 2)
        local fn = ffi.cast("get_last_target_panel_t", func)
        return fn(uiengineptr)
    end

    local function is_valid_panel_ptr(uiengineptr, itr)
        if itr == nil then 
            return false --error("itr is nil", 2)
        end
        local vtbl = uiengineptr[0] or error("uiengineptr is nil", 2)
        local func = vtbl[36] or error("uiengineptr_vtbl is nil", 2)
        local fn = ffi.cast("is_valid_panel_ptr_t", func)
        return fn(uiengineptr, itr)
    end

    local function get_panel_id(panelptr)
        local vtbl = panelptr[0] or error("panelptr is nil", 2)
        local func = vtbl[9] or error("panelptr_vtbl is nil", 2)
        local fn = ffi.cast("get_panel_id_t", func)
        return ffi.string(fn(panelptr))
    end

    local function set_visible(panelptr, state)
        local vtbl = panelptr[0] or error("panelptr is nil", 2)
        local func = vtbl[27] or error("panelptr_vtbl is nil", 2)
        local fn = ffi.cast("set_visible_t", func)
        fn(panelptr, state)
    end

    local function get_parent(panelptr)
        local vtbl = panelptr[0] or error("panelptr is nil", 2)
        local func = vtbl[25] or error("panelptr_vtbl is nil", 2)
        local fn = ffi.cast("get_parent_t", func)
        return fn(panelptr)
    end

    local function get_root(uiengineptr, custompanel)
        local itr = get_last_target_panel(uiengineptr) 
        if itr == nil then 
            return
        end
        local ret = nil
        local panelptr = nil
        while itr ~= nil and is_valid_panel_ptr(uiengineptr, itr) do 
            panelptr = ffi.cast("void***", itr)
            if custompanel and get_panel_id(panelptr) == custompanel then 
                ret = itr
                break
            elseif get_panel_id(panelptr) == "CSGOHud" then 
                ret = itr
                break
            elseif get_panel_id(panelptr) == "CSGOMainMenu" then 
                ret = itr
                break
            end
            itr = get_parent(panelptr) or error("Couldn't get parent..", 2)
        end
        return ret
    end

    local uiengine = ffi.cast("void***", access_ui_engine(panoramaengine))
    local run_script = ffi.cast("run_script_t", uiengine[0][113])

    local rootpanel = get_root(uiengine) or error("Couldn't get root panel..", 2)

    local function eval(code, custompanel, customFile)
        if custompanel then 
            rootpanel = get_root(uiengine, custompanel)
        else
            if rootpanel == nil then    
                rootpanel = get_root(uiengine) or error("Couldn't get root panel..", 2)
            end
        end
        local file = customFile or "panorama/layout/base_mainmenu.xml"
        return run_script(uiengine, rootpanel, ffi.string(code), file, 8, 10, false, false)
    end
    local function get_child(childname)
        return get_root(uiengine, childname) or error("Couldn't get root panel..", 2)
    end
    local function change_visiblity(childptr, state)
        local panelptr = ffi.cast("void***", childptr)
        if is_valid_panel_ptr(uiengine, childptr) then 
            return set_visible(panelptr, state)
        else
            error("Invalid panel..", 2)
        end
    end
    local function get_child_name(childptr)
        local panelptr = ffi.cast("void***", childptr)
        if is_valid_panel_ptr(uiengine, childptr) then 
            return ffi.string(get_panel_id(panelptr))
        else
            error("Invalid panel..", 2)
        end
    end
    return {
        eval = eval,
        get_child = get_child,
        get_child_name = get_child_name,
        set_visible = change_visiblity
    }
end

local keycache = {}

local urlmon = ffi.load 'UrlMon'
local wininet = ffi.load 'WinInet'
local gdi = ffi.load 'Gdi32'

local g_VGuiSurface = ffi.cast(ffi.typeof("void***"), utils.create_interface("vguimatsurface.dll", "VGUI_Surface031"))
local native_Surface_DrawSetColor = ffi.cast(ffi.typeof("void(__thiscall*)(void*, int, int, int, int)"), g_VGuiSurface[0][15])
local native_Surface_DrawFilledRectFade = ffi.cast(ffi.typeof("void(__thiscall*)(void*, int, int, int, int, unsigned int, unsigned int, bool)"), g_VGuiSurface[0][123])

GradientRect = function(x, y, w, h, color, color2, horizontal)
    local r0, g0, b0, a0 = color:r(), color:g(), color:b(), color:a()
    local r1, g1, b1, a1 = color2:r(), color2:g(), color2:b(), color2:a()

    native_Surface_DrawSetColor(g_VGuiSurface,r0, g0, b0, a0)
    native_Surface_DrawFilledRectFade(g_VGuiSurface,x, y, x + w, y + h, 255, 0, horizontal)
    native_Surface_DrawSetColor(g_VGuiSurface,r1, g1, b1, a1)
    return native_Surface_DrawFilledRectFade(g_VGuiSurface,x, y, x + w, y + h, 0, 255, horizontal)
end

local ffi_helpers = {
    color_print_fn = ffi.cast("console_color_print", ffi.C.GetProcAddress(ffi.C.GetModuleHandleA("tier0.dll"), "?ConColorMsg@@YAXABVColor@@PBDZZ")),
    color_print = function(self, text, color)
        local col = ffi.new("color_struct_t")

        col.r = color:r()
        col.g = color:g()
        col.b = color:b()
        col.a = color:a()

        self.color_print_fn(col, text)
    end
}

local FindHudElement = function(name)
    local pThis = ffi.cast(ffi.typeof("DWORD**"), utils.find_signature("client.dll", "B9 ? ? ? ? 68 ? ? ? ? E8 ? ? ? ? 89 46 24") + 1)[0]

    local find_hud_element = ffi.cast(ffi.typeof("DWORD(__thiscall*)(void*, const char*)"), utils.find_signature("client.dll", "55 8B EC 53 8B 5D 08 56 57 8B F9 33 F6 39 77 28"))

    return find_hud_element(pThis, name)
end

ffi.C.CreateDirectoryA('C:\\BetterAPI', NULL)


fs = {}
misc = {}
sengine = {}
input = {}
draw = {}
panorama = panoramalib()
entlist = {}
--- FILE SYSTEM START ----

fs.download = function(from, to)
    wininet.DeleteUrlCacheEntryA(from)
    urlmon.URLDownloadToFileA(nil, from, to, 0,0)
end

fs.createdir = function(path)
    ffi.C.CreateDirectoryA(path, NULL)
end

fs.addfont = function(path)
    gdi.AddFontResourceA( path )
end

fs.scriptpath = function()
    local str = debug.getinfo(2, "S").source:sub(2)
    local name = str:match("[^/]*.lua$")
    return name
end

--- FILE SYSTEM END ----

--- MISC START ---

misc.scriptname = function()
    local str = debug.getinfo(2, "S").source:sub(2)
    local start, finish = str:find('[%w%s!-={-|]+[_%.].+')   
    return str:sub(start,#str) 
end

--- MISC END ---

--- INPUT START ----

input.getcursorpos = function()
    local pointer = ffi.new("POINT[1]")
    ffi.C.GetCursorPos(pointer)
    return pointer[0]
end

input.keystate = function(code)
    if ffi.C.GetAsyncKeyState(code) ~= 0 then
        return true
    else 
        return false
    end
end

--- INPUT END ---

--- SOURCE ENGINE START ---

sengine.colorprint = function(color, text)
    ffi_helpers.color_print(ffi_helpers, text, color)
end

sengine.chatprint = function(text)
    local g_ChatElement = FindHudElement("CHudChat")
    local CHudChat_vtbl = ffi.cast(ffi.typeof("void***"), g_ChatElement)
    local print = ffi.cast("chat_printf", CHudChat_vtbl[0][27])
    print(CHudChat_vtbl, 0, 0, text)
end

--- SOURCE ENGINE END ---

--- DRAW START ---

draw.gradientrect = GradientRect

--- DRAW END ---

--- ENTITY LIST START ---

entlist.get_players = function(num) -- 0 - enemies only, 1 - teammates only, 2 - all players
    local num = num or 2
    local lp = entitylist.get_local_player()
    local players = {}
    for i=1, globals.get_maxclients() do
        local ent = entitylist.get_player_by_index( i )
        if not ent then goto skip end
        local pl = entitylist.entity_to_player( ent )
        if not pl then goto skip end
        if num == 2 then
            table.insert(players, pl)
        elseif num == 1 then
            if lp:get_team() == pl:get_team() then
                table.insert(players, pl)
            end
        elseif num == 0 then
            if lp:get_team() ~= pl:get_team() then
                table.insert(players, pl)
            end
        else
            error()
        end

        ::skip::
    end

    return players
end

--- ENTITY LIST END ---