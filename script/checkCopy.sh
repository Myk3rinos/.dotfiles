

checkIfCopyOk() {
  destinationInfo=$(du -sb $1 | cut -f1 )
  originalInfo=$(du -sb $2 | cut -f1)
  if [[ $destinationInfo -eq $originalInfo ]];
  then
    echo -e "$colorG $2: $originalInfo b $colorEnd"
  else
    echo -e "$colorB $2: $originalInfo b  is not the same ! $colorEnd"
  fi
}

