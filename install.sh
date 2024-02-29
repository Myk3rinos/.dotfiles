# PS3="Enter a number: "

# select character in Sheldon Leonard Penny Howard Raj
# do
#     echo "Selected character: $character"
#     echo "Selected number: $REPLY"
# done

echo "------------------ starting ------------------"


createSymlinks() {
    if [ -f $1 ] || [ -r $1 ]; then # check if file exists
      rm ~/"$2""$1"
      ln -s $(pwd)/$1 ~/"$2""$1"
        echo "$1 config linked."
    else
        echo "WARNING: no $1 config found; can't link for now."
    fi
}

gitinit() { 
    echo "Do you want to connect to your github? (y/n)"
    select yn in "Yes" "No"; do
        case $yn in
            # No ) exit;;
            Yes ) gh auth login; break;;
            No ) break;;
        esac
    done

}

filesToLinkInHome=(.zshrc .themes)
filesToLinkInConfig=( yazi kitty nvim neofetch starship.toml)

echo "------------------ create symlinks ------------------" 
for file in "${filesToLinkInHome[@]}"; do
   createSymlinks $file ""
done
for file in "${filesToLinkInConfig[@]}"; do
   createSymlinks $file ".config/"
done
echo "------------- creation off symlink done -------------" 

echo "------------------ finished ------------------"
