## Guidance for setting up a Docker image in GitLab

CI/CD pipeline for auto-tests is run in Docker container. 
Dockerfile contains instructions for bulding the image and installing 3 browsers for running auto-tests:
* Chrome
* Firefox
* Edge
### Adding Docker image to GitLab instruction
* Before proceeding with installation make sure that Docker application is installed to your workstation. Otherwise, install it
* For checking docker images installed locally use the command:
<br> *docker images*
* In command line navigate to the directory where **Dockerfile** is stored. Use command:
<br> *cd*
* Build the image locally from **Dockerfile** with **rutaf_bdd_si** name for instance:
<br> *docker build -t rutaf_bdd_si*;
* For proceeding with sending requests to GitLab you need to have personal Access Token. 
To add a new one: navigate to GitLab > current user > Preferences > Access Tokens.
Check all Scopes and generate a token. Remember the token since for the next time it will not be shown in UI.
* In the command line login to GitLab by the command:
<br> *docker login -u USER_EMAIL -p PERSONAL_ACCESS_TOKEN registry.appdev.rfgdev.com*
* To the created image add the tag with the **latest** name and path used in the project:
<br> *docker tag rutaf_bdd_si registry.appdev.rfgdev.com/is/rutaf-bdd-si:latest*
* Push the image to the GitLab:
<br> *docker push registry.appdev.rfgdev.com/is/rutaf-bdd-si:temp*
* The image can be found in GitLab > Packages & Registries > Container Registry > Root Image 