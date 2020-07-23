# quasiregularity-lens

## Quick Start

### Set up a Lens container using Docker

This requires [Docker](https://www.docker.com/get-started) to be installed.

```bash
make requirements
make lens
```

### Log in to container using VNC

- [TigerVNC](https://github.com/TigerVNC/tigervnc/releases) is the recommended VNC viewer for connecting to the container.
- [RealVNC](https://www.realvnc.com/en/connect/download/viewer/) is a classic VNC viewer.
- [UltraVNC](https://www.uvnc.com/downloads/ultravnc.html) is a good VNC viewer for Windows.

```bash
vncviewer localhost:1
```

The password is `vnc123`.

### Run the experiment

Open the terminal from the desktop dock and run the following:

```bash
cd ~/storage/quasiregularity-lens
make train
make experiment
```

### Results

Results will be in `./results`.
Results are also visible from the host machine at `~/.lens-storage/quasiregularity-lens/results`.
