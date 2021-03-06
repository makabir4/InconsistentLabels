$datasets = @("zeppelin","shiro","maven","flume","mahout")
#$datasets = @("zeppelin")

foreach($project in $datasets)
{
    write-host "now doing $($project)"
    $filelist = Get-ChildItem D:\workspace\mixed-workspace\mySZZ\buggyFileAndLineNum_from_git_show\$($project)
    foreach($single_file in $filelist){
        write-host "=========$($single_file)========="
        $k = 1
        $this_version = 0
        $dir = $($single_file).Name
        $file = Get-Content "D:\workspace\mixed-workspace\mySZZ\buggyFileAndLineNum_from_git_show\$($project)\$($single_file)"
        $commitsha = $($dir).Substring($dir.LastIndexOf("_")+1,$dir.LastIndexOf(".")-$dir.LastIndexOf("_")-1)
        $logPath = "D:\workspace\mixed-workspace\mySZZ\git_blame_l_from_buggyFileAndLineNum\$($project)\$($project)_$($commitsha)_pre.txt"
        $data_gitBlame = ''
        foreach($commitid in $file){
            #$logPath = "D:\workspace\mixed-workspace\mySZZ\git_blame_l_from_buggyFileAndLineNum\$($project)\$($project)_$($commitsha)_pre_$($k).txt"
            write-host "======$($logPath)======"
        	#if( !(Test-Path $logPath ))
        	#{
        	write-host "write $($project) git blame -l .txt"
                #write-host "$commitid"#文件中一行，包括-L，commit的sha值，文件名

	$array = $commitid.Split(" ")
                $blameline = $array[0]
	$commitsha_pre = $array[1]
	$filedir = $array[2]
	#$time_bugFixing = $array[3]+' '+$array[4]

                #write-host "$blameline"
                #write-host "$commitsha_pre"
                #write-host "$filedir"#最后的文件名
                #write-host "$time_bugFixing"

	cd D:\workspace\mixed-workspace\mySZZ\GitRepository\$project
	#write-host "===$this_version==="
                #if($commitsha -ne $this_version)
                #{
                    #git reset --hard $commitsha#会自动打印回退到的提交
                #}
                #$this_version = $commitsha
                #git log -L $blamelinetoline > $($logPath)

	$data_gitBlame += git blame -l -f -L $blameline $commitsha_pre $filedir
	$data_gitBlame +=  "`r`n"
	#$data_gitBlame = $data_gitBlame+' '+$time_bugFixing
	#write-output $data_gitBlame > $($logPath)#如果是向文件附加必须是双箭头>>，不然会清空原文件内容

        	#}
            $k = $k + 1
        }
        write-output $data_gitBlame > $($logPath)#如果是向文件附加必须是双箭头>>，不然会清空原文件内容
    }
}
cd D:\workspace\mixed-workspace\mySZZ\git_blame_l_from_buggyFileAndLineNum
write-host "End..."