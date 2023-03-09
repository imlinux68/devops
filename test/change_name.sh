#!/bin/bash
function change_name {
    read -p "Enter the name of the record you want to change: " old_name
    # check if the record exists
    if ! grep -q "^$old_name," /project/record.collection
     then
        echo "Record not found"
        echo "$(date +'%d/%m/%Y %H:%M:%S') - Change name failed: record not found" >> /project/file.log
        return
    fi
    
    # get all  same names While
    grep "^$old_name," /project/record.collection > /tmp/temp_file
    num_records=$(wc -l < /tmp/temp_file)
    
    # if there is only one entry, change the name directly
    if [[ $num_records -eq 1 ]]
     then
        read -p "Enter the new name: " new_name
        sed -i "s/^$old_name,/$new_name,/" /project/record.collection
        echo "Name changed successfully"
        echo "$(date +'%d/%m/%Y %H:%M:%S') - Name for record $old_name changed to $new_name" >> /project/file.log
        return
    fi
    
    # if there are multiple entries, show the user a menu to choose from
    echo "Choose the record you want to change:"
    awk '{print NR ". " $0}' /tmp/temp_file
    read -p "Enter the number of the record: " choice
    # check if the choice is a valid number
    if ! [[ "$choice" =~ ^[0-9]+$ ]]
     then
        echo "Invalid choice"
        echo "$(date +'%d/%m/%Y %H:%M:%S') - Change name failed: invalid choice" >> /project/file.log
        return
    fi
    # check if the choice is in range
    if [[ $choice -lt 1 ]] || [[ $choice -gt $num_records ]]
     then
        echo "Invalid choice"
        echo "$(date +'%d/%m/%Y %H:%M:%S') - Change name failed: invalid choice" >> /project/file.log
        return
    fi
    # get all names and change the name
    old_line=$(sed "${choice}q;d" /tmp/temp_file)
    old_name=$(echo $old_line | cut -d ',' -f 1)
    read -p "Enter the new name: " new_name
    sed -i "s/^$old_name,/$new_name,/" /project/record.collection
    echo "Name changed successfully"
    echo "$(date +'%d/%m/%Y %H:%M:%S') - Name for record $old_name changed to $new_name" >> /project/file.log
}
