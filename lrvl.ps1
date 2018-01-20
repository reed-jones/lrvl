###########################
# lrvl.ps1 by Reed Jones
# Laravel installer
# Jan 20, 2018
###########################

param(
  [string] $vm,
  [string] $new
)
# Prefered development TLD
$tld = '.test'
function startUp {
  If (!$vm -and $new) {
    newProject
  }
  ElseIf (!$new -and $vm) {
    vagrantController
  }
  Else {
    Write-Host "Sorry, command not understood. Options include:
    -new {siteName}
    -vm {go/connect/destroy}"
  }
}

# Vagrant Controlls
$siteUrl = $(Get-Location | Split-Path -Leaf)
function vagrantController {
  switch -regex ($vm) {
    "^up?$" { vagrantUp }
    "^go?$" { vagrantGo }
    "^s(sh)?$" { vagrantSSH }
    "^st(atus)?$" { vagrantStatus }
    "^d(estroy)?$" { vagrantDestroy }
    default { & Write-Host "vagrant command not understood" }
  }
}
function vagrantUp {
  & Write-Host "vagrant up"
  & vagrant up
}
function vagrantGo {
  & Write-Host "vagrant starting"
  & vagrant up
  # open URL in defualt browser
  (New-Object -Com Shell.Application).Open("http://$($siteurl)$($tld)")
  & vagrantSSH
}

function vagrantSSH {
  & Write-Host "vagrant ssh"
  & vagrant ssh
}

function vagrantStatus {
  & Write-Host "vagrant status"
  & vagrant status
}
function vagrantDestroy {
  & Write-Host "vagrant destroying"
  & vagrant destroy --force
}

# Laravel Create New Project
function newProject {

  #  Create new laravel project
  & composer  create-project --prefer-dist laravel/laravel $new

  # cd into new folder
  & Set-Location $new

  # install homestead
  & composer require laravel/homestead --dev

  # init homestead
  & vendor\\bin\\homestead make

  # replace default domain with project-name
  $here = (Get-Item -Path ".\" -Verbose).FullName
  $content = [System.IO.File]::ReadAllText("$($here)\Homestead.yaml").Replace("homestead.test", "$($new)$($tld)")
  [System.IO.File]::WriteAllText("$($here)\Homestead.yaml", $content)

  # auto hostsfile magic
  & Add-Content -Encoding UTF8 C:\Windows\system32\drivers\etc\hosts "192.168.10.10 `t$($new)$($tld) `t# reeds powershell magic"

  # if available globally, don't need to copy
  & Copy-Item -Path ..\lrvl.ps1 -Destination .\

  # friendly output
  & Write-Host "
/*********************************************************************/
 | After configuring your Homestead.yaml file to your liking
 | simply start the vm and connect with
 | '.\lrvl -vm go'
 | and destroy with
 | '.\lrvl -vm destroy"

  # start VSCode
  & code .
}

startUp
