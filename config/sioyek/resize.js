// https://github.com/ahrm/sioyek/issues/938#issuecomment-1912180571

let prev_width = sioyek_api.get_variable('width');
let current_width = sioyek_api.get_json_state()["window_width"];
sioyek_api.set_variable('width', current_width);

if (prev_width != undefined){
    if (current_width > prev_width){
        sioyek.fit_to_page_width_ratio();
    }
    else{
        sioyek.fit_to_page_width();
    }
}
