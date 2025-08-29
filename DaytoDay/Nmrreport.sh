Convert shell script to Python3Converter_status=`$sshconn_RSS_SPE2 "systemctl status converterd | grep Active |                                                                              wc -l" `
status=`$sshconn_RSS_SPE2 "systemctl status converterd | grep Active | cut -d ')                                                                             ' -f 1" | cut -d ':' -f 2`

if [ "$Converter_status" -gt 0 ]
 then
   R11_Converter_status=$status')'
   echo -n $grn `$sshconn_RSS_SPE2 "systemctl status converterd | grep Active |                                                                              cut -d ')' -f 1" | cut -d ':' -f 2` $clr >>$log_file
 else
   R11_Converter_status='Inactive'
   echo -e $red "Converter process may not be running properly. Please check man                                                                             ually \n" $clr>>$log_file
 fi

$sshconn_RSS_SPE2 "systemctl status converterd | grep Active">>$log_file

# 3. Tomcat service Status

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\nTomcat Service status \n" | tee -a "$log_file"


Tomcat_status=`$sshconn_RSS_SPE2 "systemctl status tomcat | grep Active | wc -l"                                                                              `

if [ "$Tomcat_status" -gt 0 ]
 then
   R11_Tomcat_status=`$sshconn_RSS_SPE2 "systemctl status tomcat | grep Active |                                                                              cut -d ')' -f 1" | cut -d ':' -f 2 `')'
   echo -n $grn `systemctl status tomcat | grep Active` $clr >>$log_file
 else
   R11_Tomcat_status='Inactive'
   echo -e $red "Tomcat service may not be running properly. Please check manual                                                                             ly (systemctl status tomcat)\n" $clr>>$log_file
 fi

$sshconn_RSS_SPE2 "systemctl status tomcat | grep Active">>$log_file

# 4. dbus service Status

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\ndbus Service status \n" | tee -a "$log_file"



dbus_status=`$sshconn_RSS_SPE2 "systemctl status dbus | grep Active | wc -l" `


if [ $dbus_status -gt 0 ]
 then
   R11_Dbus_status=`$sshconn_RSS_SPE2 "systemctl status dbus | grep Active | cut                                                                              -d ')' -f 1" | cut -d ':' -f 2 `')'
   #echo -n $grn `systemctl status dbus | grep Active` $clr >>$log_file
 else
  R11_Dbus_status='Inactive'
   echo -e $red "dbus service may not be running properly. Please check manually                                                                              (systemctl status dbus)\n" $clr>>$log_file
 fi

$sshconn_RSS_SPE2 "systemctl status dbus | grep Active">>$log_file

#5      Recorder process Status
# if [ $var1 -gt 0 ]; then  echo "var has value"; else echo "var is empty"; fi                                                                               --> example if else

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\nRecorder process status \n" | tee -a "$log_file"


process_status=`$sshconn_RSS_SPE2 "systemctl status recorderd | grep Active | wc                                                                              -l" `

if [ $process_status -gt 0 ]
 then
   R11_Recorder_status=`$sshconn_RSS_SPE2 "systemctl status recorderd | grep Act                                                                             ive | cut -d ')' -f 1" | cut -d ':' -f 2 `')'
   #echo -n $grn `systemctl status recorderd | grep Active ` $clr >>$log_file
 else
   R11_Recorder_status='Inactive'
   echo -e $red "Recorder process may not be running properly. Please check manu                                                                             ally \n" $clr>>$log_file
 fi

$sshconn_RSS_SPE2 "systemctl status recorderd | grep Active">>$log_file

# 6. Memory Status

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\nMemory status \n" | tee -a "$log_file"

  R11_Memory_status=`$sshconn_RSS_SPE2 free | awk '/Mem/{printf("%.2f%"), $3/$2*                                                                             100}'`

echo -n $grn `$sshconn_RSS_SPE2 free -m` $clr >>$log_file


# 7. firewall service Status

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\nfirewall Service status \n" | tee -a "$log_file"



fwall_status=`$sshconn_RSS_SPE2 "systemctl status firewalld | grep Active | wc -                                                                             l" `


if [ $fwall_status -gt 0 ]
 then
   R11_fwall_status=`$sshconn_RSS_SPE2 "systemctl status firewalld | grep Active                                                                              | cut -d ')' -f 1" | cut -d ':' -f 2 `')'

 else
  R11_fwall_status='Inactive'
   echo -e $red "firewall service may not be running properly. Please check manu                                                                             ally (systemctl status firewalld )\n" $clr>>$log_file
 fi

$sshconn_RSS_SPE2 "systemctl status firewalld | grep Active">>$log_file





echo -e "\n****************************************************************RSS s                                                                             erver health check Ends*********************************************************                                                                             ************************\n">>$log_file

echo -e "\n****************************************************************RSS S                                                                             erver health check**************************************************************                                                                             ************\n">>$log_file

# 1. Checking system Status for RSS1 Leganes


L11=`$sshconn_L1 "systemctl status | sed -n 1,5p | grep "running" | wc -l"`

$sshconn_L1 "systemctl status | sed -n 1,5p ">>$log_file

echo -e "\nChecking system Status \n"

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e
echo -e "System Status .\n" >>$log_file

if [ "$L11" -gt 0 ]
 then
   RS1L_System_status='Running'
   echo -e $grn `$sshconn_L1 "systemctl status | sed -n 1,5p" ` $clr>>$log_file
else
   RS1L_System_status='Not Running'
   echo -e $grn `$sshconn_L1 "systemctl status | sed -n 1,5p" ` $clr>>$log_file
fi

echo -e "\n" >> log_file


# 2. Converter process Status

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\nConverter process status \n" | tee -a "$log_file"


Converter_status=`$sshconn_L1 "systemctl status converterd | grep Active | wc -l                                                                             " `
status=`$sshconn_L1 "systemctl status converterd | grep Active | cut -d ')' -f 1                                                                             " | cut -d ':' -f 2`

if [ "$Converter_status" -gt 0 ]
 then
   RS1L_Converter_status=$status')'
   echo -n $grn `$sshconn_L1 "systemctl status converterd | grep Active | cut -d                                                                              ')' -f 1" | cut -d ':' -f 2` $clr >>$log_file
 else
   RS1L_Converter_status='Inactive'
   echo -e $red "Converter process may not be running properly. Please check man                                                                             ually \n" $clr>>$log_file
 fi

$sshconn_L1 "systemctl status converterd | grep Active">>$log_file

# 3. Tomcat service Status

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\nTomcat Service status \n" | tee -a "$log_file"


Tomcat_status=`$sshconn_L1 "systemctl status tomcat | grep Active | wc -l" `

if [ "$Tomcat_status" -gt 0 ]
 then
   RS1L_Tomcat_status=`$sshconn_L1 "systemctl status tomcat | grep Active | cut                                                                              -d ')' -f 1" | cut -d ':' -f 2 `')'
   echo -n $grn `systemctl status tomcat | grep Active` $clr >>$log_file
 else
   RS1L_Tomcat_status='Inactive'
   echo -e $red "Tomcat service may not be running properly. Please check manual                                                                             ly (systemctl status tomcat)\n" $clr>>$log_file
 fi

$sshconn_L1 "systemctl status tomcat | grep Active">>$log_file

# 4. dbus service Status

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\ndbus Service status \n" | tee -a "$log_file"



dbus_status=`$sshconn_L1 "systemctl status dbus | grep Active | wc -l" `


if [ $dbus_status -gt 0 ]
 then
   RS1L_Dbus_status=`$sshconn_L1 "systemctl status dbus | grep Active | cut -d '                                                                             )' -f 1" | cut -d ':' -f 2 `')'
   #echo -n $grn `systemctl status dbus | grep Active` $clr >>$log_file
 else
  RS1L_Dbus_statu='Inactive'
   echo -e $red "dbus service may not be running properly. Please check manually                                                                              (systemctl status dbus)\n" $clr>>$log_file
 fi

$sshconn_L1 "systemctl status dbus | grep Active">>$log_file

#5      Recorder process Status
# if [ $var1 -gt 0 ]; then  echo "var has value"; else echo "var is empty"; fi                                                                               --> example if else

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\nRecorder process status \n" | tee -a "$log_file"


process_status=`$sshconn_L1 "systemctl status recorderd | grep Active | wc -l" `

if [ $process_status -gt 0 ]
 then
   RS1L_Recorder_status=`$sshconn_L1 "systemctl status recorderd | grep Active |                                                                              cut -d ')' -f 1" | cut -d ':' -f 2 `')'
   #echo -n $grn `systemctl status recorderd | grep Active ` $clr >>$log_file
 else
   RS1L_Recorder_status='Inactive'
   echo -e $red "Recorder process may not be running properly. Please check manu                                                                             ally \n" $clr>>$log_file
 fi

$sshconn_L1 "systemctl status recorderd | grep Active">>$log_file

# 6. Memory Status

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\nMemory status \n" | tee -a "$log_file"

  RS1L_Memory_status=`$sshconn_L1 free | awk '/Mem/{printf("%.2f%"), $3/$2*100}'                                                                             `

echo -n $grn `$sshconn_L1 free -m` $clr >>$log_file


# 7. firewall service Status

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\nfirewall Service status \n" | tee -a "$log_file"



fwall_status=`$sshconn_L1 "systemctl status firewalld | grep Active | wc -l" `


if [ $fwall_status -gt 0 ]
 then
   RS1L_fwall_status=`$sshconn_L1 "systemctl status firewalld | grep Active | cu                                                                             t -d ')' -f 1" | cut -d ':' -f 2 `')'

 else
  RS1L_fwall_status='Inactive'
   echo -e $red "firewall service may not be running properly. Please check manu                                                                             ally (systemctl status firewalld )\n" $clr>>$log_file
 fi

$sshconn_L1 "systemctl status firewalld | grep Active">>$log_file





