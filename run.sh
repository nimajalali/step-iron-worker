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
    sudo gem install iron_worker_ng

    info 'finished iron worker cli installation';
else
    info 'iron worker cli is available, and will not be installed by this step'
fi

debug "type iron_worker: $(type iron_worker)"
debug "iron worker version: $(iron_worker --version)"

info 'running iron_worker $WERCKER_IRON_WORKER_CMD $WERCKER_IRON_WORKER_WORKER_NAME $WERCKER_IRON_WORKER_ARGS'

iron_worker $WERCKER_IRON_WORKER_CMD $WERCKER_IRON_WORKER_WORKER_NAME $WERCKER_IRON_WORKER_ARGS