FROM --platform=linux/amd64 alpine:3.20

RUN echo "y" | apk add alpine-sdk nasm bash valgrind rustup \
clang

WORKDIR /app

COPY . .

CMD ["bash"]