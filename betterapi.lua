ffi = require("ffi")

ffi.cdef[[

    typedef unsigned long DWORD, *PDWORD, *LPDWORD;  
    typedef unsigned char byte;

    typedef struct {
        uint8_t r;
        uint8_t g;
        uint8_t b;
        uint8_t a;
    } color_struct_t;

    typedef struct {
        float x,y;
    } vec2_t;

    typedef struct {
        vec2_t m_Position;
        vec2_t m_TexCoord;
    } Vertex_t;

    typedef struct tagPOINT {
        long x;
        long y;
    } POINT;

    typedef struct
    {
        float x,y,z;
    } vec3_t;

    // HITBOXPOS STRUCTS START

    typedef struct
    {
        int id;                     //0x0000
        int version;                //0x0004
        long    checksum;               //0x0008
        char    szName[64];             //0x000C
        int length;                 //0x004C
        vec3_t  vecEyePos;              //0x0050
        vec3_t  vecIllumPos;            //0x005C
        vec3_t  vecHullMin;             //0x0068
        vec3_t  vecHullMax;             //0x0074
        vec3_t  vecBBMin;               //0x0080
        vec3_t  vecBBMax;               //0x008C
        int pad[5];
        int numhitboxsets;          //0x00AC
        int hitboxsetindex;         //0x00B0
    } studiohdr_t;

    typedef struct
    {
        void*   fnHandle;               //0x0000
        char    szName[260];            //0x0004
        int nLoadFlags;             //0x0108
        int nServerCount;           //0x010C
        int type;                   //0x0110
        int flags;                  //0x0114
        vec3_t  vecMins;                //0x0118
        vec3_t  vecMaxs;                //0x0124
        float   radius;                 //0x0130
        char    pad[28];              //0x0134
    } model_t;

    typedef struct
    {
        int     m_bone;                 // 0x0000
        int     m_group;                // 0x0004
        vec3_t  m_mins;                 // 0x0008
        vec3_t  m_maxs;                 // 0x0014
        int     m_name_id;                // 0x0020
        vec3_t  m_angle;                // 0x0024
        float   m_radius;               // 0x0030
        int        pad2[4];
    } mstudiobbox_t;
    
    typedef struct
    {
        int sznameindex;
    
        int numhitboxes;
        int hitboxindex;
    } mstudiohitboxset_t;

    typedef struct {
        float m_flMatVal[3][4];
    } matrix3x4_t;

    // HITBOXPOS STRUCTS END

    unsigned int mbstowcs(wchar_t* w, const char* s, unsigned int c);

    bool GetCursorPos(
        POINT* lpPoint
    );

    short GetAsyncKeyState(
        int vKey
    );
    int MessageBoxA(void *w, const char *txt, const char *cap, int type);
    bool CreateDirectoryA(const char* lpPathName, void* lpSecurityAttributes);
    int exit(int arg);

    void* __stdcall URLDownloadToFileA(void* LPUNKNOWN, const char* LPCSTR, const char* LPCSTR2, int a, int LPBINDSTATUSCALLBACK);        
    void* __stdcall ShellExecuteA(void* hwnd, const char* op, const char* file, const char* params, const char* dir, int show_cmd);

    int AddFontResourceA(const char* unnamedParam1);

    bool DeleteUrlCacheEntryA(const char* lpszUrlName);

    bool GetCursorPos(
        POINT* lpPoint
    );

    short GetAsyncKeyState(
        int vKey
    );

    void* GetProcAddress(void* hModule, const char* lpProcName);
    void* GetModuleHandleA(const char* lpModuleName);

    typedef void (*console_color_print)(const color_struct_t&, const char*, ...);

    typedef void (__cdecl* chat_printf)(void*, int, int, const char*, ...);

    typedef int(__fastcall* clantag_t)(const char*, const char*);

    // HITBOXPOS FUNCS START

    typedef bool(__fastcall* cbaseanim_setupbones)(matrix3x4_t *pBoneToWorldOut, int nMaxBones, int boneMask, float currentTime);

    // HITBOXPOS FUNCS END

    // PANORAMA START

    // UIEngine
    typedef void*(__thiscall* access_ui_engine_t)(void*, void); // 11
    typedef bool(__thiscall* is_valid_panel_ptr_t)(void*, void*); // 36
    typedef void*(__thiscall* get_last_target_panel_t)(void*); // 56
    typedef int (__thiscall *run_script_t)(void*, void*, char const*, char const*, int, int, bool, bool); // 113

    // IUIPanel
    typedef const char*(__thiscall* get_panel_id_t)(void*, void); // 9
    typedef void*(__thiscall* get_parent_t)(void*); // 25
    typedef void*(__thiscall* set_visible_t)(void*, bool); // 27

    // PANORAMA END

]]