echo -e "\n****************************************************************RSS s                                                                             erver health check Ends*********************************************************                                                                             ************************\n">>$log_file

echo -e "\n****************************************************************RSS S                                                                             erver health check**************************************************************                                                                             ************\n">>$log_file

# 1. Checking system Status for RSS1 Leganes


L11=`$sshconn_L3 "systemctl status | sed -n 1,5p | grep "running" | wc -l"`

$sshconn_L3 "systemctl status | sed -n 1,5p ">>$log_file

echo -e "\nChecking system Status \n"

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e
echo -e "System Status .\n" >>$log_file

if [ "$L11" -gt 0 ]
 then
   RS1R_System_status='Running'
   echo -e $grn `$sshconn_L3 "systemctl status | sed -n 1,5p" ` $clr>>$log_file
else
   RS1R_System_status='Not Running'
   echo -e $grn `$sshconn_L3 "systemctl status | sed -n 1,5p" ` $clr>>$log_file
fi

echo -e "\n" >> log_file


# 2. Converter process Status

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\nConverter process status \n" | tee -a "$log_file"


Converter_status=`$sshconn_L3 "systemctl status converterd | grep Active | wc -l                                                                             " `
status=`$sshconn_L3 "systemctl status converterd | grep Active | cut -d ')' -f 1                                                                             " | cut -d ':' -f 2`

if [ "$Converter_status" -gt 0 ]
 then
   RS1R_Converter_status=$status')'
   echo -n $grn `$sshconn_L3 "systemctl status converterd | grep Active | cut -d                                                                              ')' -f 1" | cut -d ':' -f 2` $clr >>$log_file
 else
   RS1R_Converter_status='Inactive'
   echo -e $red "Converter process may not be running properly. Please check man                                                                             ually \n" $clr>>$log_file
 fi

$sshconn_L3 "systemctl status converterd | grep Active">>$log_file

# 3. Tomcat service Status

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\nTomcat Service status \n" | tee -a "$log_file"


Tomcat_status=`$sshconn_L3 "systemctl status tomcat | grep Active | wc -l" `

if [ "$Tomcat_status" -gt 0 ]
 then
   RS1R_Tomcat_status=`$sshconn_L3 "systemctl status tomcat | grep Active | cut                                                                              -d ')' -f 1" | cut -d ':' -f 2 `')'
   echo -n $grn `systemctl status tomcat | grep Active` $clr >>$log_file
 else
   RS1R_Tomcat_status='Inactive'
   echo -e $red "Tomcat service may not be running properly. Please check manual                                                                             ly (systemctl status tomcat)\n" $clr>>$log_file
 fi

$sshconn_L3 "systemctl status tomcat | grep Active">>$log_file

# 4. dbus service Status

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\ndbus Service status \n" | tee -a "$log_file"



dbus_status=`$sshconn_L3 "systemctl status dbus | grep Active | wc -l" `


if [ $dbus_status -gt 0 ]
 then
   RS1R_Dbus_status=`$sshconn_L3 "systemctl status dbus | grep Active | cut -d '                                                                             )' -f 1" | cut -d ':' -f 2 `')'
   #echo -n $grn `systemctl status dbus | grep Active` $clr >>$log_file
 else
  RS1R_Dbus_statu='Inactive'
   echo -e $red "dbus service may not be running properly. Please check manually                                                                              (systemctl status dbus)\n" $clr>>$log_file
 fi

$sshconn_L3 "systemctl status dbus | grep Active">>$log_file

#5      Recorder process Status
# if [ $var1 -gt 0 ]; then  echo "var has value"; else echo "var is empty"; fi                                                                               --> example if else

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\nRecorder process status \n" | tee -a "$log_file"


process_status=`$sshconn_L3 "systemctl status recorderd | grep Active | wc -l" `

if [ $process_status -gt 0 ]
 then
   RS1R_Recorder_status=`$sshconn_L3 "systemctl status recorderd | grep Active |                                                                              cut -d ')' -f 1" | cut -d ':' -f 2 `')'
   #echo -n $grn `systemctl status recorderd | grep Active ` $clr >>$log_file
 else
   RS1R_Recorder_status='Inactive'
   echo -e $red "Recorder process may not be running properly. Please check manu                                                                             ally \n" $clr>>$log_file
 fi

$sshconn_L3 "systemctl status recorderd | grep Active">>$log_file

# 6. Memory Status

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\nMemory status \n" | tee -a "$log_file"

  RS1R_Memory_status=`$sshconn_L3 free | awk '/Mem/{printf("%.2f%"), $3/$2*100}'                                                                             `

echo -n $grn `$sshconn_L3 free -m` $clr >>$log_file


# 7. firewall service Status

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\nfirewall Service status \n" | tee -a "$log_file"



fwall_status=`$sshconn_L3 "systemctl status firewalld | grep Active | wc -l" `


if [ $fwall_status -gt 0 ]
 then
   RS1R_fwall_status=`$sshconn_L3 "systemctl status firewalld | grep Active | cu                                                                             t -d ')' -f 1" | cut -d ':' -f 2 `')'

 else
  RS1R_fwall_status='Inactive'
   echo -e $red "firewall service may not be running properly. Please check manu                                                                             ally (systemctl status firewalld )\n" $clr>>$log_file
 fi

$sshconn_L3 "systemctl status firewalld | grep Active">>$log_file


echo -e "\n****************************************************************RSS s                                                                             erver health check Ends*********************************************************                                                                             ************************\n">>$log_file

echo -e "\n****************************************************************RSS S                                                                             erver health check**************************************************************                                                                             ************\n">>$log_file

# 1. Checking system Status for RSS1 Leganes


L11=`$sshconn_L4 "systemctl status | sed -n 1,5p | grep "running" | wc -l"`

$sshconn_L4 "systemctl status | sed -n 1,5p ">>$log_file

echo -e "\nChecking system Status \n"

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e
echo -e "System Status .\n" >>$log_file

if [ "$L11" -gt 0 ]
 then
   RS2R_System_status='Running'
   echo -e $grn `$sshconn_L4 "systemctl status | sed -n 1,5p" ` $clr>>$log_file
else
   RS2R_System_status='Not Running'
   echo -e $grn `$sshconn_L4 "systemctl status | sed -n 1,5p" ` $clr>>$log_file
fi

echo -e "\n" >> log_file


# 2. Converter process Status

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\nConverter process status \n" | tee -a "$log_file"


Converter_status=`$sshconn_L4 "systemctl status converterd | grep Active | wc -l                                                                             " `
status=`$sshconn_L4 "systemctl status converterd | grep Active | cut -d ')' -f 1                                                                             " | cut -d ':' -f 2`

if [ "$Converter_status" -gt 0 ]
 then
   RS2R_Converter_status=$status')'
   echo -n $grn `$sshconn_L4 "systemctl status converterd | grep Active | cut -d                                                                              ')' -f 1" | cut -d ':' -f 2` $clr >>$log_file
 else
   RS2R_Converter_status='Inactive'
   echo -e $red "Converter process may not be running properly. Please check man                                                                             ually \n" $clr>>$log_file
 fi

$sshconn_L4 "systemctl status converterd | grep Active">>$log_file

# 3. Tomcat service Status

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\nTomcat Service status \n" | tee -a "$log_file"


Tomcat_status=`$sshconn_L4 "systemctl status tomcat | grep Active | wc -l" `

if [ "$Tomcat_status" -gt 0 ]
 then
   RS2R_Tomcat_status=`$sshconn_L4 "systemctl status tomcat | grep Active | cut                                                                              -d ')' -f 1" | cut -d ':' -f 2 `')'
   echo -n $grn `systemctl status tomcat | grep Active` $clr >>$log_file
 else
   RS2R_Tomcat_status='Inactive'
   echo -e $red "Tomcat service may not be running properly. Please check manual                                                                             ly (systemctl status tomcat)\n" $clr>>$log_file
 fi

$sshconn_L4 "systemctl status tomcat | grep Active">>$log_file

# 4. dbus service Status

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\ndbus Service status \n" | tee -a "$log_file"



dbus_status=`$sshconn_L4 "systemctl status dbus | grep Active | wc -l" `


if [ $dbus_status -gt 0 ]
 then
   RS2R_Dbus_status=`$sshconn_L4 "systemctl status dbus | grep Active | cut -d '                                                                             )' -f 1" | cut -d ':' -f 2 `')'
   #echo -n $grn `systemctl status dbus | grep Active` $clr >>$log_file
 else
  RS2R_Dbus_statu='Inactive'
   echo -e $red "dbus service may not be running properly. Please check manually                                                                              (systemctl status dbus)\n" $clr>>$log_file
 fi

$sshconn_L4 "systemctl status dbus | grep Active">>$log_file

#5      Recorder process Status
# if [ $var1 -gt 0 ]; then  echo "var has value"; else echo "var is empty"; fi                                                                               --> example if else

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\nRecorder process status \n" | tee -a "$log_file"


process_status=`$sshconn_L4 "systemctl status recorderd | grep Active | wc -l" `

if [ $process_status -gt 0 ]
 then
   RS2R_Recorder_status=`$sshconn_L4 "systemctl status recorderd | grep Active |                                                                              cut -d ')' -f 1" | cut -d ':' -f 2 `')'
   #echo -n $grn `systemctl status recorderd | grep Active ` $clr >>$log_file
 else
   RS2R_Recorder_status='Inactive'
   echo -e $red "Recorder process may not be running properly. Please check manu                                                                             ally \n" $clr>>$log_file
 fi

$sshconn_L4 "systemctl status recorderd | grep Active">>$log_file

# 6. Memory Status

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\nMemory status \n" | tee -a "$log_file"

  RS2R_Memory_status=`$sshconn_L4 free | awk '/Mem/{printf("%.2f%"), $3/$2*100}'                                                                             `

echo -n $grn `$sshconn_L4 free -m` $clr >>$log_file


