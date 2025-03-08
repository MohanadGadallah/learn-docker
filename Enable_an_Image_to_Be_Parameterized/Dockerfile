FROM node:11-alpine

ENV diameter=2
COPY compute.js .
CMD ["node", "compute.js"]

# docker build -t compute .
# docker run --rm -it compute