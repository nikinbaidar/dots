return {
    snippet("update", fmt([[
    UPDATE {}
    SET {} = {}
    WHERE {};
    ]], {
            i(1, "table"),
            i(2, "field"), 
            i(3, "value, field = value ..."), 
            i(4, "condition")
        }
    )), 
}



