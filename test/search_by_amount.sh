search_by_amount() {
    local count=$(grep -c "," /project/record.collection)
    if [[ $count -eq 0 ]]
     then
        echo "no entries found"
        echo "$(date +'%d/%m/%Y %H:%M:%S'): No entries found" >> /project/file.log
        return
    fi
    
    echo "recod sorted by amount: "
    echo "$(date +'%d/%m/%Y %H:%M:%S'): Entries sorted by amount: " >> /project/file.log
    
    # sorting by amount in descending order
    sort -t',' -k2nr /project/record.collection | while IFS=',' read -r name amount; do
        echo "$name, $amount"
        echo " $(date +'%d/%m/%Y %H:%M:%S'): $name, $amount" >> /project/file.log
    done
}
