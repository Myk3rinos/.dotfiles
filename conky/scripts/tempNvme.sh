sensors | grep -A 2 '^nvme-pci-0200' | cut -c15-19 | grep -A 2 '+' | cut -c2-5