# 7. firewall service Status

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\nfirewall Service status \n" | tee -a "$log_file"



fwall_status=`$sshconn_L4 "systemctl status firewalld | grep Active | wc -l" `


if [ $fwall_status -gt 0 ]
 then
   RS2R_fwall_status=`$sshconn_L4 "systemctl status firewalld | grep Active | cu                                                                             t -d ')' -f 1" | cut -d ':' -f 2 `')'

 else
  RS2R_fwall_status='Inactive'
   echo -e $red "firewall service may not be running properly. Please check manu                                                                             ally (systemctl status firewalld )\n" $clr>>$log_file
 fi

$sshconn_L4 "systemctl status firewalld | grep Active">>$log_file






echo -e "\n****************************************************************RSS s                                                                             erver health check Ends*********************************************************                                                                             ************************\n">>$log_file





# 1. Checking system Status for RSS2 Leganes


L11=`$sshconn_L2 "systemctl status | sed -n 1,5p | grep "running" | wc -l"`

echo -e "\nChecking system Status \n"

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e
echo -e "System Status .\n" >>$log_file

if [ $L11 -gt 0 ]
 then
   RS2L_System_status='Running'
   echo -e $grn `systemctl status | sed -n 1,5p` $clr>>$log_file
else
   RS2L_System_status='Not Running'
   echo -e $grn `systemctl status | sed -n 1,5p` $clr>>$log_file
fi

$sshconn_L2 "systemctl status converterd | grep Active">>$log_file

echo -e "\n" >> log_file


# 2. Converter process Status

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\nConverter process status \n" | tee -a "$log_file"


Converter_status=`$sshconn_L2 "systemctl status converterd | grep Active | wc -l                                                                             " `
status1=`$sshconn_L2 "systemctl status converterd | grep Active | cut -d ')' -f                                                                              1" | cut -d ':' -f 2 `
if [ $Converter_status -gt 0 ]
 then
   RS2L_Converter_status=$status1')'
   #echo -n $grn `systemctl status converterd | grep Active ` $clr >>$log_file
 else
   RS2L_Converter_status='Inactive'
   echo -e $red "Converter process may not be running properly. Please check man                                                                             ually \n" $clr>>$log_file
 fi

$sshconn_L2 "systemctl status converterd | grep Active">>$log_file


# 3. Tomcat service Status

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\nTomcat Service status \n" | tee -a "$log_file"



Tomcat_status=`$sshconn_L2 "systemctl status tomcat | grep Active | wc -l" `

if [ $Tomcat_status -gt 0 ]
 then
   RS2L_Tomcat_status=`$sshconn_L2 "systemctl status tomcat | grep Active | cut                                                                              -d ')' -f 1" | cut -d ':' -f 2 `')'
   #echo -n $grn `systemctl status tomcat | grep Active` $clr >>$log_file
 else
   RS2L_Tomcat_status='Inactive'
   echo -e $red "Tomcat service may not be running properly. Please check manual                                                                             ly (systemctl status tomcat)\n" $clr>>$log_file
fi

$sshconn_L2 "systemctl status tomcat | grep Active">>$log_file
# 4. dbus service Status

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\ndbus Service status \n" | tee -a "$log_file"


dbus_status=`$sshconn_L2 "systemctl status dbus | grep Active | wc -l"`

if [ $dbus_status -gt 0 ]
 then
   RS2L_Dbus_status=`$sshconn_L2 "systemctl status dbus | grep Active | cut -d '                                                                             )' -f 1" | cut -d ':' -f 2 `')'
   #echo -n $grn `systemctl status dbus | grep Active` $clr >>$log_file
 else
  RS2L_Dbus_statu='Inactive'
   echo -e $red "dbus service may not be running properly. Please check manually                                                                              (systemctl status dbus)\n" $clr>>$log_file
 fi

$sshconn_L2 "systemctl status dbus | grep Active">>$log_file
#5      Recorder process Status
# if [ $var1 -gt 0 ]; then  echo "var has value"; else echo "var is empty"; fi                                                                               --> example if else

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\nRecorder process status \n" | tee -a "$log_file"


process_status=`$sshconn_L2 "systemctl status recorderd | grep Active | wc -l"`

if [ $process_status -gt 0 ]
 then
   RS2L_Recorder_status=`$sshconn_L2 "systemctl status recorderd | grep Active |                                                                              cut -d ')' -f 1" | cut -d ':' -f 2 `')'
   #echo -n $grn `systemctl status recorderd | grep Active ` $clr >>$log_file
 else
   RS2L_Recorder_status='Inactive'
   echo -e $red "Recorder process may not be running properly. Please check manu                                                                             ally \n" $clr>>$log_file
 fi

$sshconn_L2 "systemctl status recorderd | grep Active">>$log_file

# 6. Memory Status

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\nMemory status \n" | tee -a "$log_file"


  RS2L_Memory_status=`$sshconn_L2 free | awk '/Mem/{printf("%.2f%"), $3/$2*100}'                                                                             `

echo -n $grn `$sshconn_L2 free -m` $clr >>$log_file


# 7. firewall service Status

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\nfirewall Service status \n" | tee -a "$log_file"



fwall_status=`$sshconn_L2 "systemctl status firewalld | grep Active | wc -l" `


if [ $fwall_status -gt 0 ]
 then
   RS2L_fwall_status=`$sshconn_L2 "systemctl status firewalld | grep Active | cu                                                                             t -d ')' -f 1" | cut -d ':' -f 2 `')'

 else
  RS2L_fwall_status='Inactive'
   echo -e $red "firewall service may not be running properly. Please check manu                                                                             ally (systemctl status firewalld )\n" $clr>>$log_file
 fi

$sshconn_L2 "systemctl status firewalld | grep Active">>$log_file






echo -e "\n****************************************************************RSS s                                                                             erver health check Ends*********************************************************                                                                             ************************\n">>$log_file





# Check for RA server
#RA server Status
echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\nRA Leganes server system status \n" | tee -a "$log_file"



RAL_System=`$sshconn_RAL systemctl status | grep running | wc -l`

if [ $RAL_System -gt 0 ]
 then
   RAL_System_status='Active'

 else
   RAL_System_status='InActive'
   echo -e $red"There may be issue. Please check RA service. \n"$clr>>$log_file
fi

$sshconn_RAL "systemctl status | grep running">>$log_file

#RA server Cognia listening

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\nRA Leganes server Cognia connection status \n" | tee -a "$log_file"


RAL_Cognia_result=`$sshconn_RAL "netstat -an | grep ESTABLISHED | egrep '18.203.                                                                             78|54.220.104|168.119.69|185.180.216.201|185.180.217.201' | wc -l"`

if [ $RAL_Cognia_result -gt 0 ]
 then
   RAL_Cognia='Established'

 else
   RAL_Cognia='Not Established'
   echo -e $red"There may be issue. Please check RA service. \n"$clr>>$log_file
fi

$sshconn_RAL "netstat -an | grep ESTABLISHED | egrep '18.203.78|54.220.104|168.1                                                                             19.69|185.180.216.201|185.180.217.201'">>$log_file

#RA server Nice listening

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\nRA Leganes server Nice connection status \n" | tee -a "$log_file"


RAL_Nice_result=`$sshconn_RAL "netstat -an | grep ESTABLISHED | grep '205.228.82                                                                             ' | wc -l"`

if [ $RAL_Nice_result -gt 0 ]
 then
   RAL_Nice='Established'

 else
   RAL_Nice='Not Established '
   echo -e $red"There may be issue. Please check RA service. \n"$clr>>$log_file
fi

$sshconn_RAL "netstat -an | grep ESTABLISHED | grep '205.228.82'">>$log_file

#RA server Index listening

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\nRA Leganes server Index connection status \n" | tee -a "$log_file"


RAL_Index_result=`$sshconn_RAL "netstat -an | grep :8443 | grep ESTABLISHED | wc                                                                              -l"`

if [ $RAL_Index_result -gt 0 ]
 then
   RAL_Index='Established'

 else
   RAL_Index_result=`$sshconn_RAL "netstat -an | grep :8443 | grep LISTEN | wc -                                                                             l"`

   if [ $RAL_Index_result -gt 0 ]
   then
       RAL_Index='Listening'
   else
      RAL_Index='Not Established'
      echo -e $red"There may be issue. Please check RA service. \n"$clr>>$log_fi                                                                             le
   fi
fi

$sshconn_RAL "netstat -an | grep :8443 ">>$log_file

#RA server Tomcat status

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\nRA Leganes server Tomcat service status \n" | tee -a "$log_file"


RAL_tomcat_status=`$sshconn_RAL "systemctl status tomcat | grep Active | wc -l"`

if [ $RAL_tomcat_status -gt 0 ]
 then
   RAL_tomcat=`$sshconn_RAL "systemctl status tomcat | grep Active | cut -d ')'                                                                              -f 1" | cut -d ':' -f 2`')'

 else
   RAL_tomcat='InActive'
   echo -e $red"There may be issue. Please check RA service. \n"$clr>>$log_file
fi

# 7. firewall service Status

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\nfirewall Service status \n" | tee -a "$log_file"



fwall_status=`$sshconn_RAL "systemctl status firewalld | grep Active | wc -l" `


if [ $fwall_status -gt 0 ]
 then
   RAL_fwall_status=`$sshconn_RAL "systemctl status firewalld | grep Active | cu                                                                             t -d ')' -f 1" | cut -d ':' -f 2 `')'

 else
  RAL_fwall_status='Inactive'
   echo -e $red "firewall service may not be running properly. Please check manu                                                                             ally (systemctl status firewalld )\n" $clr>>$log_file
 fi

$sshconn_RAL "systemctl status firewalld | grep Active">>$log_file


# Check for RA server Ratingen
#RA server Status
echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\nRA Leganes server system status \n" | tee -a "$log_file"



RAL_System=`$sshconn_RAR systemctl status | grep running | wc -l`

