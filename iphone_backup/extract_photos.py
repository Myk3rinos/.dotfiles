import os
import sqlite3
import shutil
import sys
from datetime import datetime

def extract_photos(backup_path, output_path):
    """
    Extrait les photos d'une sauvegarde iPhone et les organise par date.

    :param backup_path: Chemin vers le dossier de la sauvegarde de l'iPhone.
    :param output_path: Chemin vers le dossier de sortie pour les photos.
    """
    db_path = os.path.join(backup_path, 'Manifest.db')
    if not os.path.exists(db_path):
        print(f"Erreur : La base de données Manifest.db n'a pas été trouvée dans {backup_path}")
        return

    if not os.path.exists(output_path):
        os.makedirs(output_path)

    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()

    query = """
    SELECT
        fileID,
        domain,
        relativePath,
        file
    FROM
        Files
    WHERE
        domain = 'CameraRollDomain' AND (relativePath LIKE '%.JPG' OR relativePath LIKE '%.PNG' OR relativePath LIKE '%.HEIC')
    """

    cursor.execute(query)

    for row in cursor.fetchall():
        file_id, domain, relative_path, file_info = row
        
        # Le nom du fichier dans la sauvegarde est basé sur le fileID
        backup_file_path = os.path.join(backup_path, file_id[:2], file_id)
        
        if os.path.exists(backup_file_path):
            try:
                # Essayer d'extraire la date de la structure du fichier si possible
                # Ceci est un exemple, la méthode d'extraction de la date peut varier
                # Pour cet exemple, nous utilisons la date de modification du fichier comme fallback
                creation_date = datetime.fromtimestamp(os.path.getmtime(backup_file_path))
                date_str = creation_date.strftime('%Y-%m-%d')
                
                # Créer un nom de fichier plus descriptif
                new_filename = f"{date_str}_{os.path.basename(relative_path)}"
                output_file_path = os.path.join(output_path, new_filename)
                
                print(f"Copie de {relative_path} vers {output_file_path}")
                shutil.copy2(backup_file_path, output_file_path)
            except Exception as e:
                print(f"Erreur lors du traitement du fichier {relative_path}: {e}")

    conn.close()
    print("Extraction des photos terminée.")

if __name__ == '__main__':
    if len(sys.argv) != 3:
        print("Usage: python3 extract_photos.py <chemin_sauvegarde> <chemin_sortie>")
        sys.exit(1)
    
    backup_folder = sys.argv[1]
    output_folder = sys.argv[2]
    
    extract_photos(backup_folder, output_folder)
