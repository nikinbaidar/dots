return {

    snippet("sec", fmt("## {}",  {
        i(1, "Section")
    })),

    snippet("sub", fmt("### {}", {
        i(1, "Sub Section") 
    })),

    snippet("link", fmt("[{}]({})", {
        i(1, "Anchor"),
        i(2, "URL")
    })),


}
