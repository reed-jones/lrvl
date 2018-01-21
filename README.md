# lrvl - a short and sweet laravel installer for windows
Based on Laravel, Vagrant, Homestead, and automatically configures adds to your Host file, making your new laravel project available at yourProject.test (only tested on my own Windows 10 box, YMMV)

## About

lrvl is an unofficial alternative command line laravel installer script for windows. It makes a few assumptions, such as you have VirtualBox and vagrant installed already, your editor of choice is VSCode, and your prefered test TLD is '.test'.

To install, git clone this repo somewhere nice, then for convenience, add that path to your Environment Variables. Now the lrvl command should be available everywhere.

Usage is pretty simply, from your prefered web root folder on your computer, using the powershell commandline (I recommend checking out [cmder](http://cmder.net/)) create a new project using `lrvl -new myProject`. The script will run off, installing all the things into the `myProject` folder, `cd` into it, and open up your editor. Feel free to look over and update your [Homestead.yaml](https://laravel.com/docs/5.5/homestead) file as you would like now. notice your ` sites: map: ` is configured for your URL, as an aside an entry as been added to your hosts file also. start it up with `lrvl -vm go` (this will take awhile as we wait for vagrant). Your browser should open up to myProject.com, and your command line will be ssh'd into your vagrant box. When your done, just `exit` your ssh connection and `lrvl -vm destroy` to shutdown the server.

## Requirements
Since this basically automates the install intructions found in the official [documentation](https://laravel.com/docs/5.5/installation), the same requirements are still requirements. This basically means:
- PHP >= 7.0.0
- [Composer](https://getcomposer.org/download/)
- One of {[VirtualBox 5.2](https://www.virtualbox.org/wiki/Downloads)/VMWare/Hyper-V} *I have only tested this with VirtualBox*
- [Vagrant](https://www.vagrantup.com/downloads.html)

It also assumes your going to start working on your project right away, and your prefered text editor is VSCode. If this is wrong, or your code.exe isn't available in your $PATH, change the line at the end from `& code.` to `# & code .`. alternatively, you could change it to your prefered editor. for example sublime text `& subl .`

## Again, steps are:
- `lrvl -n myProject`
- `lrvl -v u`
- // Do Your Work
- `lrvl -v h`

## full list of commands as follows:

| command | shortcode | usage                  | action                                |
| ------- | --------- | ---------------------- | ------------------------------------- |
| -new    | -n        | lrvl -n myProject      | Creates a new project                 |



| command | shortcode | usage                  | action                                |
| ------- | --------- | ---------------------- | ------------------------------------- |
| -vm     | -v        | lrvl -v u(p)?          | vagrant up                            |
| -vm     | -v        | lrvl -v g(o)?          | vagrant up, open browser, vagrant ssh |
| -vm     | -v        | lrvl -v h(alt)?        | vagrant halt                          |
| -vm     | -v        | lrvl -v s(sh)?         | vagrant ssh                           |
| -vm     | -v        | lrvl -v st(atus)?      | vagrant status                        |
| -vm     | -v        | lrvl -v r(eprovision)? | vagrant reload --provision            |
| -vm     | -v        | lrvl -v d(estroy)?     | vagrant destroy --force               |



| command  | shortcode | usage                  | action                                   |
| -------- | --------- | ---------------------- | ---------------------------------------- |
| -artisan | -a        | lrvl -v m(igrate)?     | vagrant ssh; php artisan migrate         |
| -artisan | -a        | lrvl -v r(efresh)?     | vagrant ssh; php artisan migrate:refresh |
| -artisan | -a        | lrvl -v mr(eset)?      | vagrant ssh; php artisan migrate:reset   |
