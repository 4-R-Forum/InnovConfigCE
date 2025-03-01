# InnovConfig Setup Guide

## Setup Checklist


1. Choose a name to be shared by your new project local instance url, database and new project repository. If the name is MyProject: treat this as case sensitive
    - Your Innovator url will be 'http://localhost/MyProject"
    - The database name will be MyProject
    - The repository name will be MyProject
    - In the following steps, substitute your project name for MyProject.
1. Install a new Innovator instance using the .msi on your machine using the url from the previous step, for example 'http://localhost/MyProject" .
1. Backup the database just installed as MyProject for a clean restore.
1. Create a new repo with the name MyProject at GitHub.com.
1. On your machine, clone the repo in the same folder as InnovConfig, this will be the MyProject repo
1. On your machine in VS Code, open the, InnovConfigCE Repo and run the script Use-Steps.ps1, select option 0. This will prompt for a project name (MyProject) and copy files to the Project repo.
1. In the MyProject repo, do the following:
    1. Edit Master_Config.xml for your machine name by copying and editing the sample.
    1. Edit Param_Config.xml for your project.
    1. Get ImportExport utilities for the Community Edition from http://aras.com/support
    1. Copy ConsoleUpgrade folder to the repo MyProj/tools folder, so that you have the folder MyProject/tools/ConsoleUpgrade. IOM.dll and Libs.dll will be used by functions in this InnovConfig module
    1. Add Packages and or src/Pre or PostProcessing to support Param_config
1. Add and commit content to MyProject repo
1. In the Project repo (MyProject) Run the script Use-Steps.ps1 as Administrator, this is necessary to restart Windows services.
## InnovConfig design and structure

InnovConfig uses the structure shown below.

Use-Steps.ps1 Step 0 copies this structure from this repo to a new project folder, with a new GitHub remote. The project repo imports the InnovConfig Module from this repo. InnovConfig functions are exectuted in the project repo with configurations Master_Config and Param_Config also in the project repo. This allows multiple project repos to share a common code-base for InnovConfig.

When InnovConfig is stable it will be shared from a source such as  PowershellGallery, and used with Install-Module rather than Import-Module.

```text
+---AML-Packages           
    - Packages and manifest files
+---AutoTest
    - Pester (Powershell Tester) scripts
+---Documents
    - Documents in markdown format
+---Innovator
    - Innovator Tree
+---InnovConfig
    - Module. See Documents\InnovConfigGuide.md
+---src
    Text files, mostly AML
    +---PostProcessing
        -  applied after Import
    +---PreProcessing
        - applied after Import
    +---Test-AML
        - used by AutoTest
+---Temp
    -emporary files, excluded in .gitignore
    +---Export
        - Destination for Consolue Upgrade, for merging to AML-Pacakges
    \---Logs
        - From ConsoleUprade and other tools
+---tools
    dlls for specific Innovator release
    +---ConsoleUpgrade
    \---IOM.dll
```

## Table of revisions

1. JMH 2/25/2025 - First Community Edition 

## Known issues

1. Use-Steps.ps1 gives 3 Resolve-Path errors, they can be ignored