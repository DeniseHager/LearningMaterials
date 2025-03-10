<#
Convert an IIS Log file to a Comma Seperated Values (CSV) file.

################################# Convert an IIS access log to a Comma Seperated Values CSV file
Uncomment this to use parameter passing
#>

If($args.count -lt 1){
"Please supply the path to the log file"
exit
}

If (!(test-path $args[0] )){
"Invalid log file path"
exit
}


$a=1  #this will become an element counter and will be used to track the location in the array
$WebLog=get-content $args[0]

$foundFields=$False #this will be a control variable.  It will tell me if the fields have already been processed.
                    #the log file may have more than one of these header lines, I only want one of them in my csv file

foreach ($line in $Weblog){
    If ($line.StartsWith("#Fields:")){

        If ($foundFields -eq $false){
            $HeaderLine=$line -replace "#Fields: ",""
            $HeaderLine=$HeaderLine -replace " ", ","
            $HeaderLine | Out-File .\u_ex151006.csv -Encoding ascii
            $foundFields=$true
        }
    }
 <#split the values of the log entry strings up into an array.  Find the elements that contain the User-agent
 strings that include "*,*" in them and encase these values in "" 
 #>
		
    If (-not $Line.StartsWith("#")){  #<----if it doesn't start with a # then it's a log entry string
 	$logEntry=$Line -split " "  #split the string into an array
        foreach ($_ in $LogEntry){
            if ($_ -like "*,*"){
				$_='"'+$_+'"'  
            }
            If ($a -lt $logentry.count){ #if its not the last element, put a comma at the end
                $LogEntryString+=$_+',' 
            }
            else{
                $LogEntryString+=$_  #if its the last element, no comma
            }
                $a++ #increment the element count 
        }
			
        $LogEntryString | out-file .\u_ex151006.csv -Append -Encoding ascii #add the modified output to the file
        $logEntryString=$null  #clear the output string for the next log entry
        $a=1 #reset the element counter			   
	}	   

}
