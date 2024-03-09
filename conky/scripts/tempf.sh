sensors | grep -A 2 '^coretemp-isa-0000' | cut -c16-20 | grep -A 2 '+' | cut -c2-5
