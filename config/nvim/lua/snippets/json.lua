return {
    snippet({trig = "obj", regTrig = true}, fmt([[
    {{
        "name": "{}",
        "category": "A",
        "options": [
            "{}",
            "{}",
            "{}",
            "{}"
        ],
        "ansKey": 2 
    }},
    ]], {
        i(1, "Question"),
        i(2, "A"),
        i(3, "B"),
        i(4, "C"),
        i(5, "D"),
    })),
}