--- MEMORY CDEF START

ffi.cdef[[
	typedef void *PVOID;
	typedef PVOID HANDLE;
	typedef unsigned long DWORD;
	typedef bool BOOL;
	typedef unsigned long ULONG_PTR;
	typedef long LONG;
	typedef char CHAR;
	typedef unsigned char BYTE;
	typedef unsigned int SIZE_T;
	typedef const void *LPCVOID;
	typedef int *FARPROC;
	typedef const char *LPCSTR;
	typedef uint16_t *UINT;

	typedef struct tagPROCESSENTRY32 {
		DWORD     dwSize;
		DWORD     cntUsage;
		DWORD     th32ProcessID;
		ULONG_PTR th32DefaultHeapID;
		DWORD     th32ModuleID;
		DWORD     cntThreads;
		DWORD     th32ParentProcessID;
		LONG      pcPriClassBase;
		DWORD     dwFlags;
		CHAR      szExeFile[260];
	} PROCESSENTRY32;

	typedef struct tagMODULEENTRY32 {
		DWORD   dwSize;
		DWORD   th32ModuleID;
		DWORD   th32ProcessID;
		DWORD   GlblcntUsage;
		DWORD   ProccntUsage;
		BYTE    *modBaseAddr;
		DWORD   modBaseSize;
		HANDLE hModule;
		char    szModule[255 + 1];
		char    szExePath[260];
	} MODULEENTRY32;

	HANDLE CreateToolhelp32Snapshot(
		DWORD dwFlags,
		DWORD th32ProcessID
	);
	
	HANDLE OpenProcess(
		DWORD dwDesiredAccess,
		BOOL  bInheritHandle,
		DWORD dwProcessId
	);
	
	BOOL Process32Next(
		HANDLE           hSnapshot,
		PROCESSENTRY32 *lppe
	);
	
	BOOL CloseHandle(
		HANDLE hObject
	);
	
	BOOL Process32First(
		HANDLE           hSnapshot,
		PROCESSENTRY32 *lppe
	);
	
	BOOL Module32Next(
		HANDLE          hSnapshot,
		MODULEENTRY32 *lpme
	);
	
	BOOL Module32First(
		HANDLE          hSnapshot,
		MODULEENTRY32 *lpme
	);
	
	BOOL ReadProcessMemory(
		HANDLE  hProcess,
		LPCVOID lpBaseAddress,
		PVOID  lpBuffer,
		SIZE_T  nSize,
		SIZE_T  *lpNumberOfBytesRead
	);
	
	BOOL WriteProcessMemory(
	  HANDLE  hProcess,
	  LPCVOID  lpBaseAddress,
	  PVOID lpBuffer,
	  SIZE_T  nSize,
	  SIZE_T  *lpNumberOfBytesWritten
	);
	
	HANDLE GetModuleHandleA(
		LPCSTR lpModuleName
	);
	
	FARPROC GetProcAddress(
		HANDLE hModule,
		LPCSTR  lpProcName
	);

	BOOL TerminateProcess(
  		HANDLE hProcess,
  		UINT   uExitCode
	);
	
	typedef void*(* Interface_t)(const char*, int*);
	typedef PVOID(__thiscall* GetEntityHandle_t)(PVOID, unsigned long);
]]

--- MEMORY CDEF END

local vmt_bind = function(vmt_table, func, index)
    local result = ffi.cast(ffi.typeof(func), vmt_table[0][index])
    return function(...)
        return result(vmt_table, ...)
    end
end

local function panoramalib()
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

