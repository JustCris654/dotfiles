. "$HOME/.cargo/env"
export PATH=$HOME/development/flutter/bin:$PATH

function k__custom_delete_pods_from_regex() {
    regex=$1
    ns=$2  # optional
    if [ -z "$1" ];
    then
        echo "Regex empty, no pods to delete";
        return 1;
    fi
    if [ -z ${ns+x} ]; 
    then
        echo "Namespace empty";
    fi
    kubecolor get pods ${ns:+ -n $ns} --no-headers | awk /${regex}/'{print $1}' | xargs kubecolor delete ${ns:+ -n $ns} pod
}

function k__trigger_otp_build() {
    kubens gtfs;
    var=0;
    while :
    do
        kubecolor create job --from=cronjob/service-activator test-otp$((var+=1))
        if [ $? -eq 0 ]; then
            kubens otp;
            return 0;
        fi
    done

}

function k__get_pods_loop() {
    while :
    do
        clear;
        kubecolor get pods;
        sleep 3;
    done
}
