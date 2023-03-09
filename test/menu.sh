#!/bin/bash
source search_by_name.sh
source search_by_amount.sh
source add_entry.sh
source delete_entry.sh
source change_name.sh
source show_sort.sh
source show_num_sort.sh
source change_amounts.sh


function menu {
while true
do
    clear
    echo "Welcome to the Record Collection Menu"
    echo "1. Search by Name"
    echo "2. Search by Amount"
    echo "3. Add Entry"
    echo "4. Delete Entry"
    echo "5. Change Amount"
    echo "6. Change Name"
    echo "7. Show All Entries Sorted by Name"
    echo "8. Show All Entries Sorted by Amount"
    echo "9. Exit"
    read -p "Please choose an option: " choice
    case $choice in
        1)
            search_by_name
            read -p "Press Enter to continue"
            ;;
        2)
            search_by_amount
            read -p "Press Enter to continue"
            ;;
        3)
            add_entry
            read -p "Press Enter to continue"
            ;;
        4)
            delete_entry
            read -p "Press Enter to continue"
            ;;
        5)
            change_amount
            read -p "Press Enter to continue"
            ;;
        6)
            change_name
            read -p "Press Enter to continue"
            ;;
        7)
            show_all_entries_sorted_by_name
            read -p "Press Enter to continue"
            ;;
        8)
            show_all_entries_sorted_by_amount
            read -p "Press Enter to continue"
            ;;
        9)
            echo "Exiting Record Collection Menu"
            exit 5
            ;;
        *)
            echo "Choose nums between 1-9"
            read -p "Press Enter to continue"
            ;;
    esac
done
}
