#!/bin/bash  
# SilverStripe Module Builder

# Get namespace and module name

namespace="$1"
modulename="$2"

# validate and throw error if namespace or module-name not provided

if [ -z $namespace ] || [ -z $modulename ]
then  
   echo "** ERROR MESSAGE **"
   echo "Please enter your namespace and module name, Example below"
   echo "./module-builder.sh beanjuice new-module"   
   exit 1
fi

# Check if vendor directory exists, If not create it

if [ -d "vendor" ]
then
   :   
else
   mkdir "vendor"
fi

# Check if namespace directory exists, If not create it

if [ -d "vendor/$namespace" ]
then
   :   
else
   mkdir "vendor/$namespace"
fi

# Check if module already exists, delete it or get new module name

if [ -d "vendor/$namespace/$modulename" ]
then  
   echo "$modulename already exists in vendor directory, confirm if this can be removed? (Y or N):"
   read deletedirflag
fi

if [ "$deletedirflag" = "Y" ] || [ "$deletedirflag" = "y" ]
then
   rm -rf vendor/$namespace/$modulename
elif [ "$deletedirflag" = "N" ] || [ "$deletedirflag" = "n" ]
then
   echo "Please enter another name for your module: "
   read modulename
fi

# validate and throw error if module-name already exists or not provided

if [ -d "vendor/$namespace/$modulename" ] || [ -z $modulename ]
then    
   echo "** ERROR MESSAGE **"
   echo "Module name cannot be empty or duplicate, Please correct it and try again" 
   exit 1
fi

# Create SilverStripe module directory structure

moduleroot="vendor/$namespace/$modulename"

mkdir $moduleroot &&
mkdir $moduleroot/_config &&
touch $moduleroot/_config/config.yml &&
mkdir $moduleroot/src &&
mkdir $moduleroot/tests &&
mkdir $moduleroot/templates &&
mkdir $moduleroot/templates/Layout &&
touch $moduleroot/composer.json &&
touch $moduleroot/.gitignore &&
touch $moduleroot/.gitattributes &&
touch $moduleroot/README.md
touch $moduleroot/code-of-conduct.md
touch $moduleroot/CONTRIBUTING.md

# Set permissions for the directory

chmod -R 755 "$moduleroot"

# validate exit status

if [ "$?" -eq "0" ]
then
   echo "Cheers! Your SilverStripe module structure is ready, Go for it!"
   exit 0
else
   echo "** ERROR MESSAGE**" 
   echo "Module build failed, some of possible reasons could be"
   echo "Directory permission (or) Module already exists, take a look and try again"
   exit 1
fi



