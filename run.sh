# Suffix for missing options.
error_suffix='Please add this option to the wercker.yml'


if [ ! -n "$WERCKER_IRON_WORKER_WORKER_NAME"  ]
then
    fail "Missing or empty option IRON_WORKER_WORKER_NAME. $error_suffix"
fi

if [ ! -n "$WERCKER_IRON_WORKER_CMD"  ]
then
    fail "Missing or empty option IRON_WORKER_CMD. $error_suffix"
fi

if [ ! -n "$WERCKER_IRON_WORKER_ARGS"  ]
then
    fail "Missing or empty option IRON_WORKER_ARGS. $error_suffix"
fi

# Install iron worker cli if needed
if ! type iron_worker &> /dev/null ;
then
    info 'iron worker cli not found, installing it'

    cd $TMPDIR

    sudo apt-get update
    sudo apt-get install -y ruby1.9.1
    result=$(sudo gem install iron_worker_ng)

    if [[ $? -ne 0 ]];then
        warn $result
        fail 'iron worker cli installation failed';
    else
        info 'finished iron worker cli installation';
    fi
else
    info 'iron worker cli is available, and will not be installed by this step'
    debug "type iron_worker: $(type iron_worker)"
    debug "iron worker version: $(iron_worker --version)"
fi

result=$(iron_worker $WERCKER_IRON_WORKER_CMD $WERCKER_IRON_WORKER $WERCKER_IRON_WORKER_ARGS)
if [[ $? -ne 0 ]];then
    warn $result
    fail 'iron_worker $WERCKER_IRON_WORKER_CMD failed';
else
    success 'iron_worker $WERCKER_IRON_WORKER_CMD finished';
fi

