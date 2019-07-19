FROM ubuntu
LABEL Author="Leo Lin <leolin@leolin.studio>"

# Prevent dpkg errors
ENV TERM=xterm-256color

# set mirrors to cn
# RUN sed -i "s/http:\/\/archive./http:\/\/cn.archive./g" /etc/apt/sources.list

# Install Ansible
RUN apt-get update -qy && \
    apt-get install -qy software-properties-common && \
    apt-add-repository -y ppa:ansible/ansible && \
    apt-get update -qy && \
    apt-get install -qy ansible

# Copy baked in playbooks
COPY ansible /ansible

# Add volume for ansible playbooks
VOLUME [ "/ansible" ]
WORKDIR /ansible

# Entrypoint
ENTRYPOINT ["ansible-playbook"]
CMD ["site.yml"]