step-iron-worker
================

[![wercker status](https://app.wercker.com/status/e6bc39b923c3696badc8797829c9d505/m/ "wercker status")](https://app.wercker.com/project/bykey/e6bc39b923c3696badc8797829c9d505)

# Iron Worker Step

Use the Iron Worker CLI to run, upload, queue and schedule workers in Iron.io. More info [here](http://dev.iron.io/worker/reference/cli/). This step assumes the iron.json and my_worker.worker files exist in your root source directory.

# Options

* `worker-name` (required) Specify the name of the .worker file. For example, my_worker.worker would be worker-name: my_worker
* `cmd` (required) The iron_worker sub command to use. The iron_worker cli support run, upload, queue, schedule and log.
* `args` (optional) Arguments passed to the iron_worker command.

# Example

``` yaml
deploy:
    steps:
        - nimajalali/iron-worker:
            worker-name: my_worker
            cmd: upload
        	args: --env development --max-concurrency 10
```