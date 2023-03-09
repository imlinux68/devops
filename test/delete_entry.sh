#!/bin/bash
delete_entry() {
  echo "Enter name to delete:"
  read name

  # check name exists in file
  if ! grep -q "^$name," /project/record.collection
  then
    echo "Error: Name not found in file."
    echo "$(date +'%d/%m/%Y %H:%M:%S'): Deleting entry failed" >> /project/file.log
    return 1
  fi

  # Count num of records with a given name
  count=$(grep -c "^$name," /project/record.collection)

  # uf there is only one  ask the user to delete it
  if [[ $count -eq 1 ]]
  then
    echo "There is only one record with name '$name'"
    echo "Do you want to delete this record? (y/n)"
    read answer

    if [[ $answer == "y" ]]
    then
      sed -i "/^$name,/d" /project/record.collection
      echo "$(date +'%d/%m/%Y %H:%M:%S'): Entry deleted successfully" >> /project/file.log
      return 0
    else
      echo "Entry not deleted."
      echo "$(date +'%d/%m/%Y %H:%M:%S'): Entry delete Failed" >> /project/file.log
      return 1
    fi
  fi

  # if multiple records with the same name, ask which one to delete
  echo "There are $count records with name '$name'."
  echo "Choose entry to delete (1-$count):"

  # list of records with given name and their indices
  grep "^$name," /project/record.collection | nl -nln

  read index

  # Validate user input for index
  if [[ $index =~ ^[1-$count]$ ]]
  then
    sed -i "${index}d" /project/record.collection
    echo "$(date +'%d/%m/%Y %H:%M:%S'): Entry deleted successfully" >> /project/file.log
    return 0
  else
    echo "Invalid index. Entry not deleted."
    echo "$(date +'%d/%m/%Y %H:%M:%S'): Deleting entry Failed" >> /project/file.log
    return 1
  fi
}