if [ $RAL_System -gt 0 ]
 then
   RAR_System_status='Active'

 else
   RAR_System_status='InActive'
   echo -e $red"There may be issue. Please check RA service. \n"$clr>>$log_file
fi


#RA server Cognia listening

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\nRA Leganes server Cognia connection status \n" | tee -a "$log_file"


RAR_Cognia_result=`$sshconn_RAR "netstat -an | grep ESTABLISHED | egrep '18.203.                                                                             78|54.220.104|168.119.69|185.180.216.201|185.180.217.201' | wc -l"`

if [ $RAR_Cognia_result -gt 0 ]
 then
   RAR_Cognia='Established'

 else
   RAR_Cognia='Not Established'
   echo -e $red"There may be issue. Please check RA service. \n"$clr>>$log_file
fi
$sshconn_RAR "netstat -an | grep ESTABLISHED | egrep '18.203.78|54.220.104|168.1                                                                             19.69|185.180.216.201|185.180.217.201'">>$log_file


#RA server Nice listening

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\nRA Leganes server Nice connection status \n" | tee -a "$log_file"


RAR_Nice_result=`$sshconn_RAR "netstat -an | grep ESTABLISHED | grep '205.228.82                                                                             ' | wc -l"`

if [ $RAR_Nice_result -gt 0 ]
 then
   RAR_Nice='Established'

 else
   RAR_Nice='Not Established'
   echo -e $red"There may be issue. Please check RA service. \n"$clr>>$log_file
fi

$sshconn_RAR "netstat -an | grep ESTABLISHED | grep '205.228.82'">>$log_file


#RA server Index listening

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\nRA Leganes server Index connection status \n" | tee -a "$log_file"

RAR_Index_result=`$sshconn_RAR "netstat -an | grep :8443 | grep ESTABLISHED | wc                                                                              -l"`

if [ $RAR_Index_result -gt 0 ]
 then
   RAR_Index='Established'

 else
   RAR_Index_result=`$sshconn_RAR "netstat -an | grep :8443 | grep LISTEN | wc -                                                                             l"`

   if [ $RAR_Index_result -gt 0 ]
   then
       RAR_Index='Listening'
   else
      RAR_Index='Not Established'
      echo -e $red"There may be issue. Please check RA service. \n"$clr>>$log_fi                                                                             le
   fi
fi

$sshconn_RAR "netstat -an | grep :8443 ">>$log_file

#RA server Tomcat status

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\nRA Leganes server Tomcat service status \n" | tee -a "$log_file"


RAR_tomcat_status=`$sshconn_RAR "systemctl status tomcat | grep Active | wc -l"`

if [ $RAR_tomcat_status -gt 0 ]
 then
   RAR_tomcat=`$sshconn_RAR "systemctl status tomcat | grep Active | cut -d ')'                                                                              -f 1" | cut -d ':' -f 2`')'

 else
   RAR_tomcat='inActive'
   echo -e $red"There may be issue. Please check RA service. \n"$clr>>$log_file
fi

# 7. firewall service Status

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\nfirewall Service status \n" | tee -a "$log_file"



fwall_status=`$sshconn_RAR "systemctl status firewalld | grep Active | wc -l" `


if [ $fwall_status -gt 0 ]
 then
   RAR_fwall_status=`$sshconn_RAR "systemctl status firewalld | grep Active | cu                                                                             t -d ')' -f 1" | cut -d ':' -f 2 `')'

 else
  RAR_fwall_status='Inactive'
   echo -e $red "firewall service may not be running properly. Please check manu                                                                             ally (systemctl status firewalld )\n" $clr>>$log_file
 fi

$sshconn_RAR "systemctl status firewalld | grep Active">>$log_file



# Check Momory status for all servers RA , RSS , INDEX
# All connections


echo `$sshconn_L1 df -Th | awk 'NR>1 { print $1, " Mounted on ", $NF, " Used ",                                                                              $6 ," <br> "}'` >/home/ucslsind/NMR_Report/isr6dot4/monitoring/mem_status/Mem_RS                                                                             S_Leganes_Virtual.txt
echo `$sshconn_L2 df -Th | awk 'NR>1 { print $1, " Mounted on ", $NF, " Used ",                                                                              $6 ," <br> " }'` >/home/ucslsind/NMR_Report/isr6dot4/monitoring/mem_status/Mem_R                                                                             SS_Leganes_HW.txt
echo `$sshconn_L3 df -Th | awk 'NR>1 { print $1, " Mounted on ", $NF, " Used ",                                                                              $6 ," <br> "}'` >/home/ucslsind/NMR_Report/isr6dot4/monitoring/mem_status/Mem_RS                                                                             S_Ratingen_Virtual.txt
echo `$sshconn_L4 df -Th | awk 'NR>1 { print $1, " Mounted on ", $NF, " Used ",                                                                              $6 ," <br> " }'` >/home/ucslsind/NMR_Report/isr6dot4/monitoring/mem_status/Mem_R                                                                             SS_Ratingen_HW.txt
echo `$sshconn_RAL df -Th | awk 'NR>1 { print $1, " Mounted on ", $NF, " Used ",                                                                              $6 ," <br> "}'` >/home/ucslsind/NMR_Report/isr6dot4/monitoring/mem_status/Mem_R                                                                             A_Leganes.txt
echo `$sshconn_RAR df -Th | awk 'NR>1 { print $1, " Mounted on ", $NF, " Used ",                                                                              $6 ," <br> "}'` >/home/ucslsind/NMR_Report/isr6dot4/monitoring/mem_status/Mem_R                                                                             A_Ratingen.txt
echo `$sshconn_I1 df -Th | awk 'NR>1 { print $1, " Mounted on ", $NF, " Used ",                                                                              $6 ," <br> "}'` >/home/ucslsind/NMR_Report/isr6dot4/monitoring/mem_status/Mem_In                                                                             dex_Leganes.txt
echo `$sshconn_I2 df -Th | awk 'NR>1 { print $1, " Mounted on ", $NF, " Used ",                                                                              $6 ," <br> "}'` >/home/ucslsind/NMR_Report/isr6dot4/monitoring/mem_status/Mem_In                                                                             dex_Ratingen.txt









echo -e "\n****************************************************************Index                                                                              Leganes server health check****************************************************                                                                             *****************************\n">>$log_file






# 1. Checking system Status for Index Leganes


I11=`$sshconn_I1 "systemctl status | sed -n 1,5p | grep "running" | wc -l"`

echo -e "\nChecking system Status \n"

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e
echo -e "System Status .\n" >>$log_file

if [ $I11 -gt 0 ]
 then
   In_System_status='Running'
   #echo -e $grn `systemctl status | sed -n 1,5p` $clr>>$log_file
else
   In_System_status='Not Running'
   echo -e $grn `systemctl status | sed -n 1,5p` $clr>>$log_file
fi

$sshconn_I1 "systemctl status | sed -n 1,5p">>$log_file

echo -e "\n" >> log_file




# 2.    SQL service Checks

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\nSQL service Checks \n" | tee -a "$log_file"


mysql_status=`$sshconn_I1 "systemctl status mysqld | grep "Active*" | wc -l"`

if [ $mysql_status -gt 0 ]
 then
   In_SQL_status=`$sshconn_I1 "systemctl status mysqld | grep Active | cut -d ')                                                                             ' -f 1" | cut -d ':' -f 2 `')'
   #echo -n $grn `systemctl status mysqld | grep "Active*"` $clr >>$log_file
 else
  In_SQL_status='Inactive'
   echo -e $red "There may be issue. Please check status of SQL services manuall                                                                             y. \n" $clr>>$log_file
 fi

$sshconn_I1 "systemctl status mysqld | grep Active">>$log_file

 # 3.   INDEX PORT LISTENING
echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\nIndex server mysql service  status \n" | tee -a "$log_file"

echo -e $grn `$sshconn_I1 "netstat -tulpn | grep mysqld "` $clr>>$log_file

mysql_portstatus=`$sshconn_I1 "netstat -tulpn | grep mysqld | awk '{print $6}' |                                                                              grep "LISTEN" | wc -l"`

if [ $mysql_portstatus -gt 0 ]
 then
   In_mysql_port='Listening'

 else
   In_mysql_port='Not Listening'
   echo -e $red"There may be issue. Please check mysqld service port. \n"$clr>>$                                                                             log_file
fi


# 4. firewall service Status

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\nfirewall Service status \n" | tee -a "$log_file"



fwall_status=`$sshconn_I1 "systemctl status firewalld | grep Active | wc -l" `


if [ $fwall_status -gt 0 ]
 then
   In_fwall_status=`$sshconn_I1 "systemctl status firewalld | grep Active | cut                                                                              -d ')' -f 1" | cut -d ':' -f 2 `')'

 else
  In_fwall_status='Inactive'
   echo -e $red "firewall service may not be running properly. Please check manu                                                                             ally (systemctl status firewalld )\n" $clr>>$log_file
 fi

$sshconn_I1 "systemctl status firewalld | grep Active">>$log_file



#5.     DB Sync
echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\nDB Sync status \n" | tee -a "$log_file"

read readpos execpos < <($sshconn_I1 "mysql -uroot -p@dmIn123 ipcr_db -se \"show                                                                              slave status \G;\" 2>/dev/null | sed -n '/Read_Master_Log_Pos/s/.*: \([0-9]\+\)                                                                             /\1/p; /Exec_Master_Log_Pos/s/.*: \([0-9]\+\)/\1/p' | paste -sd ' '")
  if [[ $? = 1 ]]; then idxerror=$((idxerror+1)); echo -e "${red}Failed\n\n    S                                                                             SH connection could not be established in 3 seconds$clr\n"
elif [[ $? = 5 ]]; then idxerror=$((idxerror+1)); echo -e "${red}Failed\n\n    S                                                                             SH connection could not be established, root password may have been changed$clr\                                                                             n"
elif [[ $readpos = $execpos ]]; then In_DB_status='Sync'
else In_DB_status='Desync'
fi

