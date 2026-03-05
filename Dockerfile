FROM marsel7/openfang:latest

USER root

ENV PORT=4200
ENV OPENFANG_LISTEN=0.0.0.0:${PORT}

# Custom skills
COPY skills/ /root/.openfang/skills/

WORKDIR /app

EXPOSE 4200

CMD ["sh","-c","init --non-interactive && start"]
