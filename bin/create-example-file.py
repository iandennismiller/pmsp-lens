#!/usr/bin/env python

import sys
sys.path.insert(0, '/home/idm/Work/word-learning-jspsych/src')
sys.path.insert(1, '/home/idm/Work/pmsp-torch/src')

import configparser
import os
from jsfsdb import jsfsdb
import click

from warping_dilution_study.models.partition import PartitionMap
from warping_dilution_study.models.stimuli import StimulusDatabase

from pmsp.english.frequencies import Frequencies
from pmsp.english.graphemes import Graphemes
from pmsp.english.phonemes import Phonemes


output_path = "/home/idm/Work/pmsp-lens/usr/examples/partition-2"
stimulus_csv_path = "/home/idm/Work/word-learning-jspsych/usr/stimulus-database/warping-dilution-full.csv"
frequency_filename = "/home/idm/Work/pmsp-torch/src/pmsp/data/word-frequencies.csv"

config_filename = os.environ["SETTINGS"]
# config_filename = "/home/idm/.dilution-deadline-study.ini"

cfg = configparser.ConfigParser()
cfg.read(config_filename)

db = jsfsdb(dbpath=cfg['DEFAULT']['dbpath'])

graphemes = Graphemes()
phonemes = Phonemes()

def generate(partition_map_id, partition_map_list, dilution, frequency):

    count = 0

    partition_map = PartitionMap(
        stimulus_database=StimulusDatabase(spreadsheet=stimulus_csv_path),
        partition_map_id=partition_map_id,
    )

    for partition_map_idx in partition_map_list:
        for anchor in partition_map.get_partitions()[partition_map_idx].anchors:
            # print(anchor)
            print(f"name: {{{count}_{anchor.orthography}_{anchor.phonology.replace('/', '')}_ANC_UNK}}")

            # print(anchor.orthography)
            print(f"freq: {frequency / dilution:0.8f}")

            # print(graphemes.get_graphemes(anchor.orthography))
            orthography_vector = graphemes.get_graphemes(anchor.orthography)
            print(f"I: {' '.join([str(x) for x in orthography_vector])}")

            # print(anchor.phonology)
            phonology_vector = phonemes.get_phonemes(anchor.phonology)
            print(f"T: {' '.join([str(x) for x in phonology_vector])};")
            print()

            count += 1


@click.group()
def cli():
    pass


@click.command('create_examples', short_help='Create example file.')
@click.option('--dilution', required=True, help='Dilution level.')
@click.option('--partition', required=True, help='Partition.')
@click.option('--frequency', required=True, help='Anchor frequency.')
def create_examples(dilution, partition, frequency):
    generate(
        partition_map_id=int(partition),
        partition_map_list=range(0, int(dilution)),
        dilution=int(dilution),
        frequency=float(frequency),
    )


cli.add_command(create_examples)


if __name__ == '__main__':
    cli()