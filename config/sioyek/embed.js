#!/usr/bin/env node

/****************************************************************/
/* This uses Qt's JS engine. So native JS functions won't work. */
/****************************************************************/

sioyek_async.embed_annotations();
sioyek_async._extract_highlights();
sioyek_async.wait(1000);
sioyek_async.delete_all_highlights();
// sioyek_async.clear_current_document_drawings();
