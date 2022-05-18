#!/bin/bash

while [[ $# > 0 ]]
do
    case "$1" in
        -s|--subscription)
            subscription="$2"
            shift
            ;;
        --help|*)
            echo "Usage:"
            echo "   --subscription -s : ID of subscription."
            echo "   --tenant -t       : ID of tenant."
            echo "   --help            : Show this help message and exit."
            exit 1
            ;;
    esac
    shift
done

if [ -z "$subscription" ]; then
    echo "No subscription ID supplied"
    exit 1
fi

SCRIPTDIR=$(cd $(dirname $0) && pwd)

resourceGroups=$SCRIPTDIR/rglist.txt

export TF_LOG=INFO
export TF_LOG_PATH="./terraform.log"

for rg in `cat $resourceGroups`; do
    echo create $rg resources ...

    mkdir ./${rg}
    cp -pr ./template/* ./${rg}

    cd ./${rg}

    terraform init
    terraform plan -no-color -out main.tfplan -var "resource_group_name=${rg}" -var "subscription_id=${subscrption}"
    terraform apply -no-color main.tfplan

    cd ..
done
