return {
    snippet("load", fmt([[
    LOAD DATA LOCAL INFILE '{}'
    INTO TABLE {}
    FIELDS TERMINATED BY ',' ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    ({});
    ]], {
            i(1, "FILE"),
            i(2, "TABLE"),
            i(3, "COLUMNS"),
        }
    )), 
}



