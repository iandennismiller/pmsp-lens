#!/usr/bin/env python3

import re
import click
from pmsp.stimuli import build_stimuli_df


@click.group()
def cli():
    pass


@click.command('orthography_phonology', help="Generate orthography and phonology activations CSV")
@click.option('--word_file', required=True, help='Word file to read from.')
@click.option('--freq_file', required=True, help='Frequency file to read from.')
@click.option('--out_csv', required=True, help='Frequency file to read from.')
def orthography_phonology(word_file, freq_file, out_csv):
    stimuli_df = build_stimuli_df(word_file, freq_file)

    # stimuli_df['graphemes'] = stimuli_df['graphemes'].apply(lambda x: ','.join([str(y) for y in x]))

    # stimuli_df[[ f"grapheme{x}" for x in range(0, 105) ]] = stimuli_df['graphemes'].tolist()

    stimuli_df[
        [ f"grapheme_onset_{x}" for x in range(0, 30) ] +
        [ f"grapheme_vowel_{x}" for x in range(0, 27) ] +
        [ f"grapheme_offset_{x}" for x in range(0, 48) ]
    ] = stimuli_df['graphemes'].tolist()

    # stimuli_df['phonemes'] = stimuli_df['phonemes'].apply(lambda x: ','.join([str(y) for y in x]))

    # stimuli_df[[ f"phoneme{x}" for x in range(0, 61) ]] = stimuli_df['phonemes'].tolist()

    stimuli_df[
        [ f"phoneme_onset_{x}" for x in range(0, 23) ] +
        [ f"phoneme_vowel_{x}" for x in range(0, 14) ] +
        [ f"phoneme_offset_{x}" for x in range(0, 24) ]
    ] = stimuli_df['phonemes'].tolist()

    del stimuli_df['phonemes']
    del stimuli_df['graphemes']

    print(stimuli_df)
    stimuli_df.to_csv(out_csv)


@click.command('hidden_activations', help="Transform hidden activations from raw TXT to CSV")
@click.option('--seed', required=True)
@click.option('--dilution_level', required=True)
@click.option('--infile', required=True, help="activation .txt file")
def hidden_activations(seed, dilution_level, infile):
    """
    - transform hidden.txt and output.txt into activations.csv
        - seed, dilution_level, epoch, input_word, anchor_group_id, anchor_or_probe
    """

    with open(infile, 'r') as f:
        for line in f.readlines():
            line = line.strip()
            identifier, activations = line.split(' ', maxsplit=1)
            # print(identifier)
            epoch, packed_word, layer = identifier.split('|')

            m = re.match(r'^(.+?)_(.+?)_(.+?)_(.+?)$', packed_word)
            stimulus_id, orthography, phonology, word_type = m.groups()
            activation_list = activations.split(' ')

            print(f"{seed},{dilution_level},{epoch},{stimulus_id},{orthography},{layer},{','.join(activation_list)}")


@click.command('output_activations', help="Transform output activations from raw TXT to CSV")
@click.option('--seed', required=True)
@click.option('--dilution_level', required=True)
@click.option('--infile', required=True, help="activation .txt file")
def output_activations(seed, dilution_level, infile):
    """
    - transform hidden.txt and output.txt into activations.csv
        - seed, dilution_level, epoch, input_word, anchor_group_id, anchor_or_probe
    """

    with open(infile, 'r') as f:
        for line in f.readlines():
            line = line.strip()
            identifier, activations = line.split(' ', maxsplit=1)
            # print(identifier)
            epoch, packed_word, layer = identifier.split('|')

            if layer == 'output':
                m = re.match(r'^(.+?)_(.+?)_(.+?)_(.+?)$', packed_word)
                stimulus_id, orthography, phonology, word_type = m.groups()
                activation_list = activations.split(' ')

                print(f"{seed},{dilution_level},{epoch},{stimulus_id},{orthography},{layer},{','.join(activation_list)}")


cli.add_command(orthography_phonology)
cli.add_command(hidden_activations)
cli.add_command(output_activations)


if __name__ == '__main__':
    cli()
