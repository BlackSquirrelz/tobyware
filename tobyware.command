#! /bin/bash
echo "==============================================="
echo
echo "Mac Computer Basic Information Gathering Tool"
echo "Copyright: Tobias Weisskopf"
echo "Created - January 2020"
echo
echo "==============================================="
echo "This script will gather some basic information about the system to be imaged"
echo "The default saving location is on the current drive."
#Check if directory and file exists, otherwise create it.
echo
echo "Please enter a case name: "
read case
casedir="$case"_$(date +"%Y%m%d")_$(whoami)
echo "Creating $casedir on $(pwd)..."
mkdir $casedir
basicFile=$(date +"%Y%m%d")_BasicInformation.txt
BasicInformation=$casedir/$basicFile
touch $BasicInformation
#Write Header Information
echo "Case information Project - " $case >> $BasicInformation
echo "Aquired on" $(date) >> $BasicInformation
echo "Gathering Basic Information..."
echo "Username:  " $(whoami) >> $BasicInformation
echo "Basic Information Collected"
echo "----------------------------"
echo "Gathering Computer Information..."
#Get Computer information
echo "Model: " $(system_profiler SPHardwareDataType | grep "Model Identifier") >> $BasicInformation
echo "OS Version: " $(sw_vers -productVersion) >> $BasicInformation
echo "Serial Number: " $(system_profiler SPHardwareDataType | grep Serial) >> $BasicInformation
echo "Controller: " $(system_profiler SPHardwareDataType | grep Controller) >> $BasicInformation
echo "FileVault Status: " $(sudo fdesetup status) >> $BasicInformation
echo "System Software: " $(system_profiler SPSoftwareDataType) >> $BasicInformation
echo "----------------------------"
echo "End of Report" >> $BasicInformation
echo
echo "Computer information collected"
echo "----------------------------"
echo "Gathering System Information"
cd $casedir
mkdir "System Information"
system_profiler -detailLevel full > ./$(date +"%Y%m%d")_system_report_full.txt
cd ..
echo "System Information collected"

echo "Acquisition of case information finished, please review the log file to determine the next steps."
