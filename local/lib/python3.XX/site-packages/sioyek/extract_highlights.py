import os
import subprocess
import sys
import sqlite3
import pathlib
from .sioyek import Sioyek, clean_path
from datetime import datetime, timedelta

LOCAL_DATABASE_FILE = None
SHARED_DATABASE_FILE = None
SIOYEK_PATH = None

os.system("clear")


def extract_highlights(sioyek_path, local_database, shared_database, file_path, clean_up):
    sioyek = Sioyek(sioyek_path, local_database, shared_database)
    with sqlite3.connect(local_database):
        doc_path = clean_path(file_path)
        doc_dir = os.path.join(os.path.expanduser("~"), "notes/highlights")
        doc_base_file_name = os.path.splitext(os.path.basename(doc_path))[0]
        new_file_name = f"{doc_base_file_name}.md"
        new_file_path = str(pathlib.Path(doc_dir) / new_file_name).replace('\\', '/')
        highlights = sioyek.get_document(doc_path).get_highlights_with_time_stamps()

        if highlights:
            cmd = f"grep -oP '\\d{{4}}-\\d{{2}}-\\d{{2}} \\d{{2}}:\\d{{2}}:\\d{{2}}' '{new_file_path}' | tail -1"
            result = subprocess.run(cmd, shell=True, check=True, text=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            date_format = "%Y-%m-%d %H:%M:%S"
            most_recent_extraction = None

            try:
                date_string = result.stdout.strip()
                most_recent_extraction = datetime.strptime(date_string, date_format)
            except ValueError as error:
                pass

            current_datetime = f"\n<!-- {datetime.now().strftime(date_format)} -->\n\n"
            delta = timedelta(hours=5, minutes=45)

            document_highlights = [(datetime.strptime(x[5], date_format), x[4], x[2]) for x in highlights]
            filtered_highlights = [ (item[1], item[2]) for item in document_highlights
                if most_recent_extraction is None or (item[0] + delta) > most_recent_extraction ]

            if filtered_highlights:
                with open(new_file_path, 'a') as file:
                    file.write(current_datetime)
                    print(current_datetime)
                    for highliht_type, text in filtered_highlights:
                        pattern = f"[{highliht_type}] {text}\n\n"
                        print(pattern)
                        file.write(pattern)


def main():
    if len(sys.argv) > 1:
        global SIOYEK_PATH, LOCAL_DATABASE_FILE
        SIOYEK_PATH = clean_path(sys.argv[1])
        LOCAL_DATABASE_FILE = clean_path(sys.argv[2])
        SHARED_DATABASE_FILE = clean_path(sys.argv[3])
        file_path = clean_path(sys.argv[4])
        clean_up = bool(int(sys.argv[5]))
        extract_highlights(SIOYEK_PATH, LOCAL_DATABASE_FILE,
                           SHARED_DATABASE_FILE, file_path, clean_up)


if __name__ == '__main__':
    main()
