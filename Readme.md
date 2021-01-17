# pmsp-lens

## Lens

Create a folder `~/.lens-storage` for sharing data with a docker image and then clone this repository into that space.

```{bash}
make requirements
```

Run Lens inside a Docker image with access to `~/.lens-storage`.

```{bash}
make lens
```

## VNC on a remote host

```{bash}
~/.vnc/vncserver start
export DISPLAY=:6
```

## PMSP

### Study 3: Recurrent

The PMSP network topology is specified with a recurrent link upon the output layer.
The recurrence is specified in the code as a bidirectional link from the output to itself.

To train the network and produce activations for hidden and output units, perform the following:

```{bash}
cd src/pmspRecurrent
make train
make activations
```

#### Results

- [2020-11-05](results/2020-11-05)
