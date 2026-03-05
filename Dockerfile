FROM marsel7/openfang:latest

ENV PORT=4200
ENV OPENFANG_LISTEN=0.0.0.0:${PORT}

COPY skills/ /root/.openfang/skills/

WORKDIR /app

EXPOSE 4200

CMD ["start"]
