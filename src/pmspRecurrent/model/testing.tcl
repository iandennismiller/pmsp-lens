# pmsp-lens
# Ian Dennis Miller
# 2020-11-07

proc test_base { examples_path } {
    loadExamples "${examples_path}/pmsp-train.ex" -s test
    test
}

proc test_anchors { examples_path } {
    loadExamples "${examples_path}/anchors-n1.ex" -s test
    test
}

proc test_probes { examples_path } {
    loadExamples "${examples_path}/probes-new.ex" -s test
    test
}

proc test_anchors_probes { examples_path } {
    loadExamples "${examples_path}/pmsp-added-anchors-n1.ex" -s test
    test
}