local function memorylib()
    local variables = {
        dwPID = 0,
        hProcess = 0,
    }
    
    
    proc = {}
    
    proc.find_module = function(name)
        local hModule = ffi.C.CreateToolhelp32Snapshot(0x00000008, variables.dwPID)
        if hModule == -1 then return end
        
        local mEntry = ffi.new("MODULEENTRY32")
        mEntry.dwSize = ffi.sizeof(mEntry)
        
        mEntry = ffi.new("MODULEENTRY32 [1]", mEntry)
        
        repeat
            if ffi.string(mEntry[0].szModule) == name then
                client.log(string.format("[~] Module %s found!", name))
            
                ffi.C.CloseHandle(hModule)
                
                return ffi.cast("DWORD", mEntry[0].modBaseAddr)
            end
        until not ffi.C.Module32Next(hModule, mEntry)
        
        ffi.C.CloseHandle(hModule)
        
        client.log(string.format("[-] Oops! Module %s not found!", name))
        
        return 0
    end
    
    proc.find_process = function(name)
        local hPID = ffi.C.CreateToolhelp32Snapshot(0x00000002, 0)
        if hPID == -1 then return end
    
        local PROCESSENTRY32 = ffi.new("PROCESSENTRY32")
        PROCESSENTRY32.dwSize = ffi.sizeof(PROCESSENTRY32)
    
        PROCESSENTRY32 = ffi.new("PROCESSENTRY32 [1]", PROCESSENTRY32)
    
        repeat
            if ffi.string(PROCESSENTRY32[0].szExeFile) == name then
                client.log(string.format("[~] Process %s found!", name))
                
                variables.dwPID = PROCESSENTRY32[0].th32ProcessID
                
                ffi.C.CloseHandle(hPID)
                
                variables.hProcess = ffi.C.OpenProcess(2035711, false, variables.dwPID)
                return 
            end
        until not ffi.C.Process32Next(hPID, PROCESSENTRY32)
    
        client.log(string.format("[-] Oops! Process %s not found!", name))
    
        ffi.C.CloseHandle(hPID)
        
        return
    end
    
    ------
    
    proc.readmemory = function(t, offset, add)
        if add ~= nil then
            offset = ffi.cast("PVOID", offset + add)
        else
            offset = ffi.cast("PVOID", offset)
        end
    
        local buff = ffi.new(t .. "[1]")
    
        ffi.C.ReadProcessMemory(variables.hProcess, offset, buff, ffi.sizeof(buff), nil)
        
        return buff[0]
    end
    
    ------
    
    proc.writememory = function(t, offset, add, value)
        if variables.dwPID < 1 then
            return "ахуел" end
    
        if add ~= nil then
            offset = ffi.cast("PVOID", offset + add)
        else
            offset = ffi.cast("PVOID", offset)
        end
    
        local buff = ffi.new(t .. "[1]", ffi.new(t, value))
    
        ffi.C.ReadProcessMemory(variables.hProcess, offset, buff, ffi.sizeof(buff), nil)
        
        return buff[0]
    end
    
    return proc
end

local new_vert = ffi.typeof('Vertex_t[?]')
local new_vec2 = ffi.typeof('vec2_t')
local zerovec = new_vec2()
zerovec.x, zerovec.y = 0,0
local charbuffer = ffi.typeof("char[?]")
local new_intptr = ffi.typeof("int[1]")
local new_boolptr = ffi.typeof('bool[1]')
local new_int = ffi.typeof('int')
local new_widebuffer = ffi.typeof("wchar_t[?]")

vec2 = {}
vec2.new = function(x,y)
    return ffi.new(new_vec2, {x,y})
end

