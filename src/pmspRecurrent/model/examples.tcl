# pmsp-lens
# Ian Dennis Miller
# 2020-11-07

proc introduceBaseVocabulary { examples_path } {
    loadExamples "${examples_path}/pmsp-train.ex" -s vocab
    exampleSetMode vocab PERMUTED
    useTrainingSet vocab

    # Recurrent Network:
    # this prevents error from being computed until after the graceTime has passed.
    setObj vocab.minTime 2.0
    setObj vocab.maxTime 2.0
    setObj vocab.graceTime 1.0
}

proc introduceAnchors { amount examples_path } {
    # load frequency-dilution vocab and anchors
    set example_file "${examples_path}/pmsp-added-anchors-n${amount}.ex"
    loadExamples $example_file -s "vocab_anchors${amount}"
    exampleSetMode "vocab_anchors${amount}" PERMUTED
    useTrainingSet "vocab_anchors${amount}"
}
