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

1. Start the Rails server
    * Open a new bash-terminal in VS-Code ("vscode->/workspaces/secretspots $")
    * Start the server with the ```rails s```-command.
    * The devellopment application should now be running on localhost:3000

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
    
    https://guides.rubyonrails.org/testing.html

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
