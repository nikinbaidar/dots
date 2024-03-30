let state = sioyek_api.get_json_state();

let path = state["document_path"];
let parts = path.split('/');
let file_name = parts[parts.length - 1];
let file_name_parts = file_name.split('.');
let new_name = file_name_parts[0] + "_embedded." + file_name_parts[1];
let new_path = parts.slice(0, parts.length - 1).join('/') + '/' + new_name;
sioyek.embed_annotations(new_path);
