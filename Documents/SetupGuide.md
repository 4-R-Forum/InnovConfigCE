# InnovConfig Setup Guide

## Setup Checklist


1. Choose a name to be shared by your new project local instance url, database and new project repository.
1. Install a new Innovator instance using the .msi on your development machine using the name.
1. Backup the database just installed for a clean restore.
1. Create a new repo with the project name in GitHub.com.
1. Clone the repo to your development machine in the same folder as InnovConfig, this will be the Project repo
1. Run script New-Project in InnovConfig Repo. This will prompt for a project name and copy files to the Project repo; within it do the following:
    1. Edit Master_Config.xml for your machine name by copying and editing the sample.
    1. Edit Param_Config.xml for your project.
    1. Add Packages and or src/Pre or PostProcessing to support Param_config
    1. Copy ConsoleUpgrade and SDK IOM from PackageImportExportUtilities and Utilities/IOMSDK (or installed Innovator/Server/bin/IOM.dll) to tools folder.
1. Add and commit content to local repo
1. Run the script Use-Steps.ps1 for Step 1.

## InnovConfig design and structure

InnovConfig uses the following structure.

Setup steps copy this structure to a new project folder with a new GitHub remote. The project repo uses the InnovConfig Module by importing it from a fixed location on the local machine. Its scripts are exectuted using Master_Config and Param_Config in the project repo. This allows multiple project repos to share a common code-base for InnovConfig while it is being built and tested.

When InnovConfig is stable it will be shared from a source such as  PowershellGallery, and used with Install-Module rather thatn Import-Module.

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
    \---IOM_SDK
```

## Table of revisions

1. JMH 05/14/2024 - First draft of guide

## Known issues
