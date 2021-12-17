FROM alpine:latest
RUN apk add --no-cache ansible
VOLUME ["/tmp/playbook"]
WORKDIR /tmp/playbook
ENTRYPOINT ["ansible-playbook"]
CMD ["--version"]
