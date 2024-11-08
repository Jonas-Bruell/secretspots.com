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
    * You should be prompted to "Rebuild Container", if not, click the blue button on the bottom left of VS-Code and select "Rebuild Container"
        * It can take some time for the container to rebuild, open the log files if you are unsure if the build has finished already
        * The error "postCreateCommand failed with exit code 127" seems not to impact the creation of the container, I have not found a solution yet for this problem.
        * When the containerisation process has finished, Docker automatically boots the container, this also takes a while.

1. Configure Ruby
    * Open a new bash-terminal in VS-Code ("vscode->/workspaces/secretspots $")
    * Run the command ```bundle install```
    * If any error occure because of previous installations, try the command again untill you get the "Bundle complete!" message (green)

1. Start the Rails server
    * In the same bash-terminal, start the server with the ```rails s```-command.
    * The devellopment application should now be running on localhost:3000
    * Keep this terminal open as long as you want to use the server. Use ````Ctrl-C``` in the terminal to stop the server.

## Project

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite
    
    * https://guides.rubyonrails.org/testing.html
    * make sure to prepare the database with ```rails db:test:prepare```

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
