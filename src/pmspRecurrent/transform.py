#!/usr/bin/env python3

import click
from pmsp.stimuli import build_stimuli_df

"""
- transform hidden.txt and output.txt into activations.csv
    - seed, dilution_level, epoch, input_word, anchor_group_id, anchor_or_probe
    - orth_onset, orth_vowel, orth_offset, hidden, phon_onset, phon_vowel, phon_offset
"""


@click.group()
def cli():
    pass


@click.command('orthography_activations', help="Generate orthography activations CSV")
@click.option('--word_file', required=True, help='Word file to read from.')
@click.option('--freq_file', required=True, help='Frequency file to read from.')
@click.option('--out_csv', required=True, help='Frequency file to read from.')
def orthography_activations(word_file, freq_file, out_csv):
    stimuli_df = build_stimuli_df(word_file, freq_file)
    print(stimuli_df)
    stimuli_df.to_csv(out_csv)


@click.command('hidden_and_output_activations', help="Transform activations from raw TXT to CSV")
@click.option('--hidden_txt', required=True, help="hidden unit activation .txt file")
@click.option('--output_txt', required=True, help="output unit activation .txt file")
def hidden_and_output_activations(hidden_txt, output_txt):
    print(f"Hi {hidden_txt}")
    pass


cli.add_command(orthography_activations)
cli.add_command(hidden_and_output_activations)


if __name__ == '__main__':
    cli()
