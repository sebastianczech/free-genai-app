FROM golang:1.22

WORKDIR /go/src
RUN git clone https://github.com/kubernetes-sigs/cloud-provider-kind

WORKDIR /go/src/cloud-provider-kind
RUN go mod download
RUN make build

FROM docker:25.0-dind
COPY --from=0 --chown=root:root ./go/src/cloud-provider-kind/bin/cloud-provider-kind /bin/cloud-provider-kind
ENTRYPOINT ["/bin/cloud-provider-kind"]
