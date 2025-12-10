import os
import sys
from datetime import datetime
import piexif

def update_metadata(output_path):
    """
    Met à jour les métadonnées EXIF des images dans un dossier.
    """
    if not os.path.exists(output_path):
        print(f"Erreur : Le dossier {output_path} n'existe pas.")
        return

    for filename in os.listdir(output_path):
        if filename.lower().endswith(('.jpg', '.jpeg')):
            file_path = os.path.join(output_path, filename)
            
            try:
                print(f"Mise à jour des métadonnées pour {filename}")
                creation_date = datetime.fromtimestamp(os.path.getmtime(file_path))
                date_str = creation_date.strftime('%Y:%m:%d %H:%M:%S')

                try:
                    exif_dict = piexif.load(file_path)
                except Exception:
                    exif_dict = {"0th": {}, "Exif": {}, "GPS": {}, "1st": {}, "thumbnail": None}

                if piexif.ExifIFD.DateTimeOriginal not in exif_dict['Exif']:
                    exif_dict['Exif'][piexif.ExifIFD.DateTimeOriginal] = date_str.encode('utf-8')

                exif_bytes = piexif.dump(exif_dict)
                piexif.insert(exif_bytes, file_path)
                print(f"  - Métadonnées mises à jour avec la date : {date_str}")

            except Exception as e:
                print(f"  - ERREUR lors de la mise à jour de {filename}: {e}")

    print("Mise à jour des métadonnées terminée.")

if __name__ == '__main__':
    if len(sys.argv) != 2:
        print("Usage: python3 update_metadata.py <chemin_dossier_photos>")
        sys.exit(1)
    
    output_folder = sys.argv[1]
    update_metadata(output_folder)