echo -e "readpos: $readpos , execpos: $execpos">>$log_file








echo -e "\n****************************************************************Index                                                                              Ratingen server health check***************************************************                                                                             ******************************\n">>$log_file


# 1. Checking system Status for Index Leganes


I12=`$sshconn_I2 "systemctl status | sed -n 1,5p | grep "running" | wc -l"`

echo -e "\nChecking system Status \n"

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e
echo -e "System Status .\n" >>$log_file

if [ $I12 -gt 0 ]
 then
   InR_System_status='Running'
   #echo -e $grn `systemctl status | sed -n 1,5p` $clr>>$log_file
else
   InR_System_status='Not Running'
   echo -e $grn `systemctl status | sed -n 1,5p` $clr>>$log_file
fi

echo -e "\n" >> log_file




# 2.    SQL service Checks

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\nSQL service Checks \n" | tee -a "$log_file"


mysql_status=`$sshconn_I2 "systemctl status mysqld | grep "Active*" | wc -l"`

if [ $mysql_status -gt 0 ]
 then
   InR_SQL_status=`$sshconn_I2 "systemctl status mysqld | grep Active | cut -d '                                                                             )' -f 1" | cut -d ':' -f 2 `')'
   #echo -n $grn `systemctl status mysqld | grep "Active*"` $clr >>$log_file
 else
  InR_SQL_status='Inactive'
   echo -e $red "There may be issue. Please check status of SQL services manuall                                                                             y. \n" $clr>>$log_file
 fi


 # 3.   INDEX PORT LISTENING
echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\nIndex server mysql service  status \n" | tee -a "$log_file"

echo -e $grn `$sshconn_I2 "netstat -tulpn | grep mysqld "` $clr>>$log_file

mysql_portstatus=`$sshconn_I2 "netstat -tulpn | grep "mysqld" | awk '{print $6}'                                                                              | grep "LISTEN" | wc -l"`

if [ $mysql_portstatus -gt 0 ]
 then
   InR_mysql_port='Listening'

 else
   InR_mysql_port='Not Listening'
   echo -e $red"There may be issue. Please check mysqld service port. \n"$clr>>$                                                                             log_file
fi

# 4. firewall service Status

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\nfirewall Service status \n" | tee -a "$log_file"



fwall_status=`$sshconn_I2 "systemctl status firewalld | grep Active | wc -l" `


if [ $fwall_status -gt 0 ]
 then
   InR_fwall_status=`$sshconn_I2 "systemctl status firewalld | grep Active | cut                                                                              -d ')' -f 1" | cut -d ':' -f 2 `')'

 else
  InR_fwall_status='Inactive'
   echo -e $red "firewall service may not be running properly. Please check manu                                                                             ally (systemctl status firewalld )\n" $clr>>$log_file
 fi

$sshconn_I2 "systemctl status firewalld | grep Active">>$log_file




#4.     DB Sync
echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\nDB Sync status \n" | tee -a "$log_file"

#echo -e $grn `mysql -u$userid -p$password ipcr_db -se "show slave status \G;" |                                                                              grep -e  "Slave_IO_Running*" -e "Slave_SQL_Running: *"` $clr >>$log_file

read readpos execpos < <($sshconn_I2 "mysql -uroot -p@dmIn123 ipcr_db -se \"show                                                                              slave status \G;\" 2>/dev/null | sed -n '/Read_Master_Log_Pos/s/.*: \([0-9]\+\)                                                                             /\1/p; /Exec_Master_Log_Pos/s/.*: \([0-9]\+\)/\1/p' | paste -sd ' '")
if [[ $? = 1 ]]; then idxerror=$((idxerror+1)); echo -e "${red}Failed\n\n    SSH                                                                              connection could not be established in 3 seconds$clr\n"
        elif [[ $? = 5 ]]; then idxerror=$((idxerror+1)); echo -e "${red}Failed\                                                                             n\n    SSH connection could not be established, root password may have been chan                                                                             ged$clr\n"
        elif [[ $readpos = $execpos ]]; then InR_DB_status='Sync'
        else InR_DB_status='Desync'
fi

echo -e "readpos: $readpos , execpos: $execpos">>$log_file


#6. recording stuck for more than 24 hours
echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\Details of Recordings in last 24 hours \n" | tee -a "$log_file"


Stuck_24=`$sshconn_I2 "mysql -H -uroot -p@dmIn123 ipcr_db -se \"select a.account                                                                             _name as Database_Name  , CASE WHEN a.account_name='barclaysnmr86'  THEN 'Barcla                                                                             ys'
 WHEN a.account_name='VONECEU034'       THEN 'Iron Mountain'
 WHEN a.account_name='morganstanley112' THEN 'Morgan Stanley (Production 1)'
 WHEN a.account_name='lloyds76' THEN 'Lloyds '
 WHEN a.account_name='macqb101' THEN 'Macquarie'
 WHEN a.account_name='RBS'    THEN 'Royal Bank of Scotland '
 WHEN a.account_name='customer46'       THEN 'Test customer'
 WHEN a.account_name='BNPP'     THEN 'BNPP'
 WHEN a.account_name='dekab109' THEN 'Deka Bank '
 WHEN a.account_name='spwnmr107'        THEN 'Schroders Personal Wealth'
 WHEN a.account_name='efg47'    THEN 'EFG Bank'
 WHEN a.account_name='slanr110' THEN 'SLA Standard Life Aberdeen'
 WHEN a.account_name='nmrcust81'        THEN 'Julius Baer Bank'
 WHEN a.account_name='nmrpb115' THEN 'Wells Fargo'
 WHEN a.account_name='legen118' THEN 'Legal General'
 WHEN a.account_name='BancaIMI' THEN 'Banca IMI '
 WHEN a.account_name='ingbk108' THEN 'ING Netherlands'
 WHEN a.account_name='nmr94094' THEN 'Rathbones'
 WHEN a.account_name='mizuhoint24'      THEN 'Mizuho Bank Ltd'
 WHEN a.account_name='ShellUK114'       THEN 'Shell '
 WHEN a.account_name='glenc105' THEN 'Glencore'
 WHEN a.account_name='nmrcust84'        THEN 'Berenberg Bank'
 WHEN a.account_name='tbank117' THEN 'The Toronto Dominion Bank (TD Bank)'
 WHEN a.account_name='VONECUK067'       THEN 'CR3_EssarOIL_LVR '
 WHEN a.account_name='nmrcust90'        THEN 'Artemis'
 WHEN a.account_name='gillp100' THEN 'Generation Investment Management LLP'
 WHEN a.account_name='eninmr129'        THEN 'ENI'
 WHEN a.account_name='aviva45'  THEN 'Aviva PLC'
 WHEN a.account_name='msta2119' THEN 'Morgan Stanley Production2'
 WHEN a.account_name='vgetrial66'       THEN 'Trial_C66 (used by Sales)_PoC '
 WHEN a.account_name='nmrcust93'        THEN 'Morningstar'
 WHEN a.account_name='KamesCapital77'   THEN 'Kames Capital PLC'
 WHEN a.account_name='VONECUK017-CL4'   THEN 'Travis Perkins'
 WHEN a.account_name='Mizuho'   THEN 'Mizuho'
 WHEN a.account_name='Customer14'       THEN 'PROD TEST CUST (Trial_C14 (used by                                                                              Sales))  '
 WHEN a.account_name='VONECUK086'       THEN 'Ballyvessy_LVR'
 WHEN a.account_name='mitsubishisecurities83'   THEN 'Mitsubishi UFJ Financial G                                                                             roup'
 WHEN a.account_name='VONECUK003'       THEN 'PROD TEST CUST (Trial_C03 (used by                                                                              Engineering)_LVR_UK)'
 WHEN a.account_name='System'   THEN 'PROD TEST CUST '
 WHEN a.account_name='nmrcust7878'      THEN 'Partners Group(Cust 78)'
 WHEN a.account_name='volkr106' THEN 'Volker'
 WHEN a.account_name='INEOS116' THEN 'INEOS (Inovyn Chlorvinyls Limited)'
 WHEN a.account_name='VodafoneTrial'    THEN 'PROD TEST CUST (Trial_C15 (used by                                                                              Ops&Sales)) '
 WHEN a.account_name='wpear102' THEN 'William Pears'
 WHEN a.account_name='centrica48'       THEN 'Centrica'
 WHEN a.account_name='VONECEU020'       THEN 'ENGG TEST CUST ( Trial_C20 (used b                                                                             y Engineering)_LVR_EU )'
 WHEN a.account_name='customer26'       THEN 'customer26'
 WHEN a.account_name='nmrcust95'        THEN 'Not Live '
 WHEN a.account_name='BNY-mellonNMR79'  THEN 'Bank of New York Mellon'
 WHEN a.account_name='Customer18'       THEN 'PROD TEST CUST (Trial_C18 (used by                                                                              Sales) )'
 WHEN a.account_name='ondra103' THEN 'Ondra LLP'
 WHEN a.account_name='bank-of-montreal49'       THEN 'Bank of Montreal'
 WHEN a.account_name='rwepo120' THEN 'RWE'
 WHEN a.account_name='Gazprom'  THEN 'Gazprom'
 WHEN a.account_name='customer27'       THEN 'PROD TEST CUST '
 WHEN a.account_name='nmrcust96'        THEN 'Not Live '
 WHEN a.account_name='British Petroleum'        THEN 'British Petroleum'
 WHEN a.account_name='smith44'  THEN 'Smith & Williamson'
 WHEN a.account_name='SLS TEST PLATFORM - CUST43'       THEN 'SLS TEST PLATFORM                                                                              - CUST43'
 WHEN a.account_name='cairn104' THEN 'Cairn Capital Group'
 else a.account_name
END AS Customer_Name, second.Total as 'Total Recordings' , COALESCE(first.count,                                                                             0) as Stuck_Recording_Count  from (select sum(c.number_of_calls_recorded) as 'To                                                                             tal', a.account_id as ss from call_stats c INNER JOIN route_config r on c.route_                                                                             id=r.route_id  INNER JOIN accounts a on r.account_id = a.account_id and call_dat                                                                             e = DATE_SUB(CURDATE(),INTERVAL 1 DAY)  group by c.route_id) as second LEFT JOIN                                                                              (select count(*) as count , a.account_id as ff  from recordings r, accounts a w                                                                             here r.account_code=a.account_id and start_time >= DATE_SUB(CURDATE(),INTERVAL 1                                                                              DAY) and start_time < CURDATE() group by r.account_code) as first ON first.ff =                                                                              second.ss INNER JOIN accounts a ON a.account_id = second.ss order by second.Tot                                                                             al DESC;\" "`


