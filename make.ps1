function Add-Zip
{
    param([string]$zipfilename)

    if(-not (test-path($zipfilename)))
    {
        set-content $zipfilename ("PK" + [char]5 + [char]6 + ("$([char]0)" * 18))
        (dir $zipfilename).IsReadOnly = $false
    }

    $shellApplication = new-object -com shell.application
    $zipPackage = $shellApplication.NameSpace($zipfilename)

    foreach($file in $input)
    {
            $zipPackage.CopyHere($file.FullName)
            Start-sleep -milliseconds 500
    }
}

dir src\* | Add-Zip ((Convert-Path .) + '\tab_manager.zip')
Move-Item tab_manager.zip tab_manager.xpi -Force

