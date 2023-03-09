change_amount() {
  echo "Enter the name of the entry to change the amount: "
  read name

  # Check if the name exists in the record collection
  if ! grep -q "^$name," "/project/record.collection"
  then
    echo "Error: Entry not found in collection"
    echo "$(date +'%d/%m/%Y %H:%M:%S'): - Error: Entry '$name' not found in collection" >> "/project/file.log"
    return 1
  fi

  # Count the number of entries with the same name
  count=$(grep -c "^$name," "/project/record.collection")

  # If there is only one entry, change its amount directly
  if [[ $count -eq 1 ]]
  then
    echo "Enter the new amount for '$name':"
    read amount
    if [[ $amount -lt 0 ]]
    then
      echo "Error: Amount cannot be negative."
      echo "$(date +'%d/%m/%Y %H:%M:%S'): - Error: Amount for entry '$name' cannot be negative" >> "/project/file.log"
      return 1
    fi
    sed -i "s/^$name,[[:digit:]]\+/$name, $amount/" "/project/record.collection"
    echo "Amount for '$name' changed to '$amount'."
    echo "$(date +'%d/%m/%Y %H:%M:%S'): - Amount for entry '$name' changed to '$amount'" >> "/project/file.log"
    return 0
  fi

  # If there are multiple entries with the same name, ask the user to select one
  echo "There are several entries with the name '$name'. Please select one to change the amount: "
  grep "^$name," "/project/record.collection" | nl -nln
  read selection
  while [[ $selection -lt 1 ]] || [[ $selection -gt $count ]]
  do
    echo "Invalid selection. Please enter a number between 1 and $count: "
    read selection
  done

  # Change the amount for the selected entry
  entry=$(grep "^$name," "/project/record.collection" | sed -n "${selection}p")
  current_amount=$(echo "$entry" | cut -d ',' -f 2)
  echo "Enter the new amount for '$name' (current amount: $current_amount): "
  read amount
  if [[ $amount -lt 0 ]]
  then
    echo "Error: Amount cannot be negative."
    echo "$(date +'%d/%m/%Y %H:%M:%S'): - Error: Amount for entry '$name' cannot be negative" >> "/project/file.log"
    return 1
  fi
  sed -i "s/$entry/$name,$amount/" "/project/record.collection"
  echo "Amount for '$name' changed to '$amount'."
  echo "$(date +'%d/%m/%Y %H:%M:%S'): - Amount for entry '$name' changed to '$amount'" >> "/project/file.log"
  return 0
}

