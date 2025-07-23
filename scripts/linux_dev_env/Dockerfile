FROM debian:12.10

ENV HOME=/root
ENV EDITOR=nvim

# to make this as realistic as possible, we will make a separate user and run 
# fish in that container
RUN useradd -m ctc
WORKDIR /home/ctc
RUN mkdir /home/ctc/scripts

# move things into place
COPY ./*.sh /home/ctc/scripts
COPY .config /home/ctc/.config
RUN ln -s /home/ctc/.config/.tmux.conf /home/ctc/.tmux.conf
RUN chown -R ctc:ctc /home/ctc/.config /home/ctc/scripts
RUN chmod +x /home/ctc/scripts/*

# install everything
RUN /home/ctc/scripts/linux_env.sh

# set the user and run the shell
USER ctc
ENV HOME=/home/ctc
ENTRYPOINT ["fish"]
