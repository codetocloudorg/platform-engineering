FROM debian:12.10

RUN apt update && apt install -y xz-utils curl
RUN useradd -m ctc
RUN mkdir -m 0755 /nix && chown ctc /nix
WORKDIR /home/ctc
ENV HOME=/home/ctc
RUN mkdir /home/ctc/scripts
COPY ./*.sh /home/ctc/scripts
RUN chown -R ctc:ctc /home/ctc/scripts
RUN chmod +x /home/ctc/scripts/*
COPY .config /home/ctc/.config
RUN chown -R ctc:ctc /home/ctc/.config 
RUN ln -s /home/ctc/.config/.tmux.conf /home/ctc/.tmux.conf
USER ctc
ENV EDITOR=nvim

# install everything
RUN /home/ctc/scripts/linux_env.sh

# if we change dotfiles, we still use dockers stored images

ENTRYPOINT ["/home/ctc/.nix-profile/bin/fish"]
