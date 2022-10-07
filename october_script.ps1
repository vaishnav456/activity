main
function main{
    file_del
    en_admin
    script_start
    sys_info
    Set-ExecutionPolicy -ExecutionPolicy restricted
}

function script_start{
    main_logo
    echo "|****************************************************|"
    echo "|Please select following option defined IT Department|"
    echo "|****************************************************|"
    echo "|1. Change Hostname of System                        |"   
    echo "|2. Add user to the System                           |"
    echo "|3. Change group of the User                         |"
    echo "|4. Change username of the user                      |"
    echo "|****************************************************|"
    $choice=Read-Host
    if($choice -eq "1"){ 
        change_hostname
    }
    elseif($choice -eq "2"){
        adduser
    }
    elseif($choice -eq "3"){
        ch_group
    }
    elseif($choice -eq "4"){
        ch_username
    }
    else{
        Write-Warning -Message "Invalid Input"
    }
}


function sys_info{
    $label=Read-Host -Prompt "Please Enter the Label No-"
    $name=Read-Host -Prompt "Please Enter your name"
    mkdir -Name $label -Path files\$label\system-info
    date > files\$label\system-info\date.txt
    ipconfig /all > files\$label\system-info\ipconfig.txt
    Get-WmiObject win32_bios > files\$label\system-info\serial_number.txt
    Get-AppxPackage –AllUsers | Select Name, PackageFullName > files\$label\system-info\installed.txt
    Get-WmiObject -query ‘select * from SoftwareLicensingService’ > files\$label\system-info\windows_key.txt
    echo name > files\$label\system-info\done_by.txt
    clear
    
}



function main_logo{
    clear
    echo "##########_____####################_____####################_____###################_______###################_____####################_____##";
    echo "#########/\####\##################/\####\##################/\####\#################/::\####\#################/\####\##################/\####\#";
    echo "########/::\____\################/::\____\################/::\____\###############/::::\####\###############/::\####\################/::\____\";
    echo "#######/::::|###|###############/::::|###|###############/::::|###|##############/::::::\####\#############/::::\####\##############/:::/####/";
    echo "######/:::::|###|##############/:::::|###|##############/:::::|###|#############/::::::::\####\###########/::::::\####\############/:::/####/#";
    echo "#####/::::::|###|#############/::::::|###|#############/::::::|###|############/:::/~~\:::\####\#########/:::/\:::\####\##########/:::/####/##";
    echo "####/:::/|::|###|############/:::/|::|###|############/:::/|::|###|###########/:::/####\:::\####\#######/:::/##\:::\####\########/:::/####/###";
    echo "###/:::/#|::|###|###########/:::/#|::|###|###########/:::/#|::|###|##########/:::/####/#\:::\####\#####/:::/####\:::\####\######/:::/####/####";
    echo "##/:::/##|::|___|______####/:::/##|::|___|______####/:::/##|::|___|______###/:::/____/###\:::\____\###/:::/####/#\:::\####\####/:::/####/#####";
    echo "#/:::/###|::::::::\####\##/:::/###|::::::::\####\##/:::/###|::::::::\####\#|:::|####|#####|:::|####|#/:::/####/###\:::\####\##/:::/####/######";
    echo "/:::/####|:::::::::\____\/:::/####|:::::::::\____\/:::/####|:::::::::\____\|:::|____|#####|:::|####|/:::/____/#####\:::\____\/:::/____/#######";
    echo "\::/####/#~~~~~/:::/####/\::/####/#~~~~~/:::/####/\::/####/#~~~~~/:::/####/#\:::\####\###/:::/####/#\:::\####\######\::/####/\:::\####\#######";
    echo "#\/____/######/:::/####/##\/____/######/:::/####/##\/____/######/:::/####/###\:::\####\#/:::/####/###\:::\####\######\/____/##\:::\####\######";
    echo "#############/:::/####/###############/:::/####/###############/:::/####/#####\:::\####/:::/####/#####\:::\####\###############\:::\####\#####";
    echo "############/:::/####/###############/:::/####/###############/:::/####/#######\:::\__/:::/####/#######\:::\####\###############\:::\####\####";
    echo "###########/:::/####/###############/:::/####/###############/:::/####/#########\::::::::/####/#########\:::\####\###############\:::\####\###";
    echo "##########/:::/####/###############/:::/####/###############/:::/####/###########\::::::/####/###########\:::\####\###############\:::\####\##";
    echo "#########/:::/####/###############/:::/####/###############/:::/####/#############\::::/####/#############\:::\####\###############\:::\####\#";
    echo "########/:::/####/###############/:::/####/###############/:::/####/###############\::/____/###############\:::\____\###############\:::\____\";
    echo "########\::/####/################\::/####/################\::/####/#################~~######################\::/####/################\::/####/";
    echo "#########\/____/##################\/____/##################\/____/###########################################\/____/##################\/____/#";
    echo "##############################################################################################################################################";
    echo "This script is created by IT department of MMMOCL"
}



function change_hostname{
    $h_name=Read-Host -Prompt "Please Enter the hostname you want to change to"
    Rename-Computer -NewName "$h_name" 
    script_start
}

function adduser{
    $user_name=Read-Host -Prompt "Please Enter the username"
    $pass_word= Read-Host -AsSecureString -Prompt "Please Enter the Password"
    New-LocalUser -Name $user_name -Password $pass_word -AccountNeverExpires -PasswordNeverExpires 
    script_start
}

function ch_group{
    $user_name=Read-Host -Prompt "Please Enter the username you want to move to Users group"
    Remove-LocalGroupMember -Group Administrators -Member $user_name
    Add-LocalGroupMember -Group Users -Member $user_name 
    script_start
}

function ch_username{
    $main_user=Read-Host -Prompt "Enter the old username"
    $change_user=Read-Host -Prompt "Enter the new username"
    Rename-LocalUser -Name $main_user -NewName $change_user 
    script_start
}

function en_admin{
    Enable-LocalUser -Name Administrator
    Set-LocalUser -Name Administrator -AccountNeverExpires -Password M3Ocl@202$ -PasswordNeverExpires True -UserMayChangePassword True
}

function file_del{
    rm C:\Windows\Temp\*
    rm C:\Windows\Prefetch\*
    rm C:\Users\vaish\AppData\Local\Temp\*
}