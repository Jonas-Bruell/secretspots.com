# README

## Installation & Setup
### Required programmes:
* VS-Code : https://code.visualstudio.com
* Docker-desktop : https://www.docker.com

### Setting up the program locally:

1. Open your Docker-desktop application
    * Docker needs to be running during the whole containerisation process 

1. Clone the project to VS-Code
    * Open the "secretspots.code-workspace"-file and click the button "Open Workspace"
    * You should be prompted to ```Rebuild Container```, if not, click the blue button on the bottom left of VS-Code and select "Rebuild Container"
        * It can take some time for the container to rebuild, open the log files if you are unsure if the build has finished already
        * The error ```postCreateCommand failed with exit code 127``` seems not to impact the creation of the container, I have not found a solution yet for this problem and ignoring it has worked fine so far.
        * When the containerisation process has finished, Docker automatically boots the container, this also takes a while.

1. Configure Ruby
    * Open a new bash-terminal in VS-Code ("vscode->/workspaces/secretspots $")
    * Run the command ```bundle install```
    * If any error occurs because of previous installations, try the command again untill you get the "Bundle complete!" message (green). Sometimes it needs multiple tries, probably because some gems depend on others.

1. Configure the database.
    * The database can be initialised by the ```rails db:migrate``` command, this also creates the database, so no need for multiple commands. Now the backend has been setup, the only thing left to do, is to:

1. Start the Rails server
    * In the same bash-terminal, start the server with the ```rails s```-command.
    * The devellopment application should now be running on ```localhost:3000```
    * Keep this terminal open as long as you want to use the server. Use ```Ctrl-C``` in the terminal to stop the server.

## Project

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

    * ruby-3.3.6

* System dependencies

    * Docker desktop has to be running at all time for the devcontainer to function properly
    * All other dependancies are defined in the gemfile

* Configuration

    * Adding / deleting API keys
        1. Make sure you have the (correct) ```master.key``` file in your ```/config```-folder.
        2. Run the ```EDITOR="code --wait" rails credentials:edit```-command in a terminal.
        3. Add the keys in the ```<data>-<hash>-credentials.yml```-file that opens in your editor.
        4. Save & close this file, this saves the changes to the encrypted ```credentials.yml.enc```-file.
        5. In the codebase, use ```Rails.application.credentials.dig('<KEY>')``` to retrieve the keys from the encrypted file.

* Database creation & initialization

    * only the ```rails db:migrate``` command is needed

* How to run the test suite
    
    * https://guides.rubyonrails.org/testing.html
    * make sure to prepare the database with ```rails db:test:prepare```
