FROM marsel7/openfang:latest

USER root

ENV PORT=4200
ENV OPENFANG_LISTEN=0.0.0.0:4200

# Custom skills copy
COPY skills/ /root/.openfang/skills/

WORKDIR /app

EXPOSE 4200

CMD ["sh","-c","openfang init --non-interactive && openfang start"]
