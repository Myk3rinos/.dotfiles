#!/bin/sh

echo $(sensors | grep -A 2 '^acpitz-acpi-0' | cut -c15-19 | grep -A 2 '+' | cut -c2-3)
# temp2=$(sensors | grep -A 2 '^acpitz-acpi-0' | cut -c15-19 | grep -A 2 '+' | cut -c2-5)

# if [ $temp -gt 0 ]
# then
   # printf $temp
   # echo $temp
  # echo -e "\e[31mRed Text\e[0m"
# fi

