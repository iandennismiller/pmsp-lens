# pmsp-lens
# Ian Dennis Miller
# 2020-11-07

proc introduce_base_vocabulary { examples_path } {
    loadExamples "${examples_path}/pmsp-train.ex" -s vocab
    exampleSetMode vocab PERMUTED
    useTrainingSet vocab
}

proc introduce_anchors { amount examples_path } {
    # load frequency-dilution vocab and anchors
    set example_file "${examples_path}/pmsp-added-anchors-n${amount}.ex"
    loadExamples $example_file -s "vocab_anchors${amount}"
    exampleSetMode "vocab_anchors${amount}" PERMUTED
    useTrainingSet "vocab_anchors${amount}"
}
