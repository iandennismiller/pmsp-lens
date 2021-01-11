set f ""

proc saveTest {} {

    setObj postExampleProc {outTarg}
    #Need to view units to be able to access the history arrays.
    viewUnits
    global f

    set f [open out_train_expVocab_drop20_english.txt w ]
    useTestingSet expVocab_drop20_english
    test
    close $f

    set f [open out_test_expVocab_drop0_english.txt w]
    useTestingSet expVocab_drop0_english
    test
    close $f


    setObj postExampleProc {}
}


proc outTarg {} {

    global f

    #list of group outputs to log
    # set gr {phono_onset phono_vowel phono_coda}
    set gr {hidden}
    set ty {output}
    # set ty {output target}

    foreach t $ty {

        puts -nonewline $f  "[getObj net(0).currentExample.name]|$t "
        foreach g $gr {
            #puts "group count"
            #puts [getObj $g.numUnits]
            for {set u 0} {$u < [getObj $g.numUnits]} {incr u} {
                puts -nonewline $f  "[getObj $g.unit($u).$t] "
            }
        }
        puts $f ""

    }

}