# Get Last Used DP
$searchtext = " successfully processed download completion."
$file = "c:\Windows\CCM\Logs\ContentTransferManager.log"
if (Test-Path $file){
    if (Get-Content $file | Select-String -Pattern $searchtext -Quiet){
        $StrResult = (Get-Content $file | Select-String -Pattern $searchtext | Select-Object -Last 1).ToString()
        if($StrResult){
            $LastCTMid = $StrResult.SubString(1,$StrResult.IndexOf('}')) | ForEach-Object{$_.Replace($_.SubString(0,$_.IndexOf('{')),'')}
        }
            
        $searchtext2 = "CTM job $LastCTMid switched to location "
        $StrResult2 = ""
        $StrResult2 = (Get-Content $file | Select-String -Pattern $searchtext2 -SimpleMatch | Select-Object -Last 1)
                     
        If($StrResult2){
            $StrResult2 = $StrResult2.ToString()
            $LastDP = $StrResult2.Split('/')[2]}
        Else{
                
            $searchtext3 = "CTM job $LastCTMid (corresponding DTS job {"
            $StrResult3 = ""
            $StrResult3 = (Get-Content $file | Select-String -Pattern $searchtext3 -SimpleMatch | Select-Object -Last 1)
            If($StrResult3){
                $StrResult3 = $StrResult3.ToString()
                $LastDP = $StrResult3.Split('/')[2]
            }
        }
    }
    }
$LastDP