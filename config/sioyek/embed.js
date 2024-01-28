#!/usr/bin/env node
sioyek_async.embed_annotations();
sioyek_async._extract_highlights();
sioyek_async.wait(1000);
sioyek_async.delete_all_highlights();