#4.     To Check details of Recordings for today

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\nCount of Recordings for accounts for today \n" | tee -a "$log_file"

Stuck_today=`$sshconn_I2 "mysql -H -uroot -p@dmIn123 ipcr_db -se \" select a.acc                                                                             ount_name as Database_Name  , CASE WHEN a.account_name='barclaysnmr86'  THEN 'Ba                                                                             rclays'
 WHEN a.account_name='VONECEU034'       THEN 'Iron Mountain'
 WHEN a.account_name='morganstanley112' THEN 'Morgan Stanley (Production 1)'
 WHEN a.account_name='lloyds76' THEN 'Lloyds '
 WHEN a.account_name='macqb101' THEN 'Macquarie'
 WHEN a.account_name='RBS'    THEN 'Royal Bank of Scotland '
 WHEN a.account_name='customer46'       THEN 'Test customer'
 WHEN a.account_name='BNPP'     THEN 'BNPP'
 WHEN a.account_name='dekab109' THEN 'Deka Bank '
 WHEN a.account_name='spwnmr107'        THEN 'Schroders Personal Wealth'
 WHEN a.account_name='efg47'    THEN 'EFG Bank'
 WHEN a.account_name='slanr110' THEN 'SLA Standard Life Aberdeen'
 WHEN a.account_name='nmrcust81'        THEN 'Julius Baer Bank'
 WHEN a.account_name='nmrpb115' THEN 'Wells Fargo'
 WHEN a.account_name='legen118' THEN 'Legal General'
 WHEN a.account_name='BancaIMI' THEN 'Banca IMI '
 WHEN a.account_name='ingbk108' THEN 'ING Netherlands'
 WHEN a.account_name='nmr94094' THEN 'Rathbones'
 WHEN a.account_name='mizuhoint24'      THEN 'Mizuho Bank Ltd'
 WHEN a.account_name='ShellUK114'       THEN 'Shell '
 WHEN a.account_name='glenc105' THEN 'Glencore'
 WHEN a.account_name='nmrcust84'        THEN 'Berenberg Bank'
 WHEN a.account_name='tbank117' THEN 'The Toronto Dominion Bank (TD Bank)'
 WHEN a.account_name='VONECUK067'       THEN 'CR3_EssarOIL_LVR '
 WHEN a.account_name='nmrcust90'        THEN 'Artemis'
 WHEN a.account_name='gillp100' THEN 'Generation Investment Management LLP'
 WHEN a.account_name='eninmr129'        THEN 'ENI'
 WHEN a.account_name='aviva45'  THEN 'Aviva PLC'
 WHEN a.account_name='msta2119' THEN 'Morgan Stanley Production2'
 WHEN a.account_name='vgetrial66'       THEN 'Trial_C66 (used by Sales)_PoC '
 WHEN a.account_name='nmrcust93'        THEN 'Morningstar'
 WHEN a.account_name='KamesCapital77'   THEN 'Kames Capital PLC'
 WHEN a.account_name='VONECUK017-CL4'   THEN 'Travis Perkins'
 WHEN a.account_name='Mizuho'   THEN 'Mizuho'
 WHEN a.account_name='Customer14'       THEN 'PROD TEST CUST (Trial_C14 (used by                                                                              Sales))  '
 WHEN a.account_name='VONECUK086'       THEN 'Ballyvessy_LVR'
 WHEN a.account_name='mitsubishisecurities83'   THEN 'Mitsubishi UFJ Financial G                                                                             roup'
 WHEN a.account_name='VONECUK003'       THEN 'PROD TEST CUST (Trial_C03 (used by                                                                              Engineering)_LVR_UK)'
 WHEN a.account_name='System'   THEN 'PROD TEST CUST '
 WHEN a.account_name='nmrcust7878'      THEN 'Partners Group(Cust 78)'
 WHEN a.account_name='volkr106' THEN 'Volker'
 WHEN a.account_name='INEOS116' THEN 'INEOS (Inovyn Chlorvinyls Limited)'
 WHEN a.account_name='VodafoneTrial'    THEN 'PROD TEST CUST (Trial_C15 (used by                                                                              Ops&Sales)) '
 WHEN a.account_name='wpear102' THEN 'William Pears'
 WHEN a.account_name='centrica48'       THEN 'Centrica'
 WHEN a.account_name='VONECEU020'       THEN 'ENGG TEST CUST ( Trial_C20 (used b                                                                             y Engineering)_LVR_EU )'
 WHEN a.account_name='customer26'       THEN 'customer26'
 WHEN a.account_name='nmrcust95'        THEN 'Not Live '
 WHEN a.account_name='BNY-mellonNMR79'  THEN 'Bank of New York Mellon'
 WHEN a.account_name='Customer18'       THEN 'PROD TEST CUST (Trial_C18 (used by                                                                              Sales) )'
 WHEN a.account_name='ondra103' THEN 'Ondra LLP'
 WHEN a.account_name='bank-of-montreal49'       THEN 'Bank of Montreal'
 WHEN a.account_name='rwepo120' THEN 'RWE'
 WHEN a.account_name='Gazprom'  THEN 'Gazprom'
 WHEN a.account_name='customer27'       THEN 'PROD TEST CUST '
 WHEN a.account_name='nmrcust96'        THEN 'Not Live '
 WHEN a.account_name='British Petroleum'        THEN 'British Petroleum'
 WHEN a.account_name='smith44'  THEN 'Smith & Williamson'
 WHEN a.account_name='SLS TEST PLATFORM - CUST43'       THEN 'SLS TEST PLATFORM                                                                              - CUST43'
 WHEN a.account_name='cairn104' THEN 'Cairn Capital Group'
 else a.account_name
END AS Customer_Name, second.Total as 'Total Recordings' , COALESCE(first.count,                                                                             0) as 'Stuck Recording Count'  from (select sum(c.number_of_calls_recorded) as '                                                                             Total', a.account_id as ss from call_stats c INNER JOIN route_config r on c.rout                                                                             e_id=r.route_id  INNER JOIN accounts a on r.account_id = a.account_id and call_d                                                                             ate = CURDATE()  group by c.route_id) as second LEFT JOIN (select count(*) as co                                                                             unt , a.account_id as ff  from recordings r, accounts a where r.account_code=a.a                                                                             ccount_id and start_time >= CURDATE() and (start_time <= now() - interval 60 min                                                                             ute) group by r.account_code) as first ON first.ff = second.ss INNER JOIN accoun                                                                             ts a ON a.account_id = second.ss order by second.Total DESC; \" "`


#4.     To Check the count of Recordings for  account in Leganes

echo -e "\n=====================================================================                                                                             ===================================================================\n">>$log_fil                                                                             e

echo -e "\n\nCount of Recordings for accounts \n" | tee -a "$log_file"

