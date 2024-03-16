#!/bin/sh

echo $(sensors | grep -A 2 '^acpitz-acpi-0' | cut -c15-19 | grep -A 2 '+' | cut -c2-5)
