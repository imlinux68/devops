function show_all_entries_sorted_by_name {
    if [[ ! -f /project/record.collection ]]
     then
        echo "Error: record.collection file doesnt exist." >&2
        echo "$(date +'%d/%m/%Y %H:%M:%S'): Failed: record.collection file does not exist" >> /project/file.log
        return 1
    fi

    if [[ ! -s /project/record.collection ]]
     then
        echo "Error: record.collection file is empty." >&2
        echo "$(date +'%d/%m/%Y %H:%M:%S'): Failed: record.collection file is empty" >> /project/file.log
        return 1
    fi

    local sorted_file=$(sort -t',' -k1 /project/record.collection)

    echo "List of all entries sorted by name:"
    echo "$sorted_file" | awk -F',' '{ printf "%s, %s\n", $1, $2 }'

    echo "$(date +'%d/%m/%Y %H:%M:%S'): show_all_entries function succeSS" >> /project/file.log
}
