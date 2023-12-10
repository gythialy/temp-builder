#!/bin/bash

set -eux

versions=(go1.21.4 go1.21.3 go1.21.2 go1.21.1 go1.21.0 go1.20.12 go1.20.11 go1.20.10 go1.20.9 go1.20.8 go1.20.7 go1.20.6 go1.20.5 go1.20.4 go1.20.3 go1.20.2 go1.20.1 go1.20 go1.19.13 go1.19.12 go1.19.11 go1.19.10 go1.19.9 go1.19.8 go1.19.7 go1.19.6 go1.19.5 go1.19.4 go1.19.3 go1.19.2 go1.19.1 go1.19 go1.18.10 go1.18.9 go1.18.8 go1.18.7 go1.18.6 go1.18.5 go1.18.4 go1.18.3)
hash=(73cac0215254d0c7d1241fa40837851f3b9a8a742d0b54714cbdfb3feaf8f0af 1241381b2843fae5a9707eec1f8fb2ef94d827990582c7c7c32f5bdfbfd420c8 f5414a770e5e11c6e9674d4cd4dd1f4f630e176d1828d3427ea8ca4211eee90d b3075ae1ce5dab85f89bc7905d1632de23ca196bd8336afd93fa97434cfa55ae d0398903a16ba2232b389fb31032ddf57cac34efda306a0eebac34f0965a0742 9c5d48c54dd8b0a3b2ef91b0f92a1190aa01f11d26e98033efa64c46a30bba7b ef79a11aa095a08772d2a69e4f152f897c4e96ee297b0dc20264b7dec2961abe 80d34f1fd74e382d86c2d6102e0e60d4318461a7c2f457ec1efc4042752d4248 8921369701afa749b07232d2c34d514510c32dbfd79c65adb379451b5f0d7216 cc97c28d9c252fbf28f91950d830201aa403836cbed702a05932e63f7f0c7bc4 f0a87f1bcae91c4b69f8dc2bc6d7e6bfcd7524fceec130af525058c0c17b1b44 b945ae2bb5db01a0fb4786afde64e6fbab50b67f6fa0eb6cfa4924f16a7ff1eb d7ec48cde0d3d2be2c69203bc3e0a44de8660b9c09a6e85c4732a3f7dc442612 698ef3243972a51ddb4028e4a1ac63dc6d60821bf18e59a807e051fee0a385bd 979694c2c25c735755bf26f4f45e19e64e4811d661dd07b8c010f7a8e18adfca 4eaea32f59cde4dc635fbc42161031d13e1c780b87097f4b4234cfce671f1768 000a5b1fca4f75895f78befeb2eecf10bfff3c428597f3f1e69133b63b911b02 5a9ebcc65c1cce56e0d2dc616aff4c4cedcfbda8cc6f0288cc08cda3b18dcbf1 4643d4c29c55f53fa0349367d7f1bb5ca554ea6ef528c146825b0f8464e2e668 48e4fcfb6abfdaa01aaf1429e43bdd49cea5e4687bd5f5b96df1e193fcfd3e7e ee18f98a03386e2bf48ff75737ea17c953b1572f9b1114352f104ac5eef04bb4 8b045a483d3895c6edba2e90a9189262876190dbbd21756870cdd63821810677 e858173b489ec1ddbe2374894f52f53e748feed09dde61be5b4b4ba2d73ef34b e1a0bf0ab18c8218805a1003fd702a41e2e807710b770e787e5979d1cf947aba 7a75720c9b066ae1750f6bcc7052aba70fa3813f4223199ee2a2315fd3eb533d e3410c676ced327aec928303fef11385702a5562fd19d9a1750d5a2979763c3d 36519702ae2fd573c9869461990ae550c8c0d955cd28d2827a6b159fda81ff95 c9c08f783325c4cf840a94333159cc937f05f75d36a8b307951d5bd959cf2ab8 74b9640724fd4e6bb0ed2a1bc44ae813a03f1e72a4c76253e2d5c015494430ba 5e8c5a74fe6470dd7e055a461acda8bb4050ead8c2df70f227e3ff7d8eb7eeb6 acc512fbab4f716a8f97a8b3fbaa9ddd39606a28be6c2515ef7c6c6311acffde 464b6b66591f6cf055bc5df90a9750bf5fbc9d038722bb84a9d56a2bea974be6 5e05400e4c79ef5394424c0eff5b9141cb782da25f64f79d54c98af0a37f8d49 015692d2a48e3496f1da3328cf33337c727c595011883f6fc74f9b5a9c86ffa8 4d854c7bad52d53470cf32f1b287a5c0c441dc6b98306dea27358e099698142a 6c967efc22152ce3124fc35cdf50fc686870120c5fd2107234d05d450a6105d8 bb05f179a773fed60c6a454a24141aaa7e71edfd0f2d465ad610a3b8f1dc7fe8 9e5de37f9c49942c601b191ac5fba404b868bfc21d446d6960acc12283d6e5f2 c9b099b68d93f5c5c8a8844a89f8db07eaa58270e3a1e01804f17f4cf8df02f5 956f8507b302ab0bb747613695cdae10af99bbd39a90cae522b7c0302cc27245)

for i in "${!versions[@]}"; do
  v=${versions[$i]//go/}
  image_tag="ghcr.io/gythialy/golang-cross:${v}"
  image_tag1="ghcr.io/gythialy/golang-cross:${v}-0"
  image_tag2="ghcr.io/gythialy/golang-cross:v${v}"
  image_tag3="ghcr.io/gythialy/golang-cross:v${v}-0"
  docker build --build-arg GO_VERSION=${versions[$i]} \
    --build-arg GOLANG_DIST_SHA=${hash[$i]} \
    -f Dockerfile \
    -t ${image_tag} .
  docker tag ${image_tag} "${image_tag1}"
  docker tag ${image_tag} "${image_tag2}"
  docker tag ${image_tag} "${image_tag3}"
  docker push ${image_tag}
  docker push "${image_tag1}"
  docker push "${image_tag2}"
  docker push "${image_tag3}"
  # cosign sign --yes " ${image_tag}@$(docker images --no-trunc --quiet ${image_tag})"
done
