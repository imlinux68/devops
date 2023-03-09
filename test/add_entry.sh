function add_entry {
  # ask for name and valid
  read -p "Enter the name: " name
  if [[ ! $name =~ ^[a-zA-Z]+$ ]]
   then
    echo "bad name. Only letters"
    echo "$(date +'%d/%m/%Y %H:%M:%S'): Add entry failed. Invalid name" >> /project/file.log
    return
  fi

  # ask user fot the amount and validate it
  read -p "Enter the amount: " amount
  if [[ ! $amount =~ ^[0-9]+$ ]]
   then
    echo "bad amount. Only numbers"
    echo "$(date +'%d/%m/%Y %H:%M:%S'): Add entry failed. Invalid amount" >> /project/file.log
    return
  fi

  # check if if the name already exists
  if grep -q "^${name}, " /project/record.collection
   then
    echo "An entry with such already exists"
    echo "$(date +'%d/%m/%Y %H:%M:%S'): Add entry failed, entry with this name exists" >> /project/file.log
    return
  fi

  # Add the entry to the file
  echo "${name},${amount}" >> /project/record.collection
  echo "Entry added: ${name},${amount}"

  # logging the success
  echo "$(date +'%d/%m/%Y %H:%M:%S'): add entry success" >> /project/file.log
}

