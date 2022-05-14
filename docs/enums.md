## EFontFlags
    NONE       
    ITALIC		 
    UNDERLINE	 
    STRIKEOUT	 
    SYMBOL		 
    ANTIALIAS	 
    GAUSSIANBLUR 
    ROTARY		 
    DROPSHADOW	 
    ADDITIVE	 
    OUTLINE		 
    CUSTOM		 
    
Example:
    ```lua
    local font = draw.init_font('Verdana', 12, 12, 0, {EFontFlags('DROPSHADOW')})
    ```