IN2=`$sshconn_I2   "mysql -H -uroot -p@dmIn123 ipcr_db -e  \"select a.account_na                                                                             me as Database_Name, CASE WHEN a.account_name='barclaysnmr86'  THEN     'Barclay                                                                             s'
 WHEN a.account_name='VONECEU034'       THEN 'Iron Mountain'
 WHEN a.account_name='morganstanley112' THEN 'Morgan Stanley (Production 1)'
 WHEN a.account_name='lloyds76' THEN 'Lloyds '
 WHEN a.account_name='macqb101' THEN 'Macquarie'
 WHEN a.account_name='RBS'    THEN 'Royal Bank of Scotland '
 WHEN a.account_name='customer46'       THEN 'Test customer'
 WHEN a.account_name='BNPP'     THEN 'BNPP'
 WHEN a.account_name='dekab109' THEN 'Deka Bank '
 WHEN a.account_name='spwnmr107'        THEN 'Schroders Personal Wealth'
 WHEN a.account_name='efg47'    THEN 'EFG Bank'
 WHEN a.account_name='slanr110' THEN 'SLA Standard Life Aberdeen'
 WHEN a.account_name='nmrcust81'        THEN 'Julius Baer Bank'
 WHEN a.account_name='nmrpb115' THEN 'Wells Fargo'
 WHEN a.account_name='legen118' THEN 'Legal General'
 WHEN a.account_name='BancaIMI' THEN 'Banca IMI '
 WHEN a.account_name='ingbk108' THEN 'ING Netherlands'
 WHEN a.account_name='nmr94094' THEN 'Rathbones'
 WHEN a.account_name='mizuhoint24'      THEN 'Mizuho Bank Ltd'
 WHEN a.account_name='ShellUK114'       THEN 'Shell '
 WHEN a.account_name='glenc105' THEN 'Glencore'
 WHEN a.account_name='nmrcust84'        THEN 'Berenberg Bank'
 WHEN a.account_name='tbank117' THEN 'The Toronto Dominion Bank (TD Bank)'
 WHEN a.account_name='VONECUK067'       THEN 'CR3_EssarOIL_LVR '
 WHEN a.account_name='nmrcust90'        THEN 'Artemis'
 WHEN a.account_name='gillp100' THEN 'Generation Investment Management LLP'
 WHEN a.account_name='eninmr129'        THEN 'ENI'
 WHEN a.account_name='aviva45'  THEN 'Aviva PLC'
 WHEN a.account_name='msta2119' THEN 'Morgan Stanley Production2'
 WHEN a.account_name='vgetrial66'       THEN 'Trial_C66 (used by Sales)_PoC '
 WHEN a.account_name='nmrcust93'        THEN 'Morningstar'
 WHEN a.account_name='KamesCapital77'   THEN 'Kames Capital PLC'
 WHEN a.account_name='VONECUK017-CL4'   THEN 'Travis Perkins'
 WHEN a.account_name='Mizuho'   THEN 'Mizuho'
 WHEN a.account_name='Customer14'       THEN 'PROD TEST CUST (Trial_C14 (used by                                                                              Sales))  '
 WHEN a.account_name='VONECUK086'       THEN 'Ballyvessy_LVR'
 WHEN a.account_name='mitsubishisecurities83'   THEN 'Mitsubishi UFJ Financial G                                                                             roup'
 WHEN a.account_name='VONECUK003'       THEN 'PROD TEST CUST (Trial_C03 (used by                                                                              Engineering)_LVR_UK)'
 WHEN a.account_name='System'   THEN 'PROD TEST CUST '
 WHEN a.account_name='nmrcust7878'      THEN 'Partners Group(Cust 78)'
 WHEN a.account_name='volkr106' THEN 'Volker'
 WHEN a.account_name='INEOS116' THEN 'INEOS (Inovyn Chlorvinyls Limited)'
 WHEN a.account_name='VodafoneTrial'    THEN 'PROD TEST CUST (Trial_C15 (used by                                                                              Ops&Sales)) '
 WHEN a.account_name='wpear102' THEN 'William Pears'
 WHEN a.account_name='centrica48'       THEN 'Centrica'
 WHEN a.account_name='VONECEU020'       THEN 'ENGG TEST CUST ( Trial_C20 (used b                                                                             y Engineering)_LVR_EU )'
 WHEN a.account_name='customer26'       THEN 'customer26'
 WHEN a.account_name='nmrcust95'        THEN 'Not Live'
 WHEN a.account_name='BNY-mellonNMR79'  THEN 'Bank of New York Mellon'
 WHEN a.account_name='Customer18'       THEN 'PROD TEST CUST (Trial_C18 (used by                                                                              Sales) )'
 WHEN a.account_name='ondra103' THEN 'Ondra LLP'
 WHEN a.account_name='bank-of-montreal49'       THEN 'Bank of Montreal'
 WHEN a.account_name='rwepo120' THEN 'RWE'
 WHEN a.account_name='Gazprom'  THEN 'Gazprom'
 WHEN a.account_name='customer27'       THEN 'PROD TEST CUST '
 WHEN a.account_name='nmrcust96'        THEN 'Not Live '
 WHEN a.account_name='British Petroleum'        THEN 'British Petroleum'
 WHEN a.account_name='smith44'  THEN 'Smith & Williamson'
 WHEN a.account_name='SLS TEST PLATFORM - CUST43'       THEN 'SLS TEST PLATFORM                                                                              - CUST43'
 WHEN a.account_name='cairn104' THEN 'Cairn Capital Group'
 else a.account_name
END AS Customer_Name ,(select count(*) from recordings where account_code=a.acco                                                                             unt_id and start_time < curdate()) as Stuck_Recording_Count from accounts a orde                                                                             r by Stuck_Recording_Count DESC; \" "`







#7 Total Percent of recordings stuck

Total_recordings=`$sshconn_I2 "mysql -H -uroot -p@dmIn123 ipcr_db -se \"select (                                                                             select count(*) from cdr_remote) as 'Total Number of Recordings', (select count(                                                                             *) from cdr_remote where status!=0) as 'Total Recordings in ISR', ((select count                                                                             (*) from cdr_remote where status != 0) * 100.0 / (select count(*) from cdr_remot                                                                             e )) as 'Precent of Recording to be processed';\" "`



#8 calculate total recording for a day


tot_rec=`$sshconn_I2 "mysql -uroot -p@dmIn123 ipcr_db -se \"select COALESCE(sum(                                                                             number_of_calls_recorded),0) from call_stats where call_date >= CURDATE(); \" "                                                                              `
tot_stuck=`$sshconn_I2 "mysql -uroot -p@dmIn123 ipcr_db -se \"select count(*) fr                                                                             om recordings where start_time >= CURDATE() and start_time > now() - interval 30                                                                              minute ;\" "`
tot_formorethanhour=`$sshconn_I2 "mysql -uroot -p@dmIn123 ipcr_db -se \"select c                                                                             ount(*) from recordings where start_time >= CURDATE() and start_time <= now() -                                                                              interval 30 minute ;\" "`
if [ $tot_formorethanhour -gt 0 ]
 then
   tot_per=$(echo "scale=3; $tot_formorethanhour/$tot_rec*100" | bc)
 else
   tot_per=0
fi


_today="$(date -u '+%d-%m-%Y %T') UTC"

#9 Calculate total recording for yesterday
YESTERDAY=`TZ=GMT+24 date +%m/%d/%Y`


tot_rec_y=`$sshconn_I2 "mysql -uroot -p@dmIn123 ipcr_db -se \"select COALESCE(su                                                                             m(number_of_calls_recorded),0) from call_stats where call_date = DATE_SUB(CURDAT                                                                             E(),INTERVAL 1 DAY)  ; \" " `
tot_stuck_y=`$sshconn_I2 "mysql -uroot -p@dmIn123 ipcr_db -se \"select count(*)                                                                              from recordings where start_time >= DATE_SUB(CURDATE(),INTERVAL 1 DAY) and start                                                                             _time < CURDATE() ;\" "`
if [ $tot_rec_y -gt 0 ]
 then
   tot_per_y=$(echo "scale=3; $tot_stuck_y/$tot_rec_y*100" | bc)
 else
   tot_per_y=0
fi



_yesterday=`TZ=GMT+24 date +%d-%m-%Y`

echo -e "\n****************************************************************Memor                                                                             y Status prepare table structure************************************************                                                                             *****************\n">>$log_file

Mem_table='<h3 style="color:#A4204B;"> Memory Status </h3>
<TABLE tyle="border-collapse:separate;
border-spacing:500em; " BORDER=1>
<TR>
<TH>Server</TH>
<TH>Disk space Staus</TH>
<TH>Server</TH>
<TH>Disk space Status</TH>
</TR>
<TR style="margin-top:10px;">
<TD>RSS 1 Leganes</TD>
<TD style="white-space:pre-wrap; word-wrap:break-word">Mem_RSS1_Leganes
</TD>
<TD>RSS 2 Leganes</TD>
<TD style="white-space:pre-wrap; word-wrap:break-word">Mem_RSS2_Leganes
</TD>

</TR>
<TR style="margin-top:10px;">
<TD>RSS 1 Ratingen</TD>
<TD style="white-space:pre-wrap; word-wrap:break-word">Mem_RSS1_Ratingen</TD>
<TD>RSS 2 Ratingen</TD>
<TD style="white-space:pre-wrap; word-wrap:break-word">Mem_RSS2_Ratingen</TD>

</TR>
<TR>
<TD>RA Leganes</TD>
<TD style="white-space:pre-wrap; word-wrap:break-word">Mem_RA_Leganes</TD>
<TD>RA Ratingen</TD>
<TD style="white-space:pre-wrap; word-wrap:break-word">Mem_RA_Ratingen</TD>

</TR>
<TR>
<TD>Index Leganes</TD>
<TD style="white-space:pre-wrap; word-wrap:break-word">Mem_Index_Leganes</TD>
<TD>Index Ratingen</TD>
<TD style="white-space:pre-wrap; word-wrap:break-word">Mem_Index_Ratingen</TD>

</TR>
</TABLE>
<p>&nbsp;</p>
<p>&nbsp;</p>'



yesterday_table='<p>&nbsp;</p>
<p>&nbsp;</p>
<h3 style="color:#A4204B"> Recording Stats for Yesterday(_yesterday) </h3>
<TABLE BORDER=1>
<TR>
<TH>Total Recordings</TH>
<TH>Total Number of StuckRecordings</TH>
<TH>Per Of Stuck Recording</TH>
</TR>
<TR>
<TD>tot_rec_y</TD>
<TD>tot_stuck_y</TD>
<TD>tot_per_y</TD>
</TR>
</TABLE>
<p>&nbsp;</p>
<p>&nbsp;</p>'






echo -e "\n****************************************************************Index                                                                              Server health check Ends*******************************************************                                                                             *******************\n">>$log_file
#RS1L_Memory_status='Unknown'



# prepare report file
cp /home/ucslsind/NMR_Report/isr6dot4/monitoring/sample.html "$HTML_file"

