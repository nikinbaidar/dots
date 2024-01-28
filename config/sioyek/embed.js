#!/usr/bin/env node
sioyek.embed_annotations();
sioyek._extract_highlights();
sioyek_async.wait(1000);
sioyek.delete_all_highlights();
