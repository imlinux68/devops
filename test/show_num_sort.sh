show_all_entries_sorted_by_amount() {
    # Check if the record.collection file exists
    if [[ ! -f /project/record.collection ]]
     then
        echo "Error: record collection file does not exist"
        echo " $(date +'%d/%m/%Y %H:%M:%S'): Error: record collection file does not exist" >> /project/file.log
        return
    fi
    
    # onlyif there are any entries in the record.collection file
    if [[ ! -s /project/record.collection ]] 
    then
        echo "Error: no entries found in record collection"
        echo "$(date +'%d/%m/%Y %H:%M:%S'): Error: no entries found in record collection" >> /project/file.log
        return
    fi
    
    # sorting the entries in the record.collection file by amount
    sorted_entries=$(sort -t ',' -k2rn /project/record.collection)
    
    # function!!! print the sorted entries function
    echo "All Entries Sorted by Amount:"
    echo "------------------------------"
    echo "$sorted_entries" | awk '{printf "%-20s %s\n", $1",", $2}' 
    echo "------------------------------"
    
    # logging
    echo "$(date +'%d/%m/%Y %H:%M:%S'):  sorted by amount successfullY" >> /project/file.log
}