perl -pi  -e "s/RS1L_Recorder_status/${RS1L_Recorder_status}/g ; s/RS1L_Converte                                                                             r_status/$RS1L_Converter_status/g ; s/RS1L_Tomcat_status/$RS1L_Tomcat_status/g ;                                                                              s/RS1L_Dbus_status/$RS1L_Dbus_status/g ; s/RS1L_System_status/$RS1L_System_stat                                                                             us/g ; s/RS1L_fwall_status/$RS1L_fwall_status/g ; s/RS1L_Memory_status/$RS1L_Mem                                                                             ory_status/g"  "$HTML_file">>"$HTML_file"
perl -pi  -e "s/RS2L_Recorder_status/$RS2L_Recorder_status/g ; s/RS2L_Converter_                                                                             status/$RS2L_Converter_status/g ; s/RS2L_Tomcat_status/$RS2L_Tomcat_status/g ; s                                                                             /RS2L_Dbus_status/$RS2L_Dbus_status/g ; s/RS2L_System_status/$RS2L_System_status                                                                             /g ; s/RS2L_fwall_status/$RS2L_fwall_status/g ; s/RS2L_Memory_status/$RS2L_Memor                                                                             y_status/g"  "$HTML_file">>$HTML_file
perl -pi  -e "s/RS2R_Recorder_status/${RS2R_Recorder_status}/g ; s/RS2R_Converte                                                                             r_status/$RS2R_Converter_status/g ; s/RS2R_Tomcat_status/$RS2R_Tomcat_status/g ;                                                                              s/RS2R_Dbus_status/$RS2R_Dbus_status/g ; s/RS2R_System_status/$RS2R_System_stat                                                                             us/g ; s/RS2R_fwall_status/$RS2R_fwall_status/g ; s/RS2R_Memory_status/$RS2R_Mem                                                                             ory_status/g"  "$HTML_file">>"$HTML_file"
perl -pi  -e "s/RS1R_Recorder_status/${RS1R_Recorder_status}/g ; s/RS1R_Converte                                                                             r_status/$RS1R_Converter_status/g ; s/RS1R_Tomcat_status/$RS1R_Tomcat_status/g ;                                                                              s/RS1R_Dbus_status/$RS1R_Dbus_status/g ; s/RS1R_System_status/$RS1R_System_stat                                                                             us/g ; s/RS1R_fwall_status/$RS1R_fwall_status/g ; s/RS1R_Memory_status/$RS1R_Mem                                                                             ory_status/g"  "$HTML_file">>"$HTML_file"
perl -pi  -e "s/R11_Recorder_status/${R11_Recorder_status}/g ; s/R11_Converter_s                                                                             tatus/$R11_Converter_status/g ; s/R11_Tomcat_status/$R11_Tomcat_status/g ; s/R11                                                                             _Dbus_status/$R11_Dbus_status/g ; s/R11_System_status/$R11_System_status/g ; s/R                                                                             11_fwall_status/$R11_fwall_status/g ; s/R11_Memory_status/$R11_Memory_status/g"                                                                               "$HTML_file">>"$HTML_file"
perl -pi  -e "s/R12_Recorder_status/${R12_Recorder_status}/g ; s/R12_Converter_s                                                                             tatus/$R12_Converter_status/g ; s/R12_Tomcat_status/$R12_Tomcat_status/g ; s/R12                                                                             _Dbus_status/$R12_Dbus_status/g ; s/R12_System_status/$R12_System_status/g ; s/R                                                                             12_fwall_status/$R12_fwall_status/g ; s/R12_Memory_status/$R12_Memory_status/g"                                                                               "$HTML_file">>"$HTML_file"


perl -pi -e "s/tot_rec/$tot_rec/g ; s/tot_stuck/$tot_stuck/g ; s/tot_per/$tot_pe                                                                             r/g ; s/_today/$_today/g ; s/tot_onehour/$tot_formorethanhour/g"  "$HTML_file">>                                                                             "$HTML_file"


perl -pi -e "s/In_System_status/$In_System_status/g ; s/In_SQL_status/$In_SQL_st                                                                             atus/g ; s/In_mysql_port/$In_mysql_port/g ; s/In_DB_status/$In_DB_status/g ; s/I                                                                             n_fwall_status/$In_fwall_status/g ; s/In_last_status/$In_last_status/g" "$HTML_f                                                                             ile">>"$HTML_file"
perl -pi -e "s/InR_System_status/$InR_System_status/g ; s/InR_SQL_status/$InR_SQ                                                                             L_status/g ; s/InR_mysql_port/$InR_mysql_port/g ; s/InR_DB_status/$InR_DB_status                                                                             /g ; s/InR_fwall_status/$InR_fwall_status/g ;  s/InR_last_status/$InR_last_statu                                                                             s/g" "$HTML_file">>"$HTML_file"



perl -pi -e "s/RAL_System_status/$RAL_System_status/g ; s/RAL_Cognia/$RAL_Cognia                                                                             /g ; s/RAL_Nice/$RAL_Nice/g ; s/RAL_Index/$RAL_Index/g ; s/RAL_fwall_status/$RAL                                                                             _fwall_status/g ; s/RAL_tomcat/$RAL_tomcat/g" "$HTML_file">>"$HTML_file"
perl -pi -e "s/RAR_System_status/$RAR_System_status/g ; s/RAR_Cognia/$RAR_Cognia                                                                             /g ; s/RAR_Nice/$RAR_Nice/g ; s/RAR_Index/$RAR_Index/g ; s/RAR_fwall_status/$RAR                                                                             _fwall_status/g ; s/RAR_tomcat/$RAR_tomcat/g" "$HTML_file">>"$HTML_file"

echo "<p>&nbsp;</p>">>$HTML_file
echo "<p>&nbsp;</p>">>$HTML_file
echo "<h3  style=\"color:#A4204B\" >Recording details for Today (until an hour a                                                                             go) </h3>">>$HTML_file
echo $Stuck_today >>$HTML_file

echo $yesterday_table >>$HTML_file
perl -pi -e "s/tot_rec_y/$tot_rec_y/g ; s/tot_stuck_y/$tot_stuck_y/g ; s/tot_per                                                                             _y/$tot_per_y/g ; s/_yesterday/$_yesterday/g"  "$HTML_file">>"$HTML_file"



echo "<h3  style=\"color:#A4204B\" >Recording details for Yesterday ($_yesterday                                                                             ) </h3>">>$HTML_file
echo $Stuck_24 >>$HTML_file

echo "<p>&nbsp;</p>">>$HTML_file
echo "<p>&nbsp;</p>">>$HTML_file
echo $Mem_table >>$HTML_file


perl -pi -e '$Mem_RSS1_Leganes=`cat /home/ucslsind/NMR_Report/isr6dot4/monitorin                                                                             g/mem_status/Mem_RSS_Leganes_Virtual.txt` ; s/Mem_RSS1_Leganes/"$Mem_RSS1_Legane                                                                             s"/g' "$HTML_file">>"$HTML_file"
perl -pi -e '$Mem_RSS_LHW=`cat /home/ucslsind/NMR_Report/isr6dot4/monitoring/mem                                                                             _status/Mem_RSS_Leganes_HW.txt` ; s/Mem_RSS2_Leganes/"$Mem_RSS_LHW"/g' "$HTML_fi                                                                             le">>"$HTML_file"
perl -pi -e '$Mem_RSS1_Ratingen=`cat /home/ucslsind/NMR_Report/isr6dot4/monitori                                                                             ng/mem_status/Mem_RSS_Ratingen_Virtual.txt` ; s/Mem_RSS1_Ratingen/"$Mem_RSS1_Rat                                                                             ingen"/g' "$HTML_file">>"$HTML_file"
perl -pi -e '$Mem_RSS_RHW=`cat /home/ucslsind/NMR_Report/isr6dot4/monitoring/mem                                                                             _status/Mem_RSS_Ratingen_HW.txt` ; s/Mem_RSS2_Ratingen/"$Mem_RSS_RHW"/g' "$HTML_                                                                             file">>"$HTML_file"
perl -pi -e '$Mem_RA_Leganes=`cat /home/ucslsind/NMR_Report/isr6dot4/monitoring/                                                                             mem_status/Mem_RA_Leganes.txt` ; s/Mem_RA_Leganes/"$Mem_RA_Leganes"/g' "$HTML_fi                                                                             le">>"$HTML_file"
perl -pi -e '$Mem_RA_Ratingen=`cat /home/ucslsind/NMR_Report/isr6dot4/monitoring                                                                             /mem_status/Mem_RA_Ratingen.txt` ; s/Mem_RA_Ratingen/"$Mem_RA_Ratingen"/g' "$HTM                                                                             L_file">>"$HTML_file"
perl -pi -e '$Mem_Index_Leganes=`cat /home/ucslsind/NMR_Report/isr6dot4/monitori                                                                             ng/mem_status/Mem_Index_Leganes.txt` ; s/Mem_Index_Leganes/"$Mem_Index_Leganes"/                                                                             g' "$HTML_file">>"$HTML_file"
perl -pi -e '$Mem_Index_Ratingen=`cat /home/ucslsind/NMR_Report/isr6dot4/monitor                                                                             ing/mem_status/Mem_Index_Ratingen.txt` ; s/Mem_Index_Ratingen/"$Mem_Index_Rating                                                                             en"/g' "$HTML_file">>"$HTML_file"




echo "<h3  style=\"color:#A4204B\" >Total Recordings to be Processed  </h3>">>$H                                                                             TML_file
echo $IN2 >>$HTML_file



echo "</body>" >>$HTML_file
echo "</html>" >>$HTML_file


echo "RS1L_Recorder_status : $RS1L_Recorder_status , RS1L_Converter_status : $RS                                                                             1L_Converter_status"
echo "check logs at $log_file and HTML at $HTML_file"

#  send email of report
content='Please find attached report for NMR platform 6.4. \n
The status shown are captured at time of script run. \n
Please find the design documents at https://vodafone.sharepoint.com/:f:/r/sites/                                                                             UnifiedCommunications2ndLineINDIA/Shared%20Documents/General/NMR%20Monitoring?cs                                                                             f=1&web=1&e=P3MIZ7 \n
\n\n\n



Thanks ,\n
Devops Team \n
UC SLS '

zip -j $zip_file $HTML_file


#( echo -e $content; uuencode "$HTML_file" "$NOW.html" ) | mailx -s "TEST 6.4 NM                                                                             R Platform Monitoring  ($NOW)" -c "$test" -r no_reply "$test"
( echo -e $content; uuencode "$HTML_file" "$NOW.html" ) | mailx -s "6.4 NMR Plat                                                                             form Monitoring  ($NOW)" -c "$cc_users" -r no-reply "$to_users"

#uuencode "$HTML_file" "$NOW.html" | mailx -s "NMR_Report_$NOW" -r no_reply "$us                                                                             ers"



H>
