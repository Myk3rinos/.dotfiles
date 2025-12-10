import os
import sqlite3
import shutil
import sys
from datetime import datetime
import piexif

def remove_empty_folders(path):
    """
    Supprime les dossiers vides, à l'exception de ceux contenant des fichiers cachés.
    """
    print("Suppression des dossiers vides...")
    for root, dirs, files in os.walk(path, topdown=False):
        for name in dirs:
            dir_path = os.path.join(root, name)
            # Vérifie si le dossier est vide ou ne contient que des fichiers cachés
            if not os.listdir(dir_path) or all(f.startswith('.') for f in os.listdir(dir_path)):
                try:
                    os.rmdir(dir_path)
                    print(f"Dossier vide supprimé : {dir_path}")
                except OSError as e:
                    print(f"Erreur lors de la suppression de {dir_path}: {e}")

def analyze_and_extract(backup_path, output_path):
    """
    Analyzes an iPhone backup, extracts all files, organizes them by type,
    and updates image metadata.
    """
    db_path = os.path.join(backup_path, 'Manifest.db')
    if not os.path.exists(db_path):
        print(f"Error: Database Manifest.db not found in {backup_path}")
        return

    print("Connecting to the backup database...")
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()

    query = "SELECT fileID, relativePath FROM Files"
    try:
        cursor.execute(query)
        files_to_process = cursor.fetchall()
        print(f"Found {len(files_to_process)} files to process.")
    except sqlite3.Error as e:
        print(f"Error reading database: {e}")
        conn.close()
        return

    # Create the main output directory if it doesn't exist
    if not os.path.exists(output_path):
        os.makedirs(output_path)

    # --- Extraction Phase ---
    print("\nStarting file extraction and organization...")
    for file_id, relative_path in files_to_process:
        # Sanitize relative_path to handle potential invalid characters
        safe_relative_path = relative_path.replace(':', '_').replace('?', '_')
        
        # Determine the file extension and create the corresponding subdirectory
        ext = os.path.splitext(safe_relative_path)[1][1:].lower()
        if not ext:
            ext = "no_extension"
        
        target_dir = os.path.join(output_path, ext)
        if not os.path.exists(target_dir):
            os.makedirs(target_dir)

        # Construct source and destination paths
        source_path = os.path.join(backup_path, file_id[:2], file_id)
        dest_filename = os.path.basename(safe_relative_path)
        dest_path = os.path.join(target_dir, dest_filename)

        if os.path.exists(source_path):
            try:
                shutil.copy2(source_path, dest_path)
                # print(f"Copied: {dest_path}") # This can be very verbose
            except Exception as e:
                print(f"Error copying {source_path} to {dest_path}: {e}")
        else:
            print(f"Warning: Source file not found for {relative_path} at {source_path}")

    conn.close()
    print("File extraction and organization complete.")

    # --- Metadata Update Phase ---
    print("\nStarting metadata update for image files...")
    for root, _, files in os.walk(output_path):
        for filename in files:
            if filename.lower().endswith(('.jpg', '.jpeg')):
                file_path = os.path.join(root, filename)
                try:
                    # Use file's modification time for EXIF date
                    mtime = os.path.getmtime(file_path)
                    date_str = datetime.fromtimestamp(mtime).strftime('%Y:%m:%d %H:%M:%S')

                    try:
                        exif_dict = piexif.load(file_path)
                    except (piexif.InvalidImageDataError, ValueError):
                        # If no EXIF data, create a new structure
                        exif_dict = {"0th": {}, "Exif": {}, "GPS": {}, "1st": {}, "thumbnail": None}

                    # Update the DateTimeOriginal tag
                    exif_dict['Exif'][piexif.ExifIFD.DateTimeOriginal] = date_str.encode('utf-8')
                    
                    # Write the updated EXIF data back to the file
                    piexif.insert(piexif.dump(exif_dict), file_path)
                    # print(f"Updated metadata for: {filename}")
                except Exception as e:
                    print(f"Error updating metadata for {filename}: {e}")
    
    print("Metadata update complete.")

    # --- Cleanup Phase ---
    remove_empty_folders(output_path)

    print("\nAll operations finished!")


if __name__ == '__main__':
    if len(sys.argv) != 3:
        print("Usage: python3 organize_backup.py <path_to_backup_folder> <path_to_output_folder>")
        sys.exit(1)
    
    backup_folder = sys.argv[1]
    output_folder = sys.argv[2]
    
    analyze_and_extract(backup_folder, output_folder)