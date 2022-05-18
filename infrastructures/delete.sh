#!/bin/bash
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
    echo delete $rg resources ...

    if [ -d ./${rg} ]; then
        cd ./${rg}

        terraform plan -destroy -no-color -out main.destroy.tfplan -var "resource_group_name=${rg}" -var "subscription_id=${subscrption}"
        terraform apply -no-color main.destroy.tfplan

        cd ..
    fi
done
