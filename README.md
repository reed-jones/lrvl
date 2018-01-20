# lrvl - a short and sweet laravel installer for windows
Laravel, Vagrant, Homestead, and automatic host file powershell helper (only tested on my own Windows 10 box, YMMV)


lrvl is an unofficial alternative command line laravel installer script for windows. It makes a few assumptions, such as you have VirtualBox and vagrant installed already, your editor of choice is VSCode, and your prefered test TLD is '.test'.

Usage is pretty simply, just copy lrvl.ps1 into your prefered web root folder on your computer, then from powershell (I recommend checking out [cmder](http://cmder.net/)) create a new project using `.\lrvl -new myProject`. The script will run off, installing all the things into the myProject folder, `cd` into it, and open up your editor. It will also make a copy of `lrvl` so that you can use all the vagrant shortcuts in your project folder. Feel free to look over and update your [Homestead.yaml](https://laravel.com/docs/5.5/homestead) file as you would like now. notice your ` sites: map: ` is configured for your URL, as an aside an entry as been added to your hosts file also. start it up with `.\lrvl -vm go` (this will take awhile as we wait for vagrant). Your browser should open up to myProject.com, and your command line will be ssh'd into your vagrant box. When your done, just `exit` your ssh connection and `.\lrvl -vm destroy` to shutdown the server.

## Again, steps are:
- `.\lrvl -n myProject`
- `.\lrvl -v g`
- // Do Your Work
- `.\lrvl -v d`

## full list of commands as follows:

| command | shortcode | usage                | action                                |
| ------- | --------- | -------------------- | ------------------------------------- |
| -new    | -n        | .\lrvl -n myProject  | Creates a new project                 |
| -vm     | -v        | .\lrvl -v up?        | vagrant up                            |
| -vm     | -v        | .\lrvl -v go?        | vagrant up, open browser, vagrant ssh |
| -vm     | -v        | .\lrvl -v s(sh)?     | vagrant ssh                           |
| -vm     | -v        | .\lrvl -v st(atus)?  | vagrant status                        |
| -vm     | -v        | .\lrvl -v d(estroy)? | vagrant destroy --force               |

Its probably worth pointing out that there arent any safe guards currently in place, so making a new project inside your current project probably works, but doesn't make any sense, same with running and of the vagrant (vm) commands outside of a specific project folder.
