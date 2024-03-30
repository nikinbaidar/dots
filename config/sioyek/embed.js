
let state = sioyek_api.get_json_state();

let path = state["document_path"];

sioyek.embed_annotations(path);

