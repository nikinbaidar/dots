return {

    s("mkhelp", fmt([[
    display_help() {{
        cat << 'EOF'
    {}

    Usage:
    {} 

    Options:
    {}
    EOF
    }}
    ]] , {
        i(1),
        i(2),
        i(3),
    })),

}
