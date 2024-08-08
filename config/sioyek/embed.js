let state = sioyek_api.get_json_state();

let path = state["document_path"];

let parts = path.split('/');
let file_name = parts[parts.length - 1];
let new_path = "/home/nikin/projects/AI-Paper-annotations/" + file_name;

sioyek.embed_annotations(new_path);
