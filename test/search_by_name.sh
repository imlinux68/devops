#!/bin/bash

function search_by_name {
  # check if file exists and is not empty(?)
  if [[ -s /project/record.collection ]]
   then
    echo "Enter name to search: "
    read name

    # lokk for records by name
    records=$(grep -i "^$name," /project/record.collection)

    # check if any records were found
    if [[ -n $records ]]; then
      # Sort records by name
      sorted_records=$(echo "$records" | sort -t',' -k1)

      # print sorted records
      echo "$sorted_records"

      # search results to log file
      echo "$(date +'%d/%m/%Y %H:%M:%S'): Search by name for '$name': " >> /project/file.log
      echo "$(date +'%d/%m/%Y %H:%M:%S'): $sorted_records" >> /project/file.log
    else
      # No records found
      echo "No records found for '$name' "

      # error to log file
      echo "$(date +'%d/%m/%Y %H:%M:%S'): search by name FFFFailed: no records found for '$name'" >> /project/file.log
    fi
  else
    # if fle is empty or does not exist
    echo "$(date +'%d/%m/%Y %H:%M:%S'): Error: /project/record.collection is empty or does not exist"

    # Write error to log file
    echo "$(date +'%d/%m/%Y %H:%M:%S'): search by name Failed: /project/record.collection is empty or does not exist" >> /project/file.log
  fi

  # Return to main menu
   sleep 3;
  source menu.sh
}
