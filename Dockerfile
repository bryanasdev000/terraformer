FROM alpine:3.12.0 
RUN apk add --no-cache go git
RUN git clone https://github.com/GoogleCloudPlatform/terraformer /root/terraformer
RUN cd /root/terraformer && go mod download && go build -v 

FROM alpine:3.12.0 
COPY --from=0 /root/terraformer/terraformer /root
RUN apk add --no-cache terraform
COPY OfficialProviders.tf /root
RUN cd /root && terraform init
WORKDIR /root/