local native_Surface, Cast_m_bClippingEnabled, clipCache, PrintText, font_cache, ConvertAnsiToUnicode = (function()
    local RawLocalize = utils.create_interface('localize.dll', 'Localize_001')
    local Localize    = ffi.cast(ffi.typeof('void***'), RawLocalize)

    local FindSafe = vmt_bind(Localize, 'wchar_t*(__thiscall*)(void*, const char*)', 12)
    local ConvertAnsiToUnicode = vmt_bind(Localize, 'int(__thiscall*)(void*, const char*, wchar_t*, int)', 15)
    local ConvertUnicodeToAnsi = vmt_bind(Localize, 'int(__thiscall*)(void*, wchar_t*, char*, int)', 16)

    local VGUI_Surface031 = utils.create_interface("vguimatsurface.dll", "VGUI_Surface031")
    local g_VGuiSurface = ffi.cast(ffi.typeof("void***"), VGUI_Surface031)
    local native_Surface = {}
    native_Surface.DrawSetColor = vmt_bind(g_VGuiSurface, "void(__thiscall*)(void*, int, int, int, int)", 15)
    native_Surface.DrawTexturedRect = vmt_bind(g_VGuiSurface, "void(__thiscall*)(void*, int, int, int, int)", 41)
    native_Surface.DrawSetTextureRGBA = vmt_bind(g_VGuiSurface, "void(__thiscall*)(void*, int, const unsigned char*, int, int)", 37)
    native_Surface.DrawSetTexture = vmt_bind(g_VGuiSurface, "void(__thiscall*)(void*, int)", 38)
    native_Surface.DrawFilledRectFade = vmt_bind(g_VGuiSurface, "void(__thiscall*)(void*, int, int, int, int, unsigned int, unsigned int, bool)", 123)
    native_Surface.DrawFilledRect =  vmt_bind(g_VGuiSurface, 'void(__thiscall*)(void*, int, int, int, int)', 16)
    native_Surface.DrawOutlinedRect = vmt_bind(g_VGuiSurface, 'void(__thiscall*)(void*, int, int, int, int)', 18)
    native_Surface.CreateNewTextureID = vmt_bind(g_VGuiSurface, "int(__thiscall*)(void*, bool)", 43)
    native_Surface.IsTextureIDValid = vmt_bind(g_VGuiSurface, "bool(__thiscall*)(void*, int)", 42)
    native_Surface.FontCreate = vmt_bind(g_VGuiSurface, 'unsigned long(__thiscall*)(void*)', 71)
    native_Surface.SetFontGlyphSet = vmt_bind(g_VGuiSurface, 'void(__thiscall*)(void*, unsigned long, const char*, int, int, int, int, unsigned long, int, int)', 72)
    native_Surface.GetTextSize = vmt_bind(g_VGuiSurface, 'void(__thiscall*)(void*, unsigned long, const wchar_t*, int&, int&)', 79)
    native_Surface.DrawSetTextColor = vmt_bind(g_VGuiSurface, 'void(__thiscall*)(void*, int, int, int, int)', 25)
    native_Surface.DrawSetTextFont = vmt_bind(g_VGuiSurface, 'void(__thiscall*)(void*, unsigned long)', 23)
    native_Surface.DrawSetTextPos = vmt_bind(g_VGuiSurface, 'void(__thiscall*)(void*, int, int)', 26)
    native_Surface.DrawPrintText = vmt_bind(g_VGuiSurface, 'void(__thiscall*)(void*, const wchar_t*, int, int)', 28)
    native_Surface.DrawLine = vmt_bind(g_VGuiSurface, 'void(__thiscall*)(void*, int, int, int, int)', 19)
    native_Surface.DrawTexturedPolygon = vmt_bind(g_VGuiSurface, "void(__thiscall*)(void*, int, Vertex_t*, bool)", 106)
    native_Surface.DrawTexturedPolyLine = vmt_bind(g_VGuiSurface, "void(__thiscall*)(void*, const Vertex_t*, int)", 104)
    native_Surface.LimitDrawingArea = vmt_bind(g_VGuiSurface, "void(__thiscall*)(void*, int, int, int, int)", 147)
    native_Surface.GetDrawingArea = vmt_bind(g_VGuiSurface, "void(__thiscall*)(void*, int&, int&, int&, int&)", 146)

    local PrintText = function(text, localized)
        local size = 1024.0
        if localized then
            local char_buffer = charbuffer(size)
            ConvertUnicodeToAnsi(text, char_buffer, size)
        
            return native_Surface.DrawPrintText(text, #ffi.string(char_buffer), 0)
        else
            local wide_buffer = new_widebuffer(size)
        
            ConvertAnsiToUnicode(text, wide_buffer, size)
            return native_Surface.DrawPrintText(wide_buffer, #text, 0)
        end
    end

    local font_cache = {}

    local Cast_m_bClippingEnabled = ffi.cast('int*', VGUI_Surface031 + 0x280)

    local clipCache = {
        x = new_intptr(),
        y = new_intptr(),
        x1 = new_intptr(),
        y1 = new_intptr(),
    }


    return native_Surface, Cast_m_bClippingEnabled, clipCache, PrintText, font_cache, ConvertAnsiToUnicode
end)()
local urlmon = ffi.load 'UrlMon'
local wininet = ffi.load 'WinInet'
local gdi = ffi.load 'Gdi32'

local g_VGuiSurface = ffi.cast(ffi.typeof("void***"), utils.create_interface("vguimatsurface.dll", "VGUI_Surface031"))
local native_Surface_DrawSetColor = ffi.cast(ffi.typeof("void(__thiscall*)(void*, int, int, int, int)"), g_VGuiSurface[0][15])
local native_Surface_DrawFilledRectFade = ffi.cast(ffi.typeof("void(__thiscall*)(void*, int, int, int, int, unsigned int, unsigned int, bool)"), g_VGuiSurface[0][123])
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

EFontFlags = ffi.typeof([[
    enum {
	    NONE,
	    ITALIC			= 0x001,
	    UNDERLINE		= 0x002,
	    STRIKEOUT		= 0x004,
	    SYMBOL			= 0x008,
	    ANTIALIAS		= 0x010,
	    GAUSSIANBLUR		= 0x020,
	    ROTARY			= 0x040,
	    DROPSHADOW		= 0x080,
	    ADDITIVE		= 0x100,
	    OUTLINE		= 0x200,
	    CUSTOM			= 0x400,
    }
]])

local FindHudElement = function(name)
    local pThis = ffi.cast(ffi.typeof("DWORD**"), utils.find_signature("client.dll", "B9 ? ? ? ? 68 ? ? ? ? E8 ? ? ? ? 89 46 24") + 1)[0]

    local find_hud_element = ffi.cast(ffi.typeof("DWORD(__thiscall*)(void*, const char*)"), utils.find_signature("client.dll", "55 8B EC 53 8B 5D 08 56 57 8B F9 33 F6 39 77 28"))

    return find_hud_element(pThis, name)
end

local fn_change_clantag = utils.find_signature("engine.dll", "53 56 57 8B DA 8B F9 FF 15")
local set_clantag = ffi.cast("clantag_t", fn_change_clantag)

local ModelInfo = ffi.cast(ffi.typeof("void***"), utils.create_interface("engine.dll", "VModelInfoClient004"))
local GetStudioModel = ffi.cast(ffi.typeof("studiohdr_t*(__thiscall*)(void*, model_t*)"), ModelInfo[0][32])

local IClientEntityList = ffi.cast(ffi.typeof("void***"), utils.create_interface("client.dll", "VClientEntityList003"))
local GetHighestEntityIndex = ffi.cast(ffi.typeof("int(__thiscall*)(void*)"), IClientEntityList[0][6])
local GetClientEntity = ffi.cast(ffi.typeof("unsigned long(__thiscall*)(void*, int)"), IClientEntityList[0][3])

local Typeof_tbl = {
    ClientRenderable = ffi.typeof("void***"),
    GetModel = ffi.typeof("model_t*(__thiscall*)(void*)"),
    SetupBones = ffi.typeof("bool(__thiscall*)(void*, matrix3x4_t* pBoneToWorldOut, int nMaxBones, int boneMask, float currentTime)")
}

local ClientRenderable_tbl = {}

function vector:add(a)
    return vector.new(self.x + a.x, self.y + a.y, self.z + a.z)
  end
  
function vector:divide(a)
  return vector.new(self.x / a, self.y / a, self.z / a)
end

local pHitboxSet = function(i, stdmdl)
    if i < 0 or i > stdmdl.numhitboxsets then return nil end
    return ffi.cast("mstudiohitboxset_t*", ffi.cast("byte*", stdmdl) + stdmdl.hitboxsetindex) + i
end
  
local pHitbox = function(i, stdmdl)
  if i > stdmdl.numhitboxes then return nil end
  return ffi.cast("mstudiobbox_t*", ffi.cast("byte*", stdmdl) + stdmdl.hitboxindex) + i
end
  
local DotProduct = function(a, b)
  return a.x * b.x + a.y * b.y + a.z * b.z
end
  
local VectorTransform = function(in1, in2)
  return vector.new(
      DotProduct(in1, vector.new(in2[0][0], in2[0][1], in2[0][2])) + in2[0][3],
      DotProduct(in1, vector.new(in2[1][0], in2[1][1], in2[1][2])) + in2[1][3],
      DotProduct(in1, vector.new(in2[2][0], in2[2][1], in2[2][2])) + in2[2][3]
  )
end

fs = {}
misc = {}
sengine = {}
input = {}
draw = {}
panorama = panoramalib()
entlist = {}
memory = memorylib()
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

sengine.set_clantag = function(clantag)
    return set_clantag(clantag, clantag)
end

--- SOURCE ENGINE END ---

--- DRAW START ---

draw.set_clip = function (x,y,w,h)
    Cast_m_bClippingEnabled[0] = true
    native_Surface.GetDrawingArea(clipCache.x, clipCache.y, clipCache.x1, clipCache.y1)
    native_Surface.LimitDrawingArea(x,y,x + w,y + h)
end

draw.end_clip = function ()
    native_Surface.LimitDrawingArea(clipCache.x[0], clipCache.y[0], clipCache.x1[0], clipCache.y1[0])
    Cast_m_bClippingEnabled[0] = false
end

draw.line = function(x0, y0, x1, y1, r, g, b, a)
	native_Surface.DrawSetColor(r, g, b, a)
	return native_Surface.DrawLine(x0, y0, x1, y1)
end

draw.rect = function(x, y, w, h, r, g, b, a)
	native_Surface.DrawSetColor(r, g, b, a)
	return native_Surface.DrawOutlinedRect(x, y, x + w, y + h)
end

draw.filled_rect = function(x, y, w, h, r, g, b, a)
    native_Surface.DrawSetColor(r, g, b, a)
    return native_Surface.DrawFilledRect(x, y, x + w, y + h)
end

draw.gradientrect = function(x, y, w, h, r0, g0, b0, a0, r1, g1, b1, a1, horizontal)
    native_Surface.DrawSetColor(r0, g0, b0, a0)
    native_Surface.DrawFilledRectFade(x, y, x + w, y + h, 255, 0, horizontal)
    native_Surface.DrawSetColor(r1, g1, b1, a1)
    return native_Surface.DrawFilledRectFade(x, y, x + w, y + h, 0, 255, horizontal)
end

draw.polygon = function(vertices, clipvertices, r, g, b, a)
    local a = a or 255
    local numvert = #vertices
    local buf = new_vert(numvert)
    local i = 0
    for k,v in pairs(vertices) do
        local vec = new_vec2()
        vec.x, vec.y = v.x, v.y
        buf[i].m_Position = vec
        buf[i].m_TexCoord = zerovec
        i = i + 1
    end
    native_Surface.DrawSetColor(r, g, b, a)
    native_Surface.DrawSetTexture(-1)
    native_Surface.DrawTexturedPolygon(numvert, buf, clipvertices)
end

draw.polyline = function(vertices, r, g, b, a)
    local a = a or 255
    local numvert = #vertices
    local buf = new_vert(numvert)
    local i = 0
    for k,v in pairs(vertices) do
        local vec = new_vec2()
        vec.x, vec.y = v.x, v.y
        buf[i].m_Position = vec
        buf[i].m_TexCoord = zerovec
        i = i + 1
    end
    native_Surface.DrawSetColor(r, g, b, a)
    native_Surface.DrawSetTexture(-1)
    native_Surface.DrawTexturedPolyLine(buf, numvert)
end

draw.init_rgba = function(data, w, h)
    local returntbl = {}
    local tid = native_Surface.CreateNewTextureID(true)
    if not tid or not native_Surface.IsTextureIDValid(tid) or not data then return end
    native_Surface.DrawSetTextureRGBA(tid, data, w, h)
    returntbl.tid = tid
    returntbl.data = data
    return returntbl
end

draw.rgba = function(datatbl, x, y, w, h, alpha)
    local tid = datatbl.tid
    native_Surface.DrawSetColor(255,255,255,alpha)
    native_Surface.DrawSetTexture(tid)
    --native_Surface.DrawSetTextureRGBA(g_VGuiSurface, tid, data, w, h)
    return native_Surface.DrawTexturedRect(x, y, x + w, y + h)
end

draw.init_font = function(name, h, weight, blur, flags)
	local flags_i = 0
	local t = type(flags)
	if t == "number" then
		flags_i = flags
	elseif t == "table" then
		for i = 1, #flags do
			flags_i = flags_i + flags[i]
		end
	else
		flags_i = 0x0
	end

	local cache_key = string.format("%s\0%d\0%d\0%d", name, h, weight, flags_i)
	if font_cache[cache_key] == nil then
		font_cache[cache_key] = native_Surface.FontCreate()
		native_Surface.SetFontGlyphSet(font_cache[cache_key], name, h, weight, blur, 0, flags_i, 0, 0)
	end

	return font_cache[cache_key]
end

draw.get_textsize = function(font, text)
	local wide_buffer = new_widebuffer(1024)
	local w_ptr = new_intptr()
	local h_ptr = new_intptr()

	ConvertAnsiToUnicode(text, wide_buffer, 1024)
	native_Surface.GetTextSize(font, wide_buffer, w_ptr, h_ptr)
    
	return vec2.new(tonumber(w_ptr[0]), tonumber(h_ptr[0]))
end

draw.text = function(font, x, y, r, g, b, a, text)
    native_Surface.DrawSetTextPos(x, y)
	native_Surface.DrawSetTextFont(font)
	native_Surface.DrawSetTextColor(r, g, b, a)
    return PrintText(text, false)
end

draw.text_centered = function(font, x, y, r, g, b, a, text, centered_x, centered_y)
	local text_size = draw.get_textsize(font, text)
	local x,y = x,y
	if centered_x then
		x = x - text_size.x / 2
	end
	if centered_y then
		y = y - text_size.y / 2
	end
    return draw.text(font,x,y,r,g,b,a,text)
end
--local native_Surface_DrawSetTextureRGBA = ffi.cast(ffi.typeof("void(__thiscall*)(void*, int, const unsigned char*, int, int)"), g_VGuiSurface[0][37])

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

entlist.find_by_class = function(class) -- Example: "CBasePlayer"
    for i=64, GetHighestEntityIndex(IClientEntityList) do
        local ent = entitylist.get_player_by_index(i)
        
        if ent ~= nil then
            if ent:get_class_name() == class then
                return ent
            end
        end
    end
end

entlist.get_player_resource = function()
    return entlist.find_by_class('CCSPlayerResource')
end

--- ENTITY LIST END ---

--- PLAYER START ---

function player:is_alive()
    if not self then return false end
    return self:get_health() > 0
end

function player:gethitboxpos(hitbox_id)
    local hitbox_id = hitbox_id or 0
    if not self or not self:is_alive() then return end

    local index = self:get_index()

    local matrix = ffi.new('matrix3x4_t[128]')
    if ClientRenderable_tbl[index] == nil then
        ClientRenderable_tbl[index] = {}
        ClientRenderable_tbl[index].ClientRenderable = ffi.cast(Typeof_tbl.ClientRenderable, GetClientEntity(IClientEntityList, index) + 0x4)
        ClientRenderable_tbl[index].GetModel = ffi.cast(Typeof_tbl.GetModel, ClientRenderable_tbl[index].ClientRenderable[0][8])
        ClientRenderable_tbl[index].SetupBones = ffi.cast(Typeof_tbl.SetupBones, ClientRenderable_tbl[index].ClientRenderable[0][13])
    end
    local sbool = ClientRenderable_tbl[index].SetupBones(ClientRenderable_tbl[index].ClientRenderable, matrix, 128, 0x0007FF00, globals.get_curtime())
    if not matrix or not sbool then return end

    local model = ClientRenderable_tbl[index].GetModel(ClientRenderable_tbl[index].ClientRenderable)

    if not model then return end

    local studio_model = GetStudioModel(ModelInfo, model)

    if not studio_model then return end

    local set = pHitboxSet( 0, studio_model)

    if not set then return end

    local hitbox = pHitbox(hitbox_id, set)

    if not hitbox then return end
    local mins = VectorTransform(hitbox.m_mins, matrix[hitbox.m_bone].m_flMatVal)
    local maxs = VectorTransform(hitbox.m_maxs, matrix[hitbox.m_bone].m_flMatVal)

    return mins:add(maxs):divide(2)
end

events.register_event( 'round_start', function() 
    ClientRenderable_tbl = {}
end)

--- PLAYER END ---