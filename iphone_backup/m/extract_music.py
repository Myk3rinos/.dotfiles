import os
import sqlite3
import shutil
import sys

def extract_music(backup_path, output_path):
    """
    Extrait les fichiers MP3 d'une sauvegarde iPhone.
    """
    db_path = os.path.join(backup_path, 'Manifest.db')
    if not os.path.exists(db_path):
        print(f"Erreur : La base de données Manifest.db n'a pas été trouvée dans {backup_path}")
        return

    if not os.path.exists(output_path):
        os.makedirs(output_path)

    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()

    # Requête pour trouver les fichiers .mp3
    query = """
    SELECT
        fileID,
        relativePath
    FROM
        Files
    WHERE
        relativePath LIKE '%.mp3'
    """

    cursor.execute(query)
    
    print("Début de l'extraction des fichiers MP3...")
    found_files = 0

    for row in cursor.fetchall():
        file_id, relative_path = row
        found_files += 1
        
        backup_file_path = os.path.join(backup_path, file_id[:2], file_id)
        
        if os.path.exists(backup_file_path):
            try:
                output_filename = os.path.basename(relative_path)
                if not output_filename:
                    output_filename = file_id

                output_file_path = os.path.join(output_path, output_filename)
                
                print(f"Copie de {output_filename} vers {output_path}")
                shutil.copy2(backup_file_path, output_file_path)
            except Exception as e:
                print(f"Erreur lors du traitement du fichier {relative_path}: {e}")
        else:
            print(f"Fichier source non trouvé pour {relative_path} ({backup_file_path})")

    conn.close()
    
    if found_files == 0:
        print("Aucun fichier MP3 trouvé dans la base de données.")
    else:
        print(f"Extraction terminée. {found_files} fichiers MP3 traités.")

if __name__ == '__main__':
    if len(sys.argv) != 3:
        print("Usage: python3 extract_music.py <chemin_sauvegarde> <chemin_sortie_musique>")
        sys.exit(1)
    
    backup_folder = sys.argv[1]
    output_folder = sys.argv[2]
    
    extract_music(backup_folder, output_folder)
