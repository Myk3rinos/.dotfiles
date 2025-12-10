import os
import shutil
import sys

def add_to_itunes(music_source_path):
    # Determine the path to the "Automatically Add to iTunes" folder
    if sys.platform == "darwin":  # macOS
        itunes_folder = os.path.expanduser("~/Music/iTunes/iTunes Media/Automatically Add to iTunes")
    elif sys.platform == "win32":  # Windows
        itunes_folder = os.path.join(os.environ['USERPROFILE'], 'Music', 'iTunes', 'iTunes Media', 'Automatically Add to iTunes')
    else:
        print("Operating system not supported for this script.")
        return

    # Check if the iTunes folder exists
    if not os.path.isdir(itunes_folder):
        print(f"Error: The 'Automatically Add to iTunes' folder was not found at:")
        print(itunes_folder)
        print("Please ensure iTunes or the Music app is installed and has been run at least once.")
        # Optional: try to create it, though it's better if the app does it.
        # try:
        #     os.makedirs(itunes_folder)
        #     print("Created 'Automatically Add to iTunes' folder.")
        # except OSError as e:
        #     print(f"Could not create the folder: {e}")
        #     return
        return

    # Copy files from the source folder to the iTunes folder
    print(f"Adding files from '{music_source_path}' to the iTunes/Music library...")
    
    copied_count = 0
    for filename in os.listdir(music_source_path):
        source_file = os.path.join(music_source_path, filename)
        if os.path.isfile(source_file):
            try:
                shutil.copy(source_file, itunes_folder)
                print(f"  -> Added: {filename}")
                copied_count += 1
            except Exception as e:
                print(f"Error copying {filename}: {e}")

    print(f"\nFinished. {copied_count} files were moved to the queue.")
    print("Please open iTunes or the Music app to complete the import.")

if __name__ == '__main__':
    if len(sys.argv) != 2:
        print(f"Usage: python3 {sys.argv[0]} <path_to_your_music_folder>")
        sys.exit(1)
    
    music_folder = sys.argv[1]
    if not os.path.isdir(music_folder):
        print(f"Error: The specified source folder does not exist: '{music_folder}'")
        sys.exit(1)
        
    add_to_itunes(music_folder)