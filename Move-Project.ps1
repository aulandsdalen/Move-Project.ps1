param([string]$projectName = "project")
$baseDirectory = "C:\Users\aulandsdalen\Documents\ucheba\code"
$gitDirectory = "C:\Users\aulandsdalen\Documents\ucheba\code\github"
Write-Host "Project = $projectName"
Write-Host "$baseDirectory\$projectName"
Get-ChildItem "$baseDirectory\$projectName"
Copy-Item "$baseDirectory\$projectName\main.c" "$gitDirectory\$projectName.c"
Get-ChildItem "$gitDirectory"
Set-Location "$gitDirectory"
git add ".\$projectName.c"
$gitStatus = git status --porcelain
if ($gitStatus) {
    Write-Host "This is probably a new file, will commit now"
    $commitMessage = Read-Host -Prompt "Commit message"
    git commit -m $commitMessage
    $yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", "Pushes newly added file to remote origin"
    $no = New-Object System.Management.Automation.Host.ChoiceDescription "&No", "No, let me push my commit myself"
    $options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)
    switch ($host.ui.PromptForChoice("Push to remote now?", "'git push origin master'", $options, 0)) {
        0 { #YES
            git push origin master
        }
        1 { #NO
            Write-Host "OK, exiting..."
        }
    }
}