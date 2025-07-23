FROM debian:12.10

# update
RUN apt update && apt install -y xz-utils curl

# create nix dir
RUN useradd -m ctc
RUN mkdir -m 0755 /nix && chown ctc /nix

# custom user 
WORKDIR /home/ctc
ENV HOME=/home/ctc

# copy over scripts
RUN mkdir /home/ctc/scripts
COPY ./linux_env.sh /home/ctc/linux_env.sh
COPY ./scripts/ /home/ctc/scripts
RUN chown -R ctc:ctc /home/ctc/scripts
RUN chown -R ctc:ctc /home/ctc/linux_env.sh
RUN chmod +x /home/ctc/scripts/*
RUN chmod +x /home/ctc/linux_env.sh

# copy over dotfiles
COPY .config /home/ctc/.config
RUN chown -R ctc:ctc /home/ctc/.config 

# tmux should be in root config dir, we'll settle for simlink
RUN ln -s /home/ctc/.config/.tmux.conf /home/ctc/.tmux.conf

# set the editor
ENV EDITOR=nvim

# install everything
USER ctc
RUN /home/ctc/linux_env.sh

ENTRYPOINT ["/home/ctc/.nix-profile/bin/fish"]
