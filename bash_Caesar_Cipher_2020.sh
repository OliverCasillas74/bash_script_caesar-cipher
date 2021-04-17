#!/bin/bash


# Oliver Casillas Jaimes
# BS6953
# CS 497
# Assignment #6
# 11/17/2020



# this variable will store as many shifts the user requests
# while ecrypting text using the Caesar Cipher technique.
# doing this, while Decrypting using CC, the program will
# use the the right amount of shifts, in order to go back to
# the original text. 
local cc_rotations


# Display Menu Function
show_menu() {
	clear
	echo "===================="
	echo "      MAIN MENU "
	echo "===================="
	echo "Please choose from the"
	echo "   following Options  "
	echo ""
	echo "1. Create a file "
	echo "2. Write text into file"
	echo "3. Encrypt text in file"
	echo "4. Decrypt text in file"
	echo "5. Read text in file"
	echo "6. EXIT"

}


# Read Options on Menu
read_option() {
	local choice
	echo ""
	read -p "Select an option, please [1 -6]: " choice
	case $choice in
		1) create_file ;;
		2) write_text ;;
		3) encrypt_text ;;
		4) decrypt_text ;;
		5) read_file ;;
		6) exit 0 ;;
	esac
}

# Pause
pause() {
    echo ""
    read -p "Press [ENTER] to continue..."
}


# Creating a File
create_file() {
	clear
	echo "================"
	echo "Creating a File"
	echo "================"
	echo ""
	read -p "Please enter the name of the file to be created: " filename

	touch $filename
	echo ""
	echo "File successfully created"
	pause
}


# Write Text into a File
write_text() {
	local file
	local text
	clear
	echo "======================"
	echo "Write Text into a File"
	echo "======================"
	echo ""
	echo "Enter the name of the File to modify" 
	read -p "or Enter a new name to create File: " file
	echo ""
	echo  "Please enter your text here: "
	echo "" 
	read -p "" text
	echo ""
	echo > $file $text
	echo "Your text has been added to the selected file [$file]"
	pause

}

# Encrypting the text in the file. MENU
encrypt_text() {
	local choice
	clear
	echo "==========================="
	echo "Encrypting the Text in File"
	echo "==========================="
	echo ""
	echo "1) ROT13 Encryption"
	echo "2) Caesar Cipher"
	echo "3) Return to Main Menu"
	echo ""
	read -p "Choose the type of Encryption: " choice

	case $choice in
		1) rot13_text_e ;;
		2) cc_text_e ;;
		3) show_menu ;;
	esac
}


# Decrypting the text in the file. MENU
decrypt_text() {
	local choice
	clear
	echo "==========================="
	echo "Decrypting the Text in File"
	echo "==========================="
	echo ""
	echo "1) ROT13 Decryption"
	echo "2) Caesar Cipher"
	echo "3) return to Main Menu"
	echo ""
	read -p "Choose the type of Decryption: " choice

	case $choice in
		1) rot13_text_d ;;
		2) cc_text_d ;;
		3) show_menu
	esac
}

# ROT13 Encryption
rot13_text_e() {
	local file_entered
	# local file_encrypted

	clear
	echo "==============="
	echo "     ROT13     "
	echo "   Encryption  "
	echo "==============="
	echo ""
	read -p "Enter the file name to read: " file_entered
	echo ""
	read -p "Enter the file name where you want to store the Encrypted text: " file_output
	echo ""
	echo "The current text in file is: "
	echo "============================"
	echo ""
	cat $file_entered
	echo ""

	encrypting=$(cat $file_entered | tr '[A-Za-z]' '[N-ZA-Mn-za-m]')
	echo "Text after Encrypting using ROT13: "
	echo "================================== "
	echo ""
	echo $encrypting

	echo > $file_output $encrypting
	echo ""
	echo "The Encrypted text has been saved into the [$file_output] file."
	pause 

}

# ROT13 Decryption
rot13_text_d() {
	local file_entered

	clear
	echo "=================="
	echo "       ROT13      "
	echo "     Decryption   "
	echo "=================="
	echo ""
	read -p "Enter the file name to read: " file_entered
	echo ""
	read -p "Enter the file name where you want to store the Decrypted text: " file_output
	echo ""
	echo "The current text in file is: "
	echo "============================ "
	echo ""
	cat $file_entered
	echo ""

	decrypting=$(cat $file_entered | tr '[A-Za-z]' '[N-ZA-Mn-za-m]')
 	echo "Text after Decrypting using ROT13: "
	echo "================================== "
	echo ""
	echo $decrypting

	echo > $file_output $decrypting
	echo ""
	echo "The Decrypted text has been saved into the [$file_output] file."
	pause
}

# Caesar Cipher Encryption
cc_text_e() {
	local file_entered
	#local cc_rotations

	clear
	echo "======================"
	echo "    Caesar Cipher     "
	echo "      Encryption      "
	echo "======================"
	echo ""
	read -p "Enter the file name to read: " file_entered
	echo ""
	read -p "Enter the file name where you want to store the Decrypted text: " file_output
	echo ""

	echo "How many Rotations do you want to apply? "
	read -p "Rotations: " cc_rotations

	echo ""
	echo "The current text in file is: "
	echo "============================ "
	echo ""
	cat $file_entered
	echo ""

	# alphabet variables
	upper_c=ABCDEFGHIJKLMNOPQRSTUVWXYZ
	lower_c=abcdefghijklmnopqrstuvwxyz

	# Encryption command line.
	encrypting_cc=$(cat $file_entered | sed "y/$upper_c$lower_c/${upper_c:$cc_rotations}${upper_c::$cc_rotations}${lower_c:$cc_rotations}${lower_c::$cc_rotations}/")

	echo "After Encrypting using Caesar Cipher, "
	echo "shifting [$cc_rotations] places."
	echo "==================================== "
	echo ""
	echo $encrypting_cc 

	echo > $file_output $encrypting_cc
	echo""
	echo "The Encrypted text has been saved into the [$file_output] file."
	pause

}


# Caesar Cipher Decryption
cc_text_d() {
	local file_entered

	clear
	echo "======================"
	echo "    Caesar Cipher     "
	echo "      Decryption      "
	echo "======================"
	echo ""
	read -p "Enter the file name to read: " file_entered
	echo ""
	read -p "Enter the file name where you want to store the Decrypted text: " file_output
	echo ""
	echo "The current text in file is: "
	echo "============================ "
	echo ""
	cat $file_entered
	
	echo ""
	echo ""

	# alphabet variables
	upper_c=ABCDEFGHIJKLMNOPQRSTUVWXYZ
	lower_c=abcdefghijklmnopqrstuvwxyz
	
	decrypting_cc=$(cat $file_entered | sed "y/${upper_c:$cc_rotations}${upper_c::$cc_rotations}${lower_c:$cc_rotations}${lower_c::$cc_rotations}/$upper_c$lower_c/")

	echo "After Decrypting the text using Caesar Cipher: "
	echo "============================================== "
	echo ""
	echo $decrypting_cc

	echo > $file_output $decrypting_cc
	echo ""
	echo "The Decrypted text has been saved into the [$file_output] file."
	pause

}


# Reading the Contents of a File
read_file() {
	local file_to_read

	clear
	echo "=========================="
	echo "Reading the Text in a File"
	echo "=========================="
	echo ""
	read -p "Please, enter the name of the file: " file_to_read
	echo ""
	echo "The text in this file is the following: "
	echo ""
	cat $file_to_read
	echo ""
	pause

}


# Loop for Menu

while true
do
	show_menu
	read_option
done
