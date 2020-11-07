# pmsp-lens
# Ian Dennis Miller
# 2020-11-07

source accuracy.tcl
source activations.tcl

# the logging interval is set during initialization of Logger
set loggingInterval {}

proc Logger { newLoggingInterval } {
    # install hook
    setObj postExampleProc logAccuracyHook

    global loggingInterval
    set loggingInterval $newLoggingInterval
}
