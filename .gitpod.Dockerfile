# You can find the new timestamped tags here: https://hub.docker.com/r/gitpod/workspace-full/tags
FROM gitpod/workspace-full:2022-09-11-15-11-40

SHELL ["/bin/bash", "-c"]

# NVM
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash \
    && . ~/.nvm/nvm.sh \
    && nvm install 16 \
    && nvm alias default 16 \
    && nvm use default
RUN echo "export PATH='$PATH:$(npm -g bin)'" > ~/.bashrc

# Vulcan CLI
RUN npm i -g @vulcan-sql/cli@dev