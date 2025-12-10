import os
import sqlite3
from collections import Counter

def analyze_backup(backup_path):
    db_path = os.path.join(backup_path, 'Manifest.db')
    if not os.path.exists(db_path):
        print(f"Erreur : La base de données Manifest.db n'a pas été trouvée dans {backup_path}")
        return

    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()

    query = "SELECT relativePath FROM Files"
    cursor.execute(query)

    file_extensions = Counter()
    for row in cursor.fetchall():
        relative_path = row[0]
        if relative_path:
            ext = os.path.splitext(relative_path)[1].lower()
            if ext:
                file_extensions[ext] += 1

    conn.close()

    print("Analyse de la sauvegarde terminée. Voici un résumé des types de fichiers trouvés :")
    for ext, count in file_extensions.most_common(20):
        print(f"- {ext}: {count} fichiers")

if __name__ == '__main__':
    backup_folder = '00008101-000164583EE0001E'
    analyze_backup(backup_folder)
