

checkIfCopyOk() {
  destinationInfo=$(du -sb $1 | cut -f1 )
  originalInfo=$(du -sb $2 | cut -f1)
  if [[ $destinationInfo -eq $originalInfo ]];
  then
    echo -e "$2: $colorG $originalInfo b $colorEnd"
  else
    echo -e "$2: $colorB $originalInfo b  is not the same ! $colorEnd"
  fi
}

